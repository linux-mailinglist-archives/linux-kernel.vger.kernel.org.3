Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85A6A4D3E7D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 01:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235102AbiCJA6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 19:58:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238208AbiCJA6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 19:58:06 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC710C0842
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 16:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646873826; x=1678409826;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EGCCGf78mu6c1NuKFEQ6fLhRTn1OWX4f7P2TPo065pc=;
  b=cuC6WWF340+XQMp1CNHDScR/HNCjQ//6WmUHSVQTly6l5h3tLUovXwys
   uEXltPU+VCTtfA/TGg7L1F21Y/zzz8eq6/qI+vp8y6+WcZhb3mUPZd9X8
   TapzBxiMH6cXIztADjTInYrXL9UEUfD6ch3IYvTxvTkd26HAeVlJAx+S5
   RsFSnNaanYb8qpXzJNvejq6CG/W9RC5RCoXbAWtDJ4cTn1QnEoj/+AvwQ
   R9sTBOiEmvBo6iv4vKS1nW/hjXnpTzoQ6BBHqc8d/nJgKs+0eLrZeG37f
   FAe6OG+vj0M6IvOiPvcXH3+JCrw1GCzvIsfcxSlOZuRZUT8qnsZqrVCVB
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="242572006"
X-IronPort-AV: E=Sophos;i="5.90,169,1643702400"; 
   d="scan'208";a="242572006"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 16:57:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,169,1643702400"; 
   d="scan'208";a="642361390"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 09 Mar 2022 16:57:04 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nS771-00045W-Fx; Thu, 10 Mar 2022 00:57:03 +0000
Date:   Thu, 10 Mar 2022 08:56:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Abhishek Goel <huntbag@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH] mm: Only re-generate demotion targets when a numa node
 changes its N_CPU state
Message-ID: <202203100830.iDtoMHKt-lkp@intel.com>
References: <20220309144644.4278-1-osalvador@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220309144644.4278-1-osalvador@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oscar,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on hnaz-mm/master]

url:    https://github.com/0day-ci/linux/commits/Oscar-Salvador/mm-Only-re-generate-demotion-targets-when-a-numa-node-changes-its-N_CPU-state/20220309-224707
base:   https://github.com/hnaz/linux-mm master
config: sparc-randconfig-r001-20220309 (https://download.01.org/0day-ci/archive/20220310/202203100830.iDtoMHKt-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/8af0c9ff9475c64e31963a5810b127875081c5ff
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Oscar-Salvador/mm-Only-re-generate-demotion-targets-when-a-numa-node-changes-its-N_CPU-state/20220309-224707
        git checkout 8af0c9ff9475c64e31963a5810b127875081c5ff
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=sparc SHELL=/bin/bash kernel/sched/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from kernel/sched/sched.h:53,
                    from kernel/sched/core.c:13:
   include/linux/migrate.h:54:20: error: function declaration isn't a prototype [-Werror=strict-prototypes]
      54 | static inline void set_migration_target_nodes() {}
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/migrate.h: In function 'set_migration_target_nodes':
>> include/linux/migrate.h:54:20: warning: old-style function definition [-Wold-style-definition]
   kernel/sched/core.c: At top level:
   kernel/sched/core.c:3442:6: warning: no previous prototype for 'sched_set_stop_task' [-Wmissing-prototypes]
    3442 | void sched_set_stop_task(int cpu, struct task_struct *stop)
         |      ^~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from kernel/sched/sched.h:53,
                    from kernel/sched/loadavg.c:9:
   include/linux/migrate.h:54:20: error: function declaration isn't a prototype [-Werror=strict-prototypes]
      54 | static inline void set_migration_target_nodes() {}
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/migrate.h: In function 'set_migration_target_nodes':
>> include/linux/migrate.h:54:20: warning: old-style function definition [-Wold-style-definition]
   cc1: some warnings being treated as errors
--
   In file included from kernel/sched/sched.h:53,
                    from kernel/sched/fair.c:23:
   include/linux/migrate.h:54:20: error: function declaration isn't a prototype [-Werror=strict-prototypes]
      54 | static inline void set_migration_target_nodes() {}
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/migrate.h: In function 'set_migration_target_nodes':
>> include/linux/migrate.h:54:20: warning: old-style function definition [-Wold-style-definition]
   kernel/sched/fair.c: At top level:
   kernel/sched/fair.c:11135:6: warning: no previous prototype for 'task_vruntime_update' [-Wmissing-prototypes]
   11135 | void task_vruntime_update(struct rq *rq, struct task_struct *p, bool in_fi)
         |      ^~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from kernel/sched/sched.h:53,
                    from kernel/sched/rt.c:6:
   include/linux/migrate.h:54:20: error: function declaration isn't a prototype [-Werror=strict-prototypes]
      54 | static inline void set_migration_target_nodes() {}
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/migrate.h: In function 'set_migration_target_nodes':
>> include/linux/migrate.h:54:20: warning: old-style function definition [-Wold-style-definition]
   kernel/sched/rt.c: At top level:
   kernel/sched/rt.c:730:6: warning: no previous prototype for 'sched_rt_bandwidth_account' [-Wmissing-prototypes]
     730 | bool sched_rt_bandwidth_account(struct rt_rq *rt_rq)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +54 include/linux/migrate.h

    36	
    37	extern void migrate_page_states(struct page *newpage, struct page *page);
    38	extern void migrate_page_copy(struct page *newpage, struct page *page);
    39	extern int migrate_huge_page_move_mapping(struct address_space *mapping,
    40					  struct page *newpage, struct page *page);
    41	extern int migrate_page_move_mapping(struct address_space *mapping,
    42			struct page *newpage, struct page *page, int extra_count);
    43	void migration_entry_wait_on_locked(swp_entry_t entry, pte_t *ptep,
    44					spinlock_t *ptl);
    45	void folio_migrate_flags(struct folio *newfolio, struct folio *folio);
    46	void folio_migrate_copy(struct folio *newfolio, struct folio *folio);
    47	int folio_migrate_mapping(struct address_space *mapping,
    48			struct folio *newfolio, struct folio *folio, int extra_count);
    49	
    50	extern bool numa_demotion_enabled;
    51	#ifdef CONFIG_HOTPLUG_CPU
    52	extern void set_migration_target_nodes(void);
    53	#else
  > 54	static inline void set_migration_target_nodes() {}
    55	#endif
    56	#else
    57	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
