Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6F4B4C91BC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 18:37:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236553AbiCARhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 12:37:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236590AbiCARhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 12:37:39 -0500
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9895DA75;
        Tue,  1 Mar 2022 09:36:54 -0800 (PST)
Received: by mail-yb1-f177.google.com with SMTP id w16so2751446ybi.12;
        Tue, 01 Mar 2022 09:36:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xPNiQjL75uNBXCBoYXZyPnahmGGulyEzs8d4Se7+D1o=;
        b=cWpc+ruZc4DwBdGtFjm4TBFYV2awogjAhgsKpTVh79S3bGadFyojpo1l+CjL6dzot2
         LYSwumJIJYJm6gk+cLqPRZ90yCM/L9R2N960K+A9iBaD2Ge8t/IS510AGIhDfSAjD3p5
         8dxWzyABoLBzmKMJdnHQ856cK4NPoUggzEZqTR01j17N/DqE51w24rK7neQGy+o2IOuN
         7bQRm6tY1ny3Dd4/LNpwUF8NFJjnk4uo2jGqkPEtvqABP3X481qzApWS5eoK438qLF6D
         MIcpyf4Oo7hui6mTfzgCWmVrYdMiqslP0aHzQo6Oo20WP++G7AKaCosqTtKRgk67W2oa
         H1zA==
X-Gm-Message-State: AOAM530D+Gm7FJdcoYh7cJakCZ9MO72/24mvDZRioC7Re/+1zDa2h1je
        MaCDzpiajuwyIGVH0biZSncnEczpMBl1GnCt8K4=
X-Google-Smtp-Source: ABdhPJyVm2eUewACHTtF/feQPf6WGfTJn2HJ905v356/QogmtLoXeyTTd8mwHtilrbDMGAWpDHQkz6WEun4aw1KqsSM=
X-Received: by 2002:a25:3f47:0:b0:628:7571:b07d with SMTP id
 m68-20020a253f47000000b006287571b07dmr4668355yba.622.1646156213955; Tue, 01
 Mar 2022 09:36:53 -0800 (PST)
MIME-Version: 1.0
References: <20220301173120.297105-1-Jason@zx2c4.com>
In-Reply-To: <20220301173120.297105-1-Jason@zx2c4.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 1 Mar 2022 18:36:43 +0100
Message-ID: <CAJZ5v0g+GihH_b9YvwuHzdrUVNGXOeabOznDC1vK6qLi8gtSTQ@mail.gmail.com>
Subject: Re: [PATCH] PM: notify of PM_POST_VMFORK events from vmgenid
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
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

On Tue, Mar 1, 2022 at 6:31 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> There's an additional virtual power state that various crypto-oriented
> drivers may benefit from being notified of, such as WireGuard: right
> after a virtual machine has forked. In WireGuard's case, the PM notifier
> there that clears keys pre-suspend will be adjusted to also clear them
> post-vmfork. This trivial commit wires up the machinery for that change,
> which builds on the recently added vmgenid driver in the random.git
> tree.

Well, what does power management have to do with WireGuard'?

> Cc: Rafael J. Wysocki <rafael@kernel.org>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Len Brown <len.brown@intel.com>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  drivers/virt/vmgenid.c  | 2 ++
>  include/linux/suspend.h | 4 ++++
>  kernel/power/main.c     | 6 ++++++
>  3 files changed, 12 insertions(+)
>
> diff --git a/drivers/virt/vmgenid.c b/drivers/virt/vmgenid.c
> index 0ae1a39f2e28..4bef3e8b3476 100644
> --- a/drivers/virt/vmgenid.c
> +++ b/drivers/virt/vmgenid.c
> @@ -10,6 +10,7 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/acpi.h>
> +#include <linux/suspend.h>
>  #include <linux/random.h>
>
>  ACPI_MODULE_NAME("vmgenid");
> @@ -75,6 +76,7 @@ static void vmgenid_notify(struct acpi_device *device, u32 event)
>         if (!memcmp(old_id, state->this_id, sizeof(old_id)))
>                 return;
>         add_vmfork_randomness(state->this_id, sizeof(state->this_id));
> +       pm_notify_vmfork();

IMV, this is completely confusing.

>  }
>
>  static const struct acpi_device_id vmgenid_ids[] = {
> diff --git a/include/linux/suspend.h b/include/linux/suspend.h
> index 300273ff40cc..a3836473b87b 100644
> --- a/include/linux/suspend.h
> +++ b/include/linux/suspend.h
> @@ -477,6 +477,7 @@ static inline int is_hibernate_resume_dev(dev_t dev) { return 0; }
>  #define PM_POST_SUSPEND                0x0004 /* Suspend finished */
>  #define PM_RESTORE_PREPARE     0x0005 /* Going to restore a saved image */
>  #define PM_POST_RESTORE                0x0006 /* Restore failed */
> +#define PM_POST_VMFORK         0x0007 /* Virtual machine has just forked */
>
>  extern struct mutex system_transition_mutex;
>
> @@ -487,6 +488,7 @@ void restore_processor_state(void);
>  /* kernel/power/main.c */
>  extern int register_pm_notifier(struct notifier_block *nb);
>  extern int unregister_pm_notifier(struct notifier_block *nb);
> +extern void pm_notify_vmfork(void);
>  extern void ksys_sync_helper(void);
>
>  #define pm_notifier(fn, pri) {                         \
> @@ -525,6 +527,8 @@ static inline int unregister_pm_notifier(struct notifier_block *nb)
>         return 0;
>  }
>
> +static inline void pm_notify_vmfork(void) {}
> +
>  static inline void ksys_sync_helper(void) {}
>
>  #define pm_notifier(fn, pri)   do { (void)(fn); } while (0)
> diff --git a/kernel/power/main.c b/kernel/power/main.c
> index 7e646079fbeb..a64cfb36b1b3 100644
> --- a/kernel/power/main.c
> +++ b/kernel/power/main.c
> @@ -94,6 +94,12 @@ int pm_notifier_call_chain(unsigned long val)
>         return blocking_notifier_call_chain(&pm_chain_head, val, NULL);
>  }
>
> +void pm_notify_vmfork(void)
> +{
> +       pm_notifier_call_chain(PM_POST_VMFORK);
> +}
> +EXPORT_SYMBOL_GPL(pm_notify_vmfork);
> +
>  /* If set, devices may be suspended and resumed asynchronously. */
>  int pm_async_enabled = 1;
>
> --
> 2.35.1
>
