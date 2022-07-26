Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF615819BF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 20:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234044AbiGZSbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 14:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbiGZSbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 14:31:23 -0400
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C6C31F2CE;
        Tue, 26 Jul 2022 11:31:22 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-31e623a4ff4so152084427b3.4;
        Tue, 26 Jul 2022 11:31:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=n82DhlXUmmRWDBn1/90hG07HM42XaSvaAWKdxGdiSA8=;
        b=mTdm74fGJKO+F7L7nULRax2/f8z/6JOQkTGWbdAYbUzmXVZsRvpOLjLHSntqupjfI9
         mUd/nJqzS4U2QNacBOqEOBlNDzXpThnWN30IiAeky7phSN3qxGQMuAL+Mm5V0t2DQ+qT
         ZWuwfPsraa4b8IZ7b8PFfvh8QDEU7iLqcVn/JWl/oLL11OGAY8eGsgEOECFvrEoFQL/V
         0TYSo66Qk5XtI2EuSKoFRFAjFJbGqUT4cay7YsfrPImbeH/aUdlLY7XKRVc9C2/NFDlv
         Ewo0GIWHdczakFSXuBNPglm8szlbrz0oM/fZ1JFnEP/VKTz2oRD1+EqSsFwWvgCGXe+g
         /6Fg==
X-Gm-Message-State: AJIora/JBH2PypUi0gXKdUyRBkE9SykmT4b7RvamlNoFC5Z+I+lAxJJm
        XgTQoXvsx9N/sUuiFow+IR74o4sS8ibC6eSPIcjJ+Q6fdDA=
X-Google-Smtp-Source: AGRyM1uqp5TiGgWPGpfJgth/RPy+WmH1BNU71XEuqnN0R9mspF9qNQtcS5mytBoJRoiS8F7w9kqb7y0aZRyHz6yivpM=
X-Received: by 2002:a81:1b97:0:b0:2db:640f:49d8 with SMTP id
 b145-20020a811b97000000b002db640f49d8mr15600692ywb.326.1658860281180; Tue, 26
 Jul 2022 11:31:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220726145948.2194684-1-jeremy.linton@arm.com>
In-Reply-To: <20220726145948.2194684-1-jeremy.linton@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 26 Jul 2022 20:31:10 +0200
Message-ID: <CAJZ5v0i-bCi0=FN=rMWCWCyKYQ6-upOhXteu9p6xAaf5=m93+w@mail.gmail.com>
Subject: Re: [PATCH] ACPI: CPPC: Disable FIE if registers in PCC regions
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Robert Moore <robert.moore@intel.com>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2022 at 5:00 PM Jeremy Linton <jeremy.linton@arm.com> wrote:
>
> PCC regions utilize a mailbox to set/retrieve register values used by
> the CPPC code. This is fine as long as the operations are
> infrequent. With the FIE code enabled though the overhead can range
> from 2-11% of system CPU overhead (ex: as measured by top) on Arm
> based machines.
>
> So, before enabling FIE assure none of the registers used by
> cppc_get_perf_ctrs() are in the PCC region. Furthermore lets also
> enable a module parameter which can also disable it at boot or module
> reload.
>
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>  drivers/acpi/cppc_acpi.c       | 31 +++++++++++++++++++++++++++++++
>  drivers/cpufreq/cppc_cpufreq.c | 19 +++++++++++++++----
>  include/acpi/cppc_acpi.h       |  5 +++++
>  3 files changed, 51 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 3c6d4ef87be0..ad84c55b6409 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -1246,6 +1246,37 @@ int cppc_get_perf_caps(int cpunum, struct cppc_perf_caps *perf_caps)
>  }
>  EXPORT_SYMBOL_GPL(cppc_get_perf_caps);
>

A kerneldoc, please.

> +int cppc_perf_ctrs_in_pcc(void)

Why int and not bool?

