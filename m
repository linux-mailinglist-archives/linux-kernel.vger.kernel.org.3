Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E267482086
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 23:13:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242224AbhL3WNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 17:13:31 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:54577 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S240629AbhL3WNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 17:13:30 -0500
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1BUMDPkH019176
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Dec 2021 17:13:25 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 120C515C33A3; Thu, 30 Dec 2021 17:13:25 -0500 (EST)
Date:   Thu, 30 Dec 2021 17:13:25 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH] random: avoid superfluous call to RDRAND in CRNG
 extraction
Message-ID: <Yc4vBfiN529c06kI@mit.edu>
References: <20211230165052.2698-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211230165052.2698-1-Jason@zx2c4.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 30, 2021 at 05:50:52PM +0100, Jason A. Donenfeld wrote:
> RDRAND is not fast. RDRAND is actually quite slow. We've known this for
> a while, which is why functions like get_random_u{32,64} were converted
> to use batching of our ChaCha-based CRNG instead.
> 
> Yet CRNG extraction still includes a call to RDRAND, in the hot path of
> every call to get_random_bytes(), /dev/urandom, and getrandom(2).
> 
> This call to RDRAND here seems quite superfluous. CRNG is already
> extracting things based on a 256-bit key, based on good entropy, which
> is then reseeded periodically, updated, backtrack-mutated, and so
> forth. The CRNG extraction construction is something that we're already
> relying on to be secure and solid. If it's not, that's a serious
> problem, and it's unlikely that mixing in a measly 32 bits from RDRAND
> is going to alleviate things.
> 
> There is one place, though, where such last-ditch moves might be
> quasi-sensible, and that's before the CRNG is actually ready. In that case,
> we're already very much operating from a position of trying to get
> whatever we can, so we might as well throw in the RDRAND call because
> why not.

So I'm not sure we how desperately we *need* the 370% performance
improvement, but realistically speaking, in
crng_init_try_arch_early(), which gets called from rand_initialize(),
we will have already set crng->state[4..15] via RDSEED or RDRAND.

So there's no point in setting crng->state[0] from RDRAND.  So if
we're wanting to speed things up, we should just remove the
crng->state[0] <= RDRAND entirely.

Or if we want to improve the security of get_random_bytes() pre
crng_ready(), then we should try to XOR RDRAND bytes into all returned
buffer from get_random_bytes().  In other words, I'd argue that we
should "go big, or go home".  (And if we do have some real,
security-critical users of get_random_bytes() pre-crng_ready(), maybe
"go big" is the right way to go.  Of course, if those do exist, we're
still screwed for those architectures which don't have an RDRAND or
equivalent --- arm32, RISC-V, I'm looking at you.)

					- Ted
