Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 399AC5ADDE3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 05:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232647AbiIFDTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 23:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231570AbiIFDTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 23:19:18 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E61526576;
        Mon,  5 Sep 2022 20:19:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BcPdsKFFQxpM93SM/uNcTGOpF8gL7x7RejIUrvYLrKDalhhkFptPLnZW2NWCwaOLO0IbVbFwY4m7p4lsrs7LzPtYBUZYrX1s5aQ797llb1Yv/WJjiqNSj4/vVgIAZsUfYsGnD2sfimLH5sBs6RbPMwwEE2s8bhvBBfLmnw/J4dKCiul73a9S5DiCIbo6wgdVy2DZr+DtJMh4Clxlaz/Q+zDAFycpMq2ztB4ZZkvOe8jxKaeu7nEbQJCT2vi5bLysZdFiKplwJXnET1k2mZCJV4U2Sc37LBdWrkufXIHGQBqOG3CrW3BQawAlvRTnKafTj48dRBBg4xWNbrHJLJLeYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B2mMQHV4zfxseO6vW48cEkZwrkilUJnqLxwiiYc9og0=;
 b=W6idxFlOVry5MYdfwRC9MQnyhWrmFstaY+mt8Z/zHn4X0kI61lWbw52Jeq47pJ9Ef6nLVoEcXlZ2MqwMxPhHuN0bOnj4evCdca4KhUKL+oT90P/zhGmySNTliBrcKCuSY0/BMQP1aKVVCp9O3kEoMDxIsb6FBBI1I7bTKQRorYF0pcgEif+8pn5UcUTWJMpKbK/FtjdfpwRTmYr4Y6SYE90z+fL72yKqf+JJTg8ASNUwAbPT5/8t/uml0e9vOev+03zzDt+1J6gnFyQPTP/7fVVOQJ5mMOt+KJO8GVkJczS0PAq9jLCjPLsXpfm6g5M/ERXsFn2kQKBidz8WJiL1ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B2mMQHV4zfxseO6vW48cEkZwrkilUJnqLxwiiYc9og0=;
 b=VO5MRf1Xlz9vG+UykvZog1U58fx6lmkdFAwr4rz1Nt7pW34LH+WoTQNkheuRzdEZUgWl3U4NR72WpguK/dVpNeJNQAGsRrB/z//DfPXN8VxoigOhK/LWr1wYJQ44tCorL+aPP1mbmJvfLQl/rvbyFqmkPXdwQkK7CJhMzmpQYdU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 DS0PR12MB6655.namprd12.prod.outlook.com (2603:10b6:8:d0::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5588.18; Tue, 6 Sep 2022 03:19:15 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::cfb:b63:3255:646c]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::cfb:b63:3255:646c%5]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 03:19:15 +0000
Date:   Tue, 6 Sep 2022 11:18:49 +0800
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
Subject: Re: [PATCH v2] cpufreq: amd_pstate: Fix initial highest_perf value
Message-ID: <Yxa8GTmbMvMTOmjG@amd.com>
References: <20220829055901.24593-1-Perry.Yuan@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220829055901.24593-1-Perry.Yuan@amd.com>
X-ClientProxiedBy: SG2PR02CA0023.apcprd02.prod.outlook.com
 (2603:1096:3:17::35) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3ad4b792-ef7b-4152-b8e0-08da8fb693fa