> +{
> +       int cpu;
> +       struct cpc_desc *cpc_desc;
> +       struct cpc_register_resource *delivered_reg, *reference_reg,
> +               *ref_perf_reg, *ctr_wrap_reg;

No line wraps here, please and follow the reverse xmas tree convention.

> +
> +       for_each_present_cpu(cpu) {

Declare the variables only used in this loop here and you only need two.

> +               cpc_desc = per_cpu(cpc_desc_ptr, cpu);
> +               delivered_reg = &cpc_desc->cpc_regs[DELIVERED_CTR];
> +               reference_reg = &cpc_desc->cpc_regs[REFERENCE_CTR];
> +               ref_perf_reg = &cpc_desc->cpc_regs[REFERENCE_PERF];
> +               ctr_wrap_reg = &cpc_desc->cpc_regs[CTR_WRAP_TIME];

I would do

if (CPC_IN_PCC(&cpc_desc->cpc_regs[DELIVERED_CTR]) ||
    CPC_IN_PCC(&cpc_desc->cpc_regs[REFERENCE_CTR]) ||
    CPC_IN_PCC(&cpc_desc->cpc_regs[CTR_WRAP_TIME]))
        return true;

ref_perf_reg = &cpc_desc->cpc_regs[REFERENCE_PERF];
if (!CPC_SUPPORTED(ref_perf_reg))
    ref_perf_reg = &cpc_desc->cpc_regs[NOMINAL_PERF];

if (CPC_IN_PCC(ref_perf_reg))
    return true;

> +
> +               /*
> +                * If reference perf register is not supported then we should
> +                * use the nominal perf value
> +                */
> +               if (!CPC_SUPPORTED(ref_perf_reg))
> +                       ref_perf_reg = &cpc_desc->cpc_regs[NOMINAL_PERF];
> +
> +               /* Are any of the regs PCC ?*/
> +               if (CPC_IN_PCC(delivered_reg) || CPC_IN_PCC(reference_reg) ||
> +                       CPC_IN_PCC(ctr_wrap_reg) || CPC_IN_PCC(ref_perf_reg)) {
> +                       return true;
> +               }
> +       }
> +       return false;
> +}
> +EXPORT_SYMBOL_GPL(cppc_perf_ctrs_in_pcc);
> +
>  /**
>   * cppc_get_perf_ctrs - Read a CPU's performance feedback counters.
>   * @cpunum: CPU from which to read counters.
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 24eaf0ec344d..a66d3013d0f8 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -63,6 +63,10 @@ static struct cppc_workaround_oem_info wa_info[] = {
>
>  static struct cpufreq_driver cppc_cpufreq_driver;
>
> +static bool fie_disabled;
> +module_param(fie_disabled, bool, 0444);
> +MODULE_PARM_DESC(fie_disabled, "Disable Frequency Invariance Engine (FIE)");
> +
>  #ifdef CONFIG_ACPI_CPPC_CPUFREQ_FIE
>
>  /* Frequency invariance support */
> @@ -158,7 +162,7 @@ static void cppc_cpufreq_cpu_fie_init(struct cpufreq_policy *policy)
>         struct cppc_freq_invariance *cppc_fi;
>         int cpu, ret;
>
> -       if (cppc_cpufreq_driver.get == hisi_cppc_cpufreq_get_rate)
> +       if (fie_disabled)
>                 return;
>
>         for_each_cpu(cpu, policy->cpus) {
> @@ -199,7 +203,7 @@ static void cppc_cpufreq_cpu_fie_exit(struct cpufreq_policy *policy)
>         struct cppc_freq_invariance *cppc_fi;
>         int cpu;
>
> -       if (cppc_cpufreq_driver.get == hisi_cppc_cpufreq_get_rate)
> +       if (fie_disabled)
>                 return;
>
>         /* policy->cpus will be empty here, use related_cpus instead */
> @@ -229,7 +233,12 @@ static void __init cppc_freq_invariance_init(void)
>         };
>         int ret;
>
> -       if (cppc_cpufreq_driver.get == hisi_cppc_cpufreq_get_rate)
> +       if (cppc_perf_ctrs_in_pcc()) {
> +               pr_debug("FIE not enabled on systems with registers in PCC\n");
> +               fie_disabled = true;
> +       }
> +
> +       if (fie_disabled)
>                 return;
>
>         kworker_fie = kthread_create_worker(0, "cppc_fie");
> @@ -247,7 +256,7 @@ static void __init cppc_freq_invariance_init(void)
>
>  static void cppc_freq_invariance_exit(void)
>  {
> -       if (cppc_cpufreq_driver.get == hisi_cppc_cpufreq_get_rate)
> +       if (fie_disabled)
>                 return;
>
>         kthread_destroy_worker(kworker_fie);
> @@ -940,6 +949,8 @@ static void cppc_check_hisi_workaround(void)
>                 }
>         }
>
> +       fie_disabled = true;
> +
>         acpi_put_table(tbl);
>  }
>
> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
> index d389bab54241..f4ff571fcdcb 100644
> --- a/include/acpi/cppc_acpi.h
> +++ b/include/acpi/cppc_acpi.h
> @@ -140,6 +140,7 @@ extern int cppc_get_perf_ctrs(int cpu, struct cppc_perf_fb_ctrs *perf_fb_ctrs);
>  extern int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls);
>  extern int cppc_set_enable(int cpu, bool enable);
>  extern int cppc_get_perf_caps(int cpu, struct cppc_perf_caps *caps);
> +extern int cppc_perf_ctrs_in_pcc(void);
>  extern bool acpi_cpc_valid(void);
>  extern bool cppc_allow_fast_switch(void);
>  extern int acpi_get_psd_map(unsigned int cpu, struct cppc_cpudata *cpu_data);
> @@ -173,6 +174,10 @@ static inline int cppc_get_perf_caps(int cpu, struct cppc_perf_caps *caps)
>  {
>         return -ENOTSUPP;
>  }
> +extern int cppc_perf_ctrs_in_pcc(void)
> +{
> +       return false;
> +}
>  static inline bool acpi_cpc_valid(void)
>  {
>         return false;
> --
