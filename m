Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DBEE4DD545
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 08:33:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233118AbiCRHe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 03:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbiCRHeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 03:34:23 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF77A82D30
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 00:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647588784; x=1679124784;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=5wFaDivmsqjIimlyRpkOSsUEc9NDJ1nuFC7Obz/eUIE=;
  b=b3DhLjjSaR66riztr3Mmg0fSuhKezGdANoiB4Xnxj6AcA5lApgbM88hC
   PFnvFim37Uk8yrIgTKQ6FhwND0U6H6RGacAa52tfxoGQvrQePk76YjFOu
   RMuv8NjJ9qRw+rwNfWVSReMub6CjhJKB/Cka42kl/lDR/x46GLUAdl4R9
   5b3h1GH5I07KhOecSKnj1nROfnNs4xfEacIFSg6Vvobv7uzI/KulBU+gM
   7kpfmeJZJhb0fSxdXgceRwjuUVG5jYVLd9WoRETegBZyoAoJ9vr5XWCKg
   nRi/J7++TyyRjgEvwE/mgMtE/7wioIC4iV35kRWyabjkFy5oUtWL0wdD2
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="237029545"
X-IronPort-AV: E=Sophos;i="5.90,191,1643702400"; 
   d="scan'208";a="237029545"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 00:33:04 -0700
X-IronPort-AV: E=Sophos;i="5.90,191,1643702400"; 
   d="scan'208";a="541724957"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.94])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 00:33:02 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Abhishek Goel <huntbag@linux.vnet.ibm.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Untangle config dependencies for demote-on-reclaim
References: <20220317132450.5116-1-osalvador@suse.de>
Date:   Fri, 18 Mar 2022 15:33:00 +0800
In-Reply-To: <20220317132450.5116-1-osalvador@suse.de> (Oscar Salvador's
        message of "Thu, 17 Mar 2022 14:24:50 +0100")
Message-ID: <87tubvk95f.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Oscar,

Thanks for doing this.

Oscar Salvador <osalvador@suse.de> writes:

> At the time demote-on-reclaim was introduced, it was tied to
> CONFIG_HOTPLUG_CPU + CONFIG_MIGRATE, but that is not really
> accurate.
>
> The only two things we need to depen on is CONFIG_NUMA +
> CONFIG_MIGRATE, so clean this up.
> Furthermore, we only register the hotplug memory notifier
> when the system has CONFIG_MEMORY_HOTPLUG.
>
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> Suggested-by: "Huang, Ying" <ying.huang@intel.com>
> ---
>  include/linux/migrate.h |  5 ++++-
>  mm/migrate.c            | 11 ++++++-----
>  mm/vmstat.c             |  2 --
>  3 files changed, 10 insertions(+), 8 deletions(-)
>
> diff --git a/include/linux/migrate.h b/include/linux/migrate.h
> index a4a336fd81fc..1efabe7bb5fc 100644
> --- a/include/linux/migrate.h
> +++ b/include/linux/migrate.h
> @@ -49,14 +49,17 @@ int folio_migrate_mapping(struct address_space *mapping,
>  
>  extern bool numa_demotion_enabled;
>  extern void migrate_on_reclaim_init(void);
> -#ifdef CONFIG_HOTPLUG_CPU
> +#ifdef CONFIG_NUMA
>  extern void set_migration_target_nodes(void);
> +extern void migrate_on_reclaim_init(void);
>  #else
>  static inline void set_migration_target_nodes(void) {}
> +static inline void migrate_on_reclaim_init(void) {}
>  #endif
>  #else
>  
>  static inline void set_migration_target_nodes(void) {}
> +static inline void migrate_on_reclaim_init(void) {}

To avoid to duplicate the void definition.  How about to usec

#if defined(CONFIG_MIGRATION) && defined(CONFIG_NUMA)
/* xxx */
#else
/* yyy */
#endif

And we need to put "numa_demotion_enabled" inside too.  Because it is
defined inside CONFIG_NUMA too now.

>  static inline void putback_movable_pages(struct list_head *l) {}
>  static inline int migrate_pages(struct list_head *l, new_page_t new,
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 3364bfaddeef..118f71425241 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -2144,7 +2144,6 @@ int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
>  	return 0;
>  }
>  #endif /* CONFIG_NUMA_BALANCING */
> -#endif /* CONFIG_NUMA */
>  
>  /*
>   * node_demotion[] example:
> @@ -2278,7 +2277,6 @@ int next_demotion_node(int node)
>  	return target;
>  }
>  
> -#if defined(CONFIG_HOTPLUG_CPU)
>  /* Disable reclaim-based migration. */
>  static void __disable_all_migrate_targets(void)
>  {
> @@ -2471,6 +2469,7 @@ void set_migration_target_nodes(void)
>   * __set_migration_target_nodes() can be used as opposed to
>   * set_migration_target_nodes().
>   */
> +#ifdef CONFIG_MEMORY_HOTPLUG
>  static int __meminit migrate_on_reclaim_callback(struct notifier_block *self,
>  						 unsigned long action, void *_arg)
>  {
> @@ -2516,6 +2515,7 @@ static int __meminit migrate_on_reclaim_callback(struct notifier_block *self,
>  
>  	return notifier_from_errno(0);
>  }
> +#endif
>  
>  void __init migrate_on_reclaim_init(void)
>  {
> @@ -2523,8 +2523,9 @@ void __init migrate_on_reclaim_init(void)
>  				      sizeof(struct demotion_nodes),
>  				      GFP_KERNEL);
>  	WARN_ON(!node_demotion);
> -
> +#ifdef CONFIG_MEMORY_HOTPLUG
>  	hotplug_memory_notifier(migrate_on_reclaim_callback, 100);
> +#endif

Another way is to add "#else" and void definition after
migrate_on_reclaim_callback().  But this isn't a big deal.

>  	/*
>  	 * At this point, all numa nodes with memory/CPus have their state
>  	 * properly set, so we can build the demotion order now.
> @@ -2535,7 +2536,6 @@ void __init migrate_on_reclaim_init(void)
>  	set_migration_target_nodes();
>  	cpus_read_unlock();
>  }
> -#endif /* CONFIG_HOTPLUG_CPU */
>  
>  bool numa_demotion_enabled = false;

As above, this is under CONFIG_NUMA too now.

Best Regards,
Huang, Ying

> @@ -2596,4 +2596,5 @@ static int __init numa_init_sysfs(void)
>  	return err;
>  }
>  subsys_initcall(numa_init_sysfs);
> -#endif
> +#endif /* CONFIG_SYSFS */
> +#endif /* CONFIG_NUMA */
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index b75b1a64b54c..f2d0dec1062d 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -2111,9 +2111,7 @@ void __init init_mm_internals(void)
>  
>  	start_shepherd_timer();
>  #endif
> -#if defined(CONFIG_MIGRATION) && defined(CONFIG_HOTPLUG_CPU)
>  	migrate_on_reclaim_init();
> -#endif
>  #ifdef CONFIG_PROC_FS
>  	proc_create_seq("buddyinfo", 0444, NULL, &fragmentation_op);
>  	proc_create_seq("pagetypeinfo", 0400, NULL, &pagetypeinfo_op);
