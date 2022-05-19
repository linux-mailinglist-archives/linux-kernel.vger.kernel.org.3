Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F52252DDB6
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 21:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244528AbiESTWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 15:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244468AbiESTWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 15:22:13 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B946A063
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 12:21:55 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id r27so6800038iot.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 12:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nj+QqHclxUIqJDH12ZbmYOuUJ7MLUZBfcDbT0ZurC6A=;
        b=RV3Qj5QqIqAPU2EriXPFEahyIhE7qT7HCRIPKUm8O/731OS5eZFILrdI4fXpPaXtOQ
         p4S+KZWogys3AQIDCZWSJXEpwdXVD7WJ+v9/SijWMhQhfrTzWBk2dCcjmFZ1rmXpG0A0
         4ZGq+wcwcVAmcs9AU60tnIawPIriX1m8HE1Z4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nj+QqHclxUIqJDH12ZbmYOuUJ7MLUZBfcDbT0ZurC6A=;
        b=B9hInETbeV8A5nmKYV3xT1qmW7QA3zo5/X80yGfHitUBObXRC1UQeKs+Eg5B9wOT+a
         gPpzbNnHV+Nwsef22HCv3O/RvJ++/x6wYM4O8GmofaoGQ1ruNfwUNT9ZFv6ONc3QZc7t
         UmbAyfKsI0te7RveDoqBSsRirOiSJ3TAL2oPX1jNBkrKiBcIIJGoBGAYxOSuN5zF/GWf
         cSclNFgC+rkETy5BBwdiYVQd7+9CZv9eq05vwiFOxh+6THIm5PKZniv8RQHDoPRfeggb
         7jpDGARQt5F9ngeafRZsMoC6ivC/40gAaECP/F6uUdBTZV4U4HeOIESTLfIOXGLoQRA0
         tjlg==
X-Gm-Message-State: AOAM531eJ3IpAhVa/C7qTVzgjRETCjKRxLT855yEb5ONv6aoYxxggrff
        rIs3moCi0EHTKVS4IiHHdYLy1A==
X-Google-Smtp-Source: ABdhPJxxWB+DQtWoeLRjEZZECX11LDvTCuFnq1VfzayEuFudrk4HaGoeemi46yKk7Kj4PzDJmjHBpg==
X-Received: by 2002:a02:9984:0:b0:32d:aeff:c592 with SMTP id a4-20020a029984000000b0032daeffc592mr3518394jal.46.1652988114561;
        Thu, 19 May 2022 12:21:54 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id w69-20020a025d48000000b0032b3a781751sm125970jaa.21.2022.05.19.12.21.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 May 2022 12:21:54 -0700 (PDT)
Subject: Re: [PATCH V6 2/4] cpufreq: amd-pstate: Add test module for
 amd-pstate driver
To:     Meng Li <li.meng@amd.com>, Huang Rui <ray.huang@amd.com>,
        linux-pm@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Jinzhou Su <Jinzhou.Su@amd.com>,
        Perry Yuan <Perry.Yuan@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220519134737.359290-1-li.meng@amd.com>
 <20220519134737.359290-3-li.meng@amd.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <79a43bff-f3ce-43f5-6959-ae8bcb747a77@linuxfoundation.org>
Date:   Thu, 19 May 2022 13:21:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220519134737.359290-3-li.meng@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/19/22 7:47 AM, Meng Li wrote:
> Add amd-pstate-ut module, which is conceptually out-of-tree module
> and provides ways for selftests/amd-pstate driver to test various
> kernel module-related functionality. This module will be expected by
> some of selftests to be present and loaded.
> 
> Signed-off-by: Meng Li <li.meng@amd.com>
> Acked-by: Huang Rui <ray.huang@amd.com>
> ---
>   drivers/cpufreq/Kconfig.x86     |   6 +
>   drivers/cpufreq/Makefile        |   1 +
>   drivers/cpufreq/amd-pstate-ut.c | 278 ++++++++++++++++++++++++++++++++
>   3 files changed, 285 insertions(+)
>   create mode 100644 drivers/cpufreq/amd-pstate-ut.c
> 
> diff --git a/drivers/cpufreq/Kconfig.x86 b/drivers/cpufreq/Kconfig.x86
> index 55516043b656..37ba282cd156 100644
> --- a/drivers/cpufreq/Kconfig.x86
> +++ b/drivers/cpufreq/Kconfig.x86
> @@ -51,6 +51,12 @@ config X86_AMD_PSTATE
>   
>   	  If in doubt, say N.
>   
> +config X86_AMD_PSTATE_UT
> +	tristate "selftest for AMD Processor P-State driver"
> +	depends on X86_AMD_PSTATE

Please specify default value

