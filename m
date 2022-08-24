Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84EE859F381
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 08:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234905AbiHXGNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 02:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234875AbiHXGNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 02:13:42 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE90422E5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 23:13:40 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id x63-20020a17090a6c4500b001fabbf8debfso530221pjj.4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 23:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=AjR9XSu1Nnujm9uAtsWKpMZYdgaGmcyKS3pcgGtNRUM=;
        b=l/pSwXqA6guVnJ/fx7K2+lSbwt6YRJjnrqrTJHpYb5w/lPaPEyCRI2QoDK9P6vhblk
         fuThyVN/dGpp+Qa47H5eIUfXYMlTxKI/vPK+mX8cGggbUV+ERX/lHsq5kzJbLd8hsd+7
         /j8Nnj8egrXjVUqmrxGY2F/0XfEoEmNtx5y/uZpVJKTva2JbXG7Y4SOC/NHX3s/W1T6e
         jSuevNypXxEV2OKm1jYaGvpZ7nsSCDMITwizhqOQis7oPtDvWOKLH8Q/3lVZFo27LCQz
         i930bzrmqKe+VZIuiDLHFTsoIIAOQYXIGWcPzIxewmQsPGKCHgMAHoLyMuTCq0hvs5Dh
         1bEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=AjR9XSu1Nnujm9uAtsWKpMZYdgaGmcyKS3pcgGtNRUM=;
        b=oQ57lR1JocBx4oCF9xeHjiCHOVNlwJkmrceu1UvL/SEJ0z8J+sztKXPpJa/6wFy/hQ
         k4oqd9v3qdmP4++SUIrEH2ZmQN7NfNfsFBkT3snLMnXobo6G8CQu6rhXVWnIiDvmFSSC
         8FRAcORHLTMO/kzEw3UqVTboUW14Pc6AdGzDhSsjmmBCNbkyGgbs3fzTj7P+Ro796r/e
         zybP54KTGYxLvWDUvSkENDCwes/G4sQDnCj/nslolHuZ+jjVECoarcUH0cizGkqmp69z
         ph4v4+YeceeiajGniEc8aucqP2k933CRfW9YnVEMEU8PLiOEExvnxOj5vT5oMjbVM77w
         BHdA==
X-Gm-Message-State: ACgBeo39kOmqcFz/m6HNZlnol9crVV6/kG1xyQrb7SycSGoIYxIM9ENU
        6tAcyFq+F4PhkS3Rugf8Qg5GDA==
X-Google-Smtp-Source: AA6agR7q00M3tCfGwdQsjPNGovJMwuhXdx/RcRhLw9z81kXeVR2UCGA4aOdveVFjy27b+5HqazB7tg==
X-Received: by 2002:a17:902:c945:b0:16d:d425:324a with SMTP id i5-20020a170902c94500b0016dd425324amr26788193pla.7.1661321620331;
        Tue, 23 Aug 2022 23:13:40 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id f7-20020a170902684700b0016d93c84049sm11572397pln.54.2022.08.23.23.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 23:13:39 -0700 (PDT)
Date:   Wed, 24 Aug 2022 11:43:37 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     linux-acpi@vger.kernel.org, rafael@kernel.or, lenb@kernel.org,
        robert.moore@intel.com, punit.agrawal@bytedance.com,
        lukasz.luba@arm.com, ionela.voinescu@arm.com,
        pierre.gondois@arm.com, linux-kernel@vger.kernel.org,
        devel@acpica.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 1/2] ACPI: CPPC: Disable FIE if registers in PCC
 regions
