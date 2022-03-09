Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC11B4D2FED
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 14:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233094AbiCINb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 08:31:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbiCINb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 08:31:27 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84212179A37;
        Wed,  9 Mar 2022 05:30:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YIXr0P28/lFENBsMN2aArZfHFp939CA/x+hQJFxedhVUzYLNedOcufvV3WgroOf9MQSxwtxnLu/Uen5k2//alYogwssEsyp6z/ngzSDZCMI22r8bgGpZGJ4UEg/ghTWmWFPyBLOJe1nGCZvMeAuGaQPW6YT2814vgeekBiovpabMvWW3CIclTBoUTatErQg8iXmvnBM7gdE2DRnklJ8KxuTBdNSgxvoYpe8dhVacCVD721JagSODg6Jj8soaTQjzieKPNZUV/wV60XQW/6heO+y+UvggetoBK1c3Uq0cdAnSbS4pxwdKNudO/1oKJZEJasIwaP8ONa5GnQKXt9EUCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k7AYhRatwPRHVz75AoZoJ2xGgFXeEcU7vj8S7xVd++g=;
 b=cif63uYpb71qsz4oryS93vxZh7Oq9FnMXBaRqDSkxDUGpR1Oqk0SulTdRdEuGU5kyVXKI9Ru27A3ILk7PT+OYcB6psafSs1c00qOd+HjrpA1IlFNcPUlEj1rlqJ9nvflHZoPz/II+MAHCO5GrsBhr8GnMumrracnCo8LDCLAOZhcPVNGKgf004B2hwVVHHYzUPDx4fRxkv6t76ciDsb8W8KKgpczOzVeZSAw4lwd6qVNPIS85i6YAmNIOw09UKLKeoXTyV2/Jnmy7YbnwdM0Ua31poin5ttt/ad/PxVFxl5hguZn8rB8JR153KzohnZTzEvpVov62Y4ANksc+UjvuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k7AYhRatwPRHVz75AoZoJ2xGgFXeEcU7vj8S7xVd++g=;
 b=4Bq2NOQsOpI0ZAszkJnRo1q5FhFbGGtaeOVrsbX70fBAJP3Gtl1PSGVzIzVAYD/S9vVrnI8PYys39WNvgKSoaGV8SUuu4T2dclO5/naMJedGD5QaWIArSW4r8mLHuhIldzMae8LZfbv6iHjMB36GZsnu+v0swp0/mplPVS44enE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 BYAPR12MB3477.namprd12.prod.outlook.com (2603:10b6:a03:ac::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5038.14; Wed, 9 Mar 2022 13:30:22 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::8d40:da47:7312:64b8]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::8d40:da47:7312:64b8%6]) with mapi id 15.20.5038.027; Wed, 9 Mar 2022
 13:30:22 +0000
Date:   Wed, 9 Mar 2022 21:29:57 +0800
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
Message-ID: <Yiir1RptLgruDV2j@amd.com>
References: <20220304060724.314582-1-Jinzhou.Su@amd.com>
 <20220304060724.314582-2-Jinzhou.Su@amd.com>
 <YiG0uqa+Ho7XyuHJ@amd.com>
 <MWHPR1201MB2494A689835082F711CC13C1900A9@MWHPR1201MB2494.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR1201MB2494A689835082F711CC13C1900A9@MWHPR1201MB2494.namprd12.prod.outlook.com>
