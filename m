Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF24157256A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 21:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236004AbiGLTPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 15:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236118AbiGLTO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 15:14:28 -0400
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4C7E683E;
        Tue, 12 Jul 2022 11:54:11 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id p129so15517362yba.7;
        Tue, 12 Jul 2022 11:54:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ayGO49PfhW5yn8VZVDZP2vCg6MktvihoyGEzbg3823A=;
        b=vPdnYSEt92RVtKJX42PS/PjJkZCQ/HWjXXqD3qDgkEcvJFV1t5uKwIMUCK57lmFVAb
         9J5Erv/RkOgb45plxXZfQ+hRVRIgyJIgg13XG7vZn1xuHiMpp/e/sbshXyYPdXskPxqL
         wCrdVqYbhjiNlBYeKDAE1j9zLCVzevODIzi/wHXFb47rXQFrq3WPfkwPlyypqP2ASh+k
         roRz1laKusUShTrXs2cv5+Z86wD+U8mrLZONxdAX7Kcj1LAI2u6/m0/7RBtNQV+BzpKD
         o/I6CJVi4xM2w8wSZU/HVe1BC/KTQzeIRxXw3OHyF7LaLFldJ3HO6NUyEDRq5oUuJDEh
         uDCg==
X-Gm-Message-State: AJIora/fy40g51l5fcjYwa4dfW1vvalANJnypJ/DQBbUw2z4uVK4fhh3
        uD0bDC4lZz1YhWoptk+6vlaVJquZ/GeLEIlpcNA=
X-Google-Smtp-Source: AGRyM1t+aWUxZewPLwcIpwK1Ma3RA1r6QQ75+VBKPWZXevvL2PtzIyXroWnXqdtasPd086IfxhYKYyVlU+344UWm5jw=
X-Received: by 2002:a25:d714:0:b0:66f:5898:9eb1 with SMTP id
 o20-20020a25d714000000b0066f58989eb1mr8476398ybg.633.1657652050606; Tue, 12
 Jul 2022 11:54:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220629011146.299521-1-xiongxin@kylinos.cn> <20220629011146.299521-3-xiongxin@kylinos.cn>
In-Reply-To: <20220629011146.299521-3-xiongxin@kylinos.cn>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 12 Jul 2022 20:53:59 +0200
Message-ID: <CAJZ5v0hURC-mhHszh=BhrGYfP9hwCs_nTQVxmtnV4Ot2yuajLA@mail.gmail.com>
Subject: Re: [PATCH -next 2/2] PM: suspend: advanced pm_wakeup_clear() for
 normal suspend/hibernate
To:     xiongxin <xiongxin@kylinos.cn>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Riwen Lu <luriwen@kylinos.cn>,
        Linux PM <linux-pm@vger.kernel.org>,
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

On Wed, Jun 29, 2022 at 5:35 AM xiongxin <xiongxin@kylinos.cn> wrote:
>
> pm_wakeup_clear() will clear the wakeup source, which can ensure that it
> is not disturbed by useless wakeup signals when doing suspend/hibernate;
>
> At the beginning of the suspend/hibernate process, the notifier
> mechanism is used to notify other device drivers. This action is
> time-consuming (second-level time-consuming). If the process fails due
> to the received wakeup signal during the execution of these functions,
> it can better improve the experience of failing suspend/hibernate
> returns;
>
> Therefore, it is recommended here that for the suspend/hibernate process
> normally called from /sys/power/state, the pm_wakeup_clear() function
> should be brought before the notifier call; for the freeze_process()
> function called from other places, the original logic is kept;
>
> The pm_suspend_target_state variable is used here to identify whether the
> suspend process is going normally.

You seem to be arguing that the previous wakeup IRQ should be cleared
before invoking PM notifiers.  However, it is only set in
pm_system_irq_wakeup() which is only called after
suspend_device_irqs(), so clearing it anywhere before calling that
function in the given cycle should be sufficient.

> Signed-off-by: xiongxin <xiongxin@kylinos.cn>
> ---
>  kernel/power/process.c | 5 ++++-
>  kernel/power/suspend.c | 6 ++++++
>  2 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/power/process.c b/kernel/power/process.c
> index 3068601e585a..3fde0240b3d1 100644
> --- a/kernel/power/process.c
> +++ b/kernel/power/process.c
> @@ -131,7 +131,10 @@ int freeze_processes(void)
>         if (!pm_freezing)
>                 atomic_inc(&system_freezing_cnt);
>
> -       pm_wakeup_clear(0);
> +       if (pm_suspend_target_state != PM_SUSPEND_ON)
> +               pm_wakeup_clear(1);

This doesn't make sense.

> +       else
> +               pm_wakeup_clear(0);
>         pr_info("Freezing user space processes ... ");
>         pm_freezing = true;
>         error = try_to_freeze_tasks(true);
> diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> index c754b084ec03..f4259f6c1cc2 100644
> --- a/kernel/power/suspend.c
> +++ b/kernel/power/suspend.c
> @@ -569,6 +569,12 @@ static int enter_state(suspend_state_t state)
>          * performed from the /sys/power/state entry.
>          */
>         pm_suspend_target_state = state;
> +       /*
> +        * Put pm_wakeup_clear() before the notifier notification chain to
> +        * optimize in the suspend process, the wakeup signal can interrupt
> +        * the suspend in advance and fail to return.
> +        */

The comment above is too hard to understand for me, sorry.

> +       pm_wakeup_clear(0);
>
>         if (sync_on_suspend_enabled) {
>                 trace_suspend_resume(TPS("sync_filesystems"), 0, true);
> --
> 2.25.1
>
>
> No virus found
>                 Checked by Hillstone Network AntiVirus
