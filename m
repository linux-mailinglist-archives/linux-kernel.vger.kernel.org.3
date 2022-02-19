Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 986B94BC325
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 01:04:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240303AbiBSACW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 19:02:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238538AbiBSACU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 19:02:20 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2418272DA1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 16:02:01 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id q8so9514753iod.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 16:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7ZlmJufess7nBAm7hU3DguIKv9ZtiGi9JSmRwv2EeUQ=;
        b=KZ27u7Fd31CMtI1sPqE6SRPOXDBWUdVlnIrhec7AUUtBN+/jw1SCmwMElAsG6PKIt6
         ccwedC7cvou8ouMzBv5d6f/9x/wWPbtESvfRfdlfF1gEfpN1+ISiGJCkMUWK/h6HDMcH
         dzT8ryzNEwtjObNWI1k5ZsbrusIbFAGRxZupY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7ZlmJufess7nBAm7hU3DguIKv9ZtiGi9JSmRwv2EeUQ=;
        b=cILLECdz1bxdWJJOu7ynCJdeZX08UqlRCjhxZ2h11bGzGQ7CjOcom5+tRQRo+ldk8n
         a/KtG43UJP7KpK3xbKMnxpXWdLiQOjKjOdUEmW4In4uLhsBWR00AoRF0V1vPcJzIEFLF
         j/RopzzxMQrhfh/S3Vs51L14ShlXi7UfAujbbIRm6Ss/YLm20glSyYmOFcz5xkHgvlY+
         m2Q7Du66B6ZL2a2W3ZHT57qtifJoC28EBYza0No+4qqCJ8+m2LyUL6t8LuoSVXfwect5
         84nxwgt5xQKTzuBbW6VvobyzzG4/neY9eqket5GWCmBtaegDOnIhtwnGjZWJdx0LwGkq
         kIUg==
X-Gm-Message-State: AOAM530SHt02Lelc0rMPfpI3hrLNP8I0sG3CmIqtbyZtTZeaXoEYsHsO
        WhaDq/PzdhCq1KtdVEKtXelIaQ==
X-Google-Smtp-Source: ABdhPJyO5b8f1Ne5v1jyoyUS2rZcna35i96AFo8C0R6aK1q7Jp4K3tW2sdgMnr2BwcH7XAu0HIZ5Jg==
X-Received: by 2002:a02:3403:0:b0:314:b71f:eae7 with SMTP id x3-20020a023403000000b00314b71feae7mr2701398jae.6.1645228921094;
        Fri, 18 Feb 2022 16:02:01 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id p5sm4433871ilq.71.2022.02.18.16.02.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Feb 2022 16:02:00 -0800 (PST)
Subject: Re: [PATCH RESEND v6 7/9] cpupower: Enable boost state support for
 AMD P-State module
To:     Huang Rui <ray.huang@amd.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-pm@vger.kernel.org
Cc:     Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Steven Noonan <steven@valvesoftware.com>,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Jinzhou Su <Jinzhou.Su@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        Perry Yuan <Perry.Yuan@amd.com>,
        Jassmine Meng <li.meng@amd.com>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220216073558.751071-1-ray.huang@amd.com>
 <20220216073558.751071-8-ray.huang@amd.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <f415df0b-9320-090c-7ca9-8597c0211e87@linuxfoundation.org>
Date:   Fri, 18 Feb 2022 17:01:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220216073558.751071-8-ray.huang@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/16/22 12:35 AM, Huang Rui wrote:
> The legacy ACPI hardware P-States function has 3 P-States on ACPI table,
> the CPU frequency only can be switched between the 3 P-States. While the
> processor supports the boost state, it will have another boost state
> that the frequency can be higher than P0 state, and the state can be
> decoded by the function of decode_pstates() and read by
> amd_pci_get_num_boost_states().
> 
> However, the new AMD P-State function is different than legacy ACPI
> hardware P-State on AMD processors. That has a finer grain frequency
> range between the highest and lowest frequency. And boost frequency is
> actually the frequency which is mapped on highest performance ratio. The
> similiar previous P0 frequency is mapped on nominal performance ratio.

Nit - similar

