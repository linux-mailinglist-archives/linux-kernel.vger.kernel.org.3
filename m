Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77EE35A4F07
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 16:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbiH2OU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 10:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbiH2OUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 10:20:16 -0400
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5212408C;
        Mon, 29 Aug 2022 07:20:15 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-340f82c77baso83721117b3.1;
        Mon, 29 Aug 2022 07:20:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=1p7BUIQ+fp1bYUwTlQE8F/ZpBFXEYfElvWMJ48hUNkM=;
        b=PFNe7C6I1Ep7DNMkPho9b+eKO/xovqO57lPbxkzXnmdzLdBH+/O9uZvNMOHBLFFXAB
         K6iR7GRjNU9kDT75LyMluq9QwtCXsD3IKW+44iVGycYYQQcos8OzMqoU3ipa4q53wbjk
         fT+zqietivvwnLQW48lOgFAGxdTuRGoC3f2sTuEgoeSX2lmIiiw7w6s0vtw/Xh1QQ0n+
         azITUhX4i9NE1iSQAdo6HtueqbWEZxC61OAxN8hLuHBABweJG/kU8MWQWZ5cWNsLbjd4
         swFsjRayHAfctHPVaBhwcLx/5PZ47LdWfNiENqyBMULdeSj5JXh6kxrmmJIPK4vdnRLi
         ZR1g==
X-Gm-Message-State: ACgBeo0ImAbr5uiDqpEHvQssiOst/sQX1OtCCXPJgkNbUFW+F37oGKXB
        czp305pyYE9hT6OH4Xo73EZbpMqs4Zg8d9BU0rg=
X-Google-Smtp-Source: AA6agR4F/krzLDgya0v466f9YmXrHXnnHI7/b3x8fmHCUjPhph2Yus4Xc3quzkG+1BjkSJSIjoAMAAWcOf2oVxV7IVQ=
X-Received: by 2002:a0d:f647:0:b0:328:317c:9069 with SMTP id
 g68-20020a0df647000000b00328317c9069mr9461412ywf.301.1661782814810; Mon, 29
 Aug 2022 07:20:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220829132908.5254-1-mario.limonciello@amd.com> <20220829132908.5254-2-mario.limonciello@amd.com>
In-Reply-To: <20220829132908.5254-2-mario.limonciello@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 29 Aug 2022 16:20:03 +0200
Message-ID: <CAJZ5v0hfYhNLp+x9iFiqsQaL4XA8QdFhRK7Csgr8po8JPoimyQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] ACPI: s2idle: Add a new ->enter() callback for platform_s2idle_ops
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

On Mon, Aug 29, 2022 at 3:29 PM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On some platforms it is found that Linux more aggressively enters s2idle
> than Windows enters Modern Standby and this uncovers some synchronization
> issues for the platform.  To aid in debugging this class of problems in
> the future, add support for an extra optional callback intended for
> drivers to emit extra debugging.

I'm not liking this.

If you want debug, why not simply add it where it is needed?

> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
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
> index 7fe41ee489d6..7856930a7da9 100644
> --- a/drivers/acpi/sleep.h
> +++ b/drivers/acpi/sleep.h
> @@ -18,6 +18,7 @@ static inline acpi_status acpi_set_waking_vector(u32 wakeup_address)
>  extern int acpi_s2idle_begin(void);
>  extern int acpi_s2idle_prepare(void);
>  extern int acpi_s2idle_prepare_late(void);
> +extern void acpi_s2idle_enter(void);

And this name is confusing, because it suggests that the role of the
callback is to make the platform enter s2idle which isn't the case.

>  extern bool acpi_s2idle_wake(void);
>  extern void acpi_s2idle_restore_early(void);
>  extern void acpi_s2idle_restore(void);
> diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
> index f9ac12b778e6..c984093a3657 100644
> --- a/drivers/acpi/x86/s2idle.c
> +++ b/drivers/acpi/x86/s2idle.c
> @@ -486,6 +486,19 @@ int acpi_s2idle_prepare_late(void)
>         return 0;
>  }
>
> +void acpi_s2idle_enter(void)
> +{
> +       struct acpi_s2idle_dev_ops *handler;
> +
> +       if (!lps0_device_handle || sleep_no_lps0)
> +               return;
> +
> +       list_for_each_entry(handler, &lps0_s2idle_devops_head, list_node) {
> +               if (handler->enter)
> +                       handler->enter();
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
> +       .enter = acpi_s2idle_enter,
>         .wake = acpi_s2idle_wake,
>         .restore_early = acpi_s2idle_restore_early,
>         .restore = acpi_s2idle_restore,
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 6f64b2f3dc54..9df14b5a875c 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -1076,6 +1076,7 @@ struct acpi_s2idle_dev_ops {
>         struct list_head list_node;
>         void (*prepare)(void);
>         void (*restore)(void);
> +       void (*enter)(void);
>  };
>  int acpi_register_lps0_dev(struct acpi_s2idle_dev_ops *arg);
>  void acpi_unregister_lps0_dev(struct acpi_s2idle_dev_ops *arg);
> diff --git a/include/linux/suspend.h b/include/linux/suspend.h
> index 70f2921e2e70..5a3fdca0a628 100644
> --- a/include/linux/suspend.h
> +++ b/include/linux/suspend.h
> @@ -191,6 +191,7 @@ struct platform_s2idle_ops {
>         int (*begin)(void);
>         int (*prepare)(void);
>         int (*prepare_late)(void);
> +       void (*enter)(void);
>         bool (*wake)(void);
>         void (*restore_early)(void);
>         void (*restore)(void);
> diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> index 827075944d28..0c08032d6b50 100644
> --- a/kernel/power/suspend.c
> +++ b/kernel/power/suspend.c
> @@ -136,6 +136,9 @@ static void s2idle_loop(void)
>                         break;
>                 }
>
> +               if (s2idle_ops && s2idle_ops->enter)
> +                       s2idle_ops->enter();
> +
>                 s2idle_enter();
>         }
>
> --
> 2.34.1
>
