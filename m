Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FBA35662C8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 07:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiGEFdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 01:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiGEFde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 01:33:34 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE24B4AE
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 22:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656999212; x=1688535212;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bpYEAdQ0Eby67tLXeFT75RYZtLzZmOE0eyTzdj1VBHM=;
  b=BQk69yhMKAqLtizQ4qZVQ1URWy8lJgv8FvjziWAm3w+c3UI7zFOBYeL8
   SZa/y6EiTWqqxC5AN1oMz67BKYCup/JNBg1YUY4OrSYQsQ6RgJNfVtyMu
   zJRlnmJYNZnIG/ZpzDaAQ5UtoIzAKqU++ig0GhXbUcY19k3pf4CgqU2FE
   PPBLvzMXx7nRUPxqz5SLclHyj9aDEKc/9R5iJHXIe5CaX000kza0/+fw6
   upt8Y7mmDLsBCPW6hx+ZYxrltFwJy97wTzjpBCVH9OsL0dgKj/Irk8YFT
   uY1cOaERJXgijO2EbwSZSPX3m7n2x2arEcczl+I88LRWMDIRGgzz10FSr
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10398"; a="263049221"
X-IronPort-AV: E=Sophos;i="5.92,245,1650956400"; 
   d="scan'208";a="263049221"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2022 22:33:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,245,1650956400"; 
   d="scan'208";a="567461277"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 04 Jul 2022 22:33:29 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o8bBh-000Imh-72;
        Tue, 05 Jul 2022 05:33:29 +0000
Date:   Tue, 5 Jul 2022 13:33:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Gang Li <ligang.bdlg@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Gang Li <ligang.bdlg@bytedance.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm, hugetlb: skip irrelevant nodes in
 show_free_areas()
