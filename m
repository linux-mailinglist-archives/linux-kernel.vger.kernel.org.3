Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2DD4CCDF3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 07:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237244AbiCDGnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 01:43:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbiCDGnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 01:43:23 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1334E3AA;
        Thu,  3 Mar 2022 22:42:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=STBGzAH8iAxHvdMl5yUfqo0vKRDFw6BPHPxftPLGdoYBwJkLwcmGRyA8ilf8lFKRRMyK5YypCxAhCZXfYJ8lQBeRSVHw5lpXxBVr2BOWwx+JgmL4lsKEr95al7+smbra1IcLkdE2+V1gKcTlURXy4uoKM4ajDvzoI51p60QcV3ZH3Z4NKhrjAluQvGSbEiKs5eiKgZmprJjFLAea8EO6PT5pPw5FTKXuZ5lydtsoepYDhbtRMCu36KDc86G4vsOcc9KVq6l9ltNOzKkw6dXzNXH5wDBRljVlb6V9A7XOwEeBQqda4NOQex4dTe6SvM6tlP1E/ngKApT9R+1EEIX1sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2aiWRld1LQgEEA+a7dxMLE2dj2WmunMPJLCupQJoJNI=;
 b=EOVeixejQMXWz+zaPy1Yg4DtpzRFH8BMuJ677xw+vZ/+eThRGiupXQThwojSYGGPyULImCJsEyL/A/KtckSbk4EJFAvRAqCfgpgj4yWclUvZ4ssRwaJVj3qYjn5OW6y4ETQz/LszqWNOAZgAyhGDvzrAyeK1cDwlxg4MgA/4KWXS8Giy6GcxDhShG31Y76Pe4q5Y+7Z7Gg108j9ZtA0+XjRpUnKu/zTBbKoMGkGhyB29e77FKWUNLBXTNrlwpSpYWA5KSFy4CGjt8/iqVhhrtG/ZEkvuFBVV5+7/XKaG1K0SCW9jsVAnPau3wx2pu9y52uJoAvwAg9fe53CWuk1D+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2aiWRld1LQgEEA+a7dxMLE2dj2WmunMPJLCupQJoJNI=;
 b=NbdlWpHWEP9RVoBJF9k3AgyhfxptRPlMO1TNI5UpzOOG8kdJiaCSU40ZE/ZpxEEJxVzomQRG/Tcn+cyVGDSukwyOLptOwHHTlSl4cA6JD7m+mNAnxJ/bADnJpvAqazICmlx7TPhhjYFslVgViZW1Xzogi/XemL++e2VUxlwYg4M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 SA0PR12MB4414.namprd12.prod.outlook.com (2603:10b6:806:9a::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5038.14; Fri, 4 Mar 2022 06:42:30 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::8d40:da47:7312:64b8]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::8d40:da47:7312:64b8%6]) with mapi id 15.20.5038.017; Fri, 4 Mar 2022
 06:42:29 +0000
Date:   Fri, 4 Mar 2022 14:42:02 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>
Cc:     "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "srinivas.pandruvada@linux.intel.com" 
        <srinivas.pandruvada@linux.intel.com>,
        "dsmythies@telus.net" <dsmythies@telus.net>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "todd.e.brandt@linux.intel.com" <todd.e.brandt@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Yuan, Perry" <Perry.Yuan@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>
Subject: Re: [PATCH V2 1/4] cpufreq: amd-pstate: Add more tracepoint for AMD
 P-State module
Message-ID: <YiG0uqa+Ho7XyuHJ@amd.com>
References: <20220304060724.314582-1-Jinzhou.Su@amd.com>
 <20220304060724.314582-2-Jinzhou.Su@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220304060724.314582-2-Jinzhou.Su@amd.com>
X-ClientProxiedBy: SG2PR06CA0202.apcprd06.prod.outlook.com (2603:1096:4:1::34)
 To DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 249ff8e6-bc66-4810-c216-08d9fdaa2729
