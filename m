Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22F514DB222
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 15:04:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240974AbiCPOFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 10:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236177AbiCPOFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 10:05:51 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A6C2BF4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 07:04:36 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22GDJ1Yg010770;
        Wed, 16 Mar 2022 14:04:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=g1yUYBa+aWCXoccRrfDJm+5dEo3+/rkHP9z9dk6Mdac=;
 b=hZpfGWpnlprLK9kEfZBRhk0iHH5cQqkXK2xZiwl+/YmO3VrF5HDsAh39o86ol1QX32gZ
 g1E44PglDUtpAVJ5tsfQJu6P5dbnwKI+X8VU9uFYSK5vK5ipDitxizXBsVcieyBT7+pf
 TkYGWhOn22iUhyECB9AbICTs9NLE3/cS9hrip8JSm6LYxpqTnj1SqS8r6lKDsupF81E4
 1py3as0bzuWhZRzv3zB1MQ3oewwcO6yiXFadA5FElDlhA5QmTP16pSSaRkqhTptK6vPw
 w4pEoAIi/cXQ7m1QG6aViQm/Tqn1BxxZjEwVAQ8Txw18whTk5sR8wfmpCD4aBYecySvy wA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3eugp0959u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Mar 2022 14:04:02 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 22GDlo8T009255;
        Wed, 16 Mar 2022 14:04:01 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3eugp09584-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Mar 2022 14:04:01 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22GE3GCa024700;
        Wed, 16 Mar 2022 14:03:59 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03fra.de.ibm.com with ESMTP id 3erk58qu4w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Mar 2022 14:03:59 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22GE3uX054002020
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Mar 2022 14:03:56 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CFDC24203F;
        Wed, 16 Mar 2022 14:03:56 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6CD0E42045;
        Wed, 16 Mar 2022 14:03:54 +0000 (GMT)
Received: from [9.43.41.218] (unknown [9.43.41.218])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 16 Mar 2022 14:03:54 +0000 (GMT)
Message-ID: <9cfede63-ffd8-7446-825c-815291bbc9d3@linux.vnet.ibm.com>
Date:   Wed, 16 Mar 2022 19:33:52 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3] mm: Only re-generate demotion targets when a numa node
 changes its N_CPU state
