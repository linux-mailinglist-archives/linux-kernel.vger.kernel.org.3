Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48DF64BD3FF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 03:57:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344059AbiBUCr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 21:47:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344037AbiBUCry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 21:47:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567C31A386;
        Sun, 20 Feb 2022 18:47:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 18545B80E4C;
        Mon, 21 Feb 2022 02:47:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC76AC340E8;
        Mon, 21 Feb 2022 02:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645411649;
        bh=dPM6ucsKR5Kh3IChx4HaeFLJbLo8lJ+K3xGecNy8o78=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VZRA7xdGut90GFj2Sz/ReQNoHcAmkydLV2kMk1eTkjabGe6UIFO5TNEQpCuFvWy4Z
         o4zBBru9h+PjBLSM6pGBbCYoW3fIk0iT4y0MEF6VXA5DrEWe03mLfjxRXf+WVu7Xls
         lkUXAiw+4VIOGle618JiAF5nNbz83fpb1upVczBvY1yoU3jY6Hc7vYXen63YVC6+6S
         4q6ouvPvOBFb7BdV8n675GWDLNg2JIg0BuZGTyH65UQBZu7Tf4Iz/ydagW3W6b7CxS
         GIJt1JESzMHmbD+88mExOiRYIHXcImjxP7/Sv4d3FL2kZ9NezZfrSV1irDBoOy+54m
         Bk8300Nwy1yKQ==
Date:   Sun, 20 Feb 2022 18:47:28 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH v3] random: absorb fast pool into input pool after fast
 load
Message-ID: <YhL9QNsMSHZvuR0u@sol.localdomain>
References: <CAHmME9qMRO0YFwQRUZfuUjTy2=C0QYkNLZSK5YgVD0xpcP2qbQ@mail.gmail.com>
 <20220215211333.244383-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220215211333.244383-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2022 at 10:13:33PM +0100, Jason A. Donenfeld wrote:
> During crng_init == 0, we never credit entropy in add_interrupt_
> randomness(), but instead dump it directly into the primary_crng. That's
> fine, except for the fact that we then wind up throwing away that
> entropy later when we switch to extracting from the input pool and
> overwriting the primary_crng key. The two other early init sites --
> add_hwgenerator_randomness()'s use crng_fast_load() and add_device_
> randomness()'s use of crng_slow_load() -- always additionally give their
> inputs to the input pool. But not add_interrupt_randomness().
> 
> This commit fixes that shortcoming by calling mix_pool_bytes() after
> crng_fast_load() in add_interrupt_randomness(). That's partially
> verboten on PREEMPT_RT, where it implies taking spinlock_t from an IRQ
> handler. But this also only happens during early boot and then never
> again after that. Plus it's a trylock so it has the same considerations
> as calling crng_fast_load(), which we're already using.
> 
> Cc: Theodore Ts'o <tytso@mit.edu>
> Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>
> Suggested-by: Eric Biggers <ebiggers@google.com>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
> v3 uses a trylock instead of a spinlock, just like all the other locks
> taken in hard irq. (Incidentally, we're now talking about moving this
> into the deferred stage, so that at can be a spinlock, but at least with
> what we have here, this really must be a trylock.)

This looks fine, though it's unfortunate that it has to be a trylock so this
isn't guaranteed.  Also, the commit message is a bit misleading because it talks
about "overwriting" the primary_crng key, but at this point in the series the
extracted entropy is still being XOR'd with the primary_crng key.  It's not
until the next patch that the key is simply overwritten.

- Eric
