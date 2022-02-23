Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2A64C1F42
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 00:03:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244697AbiBWXDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 18:03:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234474AbiBWXDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 18:03:36 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 651D55715E
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 15:03:07 -0800 (PST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21NLkpmA007359;
        Wed, 23 Feb 2022 23:03:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=df9oL0BxwL53oqsYNSY+RoJOe2vYAFtgm9R2PxkFKDI=;
 b=EczgsH6rupFpTltVpdlGgsw8qM9nXxFNk0KlfsZWxtrfU0GjpgZbxx307bT/Ic0IBBt6
 vN5ieSgCZOWJshFoNuCys2tCSvX4CGjPQbhuTTpubNA8lpdnBG1cceF2+YgKz7Ix0BPY
 2WD+kowdF4kVEXBZP5BusyAgSKh5HPId6BDqequtPTMw9vSJqSAYqiLJPrWDfURYI4pW
 kyyUoln3sXZJoWY3EH/tyHMOs4UYr8k+TT8ZiuUIESY+IX2Dvt5+9UXfrm1afKHrNxd3
 mMnUjT6tb6qY5BWuhXrv/6Yf3XoYd4fB9UptxgYap3KPQNJKR+bfS2R/Rgjqve2pYwFN rA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3edw511a26-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Feb 2022 23:03:01 +0000
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21NMuBEC017666;
        Wed, 23 Feb 2022 23:03:01 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3edw511a1h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Feb 2022 23:03:01 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21NN2ntQ008360;
        Wed, 23 Feb 2022 23:02:59 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3ear69d6cp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Feb 2022 23:02:59 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21NN2vSZ45810056
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Feb 2022 23:02:57 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DA774A405B;
        Wed, 23 Feb 2022 23:02:56 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 42092A4040;
        Wed, 23 Feb 2022 23:02:54 +0000 (GMT)
Received: from [9.43.109.214] (unknown [9.43.109.214])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 23 Feb 2022 23:02:53 +0000 (GMT)
Message-ID: <eb438ddd-2919-73d4-bd9f-b7eecdd9577a@linux.vnet.ibm.com>
Date:   Thu, 24 Feb 2022 04:32:52 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH -V11 2/9] mm/migrate: update node demotion order on
 hotplug events
Content-Language: en-US
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Zi Yan <ziy@nvidia.com>, David Hildenbrand <david@redhat.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210721063926.3024591-1-ying.huang@intel.com>
 <20210721063926.3024591-2-ying.huang@intel.com>
From:   Abhishek Goel <huntbag@linux.vnet.ibm.com>
In-Reply-To: <20210721063926.3024591-2-ying.huang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Ih_O3fL9gF_5JvNi810rRXyqtqsK8EpM
X-Proofpoint-ORIG-GUID: J3gs5CQzjGhSx4z_qmCpVHtXPU6KSzV_
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-02-23_09,2022-02-23_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 impostorscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2202230130
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,


