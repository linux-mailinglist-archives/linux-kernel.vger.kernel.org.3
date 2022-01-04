Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB786483BC5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 06:55:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231374AbiADFzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 00:55:53 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:39638 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230181AbiADFzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 00:55:52 -0500
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 2045tn3W008635
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 4 Jan 2022 00:55:50 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 474E015C00E1; Tue,  4 Jan 2022 00:55:49 -0500 (EST)
Date:   Tue, 4 Jan 2022 00:55:49 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Sandy Harris <sandyinchina@gmail.com>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: Re: [PATCH v2] random: avoid superfluous call to RDRAND in CRNG
 extraction
Message-ID: <YdPhZQqM52viEttQ@mit.edu>
References: <Yc56ey6QKwaYg0yi@mit.edu>
 <20211231114903.60882-1-Jason@zx2c4.com>
 <Yc86TIah3w4waDEc@mit.edu>
 <CACXcFmm2nKLHdqN27Ced2nLg=h2mSX_fKWFf-OkgArVRDi3xTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACXcFmm2nKLHdqN27Ced2nLg=h2mSX_fKWFf-OkgArVRDi3xTw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2022 at 01:03:43PM +0800, Sandy Harris wrote:
> If we are removing RDRAND, what about adding some
> cheaper mixing? Something along these lines?
> 
> The current code's mixing is triggered only once in 2^32
> iterations, depends only on crng->state[], always changes
> the same state word, and introduces no new entropy.

I wouldn't call it "mixing", because the state array isn't an entropy
pool.

Recall how ChaCha20's state array is set up.  crng->state[0..3]
contain ChaCha20's initial constants, crng->state[4..11] contain the
ChaCha20 key, crng->state[12] is the 32-bit counter (which is
incremented when we call ChaCha20), and crng->state[13..15] is the
96-bit IV.

The IV and counter --- state[12..15] --- is initialized when the CRNG
is initialized.  We replace the key every time the CRNG is reseeded.

But what if we manage to call _extract_crng() more than 2**32 times?
Well, that's what this is all about:

    if (crng->state[12] == 0)
        crng->state[13]++;

What we've effectively done is treat state[12..13] as a 64-bit
counter, and state[14..15] is initialized to a 64-bit random value
("the IV") when the CRNG is initialized, and not updated during the
life of the CRNG.  This is really the only place where we've modified
ChaCha20.

Now, either we believe in the strength of ChaCha20, or we don't.  The
whole *point* of a CRNG is that we rely on the crypto, and adding some
random bit-mashing to mix in the CPU cycle counter into parts of the
ChaCha20 key (state[10..11]) and part of the ChaCha20 IV (state[12])
isn't consistent with the philosophy of a CRNG.  At the very least,
I'd like to get an opinion from a respected cryptographer about what
they think this would buy us (or what it might cost).

If we want to worry about what happens if we could actually manage to
call _extract_crng() more than 2**64 times before the reseed interval
is up --- which *is* one of the benefits of:

   if (arch_get_random_long(^v))
        crng->state[14] ^= v;

I could see doing perhaps this instead:

    if (crng->state[12] == 0) {
        crng->state[13]++;
	if (crng->state[13] == 0) {
	    crng->state[14]++;
	    if (crng->state[14] == 0) {
	        crng->state[15]++;
	    }
	}
   }
	
This essentially makes state[12..15] a 128-bit counter, which is
initialized to a random value when the CRNG is initialized, and we
would continue to treat state[4..11] as the 256 bit ChaCha20 key.
This would be a much more philosophically consistent approach, and
would allow us to more easily reason about the security based on
cryptographic research into ChaCha20 the stream cipher.

Cheers,

						- Ted