X-MS-TrafficTypeDiagnostic: SA0PR12MB4414:EE_
X-Microsoft-Antispam-PRVS: <SA0PR12MB4414336B2559BC0F2A9B7A95EC059@SA0PR12MB4414.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X+gjnYCOX28CHJ3P2TzVa0R2TPFM7MjvN+IjwiFUIH6Ar05rvAyftWAM53d/IzK019hME4S6JdXzaxy/ujt9NpBgEiOh6+bhH/yDyNzcJGQ08ax4aDgEJAf9nheOIDY15SGM5ZOgUXybPAQWQfsar0NrozeMsH1gy/dWySReQOUdAC7HXCWh9/fEAf8glX2swHrqGi1OJo79c1OgA6IViKTHmeawZbjCsKgEBet88AM7grM6MWCWpF9BvC4Q6dPqhafg9nsl3lk9cwJqpfC23cjdwsYR51RUsrafTKfTXca3znY/PLNMnRgwXP56+MdL3LJ8cH5r6r3PxBoVKSZ2lbjPzM56l6I9IQH0+JJVmtwd/VooeBlhFenta4zuPd5Y4824hi2NcmxmOGAz0oqFuPI4okYVgJkXd5fO4S+5PuVf0ZpRQLjTYE7mngvmlx47zTvlDG1BWoVLdGwKpTuWmcckRmy246+7+KBdfLG2iyUgaNgswiDCIeiouPe8/7ex1PbHyoqp2I0CEJ+OWhJsPZaTNbdN4LmosWjmupLrcBs59t7U+nsbNISFkf7zCSlN7bbG9yZ6ErgPGqu6Z3ONfoWmBmOk1zK+WYM+D0Ee0gDc209rO/T8Tb1jK8aJMggColhlAlKeOmHRs0TbnQzIjmXNyPGt3boildfyUVPIIPbmgeeQPXX+WfW2S2A2JMArlCRJTOCw3ZPSFpwOfYImRg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(2906002)(6506007)(6666004)(36756003)(2616005)(6512007)(5660300002)(508600001)(316002)(6636002)(54906003)(37006003)(83380400001)(26005)(186003)(8936002)(8676002)(38100700002)(4326008)(6862004)(86362001)(66556008)(66946007)(66476007)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/dMPxkPgLySXwhQXlZfjTEV7vaHKuIFeAXLRZ4xN0NijZNVpZrEEsnxPunaN?=
 =?us-ascii?Q?6/YCAgxmJfghjkoZgJanH53j7N8lrgQjiuPZ+YEOhxqiHgzsNgh1ksoPFVa8?=
 =?us-ascii?Q?WRWxbZEHDgyGW1k11a64H5m9pUKNczIfpvXfUPnb0Hns9T4VNqkesntQhMuy?=
 =?us-ascii?Q?6Ny73AskQGe7xXo7jk9RofjV1r3pTYPoTgRk/t7Z0zyGra6QkZ4OftlYAy2q?=
 =?us-ascii?Q?ZvUYLrG/zRT7QHDq/n5/cTn36grDNwhltjLfSr92nQDccSwm2YtETljR5yHR?=
 =?us-ascii?Q?t9sB5//NTSs6b24c0Bijqf2ii6RKuJSKcPuG1Xm1UrfDFBVNWoFUUItZzidb?=
 =?us-ascii?Q?dSfzsMThDlorwblqCisv3O/soyTYATW2voo+snnt6g1p+H5kbtEn2HCwBeda?=
 =?us-ascii?Q?YW4nnEkWN52vJw/N8LCWXw/ClbBrloXeRdSKM6kgZmo1hJ+jdVlyW4oKwrSv?=
 =?us-ascii?Q?FdsnOHGJGfeqyWXiJ7F5UcJE5Q+rEdUepQNsL8e8F08gJ5vUstyGZc9Wi41N?=
 =?us-ascii?Q?VKk0tsnAAym7mffm95eT1RDvJ1gOZnZJcE3SYG5eLWbGClJtWP2ip18P5bxc?=
 =?us-ascii?Q?MQJ6jfDFYtXNsFOE6MOOwVvK2QnOKZ+eqzfd6eH7NKApo1KsPx2O9bYQjZEC?=
 =?us-ascii?Q?kWBjM3MDX6UkB1TifX9u6/jrVc5hoNSd9mBBoYGXr9zmHbVtiHy3zjlDWToT?=
 =?us-ascii?Q?wiQVQnHLKa9IB0KCgh/dPyw0Ge79HuMHeC3ANV2IW7H/UmGx+KtwckekZJTo?=
 =?us-ascii?Q?4zlHlU/p5INx5Y9epzjlHnCor299BZK9v+2ggFYipQuY98k9+zZse/HQeXgB?=
 =?us-ascii?Q?14gnAi18AKiOjT8+impWAAPxzRjF4QaQcLOmA+SYwRWF537L8pm6iVRGsvFn?=
 =?us-ascii?Q?pFLV5GE4MDjmOLDVQVNMcvZC5py8Z23KFxls4O06ONHMzOQDT6k4/ehD+jHq?=
 =?us-ascii?Q?tDz2kPn8GxixoP/u2eX+uLe3+350k8f84SLb5Wf0+WuorDXoNhX8RHXemOKQ?=
 =?us-ascii?Q?qfyvBAfBklcv6PcImVLp/7q6PR7mzR+XRVKM92RrmDFXGJQ8wmIywL4ikJ1x?=
 =?us-ascii?Q?9P2mSi9AXTsHWwHrCRpdR/GfZ9rDIeG3Wzur6sbH6e8mJGD8wowq2dZ9he2K?=
 =?us-ascii?Q?Qu7zco0fD3tFe+zViPWWwRKpYynyOUg+U8OCivuo8JecZTghOS73QPa9GAer?=
 =?us-ascii?Q?5wv7pdi+ttRZrmAjiPeonLb6hLA1aNIM4ItXgAFdb3hSAWO36eO36auUOVl1?=
 =?us-ascii?Q?K7BVwyOs/OBYOYC6fZjI+8KHerzU+iNI4hDHi9rJNOBpWWsN6QnrooyCOO/G?=
 =?us-ascii?Q?lDV0vhpCS5iRC2Q+gzLRJZQVHhGK1sazJcBs9BDOt0T6Y7s+pqYP2lUdtUty?=
 =?us-ascii?Q?klH8ZRFI2xTwGC7cdyiHCVuTLx0RNzqubYbUnZxaw90AcnlriNqu5PERjvsn?=
 =?us-ascii?Q?4NbR/sjiP9ZmZz7aLELaMG/cvtyKYG29Q6LWHtbojCVVUvHWalN2ki7vHEht?=
 =?us-ascii?Q?rHnxX/ROzwda3Jm78yh1Ur6s/lLJp8/4PuSYWv173Lv86Oz/Flkpwxho1OlO?=
 =?us-ascii?Q?RaQT6GT8RD/drUOTyQJhlKWn3K+Sqb0+GgjYxhpF+Sb5ZJNiveVOxG5ineS/?=
 =?us-ascii?Q?iyIuNlo4vqA+2Lco1syLXiM=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 249ff8e6-bc66-4810-c216-08d9fdaa2729
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2022 06:42:29.7482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zIN3MtDT+Ht3lCXLOmgpSIldYha41vKD0kseCDd8es9S8ZtvGZO3dVlSx++AZnuMePqD3N6xnsxwgS+wyEwz5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4414
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2022 at 02:07:21PM +0800, Su, Jinzhou (Joe) wrote:
> Add frequency, mperf, aperf and tsc in the trace. This can be used
> to debug and tune the performance of AMD P-state driver.
> 
> Use the time difference between amd_pstate_update to calculate CPU
> frequency. There could be sleep in arch_freq_get_on_cpu, so do not
> use it here.
> 
> Signed-off-by: Jinzhou Su <Jinzhou.Su@amd.com>
> Co-developed-by: Huang Rui <ray.huang@amd.com>
> Signed-off-by: Huang Rui <ray.huang@amd.com>

