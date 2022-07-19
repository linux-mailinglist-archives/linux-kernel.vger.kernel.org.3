Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5984578F64
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 02:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234312AbiGSAqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 20:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233360AbiGSAqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 20:46:10 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2059.outbound.protection.outlook.com [40.107.102.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE429220C3;
        Mon, 18 Jul 2022 17:46:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z3aHUMobnCh87J/v3IK9sW3kNFc/BsHzk+jfEY/nz4bdGynvZ8eT3gV6WAMRAdOApkKCJm4zQuPOiOwK6d0wiBSYlTqaInb/pQJRQ4VbWAoZuCCtFJKmP9gcfy9XUXY51lszViUM2bXbOzyYBSJh+y9nnIMqBhcB1ootYYF/J2TfKf5ma//pCrokdKEBCU+HvOhWqEufrM/NltTWv5lLMD4J6G7W5FydR7G8zOsL4JEwF+e2Jmzuw9hbyQ+FtoFFt52rrJU3VQ8pneFBRndVBMMXLQWP+ngLzy46zK7FdqWidAVXe4v//OY0kYN3I0axGnV0qubklpEw38C6Aqocwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7toZhVNFv3gLxqnAJGGhdRwsgvfxJ/C9M0muADWXvzA=;
 b=YrUmAh4hY+S9mPxMdaj67f+DRRcBu1vBXmb3EGhx6ZXoPe79MEc0iprAMNCna/FtCN3JNrwHQB+YC0TXhgofBjP0y4LTcbqKhQFgKj1MyVFP5bMXKW0sMRXjLcTJs5IVU77uxfza+o3/yg5yIrPhG2vWAczDKtgoW5xykyMHmmkE7zJodiOaXnqFjaIi71VpOgF4oOvIom5/sUEh+EXBkNe/JarqOU3KxvhoHWWhUQgX418ywK5wwje5pBWbLPsrWvgBw6dYoZ/VHYzhjfcHbCG2sxrnluVxRdNvitCpYKW4Px30VwdDs9r4Rx8K9ZSg3O494WjNfDnf+CyCVheTZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7toZhVNFv3gLxqnAJGGhdRwsgvfxJ/C9M0muADWXvzA=;
 b=n9lZvaDQ59bvNB+t9x6JBreN+qRKkrjze/a0ZFL29WfAjSKbSRYSnzY3pzxMszdHmN29PMYNCO7K/yRkC8irFC+jJwyHYa0CFgc4ZQkz7vE6PYFLHxWsCxTe8jCeGTYJHclhEizio7JL85Y9mGUQr6+wXhiP8tBSDlvMcys3lNg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 DM6PR12MB4826.namprd12.prod.outlook.com (2603:10b6:5:1fd::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5438.21; Tue, 19 Jul 2022 00:46:07 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::ec80:e3fd:e3e2:605d]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::ec80:e3fd:e3e2:605d%5]) with mapi id 15.20.5438.023; Tue, 19 Jul 2022
 00:46:07 +0000
Date:   Tue, 19 Jul 2022 08:45:44 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Yuan, Perry" <Perry.Yuan@amd.com>
Cc:     "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 02/13] cpufreq: amd-pstate: enable AMD Precision Boost
 mode switch
Message-ID: <YtX+uF/nAIG0ykHN@amd.com>
References: <cover.1657876961.git.Perry.Yuan@amd.com>
 <b3db7981e407d5f111eeb27a8504a4ed7979ba60.1657876961.git.Perry.Yuan@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3db7981e407d5f111eeb27a8504a4ed7979ba60.1657876961.git.Perry.Yuan@amd.com>
X-ClientProxiedBy: SI2PR06CA0014.apcprd06.prod.outlook.com
 (2603:1096:4:186::11) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 859e7755-6b54-4386-e200-08da692010f2
