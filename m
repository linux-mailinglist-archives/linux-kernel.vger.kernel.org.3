Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34FAB5A0FAB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 13:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240393AbiHYL5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 07:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236914AbiHYL5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 07:57:05 -0400
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5652EA50E8;
        Thu, 25 Aug 2022 04:57:04 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-32a09b909f6so534709607b3.0;
        Thu, 25 Aug 2022 04:57:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=LpBUSQ8+dLzfENzgMDuXQKKEMYFkYK6qD4eq2J6Y6oI=;
        b=l7NKTR08Zt3KMI1NzSpAD4dIOYyngyx9Dl5b+BVp0jtBwkIK8GTwGf5AmxX1M7vBt/
         edw+XSfb4YAzpqAg4Uafqq4DjYRVCPrMo+gybhFFYUWeF9wPmkZ5AUSU9bjWUKmcKNDc
         0QaWg8P6X149e0UvWD1gZQ6QaKYEQWrD5yhXtMm0vqcO/VFVXDJwCbpXej7m1AElRCT0
         5QRBMmpTr4Hk+kHh08/Jes/0maAbLc9IRw7tI4RO1qtYK70B7TjEkwVWY+b74HaCIQEM
         4pT3Os6+cp3xmnvEz495zXVkRLkxR2i3G8ge2d/4OU/yKo63GfaYrQfQMtyxLBTJUI4c
         Q0Bg==
X-Gm-Message-State: ACgBeo04O4ut2WPDMimos+HUQ2c1PotTJqQE99bTPJ4BhF2+tbY4c52T
        +yVMpls1qUEp7wZNdgzK/AmemW4C+DNuAAR+W9c=
X-Google-Smtp-Source: AA6agR6ZltM7GIsSK7q85EYO8O9yeuzpcsEft5tghroqG/Fb2IkifDFg+A7t2tn9eqmCWFlhXgMwVLayexzdtOfifJ0=
X-Received: by 2002:a0d:e701:0:b0:336:90d7:c67a with SMTP id
 q1-20020a0de701000000b0033690d7c67amr3357365ywe.7.1661428623597; Thu, 25 Aug
 2022 04:57:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220814163548.326686-1-Perry.Yuan@amd.com> <20220814163548.326686-8-Perry.Yuan@amd.com>
In-Reply-To: <20220814163548.326686-8-Perry.Yuan@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 25 Aug 2022 13:56:52 +0200
Message-ID: <CAJZ5v0jwBU-6WFXVQZw4w7-r=LeyNqcu=rDHxP55VYKV5ETPng@mail.gmail.com>
Subject: Re: [PATCH v5 7/7] cpufreq: amd-pstate: add ACPI disabled check in acpi_cpc_valid()
To:     Perry Yuan <Perry.Yuan@amd.com>
Cc:     Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Huang Rui <ray.huang@amd.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Deepak Sharma <Deepak.Sharma@amd.com>,
        Mario Limonciello <Mario.Limonciello@amd.com>,
        Nathan Fontenot <Nathan.Fontenot@amd.com>,
        Alex Deucher <Alexander.Deucher@amd.com>,
        "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>, Shimmer.Huang@amd.com,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
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

On Sun, Aug 14, 2022 at 6:53 PM Perry Yuan <Perry.Yuan@amd.com> wrote:
>
> Add acpi function check in case ACPI is not enabled, that will cause
> pstate driver failed to call cppc acpi to change perf or update epp
> value for shared memory solution processors.
>
> When CPPC or ACPI is invalid, warning log will be needed to tell
> user that AMD pstate driver failed to load and what is wrong.
>
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> ---
>  drivers/acpi/cppc_acpi.c       | 3 +++
>  drivers/base/arch_topology.c   | 2 +-
>  drivers/cpufreq/amd-pstate.c   | 2 +-
>  drivers/cpufreq/cppc_cpufreq.c | 2 +-
>  4 files changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 1e15a9f25ae9..c2309429146f 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -424,6 +424,9 @@ bool acpi_cpc_valid(void)
>         struct cpc_desc *cpc_ptr;
>         int cpu;
>
> +       if (acpi_disabled)
> +               return false;
> +
>         for_each_present_cpu(cpu) {
>                 cpc_ptr = per_cpu(cpc_desc_ptr, cpu);
>                 if (!cpc_ptr)
> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index 579c851a2bd7..73a8cb31529d 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -352,7 +352,7 @@ void topology_init_cpu_capacity_cppc(void)
>         struct cppc_perf_caps perf_caps;
>         int cpu;
>
> -       if (likely(acpi_disabled || !acpi_cpc_valid()))
> +       if (likely(!acpi_cpc_valid()))
>                 return;
>
>         raw_capacity = kcalloc(num_possible_cpus(), sizeof(*raw_capacity),
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 9cb051d61422..96e4ecddf3f6 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -661,7 +661,7 @@ static int __init amd_pstate_init(void)
>                 return -ENODEV;
>
>         if (!acpi_cpc_valid()) {
> -               pr_debug("the _CPC object is not present in SBIOS\n");
> +               pr_warn_once("the _CPC object is not present in SBIOS or ACPI disabled\n");
>                 return -ENODEV;
>         }
>
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 24eaf0ec344d..9adb7612993e 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -947,7 +947,7 @@ static int __init cppc_cpufreq_init(void)
>  {
>         int ret;
>
> -       if ((acpi_disabled) || !acpi_cpc_valid())
> +       if (!acpi_cpc_valid())
>                 return -ENODEV;
>
>         cppc_check_hisi_workaround();
> --

Applied as 6.1 material with modified subject and changelog, thanks!