Message-ID: <20220824061337.dtgfmhgossyhzjpy@vireshk-i7>
References: <20220818211619.4193362-1-jeremy.linton@arm.com>
 <20220818211619.4193362-2-jeremy.linton@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220818211619.4193362-2-jeremy.linton@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-08-22, 16:16, Jeremy Linton wrote:
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> +bool cppc_perf_ctrs_in_pcc(void)
> +{
> +	int cpu;
> +
> +	for_each_present_cpu(cpu) {
> +		struct cpc_register_resource *ref_perf_reg;
> +		struct cpc_desc *cpc_desc;
> +
> +		cpc_desc = per_cpu(cpc_desc_ptr, cpu);
> +
> +		if (CPC_IN_PCC(&cpc_desc->cpc_regs[DELIVERED_CTR]) ||
> +		    CPC_IN_PCC(&cpc_desc->cpc_regs[REFERENCE_CTR]) ||
> +		    CPC_IN_PCC(&cpc_desc->cpc_regs[CTR_WRAP_TIME]))
> +			return true;
> +
> +
> +		ref_perf_reg = &cpc_desc->cpc_regs[REFERENCE_PERF];
> +
> +		/*
> +		 * If reference perf register is not supported then we should
> +		 * use the nominal perf value
> +		 */
> +		if (!CPC_SUPPORTED(ref_perf_reg))
> +			ref_perf_reg = &cpc_desc->cpc_regs[NOMINAL_PERF];
> +
> +		if (CPC_IN_PCC(ref_perf_reg))
> +			return true;
> +	}

Add a blank line here please.

> +	return false;
> +}
> +EXPORT_SYMBOL_GPL(cppc_perf_ctrs_in_pcc);
> +
>  /**
>   * cppc_get_perf_ctrs - Read a CPU's performance feedback counters.
>   * @cpunum: CPU from which to read counters.
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 24eaf0ec344d..32fcb0bf74a4 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -63,7 +63,15 @@ static struct cppc_workaround_oem_info wa_info[] = {
>  
>  static struct cpufreq_driver cppc_cpufreq_driver;
>  
> +static enum {
> +	FIE_UNSET = -1,
> +	FIE_ENABLED,
> +	FIE_DISABLED
> +} fie_disabled = FIE_UNSET;
> +
>  #ifdef CONFIG_ACPI_CPPC_CPUFREQ_FIE
> +module_param(fie_disabled, int, 0444);
> +MODULE_PARM_DESC(fie_disabled, "Disable Frequency Invariance Engine (FIE)");
>  
>  /* Frequency invariance support */
>  struct cppc_freq_invariance {
> @@ -158,7 +166,7 @@ static void cppc_cpufreq_cpu_fie_init(struct cpufreq_policy *policy)
>  	struct cppc_freq_invariance *cppc_fi;
>  	int cpu, ret;
>  
> -	if (cppc_cpufreq_driver.get == hisi_cppc_cpufreq_get_rate)
> +	if (fie_disabled)
>  		return;
>  
>  	for_each_cpu(cpu, policy->cpus) {
> @@ -199,7 +207,7 @@ static void cppc_cpufreq_cpu_fie_exit(struct cpufreq_policy *policy)
>  	struct cppc_freq_invariance *cppc_fi;
>  	int cpu;
>  
> -	if (cppc_cpufreq_driver.get == hisi_cppc_cpufreq_get_rate)
> +	if (fie_disabled)
>  		return;
>  
>  	/* policy->cpus will be empty here, use related_cpus instead */
> @@ -229,7 +237,21 @@ static void __init cppc_freq_invariance_init(void)
>  	};
>  	int ret;
>  
> -	if (cppc_cpufreq_driver.get == hisi_cppc_cpufreq_get_rate)
> +	switch (fie_disabled) {
> +	/* honor user request */
> +	case FIE_DISABLED:
> +	case FIE_ENABLED:
> +		break;
> +	case FIE_UNSET:
> +	default:
> +		fie_disabled = FIE_ENABLED;
> +		if (cppc_perf_ctrs_in_pcc()) {
> +			pr_info("FIE not enabled on systems with registers in PCC\n");
> +			fie_disabled = FIE_DISABLED;
> +		}
> +		break;
> +	}

here too.

> +	if (fie_disabled)
>  		return;
>  
>  	kworker_fie = kthread_create_worker(0, "cppc_fie");
> @@ -247,7 +269,7 @@ static void __init cppc_freq_invariance_init(void)
>  
>  static void cppc_freq_invariance_exit(void)
>  {
> -	if (cppc_cpufreq_driver.get == hisi_cppc_cpufreq_get_rate)
> +	if (fie_disabled)
>  		return;
>  
>  	kthread_destroy_worker(kworker_fie);
> @@ -936,6 +958,7 @@ static void cppc_check_hisi_workaround(void)
>  		    wa_info[i].oem_revision == tbl->oem_revision) {
>  			/* Overwrite the get() callback */
>  			cppc_cpufreq_driver.get = hisi_cppc_cpufreq_get_rate;
> +			fie_disabled = FIE_DISABLED;
>  			break;
>  		}
>  	}
> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
> index f73d357ecdf5..c5614444031f 100644
> --- a/include/acpi/cppc_acpi.h
> +++ b/include/acpi/cppc_acpi.h
> @@ -140,6 +140,7 @@ extern int cppc_get_perf_ctrs(int cpu, struct cppc_perf_fb_ctrs *perf_fb_ctrs);
>  extern int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls);
>  extern int cppc_set_enable(int cpu, bool enable);
>  extern int cppc_get_perf_caps(int cpu, struct cppc_perf_caps *caps);
> +extern bool cppc_perf_ctrs_in_pcc(void);
>  extern bool acpi_cpc_valid(void);
>  extern bool cppc_allow_fast_switch(void);
>  extern int acpi_get_psd_map(unsigned int cpu, struct cppc_cpudata *cpu_data);
> @@ -173,6 +174,10 @@ static inline int cppc_get_perf_caps(int cpu, struct cppc_perf_caps *caps)
>  {
>  	return -ENOTSUPP;
>  }
> +static inline bool cppc_perf_ctrs_in_pcc(void)
> +{
> +	return false;
> +}
>  static inline bool acpi_cpc_valid(void)
>  {
>  	return false;

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