> +	help
> +	  This kernel module is used for testing. It's safe to say M here.
> +
>   config X86_ACPI_CPUFREQ
>   	tristate "ACPI Processor P-States driver"
>   	depends on ACPI_PROCESSOR
> diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
> index 285de70af877..49b98c62c5af 100644
> --- a/drivers/cpufreq/Makefile
> +++ b/drivers/cpufreq/Makefile
> @@ -30,6 +30,7 @@ amd_pstate-y				:= amd-pstate.o amd-pstate-trace.o
>   
>   obj-$(CONFIG_X86_ACPI_CPUFREQ)		+= acpi-cpufreq.o
>   obj-$(CONFIG_X86_AMD_PSTATE)		+= amd_pstate.o
> +obj-$(CONFIG_X86_AMD_PSTATE_UT)		+= amd-pstate-ut.o
>   obj-$(CONFIG_X86_POWERNOW_K8)		+= powernow-k8.o
>   obj-$(CONFIG_X86_PCC_CPUFREQ)		+= pcc-cpufreq.o
>   obj-$(CONFIG_X86_POWERNOW_K6)		+= powernow-k6.o
> diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
> new file mode 100644
> index 000000000000..a510355b804e
> --- /dev/null
> +++ b/drivers/cpufreq/amd-pstate-ut.c
> @@ -0,0 +1,278 @@
> +// SPDX-License-Identifier: GPL-1.0-or-later
> +/*
> + * AMD Processor P-state Frequency Driver Unit Test
> + *
> + * Copyright (C) 2022 Advanced Micro Devices, Inc. All Rights Reserved.
> + *
> + * Author: Meng Li <li.meng@amd.com>
> + *
> + * The AMD P-State Unit Test is a test module for testing the amd-pstate
> + * driver. 1) It can help all users to verify their processor support
> + * (SBIOS/Firmware or Hardware). 2) Kernel can have a basic function
> + * test to avoid the kernel regression during the update. 3) We can
> + * introduce more functional or performance tests to align the result
> + * together, it will benefit power and performance scale optimization.
> + *
> + * At present, it only implements the basic framework and some simple
> + * test cases. Next, 1) we will add a rst document. 2) we will add more
> + * test cases to improve the depth and coverage of the test.
> + */
> +

Rephrase this to say:

This driver implements basic framework with plnas to enhance it with additional
test cases to improve the depth and coverage of the test.

Also you have the .rst in this patch series? Does the documentation comment
still valid?

> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include "../tools/testing/selftests/kselftest_module.h"

Remove this header include

> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/moduleparam.h>
> +#include <linux/fs.h>
> +#include <linux/amd-pstate.h>
> +
> +#include <acpi/cppc_acpi.h>
> +
> +/*
> + * Abbreviations:
> + * aput: used as a shortform for AMD P-State unit test.
> + * It helps to keep variable names smaller, simpler
> + */
> +
> +KSTM_MODULE_GLOBALS();
> +
> +/*
> + * Kernel module for testing the AMD P-State unit test
> + */
> +enum aput_result {

Is "aput" short for amd_pstate_unit_test? Change "aput" to
amd_pstate_ut instead. aput is rather confusing.

Same comment file wide on all function names and structure names.


> +	APUT_RESULT_PASS,
> +	APUT_RESULT_FAIL,
> +	MAX_APUT_RESULT,
> +};
> +
> +struct aput_struct {
> +	const char *name;
> +	void (*func)(u32 index);
> +	enum aput_result result;
> +};
> +
> +static void aput_acpi_cpc(u32 index);
> +static void aput_check_enabled(u32 index);
> +static void aput_check_perf(u32 index);
> +static void aput_check_freq(u32 index);
> +
> +static struct aput_struct aput_cases[] = {
> +	{"acpi_cpc_valid",   aput_acpi_cpc         },
> +	{"check_enabled",    aput_check_enabled    },
> +	{"check_perf",       aput_check_perf       },
> +	{"check_freq",       aput_check_freq       }
> +};

Add prefixes to these strings - amd_pstate_ut for example - it will
be easier for users to parse the test output.

> +
> +static bool get_shared_mem(void)
> +{
> +	bool result = false;
> +	char buf[5] = {0};
> +	struct file *filp = NULL;
> +	loff_t pos = 0;
> +	ssize_t ret;
> +
> +	if (!boot_cpu_has(X86_FEATURE_CPPC)) {
> +		filp = filp_open("/sys/module/amd_pstate/parameters/shared_mem", FMODE_PREAD, 0);

Please add a define for this file and print this in error messages below.
  
> +		if (IS_ERR(filp))
> +			pr_err("%s Open param file fail!\n", __func__);

Add filename to the error message.

> +		else {
> +			ret = kernel_read(filp, &buf, sizeof(buf), &pos);
> +			if (ret < 0)
> +				pr_err("%s ret=%ld unable to read from param file!\n",
> +					__func__, ret);

Same here.

> +			filp_close(filp, NULL);
> +		}
> +
> +		if ('Y' == *buf)
> +			result = true;
> +	}
> +
> +	return result;
> +}
> +
> +static void aput_acpi_cpc(u32 index)

