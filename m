Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0335D4C2461
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 08:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbiBXHLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 02:11:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbiBXHLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 02:11:06 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05505230E48
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 23:10:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Koy543w8iCKnvN1ShaMwFG5kRWEYh8hWeb4slVA84qzMcuX/5qPQp8NM++exuJXFeZhluEHj2h1pG+3j5P4Pvv86m7INcky9nj5GJe595OBZad9tDUd/2prJCEBBzhbstnhETEhcA+rMFc+4cpgiPROxKCLLRW48ROAqYUDN3QOmPzZ1IFuVr0UNZDwwg9QruyrrIJbipzelUPBr+4MQzzt4FP070MA/ifyKt1JDZhL/1YPLS2xMl1J+quUa1aIHrlkpjs+hrlCFIG/PDjGdfsYK+XqBNAY272B3DvrnnFZZQKn2JNNY8qozxKEKO/7cnHfnDzwFLtCO3uw/LbGsLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lUZKEGlOF9YvYmCKgQ+WuSLmetOPuUwFABNkoF9Kj08=;
 b=hjlQG2bk+ATLpuPqtacFl3uqdGpdhVNr66lIDFz7e6QDB4GJjQHKEbQ/eCgULXhzGN3W/39gWv0Cqymc7oTXvxwGCtnaqcsYJv7IOuxieF9O4PhZrCzx8pF8YQe5gvazcXDDuQAPwwT3ouP5HrP0Tlr9JIts4/q9E+5Hv0VicxKmLpjMJuB6MhQB/2MC5WqjhAh62nO8T9qnP7fnR7q+UFaiAnzGnsQ5gOqEu7a9TAhhjvQBG4ZtIzcKQaPA/bIdPyDZ3sZmi3WvcyWX66H34mgzXIcio/NbN51xsYBFipAJx5hiMn7jPZ6KOvMxmpAzYa2aEwqhbPTa7+rnMqvu2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lUZKEGlOF9YvYmCKgQ+WuSLmetOPuUwFABNkoF9Kj08=;
 b=CtVqb4AJ7VkqEfjpTllZhxm4pPTGKo8DvRj16TYro4fXSG1w5nnfIf1xI8Gjk5ZcQ12HBjScO5f7DL7/1CffRu7uY8MV7JQcRmXX8JI0aF0dLYgwfrE1J9Hhj8uVgECAYhJWMu+w6i5Hz4mV3m0QsfSqpQ8pfkrx68CckzvZS5A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3286.namprd12.prod.outlook.com (2603:10b6:a03:139::15)
 by DM6PR12MB4580.namprd12.prod.outlook.com (2603:10b6:5:2a8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Thu, 24 Feb
 2022 07:10:30 +0000
Received: from BYAPR12MB3286.namprd12.prod.outlook.com
 ([fe80::84ae:1499:eca9:558b]) by BYAPR12MB3286.namprd12.prod.outlook.com
 ([fe80::84ae:1499:eca9:558b%4]) with mapi id 15.20.5017.022; Thu, 24 Feb 2022
 07:10:30 +0000
Date:   Thu, 24 Feb 2022 12:40:09 +0530
From:   "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To:     Abel Wu <wuyun.abel@bytedance.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org, srikar@linux.vnet.ibm.com,
        aubrey.li@intel.com
Subject: Re: [RFC PATCH 1/5] sched/fair: record overloaded cpus
Message-ID: <YhcvUV/jW7yr0Sn+@BLR-5CG11610CF.amd.com>
References: <20220217154403.6497-1-wuyun.abel@bytedance.com>
 <20220217154403.6497-2-wuyun.abel@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220217154403.6497-2-wuyun.abel@bytedance.com>
X-ClientProxiedBy: BM1PR0101CA0038.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1a::24) To BYAPR12MB3286.namprd12.prod.outlook.com
 (2603:10b6:a03:139::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 502f5b24-b0f6-433e-cb33-08d9f764bd94
X-MS-TrafficTypeDiagnostic: DM6PR12MB4580:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4580855D9E2A523B06AB2934963D9@DM6PR12MB4580.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jMGSb1uugpiLzVcSVasxrW4DS9S41ET+ET7SkDe4bFuaGTkzFKrkOI49tzsBHWc7Ukzn9zY9FL5n9kQQBznITifpIF2eIuvb/k+VXtiO3rMtIOdJFGI+R0jis83WVR9eZHkYpzzdqHeOy/jT8J+dI+pv065JP+9O4uaWKxjgAY7lfVX4Gk/RsG30xLYI2SI1YXDwPW5wne37kyOhrakZi+qMkh1OBWi+EyykPBExe7DEaC/hVpNCyKFnazLdrbFJsDHkFDuMgcgYxv5BaPyq342AkSJL460+6w1rPtL1+MEDO8h4AGVPAyh6eY4VgWVlvIBlM6Sq8l7gLNUKw8jz48//VIwnn4aFozJfwNnz6550iFw5i6OlfxjfHUvWOvFqbVTReCRopgwz/F89Wa356GzSXJXvz3PutkpieAa6uGMX1ydmMvBOTYzIj/ie6JW1RmRPNELuT63a6HY2DB0fwzhZ5/bNrUPiGOJher6VjMxQxqhmqJBigm173GN32xdmxQOzVXgDBTI2s0ZLu+XpVbx9CRDnb6V99hx/9n0VOLhxaz/lwRCw3AVnAkSmDOOIDn+JOck+qJC29fCP1hzBQwIpVizgGICwz9YetOk3HsWJG6kP59zhAk6qyCyAhDhfXc+c8COE5Yfzr5/muD6GZbg7sUMltyzRbg9dcUlpGU3wNp9n9OvwNicQ17v5MMuVnvgPynYyFC7wR/cglHAGu9U55facKB7eiNj/PbNNlq9v+ISzjo8YZXquUlUk7SePno9rRFdMsdd7jApSdsx+Cg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3286.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(54906003)(6916009)(86362001)(316002)(8936002)(6506007)(66556008)(66476007)(8676002)(4326008)(66946007)(6666004)(83380400001)(6512007)(2906002)(7416002)(5660300002)(38100700002)(26005)(186003)(6486002)(508600001)(966005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jBvdgJyqfobwag7GJ+W8gduJLh3elE+kl9I1bakSaukyf8V/ZvmNtmCwM5DL?=
 =?us-ascii?Q?A8juAivDmPzZ1Vqvn/oJLztVnvIHSMK5vZs385Tz/s7dvW4JPolutr95kXk5?=
 =?us-ascii?Q?wg66o4zxHu1/lLZDj/ZBThpkLGTPzRJilHpolSHWYi8IeIB+ZqBWZ3WZZUAz?=
 =?us-ascii?Q?uv6UirNvQkM+QF2SY8/Gce4xzKQmgATBDZDuRov8s7TdHHP8qnZ+JSPEaxnk?=
 =?us-ascii?Q?aYpsHVWnnoSfvFOhdIwpPYcJWVY35/VeiZpx2trS3CU+I+oh8P5P2RA+b17f?=
 =?us-ascii?Q?Gtr/CIaHMu3a4l1SXETpMYj9KrGEpa6vM5Kt0gh8V7ogO8OSmFzj3JGlmI6/?=
 =?us-ascii?Q?iGLZ+B21fVB+fSSeiOeUQdXX56CDX+WgajpwxIYrybGa0e8Mgy2q7ZMpBhzy?=
 =?us-ascii?Q?8v+tzLMtFIYrNfp7s9pSKxT9emIwwiBJSrQjENKaqgmIWFQlXqUPpHzubmyg?=
 =?us-ascii?Q?MVyfePNd61gH2o/CIDp0zMuLSnM/kXlEdMy0ZbzLnv4E6jpPlS9bItg3RWDT?=
 =?us-ascii?Q?I+saMzb+oV0TpWqvHrvOX9xMQ6DYXJIqjHMedZ1ibpkNdKAp4cqRK61xIuWH?=
 =?us-ascii?Q?ZXZTI3nNydIgx6gvGzE1RI+cBl29eAYi0HP8odiNsr6HK6OGTxhWIp6XMkS6?=
 =?us-ascii?Q?8tdTKXFKK3xxlDTgvvC2V7WE0d/Kztmq1PIBPOd6HIfUqQtFia4/4MrkfDkI?=
 =?us-ascii?Q?hrLZsWBOdv19Yi/0CMS2g7NCy4DvIG0pEzug+mfH7sfEnR/763jga6ypTjx9?=
 =?us-ascii?Q?etYVkqGu5nbTwZb+aCjio7TtJ53se9MsPS0z4XQY/Af0WfQ1l1Wb1SBm9diE?=
 =?us-ascii?Q?ynb2MKurnqOq+osSIDg5ZSxjEyGtZCxAat2k3rBESKtEq/cIkjLS7QcCFyfp?=
 =?us-ascii?Q?KcfdKArU6jNnEi19kTE993evnLCmUyLOX1IDd7fMI3E94G0Rl7BUWXny1XbS?=
 =?us-ascii?Q?GzcX0ukg11L67kIL9R28cFDqI+NLIvmcJy0o+PufxHpRjDxEDBz0VayAbD+i?=
 =?us-ascii?Q?w80u+x65Y5OgPM6HkScR6DUB4H5tx34mCdg51tXMDbCW+3abJKeoCGsAK++e?=
 =?us-ascii?Q?csoEFV0ziCnjijlyaAA61BIymS5A7uZgxAz8gUpF+O7qqWTJwPah9shyPVUP?=
 =?us-ascii?Q?Uk+9uQQ19VLbS8N5YzGFOaBBAWdM7sNth3XRzmGLEzn9OSjsvBGJ5O0/+rrM?=
 =?us-ascii?Q?i9vWYNsXc9T5eR2hmnPnHvGDqaiedKztDyGm9mofAa/j/c4QBIPgdkxDpV27?=
 =?us-ascii?Q?55UvSd/LwDtQ1lmoyOA09ATcXWwb4Sm5CpLd34pntBCElDwlVomqaA7nKGfd?=
 =?us-ascii?Q?ot3Dxax9QSLU3KuOW7ErnPLaXbTknkKCVTtbEGKYZxNvJV3oNwL/aRpXxUU3?=
 =?us-ascii?Q?3up5A0y6B8oBWrR/CEEnvZutG0sNFVN0K/GbYvgZx5cylFzCUFOR0rg7yGl2?=
 =?us-ascii?Q?bRybf4GCADsN7ISvAgFyy13mtVmCh8Z9zZukHysgkfkmeDEmuvhtSBrcsC07?=
 =?us-ascii?Q?aNbjIaSfmxEE841FInR5ZRoX9ZgBNR9aMou+za3EsknNXILCKPgdx417camc?=
 =?us-ascii?Q?3FdJhdpqL0tGFDIw4cH4aLrRAknxAf7RY1mXrEpZJQ4+JMbAVJ3rOZkBj9Og?=
 =?us-ascii?Q?XN9Bv3IxD9TyBVHgm9Fe5n8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 502f5b24-b0f6-433e-cb33-08d9f764bd94
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3286.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2022 07:10:30.3289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oOz6CPDS60f0MupCQImv48UHS0JXkdv10rue5XjBBhcObxuPYAvZpObf3nXqBHYaeK/grzK/k+3jzUbahQ/1Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4580
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Abel,

(+ Aubrey Li, Srikar)

On Thu, Feb 17, 2022 at 11:43:57PM +0800, Abel Wu wrote:
> An CFS runqueue is considered overloaded when there are
> more than one pullable non-idle tasks on it (since sched-
> idle cpus are treated as idle cpus). And idle tasks are
> counted towards rq->cfs.idle_h_nr_running, that is either
> assigned SCHED_IDLE policy or placed under idle cgroups.
> 
> The overloaded cfs rqs can cause performance issues to
> both task types:
> 
>   - for latency critical tasks like SCHED_NORMAL,
>     time of waiting in the rq will increase and
>     result in higher pct99 latency, and
> 
>   - batch tasks may not be able to make full use
>     of cpu capacity if sched-idle rq exists, thus
>     presents poorer throughput.
> 
> The mask of overloaded cpus is updated in periodic tick
> and the idle path at the LLC domain basis. This cpumask
> will also be used in SIS as a filter, improving idle cpu
> searching.

This is an interesting approach to minimise the tail latencies by
keeping track of the overloaded cpus in the LLC so that
idle/sched-idle CPUs can pull from them. This approach contrasts with the
following approaches that were previously tried :

1. Maintain the idle cpumask at the LLC level by Aubrey Li
   https://lore.kernel.org/all/1615872606-56087-1-git-send-email-aubrey.li@intel.com/
   
2. Maintain the identity of the idle core itself at the LLC level, by Srikar :
   https://lore.kernel.org/lkml/20210513074027.543926-3-srikar@linux.vnet.ibm.com/

There have been concerns in the past about having to update the shared
mask/counter at regular intervals. Srikar, Aubrey any thoughts on this
?



> 
> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
> ---
>  include/linux/sched/topology.h | 10 ++++++++++
>  kernel/sched/core.c            |  1 +
>  kernel/sched/fair.c            | 43 ++++++++++++++++++++++++++++++++++++++++++
>  kernel/sched/sched.h           |  6 ++++++
>  kernel/sched/topology.c        |  4 +++-
>  5 files changed, 63 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
> index 56cffe42abbc..03c9c81dc886 100644
> --- a/include/linux/sched/topology.h
> +++ b/include/linux/sched/topology.h
> @@ -81,6 +81,16 @@ struct sched_domain_shared {
>  	atomic_t	ref;
>  	atomic_t	nr_busy_cpus;
>  	int		has_idle_cores;
> +
> +	/*
> +	 * The above varibles are used in idle path and
> +	 * select_task_rq, and the following two are
> +	 * mainly updated in tick. They are all hot but
> +	 * for different usage, so start a new cacheline
> +	 * to avoid false sharing.
> +	 */
> +	atomic_t	nr_overloaded	____cacheline_aligned;
> +	unsigned long	overloaded[];	/* Must be last */
>  };
>  
>  struct sched_domain {
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 1d863d7f6ad7..a6da2998ec49 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -9423,6 +9423,7 @@ void __init sched_init(void)
>  		rq->wake_stamp = jiffies;
>  		rq->wake_avg_idle = rq->avg_idle;
>  		rq->max_idle_balance_cost = sysctl_sched_migration_cost;
> +		rq->overloaded = 0;
>  
>  		INIT_LIST_HEAD(&rq->cfs_tasks);
>  
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 5c4bfffe8c2c..0a0438c3319b 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6968,6 +6968,46 @@ balance_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>  
>  	return newidle_balance(rq, rf) != 0;
>  }
> +
> +static inline int cfs_rq_overloaded(struct rq *rq)
> +{
> +	return rq->cfs.h_nr_running - rq->cfs.idle_h_nr_running > 1;
> +}
> +
> +/* Must be called with rq locked */
> +static void update_overload_status(struct rq *rq)
> +{
> +	struct sched_domain_shared *sds;
> +	int overloaded = cfs_rq_overloaded(rq);
> +	int cpu = cpu_of(rq);
> +
> +	lockdep_assert_rq_held(rq);
> +
> +	if (rq->overloaded == overloaded)
> +		return;
> +
> +	rcu_read_lock();
> +	sds = rcu_dereference(per_cpu(sd_llc_shared, cpu));
> +	if (unlikely(!sds))
> +		goto unlock;
> +
> +	if (overloaded) {
> +		cpumask_set_cpu(cpu, sdo_mask(sds));
> +		atomic_inc(&sds->nr_overloaded);
> +	} else {
> +		cpumask_clear_cpu(cpu, sdo_mask(sds));
> +		atomic_dec(&sds->nr_overloaded);
> +	}
> +
> +	rq->overloaded = overloaded;
> +unlock:
> +	rcu_read_unlock();
> +}
> +
> +#else
> +
> +static inline void update_overload_status(struct rq *rq) { }
> +
>  #endif /* CONFIG_SMP */
>  
>  static unsigned long wakeup_gran(struct sched_entity *se)
> @@ -7315,6 +7355,8 @@ done: __maybe_unused;
>  	if (new_tasks > 0)
>  		goto again;
>  
> +	update_overload_status(rq);
> +

So here, we are calling update_overload_status() after
newidle_balance(). If we had pulled a single task as a part of
newidle_balance(), in your current code, we do not update the overload
status. While this should get remedied in the next tick, should we
move update_overload_status(rq) prior to the new_tasks > 0 check ?


--
Thanks and Regards
gautham.
