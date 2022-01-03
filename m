Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D395483545
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 18:02:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234206AbiACRCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 12:02:46 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:48568 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229972AbiACRCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 12:02:45 -0500
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 203H2gNt013979
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 3 Jan 2022 12:02:42 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id D8BD515C00E1; Mon,  3 Jan 2022 12:02:41 -0500 (EST)
Date:   Mon, 3 Jan 2022 12:02:41 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>
Subject: Re: [PATCH] random: reseed in RNDRESEEDCRNG for the !crng_ready()
 case
Message-ID: <YdMsMZU/PL7o2j5f@mit.edu>
References: <20220103160002.1068356-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220103160002.1068356-1-Jason@zx2c4.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 03, 2022 at 05:00:02PM +0100, Jason A. Donenfeld wrote:
> Userspace often wants to seed the RNG from disk, without knowing how
> much entropy is really in that file. In that case, userspace says
> there's no entropy, so none is credited. If this happens in the
> crng_init==1 state -- common at early boot time when such seed files are
> used -- then that seed file will be written into the pool, but it won't
> actually help the quality of /dev/urandom reads. Instead, it'll sit
> around until something does credit sufficient amounts of entropy, at
> which point, the RNG is seeded and initialized.
> 
> Rather than let those seed file bits sit around unused until "sometime
> later", userspaces that call RNDRESEEDCRNG can expect, with this commit,
> for those seed bits to be put to use *somehow*. This is accomplished by
> extracting from the input pool on RNDRESEEDCRNG, xoring 32 bytes into
> the current crng state.

I think this is fine, but the RNDRESEEDRNG ioctl is rarely used by
userspace.  From a Google search I see that jitterentropy uses it, but
in most setups it won't be called.

So something we could do to improve things is to add some code to
random_write() so that in the case where crng_init is 1, we take half
of the bytes or CHACHA_KEY_SIZE bytes, whichever is less, and pass
those bytes to crng_fast_load().  (We'll have to copy it to a bounce
buffer since the passed in pointer is __user, and memzero_explicit it
after calling crng_fast_load.)

This will divert some part of the seed file to partially initialize
the CRNG.  It won't fully initialize the CRNG, but that's fine, since
it's possible that the seed file has been compromised --- or is a
fixed value if the seed file is from coming a VM image file.  So
having at least half of the entropy used to initialize CRNG up to
crng_init=1 is coming from interrupt timing seems like a good thing.

					- Ted