What does cpc stand for? Make the name descriptive to it is easeir to
understand. Add a comment to say what this does.


> +{
> +	if (acpi_cpc_valid())
> +		aput_cases[index].result = APUT_RESULT_PASS;
> +	else
> +		aput_cases[index].result = APUT_RESULT_FAIL;
> +}
> +
> +static void aput_pstate_enable(u32 index)
> +{
> +	int ret = 0;
> +	u64 cppc_enable = 0;
> +
> +	ret = rdmsrl_safe(MSR_AMD_CPPC_ENABLE, &cppc_enable);
> +	if (ret) {
> +		aput_cases[index].result = APUT_RESULT_FAIL;
> +		pr_err("%s rdmsrl_safe MSR_AMD_CPPC_ENABLE ret=%d is error!\n", __func__, ret);

Make this message to say what failed - did pstate enable fail?
Just say that.  "is" isn't necessary in this setence

> +		return;
> +	}
> +	if (cppc_enable)
> +		aput_cases[index].result = APUT_RESULT_PASS;
> +	else
> +		aput_cases[index].result = APUT_RESULT_FAIL;
> +}
> +
> +/*
> + *Check if enabled amd pstate

Change this to "check if amd pstate is enabled"

> + */
> +static void aput_check_enabled(u32 index)
> +{
> +	if (get_shared_mem())
> +		aput_cases[index].result = APUT_RESULT_PASS;
> +	else
> +		aput_pstate_enable(index);
> +}
> +
> +/*
> + * Check if the each performance values are reasonable.

Check if performance values are reasonable

> + * highest_perf >= nominal_perf > lowest_nonlinear_perf > lowest_perf > 0
> + */
> +static void aput_check_perf(u32 index)
> +{
> +	int cpu = 0, ret = 0;
> +	u32 highest_perf = 0, nominal_perf = 0, lowest_nonlinear_perf = 0, lowest_perf = 0;
> +	u64 cap1 = 0;
> +	struct cppc_perf_caps cppc_perf;
> +	struct cpufreq_policy *policy = NULL;
> +	struct amd_cpudata *cpudata = NULL;
> +
> +	highest_perf = amd_get_highest_perf();
> +
> +	for_each_possible_cpu(cpu) {
> +		policy = cpufreq_cpu_get(cpu);
> +		if (!policy)
> +			break;
> +		cpudata = policy->driver_data;
> +
> +		if (get_shared_mem()) {
> +			ret = cppc_get_perf_caps(cpu, &cppc_perf);
> +			if (ret) {
> +				aput_cases[index].result = APUT_RESULT_FAIL;
> +				pr_err("%s cppc_get_perf_caps ret=%d is error!\n", __func__, ret);

Same here - say what failed - the return value is relevant, but does't give
the right information. "is" isn't necessary in this setence

> +				return;
> +			}
> +
> +			nominal_perf = cppc_perf.nominal_perf;
> +			lowest_nonlinear_perf = cppc_perf.lowest_nonlinear_perf;
> +			lowest_perf = cppc_perf.lowest_perf;
> +		} else {
> +			ret = rdmsrl_safe_on_cpu(cpu, MSR_AMD_CPPC_CAP1, &cap1);
> +			if (ret) {
> +				aput_cases[index].result = APUT_RESULT_FAIL;
> +				pr_err("%s read CPPC_CAP1 ret=%d is error!\n", __func__, ret);

Same here - "is" isn't necessary in this setence

> +				return;
> +			}
> +
> +			nominal_perf = AMD_CPPC_NOMINAL_PERF(cap1);
> +			lowest_nonlinear_perf = AMD_CPPC_LOWNONLIN_PERF(cap1);
> +			lowest_perf = AMD_CPPC_LOWEST_PERF(cap1);
> +		}
> +
> +		if ((highest_perf != READ_ONCE(cpudata->highest_perf)) ||
> +			(nominal_perf != READ_ONCE(cpudata->nominal_perf)) ||
> +			(lowest_nonlinear_perf != READ_ONCE(cpudata->lowest_nonlinear_perf)) ||
> +			(lowest_perf != READ_ONCE(cpudata->lowest_perf))) {
> +			aput_cases[index].result = APUT_RESULT_FAIL;
> +			pr_err("%s cpu%d highest=%d %d nominal=%d %d lowest_nonlinear=%d %d lowest=%d %d are not equal!\n",
> +				__func__, cpu, highest_perf, cpudata->highest_perf,
> +				nominal_perf, cpudata->nominal_perf,
> +				lowest_nonlinear_perf, cpudata->lowest_nonlinear_perf,
> +				lowest_perf, cpudata->lowest_perf);

Okay - are we testing for these to be equal. Say that in the message that they
should be equal.

> +			return;
> +		}
> +
> +		if (!((highest_perf >= nominal_perf) &&
> +			(nominal_perf > lowest_nonlinear_perf) &&
> +			(lowest_nonlinear_perf > lowest_perf) &&
> +			(lowest_perf > 0))) {
> +			aput_cases[index].result = APUT_RESULT_FAIL;
> +			pr_err("%s cpu%d highest=%d nominal=%d lowest_nonlinear=%d lowest=%d have error!\n",
> +				__func__, cpu, highest_perf, nominal_perf,
> +				lowest_nonlinear_perf, lowest_perf);

What does this tell user - what does "have error" mean?

> +			return;
> +		}
> +	}
> +
> +	aput_cases[index].result = APUT_RESULT_PASS;
> +}
> +
> +/*
> + * Check if the each frequency values are reasonable.
> + * max_freq >= nominal_freq > lowest_nonlinear_freq > min_freq > 0
> + * check max freq when set support boost mode.
> + */
> +static void aput_check_freq(u32 index)
> +{
> +	int cpu = 0;
> +	struct cpufreq_policy *policy = NULL;
> +	struct amd_cpudata *cpudata = NULL;
> +
> +	for_each_possible_cpu(cpu) {
> +		policy = cpufreq_cpu_get(cpu);
> +		if (!policy)
> +			break;
> +		cpudata = policy->driver_data;
> +
> +		if (!((cpudata->max_freq >= cpudata->nominal_freq) &&
> +			(cpudata->nominal_freq > cpudata->lowest_nonlinear_freq) &&
> +			(cpudata->lowest_nonlinear_freq > cpudata->min_freq) &&
> +			(cpudata->min_freq > 0))) {
> +			aput_cases[index].result = APUT_RESULT_FAIL;
> +			pr_err("%s cpu%d max=%d nominal=%d lowest_nonlinear=%d min=%d have error!\n",
> +				__func__, cpu, cpudata->max_freq, cpudata->nominal_freq,
> +				cpudata->lowest_nonlinear_freq, cpudata->min_freq);

Same comment as above about the clearity of the error message - what does
"have error" mean

> +			return;
> +		}
> +
> +		if (cpudata->min_freq != policy->min) {
> +			aput_cases[index].result = APUT_RESULT_FAIL;
> +			pr_err("%s cpu%d cpudata_min_freq=%d policy_min=%d have error!\n",
> +				__func__, cpu, cpudata->min_freq, policy->min);

Same as above.

> +			return;
> +		}
> +
> +		if (cpudata->boost_supported) {
> +			if ((policy->max == cpudata->max_freq) ||
> +					(policy->max == cpudata->nominal_freq))
> +				aput_cases[index].result = APUT_RESULT_PASS;
> +			else {
> +				aput_cases[index].result = APUT_RESULT_FAIL;
> +				pr_err("%s cpu%d policy_max=%d cpu_max=%d cpu_nominal=%d have error!\n",
> +					__func__, cpu, policy->max, cpudata->max_freq,
> +					cpudata->nominal_freq);
> +				return;
> +			}
> +		} else {
> +			aput_cases[index].result = APUT_RESULT_FAIL;
> +			pr_err("%s cpu%d not support boost!\n", __func__, cpu);

cpu doesn't support boost?

> +			return;
> +		}
> +	}
> +}
> +
> +static void aput_do_test_case(void)
> +{
> +	u32 i = 0, arr_size = ARRAY_SIZE(aput_cases);
> +
> +	for (i = 0; i < arr_size; i++) {
> +		pr_info("****** Begin %-5d\t %-20s\t ******\n", i+1, aput_cases[i].name);

This is where adding prefix helps improving the test report.

> +		aput_cases[i].func(i);
> +		KSTM_CHECK_ZERO(aput_cases[i].result);
> +		pr_info("****** End   %-5d\t %-20s\t ******\n", i+1, aput_cases[i].name);

This is where adding prefix helps improving the test report.

> +	}
> +}
> +
> +static void __init selftest(void)

Change this to amd_pstate_ut_selftest

> +{
> +	aput_do_test_case();
> +}
> +
> +KSTM_MODULE_LOADERS(amd_pstate_ut);
> +MODULE_AUTHOR("Meng Li <li.meng@amd.com>");
> +MODULE_DESCRIPTION("Unit test for AMD P-state driver");
> +MODULE_LICENSE("GPL");
> 

thanks,
-- Shuah
