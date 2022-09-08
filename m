Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11A145B1FE7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 16:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbiIHOAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 10:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232598AbiIHN7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 09:59:52 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E1E114A54
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 06:59:08 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id i129-20020a1c3b87000000b003b332a7acbcso1059705wma.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 06:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date;
        bh=M7E92wCvpAtXrboLofbMwI8QDT7eWvJxh9Ed8UPR9FE=;
        b=rRHfSMHKzdPj0NBj/1WqdWtWFmpy0W4vezr8XGDbiuBih4zftWjVCgKCGalK0y7VyK
         MO/6ZmTPvjYRqe+0u9ejiyUOQOQejMDa2H7LDA6vl8VIC6Ru3MocSx10fxu1riNDC+n4
         Gi2dPhiF/dQMMlH7sLxvkA7fYoRaSfimqGC4u3xDBFajX57v9FXt9N70BlS9GyxMhbeb
         /H7KJ53cZNPCooK9X4r8iH6pR0S4QVuP9f2ojyB3GMMmeq69LrEPqhnPnHagrSynhXq8
         rvQK36kj1istg+2eDx319GK80QKmv2J0vw1pFmFPoC7elFZxnMjZhMfQiDJqx22tnMuB
         h79A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=M7E92wCvpAtXrboLofbMwI8QDT7eWvJxh9Ed8UPR9FE=;
        b=jax2SEHFkvpYOaVFsba3KJKsEz00znfrGZ/hZzWsJiAxbQiPCfcE4DevDq7XU/gD+I
         mEVMW9p0dIedtwoHG4eFPcbCJyWmQpBrEg3lwbkycRN3Vwxc9dVxJw4v6pOLixMU3U/W
         NHNt8L0wjiTYvd54RiKALZBsYvez6f02ssqB1+iGShHIasO51BlnDcoq+ZppYzA7pj08
         jKaCX8tXKtFSqCZnoTUnp1xqt7CuJ0ox+wto2AV6o4F6UGbGzrVqpIgu5Uu8fv8qrnX6
         /dfNbziye6cpYOEzmk5G0oIIp8BNsdYxcT/LGzNEQNgm6Yc78L3pd2eOwNxsvp5lllav
         BC7A==
X-Gm-Message-State: ACgBeo1vkom7jXk8oWvlnF5jmPJU2H2H7pAqnC+QvUfyFvsvYUf8nE/i
        2EVK7Xo9Vpulh1get12ngcqIPw==
X-Google-Smtp-Source: AA6agR5Y1ue2R4SpA013wGrxxP837wnkH1/ZIs48DYRN0QAmnqT3NJV5vcMPuyb7/Gk+sbz2YUi6gw==
X-Received: by 2002:a05:600c:3217:b0:3a6:8235:4f6f with SMTP id r23-20020a05600c321700b003a682354f6fmr2328042wmp.96.1662645547031;
        Thu, 08 Sep 2022 06:59:07 -0700 (PDT)
Received: from localhost ([95.148.15.66])
        by smtp.gmail.com with ESMTPSA id g13-20020a05600c4ecd00b003a4c6e67f01sm3196979wmq.6.2022.09.08.06.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 06:59:06 -0700 (PDT)
From:   Punit Agrawal <punit.agrawal@bytedance.com>
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     linux-acpi@vger.kernel.org, rafael@kernel.org, lenb@kernel.org,
        viresh.kumar@linaro.org, robert.moore@intel.com,
        punit.agrawal@bytedance.com, lukasz.luba@arm.com,
        ionela.voinescu@arm.com, pierre.gondois@arm.com,
        linux-kernel@vger.kernel.org, devel@acpica.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 1/2] ACPI: CPPC: Disable FIE if registers in PCC regions
References: <20220819162547.141333-1-jeremy.linton@arm.com>
        <20220819162547.141333-2-jeremy.linton@arm.com>
Date:   Thu, 08 Sep 2022 14:59:05 +0100
In-Reply-To: <20220819162547.141333-2-jeremy.linton@arm.com> (Jeremy Linton's
        message of "Fri, 19 Aug 2022 11:25:46 -0500")
Message-ID: <87pmg6arx2.fsf@stealth>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeremy,

I missed the previous version (holidays) but hopefully still in time for
this one. A query / comment below.

Jeremy Linton <jeremy.linton@arm.com> writes:

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
>  drivers/acpi/cppc_acpi.c       | 41 ++++++++++++++++++++++++++++++++++
>  drivers/cpufreq/cppc_cpufreq.c | 31 +++++++++++++++++++++----
>  include/acpi/cppc_acpi.h       |  5 +++++
>  3 files changed, 73 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 1e15a9f25ae9..c840bf606b30 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -1240,6 +1240,47 @@ int cppc_get_perf_caps(int cpunum, struct cppc_perf_caps *perf_caps)
>  }
>  EXPORT_SYMBOL_GPL(cppc_get_perf_caps);
>  
> +/**
> + * cppc_perf_ctrs_in_pcc - Check if any perf counters are in a PCC region.
> + *
> + * CPPC has flexibility about how counters describing CPU perf are delivered.
> + * One of the choices is PCC regions, which can have a high access latency. This
> + * routine allows callers of cppc_get_perf_ctrs() to know this ahead of time.
> + *
> + * Return: true if any of the counters are in PCC regions, false otherwise
> + */
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

With this change, if FIE is enabled, the rest of the function will run
even if the hisi workaround is enabled. Not sure if that is an
intentional change. The same applies to similar other changes in the
patch as well.

The rest of the changes look ok.

[...]

