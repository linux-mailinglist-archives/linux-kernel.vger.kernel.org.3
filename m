Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89C10570AB3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 21:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbiGKT05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 15:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiGKT0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 15:26:54 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BDFC61702;
        Mon, 11 Jul 2022 12:26:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IgmmH3bozrOA7jG3LkL7D3DACl5IZMUN869CDcUjuhDTVtH43UXMEG9aQTKiSH/oDxMAresy0GF1uK3HKMENNFauitQF8Nr1v9zvZ390CCHICJmM5Kd/uJuTWlcy/mzOTLi6u0uuEIK8HC5ELyyA9T1QXOnARRksCu5l476PkwsdhsjpF2lngHOZuctsVyDTpQ40sIcu0sNKnFvoO2C61fUVY9RHuTZf4C1BCO2zvaniLezg5FEEBlwWj5eSU45qiPBU4yeh6fiq25LKEt+nltq1TcD6t1o9ezK31SvNA0zU8db/v4/gyrto8zaXFx+B1GQNFi4Nc5m3eloI6/qfkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=otQEszU0Bsr56bO2jvY0ce1EvSnPwWJYmYGCNbgi1EQ=;
 b=fFrFMmUAE1+bnSYQXJuAI1H8fT3pTb7CfpKhE02HguMIXMB9k8tz9aZ2LLjWxpVjTekUUUojpbhV8J5Neo6HvdtpBa+zIlHjPaMjTkjB8qZyG54K3T0I0cHtBDlZ5sX/Y67AFE8lLeULZvSe1JwYtg7VKa0tFnSzY5wkrPQR5aanA6n+D0ABWymCTDlRPx46tobzWPO35zdxnoTt0vwn8gz0R4aAii+xRwLRYr4ulNPJRtdsSCaffxycMgd68gDKuQzQLil+XiqcrHBZTVxCbPAabWqWOBkK3AcfuMSdQubKZ6CVmcveOA1VTrPotuEIqdIZynrJsT345vBO8unCzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=otQEszU0Bsr56bO2jvY0ce1EvSnPwWJYmYGCNbgi1EQ=;
 b=Ufo93Qp77jU1mxgEfHOAzbEeyIFBdT0RvED56BFH1Ug0ROiNl7BtRHtPsNi/Etaiex7WtzmhGXK2Fhqvg4n33mXx0TbyxDo//0vDP8hg2j8pW7yzhzufKBYP0Z1BfiIfUZwnHjQZQnRqxzgb2kBKu0N6CSaZdVnk+K1/3ccBcaA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6222.namprd12.prod.outlook.com (2603:10b6:208:3c2::19)
 by DM4PR12MB6446.namprd12.prod.outlook.com (2603:10b6:8:be::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.25; Mon, 11 Jul 2022 19:26:51 +0000
Received: from MN0PR12MB6222.namprd12.prod.outlook.com
 ([fe80::ec96:60a2:ca21:17d1]) by MN0PR12MB6222.namprd12.prod.outlook.com
 ([fe80::ec96:60a2:ca21:17d1%3]) with mapi id 15.20.5417.026; Mon, 11 Jul 2022
 19:26:51 +0000
Message-ID: <39717316-281a-6c3a-4228-54210e5320dd@amd.com>
Date:   Mon, 11 Jul 2022 14:26:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 02/14] cpufreq: amd-pstate: enable AMD Precision Boost
 mode switch
Content-Language: en-US
To:     Perry Yuan <Perry.Yuan@amd.com>, rafael.j.wysocki@intel.com,
        viresh.kumar@linaro.org, Ray.Huang@amd.com
Cc:     Deepak.Sharma@amd.com, Mario.Limonciello@amd.com,
        Nathan.Fontenot@amd.com, Alexander.Deucher@amd.com,
        Jinzhou.Su@amd.com, Xinmei.Huang@amd.com, Xiaojian.Du@amd.com,
        Li.Meng@amd.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220709141739.834950-1-Perry.Yuan@amd.com>
