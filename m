Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD9125112D2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 09:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359046AbiD0HvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 03:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359034AbiD0HvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 03:51:15 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 315EE110979
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 00:48:05 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id j2so1955339ybu.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 00:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0J66tk+tjH7WPGylQ/KTca4P+o3BjiUk/X2uROjtOEA=;
        b=lMYrzKveaFZwK6dIBU7K6fnqqlJ7nYiXV3i5daGDeFvOX6iYwhNUwfXmb5/0W6ojjA
         dmHlfw/wM5F79VIPkn9V4+9NEUndSA2xHJdr2CnoDLE7xlLux2op6kPR+ErUR6qmUTf6
         Zby2m8mSls7It8gcx9UALWZy4iMACrPh4UC5HW/QzedYwRmcMq22nZYzJ9rt41ymrZOH
         CcvekU6CECb255qAOU5ujPra5/XKo5eU428a1LeJavcVI7fHtwpgs0iLJWUcBedBA5FV
         TIiBnsd/8QiVNApn9+66ZTLlWUp+6ElWa/55/AP14nlublrDhVMA4lxbBbNiEyaiO+sW
         yB5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0J66tk+tjH7WPGylQ/KTca4P+o3BjiUk/X2uROjtOEA=;
        b=StfdCWhypp5quOJih81UM8kZkkxmcRTAF/5+oFDcIej/RVvq6dQojhKtcKlyaIp5Wm
         gMyKF8KPKIOoHnAG6b/rBnn1uwG6m0wxPlshkM3gXnpBwW7zAgas86OQWqgj6X/kiSkT
         eklX7nLJyueJK6gVKGo2XN7tXzLMM+BKQe+KO+0zLt5KCiu2dKBEo3xAAHRFabjEJ0vY
         YpQwI4m7exbXg1rTpQDRkLeRmDircFx+Q7GUtjBV8+owMi7Mv9h4g23TIWd6sxXt3V27
         PXGG+Eu8H0rmFLzM/SisJO+FKmoQqxoLuEXopLKYH/JgFKTkOsRBJy1UjjeHc8VtFyJb
         6ZTg==
X-Gm-Message-State: AOAM531OAoiAFfY4JvdotFtb+ByYoTKjrNilBitG2JvsIoGXhD49kvS/
        ap/tNzPKMGgywJQD9gPjLVdtKb3WuUvQxjYsuGqv3Q==
X-Google-Smtp-Source: ABdhPJxscbTl5zn0AaJ7eDXGPDWjvRaA8W5xqZNMhdkGLYxXP9sm/5cgTFpbR4ESKqXYbi9SuBxK5Cy4C9vdT+DE3Fs=
X-Received: by 2002:a25:9b85:0:b0:63d:ad6c:aae8 with SMTP id
 v5-20020a259b85000000b0063dad6caae8mr23498572ybo.609.1651045684232; Wed, 27
 Apr 2022 00:48:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220427073448.10730-1-kunyu@nfschina.com>
In-Reply-To: <20220427073448.10730-1-kunyu@nfschina.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 27 Apr 2022 09:47:28 +0200
Message-ID: <CANpmjNNNWcH3X+1TSeinQt0VxdB2mVdQGgJwCG36X9Stochs+w@mail.gmail.com>
Subject: Re: [PATCH] kernel: Optimize unused integer return values
To:     Li kunyu <kunyu@nfschina.com>
Cc:     ebiederm@xmission.com, keescook@chromium.org, tglx@linutronix.de,
        oleg@redhat.com, legion@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Apr 2022 at 09:36, Li kunyu <kunyu@nfschina.com> wrote:
>
> Optimize unused integer return values

What is this optimizing?

Stylistically the current versions are consistent, and if in future
post_copy_siginfo_from_user32()'s implementation is changed to return
more than 0, it is easy to do.

Code-generation wise, this is de-optimizing and making code slower! In
particular, with what you've done the compiler can no longer tail-call
the functions. https://godbolt.org/z/j68MhjdzT

> Signed-off-by: Li kunyu <kunyu@nfschina.com>
> ---
>  kernel/signal.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/signal.c b/kernel/signal.c
> index 30cd1ca43bcd..ae58a966c8de 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -3464,7 +3464,7 @@ int __copy_siginfo_to_user32(struct compat_siginfo __user *to,
>         return 0;
>  }
>
> -static int post_copy_siginfo_from_user32(kernel_siginfo_t *to,
> +static void post_copy_siginfo_from_user32(kernel_siginfo_t *to,
>                                          const struct compat_siginfo *from)
>  {
>         clear_siginfo(to);
> @@ -3548,7 +3548,8 @@ static int __copy_siginfo_from_user32(int signo, struct kernel_siginfo *to,
>                 return -EFAULT;
>
>         from.si_signo = signo;
> -       return post_copy_siginfo_from_user32(to, &from);
> +       post_copy_siginfo_from_user32(to, &from);
> +       return 0;
>  }
>
>  int copy_siginfo_from_user32(struct kernel_siginfo *to,
> @@ -3559,7 +3560,8 @@ int copy_siginfo_from_user32(struct kernel_siginfo *to,
>         if (copy_from_user(&from, ufrom, sizeof(struct compat_siginfo)))
>                 return -EFAULT;
>
> -       return post_copy_siginfo_from_user32(to, &from);
> +       post_copy_siginfo_from_user32(to, &from);
> +       return 0;
>  }
>  #endif /* CONFIG_COMPAT */
>
> --
> 2.18.2
>
