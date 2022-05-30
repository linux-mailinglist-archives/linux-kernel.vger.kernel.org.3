Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E47A537A3A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 13:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235981AbiE3L4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 07:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235985AbiE3Lz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 07:55:58 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4597B6FD38;
        Mon, 30 May 2022 04:55:57 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LBYkM0bBlzjX8N;
        Mon, 30 May 2022 19:55:07 +0800 (CST)
Received: from [10.67.77.175] (10.67.77.175) by dggpeml500023.china.huawei.com
 (7.185.36.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 30 May
 2022 19:55:55 +0800
Subject: Re: [PATCH -next v2 1/1] cpufreq: CPPC: Fix unused-function warning
To:     Pierre Gondois <pierre.gondois@arm.com>,
        <linux-kernel@vger.kernel.org>
CC:     <Ionela.Voinescu@arm.com>, <Dietmar.Eggemann@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        <linux-pm@vger.kernel.org>
References: <20220530100424.103301-1-pierre.gondois@arm.com>
 <20220530100424.103301-2-pierre.gondois@arm.com>
From:   Shaokun Zhang <zhangshaokun@hisilicon.com>
Message-ID: <f2b9386a-16dd-bd03-4972-aaa026f72c03@hisilicon.com>
Date:   Mon, 30 May 2022 19:55:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220530100424.103301-2-pierre.gondois@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.77.175]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

It works for me on compile when CONFIG_ENERGY_MODEL=n, please feel free to add:
Tested-by: Shaokun Zhang <zhangshaokun@hisilicon.com>

Thanks,
Shaokun

On 2022/5/30 18:04, Pierre Gondois wrote:
> Building the cppc_cpufreq driver with for arm64 with
> CONFIG_ENERGY_MODEL=n triggers the following warnings:
>  drivers/cpufreq/cppc_cpufreq.c:550:12: error: ‘cppc_get_cpu_cost’ defined but not used
> [-Werror=unused-function]
>    550 | static int cppc_get_cpu_cost(struct device *cpu_dev, unsigned long KHz,
>        |            ^~~~~~~~~~~~~~~~~
>  drivers/cpufreq/cppc_cpufreq.c:481:12: error: ‘cppc_get_cpu_power’ defined but not used
> [-Werror=unused-function]
>    481 | static int cppc_get_cpu_power(struct device *cpu_dev,
>        |            ^~~~~~~~~~~~~~~~~~
> 
> Move the Energy Model related functions into specific guards.
> This allows to fix the warning and prevent doing extra work
> when the Energy Model is not present.
> 
> Fixes: 740fcdc2c20e ("cpufreq: CPPC: Register EM based on efficiency class information")
> Reported-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index f0a8bb2c59e5..24eaf0ec344d 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -441,6 +441,14 @@ static unsigned int cppc_cpufreq_get_transition_delay_us(unsigned int cpu)
>  	}
>  	return cppc_get_transition_latency(cpu) / NSEC_PER_USEC;
>  }
> +#else
> +static unsigned int cppc_cpufreq_get_transition_delay_us(unsigned int cpu)
> +{
> +	return cppc_get_transition_latency(cpu) / NSEC_PER_USEC;
> +}
> +#endif
> +
> +#if defined(CONFIG_ARM64) && defined(CONFIG_ENERGY_MODEL)
>  
>  static DEFINE_PER_CPU(unsigned int, efficiency_class);
>  static void cppc_cpufreq_register_em(struct cpufreq_policy *policy);
> @@ -621,21 +629,12 @@ static void cppc_cpufreq_register_em(struct cpufreq_policy *policy)
>  }
>  
>  #else
> -
> -static unsigned int cppc_cpufreq_get_transition_delay_us(unsigned int cpu)
> -{
> -	return cppc_get_transition_latency(cpu) / NSEC_PER_USEC;
> -}
>  static int populate_efficiency_class(void)
>  {
>  	return 0;
>  }
> -static void cppc_cpufreq_register_em(struct cpufreq_policy *policy)
> -{
> -}
>  #endif
>  
> -
>  static struct cppc_cpudata *cppc_cpufreq_get_cpu_data(unsigned int cpu)
>  {
>  	struct cppc_cpudata *cpu_data;
> 
