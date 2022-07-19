Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52CEA57A61B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 20:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239864AbiGSSJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 14:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239902AbiGSSJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 14:09:13 -0400
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D71D64BD12;
        Tue, 19 Jul 2022 11:09:10 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-31e45527da5so51116817b3.5;
        Tue, 19 Jul 2022 11:09:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CikpHCl4xPyO8is9wHqOqxHcI8760q8zSFqXKzAbPgs=;
        b=VYn92H9JkPruIh8+OkI9qgg8nLYfIhTZfq/ubCcaHyuiBcY5NIe/fuHpKQm87rlif5
         yiznei26XE00yJnZxIcKwB/8GbsmxylMUsi9g5MShDnLemR09ztwJZxS0JtWC/Sef+WL
         CEFbvt2DxqxTuVjhoaNYbevqmorH/wNbIAgzNiRiL4Wv8FIvJEkCSllJ1krf3lwSr1MX
         ZwHWBN/zU9+o2WxOIHVrI/CJIDR1603DhGXQmWmJV8fEjD4HlSvvdU3J6Jbn2+RgopR6
         EMZ5G6f5fD4RYPsPBWmrx2dWFj/27HiU3dPiXvJ7lRDMqu5yCdwkeDfdd0nFyVsXs8dv
         q3uA==
X-Gm-Message-State: AJIora/XD5939S4UzJ0NT38M63qOlIQ1PMvrurNcRL/tr2V2TxnwUw2x
        xVmjfVLuzqjFK3WUHOHta9U/FogF93Xko+xMwgw=
X-Google-Smtp-Source: AGRyM1vcWamIl/VSKZo+egAOoPQHNlsA/Z1+NJiXk1joCz1whK76iRN6s0LQMmw86Z/2x2D1dYhR4A1NaybZNBuYvr0=
X-Received: by 2002:a81:1a11:0:b0:31e:4549:d667 with SMTP id
 a17-20020a811a11000000b0031e4549d667mr8722237ywa.196.1658254150128; Tue, 19
 Jul 2022 11:09:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220707125329.378277-1-jaz@semihalf.com> <20220707125329.378277-2-jaz@semihalf.com>
In-Reply-To: <20220707125329.378277-2-jaz@semihalf.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 19 Jul 2022 20:08:59 +0200
Message-ID: <CAJZ5v0gdCN3P52ko44LQMqWJvDArHxZ7p4aSiQamML7aG_kRAA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] suspend: extend S2Idle ops by new notify handler
To:     Grzegorz Jaszczyk <jaz@semihalf.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dmy@semihalf.com, Mario Limonciello <mario.limonciello@amd.com>,
        Sean Christopherson <seanjc@google.com>, dbehr@google.com,
        upstream@semihalf.com, zide.chen@intel.corp-partner.google.com,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Sachi King <nakato@nakato.io>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>,
        "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>,
        "open list:HIBERNATION (aka Software Suspend, aka swsusp)" 
        <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 7, 2022 at 2:56 PM Grzegorz Jaszczyk <jaz@semihalf.com> wrote:
>
> Currently the LPS0 prepare_late callback is aimed to run as the very
> last thing before entering the S2Idle state from LPS0 perspective,
> nevertheless between this call and the system actually entering the
> S2Idle state there are several places where the suspension process could
> be canceled.

And why is this a problem?

The cancellation will occur only if there is a wakeup signal that
would otherwise cause one of the CPUs to exit the idle state.  Such a
wakeup signal can appear after calling the new notifier as well, so
why does it make a difference?

> In order to notify VMM about guest entering suspend, extend the S2Idle
> ops by new notify callback, which will be really invoked as a very last
> thing before guest actually enters S2Idle state.

It is not guaranteed that "suspend" (defined as all CPUs entering idle
states) will be actually entered even after this "last step".

