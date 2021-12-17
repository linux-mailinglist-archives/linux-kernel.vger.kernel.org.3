Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E14614785A1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 08:38:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232237AbhLQHiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 02:38:12 -0500
Received: from mail-dm6nam08on2083.outbound.protection.outlook.com ([40.107.102.83]:13280
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229533AbhLQHiL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 02:38:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zt1O4WFyWfq1CuD4q/5eEFx115qOkYMw7xuAEMDxyHnl4MJJ/kjxFbOhXc7OsWIhn8zbNd+LJZhp3nSwWHcWNRhgCAInZ8wwLjV+zRZohSmFRIGDWNVrTrB3XYtue+HUgEXPpvQc2QTpkHouhnhLE9DMoCy2/ccoXkTn+DmaguAcxWkFdTIU7Uw6ZGjJ2EP9ZObySQOFV1MJSevXDs00mJLe5TSB6J/fQ8nl7kMusK0J8QYtMOtLs7Vrx/+LAqYTfkGzlhgc0qyXD/t8OYd8JM4QXHt6GqrQXHJxy5cv5g+pNyGOSsPOeCej4JumAUfAAJmG/jEfrmNLjs6jBTLyIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2R8H19OnSSpaAETw6w3gvXDbkzXcfv1JkTSi8X1Tta8=;
 b=hhyc/y72Fy22flpiQSEalynVSAFhfmc0YyyLKbvT47JXmJu2FcLQMSdsW5xO/Mj4iw93vPa8fEd1VjQyGwHTeRMeRd7UEjh5hU165EDC8ws3bwEw9viCyvAw5aLZ1LL7pJ9UvfPC6v98GsCiQQyYknllwdMjCSurduzH5Ck1+HdjGnFZc3ooTUnYKaion6JjFP3WtFlds1V1J8co0GXytELxq1Pwpr3mW9EbD1knla4jSIsKmKqeDdxdOW9bwgcvmILp7psN/C8+cgXU3tstozjIVcPt+XGbgsRx+kLrydkt15W8psKKhVTYCAzmZHA+kXUoqqAWZPyYF2oxM5UCmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2R8H19OnSSpaAETw6w3gvXDbkzXcfv1JkTSi8X1Tta8=;
 b=0qQOHCQo71xSCUcwZuAT1n9arD2P8SX7/f07CDjqLAOJFCADIAhx0vYkpgN9gAz10wkkRC/DtKmpMELPd+RcWwhuETNF6/eyBCSPrpSCAEFplRklUpMm8C+gtTraU662Tx5vDtrrBxTWjdQnC0fENAh1GW59qzlvYSd4IyUgp/M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 DM6PR12MB2795.namprd12.prod.outlook.com (2603:10b6:5:41::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4778.18; Fri, 17 Dec 2021 07:38:07 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::5d07:e475:316c:d187]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::5d07:e475:316c:d187%5]) with mapi id 15.20.4801.015; Fri, 17 Dec 2021
 07:38:07 +0000
Date:   Fri, 17 Dec 2021 15:37:43 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        Steven Noonan <steven@valvesoftware.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [PATCH v5 08/22] cpufreq: amd: introduce the support for the
 processors with shared memory solution
Message-ID: <Ybw+R3HmkYYnnUZ1@amd.com>
References: <20211130123641.1449041-1-ray.huang@amd.com>
 <20211130123641.1449041-9-ray.huang@amd.com>
 <CAJZ5v0g=VWRtBoxd-yX8W_F9QfV4OE9Ap_vxHicW_CGgizsw2A@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0g=VWRtBoxd-yX8W_F9QfV4OE9Ap_vxHicW_CGgizsw2A@mail.gmail.com>
X-ClientProxiedBy: HK2PR06CA0012.apcprd06.prod.outlook.com
 (2603:1096:202:2e::24) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 12ee0c05-739e-4166-43ca-08d9c1302aa3