Let's remove "Signed-off-by" of me, just leave "Co-developed-by".

> ---
>  drivers/cpufreq/amd-pstate-trace.h | 22 ++++++++++-
>  drivers/cpufreq/amd-pstate.c       | 59 +++++++++++++++++++++++++++++-
>  2 files changed, 78 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate-trace.h b/drivers/cpufreq/amd-pstate-trace.h
> index 647505957d4f..35f38ae67fb1 100644
> --- a/drivers/cpufreq/amd-pstate-trace.h
> +++ b/drivers/cpufreq/amd-pstate-trace.h
> @@ -27,6 +27,10 @@ TRACE_EVENT(amd_pstate_perf,
>  	TP_PROTO(unsigned long min_perf,
>  		 unsigned long target_perf,
>  		 unsigned long capacity,
> +		 u64 freq,
> +		 u64 mperf,
> +		 u64 aperf,
> +		 u64 tsc,
>  		 unsigned int cpu_id,
>  		 bool changed,
>  		 bool fast_switch
> @@ -35,6 +39,10 @@ TRACE_EVENT(amd_pstate_perf,
>  	TP_ARGS(min_perf,
>  		target_perf,
>  		capacity,
> +		freq,
> +		mperf,
> +		aperf,
> +		tsc,
>  		cpu_id,
>  		changed,
>  		fast_switch
> @@ -44,6 +52,10 @@ TRACE_EVENT(amd_pstate_perf,
>  		__field(unsigned long, min_perf)
>  		__field(unsigned long, target_perf)
>  		__field(unsigned long, capacity)
> +		__field(unsigned long long, freq)
> +		__field(unsigned long long, mperf)
> +		__field(unsigned long long, aperf)
> +		__field(unsigned long long, tsc)
>  		__field(unsigned int, cpu_id)
>  		__field(bool, changed)
>  		__field(bool, fast_switch)
> @@ -53,15 +65,23 @@ TRACE_EVENT(amd_pstate_perf,
>  		__entry->min_perf = min_perf;
>  		__entry->target_perf = target_perf;
>  		__entry->capacity = capacity;
> +		__entry->freq = freq;
> +		__entry->mperf = mperf;
> +		__entry->aperf = aperf;
> +		__entry->tsc = tsc;
>  		__entry->cpu_id = cpu_id;
>  		__entry->changed = changed;
>  		__entry->fast_switch = fast_switch;
>  		),
>  
> -	TP_printk("amd_min_perf=%lu amd_des_perf=%lu amd_max_perf=%lu cpu_id=%u changed=%s fast_switch=%s",
> +	TP_printk("amd_min_perf=%lu amd_des_perf=%lu amd_max_perf=%lu freq=%llu mperf=%llu aperf=%llu tsc=%llu cpu_id=%u changed=%s fast_switch=%s",
>  		  (unsigned long)__entry->min_perf,
>  		  (unsigned long)__entry->target_perf,
>  		  (unsigned long)__entry->capacity,
> +		  (unsigned long long)__entry->freq,
> +		  (unsigned long long)__entry->mperf,
> +		  (unsigned long long)__entry->aperf,
> +		  (unsigned long long)__entry->tsc,
>  		  (unsigned int)__entry->cpu_id,
>  		  (__entry->changed) ? "true" : "false",
>  		  (__entry->fast_switch) ? "true" : "false"
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 9ce75ed11f8e..7be38bc6a673 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -65,6 +65,18 @@ MODULE_PARM_DESC(shared_mem,
>  
>  static struct cpufreq_driver amd_pstate_driver;
>  
> +/**
> + * struct  amd_aperf_mperf
> + * @aperf: actual performance frequency clock count
> + * @mperf: maximum performance frequency clock count
> + * @tsc:   time stamp counter
> + */
> +struct amd_aperf_mperf {
> +	u64 aperf;
> +	u64 mperf;
> +	u64 tsc;
> +};
> +
>  /**
>   * struct amd_cpudata - private CPU data for AMD P-State
>   * @cpu: CPU number
> @@ -81,6 +93,9 @@ static struct cpufreq_driver amd_pstate_driver;
>   * @min_freq: the frequency that mapped to lowest_perf
>   * @nominal_freq: the frequency that mapped to nominal_perf
>   * @lowest_nonlinear_freq: the frequency that mapped to lowest_nonlinear_perf
> + * @cur: Difference of Aperf/Mperf/tsc count between last and current sample
> + * @prev: Last Aperf/Mperf/tsc count value read from register
> + * @freq: current cpu frequency value
>   * @boost_supported: check whether the Processor or SBIOS supports boost mode
>   *
>   * The amd_cpudata is key private data for each CPU thread in AMD P-State, and
> @@ -102,6 +117,10 @@ struct amd_cpudata {
>  	u32	nominal_freq;
>  	u32	lowest_nonlinear_freq;
>  
> +	struct amd_aperf_mperf cur;
> +	struct amd_aperf_mperf prev;
> +
> +	u64 freq;
>  	bool	boost_supported;
>  };
>  
> @@ -211,6 +230,39 @@ static inline void amd_pstate_update_perf(struct amd_cpudata *cpudata,
>  					    max_perf, fast_switch);
>  }
>  
> +static inline bool amd_pstate_sample(struct amd_cpudata *cpudata)
> +{
> +	u64 aperf, mperf, tsc;
> +	unsigned long flags;
> +
> +	local_irq_save(flags);
> +	rdmsrl(MSR_IA32_APERF, aperf);
> +	rdmsrl(MSR_IA32_MPERF, mperf);
> +	tsc = rdtsc();
> +
> +	if (cpudata->prev.mperf == mperf || cpudata->prev.tsc == tsc) {
> +		local_irq_restore(flags);
> +		return false;
> +	}
> +
> +	local_irq_restore(flags);
> +
> +	cpudata->cur.aperf = aperf;
> +	cpudata->cur.mperf = mperf;
> +	cpudata->cur.tsc =  tsc;
> +	cpudata->cur.aperf -= cpudata->prev.aperf;
> +	cpudata->cur.mperf -= cpudata->prev.mperf;
> +	cpudata->cur.tsc -= cpudata->prev.tsc;
> +
> +	cpudata->prev.aperf = aperf;
> +	cpudata->prev.mperf = mperf;
> +	cpudata->prev.tsc = tsc;
> +
> +	cpudata->freq = div64_u64((cpudata->cur.aperf * cpu_khz), cpudata->cur.mperf);
> +
> +	return true;
> +}
> +
>  static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
>  			      u32 des_perf, u32 max_perf, bool fast_switch)
>  {
> @@ -226,8 +278,11 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
>  	value &= ~AMD_CPPC_MAX_PERF(~0L);
>  	value |= AMD_CPPC_MAX_PERF(max_perf);
>  
> -	trace_amd_pstate_perf(min_perf, des_perf, max_perf,
> -			      cpudata->cpu, (value != prev), fast_switch);
> +	if (trace_amd_pstate_perf_enabled() && amd_pstate_sample(cpudata)) {
> +		trace_amd_pstate_perf(min_perf, des_perf, max_perf, cpudata->freq,
> +			cpudata->cur.mperf, cpudata->cur.aperf, cpudata->cur.tsc,
> +				cpudata->cpu, (value != prev), fast_switch);

How about using struct amd_aperf_mperf pointer as one input:

trace_amd_pstate_perf(min_perf, des_perf, max_perf, &cpudata->cur, ...);

You can refer the members of struct amd_aperf_mperf in the
amd-pstate-trace.h:

	__entry->mperf = cur->mperf;
	__entry->aperf = cur->aperf;
	__entry->tsc = cur->tsc;

Thanks,
Ray
