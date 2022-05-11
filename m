Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6535522DE0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 10:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242130AbiEKIJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 04:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233633AbiEKIJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 04:09:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB1529C2E0;
        Wed, 11 May 2022 01:09:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 30E4D61A00;
        Wed, 11 May 2022 08:09:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63A6FC385DB;
        Wed, 11 May 2022 08:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652256555;
        bh=Y+Ia4l60OdZb53bKEre3+7c6IYHAuawdxs89/G063l4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u1y/tduN3NYd2a1Qt8SFP3DOzm7mGXeZuFL3MU7g9j0gR9QNqz97VTUdc5LP6wDx1
         Ly81YR2IrrLO4idAVyTPxr8tKOQwjoQvShvvPsQma9RvwsYSJvf4ZB2F8kC1wTgY39
         T1bYdHk6NVAQr8DyG7npkaatv90RPNo5jYb25cQ2K3zE7uhZhkXJhg1wi6wocgV/vN
         VOZ3FYWcHCHwCkxNa8rrGjqPu4uC8x2J5xrjMsldYvc6Iy5f9yltV94GRse1DuMN+v
         iv/6fFGFPseIKYbziHNz1TD+vxqHNep6KvRyeQuzeZnooPebet5S83yntyQATDc61R
         epxJXVhj1jdiQ==
Date:   Wed, 11 May 2022 01:09:13 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>,
        Nadia Heninger <nadiah@cs.ucsd.edu>,
        Tom Ristenpart <ristenpart@cornell.edu>
Subject: Re: [PATCH] random: do not pretend to handle premature next security
 model
Message-ID: <YntvKcp5PYDUKoFE@sol.localdomain>
References: <20220504113025.285784-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220504113025.285784-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 04, 2022 at 01:30:25PM +0200, Jason A. Donenfeld wrote:
> Per the thread linked below, "premature next" is not considered to be a
> realistic threat model, and leads to more serious security problems.
> 
> "Premature next" is the scenario in which:
> 
> - Attacker compromises the current state of a fully initialized RNG via
>   some kind of infoleak.
> - New bits of entropy are added directly to the key used to generate the
>   /dev/urandom stream, without any buffering or pooling.
> - Attacker then, somehow having read access to /dev/urandom, samples RNG
>   output and brute forces the individual new bits that were added.
> - Result: the RNG never "recovers" from the initial compromise, a
>   so-called violation of what academics term "post-compromise security".
> 
> The usual solutions to this involve some form of delaying when entropy
> gets mixed into the crng. With Fortuna, this involves multiple input
> buckets. With what the Linux RNG was trying to do prior, this involves
> entropy estimation.
> 
> However, by delaying when entropy gets mixed in, it also means that RNG
> compromises are extremely dangerous during the window of time before
> the RNG has gathered enough entropy, during which time nonces may become
> predictable (or repeated), ephemeral keys may not be secret, and so
> forth. Moreover, it's unclear how realistic "premature next" is from an
> attack perspective, if these attacks even make sense in practice.
> 
> Put together -- and discussed in more detail in the thread below --
> these constitute grounds for just doing away with the current code that
> pretends to handle premature next. I say "pretends" because it wasn't
> doing an especially great job at it either; should we change our mind
> about this direction, we would probably implement Fortuna to "fix" the
> "problem", in which case, removing the pretend solution still makes
> sense.
> 
> This also reduces the crng reseed period from 5 minutes down to 1
> minute. The rationale from the thread might lead us toward reducing that
> even further in the future (or even eliminating it), but that remains a
> topic of a future commit.
> 
> At a high level, this patch changes semantics from:
> 
>     Before: Seed for the first time after 256 "bits" of estimated
>     entropy have been accumulated since the system booted. Thereafter,
>     reseed once every five minutes, but only if 256 new "bits" have been
>     accumulated since the last reseeding.
> 
>     After: Seed for the first time after 256 "bits" of estimated entropy
>     have been accumulated since the system booted. Thereafter, reseed
>     once every minute.
> 
> Most of this patch is renaming and removing: POOL_MIN_BITS becomes
> POOL_INIT_BITS, credit_entropy_bits() becomes credit_init_bits(),
> crng_reseed() loses its "force" parameter since it's now always true,
> the drain_entropy() function no longer has any use so it's removed,
> entropy estimation is skipped if we've already init'd, the various
> notifiers for "low on entropy" are now only active prior to init, and
> finally, some documentation comments are cleaned up here and there.
> 
> Link: https://lore.kernel.org/lkml/YmlMGx6+uigkGiZ0@zx2c4.com/
> Cc: Theodore Ts'o <tytso@mit.edu>
> Cc: Nadia Heninger <nadiah@cs.ucsd.edu>
> Cc: Tom Ristenpart <ristenpart@cornell.edu>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

This looks good to me; thanks for cleaning this up!  Feel free to add:

	Reviewed-by: Eric Biggers <ebiggers@google.com>

A couple very minor comments:

>   * The high level overview is that there is one input pool, into which
> - * various pieces of data are hashed. Some of that data is then "credited" as
> - * having a certain number of bits of entropy. When enough bits of entropy are
> - * available, the hash is finalized and handed as a key to a stream cipher that
> - * expands it indefinitely for various consumers. This key is periodically
> - * refreshed as the various entropy collectors, described below, add data to the
> - * input pool and credit it. There is currently no Fortuna-like scheduler
> - * involved, which can lead to malicious entropy sources causing a premature
> - * reseed, and the entropy estimates are, at best, conservative guesses.
> + * various pieces of data are hashed. Prior to initialization, some of that
> + * data is then "credited" as having a certain number of bits of entropy.
> + * When enough bits of entropy are available, the hash is finalized and
> + * handed as a key to a stream cipher that expands it indefinitely for
> + * various consumers. This key is periodically refreshed as the various
> + * entropy collectors, described below, add data to the input pool and
> + * credit it.

The words "and credit it" at the end of this paragraph shouldn't be there.

> +      /*
> +       * If the base_crng is old enough, we try to reseed, which in turn
> +       * bumps the generation counter that we check below.
> +       */

This should say "reseed" instead of "try to reseed".

- Eric
