Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70FF7554B7B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 15:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356294AbiFVNkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 09:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355133AbiFVNkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 09:40:02 -0400
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C2A121816;
        Wed, 22 Jun 2022 06:40:01 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id r3so30252346ybr.6;
        Wed, 22 Jun 2022 06:40:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QWDg0rhyoZvpLGpAqxxEbA8VkAjLaf+fxygRl5YnWAo=;
        b=voLxEs8HPNIYm2jdQWC/XV1R0cPFew9gkojHnC1QyjXhFWfsQEcM3fLjquv7S5YLyH
         +P+o0CPXsbA5aatNwFKshTGm871EpGQOufZsN05Ar21fk20/lZfXKgGJE6rUUKJk7Jnq
         drwACxAKoYgW9dCJTl4tcnXwc5eS4+38K4GRCUObDqAC+iqcFTkktJF6KV06XA1gnyi8
         zxK5i7Jg/hbJYBJKQdbFRfni7r5bySVCTfLYqKDuIcHs9FvF9cirkTmi4pr98cRpzr8R
         zgWR+1QcWtwem3nSwAeyqnttUPkCjYwV2jFGiQBaOCoMdAld1Es5wrVVnOWPzGlFVXLo
         W4nw==
X-Gm-Message-State: AJIora/NbQaT5n71MPoZulibCWbhvooLgEiynQNSmd2aysGzTcBmICd3
        3sBuRJDrCPvCuyRPO5amhIS7O7CMTMUwPikhczU=
X-Google-Smtp-Source: AGRyM1ulk0FwjicTCMHYsSFjEwuGhk6PaUnfkpEAOMJwpRYJIdQB4D0empuIioSKX2g9kG+7kJN0R5SMJM/RI34sDk4=
X-Received: by 2002:a05:6902:1141:b0:669:3f2a:c6bb with SMTP id
 p1-20020a056902114100b006693f2ac6bbmr3828070ybu.365.1655905200472; Wed, 22
 Jun 2022 06:40:00 -0700 (PDT)
MIME-Version: 1.0
References: <8b748cc6-09c9-081c-c0c5-2e75f017b032@zhaoxin.com>
In-Reply-To: <8b748cc6-09c9-081c-c0c5-2e75f017b032@zhaoxin.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 22 Jun 2022 15:39:49 +0200
Message-ID: <CAJZ5v0gOOcy-POdtmM13n=weJGYNT8BEkix9Bzk_=0GNcgi_5w@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: Add Zhaoxin turbo boost control interface support
To:     Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        CobeChen@zhaoxin.com, TimGuo@zhaoxin.com, LindaChai@zhaoxin.com,
        LeoLiu@zhaoxin.com
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

On Wed, Jun 22, 2022 at 5:44 AM Tony W Wang-oc <TonyWWang-oc@zhaoxin.com> wrote:
>
> Recent Zhaoxin CPUs support X86_FEATURE_IDA and the turbo boost can
> be dynamically enabled or disabled through MSR 0x1a0[38] in the same
> way as Intel. So add turbo boost control support for Zhaoxin too.

And for Centaur too according to the code changes below.

>
> Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
> ---
>   drivers/cpufreq/acpi-cpufreq.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
> index 3d514b8..1bb2b90 100644
> --- a/drivers/cpufreq/acpi-cpufreq.c
> +++ b/drivers/cpufreq/acpi-cpufreq.c
> @@ -78,6 +78,8 @@ static bool boost_state(unsigned int cpu)
>
>         switch (boot_cpu_data.x86_vendor) {
>         case X86_VENDOR_INTEL:
> +       case X86_VENDOR_CENTAUR:
> +       case X86_VENDOR_ZHAOXIN:
>                 rdmsr_on_cpu(cpu, MSR_IA32_MISC_ENABLE, &lo, &hi);
>                 msr = lo | ((u64)hi << 32);
>                 return !(msr & MSR_IA32_MISC_ENABLE_TURBO_DISABLE);
> @@ -97,6 +99,8 @@ static int boost_set_msr(bool enable)
>
>         switch (boot_cpu_data.x86_vendor) {
>         case X86_VENDOR_INTEL:
> +       case X86_VENDOR_CENTAUR:
> +       case X86_VENDOR_ZHAOXIN:
>                 msr_addr = MSR_IA32_MISC_ENABLE;
>                 msr_mask = MSR_IA32_MISC_ENABLE_TURBO_DISABLE;
>                 break;
> --
> 2.7.4
