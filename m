Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E82574DB7F0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 19:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355080AbiCPSci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 14:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240131AbiCPScg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 14:32:36 -0400
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAAA96C1EE;
        Wed, 16 Mar 2022 11:31:21 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-2e5757b57caso33556187b3.4;
        Wed, 16 Mar 2022 11:31:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5R6Uwr6nDtMkAry2ZgjQvsr9fn+4rSSNhLlmGFjcijE=;
        b=dJpPlkQuAcvOOWfmeZzLvDlR6nNMi8Ik5DMS+yBogkQwY74wLRzKvJFPiUhOkBKRls
         RdWwpFWMruthAa3yJCsSxI8dxQ1VCENeBPAuNgVcxj9tvVy2hMmhZ5nXXWRbDbiOwGdh
         SinfYAWvxCv9qe3jwf0h1vAQ+eCJPejNOgsLu95vIm7TCqggOo7SQUP48MrrZOKdoQ2r
         w/Nc5QVXjhZyapAQgJltc+65FqFnk2RQHcuH5DZczH6Xq1eqjoeeV4R0URuiKti23JaF
         khhk6EYmqbIUAws5z/7Gn4f9rU2546umrzvKovILh4AMh+4vadXhm1ZibcQ3E4WKfF8y
         CJ3A==
X-Gm-Message-State: AOAM5329Xcuh0P8EM5+3KgOk683Nft6gJNhgxg833MhbCATSfgOB+azN
        w0kVqCk8gNXh1O2W/ymoq9n/QSyQjF96Xs2W50g=
X-Google-Smtp-Source: ABdhPJyvPygbAhc3PbvOAkBl24jnFqk5OslzC0Hp92pNVNJaYGEFN+DOyuPuHdbbGfTJqX9vUlCUsnaDfWhOuTc77cY=
X-Received: by 2002:a81:bd0:0:b0:2dc:184b:e936 with SMTP id
 199-20020a810bd0000000b002dc184be936mr1609014ywl.7.1647455481095; Wed, 16 Mar
 2022 11:31:21 -0700 (PDT)
MIME-Version: 1.0
References: <26decf155bffc021a97846c0a0ed09c2b5e0bef1.camel@infradead.org>
 <CAJZ5v0gAkOqh1LVpdXKLxpswBSG-3LUaXoZgw0Op+3V69BjhZQ@mail.gmail.com> <9099d8903e9b2b16daec712acc9aa533fe84d102.camel@infradead.org>
In-Reply-To: <9099d8903e9b2b16daec712acc9aa533fe84d102.camel@infradead.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 16 Mar 2022 19:31:10 +0100
Message-ID: <CAJZ5v0g=ZDeNVCbR7suZzK0KsAM-4msUZSr3oyxSf0NYg2yezQ@mail.gmail.com>
Subject: Re: [PATCH] PM / hibernate: Honour ACPI hardware signature by default
 for virtual guests
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-pm <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        benh <benh@kernel.crashing.org>,
        "van der Linden, Frank" <fllinden@amazon.com>,
        Amit Shah <aams@amazon.com>
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

On Fri, Mar 11, 2022 at 8:20 PM David Woodhouse <dwmw2@infradead.org> wrote:
>
> From: David Woodhouse <dwmw@amazon.co.uk>
>
> The ACPI specification says that OSPM should refuse to restore from
> hibernate if the hardware signature changes, and should boot from
> scratch. However, real BIOSes often vary the hardware signature in cases
> where we *do* want to resume from hibernate, so Linux doesn't follow the
> spec by default.
>
> However, in a virtual environment there's no reason for the VMM to vary
> the hardware signature *unless* it wants to trigger a clean reboot as
> defined by the ACPI spec. So enable the check by default if a hypervisor
> is detected.
>
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>
> On Wed, 2021-12-08 at 16:07 +0100, Rafael J. Wysocki wrote:
> > On Mon, Nov 8, 2021 at 5:09 PM David Woodhouse <dwmw2@infradead.org> wrote:
> > > A follow-up patch may do this automatically for certain "known good"
> > > machines based on a DMI match, or perhaps just for all hypervisor
> > > guests since there's no good reason a hypervisor would change the
> > > hardware_signature that it exposes to guests *unless* it wants them
> > > to obey the ACPI specification.
> > >
> > > Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> >
> > Applied as 5.17 material, sorry for the delay.
>
> Here's the threatened follow-up. I think that a blanket enablement for
> all hypervisors is sane enough; there's no reason why a virtual
> environment would vary the hardware signature *unless* it wanted to
> trigger the ACPI defined hibernate behaviour, is there?

I don't think so.


