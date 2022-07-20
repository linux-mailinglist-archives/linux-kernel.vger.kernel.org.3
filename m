Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5869857BB2C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 18:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbiGTQQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 12:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbiGTQQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 12:16:25 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C4631208
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 09:16:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eBBKjqoYxTFvK7IaLLn2pjNePHfaULLjaDYV9yOOkEA+dwD89ifxZdi4Wq1VRXBUazbZunV1s36IZo7L6FGlJcohuNLi3pmunG2lmhK1UFwTleRHy56OVS2Z83nIqqoHPVDv8arSZwvBH7WsZhlsf8MmyXO2+hubta42TalbsMZD/+PUGDD4rTNkuCPqRoEWc39WdBwkX2rm1MTgWFVCVJTRMThvw/CVOjC5ClTUqFK1AnFw5VyynqT63YAZDOvGGhdJBnRPYFymLBytRQ9iY3zrhU0RXHIFtvMhoGDlST3PTzvPdqBteVReXzou8+g4mkDPFUCVQP3uQYzaQ9mHHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W/oX6pZ33jkGPGBt3PmuX92XwWx3WwiKzCu35miQpcU=;
 b=CVL636PlehYTSLkKsJJUsQlXCPZxMHwsRb+zkQOB3TKaKUCS3V8B5jsydxpy+7JX67JmEml6jTG8yo5tkOlG+hv0wHu/FBLLZxZXsxfSUOe5zmABaJx1aBTAB/QFRKOPLcB7z6m4CZscCJAlisjNuJupnhkbGkm/zsjYWS7I2gj2khBJGKagCcZbenprr4F7qUUHArp4qOWPPNYYHLiPc9O6DlzX9clWE4hliE+UANwajGPiGqbDheKAhfbBiCYZvTU9SMmqyzNazG7HtRzAOv03oeqdf7agQk31I+6UeAfVIvybg81SojhP4pCRr8+w2DMq3+fTH5RWSBA9BsrzEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W/oX6pZ33jkGPGBt3PmuX92XwWx3WwiKzCu35miQpcU=;
 b=AyOWPbP/SV/fXndSmzWrQal/HQHEtKeGVgtWs7YsNJ4IZSFAKX+om7gNJq6t2tAwoxC182m08Y6y6j4RX4g0p65lZ3yhDlqiOpkQ8o+RZsYRpZzTHQ/AaIuo0/fXuqFbWHFmMjdbcgVIgcM2X7n+DXbvoSS6Ie9Qgnq0zgsmytQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3286.namprd12.prod.outlook.com (2603:10b6:a03:139::15)
 by DM6PR12MB4468.namprd12.prod.outlook.com (2603:10b6:5:2ac::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Wed, 20 Jul
 2022 16:16:22 +0000
Received: from BYAPR12MB3286.namprd12.prod.outlook.com
 ([fe80::54a6:6755:c7d4:4247]) by BYAPR12MB3286.namprd12.prod.outlook.com
 ([fe80::54a6:6755:c7d4:4247%4]) with mapi id 15.20.5438.023; Wed, 20 Jul 2022
 16:16:22 +0000
Date:   Wed, 20 Jul 2022 21:46:05 +0530
From:   "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To:     Abel Wu <wuyun.abel@bytedance.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Josh Don <joshdon@google.com>, Chen Yu <yu.c.chen@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 6/7] sched/fair: skip busy cores in SIS search
Message-ID: <YtgqRVDIGqCNJAZ6@BLR-5CG11610CF.amd.com>
References: <20220619120451.95251-1-wuyun.abel@bytedance.com>
 <20220619120451.95251-7-wuyun.abel@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220619120451.95251-7-wuyun.abel@bytedance.com>
X-ClientProxiedBy: PN3PR01CA0008.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::20) To BYAPR12MB3286.namprd12.prod.outlook.com
 (2603:10b6:a03:139::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cafdb8af-912a-43b6-f252-08da6a6b2f7c
X-MS-TrafficTypeDiagnostic: DM6PR12MB4468:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sBWE8R+Wtd5TPCoJ+NqrefbrBm0JZK4IJhyDAHjvFWMHG+yjKd/ssLXVKFph+RCyT4ojwT43y623to7tnQ92Fb6Eaz0k2VwiZrEqMUe7aQI07ih79IrVnFLpSERrXAJilRIXpl+af5DoSRA5H8lE7GGaTudjjTcluFfSeZRTcyudp/Xh4gfmvrKvCebOKnA8HuoHPnLtzEaAyEQF3XR8npr7d0ler67x4wyDbD0jYspM8/banDklljJLKEle/5gHwHl28oiQKBYnBwf8fmA+Vnn9b1ds+l7G18vWFRDuakrrVTD9+XN+bC4OOMqNfdRSU93x5FZFarkRSkNqpFHUAARYW2hYuzEU9Rlzh/tWdMejETjiAPRnf8maQUbFB5HIe/8oB9F/DTWJnkVerALu94zjU1iu6zdLRgp+5ncJnJy510I6tVEb4MJpBz2NeFLfar1niahie7x9s2kJ2YCuOTK03LfGfgPc+21+uGXb2gESL7X1I9VMsCTuRKJFnEJm3hVQpQBLBB/bVkKL8XGu60026NtkhERGUWG88JSYJo64MaMebDTLwWNCum/agIEDM7/2R4hGkbAvPfuys30rt/uCsDAhk/YEtSNKMG7r5Mix7eAdraFyU2/EcI7rCW3zeij4WwGeqo1VEyZ274oPbmXtaD6rGA4L+wCiiH0rBLAMai/B4oSW1jSDLQ4i6E98EgIVzSnyqtx+ywSCnt7osLfYA+uwdydXgHkPVqvP2Egx0W5IIRO1umlGmoMbfb2dfzNLmR8m1/YIt9viDTBo/gOTjUwNjgYUsjo+ChgUg6w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3286.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(39860400002)(366004)(376002)(346002)(41300700001)(6666004)(26005)(6512007)(6506007)(38100700002)(8936002)(5660300002)(6486002)(478600001)(186003)(83380400001)(66476007)(66946007)(316002)(66556008)(6916009)(4326008)(8676002)(54906003)(2906002)(86362001)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wz2BrSW3aeRhT9pXyIl3pRNFedpgURnfyzOD1Ly9Hp1TvxKasta30rpCUtB2?=
 =?us-ascii?Q?RebHUdO+gfZzP0dKZnKtLiR4NpFBHKc3I+h25Pr3LJmGJso0U7PX3+i8nyxw?=
 =?us-ascii?Q?lh2GQtDFr1vvjHB6sCG/ej7HFTO4esRXvPk89mcOU26gjRyTcSMCDPbNqe0a?=
 =?us-ascii?Q?ESHQnfjRM+FpIDfogjKV5alPC7DfABoBNswIz5bLS6ENZbHiTzGJRqprEpRY?=
 =?us-ascii?Q?0Jsg4jn+7wf1pYTs2D9sR/qAZKQ0LjHy3A+/HEdKb7QW7bmB39D+kZ4wT6Ig?=
 =?us-ascii?Q?qwa50NVZFW0e8DU7l3RAjs/SVqHNQJh+JSM94NCqx5UDVfGAtoux/2EiNTFe?=
 =?us-ascii?Q?MEU+rVSSQEOQjAlv4+wN8WwFmDrxSlkjYS04k+U/1aGxYeMjyVlZI4QeC6+/?=
 =?us-ascii?Q?a51zVJv0rRvD3T0fdWgg3FA7MQQgacYDEy/mWcrbhvqKpPz9CvEsYRNhwBM5?=
 =?us-ascii?Q?XFky5LZWbgrkW7l6FS1TrpszZ+dmuPD81KzJHNxuKDXyfBe9JTm/awpqxKY6?=
 =?us-ascii?Q?TJqDwsN131vCoHkNUoS5NYNlc051KcSwh3YPeRGlhR1QlhhLnlKYTYj73+3/?=
 =?us-ascii?Q?lkP+huP15ykobTh4fruFqPENXTKl7w/kVgNqpOj947b9+QbPqReKixwLHKQj?=
 =?us-ascii?Q?rfZGcmKucf8fkMKEg/9qFPqjWY2GfHgXA1yDHQdwQ72b/RktZjqzNb8JaRVV?=
 =?us-ascii?Q?afDbU06JlYf2DqCMzyyjuKgH43XTFI2s7CvR0w1mBER6nWkGp51VxAukXNVD?=
 =?us-ascii?Q?V/hwZdEU6WJ00H5DEV3csS+bPg0XeCPWOJSHiym9qwhPQfaGLpRJoj7F8FH/?=
 =?us-ascii?Q?/WJ2XwGcJdJG2G19/+19Kg/0ecKGcpE5P8klWI4nLHWFYAbrjP+uAqqP9ZeZ?=
 =?us-ascii?Q?ytB9V2xO3WFfu0BPcQiO5OmZXXAIFtbSRRgJSV6s0WNTJQxUbRDXfuOC+sVN?=
 =?us-ascii?Q?NyiFMLNQtItE2srJvlgPII+voskcWGl0NxJWadOZI2T0nkEXGxTS+ILiqzNd?=
 =?us-ascii?Q?iN9TF9AoeIsfPktVwaB3Igoh7J4hCGpiHOREy5azd96x/s/SmB38C6Q7Vz1f?=
 =?us-ascii?Q?jxuiAU2w+HfUdAw9TEDDEMh8+GBAmHdAFlx30tz4lC3DvpEW6TUCP8sx+lfp?=
 =?us-ascii?Q?YHCxalLDSEO9Uy+RFLlfxCkPGTA1zP8xy7cjPiHbvlmxbNp2jg3ZKZpHCoPZ?=
 =?us-ascii?Q?zK1TqpKJuDnPR1fYi3utf9NmmTE4A9EUoSWweBzY5EIyzCgV5EUOLaCe0bqp?=
 =?us-ascii?Q?nDqgD5dw1U5qoIYwfbCuUPExGBkyy5B5Xf35Mp36U0qJ9JUrT+we4/z0cqr3?=
 =?us-ascii?Q?orDvvFhph/+5QcadfCByedNYCSA1NCUFQbDyA48dl/j4ic8RtsZxXZGDHIuF?=
 =?us-ascii?Q?3saWlVa4G0cgwU6SKCPVkLYs0gkTvDpC+eqGm1Tb/SAPKML3c4oRCSAGV8m+?=
 =?us-ascii?Q?hHQkKThLLXJESdhN8CLga5LX0y+ywbec0tT+CG0YYUv3Gel5mN8lEALSvpDp?=
 =?us-ascii?Q?7rTFHzPzMz8OyIFAqQ/QFLmgalhU7SmPIcqFyoksazP6FR3BuVC/vXHDWmYg?=
 =?us-ascii?Q?WC532ElP6AQ+hccWM+qgYzQc/Dp8dLmgfsUpUSoS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cafdb8af-912a-43b6-f252-08da6a6b2f7c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3286.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2022 16:16:22.1171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TQRLjr1vEHtU3+JHL6k59lW5nkCdRnNxksSBwFptFaFbcvuGUveGqDOE+ndOtVcITXwvP0FPRnoQmCBORmgarw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4468
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Abel,


On Sun, Jun 19, 2022 at 08:04:50PM +0800, Abel Wu wrote:

[..snip..]

>  
> +static void sd_update_icpus(int core, int icpu)

How about update_llc_icpus() ?

> +{
> +	struct sched_domain_shared *sds;
> +	struct cpumask *icpus;
> +
> +	sds = rcu_dereference(per_cpu(sd_llc_shared, core));
> +	if (!sds)
> +		return;
> +
> +	icpus = sched_domain_icpus(sds);
> +
> +	/*
> +	 * XXX: The update is racy between different cores.
> +	 * The non-atomic ops here is a tradeoff of accuracy
> +	 * for easing the cache traffic.
> +	 */
> +	if (icpu == -1)
> +		cpumask_andnot(icpus, icpus, cpu_smt_mask(core));
> +	else if (!cpumask_test_cpu(icpu, icpus))
> +		__cpumask_set_cpu(icpu, icpus);
> +}
> +
>  /*
>   * Scans the local SMT mask to see if the entire core is idle, and records this
>   * information in sd_llc_shared->has_idle_cores.
> @@ -6340,6 +6362,10 @@ static inline bool test_idle_cpus(int cpu)
>  	return true;
>  }
>  
> +static inline void sd_update_icpus(int core, int icpu)
> +{
> +}
> +
>  static inline int select_idle_core(struct task_struct *p, int core, struct cpumask *cpus, int *idle_cpu)
>  {
>  	return __select_idle_cpu(core, p);
> @@ -6370,7 +6396,8 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
>  	if (!this_sd)
>  		return -1;
>  
> -	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
> +	cpumask_and(cpus, has_idle_core ? sched_domain_span(sd) :
> +		    sched_domain_icpus(sd->shared), p->cpus_ptr);

With this we get an idea of the likely idle CPUs. However, we may
still want SIS_UTIL on top of this as it determines the number of idle
CPUs to scan based on the utilization average that will iron out any
transient idle CPUs which may feature in
sched_domain_icpus(sd->shared) but are not likely to remain idle. Is
this understanding correct ?


>  
>  	if (sched_feat(SIS_PROP) && !has_idle_core) {
>  		u64 avg_cost, avg_idle, span_avg;
> @@ -8342,6 +8369,7 @@ struct sd_lb_stats {
>  	unsigned int prefer_sibling; /* tasks should go to sibling first */
>  
>  	int sd_state;
> +	int idle_cpu;
>  
>  	struct sg_lb_stats busiest_stat;/* Statistics of the busiest group */
>  	struct sg_lb_stats local_stat;	/* Statistics of the local group */
> @@ -8362,6 +8390,7 @@ static inline void init_sd_lb_stats(struct sd_lb_stats *sds)
>  		.total_load = 0UL,
>  		.total_capacity = 0UL,
>  		.sd_state = sd_is_busy,
> +		.idle_cpu = -1,
>  		.busiest_stat = {
>  			.idle_cpus = UINT_MAX,
>  			.group_type = group_has_spare,
> @@ -8702,10 +8731,18 @@ sched_asym(struct lb_env *env, struct sd_lb_stats *sds,  struct sg_lb_stats *sgs
>  	return sched_asym_prefer(env->dst_cpu, group->asym_prefer_cpu);
>  }
>  
> -static inline void sd_classify(struct sd_lb_stats *sds, struct rq *rq)
> +static inline void sd_classify(struct sd_lb_stats *sds, struct rq *rq, int cpu)
>  {
> -	if (sds->sd_state != sd_has_icpus && unoccupied_rq(rq))
> +	if (sds->sd_state != sd_has_icpus && unoccupied_rq(rq)) {
> +		/*
> +		 * Prefer idle cpus than unoccupied ones. This
> +		 * is achieved by only allowing the idle ones
> +		 * unconditionally overwrite the preious record
                                                 ^^^^^^^^
Nit:						 previous


> +		 * while the occupied ones can't.
> +		 */

This if condition is only executed when we encounter the very first
unoccupied cpu in the SMT domain. So why do we need this comment here
about preferring idle cpus over unoccupied ones ?


> +		sds->idle_cpu = cpu;
>  		sds->sd_state = sd_has_icpus;
> +	}
>  }
>  
>  /**
> @@ -8741,7 +8778,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>  		sgs->sum_nr_running += nr_running;
>  
>  		if (update_core)
> -			sd_classify(sds, rq);
> +			sd_classify(sds, rq, i);
>  
>  		if (nr_running > 1)
>  			*sg_status |= SG_OVERLOAD;
> @@ -8757,7 +8794,16 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>  		 * No need to call idle_cpu() if nr_running is not 0
>  		 */
>  		if (!nr_running && idle_cpu(i)) {
> +			/*
> +			 * Prefer the last idle cpu by overwriting
> +			 * preious one. The first idle cpu in this
                           ^^^^^^^
Nit:			   previous

> +			 * domain (if any) can trigger balancing
> +			 * and fed with tasks, so we'd better choose
> +			 * a candidate in an opposite way.
> +			 */

This is a better place to call out the fact that an idle cpu is
preferrable to an unoccupied cpu.

> +			sds->idle_cpu = i;
>  			sgs->idle_cpus++;
> +
>  			/* Idle cpu can't have misfit task */
>  			continue;
>  		}
> @@ -9273,8 +9319,40 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
>  
>  static void sd_update_state(struct lb_env *env, struct sd_lb_stats *sds)
>  {
> -	if (sds->sd_state == sd_has_icpus && !test_idle_cpus(env->dst_cpu))
> -		set_idle_cpus(env->dst_cpu, true);
> +	struct sched_domain_shared *sd_smt_shared = env->sd->shared;
> +	enum sd_state new = sds->sd_state;
> +	int this = env->dst_cpu;
> +
> +	/*
> +	 * Parallel updating can hardly contribute accuracy to
> +	 * the filter, besides it can be one of the burdens on
> +	 * cache traffic.
> +	 */
> +	if (cmpxchg(&sd_smt_shared->updating, 0, 1))
> +		return;
> +
> +	/*
> +	 * There is at least one unoccupied cpu available, so
> +	 * propagate it to the filter to avoid false negative
> +	 * issue which could result in lost tracking of some
> +	 * idle cpus thus throughupt downgraded.
> +	 */
> +	if (new != sd_is_busy) {
> +		if (!test_idle_cpus(this))
> +			set_idle_cpus(this, true);
> +	} else {
> +		/*
> +		 * Nothing changes so nothing to update or
> +		 * propagate.
> +		 */
> +		if (sd_smt_shared->state == sd_is_busy)
> +			goto out;


The main use of sd_smt_shared->state is to detect the transition
between sd_has_icpu --> sd_is_busy during which sds->idle_cpu == -1
which will ensure that sd_update_icpus() below clears this core's CPUs
from the LLC's icpus mask. Calling this out may be a more useful
comment instead of the comment above.

 
> +	}
> +
> +	sd_update_icpus(this, sds->idle_cpu);
> +	sd_smt_shared->state = new;
> +out:
> +	xchg(&sd_smt_shared->updating, 0);
>  }


--
Thanks and Regards
gautham.