X-ClientProxiedBy: HK2P15301CA0024.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::34) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3ba52cfb-4fe8-49cf-af99-08da01d0f5bd
X-MS-TrafficTypeDiagnostic: BYAPR12MB3477:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB3477C81EC5ADE9872C5F2E0AEC0A9@BYAPR12MB3477.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tP+Wy4e/XSMgskmhL4r4AHUwublPRY+baC7GOwPzvrJEGHffc4ir1th2Eeh06r0GOkDJApEdiyZ2imuA7D1hAAIbHxSuBrW3bDbry+ZWiJ6JGmKQIiC8H/sxkpOdTSHDXSYM45d5jduC8ZAR4Fpw/HFIr6DLEREcE+qP2kDVGXxybJU+4dR6UJ2/Um/ZdetnCEOFLa+8dXpZfx/URBVEWMof41gVDNLQAHuAVv/tSFcCdypHz17g52XyjAkfi4JNjzAew8JrGnn5ZZ+JQ+uS/9WhUAy8L+5hW5c4JFRqS93OqXYolpBa02rKsYGHM7CRn30YOu7chm1BHHMzfimBEus2OcaogDPi53rwznA3HvptKTlASs2QYmeRHS1apRIdMqjjr8M2CBnP4dPA1ZEwGks4K+n24fhdKDpaVW2SvLleU9Q9m/vYCzR66DY/EVsSRfqlVTvqYy9G4vbCPk+I0rBjg1xOX+xNP7PDG0Fst7nfa2iq/tUGB7UXcQAQXGrFLXn4KMGs7hxH+4+H2ffb9ICJffZmqtDVW/NU9+68zTKe9tauAMsLAtGkUXwEidBjGnwKvlhpA/NGbz8jxOy00nu2Ray9LJuTAGKTyR2/A7RoUzt5iJMIIVrkDn2sSMWlzMcxdVDDiHU5DNsokKTIrQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66476007)(38100700002)(6512007)(66946007)(6636002)(53546011)(36756003)(6506007)(186003)(26005)(6666004)(86362001)(83380400001)(6486002)(54906003)(5660300002)(6862004)(8676002)(37006003)(8936002)(2906002)(2616005)(316002)(508600001)(66556008)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IRVS1ck2oYhF/g5WSAvujzQHifllZJSxU66u6WKxynf3VexgvU0OFjRSzj1M?=
 =?us-ascii?Q?BwDf/gd0dLuIXPZPVrrb+6FtvRH0A9GdG/05Bwo1qXw/6TBjbSnuYUe7tNjT?=
 =?us-ascii?Q?/OF68doLpDWc0cFyNvCJ4m56tBLG0mI7DoNvO+tpOPj4++AJG9t33G47Pl36?=
 =?us-ascii?Q?Ey67er/iX6fhi5l3RIMmCxK6dolpn9zgMRYcm+F/TPPwJMV9OZ0w3p8GL3dk?=
 =?us-ascii?Q?cNcTM7r55mPU/EQc+m1rgn8LO6IwXc0Bzrs0+nUjajlqjYuRWpqd2n3qgfmz?=
 =?us-ascii?Q?PgpgWjyyGnKBfyipbQJbrmHaK76A89hsZBjaS2wXXF4sFp2PJr9LWpZw+RV+?=
 =?us-ascii?Q?Ro0ouIpAGZovEa3pl++I15Vj2rwO44jP/m5On1c5Ouadeg5rFt3bnrPz7pSV?=
 =?us-ascii?Q?SZQ1n513l3/asuMpk7u2xZKzkMyFmi26Lw74lZZnCGJJjUVOL5tMQ2zr5859?=
 =?us-ascii?Q?/S3AoM2f2lVr7eFGEWKGX36k88sjO9TEN1vTrVxUNUzwp8Ug2NxBzQAWoj1z?=
 =?us-ascii?Q?FIbymO++Q8m4dkoW+iHoMXgVpl8patd1T0a8V5/x/d9UlhlRKEPKfB+L/lGM?=
 =?us-ascii?Q?+ZcqrAdjI6aqrjstEcB/MxkCtR+zvPj20mtTEWA6jetMQo9ui2Psgs8l85VF?=
 =?us-ascii?Q?mCpQH4ez0WeZhDOPziz/AjFt6KmhN/+NBiRGL5aglzFBSDYVNx8iIH1IG0Qg?=
 =?us-ascii?Q?XzR1zQ0NT85CChv2qkJABOGeGiT31lA9MTCjOC/AS1g+dxJoSl30Ng8JixAv?=
 =?us-ascii?Q?Jh6WNCgTakH2Kg3ZndhFIrQ6KG5iozQwUxK7/sk/HjgEiauI38GveVXayxBU?=
 =?us-ascii?Q?Tc/UnU/+Qs+8EN/ERUlqjOVN3fQXJ2p+BjQbGJH9ocSOtWyaKI8dkwM6Ma5w?=
 =?us-ascii?Q?U3yehdJ/MIapcJA57zatzq5nRX6N4UlLfCtGwvmPeY5JLGDCUeVCqFJWuw6z?=
 =?us-ascii?Q?N9FDWn9w5Zem25yCOeXqrJhTJde+uG2W4TXXSVybBaV8bZ7NlheMRHsOblIw?=
 =?us-ascii?Q?9d3fXLH1PWIFj3S+1wFS6zCBz9jk2Rln7Ws6v2r9XkTShb4DzB0g+AmMfVD4?=
 =?us-ascii?Q?NMX9ICsj4h7In/qcduyrnR34koxh45WnL6T2WJmxm+vpNWjcqzCc/PmMVnAC?=
 =?us-ascii?Q?cHRDBgQ7OEU5LquK4pkzFH8WPnWNjBhqCJvGUKXNtOyuEbIuDmcQATiYC4Xx?=
 =?us-ascii?Q?cE8wRqOqIMnMmSd5lsDNhJFmG62N0ZMB4/tk1T5Om8T7Nh27Vf15nhxtEYf3?=
 =?us-ascii?Q?SZSmS9iNgQyIe5IhfxfB2i2WCygirvZTOQxjv1K/E7QOKkSZa5SizsqNMThu?=
 =?us-ascii?Q?vHRkAdesGnz5IZ9VwvQ6ZRljgg7FLHtNFlcaUlxraJDUDYZc+SsGsh+ZgNw3?=
 =?us-ascii?Q?K7Yxp1ulATa2AzZegI9kdZbfTV4PysdXynkY4eN6wOzBnEVhXIpFm86YR1Xq?=
 =?us-ascii?Q?lBZEVcktJQ7tzYcYf5j/kYexgQyfz0pci5sH1L25RVYz6P+s5QV6llEzlqW+?=
 =?us-ascii?Q?xBjNmUGKpszsNUMM9LPV79Ag+SGTa2i/U/YRM8uSd5FxcnRjMFFJkkDCjtmE?=
 =?us-ascii?Q?q8fs1if1mSgVlGvawKhRvJxmm0kdY6K90wr5ZLDJt5iUC3zLsCC765PV5urt?=
 =?us-ascii?Q?1Bta54UkJ8T9agWMCUNn2ck=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ba52cfb-4fe8-49cf-af99-08da01d0f5bd
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 13:30:21.9176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lIXdiadkPtQwgVsWPkdtsath0YSYhZrocWjC6Hgge81wbJnOyKTyZbKfpp9nDX0U4h+iUSir0pfDxZcfPvNqsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3477
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2022 at 09:23:38AM +0800, Su, Jinzhou (Joe) wrote:
> [AMD Official Use Only]
> 
> > -----Original Message-----
> > From: Huang, Ray <Ray.Huang@amd.com>
> > Sent: Friday, March 4, 2022 2:42 PM
> > To: Su, Jinzhou (Joe) <Jinzhou.Su@amd.com>
> > Cc: rjw@rjwysocki.net; linux-pm@vger.kernel.org;
> > srinivas.pandruvada@linux.intel.com; dsmythies@telus.net;
> > viresh.kumar@linaro.org; todd.e.brandt@linux.intel.com; linux-
> > kernel@vger.kernel.org; Sharma, Deepak <Deepak.Sharma@amd.com>;
> > Deucher, Alexander <Alexander.Deucher@amd.com>; Du, Xiaojian
> > <Xiaojian.Du@amd.com>; Yuan, Perry <Perry.Yuan@amd.com>; Meng, Li
> > (Jassmine) <Li.Meng@amd.com>
> > Subject: Re: [PATCH V2 1/4] cpufreq: amd-pstate: Add more tracepoint for
> > AMD P-State module
> >
> > On Fri, Mar 04, 2022 at 02:07:21PM +0800, Su, Jinzhou (Joe) wrote:
> > > Add frequency, mperf, aperf and tsc in the trace. This can be used to
> > > debug and tune the performance of AMD P-state driver.
> > >
> > > Use the time difference between amd_pstate_update to calculate CPU
> > > frequency. There could be sleep in arch_freq_get_on_cpu, so do not use
> > > it here.
> > >
> > > Signed-off-by: Jinzhou Su <Jinzhou.Su@amd.com>
> > > Co-developed-by: Huang Rui <ray.huang@amd.com>
> > > Signed-off-by: Huang Rui <ray.huang@amd.com>
> >
> > Let's remove "Signed-off-by" of me, just leave "Co-developed-by".
> >
> > > ---
> > >  drivers/cpufreq/amd-pstate-trace.h | 22 ++++++++++-
> > >  drivers/cpufreq/amd-pstate.c       | 59 +++++++++++++++++++++++++++++-
> > >  2 files changed, 78 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/cpufreq/amd-pstate-trace.h
> > > b/drivers/cpufreq/amd-pstate-trace.h
> > > index 647505957d4f..35f38ae67fb1 100644
> > > --- a/drivers/cpufreq/amd-pstate-trace.h
> > > +++ b/drivers/cpufreq/amd-pstate-trace.h
> > > @@ -27,6 +27,10 @@ TRACE_EVENT(amd_pstate_perf,
> > >     TP_PROTO(unsigned long min_perf,
> > >              unsigned long target_perf,
> > >              unsigned long capacity,
> > > +            u64 freq,
> > > +            u64 mperf,
> > > +            u64 aperf,
> > > +            u64 tsc,
> > >              unsigned int cpu_id,
> > >              bool changed,
> > >              bool fast_switch
> > > @@ -35,6 +39,10 @@ TRACE_EVENT(amd_pstate_perf,
> > >     TP_ARGS(min_perf,
> > >             target_perf,
> > >             capacity,
> > > +           freq,
> > > +           mperf,
> > > +           aperf,
> > > +           tsc,
> > >             cpu_id,
> > >             changed,
> > >             fast_switch
> > > @@ -44,6 +52,10 @@ TRACE_EVENT(amd_pstate_perf,
> > >             __field(unsigned long, min_perf)
> > >             __field(unsigned long, target_perf)
> > >             __field(unsigned long, capacity)
> > > +           __field(unsigned long long, freq)
> > > +           __field(unsigned long long, mperf)
> > > +           __field(unsigned long long, aperf)
> > > +           __field(unsigned long long, tsc)
> > >             __field(unsigned int, cpu_id)
> > >             __field(bool, changed)
> > >             __field(bool, fast_switch)
> > > @@ -53,15 +65,23 @@ TRACE_EVENT(amd_pstate_perf,
> > >             __entry->min_perf = min_perf;
> > >             __entry->target_perf = target_perf;
> > >             __entry->capacity = capacity;
> > > +           __entry->freq = freq;
> > > +           __entry->mperf = mperf;
> > > +           __entry->aperf = aperf;
> > > +           __entry->tsc = tsc;
> > >             __entry->cpu_id = cpu_id;
> > >             __entry->changed = changed;
> > >             __entry->fast_switch = fast_switch;
> > >             ),
> > >
> > > -   TP_printk("amd_min_perf=%lu amd_des_perf=%lu
> > amd_max_perf=%lu cpu_id=%u changed=%s fast_switch=%s",
> > > +   TP_printk("amd_min_perf=%lu amd_des_perf=%lu
> > amd_max_perf=%lu
> > > +freq=%llu mperf=%llu aperf=%llu tsc=%llu cpu_id=%u changed=%s
> > > +fast_switch=%s",
> > >               (unsigned long)__entry->min_perf,
> > >               (unsigned long)__entry->target_perf,
> > >               (unsigned long)__entry->capacity,
> > > +             (unsigned long long)__entry->freq,
> > > +             (unsigned long long)__entry->mperf,
> > > +             (unsigned long long)__entry->aperf,
> > > +             (unsigned long long)__entry->tsc,
> > >               (unsigned int)__entry->cpu_id,
> > >               (__entry->changed) ? "true" : "false",
> > >               (__entry->fast_switch) ? "true" : "false"
> > > diff --git a/drivers/cpufreq/amd-pstate.c
> > > b/drivers/cpufreq/amd-pstate.c index 9ce75ed11f8e..7be38bc6a673 100644
> > > --- a/drivers/cpufreq/amd-pstate.c
> > > +++ b/drivers/cpufreq/amd-pstate.c
> > > @@ -65,6 +65,18 @@ MODULE_PARM_DESC(shared_mem,
> > >
> > >  static struct cpufreq_driver amd_pstate_driver;
> > >
> > > +/**
> > > + * struct  amd_aperf_mperf
> > > + * @aperf: actual performance frequency clock count
> > > + * @mperf: maximum performance frequency clock count
> > > + * @tsc:   time stamp counter
> > > + */
> > > +struct amd_aperf_mperf {
> > > +   u64 aperf;
> > > +   u64 mperf;
> > > +   u64 tsc;
> > > +};
> > > +
> > >  /**
> > >   * struct amd_cpudata - private CPU data for AMD P-State
> > >   * @cpu: CPU number
> > > @@ -81,6 +93,9 @@ static struct cpufreq_driver amd_pstate_driver;
> > >   * @min_freq: the frequency that mapped to lowest_perf
> > >   * @nominal_freq: the frequency that mapped to nominal_perf
> > >   * @lowest_nonlinear_freq: the frequency that mapped to
> > > lowest_nonlinear_perf
> > > + * @cur: Difference of Aperf/Mperf/tsc count between last and current
> > > + sample
> > > + * @prev: Last Aperf/Mperf/tsc count value read from register
> > > + * @freq: current cpu frequency value
> > >   * @boost_supported: check whether the Processor or SBIOS supports boost
> > mode
> > >   *
> > >   * The amd_cpudata is key private data for each CPU thread in AMD
> > > P-State, and @@ -102,6 +117,10 @@ struct amd_cpudata {
> > >     u32     nominal_freq;
> > >     u32     lowest_nonlinear_freq;
> > >
> > > +   struct amd_aperf_mperf cur;
> > > +   struct amd_aperf_mperf prev;
> > > +
> > > +   u64 freq;
> > >     bool    boost_supported;
> > >  };
> > >
> > > @@ -211,6 +230,39 @@ static inline void amd_pstate_update_perf(struct
> > amd_cpudata *cpudata,
> > >                                         max_perf, fast_switch);
> > >  }
> > >
> > > +static inline bool amd_pstate_sample(struct amd_cpudata *cpudata) {
> > > +   u64 aperf, mperf, tsc;
> > > +   unsigned long flags;
> > > +
> > > +   local_irq_save(flags);
> > > +   rdmsrl(MSR_IA32_APERF, aperf);
> > > +   rdmsrl(MSR_IA32_MPERF, mperf);
> > > +   tsc = rdtsc();
> > > +
> > > +   if (cpudata->prev.mperf == mperf || cpudata->prev.tsc == tsc) {
> > > +           local_irq_restore(flags);
> > > +           return false;
> > > +   }
> > > +
> > > +   local_irq_restore(flags);
> > > +
> > > +   cpudata->cur.aperf = aperf;
> > > +   cpudata->cur.mperf = mperf;
> > > +   cpudata->cur.tsc =  tsc;
> > > +   cpudata->cur.aperf -= cpudata->prev.aperf;
> > > +   cpudata->cur.mperf -= cpudata->prev.mperf;
> > > +   cpudata->cur.tsc -= cpudata->prev.tsc;
> > > +
> > > +   cpudata->prev.aperf = aperf;
> > > +   cpudata->prev.mperf = mperf;
> > > +   cpudata->prev.tsc = tsc;
> > > +
> > > +   cpudata->freq = div64_u64((cpudata->cur.aperf * cpu_khz),
> > > +cpudata->cur.mperf);
> > > +
> > > +   return true;
> > > +}
> > > +
> > >  static void amd_pstate_update(struct amd_cpudata *cpudata, u32
> > min_perf,
> > >                           u32 des_perf, u32 max_perf, bool fast_switch)
> > { @@ -226,8
> > > +278,11 @@ static void amd_pstate_update(struct amd_cpudata *cpudata,
> > u32 min_perf,
> > >     value &= ~AMD_CPPC_MAX_PERF(~0L);
> > >     value |= AMD_CPPC_MAX_PERF(max_perf);
> > >
> > > -   trace_amd_pstate_perf(min_perf, des_perf, max_perf,
> > > -                         cpudata->cpu, (value != prev), fast_switch);
> > > +   if (trace_amd_pstate_perf_enabled() &&
> > amd_pstate_sample(cpudata)) {
> > > +           trace_amd_pstate_perf(min_perf, des_perf, max_perf,
> > cpudata->freq,
> > > +                   cpudata->cur.mperf, cpudata->cur.aperf, cpudata-
> > >cur.tsc,
> > > +                           cpudata->cpu, (value != prev), fast_switch);
> >
> > How about using struct amd_aperf_mperf pointer as one input:
> >
> > trace_amd_pstate_perf(min_perf, des_perf, max_perf, &cpudata->cur, ...);
> >
> > You can refer the members of struct amd_aperf_mperf in the
> > amd-pstate-trace.h:
> >
> >       __entry->mperf = cur->mperf;
> >       __entry->aperf = cur->aperf;
> >       __entry->tsc = cur->tsc;
> >
> 
> I prefer the former way. We'd better to split the definition of struct "amd_cpudata" into head file and include it in the trace file with your change. Will do that in the future if needed.
> 

Hmm, it should be ok. Because the trace implementation will be moved to
include/trace/events/power.h after the shared_mem is enabled.

Thanks,
Ray
