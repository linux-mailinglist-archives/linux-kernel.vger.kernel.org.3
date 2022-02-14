Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C21B84B4D34
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 12:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349827AbiBNLAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 06:00:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349861AbiBNLAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 06:00:18 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0062460DA3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 02:27:15 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21E8eMkQ007619;
        Mon, 14 Feb 2022 10:26:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pp1; bh=mIxMCdnik8LxM6FKNyPYSSLP6INs9LgXXjjKLYckjzE=;
 b=VEWnd+nhswFIeRHROjMYeWZHKYr3VqVM7WimM3UQAuy2pgqUDcuyP2xitgIo7vO9HFu8
 O1060XOXDeB19LZ0/MRWtCyXXJcbK+Rz7zfZH1LVtbkkWY2iauS4ARjq9z03y2VS+K6k
 /HD1x8I/2n0c/qqD51FF62LOoPmmF5u/+p4LjDt1ylGO1AB02K67IAvKgWgiuJ6kk/g3
 weSSAiQZ4d2LxVFg9+1pRYzYffy2qQXmIIBcT6O3AiRyjkMJ6whxYfDQ+2hHbYkf1ihL
 BAIwfKvlqdjZLYi19qS2XMUBcpBLtvWgSKuDxQhamv+VJfMIoeJyKHUoL++xbdWeJFgx Mw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e7dehhgb0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Feb 2022 10:26:50 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21EAB60K021093;
        Mon, 14 Feb 2022 10:26:50 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e7dehhgaf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Feb 2022 10:26:50 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21EAHTLE012319;
        Mon, 14 Feb 2022 10:26:48 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06ams.nl.ibm.com with ESMTP id 3e645jbyds-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Feb 2022 10:26:47 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21EAGRAg37945618
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Feb 2022 10:16:27 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A0E5D11C04C;
        Mon, 14 Feb 2022 10:26:45 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0E02711C066;
        Mon, 14 Feb 2022 10:26:43 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Mon, 14 Feb 2022 10:26:42 +0000 (GMT)
Date:   Mon, 14 Feb 2022 15:56:42 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Mike Galbraith <efault@gmx.de>,
        Gautham Shenoy <gautham.shenoy@amd.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] sched/fair: Improve consistency of allowed NUMA
 balance calculations
Message-ID: <20220214102642.GH618915@linux.vnet.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20220208094334.16379-1-mgorman@techsingularity.net>
 <20220208094334.16379-2-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20220208094334.16379-2-mgorman@techsingularity.net>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: v3ROAcE1X34MmFnbf5S67oZOqs3bbZDX
X-Proofpoint-ORIG-GUID: wGy0mDUdefYEzI8P7I_fwkjzSGI2Tocj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-14_02,2022-02-14_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 mlxscore=0 mlxlogscore=836 priorityscore=1501 adultscore=0 malwarescore=0
 spamscore=0 clxscore=1011 suspectscore=0 bulkscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202140062
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Mel Gorman <mgorman@techsingularity.net> [2022-02-08 09:43:33]:

> There are inconsistencies when determining if a NUMA imbalance is allowed
> that should be corrected.
> 
> o allow_numa_imbalance changes types and is not always examining
>   the destination group so both the type should be corrected as
>   well as the naming.
> o find_idlest_group uses the sched_domain's weight instead of the
>   group weight which is different to find_busiest_group
> o find_busiest_group uses the source group instead of the destination
>   which is different to task_numa_find_cpu
> o Both find_idlest_group and find_busiest_group should account
>   for the number of running tasks if a move was allowed to be
>   consistent with task_numa_find_cpu
> 
> Fixes: 7d2b5dd0bcc4 ("sched/numa: Allow a floating imbalance between NUMA nodes")
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> ---
>  kernel/sched/fair.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 095b0aa378df..4592ccf82c34 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9003,9 +9003,10 @@ static bool update_pick_idlest(struct sched_group *idlest,
>   * This is an approximation as the number of running tasks may not be
>   * related to the number of busy CPUs due to sched_setaffinity.
>   */
> -static inline bool allow_numa_imbalance(int dst_running, int dst_weight)
> +static inline bool
> +allow_numa_imbalance(unsigned int running, unsigned int weight)
>  {
> -	return (dst_running < (dst_weight >> 2));
> +	return (running < (weight >> 2));
>  }
> 
>  /*
> @@ -9139,12 +9140,13 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
>  				return idlest;
>  #endif
>  			/*
> -			 * Otherwise, keep the task on this node to stay close
> -			 * its wakeup source and improve locality. If there is
> -			 * a real need of migration, periodic load balance will
> -			 * take care of it.
> +			 * Otherwise, keep the task close to the wakeup source
> +			 * and improve locality if the number of running tasks
> +			 * would remain below threshold where an imbalance is
> +			 * allowed. If there is a real need of migration,
> +			 * periodic load balance will take care of it.
>  			 */
> -			if (allow_numa_imbalance(local_sgs.sum_nr_running, sd->span_weight))
> +			if (allow_numa_imbalance(local_sgs.sum_nr_running + 1, local_sgs.group_weight))
>  				return NULL;
>  		}
> 
> @@ -9350,7 +9352,7 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
>  		/* Consider allowing a small imbalance between NUMA groups */
>  		if (env->sd->flags & SD_NUMA) {
>  			env->imbalance = adjust_numa_imbalance(env->imbalance,
> -				busiest->sum_nr_running, busiest->group_weight);
> +				local->sum_nr_running + 1, local->group_weight);
>  		}
> 
>  		return;
> -- 
> 2.31.1
> 

Looks good to me.

Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>

-- 
Thanks and Regards
Srikar Dronamraju
