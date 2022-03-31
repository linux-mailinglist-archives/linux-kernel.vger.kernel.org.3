Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7D344EDE39
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 18:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239517AbiCaQFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 12:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239598AbiCaQE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 12:04:56 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E7C1F1277
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 09:02:37 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id yy13so342224ejb.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 09:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sweetwater-ai.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UOsM5fHRpbJTbGazwZ9GiS6zVSzVYyLU6fFhBXbjeRM=;
        b=BiUxkq9eAqApCSa7neVYcwP2HDDyO/cyl5dYWiP8k9WjKNqodLI7mhlEJsDAwvv5nG
         rimdHaw4zzHiI3v+GM1Gwu3n0m+bFjis9ht4sYTb3tLnrxyi3ZpdoZ+G09zk6NMK3V3h
         nGWQSW6hGRvqIdo5fpsKAhwM5CYXwdhqm055ttZkqUjCvC94NUJIOXUv0vdkgYFhDSLs
         UcsxpINNa0aNxWnzBuQzsr+5bZMfYrxQmclnkRK6sRVr4UZoSNNwhz/419yUR3V9vy5s
         Y3bKN2nKfp/hQwMBFBxeI1D/JQTpmSu2o0Kfwy9Y18cqRwXCoA1yANwIeKsyC7GUzQAx
         iS4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UOsM5fHRpbJTbGazwZ9GiS6zVSzVYyLU6fFhBXbjeRM=;
        b=l6fEEJy9VCfMe1E/nxJHmTHN2aY8bGcfmQtMu7Y0nI48czeW9gx1nQQNtNymyp8Nbh
         dhmFZgKEAZvtsDElvSxPUVfne4qFzPu8bTzztZxolLGEXi2VEY0ni/woSOj/qHPdiXUH
         qBa74ihSlaGwEQhNQ+mQ5KFOpvboi0J3i3KEId3sUb4nDQ1M1dNTQo5hsdySSMFpAgAB
         phUudWtUtSW9xbxHfDlKhODv4M0UiIzU/n1YcVSK1d+o3xupTYIHuvb3zrhJtTNBwVMS
         WrmIZKj7H/deZk9H11hCMsmsWnZ3Dar90WS1m8vOarH38eXnpa6H3bS2QqvQ45Is7Nv1
         wOmw==
X-Gm-Message-State: AOAM532cRAIRVnsTnwKnWugMyxeaPbKJR3IReox3oL2njBlA/ZxsbrXT
        iexT6Uh+mHioqMEJhRRJs6WU8omCkjj8ZDmqVkGMxjmwkH2s8g==
X-Google-Smtp-Source: ABdhPJyoE+CVoRyGVXg+1A8+GHnoymttwhN3C/n20/DaHgqTLnG4/V+XvWWB9L68jg9tnaMekQ4ZlxJQD2DFKCUnryE=
X-Received: by 2002:a17:906:7304:b0:6da:9243:865 with SMTP id
 di4-20020a170906730400b006da92430865mr5583200ejc.665.1648742556371; Thu, 31
 Mar 2022 09:02:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220331150706.124075-1-Jason@zx2c4.com> <20220331152641.169301-1-Jason@zx2c4.com>
In-Reply-To: <20220331152641.169301-1-Jason@zx2c4.com>
From:   Michael Brooks <m@sweetwater.ai>
Date:   Thu, 31 Mar 2022 09:02:27 -0700
Message-ID: <CAOnCY6Sv1goLQMJkvjsVb+TGdowUk6_vQ4ELQ_GkHu8Wjs3PAA@mail.gmail.com>
Subject: Re: [PATCH v2] random: mix build-time latent entropy into pool at init
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        "Theodore Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mix_pool_bytes() has numerous problems, as discussed in prior emails.
Do we still want to be putting so much effort into a development dead
end?

-Michael

On Thu, Mar 31, 2022 at 8:28 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> Prior, the "input_pool_data" array needed no real initialization, and so
> it was easy to mark it with __latent_entropy to populate it during
> compile-time. In switching to using a hash function, this required us to
> specifically initialize it to some specific state, which means we
> dropped the __latent_entropy attribute. An unfortunate side effect was
> this meant the pool was no longer seeded using compile-time random data.
> In order to bring this back, we declare an array in rand_initialize()
> with __latent_entropy and call mix_pool_bytes() on that at init, which
> accomplishes the same thing as before. We make this __initconst, so that
> it doesn't take up space at runtime after init.
>
> Fixes: 6e8ec2552c7d ("random: use computational hash for entropy extraction")
> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> Cc: Theodore Ts'o <tytso@mit.edu>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
> Changes v1->v2:
> - Use __initconst.
>
>  drivers/char/random.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/char/random.c b/drivers/char/random.c
> index 40107f8b9e9e..1d8242969751 100644
> --- a/drivers/char/random.c
> +++ b/drivers/char/random.c
> @@ -975,6 +975,11 @@ int __init rand_initialize(void)
>         bool arch_init = true;
>         unsigned long rv;
>
> +#if defined(LATENT_ENTROPY_PLUGIN)
> +       static const u8 compiletime_seed[BLAKE2S_BLOCK_SIZE] __initconst __latent_entropy;
> +       _mix_pool_bytes(compiletime_seed, sizeof(compiletime_seed));
> +#endif
> +
>         for (i = 0; i < BLAKE2S_BLOCK_SIZE; i += sizeof(rv)) {
>                 if (!arch_get_random_seed_long_early(&rv) &&
>                     !arch_get_random_long_early(&rv)) {
> --
> 2.35.1
>
