Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 668E24D575D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 02:32:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344012AbiCKBdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 20:33:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237827AbiCKBdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 20:33:43 -0500
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBDBF140E1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 17:32:38 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0V6qnh1P_1646962355;
Received: from 30.97.48.70(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0V6qnh1P_1646962355)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 11 Mar 2022 09:32:35 +0800
Message-ID: <f7490de2-4f0e-1c5e-5bdd-479d1744d111@linux.alibaba.com>
Date:   Fri, 11 Mar 2022 09:33:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v2] mm: Only re-generate demotion targets when a numa node
 changes its N_CPU state
To:     Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Abhishek Goel <huntbag@linux.vnet.ibm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220310120749.23077-1-osalvador@suse.de>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20220310120749.23077-1-osalvador@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/10/2022 8:07 PM, Oscar Salvador wrote:
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
> Reported-by: Abhishek Goel <huntbag@linux.vnet.ibm.com>
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> ---
> v1 -> v2: - Fix prototype function declaration
>            - Fix build error on RISC
>            - Adressed feedback from Baolin and Huang
> ---
>   include/linux/migrate.h |  8 ++++++++
>   mm/migrate.c            | 41 +++++------------------------------------
>   mm/vmstat.c             | 13 ++++++++++++-
>   3 files changed, 25 insertions(+), 37 deletions(-)
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
> index c7da064b4781..f9d5b6092a42 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -3190,7 +3190,7 @@ static void __set_migration_target_nodes(void)
>   /*
>    * For callers that do not hold get_online_mems() already.
>    */
> -static void set_migration_target_nodes(void)
> +void set_migration_target_nodes(void)
>   {
>   	get_online_mems();
>   	__set_migration_target_nodes();
> @@ -3254,51 +3254,20 @@ static int __meminit migrate_on_reclaim_callback(struct notifier_block *self,
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
> +void __init migrate_on_reclaim_init(void)
>   {
> -	set_migration_target_nodes();
> -	return 0;
> -}
> -
> -static int migration_offline_cpu(unsigned int cpu)
> -{
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
>   	/*
> -	 * In the unlikely case that this fails, the automatic
> -	 * migration targets may become suboptimal for nodes
> -	 * where N_CPU changes.  With such a small impact in a
> -	 * rare case, do not bother trying to do anything special.
> +	 * At this point, all numa nodes with memory/CPus have their state
> +	 * properly set, so we can build the demotion order now.
>   	 */
> -	WARN_ON(ret < 0);
> -	ret = cpuhp_setup_state(CPUHP_AP_MM_DEMOTION_ONLINE, "mm/demotion:online",
> -				migration_online_cpu, NULL);
> -	WARN_ON(ret < 0);
> -
> +	set_migration_target_nodes();
>   	hotplug_memory_notifier(migrate_on_reclaim_callback, 100);
> -	return 0;
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

I guess can we move these CONFIG_* macros into migrate.h like what 
set_migration_target_nodes() does? Otherwise LGTM. Please feel free to add:
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Tested-by: Baolin Wang <baolin.wang@linux.alibaba.com>