>  arch/x86/kernel/acpi/sleep.c | 23 +++++++++++++++++++++--
>  drivers/acpi/sleep.c         | 11 +++--------
>  include/linux/acpi.h         |  2 +-
>  3 files changed, 25 insertions(+), 11 deletions(-)
>
> diff --git a/arch/x86/kernel/acpi/sleep.c b/arch/x86/kernel/acpi/sleep.c
> index 1e97f944b47d..3b7f4cdbf2e0 100644
> --- a/arch/x86/kernel/acpi/sleep.c
> +++ b/arch/x86/kernel/acpi/sleep.c
> @@ -15,6 +15,7 @@
>  #include <asm/desc.h>
>  #include <asm/cacheflush.h>
>  #include <asm/realmode.h>
> +#include <asm/hypervisor.h>
>
>  #include <linux/ftrace.h>
>  #include "../../realmode/rm/wakeup.h"
> @@ -140,9 +141,9 @@ static int __init acpi_sleep_setup(char *str)
>                         acpi_realmode_flags |= 4;
>  #ifdef CONFIG_HIBERNATION
>                 if (strncmp(str, "s4_hwsig", 8) == 0)
> -                       acpi_check_s4_hw_signature(1);
> +                       acpi_check_s4_hw_signature = 1;
>                 if (strncmp(str, "s4_nohwsig", 10) == 0)
> -                       acpi_check_s4_hw_signature(0);
> +                       acpi_check_s4_hw_signature = 0;
>  #endif
>                 if (strncmp(str, "nonvs", 5) == 0)
>                         acpi_nvs_nosave();
> @@ -160,3 +161,21 @@ static int __init acpi_sleep_setup(char *str)
>  }
>
>  __setup("acpi_sleep=", acpi_sleep_setup);
> +
> +#if defined(CONFIG_HIBERNATION) && defined(CONFIG_HYPERVISOR_GUEST)
> +static int __init init_s4_sigcheck(void)
> +{
> +       /*
> +        * If running on a hypervisor, honour the ACPI specification
> +        * by default and trigger a clean reboot when the hardware
> +        * signature in FACS is changed after hibernation.
> +        */
> +       if (acpi_check_s4_hw_signature == -1 &&
> +           !hypervisor_is_type(X86_HYPER_NATIVE))
> +               acpi_check_s4_hw_signature = 1;
> +
> +       return 0;
> +}
> +/* This must happen before acpi_init() which is a subsys initcall */
> +arch_initcall(init_s4_sigcheck);
> +#endif
> diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
> index a60ff5dfed3a..4c498e1051e9 100644
> --- a/drivers/acpi/sleep.c
> +++ b/drivers/acpi/sleep.c
> @@ -874,12 +874,7 @@ static inline void acpi_sleep_syscore_init(void) {}
>  #ifdef CONFIG_HIBERNATION
>  static unsigned long s4_hardware_signature;
>  static struct acpi_table_facs *facs;
> -static int sigcheck = -1; /* Default behaviour is just to warn */
> -
> -void __init acpi_check_s4_hw_signature(int check)
> -{
> -       sigcheck = check;
> -}
> +int acpi_check_s4_hw_signature = -1; /* Default behaviour is just to warn */
>
>  static int acpi_hibernation_begin(pm_message_t stage)
>  {
> @@ -1004,7 +999,7 @@ static void acpi_sleep_hibernate_setup(void)
>         hibernation_set_ops(old_suspend_ordering ?
>                         &acpi_hibernation_ops_old : &acpi_hibernation_ops);
>         sleep_states[ACPI_STATE_S4] = 1;
> -       if (!sigcheck)
> +       if (!acpi_check_s4_hw_signature)
>                 return;
>
>         acpi_get_table(ACPI_SIG_FACS, 1, (struct acpi_table_header **)&facs);
> @@ -1016,7 +1011,7 @@ static void acpi_sleep_hibernate_setup(void)
>                  */
>                 s4_hardware_signature = facs->hardware_signature;
>
> -               if (sigcheck > 0) {
> +               if (acpi_check_s4_hw_signature > 0) {
>                         /*
>                          * If we're actually obeying the ACPI specification
>                          * then the signature is written out as part of the
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 6274758648e3..766dbcb82df1 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -526,7 +526,7 @@ acpi_status acpi_release_memory(acpi_handle handle, struct resource *res,
>  int acpi_resources_are_enforced(void);
>
>  #ifdef CONFIG_HIBERNATION
> -void __init acpi_check_s4_hw_signature(int check);
> +extern int acpi_check_s4_hw_signature;
>  #endif
>
>  #ifdef CONFIG_PM_SLEEP
> --

Applied as 5.18 material, thanks!