> From: Dave Hansen <dave.hansen@linux.intel.com>
>
> Reclaim-based migration is attempting to optimize data placement in memory
> based on the system topology.  If the system changes, so must the
> migration ordering.
>
> The implementation is conceptually simple and entirely unoptimized.  On
> any memory or CPU hotplug events, assume that a node was added or removed
> and recalculate all migration targets.  This ensures that the
> node_demotion[] array is always ready to be used in case the new reclaim
> mode is enabled.
>
> This recalculation is far from optimal, most glaringly that it does not
> even attempt to figure out the hotplug event would have some *actual*
> effect on the demotion order.  But, given the expected paucity of hotplug
> events, this should be fine.
>
> Link: https://lkml.kernel.org/r/20210715055145.195411-3-ying.huang@intel.com
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Reviewed-by: Yang Shi <shy828301@gmail.com>
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Wei Xu <weixugc@google.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Greg Thelen <gthelen@google.com>
> Cc: Keith Busch <kbusch@kernel.org>
> Cc: Yang Shi <yang.shi@linux.alibaba.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
>   mm/migrate.c | 90 +++++++++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 89 insertions(+), 1 deletion(-)
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index b7a40ab47648..a40c391f9ca7 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -49,6 +49,7 @@
>   #include <linux/sched/mm.h>
>   #include <linux/ptrace.h>
>   #include <linux/oom.h>
> +#include <linux/memory.h>
>   
>   #include <asm/tlbflush.h>
>   
> @@ -3057,6 +3058,7 @@ void migrate_vma_finalize(struct migrate_vma *migrate)
>   EXPORT_SYMBOL(migrate_vma_finalize);
>   #endif /* CONFIG_DEVICE_PRIVATE */
>   
> +#if defined(CONFIG_MEMORY_HOTPLUG)
>   /* Disable reclaim-based migration. */
>   static void __disable_all_migrate_targets(void)
>   {
> @@ -3191,10 +3193,96 @@ static void __set_migration_target_nodes(void)
>   /*
>    * For callers that do not hold get_online_mems() already.
>    */
> -__maybe_unused // <- temporay to prevent warnings during bisects
>   static void set_migration_target_nodes(void)
>   {
>   	get_online_mems();
>   	__set_migration_target_nodes();
>   	put_online_mems();
>   }
> +
> +/*
> + * React to hotplug events that might affect the migration targets
> + * like events that online or offline NUMA nodes.
> + *
> + * The ordering is also currently dependent on which nodes have
> + * CPUs.  That means we need CPU on/offline notification too.
> + */
> +static int migration_online_cpu(unsigned int cpu)
> +{
> +	set_migration_target_nodes();
> +	return 0;
> +}
> +
> +static int migration_offline_cpu(unsigned int cpu)
> +{
> +	set_migration_target_nodes();
> +	return 0;
> +}
> +
> +/*
> + * This leaves migrate-on-reclaim transiently disabled between
> + * the MEM_GOING_OFFLINE and MEM_OFFLINE events.  This runs
> + * whether reclaim-based migration is enabled or not, which
> + * ensures that the user can turn reclaim-based migration at
> + * any time without needing to recalculate migration targets.
> + *
> + * These callbacks already hold get_online_mems().  That is why
> + * __set_migration_target_nodes() can be used as opposed to
> + * set_migration_target_nodes().
> + */
> +static int __meminit migrate_on_reclaim_callback(struct notifier_block *self,
> +						 unsigned long action, void *arg)
> +{
> +	switch (action) {
> +	case MEM_GOING_OFFLINE:
> +		/*
> +		 * Make sure there are not transient states where
> +		 * an offline node is a migration target.  This
> +		 * will leave migration disabled until the offline
> +		 * completes and the MEM_OFFLINE case below runs.
> +		 */
> +		disable_all_migrate_targets();
> +		break;
> +	case MEM_OFFLINE:
> +	case MEM_ONLINE:
> +		/*
> +		 * Recalculate the target nodes once the node
> +		 * reaches its final state (online or offline).
> +		 */
> +		__set_migration_target_nodes();
> +		break;
> +	case MEM_CANCEL_OFFLINE:
> +		/*
> +		 * MEM_GOING_OFFLINE disabled all the migration
> +		 * targets.  Reenable them.
> +		 */
> +		__set_migration_target_nodes();
> +		break;
> +	case MEM_GOING_ONLINE:
> +	case MEM_CANCEL_ONLINE:
> +		break;
> +	}
> +
> +	return notifier_from_errno(0);
> +}
> +
> +static int __init migrate_on_reclaim_init(void)
> +{
> +	int ret;
> +
> +	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "migrate on reclaim",
> +				migration_online_cpu,
> +				migration_offline_cpu);
> +	/*
> +	 * In the unlikely case that this fails, the automatic
> +	 * migration targets may become suboptimal for nodes
> +	 * where N_CPU changes.  With such a small impact in a
> +	 * rare case, do not bother trying to do anything special.
> +	 */
> +	WARN_ON(ret < 0);
> +
> +	hotplug_memory_notifier(migrate_on_reclaim_callback, 100);
> +	return 0;
> +}
> +late_initcall(migrate_on_reclaim_init);
> +#endif /* CONFIG_MEMORY_HOTPLUG */
I intend to report a issue that is being caused by this patch.
 From 5.14 to 5.15 kernel, hotplug on power systems was observed to be
taking double the expected time. Git bisect between these two kernels
points to this patch as the one causing the issue.
I have verified from cpu-hotplug callback trace that we are infact
spending a lot of time in migration_offline_cpu code path.
I see that there have been subsequent patches to optimize this update
node demotion order code, but those patches are already in 5.15 kernel
and regressions are still observed even after those optimizations.
I have also recreated and observed the issue across systems with
different configs, and across different kernels containing this patch.
If needed, I will provide experiment results and traces that were used
to conclude this.

Regards,

- Abhishek

