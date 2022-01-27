Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43BC549E64F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 16:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242892AbiA0Plh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 10:41:37 -0500
Received: from mail-mw2nam10on2085.outbound.protection.outlook.com ([40.107.94.85]:60096
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231428AbiA0Plg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 10:41:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bPpVX8BZ+WBokECcDxXi4NYPvm6iTs5Ly1TuNqUF8qkPkUfYz8pYRlZB64NA/Ri2/IF9BXru9hGBEr8N6uY1DxOWhzWvJJh/lN5KnBBUfyVHkre1h4UGEn8Jekp0syugqSur9piTwDjqPJIDVwmYVYOoKnJ7NU9q32EztmC7Mkw+LuolJNf189/k6PIyTvR5IWGJWi9fCs7XpfHxMh/QjfqOrN9GPHC8BobCH0hrQ8tb5ULPqxs+W2jHBD39DzSiRkbcQ9TogJN1hBGcaasWe9/f5GBo8mxItwckpXqW5GFRfAJ5BSX7e3sbOUdsj1RE+pYgCI8ilYG+AqTJAkfyag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X66fX6j8rAewf77D+IjJuxSL96WhYXDSG060i+vSShE=;
 b=ZYoki7YFJQ8NRbCWoc/kPjim1FkoRebQFnzLVI2jXWIQQLtbYE67WdvTut/+itYGxX2cn8ZIDB6Ij+a/cgYGM+WZkwvSS5PuNxvLz0aFpienDccZzfUmRB1r/TkmiMDhbB8LjflYLc0j7a1iv22Etfl6jtEHZ+ZdKs9ZBg4UvZYesDkaSFJm5YbrtsMYIlpnHSYf/WBkJvJt2sU2S500XpxMfSMeQ0Cp3lARHyI7XEENdiT6RyVxtub4hyG5mMiJOTzy1KBLtV9Rm5MmTHEHG8HU9dOdCy6z1vFH9BEKlToVuxfHiVsfFKSM/ydpryjzO43Ej7KFrA4wBU0MH4Ts/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X66fX6j8rAewf77D+IjJuxSL96WhYXDSG060i+vSShE=;
 b=KijLBtDGyoA3IwhDnqL9S89tEr9NsydttuyW/ePZNjlOGVlfEqaUtWYM6HfVgW+UpYMYOOGamEBuSBvGLIBYF9pVV6rPS0oTAPgIilsasUHDaC8sPnj8wz908LIz6Oq5dfOlCVOuqp76Jc5rIH4tKDZyUf7epweFk3ssNnuNbk4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3286.namprd12.prod.outlook.com (2603:10b6:a03:139::15)
 by BN8PR12MB3251.namprd12.prod.outlook.com (2603:10b6:408:9b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Thu, 27 Jan
 2022 15:41:32 +0000
Received: from BYAPR12MB3286.namprd12.prod.outlook.com
 ([fe80::88e7:cc12:9082:743c]) by BYAPR12MB3286.namprd12.prod.outlook.com
 ([fe80::88e7:cc12:9082:743c%4]) with mapi id 15.20.4909.019; Thu, 27 Jan 2022
 15:41:32 +0000
Date:   Thu, 27 Jan 2022 21:11:01 +0530
From:   "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To:     Yicong Yang <yangyicong@hisilicon.com>
Cc:     peterz@infradead.org, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, tim.c.chen@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com, prime.zeng@huawei.com,
        jonathan.cameron@huawei.com, ego@linux.vnet.ibm.com,
        srikar@linux.vnet.ibm.com, linuxarm@huawei.com, 21cnbao@gmail.com,
        song.bao.hua@hisilicon.com, guodong.xu@linaro.org
Subject: Re: [PATCH v2 2/2] sched/fair: Scan cluster before scanning LLC in
 wake-up path
Message-ID: <YfK9DSMFabjYm/MV@BLR-5CG11610CF.amd.com>
References: <20220126080947.4529-1-yangyicong@hisilicon.com>
 <20220126080947.4529-3-yangyicong@hisilicon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126080947.4529-3-yangyicong@hisilicon.com>
X-ClientProxiedBy: BMXPR01CA0040.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:c::26) To BYAPR12MB3286.namprd12.prod.outlook.com
 (2603:10b6:a03:139::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b2726d7-734b-4b29-8cc1-08d9e1ab7df4
X-MS-TrafficTypeDiagnostic: BN8PR12MB3251:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB325192204850F8F32CF408E796219@BN8PR12MB3251.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MueFBncUfopKV84+RokmoohLOp+GK0IqA/EnAAM7noCyA2J8i20CADD6rb3K4r9xJj8i4kqd8fPHdLAlqLb0tRquAgxF4aKZuWrrf+sn894UPJJLMPOd+5W5ba8VQN4undAO7iZ31f1016f5TBdZe2llP71diRUTtsPdcC6bs5HlgKkE/YRENvXwOvKXfpx4C6G0MHcVkYVz4RYN9Mwps28sMPnH/rnvZoE3pAz/WOYoP15GReUg4t4xKWc+EtbisamVaMM2OoduYGbN9rTI1qDcxzyctil6ezwosnsTsea0372prhLKWot8PZkmqJo/uWKuQY/OlJPaoebwFtVpsB1fIJ2u9jz3ww9SAvUPr5kPbmkE3EKon7EBoAlI2ibXWSzyv8UEfI8rEZIcOdWOlEc1rCh4gXlmCqKlo+lK+IhC+rVY20numn6EHozhX1imIGX6fgZccAQAKGDTQVn4KLl8V6dAFPHrBtG0wjOut5vSwUVlooyqIKOutRK5IbYVhG1WrO4DsV8L1sdN4OX92cEwhSIiKND16b0iet9wp1GrfiZdCJOu/8XqQcBKEk789Q2clpPafFfL+0LURw6AM3coVb4/dcBxfQDFPVDevF3hsa3gS+WO3nD0GPCfVgUzBK2OOaX51rTUlI3DIwKPWg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3286.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6666004)(6506007)(2906002)(6486002)(83380400001)(6512007)(508600001)(186003)(26005)(316002)(8936002)(38100700002)(8676002)(5660300002)(66476007)(66556008)(4326008)(6916009)(66946007)(86362001)(7416002)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IO6OMog/trIkDaKm/c4Bn8Vxp8dIyFzvG9k/39aiSgBCbDDxHZ9omBfnizKe?=
 =?us-ascii?Q?56rvPsiao8Sf6bvUkdkcqz04AsP5igjx8rcXGGx9YOds6XjzscyZRSTZdN49?=
 =?us-ascii?Q?RTVIarkAslOkaHj6pZbghjuwCMl6YU0VFfGB/cNJbLqSMyuE/eemQ+SgmYba?=
 =?us-ascii?Q?x0Fna90dLxf3uR+X8zorttB1X67e+AqhMsnIvTdQZ0aSPOV840OiZaMGjAFf?=
 =?us-ascii?Q?2qCEqsi7OVIhkUlI3XzVq1fc4L3UpA7U1EqziTlT6iJ0vTYwXNu1QT9jItkj?=
 =?us-ascii?Q?Kp71P87eabsrDQAzhkTScJxWTdY9nlXtEZssH9xO8l9/0M9Ouh0IE9b/xgJE?=
 =?us-ascii?Q?oSzkNqLg++j4HY0Gm2PHoLFgYV/yPfyEMjeOojVpVrM2zc+rgcCTluaLmARj?=
 =?us-ascii?Q?L76Gu1CbM3a1v5nUlzivsowtQacSUVOhAQ6EgskFwWFn9Qf0e18+Oay8pPBL?=
 =?us-ascii?Q?suUCIkAKnJoX/Q+iXhK9hXq9GR2hJb5Al36/eVipqNZHECWac5Iih7nVbgCi?=
 =?us-ascii?Q?BJx7E/tNW7RjawolCWePpvsSw1T9DcjKlrOlh3mSkQKmFY0fkPYOZWbUwNiF?=
 =?us-ascii?Q?XXRjuggeK1ygvNEHyDG9UR+yEIHQMAXXAw0Y6m36RoGN6k8ypG5x8McUEhzu?=
 =?us-ascii?Q?44udxCLD9waSdLoVHfsYCFVcyBKORJ2cCnvW9mQeF9ckHIS43/EEJAIpNSOb?=
 =?us-ascii?Q?2Ib70VW/7Sip/dJxs8Nf/WRfvfo+Fz/WTc25leExZjn5XzPOt3pAd1uKqXve?=
 =?us-ascii?Q?SbEhD7CIGNPnbKuaiv2KhjAit6V08MGAOKDZOeFaFIhFrJyf7Z4sdVnebR2x?=
 =?us-ascii?Q?MbYkto0WKnArwjw97KsJP6O29faY8fKXYjOeYr5qgoj1qmr2roUrGH7jYYlX?=
 =?us-ascii?Q?9/XHZAepzm6JDAJY4dpcrhRlc/3gfNR+gLu4IIC/0y4YmVntQwvGrQF2dy0K?=
 =?us-ascii?Q?LCfTN1VRZsMBbX5xk84EpH4umA7IunSsriskRZbSfHaxGD0FtEH3PGMhmMJY?=
 =?us-ascii?Q?Ai/1PCLnY1w+PA9Pd8/Jv70SEBelxdbE5cvSH1OBvcO/yNhp/SybaP+br4rf?=
 =?us-ascii?Q?gKZzCAVl55ORWt3XEecHwtEV+orzE2y7SMZuLtcVpoYIKO5yhr8NJHfs4Oml?=
 =?us-ascii?Q?ZN8Wl36nugHWigZ3B5YMNml+ChpX9nLLnl1ERktL7j0+x8hAh8pvi9LMoDvf?=
 =?us-ascii?Q?d+M4CbYpSV4v7i71V1lW5MaiokVjL9AbaA5TFaxSFVNnKDJallTngb6fdQ5z?=
 =?us-ascii?Q?zE7PRUMtLuUvFc0KITfJDToccZ14qYrhknRcRDVIC9elXRlHRADnBK37/eqO?=
 =?us-ascii?Q?yNlbVO9JkUxBcqcT2u4Z1RjBpQzdEliDy5A/49KgVPKQHVw7dMfYkmR5uqAj?=
 =?us-ascii?Q?BNucnN5TIjjao90ehCD4N5RSms92+hKrrgktKU/sl3ofQWq4AbMcrnMB0Vy4?=
 =?us-ascii?Q?1uVmdse1qWRIqmu5tKa1Tg9DS+e1tsXG5zS24ZzhLZfefXmoq9EgcRx6tbEu?=
 =?us-ascii?Q?FlUAeUEUq3Pdtgzp4jICrGeMTnZGyN2NRBXjOh1niAuqQ5zdOXaxW3ugz/hw?=
 =?us-ascii?Q?wiDpnNwBE/n094f2G4zOc7Mm1UessvZmPLUoLO/JjRr9XTU1NKDE18GIjK/b?=
 =?us-ascii?Q?w3MIM+K2VSp+cUbdVJ7acRk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b2726d7-734b-4b29-8cc1-08d9e1ab7df4
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3286.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 15:41:32.2377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kVyEr1Apvv7GUbvcKxnAFw20hZFhs+mdBTF6j5UHNvsnWUuLEEdVZzvBFJDW0j8yNUdfiRKdAdhzG0IxROfLDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3251
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 04:09:47PM +0800, Yicong Yang wrote:
> From: Barry Song <song.bao.hua@hisilicon.com>
> 
> For platforms having clusters like Kunpeng920, CPUs within the same
> cluster have lower latency when synchronizing and accessing shared
> resources like cache. Thus, this patch tries to find an idle cpu
> within the cluster of the target CPU before scanning the whole LLC
> to gain lower latency.
> 
> Note neither Kunpeng920 nor x86 Jacobsville supports SMT, so this
> patch doesn't consider SMT for this moment.
> 
> Testing has been done on Kunpeng920 by pinning tasks to one numa
> and two numa. On Kunpeng920, Each numa has 8 clusters and each
> cluster has 4 CPUs.
> 
> With this patch, We noticed enhancement on tbench within one
> numa or cross two numa.
> 
> On numa 0:
>                             5.17-rc1                patched
> Hmean     1        324.73 (   0.00%)      378.01 *  16.41%*
> Hmean     2        645.36 (   0.00%)      754.63 *  16.93%*
> Hmean     4       1302.09 (   0.00%)     1507.54 *  15.78%*
> Hmean     8       2612.03 (   0.00%)     2982.57 *  14.19%*
> Hmean     16      5307.12 (   0.00%)     5886.66 *  10.92%*
> Hmean     32      9354.22 (   0.00%)     9908.13 *   5.92%*
> Hmean     64      7240.35 (   0.00%)     7278.78 *   0.53%*
> Hmean     128     6186.40 (   0.00%)     6187.85 (   0.02%)
> 
> On numa 0-1:
>                             5.17-rc1                patched
> Hmean     1        320.01 (   0.00%)      378.44 *  18.26%*
> Hmean     2        643.85 (   0.00%)      752.52 *  16.88%*
> Hmean     4       1287.36 (   0.00%)     1505.62 *  16.95%*
> Hmean     8       2564.60 (   0.00%)     2955.29 *  15.23%*
> Hmean     16      5195.69 (   0.00%)     5814.74 *  11.91%*
> Hmean     32      9769.16 (   0.00%)    10872.63 *  11.30%*
> Hmean     64     15952.50 (   0.00%)    17281.98 *   8.33%*
> Hmean     128    13113.77 (   0.00%)    13895.20 *   5.96%*
> Hmean     256    10997.59 (   0.00%)    11244.69 *   2.25%*
> Hmean     512    14623.60 (   0.00%)    15526.25 *   6.17%*
> 
> This will also help to improve the MySQL. With MySQL server
> running on numa 0 and client running on numa 1, both QPS and
> latency is imporved on read-write case:
>                         5.17-rc1        patched
> QPS-16threads        143333.2633    145077.4033(+1.22%)
> QPS-24threads        195085.9367    202719.6133(+3.91%)
> QPS-32threads        241165.6867      249020.74(+3.26%)
> QPS-64threads        244586.8433    253387.7567(+3.60%)
> avg-lat-16threads           2.23           2.19(+1.19%)
> avg-lat-24threads           2.46           2.36(+3.79%)
> avg-lat-36threads           2.66           2.57(+3.26%)
> avg-lat-64threads           5.23           5.05(+3.44%)
> 
> Tested-by: Yicong Yang <yangyicong@hisilicon.com>
> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> ---
>  kernel/sched/fair.c | 46 +++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 42 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 5146163bfabb..2f84a933aedd 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6262,12 +6262,46 @@ static inline int select_idle_smt(struct task_struct *p, struct sched_domain *sd
>  
>  #endif /* CONFIG_SCHED_SMT */
>  
> +#ifdef CONFIG_SCHED_CLUSTER
> +/*
> + * Scan the cluster domain for idle CPUs and clear cluster cpumask after scanning
> + */
> +static inline int scan_cluster(struct task_struct *p, int prev_cpu, int target)
> +{
> +	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
> +	struct sched_domain *sd = rcu_dereference(per_cpu(sd_cluster, target));
> +	int cpu, idle_cpu;
> +
> +	/* TODO: Support SMT case while a machine with both cluster and SMT born */
> +	if (!sched_smt_active() && sd) {
> +		for_each_cpu_and(cpu, cpus, sched_domain_span(sd)) {
> +			idle_cpu = __select_idle_cpu(cpu, p);
> +			if ((unsigned int)idle_cpu < nr_cpumask_bits)
> +				return idle_cpu;
> +		}
> +
> +		/* Don't ping-pong tasks in and out cluster frequently */
> +		if (cpus_share_resources(target, prev_cpu))
> +			return target;

We reach here when there aren't any idle CPUs within the
cluster. However there might be idle CPUs in the MC domain. Is a busy
@target preferable to a potentially idle CPU within the larger domain
?


--
Thanks and Regards
gautham.