X-MS-TrafficTypeDiagnostic: DM6PR12MB2795:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB27952DFB2F4E1E8CF7D4B352EC789@DM6PR12MB2795.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jaI6htsG3QWp7x3kJrGa1hsUAyssY6Sp6LBIuCWQ4Od4p6EnkId2HAxr77kqamJzxKZ4mYSIS5JTNBGzj8Sslt/NSauWU+tf79qlFIBvYp8DEj2UIrss2aKw7pJfeTHpRHBX6ij8xPFeh5MO4wA0SRZNx8+oZaCOkO75a3u6JjnCzrDwA8xjVp3pmxm00I4UZLiIvd0zIi6bh0H/VsVpTmmJh5FCz+TzCVWt+wY5uq5zCtJjOc24zQwIg7d+HsQ319evy4aRgvMlRoQyznzEZYU0NkY9+XCq01mZRv/oZfrZ1zrKLV5gJ1w16sjeTh96wDXsk3yTNOQIDOX8pSSPaJlbpXOyflm1MrvMX19wZ43ejoqhzXlRktXl/G3Vh61LuvrwPf5oraFYFK7WHO1rJn3ctQ6Rb0fmZfsjn1LLAhnvQPceVxDyPRSptWUELIPDEsxufYhNJJ65RVkb7YdIhKM+ututQFp+L99tqY6fzJduHZadsRlSREsinGSujd3bUOqW7juNzzsHvBO4zHOGLEe5kHlagZHVxQdNXJ5QJY4cI0zjbWwUUlY6uiI49U6FD71AhocLVp3Il6o+PxEDLgnGJ/Wm2PPQHZcFNdX9zaIxT0IZibEnxYY+VGpfRfxvW7pCCvSqtBov+R/mxfJp9t/e8KkkCNoKDMTp0ToNohU73oVOC2r1KniHXi9iY+TTS5DzdCxpGX3rzQF989xu5Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(83380400001)(86362001)(6512007)(2906002)(6506007)(4326008)(53546011)(7416002)(6916009)(316002)(66556008)(6666004)(508600001)(5660300002)(2616005)(54906003)(26005)(36756003)(6486002)(66946007)(38100700002)(8676002)(8936002)(66476007)(186003)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RqIds6/RA8TZn35gxaPxjvYe2ZR0ysoGTMsDJgsFGBzTZ/DSplCbxT5bB/O6?=
 =?us-ascii?Q?iur7+WI0Z2n2izsxzicsLgMkyLfop2lFTncdcGUZoAZMqcqtAPRPu/xzYwCD?=
 =?us-ascii?Q?pk7naPfewXY7Wn7AzLtvp97cNBJltDdjWOtmh/z4wDv73keOCeXUqZfRJETs?=
 =?us-ascii?Q?WUlYT2L905QV9vQZa0b3tEjH9bAd6DIeU9J6emTjLc+BW3hpIp0zZ4g0nEWF?=
 =?us-ascii?Q?1pV2y6FzHtnr5OnCqM2NEdL89b7fso/kYPoHh7ggX3vtBebk+NH3RAIJBsTH?=
 =?us-ascii?Q?NNmYx5uq8FOS5xogr6xO6F4aYun8tcyl61PI+tWxiJeA0IS1AabtRt2u836y?=
 =?us-ascii?Q?2EvSBGphIBc4m39ozAgVlF697ZGllYPCuvxIGQDpSKxus2auIhfWGrKp6VVL?=
 =?us-ascii?Q?5x//nU+mYkDmNO9JyuxJGpBID8jzPjTufJzjHU2uriApDcT1Z0bywJz0BPcR?=
 =?us-ascii?Q?7zg/zlIuHzaWgrs+rQXaibV2uzL5eB5iOJL5GgrqbfsIpb18Qbx9OmmOYivM?=
 =?us-ascii?Q?SBPu7Or9u0mFkY+hzpeGDh0KFWPPCE16Z30E0lJy6K978ZqubeuSbEApQLqE?=
 =?us-ascii?Q?g/UBhLQcgLP+ZAno6BP62tKUBIB4D3Q86EkD96Xo1xx8b6XnJVp/CRz9sk9J?=
 =?us-ascii?Q?41c85raM+DlT9ul4/yVmrtBCpNcYxo8xtgS1HVgho47WW7wpEui4e1YVAJ+7?=
 =?us-ascii?Q?zJ69lzXWXdKGtDcJiawQtD05A9ZrAh9cPccTFXaMoLvdT/KtHhiqZ5RcJ9j4?=
 =?us-ascii?Q?mqig7c+HFfJoOtsBZara1YMoFoMBmoNVL7x2msR41NWFhhXFoTee2y/cfdwd?=
 =?us-ascii?Q?c0PUVnxSyK5CiKTmUbjBnzh1emdbI/HJyGQYVpK8rllaM9W+uT5LTACGURq1?=
 =?us-ascii?Q?YiW+Y5DLLcYXhRxBMOUQMOUjxK5p/NP/2eeIH2d2n4enEK01KMBnpeAQcy8+?=
 =?us-ascii?Q?E4IKqSGZuWNJkAI/VVc3TpWUaJ2tWgrJLB9OL6czgNXqTShFWXyrLNz/ZHLK?=
 =?us-ascii?Q?+rM190kQ+YZW5c7rqlRaQcyLF7Og3mApiQgttcT28K115e4JzAr2IjTaNtJ5?=
 =?us-ascii?Q?zmbjOltQqaG/lLUI5aMNRHCXGA0CKyVHJ9qSD6bowIyjfLXdy4waPfOOVD6L?=
 =?us-ascii?Q?R7t2VUHHcMAjroAoEQDtrVID2Q7nAE+VWIBHb6jXyRRlGXhQzZIkkNDK7JL6?=
 =?us-ascii?Q?/CV3slh9bbY5oZZ0MT2rv1kJodXU0tEYEGBDsoV1XI4jBNysHcpBHIS9HNRP?=
 =?us-ascii?Q?T0yY5ga8tBjXnhO0cfNorKcdfV12+48NJIreIdfj6SZx+0MpkWjRO8zeLykr?=
 =?us-ascii?Q?FMY8fjTBOUwqRKHMbH6GE4J3y9mGT5x/qQC6r4zVLiWD42i6hMbwAZeg2lNa?=
 =?us-ascii?Q?DLjiIaxOe+zeQ+VtNra/C6xa93PZso8GuBIDvHH2D0Xj0MjB/PZ8QsVOt1Qd?=
 =?us-ascii?Q?6xfuCfo5E23sdSvmtIp4UOGFJ8Ko9CmG6kIqCQm31qhVe/YeWJ/81Mo/UC9j?=
 =?us-ascii?Q?iHHI8sHGzOzZgrDSASZ6CPMGbI+1xVBDDBDlQLIfNB1ZIaBsz44cA2Nf+N74?=
 =?us-ascii?Q?iFeyDNu5O/qQxxPHm9SN/Rx9VBZAOb9/b1AUQpaRMuyDceLFTo5BIwRRUUqG?=
 =?us-ascii?Q?rqx3VuAh6XhMhNqdJIdqwBc=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12ee0c05-739e-4166-43ca-08d9c1302aa3
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 07:38:07.7100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8eoEXKUa3RB2rngEBWqblioZ9jwNPW4P1VH6iGauUceu3HgNjZA6aWQYR6WCW7RYHwsRA5OqHARbZu5wa6FLoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2795
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 02:04:11AM +0800, Rafael J. Wysocki wrote:
> On Tue, Nov 30, 2021 at 1:38 PM Huang Rui <ray.huang@amd.com> wrote:
> >
> > In some of Zen2 and Zen3 based processors, they are using the shared
> > memory that exposed from ACPI SBIOS. In this kind of the processors,
> > there is no MSR support, so we add acpi cppc function as the backend for
> > them.
> >
> > It is using a module param (shared_mem) to enable related processors
> > manually. We will enable this by default once we address performance
> > issue on this solution.
> >
> > Signed-off-by: Jinzhou Su <Jinzhou.Su@amd.com>
> > Signed-off-by: Huang Rui <ray.huang@amd.com>
> > ---
> >  drivers/cpufreq/amd-pstate.c | 72 ++++++++++++++++++++++++++++++++++--
> >  1 file changed, 68 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> > index cab266b8bf35..68991c450fd5 100644
> > --- a/drivers/cpufreq/amd-pstate.c
> > +++ b/drivers/cpufreq/amd-pstate.c
> > @@ -35,6 +35,19 @@
> >  #define AMD_PSTATE_TRANSITION_LATENCY  0x20000
> >  #define AMD_PSTATE_TRANSITION_DELAY    500
> >
> > +/* TODO: We need more time to fine tune processors with shared memory solution
> > + * with community together.
> > + *
> > + * There are some performance drops on the CPU benchmarks which reports from
> > + * Suse. We are co-working with them to fine tune the shared memory solution. So
> > + * we disable it by default to go acpi-cpufreq on these processors and add a
> > + * module parameter to be able to enable it manually for debugging.
> > + */
> > +static bool shared_mem = false;
> > +module_param(shared_mem, bool, 0444);
> > +MODULE_PARM_DESC(shared_mem,
> > +                "enable amd-pstate on processors with shared memory solution (false = disabled (default), true = enabled)");
> > +
> >  static struct cpufreq_driver amd_pstate_driver;
> >
> >  struct amd_cpudata {
> > @@ -60,6 +73,19 @@ static inline int pstate_enable(bool enable)
> >         return wrmsrl_safe(MSR_AMD_CPPC_ENABLE, enable);
> >  }
> >
> > +static int cppc_enable(bool enable)
> > +{
> > +       int cpu, ret = 0;
> > +
> > +       for_each_online_cpu(cpu) {
> > +               ret = cppc_set_enable(cpu, enable);
> > +               if (ret)
> > +                       return ret;
> > +       }
> > +
> > +       return ret;
> > +}
> > +
> >  DEFINE_STATIC_CALL(amd_pstate_enable, pstate_enable);
> >
> >  static inline int amd_pstate_enable(bool enable)
> > @@ -90,6 +116,24 @@ static int pstate_init_perf(struct amd_cpudata *cpudata)
> >         return 0;
> >  }
> >
> > +static int cppc_init_perf(struct amd_cpudata *cpudata)
> > +{
> > +       struct cppc_perf_caps cppc_perf;
> > +
> > +       int ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
> > +       if (ret)
> > +               return ret;
> > +
> > +       WRITE_ONCE(cpudata->highest_perf, amd_get_highest_perf());
> > +
> > +       WRITE_ONCE(cpudata->nominal_perf, cppc_perf.nominal_perf);
> > +       WRITE_ONCE(cpudata->lowest_nonlinear_perf,
> > +                  cppc_perf.lowest_nonlinear_perf);
> > +       WRITE_ONCE(cpudata->lowest_perf, cppc_perf.lowest_perf);
> > +
> > +       return 0;
> > +}
> > +
> >  DEFINE_STATIC_CALL(amd_pstate_init_perf, pstate_init_perf);
> >
> >  static inline int amd_pstate_init_perf(struct amd_cpudata *cpudata)
> > @@ -107,6 +151,19 @@ static void pstate_update_perf(struct amd_cpudata *cpudata, u32 min_perf,
> >                               READ_ONCE(cpudata->cppc_req_cached));
> >  }
> >
> > +static void cppc_update_perf(struct amd_cpudata *cpudata,
> > +                            u32 min_perf, u32 des_perf,
> > +                            u32 max_perf, bool fast_switch)
> > +{
> > +       struct cppc_perf_ctrls perf_ctrls;
> > +
> > +       perf_ctrls.max_perf = max_perf;
> > +       perf_ctrls.min_perf = min_perf;
> > +       perf_ctrls.desired_perf = des_perf;
> > +
> > +       cppc_set_perf(cpudata->cpu, &perf_ctrls);
> > +}
> > +
> >  DEFINE_STATIC_CALL(amd_pstate_update_perf, pstate_update_perf);
> >
> >  static inline void amd_pstate_update_perf(struct amd_cpudata *cpudata,
> > @@ -326,7 +383,8 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
> >         /* It will be updated by governor */
> >         policy->cur = policy->cpuinfo.min_freq;
> >
> > -       policy->fast_switch_possible = true;
> > +       if (boot_cpu_has(X86_FEATURE_CPPC))
> > +               policy->fast_switch_possible = true;
> >
> >         ret = freq_qos_add_request(&policy->constraints, &cpudata->req[0],
> >                                    FREQ_QOS_MIN, policy->cpuinfo.min_freq);
> > @@ -376,7 +434,6 @@ static struct cpufreq_driver amd_pstate_driver = {
> >         .flags          = CPUFREQ_CONST_LOOPS | CPUFREQ_NEED_UPDATE_LIMITS,
> >         .verify         = amd_pstate_verify,
> >         .target         = amd_pstate_target,
> > -       .adjust_perf    = amd_pstate_adjust_perf,
> >         .init           = amd_pstate_cpu_init,
> >         .exit           = amd_pstate_cpu_exit,
> >         .name           = "amd-pstate",
> > @@ -399,8 +456,15 @@ static int __init amd_pstate_init(void)
> >                 return -EEXIST;
> >
> >         /* capability check */
> > -       if (!boot_cpu_has(X86_FEATURE_CPPC)) {
> > -               pr_debug("AMD CPPC MSR based functionality is not supported\n");
> > +       if (boot_cpu_has(X86_FEATURE_CPPC)) {
> > +               pr_debug("AMD CPPC MSR based functionality is supported\n");
> > +               amd_pstate_driver.adjust_perf = amd_pstate_adjust_perf;
> > +       } else if (shared_mem) {
> > +               static_call_update(amd_pstate_enable, cppc_enable);
> > +               static_call_update(amd_pstate_init_perf, cppc_init_perf);
> > +               static_call_update(amd_pstate_update_perf, cppc_update_perf);
> 
> I would rather add the static call definitions in this patch,
> otherwise is somewhat cumbersome to review the series.
> 

I see. Will move them into this patch in V6.

Thanks,
Ray

> > +       } else {
> > +               pr_info("This processor supports shared memory solution, you can enable it with amd_pstate.shared_mem=1\n");
> >                 return -ENODEV;
> >         }
> >
> > --
> > 2.25.1
> >