Message-ID: <202207051346.fg0ohdY4-lkp@intel.com>
References: <20220705034841.40931-1-ligang.bdlg@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220705034841.40931-1-ligang.bdlg@bytedance.com>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gang,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Gang-Li/mm-hugetlb-skip-irrelevant-nodes-in-show_free_areas/20220705-115053
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
config: arc-randconfig-r043-20220703 (https://download.01.org/0day-ci/archive/20220705/202207051346.fg0ohdY4-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/74d499a63c0d4c3f27f2a502842229cc27013d0d
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Gang-Li/mm-hugetlb-skip-irrelevant-nodes-in-show_free_areas/20220705-115053
        git checkout 74d499a63c0d4c3f27f2a502842229cc27013d0d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/arc/include/asm/ptrace.h:11,
                    from arch/arc/include/asm/bug.h:11,
                    from include/linux/bug.h:5,
                    from include/linux/mmdebug.h:5,
                    from include/linux/mm.h:6,
                    from mm/page_alloc.c:19:
   mm/page_alloc.c: In function 'show_free_areas':
>> mm/page_alloc.c:6205:13: error: implicit declaration of function 'hugepages_supported'; did you mean 'hugepage_movable_supported'? [-Werror=implicit-function-declaration]
    6205 |         if (hugepages_supported()) {
         |             ^~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:58:52: note: in definition of macro '__trace_if_var'
      58 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                    ^~~~
   mm/page_alloc.c:6205:9: note: in expansion of macro 'if'
    6205 |         if (hugepages_supported()) {
         |         ^~
   cc1: some warnings being treated as errors


vim +6205 mm/page_alloc.c

  6004	
  6005	/*
  6006	 * Show free area list (used inside shift_scroll-lock stuff)
  6007	 * We also calculate the percentage fragmentation. We do this by counting the
  6008	 * memory on each free list with the exception of the first item on the list.
  6009	 *
  6010	 * Bits in @filter:
  6011	 * SHOW_MEM_FILTER_NODES: suppress nodes that are not allowed by current's
  6012	 *   cpuset.
  6013	 */
  6014	void show_free_areas(unsigned int filter, nodemask_t *nodemask)
  6015	{
  6016		unsigned long free_pcp = 0;
  6017		int cpu, nid;
  6018		struct zone *zone;
  6019		pg_data_t *pgdat;
  6020	
  6021		for_each_populated_zone(zone) {
  6022			if (show_mem_node_skip(filter, zone_to_nid(zone), nodemask))
  6023				continue;
  6024	
  6025			for_each_online_cpu(cpu)
  6026				free_pcp += per_cpu_ptr(zone->per_cpu_pageset, cpu)->count;
  6027		}
  6028	
  6029		printk("active_anon:%lu inactive_anon:%lu isolated_anon:%lu\n"
  6030			" active_file:%lu inactive_file:%lu isolated_file:%lu\n"
  6031			" unevictable:%lu dirty:%lu writeback:%lu\n"
  6032			" slab_reclaimable:%lu slab_unreclaimable:%lu\n"
  6033			" mapped:%lu shmem:%lu pagetables:%lu bounce:%lu\n"
  6034			" kernel_misc_reclaimable:%lu\n"
  6035			" free:%lu free_pcp:%lu free_cma:%lu\n",
  6036			global_node_page_state(NR_ACTIVE_ANON),
  6037			global_node_page_state(NR_INACTIVE_ANON),
  6038			global_node_page_state(NR_ISOLATED_ANON),
  6039			global_node_page_state(NR_ACTIVE_FILE),
  6040			global_node_page_state(NR_INACTIVE_FILE),
  6041			global_node_page_state(NR_ISOLATED_FILE),
  6042			global_node_page_state(NR_UNEVICTABLE),
  6043			global_node_page_state(NR_FILE_DIRTY),
  6044			global_node_page_state(NR_WRITEBACK),
  6045			global_node_page_state_pages(NR_SLAB_RECLAIMABLE_B),
  6046			global_node_page_state_pages(NR_SLAB_UNRECLAIMABLE_B),
  6047			global_node_page_state(NR_FILE_MAPPED),
  6048			global_node_page_state(NR_SHMEM),
  6049			global_node_page_state(NR_PAGETABLE),
  6050			global_zone_page_state(NR_BOUNCE),
  6051			global_node_page_state(NR_KERNEL_MISC_RECLAIMABLE),
  6052			global_zone_page_state(NR_FREE_PAGES),
  6053			free_pcp,
  6054			global_zone_page_state(NR_FREE_CMA_PAGES));
  6055	
  6056		for_each_online_pgdat(pgdat) {
  6057			if (show_mem_node_skip(filter, pgdat->node_id, nodemask))
  6058				continue;
  6059	
  6060			printk("Node %d"
  6061				" active_anon:%lukB"
  6062				" inactive_anon:%lukB"
  6063				" active_file:%lukB"
  6064				" inactive_file:%lukB"
  6065				" unevictable:%lukB"
  6066				" isolated(anon):%lukB"
  6067				" isolated(file):%lukB"
  6068				" mapped:%lukB"
  6069				" dirty:%lukB"
  6070				" writeback:%lukB"
  6071				" shmem:%lukB"
  6072	#ifdef CONFIG_TRANSPARENT_HUGEPAGE
  6073				" shmem_thp: %lukB"
  6074				" shmem_pmdmapped: %lukB"
  6075				" anon_thp: %lukB"
  6076	#endif
  6077				" writeback_tmp:%lukB"
  6078				" kernel_stack:%lukB"
  6079	#ifdef CONFIG_SHADOW_CALL_STACK
  6080				" shadow_call_stack:%lukB"
  6081	#endif
  6082				" pagetables:%lukB"
  6083				" all_unreclaimable? %s"
  6084				"\n",
  6085				pgdat->node_id,
  6086				K(node_page_state(pgdat, NR_ACTIVE_ANON)),
  6087				K(node_page_state(pgdat, NR_INACTIVE_ANON)),
  6088				K(node_page_state(pgdat, NR_ACTIVE_FILE)),
  6089				K(node_page_state(pgdat, NR_INACTIVE_FILE)),
  6090				K(node_page_state(pgdat, NR_UNEVICTABLE)),
  6091				K(node_page_state(pgdat, NR_ISOLATED_ANON)),
  6092				K(node_page_state(pgdat, NR_ISOLATED_FILE)),
  6093				K(node_page_state(pgdat, NR_FILE_MAPPED)),
  6094				K(node_page_state(pgdat, NR_FILE_DIRTY)),
  6095				K(node_page_state(pgdat, NR_WRITEBACK)),
  6096				K(node_page_state(pgdat, NR_SHMEM)),
  6097	#ifdef CONFIG_TRANSPARENT_HUGEPAGE
  6098				K(node_page_state(pgdat, NR_SHMEM_THPS)),
  6099				K(node_page_state(pgdat, NR_SHMEM_PMDMAPPED)),
  6100				K(node_page_state(pgdat, NR_ANON_THPS)),
  6101	#endif
  6102				K(node_page_state(pgdat, NR_WRITEBACK_TEMP)),
  6103				node_page_state(pgdat, NR_KERNEL_STACK_KB),
  6104	#ifdef CONFIG_SHADOW_CALL_STACK
  6105				node_page_state(pgdat, NR_KERNEL_SCS_KB),
  6106	#endif
  6107				K(node_page_state(pgdat, NR_PAGETABLE)),
  6108				pgdat->kswapd_failures >= MAX_RECLAIM_RETRIES ?
  6109					"yes" : "no");
  6110		}
  6111	
  6112		for_each_populated_zone(zone) {
  6113			int i;
  6114	
  6115			if (show_mem_node_skip(filter, zone_to_nid(zone), nodemask))
  6116				continue;
  6117	
  6118			free_pcp = 0;
  6119			for_each_online_cpu(cpu)
  6120				free_pcp += per_cpu_ptr(zone->per_cpu_pageset, cpu)->count;
  6121	
  6122			show_node(zone);
  6123			printk(KERN_CONT
  6124				"%s"
  6125				" free:%lukB"
  6126				" boost:%lukB"
  6127				" min:%lukB"
  6128				" low:%lukB"
  6129				" high:%lukB"
  6130				" reserved_highatomic:%luKB"
  6131				" active_anon:%lukB"
  6132				" inactive_anon:%lukB"
  6133				" active_file:%lukB"
  6134				" inactive_file:%lukB"
  6135				" unevictable:%lukB"
  6136				" writepending:%lukB"
  6137				" present:%lukB"
  6138				" managed:%lukB"
  6139				" mlocked:%lukB"
  6140				" bounce:%lukB"
  6141				" free_pcp:%lukB"
  6142				" local_pcp:%ukB"
  6143				" free_cma:%lukB"
  6144				"\n",
  6145				zone->name,
  6146				K(zone_page_state(zone, NR_FREE_PAGES)),
  6147				K(zone->watermark_boost),
  6148				K(min_wmark_pages(zone)),
  6149				K(low_wmark_pages(zone)),
  6150				K(high_wmark_pages(zone)),
  6151				K(zone->nr_reserved_highatomic),
  6152				K(zone_page_state(zone, NR_ZONE_ACTIVE_ANON)),
  6153				K(zone_page_state(zone, NR_ZONE_INACTIVE_ANON)),
  6154				K(zone_page_state(zone, NR_ZONE_ACTIVE_FILE)),
  6155				K(zone_page_state(zone, NR_ZONE_INACTIVE_FILE)),
  6156				K(zone_page_state(zone, NR_ZONE_UNEVICTABLE)),
  6157				K(zone_page_state(zone, NR_ZONE_WRITE_PENDING)),
  6158				K(zone->present_pages),
  6159				K(zone_managed_pages(zone)),
  6160				K(zone_page_state(zone, NR_MLOCK)),
  6161				K(zone_page_state(zone, NR_BOUNCE)),
  6162				K(free_pcp),
  6163				K(this_cpu_read(zone->per_cpu_pageset->count)),
  6164				K(zone_page_state(zone, NR_FREE_CMA_PAGES)));
  6165			printk("lowmem_reserve[]:");
  6166			for (i = 0; i < MAX_NR_ZONES; i++)
  6167				printk(KERN_CONT " %ld", zone->lowmem_reserve[i]);
  6168			printk(KERN_CONT "\n");
  6169		}
  6170	
  6171		for_each_populated_zone(zone) {
  6172			unsigned int order;
  6173			unsigned long nr[MAX_ORDER], flags, total = 0;
  6174			unsigned char types[MAX_ORDER];
  6175	
  6176			if (show_mem_node_skip(filter, zone_to_nid(zone), nodemask))
  6177				continue;
  6178			show_node(zone);
  6179			printk(KERN_CONT "%s: ", zone->name);
  6180	
  6181			spin_lock_irqsave(&zone->lock, flags);
  6182			for (order = 0; order < MAX_ORDER; order++) {
  6183				struct free_area *area = &zone->free_area[order];
  6184				int type;
  6185	
  6186				nr[order] = area->nr_free;
  6187				total += nr[order] << order;
  6188	
  6189				types[order] = 0;
  6190				for (type = 0; type < MIGRATE_TYPES; type++) {
  6191					if (!free_area_empty(area, type))
  6192						types[order] |= 1 << type;
  6193				}
  6194			}
  6195			spin_unlock_irqrestore(&zone->lock, flags);
  6196			for (order = 0; order < MAX_ORDER; order++) {
  6197				printk(KERN_CONT "%lu*%lukB ",
  6198				       nr[order], K(1UL) << order);
  6199				if (nr[order])
  6200					show_migration_types(types[order]);
  6201			}
  6202			printk(KERN_CONT "= %lukB\n", K(total));
  6203		}
  6204	
> 6205		if (hugepages_supported()) {
  6206			for_each_node_state(nid, N_MEMORY) {
  6207				if (show_mem_node_skip(filter, nid, nodemask))
  6208					continue;
  6209				hugetlb_show_meminfo_node(nid);
  6210			}
  6211		}
  6212	
  6213		printk("%ld total pagecache pages\n", global_node_page_state(NR_FILE_PAGES));
  6214	
  6215		show_swap_cache_info();
  6216	}
  6217	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
