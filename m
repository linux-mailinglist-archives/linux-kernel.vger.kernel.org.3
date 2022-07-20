Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C514557BA20
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 17:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240469AbiGTPea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 11:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235066AbiGTPe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 11:34:27 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A7D6112D
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 08:34:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OUqhqiSG8VGQJ9iafKICFY0qKSZmJHrDMWsLqbuBRVhcKqgW8SKC5DHLqt6GJDksg2koPKJzJz3l6o+AIudhdUvXVGyCBTHMYB7vmDtN1tawF92pHS4NS5zSeE9HRKYNd7PY1lrGgyAgCtZc2eMjoG0TWm4608Oh3GNDOH3ZRRJ8oWM/bDFt1R7u/UJDU/B8tzXWaHZmXqoCyxX9islxBrPxg7/+WkCwMBerz+du//FOUalbLyzKgjFqVBkvVpXuZexS837wa81n73bR/NlAdEzD4toP1uNC8tN1FYOVMMeoF1n4ohCKyd8gm2IaIpI+l+RTLRiL+9J0RWEzPj36/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ye/hzLxooGAqqT9LAm+3NqaSEUwUCIruieE55CwhFjg=;
 b=AIgH+/ohv2GDLIfrxlhP+B02BHcVk4KXqpvnPcIVKMUbEwsSBc9QAVdEPvbcMScsk4JNkY0fmsW4uGjnP3Ua76ZdrUxW53Hg19o3m1AK8Y3MoJcC4gsw9adLSEHCg/j3SjzRQQq/0ipTBQbJa/D50gPJBaVI9dNfmnUdu+3b0lrU7+viQMyZS0qNPwGpIU+ZKcmP8xzoSm8HIt/AOvZ3yPvK+pXZ7eieqwLkhp2qNy7zWco3wMfzTDBUWHWLwn4Zs1b6QJvr+YEUcb7PL8COZ9JhIFdh8FRdHHQ1NpZtvsyr8aIqSxgReCPZaq4MJzLsheuI6hRHQntLFKB9azGdow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ye/hzLxooGAqqT9LAm+3NqaSEUwUCIruieE55CwhFjg=;
 b=YYw/O22qAOckIClDmmHTmdQNVz6ExyBFKyzHxRf8Ns6anhjXFf1kdC6LxfnWsdnFf3BNr7wXcOeD44Kan8pZwekAl6Q9JIB0OEZQooB4MrohRQasTsx28WaQlQTO7qLvfszs4iXqrLIEhL3PYQ5aYRTfgu265HxoANNjZvezh1c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3286.namprd12.prod.outlook.com (2603:10b6:a03:139::15)
 by BYAPR12MB2981.namprd12.prod.outlook.com (2603:10b6:a03:de::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.20; Wed, 20 Jul
 2022 15:34:23 +0000
Received: from BYAPR12MB3286.namprd12.prod.outlook.com
 ([fe80::54a6:6755:c7d4:4247]) by BYAPR12MB3286.namprd12.prod.outlook.com
 ([fe80::54a6:6755:c7d4:4247%4]) with mapi id 15.20.5438.023; Wed, 20 Jul 2022
 15:34:23 +0000
Date:   Wed, 20 Jul 2022 21:04:08 +0530
From:   "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To:     Abel Wu <wuyun.abel@bytedance.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Josh Don <joshdon@google.com>, Chen Yu <yu.c.chen@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 5/7] sched/fair: skip SIS domain search if fully busy
Message-ID: <YtggcHGKVSbprXr3@BLR-5CG11610CF.amd.com>
References: <20220619120451.95251-1-wuyun.abel@bytedance.com>
 <20220619120451.95251-6-wuyun.abel@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220619120451.95251-6-wuyun.abel@bytedance.com>
X-ClientProxiedBy: PN2PR01CA0233.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::12) To BYAPR12MB3286.namprd12.prod.outlook.com
 (2603:10b6:a03:139::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd1db5a0-72b9-44ad-f571-08da6a655259
X-MS-TrafficTypeDiagnostic: BYAPR12MB2981:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sNu58qwlPTMMQKSGJ2HEvK+GVoxsHZ6iaAeO/4zZJRzBsLe4pYyL+EcBiq45lHKt6p4x/fuJSo2ge0VYNNliAcuOusXknqUxB3vkSwj/CqqQw+FTtsLgNh3pn66uIjbUq1jI9XsZD9bRVJ60VneeovtCYlKdiC7ei5xzTU0F5pUkRxZ9cDsv2j5xLecgb6k2rVQDbxkJ2/yboFQx+p964+UB9tWV9RZ+adiFSl4ULHb1ztZOgAJvIk3tmhuq0edbdQiodPaOufo7denVWgbCq7CBUQm5pGetFCKSlT4eGnWy/3TUEZfvpTc8tnLKwH8dKCIRCaDR9wlHJYZUvTahSFRPcM1eB52YcYo0p7oXCs1V67dd/Sz4K5VWrZM45IVGy/V4dznbyzilpuHWPlksZ6bJ6hpHbZyMvc3SkHqx09elTjeTtpVNv7syr77ydwn4Vbw4rQxzzLDXJkOHHQwVeKzkcFBRueOVwqWeJDfm0QcCOYc7RrlgaXnQPt8FnS//2XxK3nuVaflDNLrdxMKajO7rtCFeTFXdTaGABwSI/VH5Q/2GbCFj7cOYkRSzN+gO8dvi5QB3KLoGDGPG7QNH9wX7RK86l9OBv6inBBt55r17Y89as7msILcnId8TMyjS/nzD83A7nYwjARFl1TZ2hjGzU2drM3bZElXU5M4Xq6lPGdfHR3X1niFs4FnO50Z3s81g/mee7wgF9FX7sdqXvOYsfsW5toqp3RvtzIjJdmy6kwWa6rAwLAjaMppOreNb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3286.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(376002)(136003)(39860400002)(346002)(396003)(83380400001)(86362001)(2906002)(66946007)(66556008)(4326008)(38100700002)(66476007)(6506007)(5660300002)(316002)(6512007)(26005)(8676002)(6486002)(186003)(6666004)(6916009)(54906003)(41300700001)(8936002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KmYbaP7DInaNJJTp+OXV+KviILqILr6LMBks+FJTmnodW2PzC+SUUSDivnWP?=
 =?us-ascii?Q?D151fipuB6+8MqdyYK38c9FpmDSFH/1Dj5SHiDolXdpfs/IY2eUHyESGTjco?=
 =?us-ascii?Q?QvfLu4cFT0S7jktGk9vw1uoC+K1Wn78lJNghfg1gYuL2hitQBGfMLiwMXEm6?=
 =?us-ascii?Q?oue4hVQGgSSAl0+npvvyJsDTzn+DtwKfLsPrU+2VaYLfhhkzt8CSr8cyfX1w?=
 =?us-ascii?Q?viXklDlUHpCBpyNsovkaJtYaVFci+YQJZ93mwaUmGJQMapYGDnd+kVVpJ5kc?=
 =?us-ascii?Q?Bp3Cv3bv4HcO/9yh+PPC01NXkjrj9lQTQX8mUcszxPsQbWDUbUjHFd/HM8ac?=
 =?us-ascii?Q?aYv9drVMIctA8goyiS1iS0i+Rl9aHVVho0OaYzr9uTWiu5EFsusRys4fQSDk?=
 =?us-ascii?Q?XMEhByq/rZ1P99C8iQBIywxc0//Tqfcrt5CvtzhTMzZ5f+I5H4F82FVpRPYD?=
 =?us-ascii?Q?pIb7yBvLFI9OI/iOC60kkoDP5sVEPSCRT6sA2TDHsGWI6woYzllV/qAmdDSs?=
 =?us-ascii?Q?5d3S0ejQsXT2u8bEVo9C0gfvN/qdqAS9XH2L4Lihuo03BBJGjbZkre4Q5At6?=
 =?us-ascii?Q?w0MQxc8zo9iGI+yJjN0i0KeKOhJvL34MIw7/fTACialGsZMwbxwonX8/94Z3?=
 =?us-ascii?Q?tfipV/M+02BA9TlIqykPOHaGXGiQGjOSu51cGwhJr5rp5BIWYyFgxeKU6zM3?=
 =?us-ascii?Q?O9DId2cRl0UbDqMeu0SiQIfZoFhJA9ZRkGEycZ0oXgkS4wllTSqmEHBIsD7v?=
 =?us-ascii?Q?w0DOHbIOAVhVk77jYvPL/8JoLRFq+qr7Y09PJNs4r6twEBxY3zv/ocJhzTia?=
 =?us-ascii?Q?kI40zDHAmUTbf/nlQnHFA7Rheuqocymd/eYCdEsN0Hnl1H3oxeXEHvLn1j7i?=
 =?us-ascii?Q?EVvRULhBnLgn2rbXlaMi9FOXAaQ3WDoTsctcrEFR1GcNxOuezL96sN1IijFU?=
 =?us-ascii?Q?OzLPNaJk6dqoLauW0mJ4Bg7jLHdHLJHYtAdsGAc0Pn4DOglQLVwXUE1BrBx9?=
 =?us-ascii?Q?Rq1lIQQiN1s6z8O8RQEB8SB5pTOQ83+PmNjgJph1GVUCCpdl+YTvnNVbR8rq?=
 =?us-ascii?Q?Qxyhrq+tq3U3Y/0Zwj1N5d7XxkFGSUfx9YAWvhkVvSOoDqoGPtAC2UwuRbfT?=
 =?us-ascii?Q?rEL5fam6gICFGEZpEOn4eguSNuPynPI4YaZBm+6H2g2Y4GrseOXFuCfNi6mW?=
 =?us-ascii?Q?ccsSm+6HpuK5DqeOf2ImlTmyHREkvGVleN4kNFE0BPHVBOWB0W2wn/75maYv?=
 =?us-ascii?Q?CuLYusPwZzGAhKylPzWIdWAr1ThiTdC6N3qqcx8ewVVuYBP7lXLNLoXzVyPJ?=
 =?us-ascii?Q?2GTxVfIMKH6Y/0VNHJtTT42KE14OxTyqjNXc16U1bNKXboWNTGaxmVUwJ2my?=
 =?us-ascii?Q?c0I5sqr4buzYucr7QXGa0DLHs60VGjwsUv1LpkCEVyFpO1SW36cabICx+itV?=
 =?us-ascii?Q?ayvkZuDul/0M/me4dnY0GyyRS2wJOZ2F2UdIgn7Y0M89GII4x4nbMnNO+m0E?=
 =?us-ascii?Q?AnucQ3NWpW2A9iy6C1BYKGTqXm7NYTa7Jn9csP5CCNKyOzYznQvg/1MdX1UM?=
 =?us-ascii?Q?B6nuKu/CRC3qQSO/pri7hfIVhSfNNVtaQ1QLr3p7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd1db5a0-72b9-44ad-f571-08da6a655259
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3286.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2022 15:34:23.6902
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xp0StfGp43AyV30F45CUFXJe/QluewPP6lkev4FWsN46vUje6OphLyheO/3iEmYaWNYkaI96Z0RHwR+Mqyz65w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2981
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


On Sun, Jun 19, 2022 at 08:04:49PM +0800, Abel Wu wrote:
> If a full scan on SIS domain failed, then no unoccupied cpus available
> and the LLC is fully busy. In this case we'd better spend the time on
> something more useful, rather than wasting it trying to find an idle
> cpu that probably not exist.
> 
> The fully busy status will be re-evaluated when any core of this LLC
> domain enters load balancing, and cleared once idle cpus found.
> 
> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
> ---

[..snip..]

> @@ -6197,24 +6201,44 @@ static inline int __select_idle_cpu(int cpu, struct task_struct *p)
>  DEFINE_STATIC_KEY_FALSE(sched_smt_present);
>  EXPORT_SYMBOL_GPL(sched_smt_present);
>  
> -static inline void set_idle_cores(int cpu, int val)
> +static inline void sd_set_state(int cpu, enum sd_state state)

Nit: We are setting the state of only the LLC domain and not any other
domain via this function. So should we name it as
set_llc_state()/get_llc_state() for better readability ?


>  {
>  	struct sched_domain_shared *sds;
>  
>  	sds = rcu_dereference(per_cpu(sd_llc_shared, cpu));
>  	if (sds)
> -		WRITE_ONCE(sds->has_idle_cores, val);
> +		WRITE_ONCE(sds->state, state);
>  }
>  
> -static inline bool test_idle_cores(int cpu)
> +static inline enum sd_state sd_get_state(int cpu)
>  {
>  	struct sched_domain_shared *sds;
>  
>  	sds = rcu_dereference(per_cpu(sd_llc_shared, cpu));
>  	if (sds)
> -		return READ_ONCE(sds->has_idle_cores);
> +		return READ_ONCE(sds->state);
>  
> -	return false;
> +	return sd_has_icpus;
> +}
> +
> +static inline void set_idle_cores(int cpu, int idle)
                                                  ^^^^^
I agree with Josh. We can use core_idle instead of idle here.

> +{
> +	sd_set_state(cpu, idle ? sd_has_icores : sd_has_icpus);
> +}
> +
> +static inline bool test_idle_cores(int cpu)
> +{
> +	return sd_get_state(cpu) == sd_has_icores;
> +}
> +
> +static inline void set_idle_cpus(int cpu, int idle)
> +{
> +	sd_set_state(cpu, idle ? sd_has_icpus : sd_is_busy);
> +}
> +
> +static inline bool test_idle_cpus(int cpu)
> +{
> +	return sd_get_state(cpu) != sd_is_busy;
>  }
>  
>  /*

[...]


> @@ -8661,6 +8702,12 @@ sched_asym(struct lb_env *env, struct sd_lb_stats *sds,  struct sg_lb_stats *sgs
>  	return sched_asym_prefer(env->dst_cpu, group->asym_prefer_cpu);
>  }
>  
> +static inline void sd_classify(struct sd_lb_stats *sds, struct rq *rq)
> +{
> +	if (sds->sd_state != sd_has_icpus && unoccupied_rq(rq))

Nit: sds->sd_state can either be sd_has_icpus or sd_is_busy. So for
better readability, we can just use the positive check

        if (sds->sd_state == sd_is_busy && unoccupied_rq(rq))
	       sds->sd_state  = sd_has_icpus;


> +		sds->sd_state = sd_has_icpus;
> +}
> +
>  /**
>   * update_sg_lb_stats - Update sched_group's statistics for load balancing.
>   * @env: The load balancing environment.
> @@ -8675,11 +8722,12 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>  				      struct sg_lb_stats *sgs,
>  				      int *sg_status)
>  {
> -	int i, nr_running, local_group;
> +	int i, nr_running, local_group, update_core;
>  
>  	memset(sgs, 0, sizeof(*sgs));
>  
>  	local_group = group == sds->local;
> +	update_core = env->sd->flags & SD_SHARE_CPUCAPACITY;
>  
>  	for_each_cpu_and(i, sched_group_span(group), env->cpus) {
>  		struct rq *rq = cpu_rq(i);
> @@ -8692,6 +8740,9 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>  		nr_running = rq->nr_running;
>  		sgs->sum_nr_running += nr_running;
>  
> +		if (update_core)
> +			sd_classify(sds, rq);
> +
>  		if (nr_running > 1)
>  			*sg_status |= SG_OVERLOAD;
>  
> @@ -9220,6 +9271,12 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
>  	return idlest;
>  }
>  
> +static void sd_update_state(struct lb_env *env, struct sd_lb_stats *sds)
> +{
> +	if (sds->sd_state == sd_has_icpus && !test_idle_cpus(env->dst_cpu))
> +		set_idle_cpus(env->dst_cpu, true);

We could enter this if condition when env->dst_cpu is the only idle
CPU in the SMT domain (which is likely to be the case every time we do
a NEW_IDLE balance). By the end of this load-balancing round, the
env->dst_cpu can pull a task from some other CPU and thereby no longer
remain idle but the LLC state would still be sd_has_icpus.

That would mean that some CPU on this LLC would do a full scan during
the wakeup only to find no idle CPU and reset the state to
sd_is_busy. Have you seen instances where this false-positive pattern
can result in wasteful scan thereby cause a performance degradation?
Ideally it should not be worse that what we currently have.

Apart from this, patch looks good to me.

I would be worth the while to explore if the LLC state can be used
early on in select_task_rq_fair() to determine if we need to do a
wake-affine or allow the task to stick to its previous LLC depending
on which among the previous LLC and the waker's LLC have an idle CPU.

--
Thanks and Regards
gautham.
