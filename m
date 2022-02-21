Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99DF74BD459
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 04:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344291AbiBUDiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 22:38:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344284AbiBUDiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 22:38:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15560419A4;
        Sun, 20 Feb 2022 19:37:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A859E61156;
        Mon, 21 Feb 2022 03:37:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB875C340E9;
        Mon, 21 Feb 2022 03:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645414660;
        bh=OWg64DVzBIqge941wLJ6kgmKUPvgBl5qCIc6LR6NoLM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W1twAl2gu9b9BuwpfO4dJfm8/f1DtRDYVDyHUXQNz1hGhzi1UtmtfU2jVIMbj95dx
         USA1WFZWKQUS3n5CJ6bgSpVxs1HBKkqfBWcMgfYSpHnr3JlpAPpGULfe5/9AtYErXJ
         fF7p+gfTTHFGAjwb3ByXlLv/cg29frBGLJ2l7EhlqALF6rsaFLj7tud4eY1ieCAyEY
         h8FOwt7NjPLokGt3Jeu1WLH+kBLxw4LlkSjkCjlJAXkjDLsZaxa8sV2gqQpZJKPKby
         Fwf4v3zoaarAoqxj83XRoTvXmp5pqOi1EnHUbgyNZqFlskQDYvAy8spKCRxXhX8pel
         lbaYm6lEaze4w==
Date:   Sun, 20 Feb 2022 19:37:38 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH v4] random: use simpler fast key erasure flow on per-cpu
 keys
Message-ID: <YhMJAsiHsjCJU1A4@sol.localdomain>
References: <20220214184627.3048-1-Jason@zx2c4.com>
 <20220216232142.193220-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220216232142.193220-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2022 at 12:21:42AM +0100, Jason A. Donenfeld wrote:
> Rather than the clunky NUMA full ChaCha state system we had prior, this
> commit is closer to the original "fast key erasure RNG" proposal from
> <https://blog.cr.yp.to/20170723-random.html>, by simply treating ChaCha
> keys on a per-cpu basis.
> 
> All entropy is extracted to a base crng key of 32 bytes. This base crng
> has a birthdate and a generation counter. When we go to take bytes from
> the crng, we first check if the birthdate is too old; if it is, we
> reseed per usual. Then we start working on a per-cpu crng.
> 
> This per-cpu crng makes sure that it has the same generation counter as
> the base crng. If it doesn't, it does fast key erasure with the base
> crng key and uses the output as its new per-cpu key, and then updates
> its local generation counter. Then, using this per-cpu state, we do
> ordinary fast key erasure. Half of this first block is used to overwrite
> the per-cpu crng key for the next call -- this is the fast key erasure
> RNG idea -- and the other half, along with the ChaCha state, is returned
> to the caller. If the caller desires more than this remaining half, it
> can generate more ChaCha blocks, unlocked, using the now detached ChaCha
> state that was just returned. Crypto-wise, this is more or less what we
> were doing before, but this simply makes it more explicit and ensures
> that we always have backtrack protection by not playing games with a
> shared block counter.
> 
> The flow looks like this:
> 
> ──extract()──► base_crng.key ◄──memcpy()───┐
>                    │                       │
>                    └──chacha()──────┬─► new_base_key
>                                     └─► crngs[n].key ◄──memcpy()───┐
>                                               │                    │
>                                               └──chacha()───┬─► new_key
>                                                             └─► random_bytes
>                                                                       │
>                                                                       └────►
> 
> There are a few hairy details around early init. Just as was done
> before, prior to having gathered enough entropy, crng_fast_load() and
> crng_slow_load() dump bytes directly into the base crng, and when we go
> to take bytes from the crng, in that case, we're doing fast key erasure
> with the base crng rather than the fast unlocked per-cpu crngs. This is
> fine as that's only the state of affairs during very early boot; once
> the crng initializes we never use these paths again.
> 
> In the process of all this, the APIs into the crng become a bit simpler:
> we have get_random_bytes(buf, len) and get_random_bytes_user(buf, len),
> which both do what you'd expect. All of the details of fast key erasure
> and per-cpu selection happen only in a very short critical section of
> crng_make_state(), which selects the right per-cpu key, does the fast
> key erasure, and returns a local state to the caller's stack. So, we no
> longer have a need for a separate backtrack function, as this happens
> all at once here. The API then allows us to extend backtrack protection
> to batched entropy without really having to do much at all.
> 
> The result is a bit simpler than before and has fewer foot guns. The
> init time state machine also gets a lot simpler as we don't need to wait
> for workqueues to come online and do deferred work. And the multi-core
> performance should be increased significantly, by virtue of having hardly
> any locking on the fast path.
> 
> Cc: Theodore Ts'o <tytso@mit.edu>
> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Reviewed-by: Jann Horn <jannh@google.com>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
> Changes v3->v4:
> - Following Jann's review, base_crng.birth is now written to with
>   WRITE_ONCE.
> 
>  drivers/char/random.c | 388 ++++++++++++++++++++++++------------------
>  1 file changed, 222 insertions(+), 166 deletions(-)

Looks good,

Reviewed-by: Eric Biggers <ebiggers@google.com>

The only oddity I noticed is that some new comments use the net coding style for
multi-line comments, and get reformatted to the standard style later in a later
patch.  It would be preferable to use the standard style from the beginning.

- Eric
