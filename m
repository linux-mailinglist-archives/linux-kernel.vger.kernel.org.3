Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C246A5725A1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 21:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234433AbiGLTbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 15:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234415AbiGLTbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 15:31:21 -0400
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7833BF6BAA;
        Tue, 12 Jul 2022 12:07:09 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id i14so15581756yba.1;
        Tue, 12 Jul 2022 12:07:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9jSG1wgtixdY+YA7Ct6rK6ymsNuCZJmArD422MXwHis=;
        b=T972PrJ9pEdTXdaZBKrHZXHv/ozNN3G9CyoLNIE6lS5nXY4XCgZfx0mtStUcudAdAK
         tDcRsxMc52MFYwxmkkTnfbgyS581wdPPzSm/v0XPx4NB1UktoVfVA8cQxWgELhcbtXaH
         ZYgZKojngbT6fxL1ACb+QJ/svFhAlqKHHYFL4EwNQFv8b1Z5Y81MvqdaT34el1nIjs78
         dqjMVIsztUw2Qb+HFeC3rNV89Ny8lDrpiHQ0SEc+FrUVIH3dJX/MwesB6uFMYwCICOU+
         A8JU044LkREj4sI4geMcY64vK0HEY//L1GcYLLntk3XtaIMjdAuFDnqo/qE+VdAKGviz
         MoiA==
X-Gm-Message-State: AJIora+/QCRvkoQlK8ZejGnzLPjjnqnAR6HzFIcZVdbmRUNJeMjbUrrF
        CWAZiTp39mouCmv/PcRDef6rTMqCacSGalUndHI=
X-Google-Smtp-Source: AGRyM1u98PWCXYTMOkpVRxjYEtoYwvwqepx9OO+uuI42JLM9g9l1UWgHksdgil2QZhC1d9a7zIHKSoCnqYAu7/R+hf4=
X-Received: by 2002:a25:d714:0:b0:66f:5898:9eb1 with SMTP id
 o20-20020a25d714000000b0066f58989eb1mr8536068ybg.633.1657652828443; Tue, 12
 Jul 2022 12:07:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220701023328.2783-1-mario.limonciello@amd.com>
In-Reply-To: <20220701023328.2783-1-mario.limonciello@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 12 Jul 2022 21:06:57 +0200
Message-ID: <CAJZ5v0g5Zsbddid+w2qxa_bqwmeP-FSk_42SZ3doMoFs0r8S8g@mail.gmail.com>
Subject: Re: [PATCH v3 01/10] PM: suspend: Introduce `pm_suspend_preferred_s2idle`
To:     Mario Limonciello <mario.limonciello@amd.com>
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

On Fri, Jul 1, 2022 at 4:33 AM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> Many drivers in the kernel will check the FADT to determine if low
> power idle is supported and use this information to set up a policy
> decision in the driver.  To abstract this information from drivers
> introduce a new helper symbol that can indicate this information.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  include/linux/suspend.h |  1 +
>  kernel/power/suspend.c  | 17 +++++++++++++++++
>  2 files changed, 18 insertions(+)
>
> diff --git a/include/linux/suspend.h b/include/linux/suspend.h
> index 70f2921e2e70..9d911e026720 100644
> --- a/include/linux/suspend.h
> +++ b/include/linux/suspend.h
> @@ -305,6 +305,7 @@ static inline bool idle_should_enter_s2idle(void)
>         return unlikely(s2idle_state == S2IDLE_STATE_ENTER);
>  }
>
> +extern bool pm_suspend_preferred_s2idle(void);
>  extern bool pm_suspend_default_s2idle(void);
>  extern void __init pm_states_init(void);
>  extern void s2idle_set_ops(const struct platform_s2idle_ops *ops);
> diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> index 827075944d28..0030e7dfe6cf 100644
> --- a/kernel/power/suspend.c
> +++ b/kernel/power/suspend.c
> @@ -9,6 +9,7 @@
>
>  #define pr_fmt(fmt) "PM: " fmt
>
> +#include <linux/acpi.h>
>  #include <linux/string.h>
>  #include <linux/delay.h>
>  #include <linux/errno.h>
> @@ -61,6 +62,22 @@ static DECLARE_SWAIT_QUEUE_HEAD(s2idle_wait_head);
>  enum s2idle_states __read_mostly s2idle_state;
>  static DEFINE_RAW_SPINLOCK(s2idle_lock);
>
> +/**
> + * pm_suspend_preferred_s2idle - Check if suspend-to-idle is the preferred suspend method.
> + *
> + * Return 'true' if suspend-to-idle is preferred by the system designer for the default
> + * suspend method.
> + */
> +bool pm_suspend_preferred_s2idle(void)
> +{
> +#ifdef CONFIG_ACPI
> +       return acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0;
> +#else
> +       return false;
> +#endif
> +}
> +EXPORT_SYMBOL_GPL(pm_suspend_preferred_s2idle);

First, this is ACPI-specific, so please don't try to generalize it
artificially.  This confuses things and doesn't really help.

Second, ACPI_FADT_LOW_POWER_S0 means that "low power S0 idle" is
supported, not that suspend-to-idle is the preferred suspend method in
Linux.

System designers who set that bit in FADT may not even know what
suspend-to-idle is.

But it is good that you have identified the code checking that bit,
because it should not be checked without a valid reason.  I need to
review that code and see what's going on in there.

> +
>  /**
>   * pm_suspend_default_s2idle - Check if suspend-to-idle is the default suspend.
>   *
> --
> 2.34.1
>