X-MS-TrafficTypeDiagnostic: DS0PR12MB6655:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GVKxUc1ldGMhmZZR09dKLRVaNZU3iIQOOocU2JfPVgNVMERCYWKzwlwplfFJFd+2OgeCLNEKBX52wB2HFixORs9GVbpVks6uNbGrQI0NMwIfJ3D4/HtiXySCVJG/ddl4/wuHSX1vLoMXe1znjd8FQm8MgLL/gHqqoB5x3woxGG1IM/bP2ezWv+mhdXBzsBao6boiepEuQuJhrroy7guejpuxNGBKA/mBAA3JpWMQBeydQBlnBAIDxVqgC+4gFm5+HMhrXcaR2CPbDrfDEjLKGitFA14nZPmcjIhBkH6+3bxToQqWIEf6Pff5nalusnMRJ3goAgS/JzjbW4sKJFTdcncenHzOLMpn6gk9/kM+3VRbgq8yyjIYqEK1SarylM2PSPkG0WS9qYeU4cegdBH6+p7NdMv9UrTLKFaS0d5pWZ+9eZ04nJ/MknWPQ+tlbgemID5kVs2xFOR6bHVsVMyTvaf/hnfx61GCX8NWYGaQfQGvuh7BNdWtBre4PWBCr2yPZs4cho9fY0d6KY56PUqLy8wL+AVhygrL1ixNaFn02YI3gWtnigwqU1tRftk7owG3FFKMRYiWPkjyf1ezDhvj11qo4mvDQN34XEvcTO2OjzymlVn8GPmh6HXuYaes/3lXn/pC2x/Cvv0IdyVEXwni4UE2xB93EG6cRQa8MptHR85CJrMAYm2VgHL7jtescL1v4XXQeuETBvmWWtaP5rhnYw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(366004)(136003)(39860400002)(396003)(8676002)(4326008)(66476007)(66946007)(66556008)(2616005)(38100700002)(6486002)(186003)(41300700001)(6512007)(6506007)(6666004)(54906003)(316002)(6636002)(83380400001)(26005)(37006003)(86362001)(8936002)(478600001)(5660300002)(2906002)(6862004)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i6GoGDfZeTXBx4cG+ZPObqZ1MQe2NZG3Myf60my8oSVf+Geg58EZ8+oKOjdN?=
 =?us-ascii?Q?KdVdOxVChUrurOKKvuskgYP8HnP80+NPuPYgUJ5/BDLtCIFXnTbAzwZcllWv?=
 =?us-ascii?Q?6JXkS4nwvz8Gi5N54S68jozETfMRUJqzow+/EoTYSwk28NmZbMUeOPs4V0Ev?=
 =?us-ascii?Q?Vjhg/vD5xyxIJqydJfAKXLjWMB5se2jT1yW7785cvVwKcD0oGejZUbFF3Lak?=
 =?us-ascii?Q?9j3mE5o0k/l/CV35aEicjWZto1Kh+JjvQXrAJoTSFUgn35LxcouSXG2QsgTO?=
 =?us-ascii?Q?oJeJM9lPIj7lXvrwhA2z3efeaQVOy1VU8NHR5nEEyeIAtS8BvcuuFnB2nn/q?=
 =?us-ascii?Q?mxxIlJYrMScq4SeCjRNKoh2ere0hd7AKASQ2fdCW4cN5iiAtUxC/PM3CZrFt?=
 =?us-ascii?Q?azRBlYRX0cV77gYaZAUbiRY7yDGe/KIQ0oTiNEU7+CLX+ogfzONhmFJaNXNk?=
 =?us-ascii?Q?QnvT0MxeYbHLIZtGpxsPL83r15pipZRoHjB+kBJZ7MQfcNYyNn6m6eUhEJuu?=
 =?us-ascii?Q?/B8r+aiZ9sQxWVnk94Liw/uUJDwQnSkwUnG9AUNNZRw6Jc+ZyHTeTK/SxtPn?=
 =?us-ascii?Q?oxQPrASugiSPbw+1Wb4Kc4+D07CzJ5qADmYWC9wxCh9627PzXxHqeae4NOXg?=
 =?us-ascii?Q?afMy98xE/QESbNwU8PkncgL6rPvDFP7bhjqEJRWLcpt6BVe9CaWqprd1Jt5e?=
 =?us-ascii?Q?K45dlA5GwL/J5IVK1w7lyR1s2DKJmeA3ZuCozTiSsxMbWmksx3HeJITCpZvX?=
 =?us-ascii?Q?LXnl3lZz7nexQzSQkAnd8E8i4MeyD/DUTaWNr1Vma9IyHGMQh2mb9uAAqljv?=
 =?us-ascii?Q?5OaBG9RXnPekRVQOMRvx3u/TrHLVPxVHidtxf4pLF4Dcg3reLmYxTnQme1sm?=
 =?us-ascii?Q?qt1NLtfgwllC6FzwFtlHgl3/Dk5i1Pk+VPHWVFObX7w7Rg8hcwlQeF/+c65G?=
 =?us-ascii?Q?uqEuosdu0clYj7CGtfIijGPWRkJhM4nAX8Sw5fmsYOxDwJbmVaqNcj6t+XGB?=
 =?us-ascii?Q?O8UvRS2zDdJW+i4NLR26yAklv6vsBUkwAHBF5LYNbIwJwpsBE8gXzObkE5i0?=
 =?us-ascii?Q?bhEb2Hz9y9GQiwLGVNArfBz3+3BfHt55o4hx9ZiJgEw3lP7cfFXU4NECrttz?=
 =?us-ascii?Q?fq0nxhXJx5M97GSEodhmiy8V33P8xzO+HkgIFMYrvpNOzUrmVMtJ2yP8zXL4?=
 =?us-ascii?Q?YHKjxKSBBmOGWLdCpV+NRU3HQUtCACe7ZU14VvqFMgkRqiaRJVxym9va1+Ms?=
 =?us-ascii?Q?Gqs57nYV/zY+MTTxKtACdGa0XfU8kl40BZk5IkkuxZ3DCssUjzSRaPdKI78G?=
 =?us-ascii?Q?Z6h0DD417mguEJJgTybCcDB0xZW8ATeRgVhbRrtL7XXjBjdjJebztEAtn62B?=
 =?us-ascii?Q?48gUzRm8B2U8KlLqwsFv9a2D7WnU+DErntW2M4frm92mTLDyCXtTEj7ScqxC?=
 =?us-ascii?Q?WMyTmMrHJJlsr9TjqQxfUMCS2zvj6ciziEUCRttHgdy1gzbpEYh70F4g/VJT?=
 =?us-ascii?Q?NgJxWgP+C720sghTlNL5pFWNxFcYhko8YBIFerqcT3jCSonqO261BMaWbs0H?=
 =?us-ascii?Q?5Hnr/Q4HmxKMZ6MXaPHGomWGE6CjpInKwPDYphoh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ad4b792-ef7b-4152-b8e0-08da8fb693fa
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 03:19:15.8504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /HJa8L89NWlOxi76/r9uxtjdh7OdPWERaWTl+hsqEo2gQpbWPAYXq1dTeMy+ciqL5XmOtWn0H+cOVYCZ6FSv/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6655
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022 at 01:59:01PM +0800, Yuan, Perry wrote:
> To avoid some new AMD processors use wrong highest perf when amd pstate
> driver loaded, this fix will query the highest perf from MSR register
> MSR_AMD_CPPC_CAP1 and cppc_acpi interface firstly, then compare with the
> highest perf value got by calling amd_get_highest_perf() function.
> 
> The lower value will be the correct highest perf we need to use.
> Otherwise the CPU max MHz will be incorrect if the
> amd_get_highest_perf() did not cover the new process family and model ID.
> 
> Like this lscpu info, the max frequency is incorrect.
> 
> Vendor ID:               AuthenticAMD
>     Socket(s):           1
>     Stepping:            2
>     CPU max MHz:         5410.0000
>     CPU min MHz:         400.0000
>     BogoMIPS:            5600.54
> 
> Fixes: 3743d55b289c2 (x86, sched: Fix the AMD CPPC maximum performance value on certain AMD Ryzen generations)
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>

