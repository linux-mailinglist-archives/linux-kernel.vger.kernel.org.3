Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE6C4855DB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 16:28:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241478AbiAEP2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 10:28:42 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:58094 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241463AbiAEP2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 10:28:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC40D617A2;
        Wed,  5 Jan 2022 15:28:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A818C36AE3;
        Wed,  5 Jan 2022 15:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641396520;
        bh=jK7haPX4q9rvuCeEYtnfNoeQBzPCh50yJXR961f8eX4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cbgVhvZ6f4e6Vg4gSBwo352MV63vEvJh60cdJ0w3vDIMjEmW0VChxcnjBYYH1yqv3
         u5n+s1J6xHGGIbfPcKTt75gFe7Qg/AE7bPJiz3Mp0XqvvotS1qrWJRhxSMUFFzHTGj
         +vZH2GWhYvsYdmtN1ICMyDiYh4ZkQV7ukx1Ja6T5jaOikK9urWmHV9f1sNWcSJxsZJ
         3GGkaWLsUNJlhg5K6xUI95A7RN1ZO7yZ8xkkRWRFuTv1wn/yHnzshG9DeTnkA4+HFW
         WS9w9IKS4ZhP9SulvYFhaLD/hu/cSfGFkQGjgQYJS1bJ/TNAELjivtzZ8Lz6wDoabM
         IPU/BbX/ToFiQ==
Received: by mail-wr1-f53.google.com with SMTP id t26so83773609wrb.4;
        Wed, 05 Jan 2022 07:28:40 -0800 (PST)
X-Gm-Message-State: AOAM532k1IO7O6parJad3WnbVmX04SJEHhFv4KOd5fxLJvBL0TgdcQhP
        pqb8vOaucDyhWy1pf0R/fQb5TxLLtyXV4ng4f9c=
X-Google-Smtp-Source: ABdhPJyrOZybwSp6WoRWIWZkbW2XABY3WPlCgU5yDYTkprlduwdduirIEetTOxcaZIBF5a3U/+FkN5ShKZG2OHtEcgw=
X-Received: by 2002:a5d:6b8f:: with SMTP id n15mr46755004wrx.189.1641396518606;
 Wed, 05 Jan 2022 07:28:38 -0800 (PST)
MIME-Version: 1.0
References: <Yc56ey6QKwaYg0yi@mit.edu> <20211231114903.60882-1-Jason@zx2c4.com>
In-Reply-To: <20211231114903.60882-1-Jason@zx2c4.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 5 Jan 2022 16:28:26 +0100
X-Gmail-Original-Message-ID: <CAMj1kXET1=wocf=t_xrhhGOq8Y=grubPpeY9f8Hv2u6rPfgWYg@mail.gmail.com>
Message-ID: <CAMj1kXET1=wocf=t_xrhhGOq8Y=grubPpeY9f8Hv2u6rPfgWYg@mail.gmail.com>
Subject: Re: [PATCH v2] random: avoid superfluous call to RDRAND in CRNG extraction
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Dec 2021 at 12:50, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
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
> And in the case where the CRNG doesn't have enough entropy yet, we're
> already initializing the ChaCha key row with RDRAND in
> crng_init_try_arch_early().
>
> Removing the call to RDRAND improves performance on an i7-11850H by
> 370%. In other words, the vast majority of the work done by
> extract_crng() prior to this commit was devoted to fetching 32 bits of
> RDRAND.
>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  drivers/char/random.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/char/random.c b/drivers/char/random.c
> index 4de0feb69781..17ec60948795 100644
> --- a/drivers/char/random.c
> +++ b/drivers/char/random.c
> @@ -1023,7 +1023,7 @@ static void crng_reseed(struct crng_state *crng, struct entropy_store *r)
>  static void _extract_crng(struct crng_state *crng,
>                           __u8 out[CHACHA_BLOCK_SIZE])
>  {
> -       unsigned long v, flags, init_time;
> +       unsigned long flags, init_time;
>
>         if (crng_ready()) {
>                 init_time = READ_ONCE(crng->init_time);
> @@ -1033,8 +1033,6 @@ static void _extract_crng(struct crng_state *crng,
>                                     &input_pool : NULL);
>         }
>         spin_lock_irqsave(&crng->lock, flags);
> -       if (arch_get_random_long(&v))
> -               crng->state[14] ^= v;
>         chacha20_block(&crng->state[0], out);
>         if (crng->state[12] == 0)
>                 crng->state[13]++;

Given that arch_get_random_long() may be backed by other things than
special instructions on some architectures/platforms, avoiding it if
we can on any path that may be a hot path is good, so

Acked-by: Ard Biesheuvel <ardb@kernel.org>