> If the highest performance on the processor is higher than nominal
> performance, then we think the current processor supports the boost
> state. And it uses amd_pstate_boost_init() to initialize boost for AMD
> P-State function.
> 
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> ---
>   tools/power/cpupower/utils/helpers/amd.c     | 18 ++++++++++++++++++
>   tools/power/cpupower/utils/helpers/helpers.h |  5 +++++
>   tools/power/cpupower/utils/helpers/misc.c    |  2 ++
>   3 files changed, 25 insertions(+)
> 
> diff --git a/tools/power/cpupower/utils/helpers/amd.c b/tools/power/cpupower/utils/helpers/amd.c
> index 4d45d1b44164..f5ba528dc7db 100644
> --- a/tools/power/cpupower/utils/helpers/amd.c
> +++ b/tools/power/cpupower/utils/helpers/amd.c
> @@ -175,5 +175,23 @@ static unsigned long amd_pstate_get_data(unsigned int cpu,
>   						  MAX_AMD_PSTATE_VALUE_READ_FILES);
>   }
>   
> +void amd_pstate_boost_init(unsigned int cpu, int *support, int *active)
> +{
> +	unsigned long highest_perf, nominal_perf, cpuinfo_min,
> +		      cpuinfo_max, amd_pstate_max;
> +
> +	highest_perf = amd_pstate_get_data(cpu, AMD_PSTATE_HIGHEST_PERF);
> +	nominal_perf = acpi_cppc_get_data(cpu, NOMINAL_PERF);
> +
> +	*support = highest_perf > nominal_perf ? 1 : 0;
> +	if (!(*support))
> +		return;
> +
> +	cpufreq_get_hardware_limits(cpu, &cpuinfo_min, &cpuinfo_max);
> +	amd_pstate_max = amd_pstate_get_data(cpu, AMD_PSTATE_MAX_FREQ);
> +
> +	*active = cpuinfo_max == amd_pstate_max ? 1 : 0;
> +}
> +
>   /* AMD P-State Helper Functions ************************************/
>   #endif /* defined(__i386__) || defined(__x86_64__) */
> diff --git a/tools/power/cpupower/utils/helpers/helpers.h b/tools/power/cpupower/utils/helpers/helpers.h
> index 557524078e94..f142fbfa4a77 100644
> --- a/tools/power/cpupower/utils/helpers/helpers.h
> +++ b/tools/power/cpupower/utils/helpers/helpers.h
> @@ -140,6 +140,8 @@ extern int cpufreq_has_boost_support(unsigned int cpu, int *support,
>   
>   /* AMD P-State stuff **************************/
>   extern bool cpupower_amd_pstate_enabled(void);
> +extern void amd_pstate_boost_init(unsigned int cpu,
> +				  int *support, int *active);
>   
>   /* AMD P-State stuff **************************/
>   
> @@ -177,6 +179,9 @@ static inline int cpufreq_has_boost_support(unsigned int cpu, int *support,
>   
>   static inline bool cpupower_amd_pstate_enabled(void)
>   { return false; }
> +static void amd_pstate_boost_init(unsigned int cpu,
> +				  int *support, int *active)
> +{ return; }

No need for a return here

>   
>   /* cpuid and cpuinfo helpers  **************************/
>   
> diff --git a/tools/power/cpupower/utils/helpers/misc.c b/tools/power/cpupower/utils/helpers/misc.c
> index 0c483cdefcc2..e0d3145434d3 100644
> --- a/tools/power/cpupower/utils/helpers/misc.c
> +++ b/tools/power/cpupower/utils/helpers/misc.c
> @@ -41,6 +41,8 @@ int cpufreq_has_boost_support(unsigned int cpu, int *support, int *active,
>   			if (ret)
>   				return ret;
>   		}
> +	} else if (cpupower_cpu_info.caps & CPUPOWER_CAP_AMD_PSTATE) {
> +		amd_pstate_boost_init(cpu, support, active);
>   	} else if (cpupower_cpu_info.caps & CPUPOWER_CAP_INTEL_IDA)
>   		*support = *active = 1;
>   	return 0;
> 

thanks,
-- Shuah
