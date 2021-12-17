Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5979479036
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 16:45:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235324AbhLQPpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 10:45:22 -0500
Received: from mail-ot1-f50.google.com ([209.85.210.50]:41613 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234993AbhLQPpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 10:45:21 -0500
Received: by mail-ot1-f50.google.com with SMTP id n17-20020a9d64d1000000b00579cf677301so3332019otl.8;
        Fri, 17 Dec 2021 07:45:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GzHQTD44+c4L/n3WuHxm40VcMWISZ6Ni+Liojc877bg=;
        b=CsYFrNAYNsGem/1g45gar4mTeeSZWKtzFNeo7IhceptbF1GoQl9q43nIN80MbKb0fG
         SsGHZMDGqu3o72UMbWYLwKUYl0z97yA58Rqqb4TbtJRcjOELxK0cDHIU5AvGg4nUVYfS
         mqJmcAVDCU44y9Id22DKINKxW1oFzoRyrEArv8X20Zn/lbtemp+R6m4uZPkdndIfg41g
         JU9Ssp4CJMULl492HcoFISMNwv1VmIOxEx83YGc02FqwNpE2CodNz15FS1zqIoJ9xJd1
         IJ4wYQCIdCkgUGDnev0t6QTGcqIGPdobsYC4/xRV8SvsCvpoNIeMqU2NFr+jCa2ko+rR
         xHRw==
X-Gm-Message-State: AOAM530RiX6t2YutG4Yh/8zQY1HsJzMEpwcz/P2X5J4qx8f/O6bQJKs8
        hip/aAGKiWIDmb19ePOAAsZwCyAaN7dxxzVf+y8=
X-Google-Smtp-Source: ABdhPJwAUjR3gltHqTTD8lV/z+K87FvzcUT+wem08dLnWFKadwMiq3X/kA/6Ne6ndBT8sL9/vmmmZ/j62GZuVaulrBU=
X-Received: by 2002:a05:6830:348f:: with SMTP id c15mr2642020otu.254.1639755920761;
 Fri, 17 Dec 2021 07:45:20 -0800 (PST)
MIME-Version: 1.0
References: <20211216183305.3152807-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20211216183305.3152807-1-srinivas.pandruvada@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 17 Dec 2021 16:45:09 +0100
Message-ID: <CAJZ5v0iVusXxz7yhqTgnte+OCS+tZNSmCf0hwJxuK_w76CjpOw@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Update EPP for AlderLake mobile
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 7:33 PM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> There is an expectation from users that they can get frequency specified
> by cpufreq/cpuinfo_max_freq when conditions permit. But with AlderLake
> mobile it may not be possible. This is possible that frequency is clipped
> based on the system power-up EPP value. In this case users can update
> cpufreq/energy_performance_preference to some performance oriented EPP to
> limit clipping of frequencies.
>
> To get out of box behavior as the prior generations of CPUs, update EPP
> for AlderLake mobile CPUs on boot. On prior generations of CPUs EPP = 128
> was enough to get maximum frequency, but with AlderLake mobile the
> equivalent EPP is 102. Since EPP is model specific, this is possible that
> they have different meaning on each generation of CPU.
>
> The current EPP string "balance_performance" corresponds to EPP = 128.
> Change the EPP corresponding to "balance_performance" to 102 for only
> AlderLake mobile CPUs and update this on each CPU during boot.
>
> To implement reuse epp_values[] array and update the modified EPP at the
> index for BALANCE_PERFORMANCE. Add a dummy EPP_INDEX_DEFAULT to
> epp_values[] to match indexes in the energy_perf_strings[].
>
> After HWP PM is enabled also update EPP when "balance_performance" is
> redefined for the very first time after the boot on each CPU. On
> subsequent suspend/resume or offline/online the old EPP is restored,
> so no specific action is needed.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Applied as 5.17 material, thanks!

> ---
>  drivers/cpufreq/intel_pstate.c | 79 ++++++++++++++++++++++++----------
>  1 file changed, 57 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index dec2a5649ac1..1408411f4618 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -664,19 +664,29 @@ static int intel_pstate_set_epb(int cpu, s16 pref)
>   *     3               balance_power
>   *     4               power
>   */
> +
> +enum energy_perf_value_index {
> +       EPP_INDEX_DEFAULT = 0,
> +       EPP_INDEX_PERFORMANCE,
> +       EPP_INDEX_BALANCE_PERFORMANCE,
> +       EPP_INDEX_BALANCE_POWERSAVE,
> +       EPP_INDEX_POWERSAVE,
> +};
> +
>  static const char * const energy_perf_strings[] = {
> -       "default",
> -       "performance",
> -       "balance_performance",
> -       "balance_power",
> -       "power",
> +       [EPP_INDEX_DEFAULT] = "default",
> +       [EPP_INDEX_PERFORMANCE] = "performance",
> +       [EPP_INDEX_BALANCE_PERFORMANCE] = "balance_performance",
> +       [EPP_INDEX_BALANCE_POWERSAVE] = "balance_power",
> +       [EPP_INDEX_POWERSAVE] = "power",
>         NULL
>  };
> -static const unsigned int epp_values[] = {
> -       HWP_EPP_PERFORMANCE,
> -       HWP_EPP_BALANCE_PERFORMANCE,
> -       HWP_EPP_BALANCE_POWERSAVE,
> -       HWP_EPP_POWERSAVE
> +static unsigned int epp_values[] = {
> +       [EPP_INDEX_DEFAULT] = 0, /* Unused index */
> +       [EPP_INDEX_PERFORMANCE] = HWP_EPP_PERFORMANCE,
> +       [EPP_INDEX_BALANCE_PERFORMANCE] = HWP_EPP_BALANCE_PERFORMANCE,
> +       [EPP_INDEX_BALANCE_POWERSAVE] = HWP_EPP_BALANCE_POWERSAVE,
> +       [EPP_INDEX_POWERSAVE] = HWP_EPP_POWERSAVE,
>  };
>
>  static int intel_pstate_get_energy_pref_index(struct cpudata *cpu_data, int *raw_epp)
> @@ -690,14 +700,14 @@ static int intel_pstate_get_energy_pref_index(struct cpudata *cpu_data, int *raw
>                 return epp;
>
>         if (boot_cpu_has(X86_FEATURE_HWP_EPP)) {
> -               if (epp == HWP_EPP_PERFORMANCE)
> -                       return 1;
> -               if (epp == HWP_EPP_BALANCE_PERFORMANCE)
> -                       return 2;
> -               if (epp == HWP_EPP_BALANCE_POWERSAVE)
> -                       return 3;
> -               if (epp == HWP_EPP_POWERSAVE)
> -                       return 4;
> +               if (epp == epp_values[EPP_INDEX_PERFORMANCE])
> +                       return EPP_INDEX_PERFORMANCE;
> +               if (epp == epp_values[EPP_INDEX_BALANCE_PERFORMANCE])
> +                       return EPP_INDEX_BALANCE_PERFORMANCE;
> +               if (epp == epp_values[EPP_INDEX_BALANCE_POWERSAVE])
> +                       return EPP_INDEX_BALANCE_POWERSAVE;
> +               if (epp == epp_values[EPP_INDEX_POWERSAVE])
> +                       return EPP_INDEX_POWERSAVE;
>                 *raw_epp = epp;
>                 return 0;
>         } else if (boot_cpu_has(X86_FEATURE_EPB)) {
> @@ -757,7 +767,7 @@ static int intel_pstate_set_energy_pref_index(struct cpudata *cpu_data,
>                 if (use_raw)
>                         epp = raw_epp;
>                 else if (epp == -EINVAL)
> -                       epp = epp_values[pref_index - 1];
> +                       epp = epp_values[pref_index];
>
>                 /*
>                  * To avoid confusion, refuse to set EPP to any values different
> @@ -843,7 +853,7 @@ static ssize_t store_energy_performance_preference(
>                  * upfront.
>                  */
>                 if (!raw)
> -                       epp = ret ? epp_values[ret - 1] : cpu->epp_default;
> +                       epp = ret ? epp_values[ret] : cpu->epp_default;
>
>                 if (cpu->epp_cached != epp) {
>                         int err;
> @@ -1679,10 +1689,18 @@ static void intel_pstate_hwp_enable(struct cpudata *cpudata)
>                 wrmsrl_on_cpu(cpudata->cpu, MSR_HWP_INTERRUPT, 0x00);
>
>         wrmsrl_on_cpu(cpudata->cpu, MSR_PM_ENABLE, 0x1);
> -       if (cpudata->epp_default == -EINVAL)
> -               cpudata->epp_default = intel_pstate_get_epp(cpudata, 0);
>
>         intel_pstate_enable_hwp_interrupt(cpudata);
> +
> +       if (cpudata->epp_default >= 0)
> +               return;
> +
> +       if (epp_values[EPP_INDEX_BALANCE_PERFORMANCE] == HWP_EPP_BALANCE_PERFORMANCE) {
> +               cpudata->epp_default = intel_pstate_get_epp(cpudata, 0);
> +       } else {
> +               cpudata->epp_default = epp_values[EPP_INDEX_BALANCE_PERFORMANCE];
> +               intel_pstate_set_epp(cpudata, cpudata->epp_default);
> +       }
>  }
>
>  static int atom_get_min_pstate(void)
> @@ -3349,6 +3367,16 @@ static bool intel_pstate_hwp_is_enabled(void)
>         return !!(value & 0x1);
>  }
>
> +static const struct x86_cpu_id intel_epp_balance_perf[] = {
> +       /*
> +        * Set EPP value as 102, this is the max suggested EPP
> +        * which can result in one core turbo frequency for
> +        * AlderLake Mobile CPUs.
> +        */
> +       X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L, 102),
> +       {}
> +};
> +
>  static int __init intel_pstate_init(void)
>  {
>         static struct cpudata **_all_cpu_data;
> @@ -3438,6 +3466,13 @@ static int __init intel_pstate_init(void)
>
>         intel_pstate_sysfs_expose_params();
>
> +       if (hwp_active) {
> +               const struct x86_cpu_id *id = x86_match_cpu(intel_epp_balance_perf);
> +
> +               if (id)
> +                       epp_values[EPP_INDEX_BALANCE_PERFORMANCE] = id->driver_data;
> +       }
> +
>         mutex_lock(&intel_pstate_driver_lock);
>         rc = intel_pstate_register_driver(default_driver);
>         mutex_unlock(&intel_pstate_driver_lock);
> --
> 2.31.1
>
