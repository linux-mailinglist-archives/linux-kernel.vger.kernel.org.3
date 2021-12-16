Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6CB4477B41
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 19:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240536AbhLPSEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 13:04:24 -0500
Received: from mail-ot1-f51.google.com ([209.85.210.51]:35345 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240472AbhLPSEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 13:04:23 -0500
Received: by mail-ot1-f51.google.com with SMTP id x43-20020a056830246b00b00570d09d34ebso29909674otr.2;
        Thu, 16 Dec 2021 10:04:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F62NtJ5rcRnEPI6psAGJlNzQVCLa/hSvcbHDvPlgq/k=;
        b=kpYR/QP4oeFBBzM8WgOy789DoHeRAoc6BNy70aOQ2ofU3c/Idj2+JSk3BFDAQlavVH
         pr9Y1WCh1/yQo0MYoe+T7JkWX8JdMOGxlCxUq0pprxcebjXyAvshCIfL9YoQUTt5UHnK
         6rxrNW7fHKuk/Kfi6VNyn2mC+P4lJ7PtKbc16Yv4eQqEQY8tT//swUWQS0EpejXUkqRn
         NPZRia3456lbOrkwd9QzijQzW94XKyhTElftsJ7Tnut3g8SBA6+HmFAJ0Ht3OWRIHL+D
         sVccIYXljjR3gGSlP/Um8hQXFttcnvWCZIbtw6D/LEm52RVckqsVzoo5YvLvBVLVGkxd
         iMcg==
X-Gm-Message-State: AOAM530fIpyru/FGf8IJANFfDTQcij04btbChkwTITue9CaoNPMHjQIf
        +JA15y9YEaSJQqhAWpDjTp08y0Xz7+jt89ACkYI=
X-Google-Smtp-Source: ABdhPJyX6mxbGB3zZlDlz2QTP+sYQp8M7EUTNdvEj+kfd3r2TD4M3asWg9P9SPDsI5mHV+CCwUg8Ry15/D4cdzG9Svs=
X-Received: by 2002:a9d:4c10:: with SMTP id l16mr13559702otf.198.1639677862392;
 Thu, 16 Dec 2021 10:04:22 -0800 (PST)
MIME-Version: 1.0
References: <20211130123641.1449041-1-ray.huang@amd.com> <20211130123641.1449041-9-ray.huang@amd.com>
In-Reply-To: <20211130123641.1449041-9-ray.huang@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 16 Dec 2021 19:04:11 +0100
Message-ID: <CAJZ5v0g=VWRtBoxd-yX8W_F9QfV4OE9Ap_vxHicW_CGgizsw2A@mail.gmail.com>
Subject: Re: [PATCH v5 08/22] cpufreq: amd: introduce the support for the
 processors with shared memory solution
To:     Huang Rui <ray.huang@amd.com>
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Linux PM <linux-pm@vger.kernel.org>,
        Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Steven Noonan <steven@valvesoftware.com>,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Jinzhou Su <Jinzhou.Su@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 1:38 PM Huang Rui <ray.huang@amd.com> wrote:
>
> In some of Zen2 and Zen3 based processors, they are using the shared
> memory that exposed from ACPI SBIOS. In this kind of the processors,
> there is no MSR support, so we add acpi cppc function as the backend for
> them.
>
> It is using a module param (shared_mem) to enable related processors
> manually. We will enable this by default once we address performance
> issue on this solution.
>
> Signed-off-by: Jinzhou Su <Jinzhou.Su@amd.com>
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 72 ++++++++++++++++++++++++++++++++++--
>  1 file changed, 68 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index cab266b8bf35..68991c450fd5 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -35,6 +35,19 @@
>  #define AMD_PSTATE_TRANSITION_LATENCY  0x20000
>  #define AMD_PSTATE_TRANSITION_DELAY    500
>
> +/* TODO: We need more time to fine tune processors with shared memory solution
> + * with community together.
> + *
> + * There are some performance drops on the CPU benchmarks which reports from
> + * Suse. We are co-working with them to fine tune the shared memory solution. So
> + * we disable it by default to go acpi-cpufreq on these processors and add a
> + * module parameter to be able to enable it manually for debugging.
> + */
> +static bool shared_mem = false;
> +module_param(shared_mem, bool, 0444);
> +MODULE_PARM_DESC(shared_mem,
> +                "enable amd-pstate on processors with shared memory solution (false = disabled (default), true = enabled)");
> +
>  static struct cpufreq_driver amd_pstate_driver;
>
>  struct amd_cpudata {
> @@ -60,6 +73,19 @@ static inline int pstate_enable(bool enable)
>         return wrmsrl_safe(MSR_AMD_CPPC_ENABLE, enable);
>  }
>
> +static int cppc_enable(bool enable)
> +{
> +       int cpu, ret = 0;
> +
> +       for_each_online_cpu(cpu) {
> +               ret = cppc_set_enable(cpu, enable);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       return ret;
> +}
> +
>  DEFINE_STATIC_CALL(amd_pstate_enable, pstate_enable);
>
>  static inline int amd_pstate_enable(bool enable)
> @@ -90,6 +116,24 @@ static int pstate_init_perf(struct amd_cpudata *cpudata)
>         return 0;
>  }
>
> +static int cppc_init_perf(struct amd_cpudata *cpudata)
> +{
> +       struct cppc_perf_caps cppc_perf;
> +
> +       int ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
> +       if (ret)
> +               return ret;
> +
> +       WRITE_ONCE(cpudata->highest_perf, amd_get_highest_perf());
> +
> +       WRITE_ONCE(cpudata->nominal_perf, cppc_perf.nominal_perf);
> +       WRITE_ONCE(cpudata->lowest_nonlinear_perf,
> +                  cppc_perf.lowest_nonlinear_perf);
> +       WRITE_ONCE(cpudata->lowest_perf, cppc_perf.lowest_perf);
> +
> +       return 0;
> +}
> +
>  DEFINE_STATIC_CALL(amd_pstate_init_perf, pstate_init_perf);
>
>  static inline int amd_pstate_init_perf(struct amd_cpudata *cpudata)
> @@ -107,6 +151,19 @@ static void pstate_update_perf(struct amd_cpudata *cpudata, u32 min_perf,
>                               READ_ONCE(cpudata->cppc_req_cached));
>  }
>
> +static void cppc_update_perf(struct amd_cpudata *cpudata,
> +                            u32 min_perf, u32 des_perf,
> +                            u32 max_perf, bool fast_switch)
> +{
> +       struct cppc_perf_ctrls perf_ctrls;
> +
> +       perf_ctrls.max_perf = max_perf;
> +       perf_ctrls.min_perf = min_perf;
> +       perf_ctrls.desired_perf = des_perf;
> +
> +       cppc_set_perf(cpudata->cpu, &perf_ctrls);
> +}
> +
>  DEFINE_STATIC_CALL(amd_pstate_update_perf, pstate_update_perf);
>
>  static inline void amd_pstate_update_perf(struct amd_cpudata *cpudata,
> @@ -326,7 +383,8 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>         /* It will be updated by governor */
>         policy->cur = policy->cpuinfo.min_freq;
>
> -       policy->fast_switch_possible = true;
> +       if (boot_cpu_has(X86_FEATURE_CPPC))
> +               policy->fast_switch_possible = true;
>
>         ret = freq_qos_add_request(&policy->constraints, &cpudata->req[0],
>                                    FREQ_QOS_MIN, policy->cpuinfo.min_freq);
> @@ -376,7 +434,6 @@ static struct cpufreq_driver amd_pstate_driver = {
>         .flags          = CPUFREQ_CONST_LOOPS | CPUFREQ_NEED_UPDATE_LIMITS,
>         .verify         = amd_pstate_verify,
>         .target         = amd_pstate_target,
> -       .adjust_perf    = amd_pstate_adjust_perf,
>         .init           = amd_pstate_cpu_init,
>         .exit           = amd_pstate_cpu_exit,
>         .name           = "amd-pstate",
> @@ -399,8 +456,15 @@ static int __init amd_pstate_init(void)
>                 return -EEXIST;
>
>         /* capability check */
> -       if (!boot_cpu_has(X86_FEATURE_CPPC)) {
> -               pr_debug("AMD CPPC MSR based functionality is not supported\n");
> +       if (boot_cpu_has(X86_FEATURE_CPPC)) {
> +               pr_debug("AMD CPPC MSR based functionality is supported\n");
> +               amd_pstate_driver.adjust_perf = amd_pstate_adjust_perf;
> +       } else if (shared_mem) {
> +               static_call_update(amd_pstate_enable, cppc_enable);
> +               static_call_update(amd_pstate_init_perf, cppc_init_perf);
> +               static_call_update(amd_pstate_update_perf, cppc_update_perf);

I would rather add the static call definitions in this patch,
otherwise is somewhat cumbersome to review the series.

> +       } else {
> +               pr_info("This processor supports shared memory solution, you can enable it with amd_pstate.shared_mem=1\n");
>                 return -ENODEV;
>         }
>
> --
> 2.25.1
>
