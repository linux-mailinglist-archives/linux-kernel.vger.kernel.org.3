Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7D265A6240
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 13:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbiH3Llf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 07:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbiH3LlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 07:41:00 -0400
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D35314FC82;
        Tue, 30 Aug 2022 04:39:26 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-334dc616f86so265484857b3.8;
        Tue, 30 Aug 2022 04:39:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=uV5cfbuaLiTKcX8ebdpr5XbHeoGI6rysE5BbBclWCfI=;
        b=zjsrBYCgzlhIsAkh7yQHqC7udor2hSvTI4ciFQ2THtTYcGCzifMhc4kkgrFo5/nPv9
         /ieqy9lTL6DpUDLW+oXtwWCcHR2im1i/jZP3X3aB7zRNHF8NnTD6OOPTR6CY06qbjxOo
         /nwWvUKNqWM3Eh7n00CETnRMc67Hv1RZlqF/DnOI5WLAuXvmJe8Zv9Efod+sEWT3fXO9
         02XwZoyLUaRPRonWztVRGwUaBKnZgTMR7g3Ef7CswT+8NGDolmpQ3xn38NByizSBg/7k
         UsLcRH8/JAo3+jFz5rb3HvEt2D/YzUyz3yVFNV6cR4qq0J36PCmdJ0KWZe+LuFu8z6El
         MPPQ==
X-Gm-Message-State: ACgBeo05EV14k3JjFCUbSlvmBJkIcoob+/YrZtBuVf/4p3MymKWQHPxa
        diIQF9/WTIA26o6DVBjP4zPsGHhklS2n3QBPazTF7pVA
X-Google-Smtp-Source: AA6agR4+KpbjY1aZb0VdgicXjYCJlvpgSIMRfqYob1yrYyrIGmJU1BotmLajKO2nBE3guHCl/eeE1pmLbzmU7/q+Cj8=
X-Received: by 2002:a0d:da83:0:b0:329:9c04:fe6d with SMTP id
 c125-20020a0dda83000000b003299c04fe6dmr13902110ywe.196.1661859564844; Tue, 30
 Aug 2022 04:39:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220829162953.5947-1-mario.limonciello@amd.com> <20220829162953.5947-2-mario.limonciello@amd.com>
In-Reply-To: <20220829162953.5947-2-mario.limonciello@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 30 Aug 2022 13:39:09 +0200
Message-ID: <CAJZ5v0iF1_MUptawLL4DD0RqZpysH2B+Pk5sj_=gLv9AOVdy=Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] ACPI: s2idle: Add a new ->check() callback for platform_s2idle_ops
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Hans de Goede <hdegoede@redhat.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
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

On Mon, Aug 29, 2022 at 6:29 PM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On some platforms it is found that Linux more aggressively enters s2idle
> than Windows enters Modern Standby and this uncovers some synchronization
> issues for the platform.  To aid in debugging this class of problems in
> the future, add support for an extra optional callback intended for
> drivers to emit extra debugging.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

and I'm assuming that this is for Hans.

> ---
> v2->v3:
>  * Rename to *check
> v1->v2:
>  * Add a prototype for `acpi_s2idle_enter`
>
>  drivers/acpi/sleep.h      |  1 +
>  drivers/acpi/x86/s2idle.c | 14 ++++++++++++++
>  include/linux/acpi.h      |  1 +
>  include/linux/suspend.h   |  1 +
>  kernel/power/suspend.c    |  3 +++
>  5 files changed, 20 insertions(+)
>
> diff --git a/drivers/acpi/sleep.h b/drivers/acpi/sleep.h
> index 7fe41ee489d6..d960a238be4e 100644
> --- a/drivers/acpi/sleep.h
> +++ b/drivers/acpi/sleep.h
> @@ -18,6 +18,7 @@ static inline acpi_status acpi_set_waking_vector(u32 wakeup_address)
>  extern int acpi_s2idle_begin(void);
>  extern int acpi_s2idle_prepare(void);
>  extern int acpi_s2idle_prepare_late(void);
> +extern void acpi_s2idle_check(void);
>  extern bool acpi_s2idle_wake(void);
>  extern void acpi_s2idle_restore_early(void);
>  extern void acpi_s2idle_restore(void);
> diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
> index f9ac12b778e6..474aa46f82f6 100644
> --- a/drivers/acpi/x86/s2idle.c
> +++ b/drivers/acpi/x86/s2idle.c
> @@ -486,6 +486,19 @@ int acpi_s2idle_prepare_late(void)
>         return 0;
>  }
>
> +void acpi_s2idle_check(void)
> +{
> +       struct acpi_s2idle_dev_ops *handler;
> +
> +       if (!lps0_device_handle || sleep_no_lps0)
> +               return;
> +
> +       list_for_each_entry(handler, &lps0_s2idle_devops_head, list_node) {
> +               if (handler->check)
> +                       handler->check();
> +       }
> +}
> +
>  void acpi_s2idle_restore_early(void)
>  {
>         struct acpi_s2idle_dev_ops *handler;
> @@ -527,6 +540,7 @@ static const struct platform_s2idle_ops acpi_s2idle_ops_lps0 = {
>         .begin = acpi_s2idle_begin,
>         .prepare = acpi_s2idle_prepare,
>         .prepare_late = acpi_s2idle_prepare_late,
> +       .check = acpi_s2idle_check,
>         .wake = acpi_s2idle_wake,
>         .restore_early = acpi_s2idle_restore_early,
>         .restore = acpi_s2idle_restore,
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 6f64b2f3dc54..acaa2ddc067d 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -1075,6 +1075,7 @@ acpi_status acpi_os_prepare_extended_sleep(u8 sleep_state,
>  struct acpi_s2idle_dev_ops {
>         struct list_head list_node;
>         void (*prepare)(void);
> +       void (*check)(void);
>         void (*restore)(void);
>  };
>  int acpi_register_lps0_dev(struct acpi_s2idle_dev_ops *arg);
> diff --git a/include/linux/suspend.h b/include/linux/suspend.h
> index 70f2921e2e70..03ed42ed2c7f 100644
> --- a/include/linux/suspend.h
> +++ b/include/linux/suspend.h
> @@ -191,6 +191,7 @@ struct platform_s2idle_ops {
>         int (*begin)(void);
>         int (*prepare)(void);
>         int (*prepare_late)(void);
> +       void (*check)(void);
>         bool (*wake)(void);
>         void (*restore_early)(void);
>         void (*restore)(void);
> diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> index 827075944d28..c6272d466e58 100644
> --- a/kernel/power/suspend.c
> +++ b/kernel/power/suspend.c
> @@ -136,6 +136,9 @@ static void s2idle_loop(void)
>                         break;
>                 }
>
> +               if (s2idle_ops && s2idle_ops->check)
> +                       s2idle_ops->check();
> +
>                 s2idle_enter();
>         }
>
> --
> 2.34.1
>