X-MS-TrafficTypeDiagnostic: DM6PR12MB4826:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SBOD2AbV4ddN7Pfl4xAIJNvLJiDq2LJOJwNTkdhjhnQDXvbLU6+Iiog1Xq/9eH7a3BaZ8W8rB8M80btIlfZdY2f8vlaCC7Ul4+m23Vg4BWLhtOLau4jZP+Ac+UYtJVzllhae5yBxPYSkc/Jx80UUY5csxy8s7qsIpmOGCZSIMqcu5pCQuZaL14nQAAOGdIG4q0V8WIzLCGdx9CplBSmlbPtSo43efjAGZXn74ymrIQPS4SHwDEPKPwqmsMLT3KP9c4razCEuIvUPbv1cgsGFAFDZxrtt1g6y2XLt/4trKA2BSGiXtajf2uHRk0kblG2EML5nszzixnkBOClOgg2OoSYnfZVuItfQpgm0EuxUe9CpraJz35IrS0/7aYcVUrSqRKppwiN5JdEfguFyO/3HYKcumdwwNYKF+d7iK3mejKmVmEoIJDgqy6DCqHmTjOTQdXa3pozD5xTjbkuv/H11iDir6iU/Kbn8wnFqDfnoFzmHu67Lcn/KhV2u5mNCCQYbFbNz8zUQFLCMOkWfCce5jrCZH0dzOQxOVJVinXuzmlAlhFrmxSmMRSYnHerNZbnupraC7O6wi5r0utkGbolLngAlrj5xSAvqroL69BqlDNUShZcKl9+3Hlwfvlcc4KYMzMzxd+0ZFrY7FEqMnOIZrst+6kE0E5FWzRwjQPBlnqpaH/5wxKtUY3QK+fAlv4uqlbE6PRwSuwppg2i1HRJmzVJlxsoFLV2cC0QoED9I1k5a2xmOhNDqsUfBp/RYDxG+rWWSQst8xYwctwiHSPiP5w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(346002)(376002)(136003)(39860400002)(4326008)(8936002)(5660300002)(8676002)(66946007)(66556008)(66476007)(6862004)(316002)(36756003)(2906002)(6636002)(86362001)(478600001)(38100700002)(6486002)(966005)(41300700001)(37006003)(54906003)(26005)(186003)(6666004)(6512007)(83380400001)(2616005)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZXBU+oE3MU9IKjAhu9nZTTgK4tWKEk6gba9KSZzgDoZXmzQSEx/KB9xV+QIJ?=
 =?us-ascii?Q?yUjQyogOLom6ehBVirqOo3uvh+XkQ8sKc4Yd3DCyLuH/Xv1PV3pdISX2gTH6?=
 =?us-ascii?Q?UOL+nY9/A1YNohynUhb4K1i7MIdDPf3PB2axfNv5dfWuMEn17AJ9Om64LPI3?=
 =?us-ascii?Q?ZZxKPpbGXwcN+el4x4Wm88sKqGR3+yeRtacQz/zw0b2y10CnCm0eARGw8/8o?=
 =?us-ascii?Q?AmSKYzwIIEdJj8LGk481aElOsIaOvbaFb5v+6ktbHTSGoXo+/8DwlxxNWvTR?=
 =?us-ascii?Q?tzlW1aJ6x5Ys9EyixZxGmsHjB0qGChp1ytXuMm82zTL5vBHsr+pMCx5Vi5iU?=
 =?us-ascii?Q?4+1FBpb2J2RR+7usqogo5Rwut+qBND3WbPcozZvGAyApme5yrmIC8ZQCZcOJ?=
 =?us-ascii?Q?OeO7JZF01hO8eCei4aQpd9IrDpcctOxFaWAC7vi9S4Yr9Zak9/Xu1tKnx5NO?=
 =?us-ascii?Q?XOKoiMmUz4DnHwPDTcaNT+jOwMqmsZMXCCW6WhtGFZP4NjR7xGIAgOLf1ppq?=
 =?us-ascii?Q?yeKPbGGZj8K52Q8XUJuY2krfz7RMuVucy+VpF2I7AewnsDIqN+gbDJXKe4cM?=
 =?us-ascii?Q?hYg425xOtLC8xTkzrNVLeEOL3aERBtfVgX4EyoPGJzr3v636TyM5qBykC/dU?=
 =?us-ascii?Q?r/jsoGS8gyujpaL+KXNKKGbt6QrJha29WkdKGnUwJLyVMvWvLmlqZ4aOx9qV?=
 =?us-ascii?Q?G9CEUQQaNRxCZBYh7N3qeX0z/WZrQAk/1JTCCooMsoj1+3ZhDJCMpF6psdGe?=
 =?us-ascii?Q?Ht4l+Cp9fS/6zYAqLTsSLC/uf1oiigIovkVN0NFSIsgQ80ySgQx98eCsOVx9?=
 =?us-ascii?Q?4nRJFLoxn7fiOzzOQV+e7LQlwlVLR2m9eIYVM51zgPaTfcFOiqCY25TT2v1S?=
 =?us-ascii?Q?Fv15jX2l24Wb4KXRm/rA5YMO4p12zPiUXe/DVry5ujFTK2+e8DfFZBt44dzB?=
 =?us-ascii?Q?2XNdTAnmQhBXygecSRUKEYoVEDyxODVzyKUo/3aE/iYv2j5cn29Dm4k8WOAz?=
 =?us-ascii?Q?1VNGVzR/kPSKXfzQiUiw6TYSGhzLCRgzTsLfDvxBBKBg7DMGyxXCSXPBPuX+?=
 =?us-ascii?Q?nNNUT5iyBU0swmRhDioQa7XaaScidJ/plF8ngZrfi0nZUMvCem4TVquiPVtD?=
 =?us-ascii?Q?ISGwUFnt6fl+GnY0lrx4vqp05KYcCfpxmD/M3rg/obs4mWXKPC7odIVJx9HN?=
 =?us-ascii?Q?Oi+IXMZFwXp4g/8GJYLGykmQ1HYpNINZZqxwOQ/RHipkQbCua8XnoL8DhRQY?=
 =?us-ascii?Q?GM8lePSyM5ENsCwcI1rvthusQFZtJNHC7FwMMufcwiWQg71YYxGPvGohTLhL?=
 =?us-ascii?Q?I97HnkShRnAJ/hBRpCzUlf3AZ0a1Fd9Bc6n8RyH8gPugTyBFsyvDko1Hz2+0?=
 =?us-ascii?Q?8MSGpteVntXGiBl7Tw7lFl8xhJ26qV/QKHQTjB0PW8T88hjc38jZTJAWitDy?=
 =?us-ascii?Q?aVawimnDgtDkz5vQLRyEHUS/o11Xq5TC7qno+jO//btIhysd8fAPyn/p9jlF?=
 =?us-ascii?Q?cbsBF/Igad9Mv94VZQDQ1q3rV+seXTYf6QjsxxdohEUlJIkq1kcIG/sg8Zu0?=
 =?us-ascii?Q?VBUzUppGthAAhI1ooYJdSUaE4O3PUibHTbG9qV9A?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 859e7755-6b54-4386-e200-08da692010f2
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2022 00:46:07.4319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v7X+jdq13013/Gj+tMHi/MF4uteiZyi2qRTUkZ4qWlQdIgjPh9swVg4pN1J9co6UkLUhG3Esx7IixwN7mRxEbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4826
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2022 at 06:04:21PM +0800, Yuan, Perry wrote:
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

The bit 25 (CpbDis) of MSRC001_0015 [Hardware Configuration] indicates the
core performance boost disable flag.

Please see the section 17.2 Core Performance Boost of PPR:

https://www.amd.com/system/files/TechDocs/40332.pdf

Core performance boost (CPB) dynamically monitors processor activity to
create an estimate of power consumption. If the estimated processor
consumption is below an internally defined power limit and software has
requested P0 on a given core, hardware may transition the core to a
frequency and voltage beyond those defined for P0. If the estimated power
consumption exceeds the defined power limit, some or all cores are limited
to the frequency and voltage defined by P0.

The boost state is designed for legacy ACPI P-State function which is
to request higher frequency beyond P0 State (it's equal to nominal
frequency in CPPC), and we already have the operation like
MSR_K7_HWCR_CPB_DIS in acpi-cpufreq driver. However, in CPPC, we can modify
the performance hint beyond the nominal perf to reach the goal. That won't
need this control anymore. And furthermore, this function for legacy ACPI
P-State should not be mixed them up with CPPC policy. We should prevent the
effect for this flag in CPPC.

Thanks,
Ray

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
> -- 
> 2.32.0
> 
