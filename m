Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 263D059EBEA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 21:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbiHWTMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 15:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbiHWTLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 15:11:48 -0400
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8861AE9C6;
        Tue, 23 Aug 2022 10:49:37 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-3321c2a8d4cso399310017b3.5;
        Tue, 23 Aug 2022 10:49:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=cHZxn2xN5dke6+dNAjI8WzSBH2ufuylF5p6Im82PJYA=;
        b=1Y9oOnWY/x925N/LyL3MuiLNh9cvPXF0Qo0CpueFgwahzq++RrcMO6VkzT1iJD0R3w
         vzPa3RdLaVWpOgkFuC5LdtCVEsTTB0B4t15JX7GHmPzCM04X4dqk2PZBtAeUViTC+tBh
         EWbC4+EjA4l5MUh7YczMUbe4c4JdsdFsXdaG5G+07M6IBmKkSVHikhDDq429IDnGOqaO
         FbBSmWWHdY4DV+BDmkPIavWvmIyF00IuoRm5+pCKuE/o0Nu7l2mlyt3DcXkvCUS+IOyk
         WYmLbFWkyrjsJFoajKwXEk08M9Nusz+rUDORq9074NtdWhLtdTcuNFpem4w6mVwlfm02
         om4w==
X-Gm-Message-State: ACgBeo3v2DGJn7DXMVI1GG91vme+MtpgU2bKUKsjeE3bIc/HuTWt4AR4
        xYB4qn1hd0hdavKMgyb+aQck32efb8PtXf/5440=
X-Google-Smtp-Source: AA6agR5ElR8/Ik+ufD/0IBqmq0NIBmLipbEwLaA6qtCd49CRxw4U5zKcjSfbDS9814wwC7ywC6xuHW2m+99Kfn075RU=
X-Received: by 2002:a25:ec0c:0:b0:690:d092:2d56 with SMTP id
 j12-20020a25ec0c000000b00690d0922d56mr23676520ybh.622.1661276888513; Tue, 23
 Aug 2022 10:48:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220808174107.38676-1-paul@crapouillou.net> <20220808174107.38676-2-paul@crapouillou.net>
In-Reply-To: <20220808174107.38676-2-paul@crapouillou.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 23 Aug 2022 19:47:57 +0200
Message-ID: <CAJZ5v0h3hf06xQsJGOfOyGbD470jyxkPNuaHP+E-pvXbS6Egxg@mail.gmail.com>
Subject: Re: [PATCH v2 01/30] pm: Improve EXPORT_*_DEV_PM_OPS macros
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-pm <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 8, 2022 at 7:41 PM Paul Cercueil <paul@crapouillou.net> wrote:
>
> Update the _EXPORT_DEV_PM_OPS() internal macro. It was not used anywhere
> outside pm.h and pm_runtime.h, so it is safe to update it.
>
> Before, this macro would take a few parameters to be used as sleep and
> runtime callbacks. This made it unsuitable to use with different
> callbacks, for instance the "noirq" ones.
>
> It is now semantically different: instead of creating a conditionally
> exported dev_pm_ops structure, it only contains part of the definition.
>
> This macro should however never be used directly (hence the trailing
> underscore). Instead, the following four macros are provided:
> - EXPORT_DEV_PM_OPS(name)
> - EXPORT_GPL_DEV_PM_OPS(name)
> - EXPORT_NS_DEV_PM_OPS(name, ns)
> - EXPORT_NS_GPL_DEV_PM_OPS(name, ns)
>
> For instance, it is now possible to conditionally export noirq
> suspend/resume PM functions like this:
>
> EXPORT_GPL_DEV_PM_OPS(foo_pm_ops) = {
>     NOIRQ_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn)
> };
>
> The existing helper macros EXPORT_*_SIMPLE_DEV_PM_OPS() and
> EXPORT_*_RUNTIME_DEV_PM_OPS() have been updated to use these new macros.
>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

or please let me know if you need me to pick up this one.

