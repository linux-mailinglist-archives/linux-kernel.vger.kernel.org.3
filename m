Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E741C533D0E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 14:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243629AbiEYM5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 08:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbiEYM5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 08:57:07 -0400
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C1BA0051
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 05:57:06 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id g72so8071960ybf.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 05:57:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XbTQQ3fFsREZ3tUhy2vBlOH2mWBOf5JDmMrH0eHv+2E=;
        b=d4N0E7Xfbb7foV+cJmtF6eHJT1qjiLSSMK1qK8yL31OosmRjePjL/M9gOulWmnwfGB
         pcR5iMo0ARzmSTA+C1zaVxN+w9Et1TN/3KBG5I39LLQcaQXwXZoMmr9VDfGk19sML6Oe
         1Sv2T4tBHR0SUOA2ThXVbNtYPcWD6NnuiTDDVU7KZGGxoUvZymAv/TwzCYeCviHGAzJW
         GbPlgE6QM2aWCz9I525/ufPVZh/Rep5FTiuv2flyDyiWXrhCkS305/qy7WrvYZ/lVcwo
         o3lqx33n6r0B/pPaCYtHMmbw77GwzNIRC8bs0RiLwVUrDN2ikCgUvKXR2OPp8bNpM2D7
         n0NA==
X-Gm-Message-State: AOAM5314/vBxgSh17DirGkz4zpoHrGyquxCVHemnqop8K67HO6y+SOIi
        qBdSnBITBkAcJClbPe0OZIIDwqYlbiEMUHOPbdU=
X-Google-Smtp-Source: ABdhPJwvncEE0+UfXs5AhTYhctr25qdNy+sgvQE0dTu1P4CvXNDCmqtO8eBpQI+dL/SLF8fYYF3bG7NkMvBM0jJMhKE=
X-Received: by 2002:a25:6b50:0:b0:64f:4b33:664 with SMTP id
 o16-20020a256b50000000b0064f4b330664mr28570255ybm.153.1653483426127; Wed, 25
 May 2022 05:57:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220524212118.425702-1-dmitry.osipenko@collabora.com>
In-Reply-To: <20220524212118.425702-1-dmitry.osipenko@collabora.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 25 May 2022 14:56:55 +0200
Message-ID: <CAJZ5v0gZCMZ3m7gpPNpZf8_9Uob1km01nA9BFOi9BJhb3fDXmA@mail.gmail.com>
Subject: Re: [PATCH v1] kernel/reboot: Change registration order of legacy
 power-off handler
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Tue, May 24, 2022 at 11:23 PM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> We're unconditionally registering sys-off handler for the legacy
> pm_power_off() callback, this causes problem for platforms that don't
> use power-off handlers at all and should be halted. Now reboot syscall
> assumes that there is a power-off handler installed and tries to power
> off system instead of halting it.
>
> To fix the trouble, move the handler's registration to the reboot syscall
> and check the pm_power_off() presence.
>
> Fixes: 0e2110d2e910 ("kernel/reboot: Add kernel_can_power_off()")
> Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>  kernel/reboot.c | 33 +++++++++++++++++----------------
>  1 file changed, 17 insertions(+), 16 deletions(-)
>
> diff --git a/kernel/reboot.c b/kernel/reboot.c
> index 0bdc64ecf4f6..a091145ee710 100644
> --- a/kernel/reboot.c
> +++ b/kernel/reboot.c
> @@ -569,22 +569,6 @@ static int legacy_pm_power_off(struct sys_off_data *data)
>         return NOTIFY_DONE;
>  }
>
> -/*
> - * Register sys-off handlers for legacy PM callbacks. This allows legacy
> - * PM callbacks co-exist with the new sys-off API.
> - *
> - * TODO: Remove legacy handlers once all legacy PM users will be switched
> - *       to the sys-off based APIs.
> - */
> -static int __init legacy_pm_init(void)
> -{
> -       register_sys_off_handler(SYS_OFF_MODE_POWER_OFF, SYS_OFF_PRIO_DEFAULT,
> -                                legacy_pm_power_off, NULL);
> -
> -       return 0;
> -}
> -core_initcall(legacy_pm_init);
> -
>  static void do_kernel_power_off_prepare(void)
>  {
>         blocking_notifier_call_chain(&power_off_prep_handler_list, 0, NULL);
> @@ -646,6 +630,7 @@ SYSCALL_DEFINE4(reboot, int, magic1, int, magic2, unsigned int, cmd,
>                 void __user *, arg)
>  {
>         struct pid_namespace *pid_ns = task_active_pid_ns(current);
> +       struct sys_off_handler *sys_off = NULL;
>         char buffer[256];
>         int ret = 0;
>
> @@ -670,6 +655,21 @@ SYSCALL_DEFINE4(reboot, int, magic1, int, magic2, unsigned int, cmd,
>         if (ret)
>                 return ret;
>
> +       /*
> +        * Register sys-off handlers for legacy PM callback. This allows
> +        * legacy PM callbacks temporary co-exist with the new sys-off API.
> +        *
> +        * TODO: Remove legacy handlers once all legacy PM users will be
> +        *       switched to the sys-off based APIs.
> +        */
> +       if (pm_power_off) {
> +               sys_off = register_sys_off_handler(SYS_OFF_MODE_POWER_OFF,
> +                                                  SYS_OFF_PRIO_DEFAULT,
> +                                                  legacy_pm_power_off, NULL);
> +               if (IS_ERR(sys_off))
> +                       return PTR_ERR(sys_off);
> +       }
> +
>         /* Instead of trying to make the power_off code look like
>          * halt when pm_power_off is not set do it the easy way.
>          */
> @@ -727,6 +727,7 @@ SYSCALL_DEFINE4(reboot, int, magic1, int, magic2, unsigned int, cmd,
>                 break;
>         }
>         mutex_unlock(&system_transition_mutex);
> +       unregister_sys_off_handler(sys_off);
>         return ret;
>  }
>
> --

Applied, thanks!