Content-Language: en-US
To:     Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220314150945.12694-1-osalvador@suse.de>
From:   Abhishek Goel <huntbag@linux.vnet.ibm.com>
In-Reply-To: <20220314150945.12694-1-osalvador@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wJLYhZ0e1AEFKDjq12mY_AOuqVxdu17E
X-Proofpoint-ORIG-GUID: T67zBxSKLDcfDdtiwCGIoc2sI4oGer_P
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-16_05,2022-03-15_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 clxscore=1015 impostorscore=0 priorityscore=1501 mlxscore=0
 phishscore=0 spamscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203160088
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 14/03/22 20:39, Oscar Salvador wrote:
> Abhishek reported that after patch [1], hotplug operations are
> taking ~double the expected time. [2]
>
> The reason behind is that the CPU callbacks that migrate_on_reclaim_init()
> sets always call set_migration_target_nodes() whenever a CPU is brought
> up/down.
> But we only care about numa nodes going from having cpus to become
> cpuless, and vice versa, as that influences the demotion_target order.
>
> We do already have two CPU callbacks (vmstat_cpu_online() and vmstat_cpu_dead())
> that check exactly that, so get rid of the CPU callbacks in
> migrate_on_reclaim_init() and only call set_migration_target_nodes() from
> vmstat_cpu_{dead,online}() whenever a numa node change its N_CPU state.
>
> [1] https://lore.kernel.org/linux-mm/20210721063926.3024591-2-ying.huang@intel.com/
> [2] https://lore.kernel.org/linux-mm/eb438ddd-2919-73d4-bd9f-b7eecdd9577a@linux.vnet.ibm.com/
>
> Fixes: 884a6e5d1f93b ("mm/migrate: update node demotion order on hotplug events")
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Tested-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Reported-by: Abhishek Goel <huntbag@linux.vnet.ibm.com>
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> ---
>   v2 -> v3:
>             - Add feedback from Huang Ying
> 	   - Add tags
>   v1 -> v2:
>             - Add fedback from Huang Ying
>             - Add feedback from Baolin Wang
> ---
>   include/linux/migrate.h |  8 +++++++
>   mm/migrate.c            | 47 +++++++++--------------------------------
>   mm/vmstat.c             | 13 +++++++++++-
>   3 files changed, 30 insertions(+), 38 deletions(-)
>
> diff --git a/include/linux/migrate.h b/include/linux/migrate.h
> index db96e10eb8da..90e75d5a54d6 100644
> --- a/include/linux/migrate.h
> +++ b/include/linux/migrate.h
> @@ -48,7 +48,15 @@ int folio_migrate_mapping(struct address_space *mapping,
>   		struct folio *newfolio, struct folio *folio, int extra_count);
>
>   extern bool numa_demotion_enabled;
> +extern void migrate_on_reclaim_init(void);
> +#ifdef CONFIG_HOTPLUG_CPU
> +extern void set_migration_target_nodes(void);
>   #else
> +static inline void set_migration_target_nodes(void) {}
> +#endif
> +#else
> +
> +static inline void set_migration_target_nodes(void) {}
>
>   static inline void putback_movable_pages(struct list_head *l) {}
>   static inline int migrate_pages(struct list_head *l, new_page_t new,
> diff --git a/mm/migrate.c b/mm/migrate.c
> index e8a6933af68d..2561881f03b2 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -3193,7 +3193,7 @@ static void __set_migration_target_nodes(void)
>   /*
>    * For callers that do not hold get_online_mems() already.
>    */
> -static void set_migration_target_nodes(void)
> +void set_migration_target_nodes(void)
>   {
>   	get_online_mems();
>   	__set_migration_target_nodes();
> @@ -3257,51 +3257,24 @@ static int __meminit migrate_on_reclaim_callback(struct notifier_block *self,
>   	return notifier_from_errno(0);
>   }
>
> -/*
> - * React to hotplug events that might affect the migration targets
> - * like events that online or offline NUMA nodes.
> - *
> - * The ordering is also currently dependent on which nodes have
> - * CPUs.  That means we need CPU on/offline notification too.
> - */
> -static int migration_online_cpu(unsigned int cpu)
> -{
> -	set_migration_target_nodes();
> -	return 0;
> -}
> -
> -static int migration_offline_cpu(unsigned int cpu)
> +void __init migrate_on_reclaim_init(void)
>   {
> -	set_migration_target_nodes();
> -	return 0;
> -}
> -
> -static int __init migrate_on_reclaim_init(void)
> -{
> -	int ret;
> -
>   	node_demotion = kmalloc_array(nr_node_ids,
>   				      sizeof(struct demotion_nodes),
>   				      GFP_KERNEL);
>   	WARN_ON(!node_demotion);
>
> -	ret = cpuhp_setup_state_nocalls(CPUHP_MM_DEMOTION_DEAD, "mm/demotion:offline",
> -					NULL, migration_offline_cpu);
> +	hotplug_memory_notifier(migrate_on_reclaim_callback, 100);
>   	/*
> -	 * In the unlikely case that this fails, the automatic
> -	 * migration targets may become suboptimal for nodes
> -	 * where N_CPU changes.  With such a small impact in a
> -	 * rare case, do not bother trying to do anything special.
> +	 * At this point, all numa nodes with memory/CPus have their state
> +	 * properly set, so we can build the demotion order now.
> +	 * Let us hold the cpu_hotplug lock just, as we could possibily have
> +	 * CPU hotplug events during boot.
>   	 */
> -	WARN_ON(ret < 0);
> -	ret = cpuhp_setup_state(CPUHP_AP_MM_DEMOTION_ONLINE, "mm/demotion:online",
> -				migration_online_cpu, NULL);
> -	WARN_ON(ret < 0);
> -
> -	hotplug_memory_notifier(migrate_on_reclaim_callback, 100);
> -	return 0;
> +	cpus_read_lock();
> +	set_migration_target_nodes();
> +	cpus_read_unlock();
>   }
> -late_initcall(migrate_on_reclaim_init);
>   #endif /* CONFIG_HOTPLUG_CPU */
>
>   bool numa_demotion_enabled = false;
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index 4057372745d0..9e9536df51b5 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -28,6 +28,7 @@
>   #include <linux/mm_inline.h>
>   #include <linux/page_ext.h>
>   #include <linux/page_owner.h>
> +#include <linux/migrate.h>
>
>   #include "internal.h"
>
> @@ -2043,7 +2044,12 @@ static void __init init_cpu_node_state(void)
>   static int vmstat_cpu_online(unsigned int cpu)
>   {
>   	refresh_zone_stat_thresholds();
> -	node_set_state(cpu_to_node(cpu), N_CPU);
> +
> +	if (!node_state(cpu_to_node(cpu), N_CPU)) {
> +		node_set_state(cpu_to_node(cpu), N_CPU);
> +		set_migration_target_nodes();
> +	}
> +
>   	return 0;
>   }
>
> @@ -2066,6 +2072,8 @@ static int vmstat_cpu_dead(unsigned int cpu)
>   		return 0;
>
>   	node_clear_state(node, N_CPU);
> +	set_migration_target_nodes();
> +
>   	return 0;
>   }
>
> @@ -2097,6 +2105,9 @@ void __init init_mm_internals(void)
>
>   	start_shepherd_timer();
>   #endif
> +#if defined(CONFIG_MIGRATION) && defined(CONFIG_HOTPLUG_CPU)
> +	migrate_on_reclaim_init();
> +#endif
>   #ifdef CONFIG_PROC_FS
>   	proc_create_seq("buddyinfo", 0444, NULL, &fragmentation_op);
>   	proc_create_seq("pagetypeinfo", 0400, NULL, &pagetypeinfo_op);
Tested three different kernels on a ppc system for hotplug operation-

    Kernel 
version                                                        Time taken
1. 5.14.0(baseline kernel)                                            9.6s
2. 5.15.0(upstream kernel without this patch)             23.1s
3. 5.17.0-rc8+(upstream kernel with this patch)         11.3s

*Time taken= avg total time taken to switch from smt=8 to smt=1

I have used v5.15.0 kernel for 2nd experiment as the issue was
introduced between 5.14 and 5.15. Similar numbers are
observed for any subsequent upstream kernels without this fix patch.
Overall LGTM. Please feel free to add:
Tested by: Abhishek Goel <huntbag@linux.vnet.ibm.com>

--Abhishek