> ---
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Rafael J. Wysocki <rafael@kernel.org>
> Cc: linux-pm <linux-pm@vger.kernel.org>
>
>  include/linux/pm.h         | 37 +++++++++++++++++++++++--------------
>  include/linux/pm_runtime.h | 20 ++++++++++++--------
>  2 files changed, 35 insertions(+), 22 deletions(-)
>
> diff --git a/include/linux/pm.h b/include/linux/pm.h
> index 871c9c49ec9d..93cd34f00822 100644
> --- a/include/linux/pm.h
> +++ b/include/linux/pm.h
> @@ -375,19 +375,20 @@ const struct dev_pm_ops name = { \
>  }
>
>  #ifdef CONFIG_PM
> -#define _EXPORT_DEV_PM_OPS(name, suspend_fn, resume_fn, runtime_suspend_fn, \
> -                          runtime_resume_fn, idle_fn, sec, ns)         \
> -       _DEFINE_DEV_PM_OPS(name, suspend_fn, resume_fn, runtime_suspend_fn, \
> -                          runtime_resume_fn, idle_fn); \
> -       __EXPORT_SYMBOL(name, sec, ns)
> +#define _EXPORT_DEV_PM_OPS(name, sec, ns)                              \
> +       const struct dev_pm_ops name;                                   \
> +       __EXPORT_SYMBOL(name, sec, ns);                                 \
> +       const struct dev_pm_ops name
>  #else
> -#define _EXPORT_DEV_PM_OPS(name, suspend_fn, resume_fn, runtime_suspend_fn, \
> -                          runtime_resume_fn, idle_fn, sec, ns) \
> -static __maybe_unused _DEFINE_DEV_PM_OPS(__static_##name, suspend_fn, \
> -                                        resume_fn, runtime_suspend_fn, \
> -                                        runtime_resume_fn, idle_fn)
> +#define _EXPORT_DEV_PM_OPS(name, sec, ns)                              \
> +       static __maybe_unused const struct dev_pm_ops __static_##name
>  #endif
>
> +#define EXPORT_DEV_PM_OPS(name) _EXPORT_DEV_PM_OPS(name, "", "")
> +#define EXPORT_GPL_DEV_PM_OPS(name) _EXPORT_DEV_PM_OPS(name, "_gpl", "")
> +#define EXPORT_NS_DEV_PM_OPS(name, ns) _EXPORT_DEV_PM_OPS(name, "", #ns)
> +#define EXPORT_NS_GPL_DEV_PM_OPS(name, ns) _EXPORT_DEV_PM_OPS(name, "_gpl", #ns)
> +
>  /*
>   * Use this if you want to use the same suspend and resume callbacks for suspend
>   * to RAM and hibernation.
> @@ -399,13 +400,21 @@ static __maybe_unused _DEFINE_DEV_PM_OPS(__static_##name, suspend_fn, \
>         _DEFINE_DEV_PM_OPS(name, suspend_fn, resume_fn, NULL, NULL, NULL)
>
>  #define EXPORT_SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn) \
> -       _EXPORT_DEV_PM_OPS(name, suspend_fn, resume_fn, NULL, NULL, NULL, "", "")
> +       EXPORT_DEV_PM_OPS(name) = { \
> +               SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
> +       }
>  #define EXPORT_GPL_SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn) \
> -       _EXPORT_DEV_PM_OPS(name, suspend_fn, resume_fn, NULL, NULL, NULL, "_gpl", "")
> +       EXPORT_GPL_DEV_PM_OPS(name) = { \
> +               SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
> +       }
>  #define EXPORT_NS_SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn, ns)   \
> -       _EXPORT_DEV_PM_OPS(name, suspend_fn, resume_fn, NULL, NULL, NULL, "", #ns)
> +       EXPORT_NS_DEV_PM_OPS(name, ns) = { \
> +               SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
> +       }
>  #define EXPORT_NS_GPL_SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn, ns)       \
> -       _EXPORT_DEV_PM_OPS(name, suspend_fn, resume_fn, NULL, NULL, NULL, "_gpl", #ns)
> +       EXPORT_NS_GPL_DEV_PM_OPS(name, ns) = { \
> +               SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
> +       }
>
>  /* Deprecated. Use DEFINE_SIMPLE_DEV_PM_OPS() instead. */
>  #define SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn) \
> diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
> index 9e4d056967c6..ba2077d9e366 100644
> --- a/include/linux/pm_runtime.h
> +++ b/include/linux/pm_runtime.h
> @@ -40,17 +40,21 @@
>                            resume_fn, idle_fn)
>
>  #define EXPORT_RUNTIME_DEV_PM_OPS(name, suspend_fn, resume_fn, idle_fn) \
> -       _EXPORT_DEV_PM_OPS(name, pm_runtime_force_suspend, pm_runtime_force_resume, \
> -                          suspend_fn, resume_fn, idle_fn, "", "")
> +       EXPORT_DEV_PM_OPS(name) = { \
> +               RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn) \
> +       }
>  #define EXPORT_GPL_RUNTIME_DEV_PM_OPS(name, suspend_fn, resume_fn, idle_fn) \
> -       _EXPORT_DEV_PM_OPS(name, pm_runtime_force_suspend, pm_runtime_force_resume, \
> -                          suspend_fn, resume_fn, idle_fn, "_gpl", "")
> +       EXPORT_GPL_DEV_PM_OPS(name) = { \
> +               RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn) \
> +       }
>  #define EXPORT_NS_RUNTIME_DEV_PM_OPS(name, suspend_fn, resume_fn, idle_fn, ns) \
> -       _EXPORT_DEV_PM_OPS(name, pm_runtime_force_suspend, pm_runtime_force_resume, \
> -                          suspend_fn, resume_fn, idle_fn, "", #ns)
> +       EXPORT_NS_DEV_PM_OPS(name, ns) = { \
> +               RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn) \
> +       }
>  #define EXPORT_NS_GPL_RUNTIME_DEV_PM_OPS(name, suspend_fn, resume_fn, idle_fn, ns) \
> -       _EXPORT_DEV_PM_OPS(name, pm_runtime_force_suspend, pm_runtime_force_resume, \
> -                          suspend_fn, resume_fn, idle_fn, "_gpl", #ns)
> +       EXPORT_NS_GPL_DEV_PM_OPS(name, ns) = { \
> +               RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn) \
> +       }
>
>  #ifdef CONFIG_PM
>  extern struct workqueue_struct *pm_wq;
> --
> 2.35.1
>