Acked-by: Huang Rui <ray.huang@amd.com>

> ---
>  drivers/cpufreq/amd-pstate.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 9f4375f7ab46..30fbd30c0949 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -354,6 +354,7 @@ static inline int amd_pstate_enable(bool enable)
>  static int pstate_init_perf(struct amd_cpudata *cpudata)
>  {
>  	u64 cap1;
> +	u32 highest_perf;
>  
>  	int ret = rdmsrl_safe_on_cpu(cpudata->cpu, MSR_AMD_CPPC_CAP1,
>  				     &cap1);
> @@ -365,7 +366,11 @@ static int pstate_init_perf(struct amd_cpudata *cpudata)
>  	 *
>  	 * CPPC entry doesn't indicate the highest performance in some ASICs.
>  	 */
> -	WRITE_ONCE(cpudata->highest_perf, amd_get_highest_perf());
> +	highest_perf = amd_get_highest_perf();
> +	if (highest_perf > AMD_CPPC_HIGHEST_PERF(cap1))
> +		highest_perf = AMD_CPPC_HIGHEST_PERF(cap1);
> +
> +	WRITE_ONCE(cpudata->highest_perf, highest_perf);
>  
>  	WRITE_ONCE(cpudata->nominal_perf, AMD_CPPC_NOMINAL_PERF(cap1));
>  	WRITE_ONCE(cpudata->lowest_nonlinear_perf, AMD_CPPC_LOWNONLIN_PERF(cap1));
> @@ -377,12 +382,17 @@ static int pstate_init_perf(struct amd_cpudata *cpudata)
>  static int cppc_init_perf(struct amd_cpudata *cpudata)
>  {
>  	struct cppc_perf_caps cppc_perf;
> +	u32 highest_perf;
>  
>  	int ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
>  	if (ret)
>  		return ret;
>  
> -	WRITE_ONCE(cpudata->highest_perf, amd_get_highest_perf());
> +	highest_perf = amd_get_highest_perf();
> +	if (highest_perf > cppc_perf.highest_perf)
> +		highest_perf = cppc_perf.highest_perf;
> +
> +	WRITE_ONCE(cpudata->highest_perf, highest_perf);
>  
>  	WRITE_ONCE(cpudata->nominal_perf, cppc_perf.nominal_perf);
>  	WRITE_ONCE(cpudata->lowest_nonlinear_perf,
> -- 
> 2.34.1
> 