From:   Nathan Fontenot <nafonten@amd.com>
In-Reply-To: <20220709141739.834950-1-Perry.Yuan@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR01CA0004.prod.exchangelabs.com (2603:10b6:208:71::17)
 To MN0PR12MB6222.namprd12.prod.outlook.com (2603:10b6:208:3c2::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 424f2e51-9635-4b9b-d2f5-08da63734e77
X-MS-TrafficTypeDiagnostic: DM4PR12MB6446:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1z594iBLRIGhajSQTdiNQyohUyCfM+uKVfsxP3G7hP0jPKsHJq4ycr3Of0AASsXe/r89WL/UhMrtcieEC4xwBjvi1JQ3raiSoV5fGd8DyZN1cCIijK44tc0uMNwjCBOWr6wXkdkScnQD3yBc3Drol4MXd5azfTju0O/La7zgsAWx4C334beorBXqxDCb8/lDMeof1dBctRd4yylY2n6UBhBKVGyWbsABjHskQPd/13Xe0RufRafUIJMlJzb5AAMeBAqwYZeIz0/avAZ9BjbMh1zTbNZ8ZD5cMSRlISZy5nL7JHuVz9gwPC9/xEAhGPemHjs/4ledlrh75cSD4HyG7v3oRSwZvfU3T02S+XJ7Qdi9iKibiiE0amxFXeEVfZoc0A/kP/ionMT/qyrfYaQEUGvv2nEl5a4v0v2UYMfiXE7ZXtR6UcIelDVtTvI+N68xiZKXgX0tlOn6vqFLlREaXkW9OJtveMMNYz0oaxqqvIhFyUhlNW9Il8SgLyPGdfJRsAZA9BDgxRdhhBCxH+2YSfEuwkUYmE/IbJJGE5984eXhJngigD8sO2Kp9T/gUOxYJpR7OqAUVUGRlRiOaBd6eO0S8xjISvXbdFtRrRf10/6IvpIPkEjzmJBt5PPzPnDEcXc3cahKPCrjH5oMT+n5C7ErybHySwlLjS1k6trH1PMuvB+RJUMjhVXlt6c/q3sKY6qumY00DhwRkcCg9dCFQN7K2nu/+KB/rIFgL0RyNMPnDoMGxGz0mqtgNJ09KuISSTMwqoaTCw+6fpZpYTW6ko/0iW/AkhxoaWhifozlFRXzkCu2f1sVgqSGlPieH9YjWgvJIDrdzOV5lnGqcCFMZZsY02SODs52I8AU1rVBYu4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6222.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(39860400002)(346002)(396003)(136003)(366004)(66556008)(6512007)(5660300002)(8676002)(6666004)(66476007)(4326008)(66946007)(186003)(41300700001)(83380400001)(478600001)(6636002)(8936002)(36756003)(31696002)(2616005)(316002)(38100700002)(53546011)(2906002)(6506007)(6486002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SkZybjlkTUJ4VlZVb21GU1ZUR0RUNWtsM3BRR0dnV1oyeWVxSEtEZnpheU9V?=
 =?utf-8?B?d1paMDZSbHF2VlhxcTRySUpkRDBReE5ybXc3N3ZBUVM0Y2lUTnlSM0pHSUQw?=
 =?utf-8?B?ZnhJRnRHMVRSd2d5WjYzR2twZkxiVytDSGMzdWlxN21xK3lXQ3BrK3NPS29J?=
 =?utf-8?B?RTV3bFBtZkF4MmJIaW5wOHRUeXIzMEhyQ1JsNHhVQzdVV0dlcE12eThWWktV?=
 =?utf-8?B?M2ZTRnZ5a3lhRzd5SDdJelhSOG5WckVBd2hGQzZEbzI4TExJaTBOT2R6TjlV?=
 =?utf-8?B?SEZwTzJWdmZyeHFOd0xmT3Q5MUJEd0xQRmxzaHpWaEV6Y3I5c3VMbVRzUWRM?=
 =?utf-8?B?MWJNMWEydmlqUWZiZzdKQUFlMG42VW9SN1E5dklHUTFxNjVEcVBRT0E3dmdR?=
 =?utf-8?B?YVI1c3BXYkpkc2cybVRaZnEyYTMrVEQ5bzlTOUtkeXU0U1NxUkorRGhnQThv?=
 =?utf-8?B?NkJUWTh2Vkg2NlVCejdkTWI0THlQeSs5TEwvdUsxYjlEa3BVRnNpL1Z6T21L?=
 =?utf-8?B?N0tnM3RtUGd3UmNXL2Q2MGlwNThycjJ5ZXhuYWFsdlorUllEeFNuRUxrbWNz?=
 =?utf-8?B?d0J5S1REa3p0UnpwSENqVkpWTDl1UmN6SjA1cmV4dkNwYnQyb1lnM2I5cGZp?=
 =?utf-8?B?QnRNa1pyU3JVTkFGYjdudGN6YytPd08wMys4RDJaaWQwVitldWY1MmVEUTdY?=
 =?utf-8?B?N0ZjSldwQUJobHdqRHhFUytLejJNZi9PU3pwdENnQjBDUFhZY01xVW5MdGpQ?=
 =?utf-8?B?THpMOFJmamtpRjQ3WXlaYWJzWXJxdzNLSEMyV2xEbHo4cGxmTk1DOUpFdy9o?=
 =?utf-8?B?WlYrbWtQL0NCZWowYUdRTnRwYVFYZEFJNTEweVpoUi95MlV0T1djbmFKQ3E1?=
 =?utf-8?B?RXhENmtZb3FuWlpKVFVWdEY5N0w1YTF6Q25lMGdvL1dJYis0bUJyVlNHcWYw?=
 =?utf-8?B?Q0pzYllkWGhLMDFtNlRqbjhad092SVdCWmcvR2pJL3ZlSlBjNU9Gd0lqMXh0?=
 =?utf-8?B?UmgvWDlXT1kvaUYvUmlweTN3VDQ1bWVtcmVTRnB2MUs5eUdNQ0xnYXR4V2w1?=
 =?utf-8?B?T2x5aWVPM2FWNVZ2MFc5Y2xpcStLeEN4NmVCcFdsWDd1TnQ1alpBMG82MExS?=
 =?utf-8?B?R2tXeURVNDduZktVZWovSDJKdkJtNHJsMHBiRW1wOFdsQ081ZUlYMlJpbHZ6?=
 =?utf-8?B?VGlhcGRFazh1UEZoN3JHWVd6bDJCdXpMUkpGdmhiNnd4YnZhYUxEZkN0U0pF?=
 =?utf-8?B?MVNPQU01aWJXWlZ3bm0zTnIyK05TZzkxZGh6elZ5aURGYWlYMG9TT0FyMWtZ?=
 =?utf-8?B?dHBMQWswMS95OXA4Sk5UUHdFNzVpZHlvcmE2eEhWQUJJa0Z6Vmlra3AvbEtp?=
 =?utf-8?B?cVQ0R2RPamV0cWNIYUVlRVVCS1Q3S09tREdnK3FYVys3dCtpcGpKNFc2U08r?=
 =?utf-8?B?eTNvTVVheVF5ODBoVXNmUW5FN29YNzNHQU9sRXVjcmpEOE1jeTZaV1BXZjZF?=
 =?utf-8?B?MHBrcUh2V3lqM1EzMUVJT0QrVDR2dGFyK2RFajZPejBrZUE3anIzZnlsb3ow?=
 =?utf-8?B?eXhGbWdSc0M3elE4VzBZN0ZKajloOTh5Qis0MFE4a0FudDM3dmcvcDRHSmt1?=
 =?utf-8?B?SjZsZzhxOG5iZzJxZnRncFhDcW1RTnd3a0VTT0dyNTZROEorWUVSdkd0b2Iz?=
 =?utf-8?B?UnlQY3oxdnlrcmlUN2ZpTEI2VGpDSVFqelJzOGEzVEZEdGJaaFJBV2U2aW9H?=
 =?utf-8?B?ZWQ3S1Y1d1NvaXZJOVlJR2VKNnFnS2o2dVJGdHcrbVZqVlF3SE1hQ24yQWxO?=
 =?utf-8?B?U3orRXd2MzRZNVNaem5ubFgxZ2VsYytSMGE1VVpMNFlQaVZxQ1lPMXNvaGtp?=
 =?utf-8?B?UlYwUmRxY1lJVmdZZFdKd0xZa1RkRXkzMWszNzIrUUtjYkwwZkRvTmwvMG9D?=
 =?utf-8?B?VTVEbkpVYllSVk9Fckw0Y3FIOHpncTM3cFZZUnYwLzVqbVhZUjB1L2YwQ0xa?=
 =?utf-8?B?M2FVZ0NpRmVTdThDU1dIeTBhaVIyeGd3ZVRIMjFNSjlRVk44eXQvemwvYnVr?=
 =?utf-8?B?S09GMndCbXNRK3ROY2J4SmRyOWF0UzJBc2N3NWFZQ2RrUEFzd0VTSStWZWtq?=
 =?utf-8?B?L2N0QnM2UVZRSmZTMkVYZFVTU3d6K3dneDlQdzF1NlJ3S2Uwc3REcituYWdU?=
 =?utf-8?Q?/hcDTzeXVCLr60Dogq9LQk/zao0UyD7+KbS7QrOjWRSz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 424f2e51-9635-4b9b-d2f5-08da63734e77
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6222.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2022 19:26:51.7085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wcjlEv1huVr28mLWBn1rgTdSff/Yj/kJqmjJbR4WZO1SjD6cYgCVEVjjeby9gdrrelwadu1FQhsq0RP0eJIr+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6446
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/9/22 09:17, Perry Yuan wrote:
> Add support to switch AMD precision boost state to scale cpu max
> frequency that will help to improve the processor throughput.
> 
> when set boost state to be enabled, user will need to execute below commands,
> the CPU will reach absolute maximum performance level or the highest perf which
> CPU physical support. This performance level may not be sustainable for
> long durations, it will help to improve the IO workload tasks.
> 
> * turn on CPU boost state under root
>   echo 1 > /sys/devices/system/cpu/cpufreq/boost
> 
> If user set boost off,the CPU can reach to the maximum sustained
> performance level of the process, that level is the process can maintain
> continously working and definitely it can save some power compared to
> boost on mode.
> 
> * turn off CPU boost state under root
>   echo 0 > /sys/devices/system/cpu/cpufreq/boost
> 
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> ---
>  arch/x86/include/asm/msr-index.h |  2 ++
>  drivers/cpufreq/amd-pstate.c     | 22 +++++++++++++++++++---
>  2 files changed, 21 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> index 869508de8269..b952fd6d6916 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -559,6 +559,8 @@
>  #define AMD_CPPC_MIN_PERF(x)		(((x) & 0xff) << 8)
>  #define AMD_CPPC_DES_PERF(x)		(((x) & 0xff) << 16)
>  #define AMD_CPPC_ENERGY_PERF_PREF(x)	(((x) & 0xff) << 24)
> +#define AMD_CPPC_PRECISION_BOOST_BIT	25
> +#define AMD_CPPC_PRECISION_BOOST_ENABLED	BIT_ULL(AMD_CPPC_PRECISION_BOOST_BIT)
>  
>  /* AMD Performance Counter Global Status and Control MSRs */
>  #define MSR_AMD64_PERF_CNTR_GLOBAL_STATUS	0xc0000300
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 9ac75c1cde9c..188e055e24a2 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -122,6 +122,7 @@ struct amd_cpudata {
>  
>  	u64 freq;
>  	bool	boost_supported;
> +	u64 	cppc_hw_conf_cached;
>  };
>  
>  static inline int pstate_enable(bool enable)
> @@ -438,18 +439,27 @@ static int amd_pstate_set_boost(struct cpufreq_policy *policy, int state)
>  {
>  	struct amd_cpudata *cpudata = policy->driver_data;
>  	int ret;
> +	u64 value;
>  
>  	if (!cpudata->boost_supported) {
>  		pr_err("Boost mode is not supported by this processor or SBIOS\n");
>  		return -EINVAL;
>  	}
>  
> -	if (state)
> +	ret = rdmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_HW_CTL, &value);
> +	if (ret)
> +		return ret;
> +
> +	if (state) {
> +		value |= AMD_CPPC_PRECISION_BOOST_ENABLED;
>  		policy->cpuinfo.max_freq = cpudata->max_freq;
> -	else
> +	} else {
> +		value &= ~AMD_CPPC_PRECISION_BOOST_ENABLED;
>  		policy->cpuinfo.max_freq = cpudata->nominal_freq;
> -
> +	}
>  	policy->max = policy->cpuinfo.max_freq;
> +	WRITE_ONCE(cpudata->cppc_hw_conf_cached, value);

Does the entire MSR value need to be cached? We only care about the boost enabled
bit so it may be better to just cache that.

-Nathan

> +	wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_HW_CTL, value);
>  
>  	ret = freq_qos_update_request(&cpudata->req[1],
>  				      policy->cpuinfo.max_freq);
> @@ -478,6 +488,7 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>  	int min_freq, max_freq, nominal_freq, lowest_nonlinear_freq, ret;
>  	struct device *dev;
>  	struct amd_cpudata *cpudata;
> +	u64 value;
>  
>  	dev = get_cpu_device(policy->cpu);
>  	if (!dev)
> @@ -542,6 +553,11 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>  
>  	policy->driver_data = cpudata;
>  
> +	ret = rdmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_HW_CTL, &value);
> +	if (ret)
> +		return ret;
> +	WRITE_ONCE(cpudata->cppc_hw_conf_cached, value);
> +
>  	amd_pstate_boost_init(cpudata);
>  
>  	return 0;
