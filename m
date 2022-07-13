Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E216A573C7F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 20:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236420AbiGMS1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 14:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232077AbiGMS1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 14:27:50 -0400
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029892E9F7;
        Wed, 13 Jul 2022 11:27:49 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-31cf1adbf92so121957747b3.4;
        Wed, 13 Jul 2022 11:27:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2yAkhNsH1tB4OOuCiRjioAhf9zhcyKClOY/dccJTk1Y=;
        b=5Pkm32Ht5TRWrljuB4H+SWr0a5lOGeLSos4PwNvZYNa662tTs3z2CfgtM+3AZjfc/0
         TTIuXw5TWjnTgD7kSEQdHLoDhGV2+nf3Y5WRvFlZj9Nh1Bnml+rB6aRSucXxHtlwdcoy
         1WwnpMnwCNgAkdx9lH14SAwVGrZsuwYW0XUbJfuMGXJ/7XG7ayMJpdRz/NQpiHuGAJR6
         U6gmPp2eoa8Syxdkf0PdeuVBFAywd4+X1aqvBbip6oa2ZzT251fUSS5zxfUMybt+7Xq3
         QwZsBKYhjk0peP8TK22e4TrJi6VtjmDvO6/TEyyS+8fIWnjIdu57NzmWGCHgHcD4ikM6
         dZ/A==
X-Gm-Message-State: AJIora+X9AgASNC/dIo5ShNQC4Xe5iPghcR3K1dHrHlTOkQu/B2rS3hD
        oKj9Uuao5dZrtJupKAdg+b8/X9xQAbkjLrptAvE=
X-Google-Smtp-Source: AGRyM1v1wUHmA1F4+IQ9I47CPgCjuNeQkQP95K0o1QOSZNhkEEDhNqw9ZKt1gL8f/oesQUA9awr4GGgvhPBTyuHL5NY=
X-Received: by 2002:a81:17d0:0:b0:31c:c5e2:fc1e with SMTP id
 199-20020a8117d0000000b0031cc5e2fc1emr5921676ywx.196.1657736868229; Wed, 13
 Jul 2022 11:27:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220701023328.2783-1-mario.limonciello@amd.com>
 <CAJZ5v0g5Zsbddid+w2qxa_bqwmeP-FSk_42SZ3doMoFs0r8S8g@mail.gmail.com> <fd572ac1-9447-b148-8ad5-c6ecca5c6477@amd.com>
In-Reply-To: <fd572ac1-9447-b148-8ad5-c6ecca5c6477@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 13 Jul 2022 20:27:37 +0200
Message-ID: <CAJZ5v0i0PNcXwkUOk=C23XZt0dOhH+aqrDrngHZDCBop7SzFiQ@mail.gmail.com>
Subject: Re: [PATCH v3 01/10] PM: suspend: Introduce `pm_suspend_preferred_s2idle`
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
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

On Tue, Jul 12, 2022 at 10:17 PM Limonciello, Mario
<mario.limonciello@amd.com> wrote:
>
> On 7/12/2022 14:06, Rafael J. Wysocki wrote:
> > On Fri, Jul 1, 2022 at 4:33 AM Mario Limonciello
> > <mario.limonciello@amd.com> wrote:
> >>
> >> Many drivers in the kernel will check the FADT to determine if low
> >> power idle is supported and use this information to set up a policy
> >> decision in the driver.  To abstract this information from drivers
> >> introduce a new helper symbol that can indicate this information.
> >>
> >> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> >> ---
> >>   include/linux/suspend.h |  1 +
> >>   kernel/power/suspend.c  | 17 +++++++++++++++++
> >>   2 files changed, 18 insertions(+)
> >>
> >> diff --git a/include/linux/suspend.h b/include/linux/suspend.h
> >> index 70f2921e2e70..9d911e026720 100644
> >> --- a/include/linux/suspend.h
> >> +++ b/include/linux/suspend.h
> >> @@ -305,6 +305,7 @@ static inline bool idle_should_enter_s2idle(void)
> >>          return unlikely(s2idle_state == S2IDLE_STATE_ENTER);
> >>   }
> >>
> >> +extern bool pm_suspend_preferred_s2idle(void);
> >>   extern bool pm_suspend_default_s2idle(void);
> >>   extern void __init pm_states_init(void);
> >>   extern void s2idle_set_ops(const struct platform_s2idle_ops *ops);
> >> diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> >> index 827075944d28..0030e7dfe6cf 100644
> >> --- a/kernel/power/suspend.c
> >> +++ b/kernel/power/suspend.c
> >> @@ -9,6 +9,7 @@
> >>
> >>   #define pr_fmt(fmt) "PM: " fmt
> >>
> >> +#include <linux/acpi.h>
> >>   #include <linux/string.h>
> >>   #include <linux/delay.h>
> >>   #include <linux/errno.h>
> >> @@ -61,6 +62,22 @@ static DECLARE_SWAIT_QUEUE_HEAD(s2idle_wait_head);
> >>   enum s2idle_states __read_mostly s2idle_state;
> >>   static DEFINE_RAW_SPINLOCK(s2idle_lock);
> >>
> >> +/**
> >> + * pm_suspend_preferred_s2idle - Check if suspend-to-idle is the preferred suspend method.
> >> + *
> >> + * Return 'true' if suspend-to-idle is preferred by the system designer for the default
> >> + * suspend method.
> >> + */
> >> +bool pm_suspend_preferred_s2idle(void)
> >> +{
> >> +#ifdef CONFIG_ACPI
> >> +       return acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0;
> >> +#else
> >> +       return false;
> >> +#endif
> >> +}
> >> +EXPORT_SYMBOL_GPL(pm_suspend_preferred_s2idle);
> >
> > First, this is ACPI-specific, so please don't try to generalize it
> > artificially.  This confuses things and doesn't really help.
> >
> > Second, ACPI_FADT_LOW_POWER_S0 means that "low power S0 idle" is
> > supported, not that suspend-to-idle is the preferred suspend method in
> > Linux.
> >
> > System designers who set that bit in FADT may not even know what
> > suspend-to-idle is.
>
> In "practice" it means that the system has been enabled for Modern
> Standby in Windows.
>
> >
> > But it is good that you have identified the code checking that bit,
> > because it should not be checked without a valid reason.  I need to
> > review that code and see what's going on in there.
>
> Within this series the intent is to see that the vendor meant the system
> to be using Modern Standby on Windows (and implicitly Suspend To Idle on
> Linux).
>
> With this I was trying to distinguish intent of the OEM between intent
> of the user for helping to declare policy.  Maybe the distinction of OEM
> and user decision don't really matter though and "mem_sleep_current" is
> better to use?  I think in a lot of the cases that I outlined I think
> that mem_sleep_current can drop right in instead of acpi_gbl_FADT.flags.

Checking ACPI_FADT_LOW_POWER_S0 is questionable in the majority of
cases, because if S3 is not supported, that flag is in fact
irrelevant, because Linux will allow suspend-to-idle to be used in
that case regardless of it.

> If you would like I'm happy to do that and send a new series.

I need to look at the individual pieces of code that check
ACPI_FADT_LOW_POWER_S0.