> Additionally extend the acpi_s2idle_dev_ops by notify() callback so
> any driver can hook into it and allow to implement its own notification.
>
> Taking advantage of e.g. existing acpi_s2idle_dev_ops's prepare/restore
> hooks is not an option since it will not allow to prevent race
> conditions:
> - VM0 enters s2idle
> - host notes about VM0 is in s2idle
> - host continues with system suspension but in the meantime VM0 exits
> s2idle and sends notification but it is already too late (VM could not
> even send notification on time).

Too late for what?

> Introducing notify() as a very last step before the system enters S2Idle
> together with an assumption that the VMM has control over guest
> resumption allows preventing mentioned races.

How does it do that?

It looks like you want suspend-to-idle to behave like S3 and it won't.

> Signed-off-by: Grzegorz Jaszczyk <jaz@semihalf.com>
> ---
>  drivers/acpi/x86/s2idle.c | 11 +++++++++++
>  include/linux/acpi.h      |  1 +
>  include/linux/suspend.h   |  1 +
>  kernel/power/suspend.c    |  4 ++++
>  4 files changed, 17 insertions(+)
>
> diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
> index 2963229062f8..d5aff194c736 100644
> --- a/drivers/acpi/x86/s2idle.c
> +++ b/drivers/acpi/x86/s2idle.c
> @@ -520,10 +520,21 @@ void acpi_s2idle_restore_early(void)
>                                         lps0_dsm_func_mask, lps0_dsm_guid);
>  }
>
> +static void acpi_s2idle_notify(void)
> +{
> +       struct acpi_s2idle_dev_ops *handler;
> +
> +       list_for_each_entry(handler, &lps0_s2idle_devops_head, list_node) {
> +               if (handler->notify)
> +                       handler->notify();
> +       }
> +}
> +
>  static const struct platform_s2idle_ops acpi_s2idle_ops_lps0 = {
>         .begin = acpi_s2idle_begin,
>         .prepare = acpi_s2idle_prepare,
>         .prepare_late = acpi_s2idle_prepare_late,
> +       .notify = acpi_s2idle_notify,
>         .wake = acpi_s2idle_wake,
>         .restore_early = acpi_s2idle_restore_early,
>         .restore = acpi_s2idle_restore,
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 4f82a5bc6d98..b32c4baed99b 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -1068,6 +1068,7 @@ struct acpi_s2idle_dev_ops {
>         struct list_head list_node;
>         void (*prepare)(void);
>         void (*restore)(void);
> +       void (*notify)(void);
>  };
>  int acpi_register_lps0_dev(struct acpi_s2idle_dev_ops *arg);
>  void acpi_unregister_lps0_dev(struct acpi_s2idle_dev_ops *arg);
> diff --git a/include/linux/suspend.h b/include/linux/suspend.h
> index 70f2921e2e70..16ef7f9d9a03 100644
> --- a/include/linux/suspend.h
> +++ b/include/linux/suspend.h
> @@ -191,6 +191,7 @@ struct platform_s2idle_ops {
>         int (*begin)(void);
>         int (*prepare)(void);
>         int (*prepare_late)(void);
> +       void (*notify)(void);
>         bool (*wake)(void);
>         void (*restore_early)(void);
>         void (*restore)(void);
> diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> index 827075944d28..6ba211b94ed1 100644
> --- a/kernel/power/suspend.c
> +++ b/kernel/power/suspend.c
> @@ -100,6 +100,10 @@ static void s2idle_enter(void)
>
>         /* Push all the CPUs into the idle loop. */
>         wake_up_all_idle_cpus();
> +
> +       if (s2idle_ops && s2idle_ops->notify)
> +               s2idle_ops->notify();
> +
>         /* Make the current CPU wait so it can enter the idle loop too. */
>         swait_event_exclusive(s2idle_wait_head,
>                     s2idle_state == S2IDLE_STATE_WAKE);
> --
> 2.37.0.rc0.161.g10f37bed90-goog
>
