Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B28A5608DD
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 20:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbiF2SQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 14:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiF2SQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 14:16:48 -0400
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9AB0377E7;
        Wed, 29 Jun 2022 11:16:47 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id h187so27224754ybg.0;
        Wed, 29 Jun 2022 11:16:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e2vQq8MIH4kRrw5K4HzmN1jZyRcRJ2qYNkBhgFyi0xg=;
        b=P6BnCq3gd8hraZ4KnFBI0dD28GQHPOWbovHs/zOniluEV2ZFcG2AtbMiuVnSlJ5Khw
         PoG5gxVxcqFB6L7lCaGi56bhcGxtGFDw9M1vjTRLAKzfT9dFSm45ynN69Q1gyiCxIEsL
         EndLU7fKPrcAIPx56KDQX4vRHKP/Bf2+Ud6wO50owPl8/HVG8pcNUXKH4yvjjCZ2oluw
         PEHp63zlGj09gHN7wR42ACthvZD1Nn7i+NJteRI4SbHFi0/3sFmqQGTZYNHdEBpSoinZ
         V3POWY7dYTAvTXT79BtNrtt2LjV67gF0LBEOpm1IB03EN6wo/mZ7aqlCoCfFZbBXkWUc
         u1Yg==
X-Gm-Message-State: AJIora+YyzSQ78wGeH2NYfPGhHI1VLflOXw5KYKEICSn5FScqvs1P6Pd
        nQMRGnF5BL9g18Qkic42nvoVqiGjQ42OxV57kvw=
X-Google-Smtp-Source: AGRyM1vtdAG3/1IPgFAHsKtbpsFdYjJ6cD+YS34X+Zn6psiorkXMBC9omkOX/oDPk17lui9qhblknQIk9h+Ht5Uross=
X-Received: by 2002:a25:9847:0:b0:669:b4c6:d081 with SMTP id
 k7-20020a259847000000b00669b4c6d081mr4623945ybo.633.1656526607032; Wed, 29
 Jun 2022 11:16:47 -0700 (PDT)
MIME-Version: 1.0
References: <c4f669a8-0da6-862a-0450-ddf178272bdd@zhaoxin.com>
In-Reply-To: <c4f669a8-0da6-862a-0450-ddf178272bdd@zhaoxin.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 29 Jun 2022 20:16:35 +0200
Message-ID: <CAJZ5v0iGQz0GprbHSL6JVmHv8y-kDsyW4TouN6JwJZtp46DokQ@mail.gmail.com>
Subject: Re: [PATCH V2] cpufreq: Add Zhaoxin/Centaur turbo boost control
 interface support
To:     Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        CobeChen@zhaoxin.com, TimGuo@zhaoxin.com, LindaChai@zhaoxin.com,
        LeoLiu@zhaoxin.com,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
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

On Thu, Jun 23, 2022 at 3:21 AM Tony W Wang-oc <TonyWWang-oc@zhaoxin.com> wrote:
>
> Recent Zhaoxin/Centaur CPUs support X86_FEATURE_IDA and the turbo boost
> can be dynamically enabled or disabled through MSR 0x1a0[38] in the same
> way as Intel. So add turbo boost control support for these CPUs too.
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

Applied as 5.20 material.

However, I had to manually fix up the formatting of the patch.

Can you please configure your e-mail client so that this is not
necessary in the future?

Thanks!
