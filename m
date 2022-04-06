Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35E004F6572
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 18:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237803AbiDFQcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 12:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237755AbiDFQcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 12:32:03 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E7E166219
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 18:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649209309; x=1680745309;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pFeUDZdbHypjQysHermdGH2UeJrOWPlGH628yIS4cOM=;
  b=HRICZR2H7a3Z30Q3bBWOjq3J4HH0Z9FVzjTyAf8R979GPC/31KyctMpQ
   Vt8YbBEvVV6YMLvljxIb6wW8dYh//kZLKeX8hj2qxK2KXHcNmwsZCPZ7z
   flN0zKEKqIl49ehHBlD6pCO3Q0r0459YBQ9e2MufCF1tgczKm9Cs9CJgt
   E9ILZyuKfyzaIRvL9dk5nwzLj95jWMq6QX+TI2A+9y6mYZTO7zxr39adw
   KQT0pfhtRWFmknyRVXZbniIC+O0NOh0nB8BGoxsUYSSVfsMgEbocxdnPe
   zusMPP+ZOnngVSwODhW+eFTk/+fSlG+bEHinpjFQOtYxmlKVior50m99J
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10308"; a="285883929"
X-IronPort-AV: E=Sophos;i="5.90,238,1643702400"; 
   d="scan'208";a="285883929"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 18:41:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,238,1643702400"; 
   d="scan'208";a="641854568"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 05 Apr 2022 18:41:44 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nbug3-0003xt-RO;
        Wed, 06 Apr 2022 01:41:43 +0000
Date:   Wed, 6 Apr 2022 09:41:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     kbuild-all@lists.01.org, Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Alistair Popple <apopple@nvidia.com>, peterx@redhat.com
Subject: Re: [PATCH v8 04/23] mm/uffd: PTE_MARKER_UFFD_WP
Message-ID: <202204060938.eKyGvcev-lkp@intel.com>
References: <20220405014838.14131-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220405014838.14131-1-peterx@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on hnaz-mm/master]
[also build test ERROR on arnd-asm-generic/master linus/master v5.18-rc1 next-20220405]
[cannot apply to linux/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Peter-Xu/userfaultfd-wp-Support-shmem-and-hugetlbfs/20220405-100136
base:   https://github.com/hnaz/linux-mm master
config: ia64-buildonly-randconfig-r005-20220405 (https://download.01.org/0day-ci/archive/20220406/202204060938.eKyGvcev-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/5baea0f03d347e5b13fff03af297858f1247d51a
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Peter-Xu/userfaultfd-wp-Support-shmem-and-hugetlbfs/20220405-100136
        git checkout 5baea0f03d347e5b13fff03af297858f1247d51a
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=ia64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/ia64/include/asm/pgtable.h:153,
                    from include/linux/pgtable.h:6,
                    from arch/ia64/include/asm/uaccess.h:40,
                    from include/linux/uaccess.h:11,
                    from include/linux/sched/task.h:11,
                    from include/linux/sched/signal.h:9,
                    from include/linux/rcuwait.h:6,
                    from include/linux/percpu-rwsem.h:7,
                    from include/linux/fs.h:33,
                    from arch/ia64/kernel/sys_ia64.c:10:
   arch/ia64/include/asm/mmu_context.h: In function 'reload_context':
   arch/ia64/include/asm/mmu_context.h:127:48: warning: variable 'old_rr4' set but not used [-Wunused-but-set-variable]
     127 |         unsigned long rr0, rr1, rr2, rr3, rr4, old_rr4;
         |                                                ^~~~~~~
   In file included from include/linux/hugetlb.h:14,
                    from arch/ia64/kernel/sys_ia64.c:21:
   include/linux/userfaultfd_k.h: In function 'pte_marker_entry_uffd_wp':
>> include/linux/userfaultfd_k.h:243:16: error: implicit declaration of function 'is_pte_marker_entry' [-Werror=implicit-function-declaration]
     243 |         return is_pte_marker_entry(entry) &&
         |                ^~~~~~~~~~~~~~~~~~~
>> include/linux/userfaultfd_k.h:244:14: error: implicit declaration of function 'pte_marker_get' [-Werror=implicit-function-declaration]
     244 |             (pte_marker_get(entry) & PTE_MARKER_UFFD_WP);
         |              ^~~~~~~~~~~~~~
>> include/linux/userfaultfd_k.h:244:38: error: 'PTE_MARKER_UFFD_WP' undeclared (first use in this function)
     244 |             (pte_marker_get(entry) & PTE_MARKER_UFFD_WP);
         |                                      ^~~~~~~~~~~~~~~~~~
   include/linux/userfaultfd_k.h:244:38: note: each undeclared identifier is reported only once for each function it appears in
   arch/ia64/kernel/sys_ia64.c: At top level:
   arch/ia64/kernel/sys_ia64.c:71:1: warning: no previous prototype for 'ia64_getpriority' [-Wmissing-prototypes]
      71 | ia64_getpriority (int which, int who)
         | ^~~~~~~~~~~~~~~~
   arch/ia64/kernel/sys_ia64.c:85:1: warning: no previous prototype for 'sys_getpagesize' [-Wmissing-prototypes]
      85 | sys_getpagesize (void)
         | ^~~~~~~~~~~~~~~
   arch/ia64/kernel/sys_ia64.c:91:1: warning: no previous prototype for 'ia64_brk' [-Wmissing-prototypes]
      91 | ia64_brk (unsigned long brk)
         | ^~~~~~~~
   arch/ia64/kernel/sys_ia64.c:161:1: warning: no previous prototype for 'ia64_mremap' [-Wmissing-prototypes]
     161 | ia64_mremap (unsigned long addr, unsigned long old_len, unsigned long new_len, unsigned long flags,
         | ^~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from arch/ia64/include/asm/pgtable.h:153,
                    from include/linux/pgtable.h:6,
                    from arch/ia64/include/asm/uaccess.h:40,
                    from include/linux/uaccess.h:11,
                    from include/linux/sched/task.h:11,
                    from kernel/fork.c:23:
   arch/ia64/include/asm/mmu_context.h: In function 'reload_context':
   arch/ia64/include/asm/mmu_context.h:127:48: warning: variable 'old_rr4' set but not used [-Wunused-but-set-variable]
     127 |         unsigned long rr0, rr1, rr2, rr3, rr4, old_rr4;
         |                                                ^~~~~~~
   In file included from include/linux/hugetlb.h:14,
                    from kernel/fork.c:52:
   include/linux/userfaultfd_k.h: In function 'pte_marker_entry_uffd_wp':
>> include/linux/userfaultfd_k.h:243:16: error: implicit declaration of function 'is_pte_marker_entry' [-Werror=implicit-function-declaration]
     243 |         return is_pte_marker_entry(entry) &&
         |                ^~~~~~~~~~~~~~~~~~~
>> include/linux/userfaultfd_k.h:244:14: error: implicit declaration of function 'pte_marker_get' [-Werror=implicit-function-declaration]
     244 |             (pte_marker_get(entry) & PTE_MARKER_UFFD_WP);
         |              ^~~~~~~~~~~~~~
>> include/linux/userfaultfd_k.h:244:38: error: 'PTE_MARKER_UFFD_WP' undeclared (first use in this function)
     244 |             (pte_marker_get(entry) & PTE_MARKER_UFFD_WP);
         |                                      ^~~~~~~~~~~~~~~~~~
   include/linux/userfaultfd_k.h:244:38: note: each undeclared identifier is reported only once for each function it appears in
   kernel/fork.c: At top level:
   kernel/fork.c:163:13: warning: no previous prototype for 'arch_release_task_struct' [-Wmissing-prototypes]
     163 | void __weak arch_release_task_struct(struct task_struct *tsk)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~
   kernel/fork.c:853:20: warning: no previous prototype for 'arch_task_cache_init' [-Wmissing-prototypes]
     853 | void __init __weak arch_task_cache_init(void) { }
         |                    ^~~~~~~~~~~~~~~~~~~~
   kernel/fork.c:948:12: warning: no previous prototype for 'arch_dup_task_struct' [-Wmissing-prototypes]
     948 | int __weak arch_dup_task_struct(struct task_struct *dst,
         |            ^~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from arch/ia64/include/asm/pgtable.h:153,
                    from include/linux/pgtable.h:6,
                    from include/linux/mm.h:29,
                    from kernel/sysctl.c:23:
   arch/ia64/include/asm/mmu_context.h: In function 'reload_context':
   arch/ia64/include/asm/mmu_context.h:127:48: warning: variable 'old_rr4' set but not used [-Wunused-but-set-variable]
     127 |         unsigned long rr0, rr1, rr2, rr3, rr4, old_rr4;
         |                                                ^~~~~~~
   In file included from include/linux/hugetlb.h:14,
                    from kernel/sysctl.c:46:
   include/linux/userfaultfd_k.h: In function 'pte_marker_entry_uffd_wp':
>> include/linux/userfaultfd_k.h:243:16: error: implicit declaration of function 'is_pte_marker_entry' [-Werror=implicit-function-declaration]
     243 |         return is_pte_marker_entry(entry) &&
         |                ^~~~~~~~~~~~~~~~~~~
>> include/linux/userfaultfd_k.h:244:14: error: implicit declaration of function 'pte_marker_get' [-Werror=implicit-function-declaration]
     244 |             (pte_marker_get(entry) & PTE_MARKER_UFFD_WP);
         |              ^~~~~~~~~~~~~~
>> include/linux/userfaultfd_k.h:244:38: error: 'PTE_MARKER_UFFD_WP' undeclared (first use in this function)
     244 |             (pte_marker_get(entry) & PTE_MARKER_UFFD_WP);
         |                                      ^~~~~~~~~~~~~~~~~~
   include/linux/userfaultfd_k.h:244:38: note: each undeclared identifier is reported only once for each function it appears in
   cc1: some warnings being treated as errors
--
   In file included from arch/ia64/include/asm/pgtable.h:153,
                    from include/linux/pgtable.h:6,
                    from include/linux/mm.h:29,
                    from mm/vmscan.c:15:
   arch/ia64/include/asm/mmu_context.h: In function 'reload_context':
   arch/ia64/include/asm/mmu_context.h:127:48: warning: variable 'old_rr4' set but not used [-Wunused-but-set-variable]
     127 |         unsigned long rr0, rr1, rr2, rr3, rr4, old_rr4;
         |                                                ^~~~~~~
   In file included from include/linux/hugetlb.h:14,
                    from include/linux/migrate.h:8,
                    from mm/vmscan.c:44:
   include/linux/userfaultfd_k.h: In function 'pte_marker_entry_uffd_wp':
>> include/linux/userfaultfd_k.h:243:16: error: implicit declaration of function 'is_pte_marker_entry' [-Werror=implicit-function-declaration]
     243 |         return is_pte_marker_entry(entry) &&
         |                ^~~~~~~~~~~~~~~~~~~
>> include/linux/userfaultfd_k.h:244:14: error: implicit declaration of function 'pte_marker_get' [-Werror=implicit-function-declaration]
     244 |             (pte_marker_get(entry) & PTE_MARKER_UFFD_WP);
         |              ^~~~~~~~~~~~~~
>> include/linux/userfaultfd_k.h:244:38: error: 'PTE_MARKER_UFFD_WP' undeclared (first use in this function)
     244 |             (pte_marker_get(entry) & PTE_MARKER_UFFD_WP);
         |                                      ^~~~~~~~~~~~~~~~~~
   include/linux/userfaultfd_k.h:244:38: note: each undeclared identifier is reported only once for each function it appears in
   In file included from mm/vmscan.c:57:
   include/linux/swapops.h: At top level:
>> include/linux/swapops.h:289:20: error: conflicting types for 'is_pte_marker_entry'; have 'bool(swp_entry_t)' {aka '_Bool(swp_entry_t)'}
     289 | static inline bool is_pte_marker_entry(swp_entry_t entry)
         |                    ^~~~~~~~~~~~~~~~~~~
   In file included from include/linux/hugetlb.h:14,
                    from include/linux/migrate.h:8,
                    from mm/vmscan.c:44:
   include/linux/userfaultfd_k.h:243:16: note: previous implicit declaration of 'is_pte_marker_entry' with type 'int()'
     243 |         return is_pte_marker_entry(entry) &&
         |                ^~~~~~~~~~~~~~~~~~~
   In file included from mm/vmscan.c:57:
>> include/linux/swapops.h:294:26: error: conflicting types for 'pte_marker_get'; have 'pte_marker(swp_entry_t)' {aka 'long unsigned int(swp_entry_t)'}
     294 | static inline pte_marker pte_marker_get(swp_entry_t entry)
         |                          ^~~~~~~~~~~~~~
   In file included from include/linux/hugetlb.h:14,
                    from include/linux/migrate.h:8,
                    from mm/vmscan.c:44:
   include/linux/userfaultfd_k.h:244:14: note: previous implicit declaration of 'pte_marker_get' with type 'int()'
     244 |             (pte_marker_get(entry) & PTE_MARKER_UFFD_WP);
         |              ^~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from arch/ia64/include/asm/pgtable.h:153,
                    from include/linux/pgtable.h:6,
                    from arch/ia64/include/asm/uaccess.h:40,
                    from include/linux/uaccess.h:11,
                    from include/linux/sched/task.h:11,
                    from include/linux/sched/signal.h:9,
                    from include/linux/rcuwait.h:6,
                    from include/linux/percpu-rwsem.h:7,
                    from include/linux/fs.h:33,
                    from fs/proc/meminfo.c:2:
   arch/ia64/include/asm/mmu_context.h: In function 'reload_context':
   arch/ia64/include/asm/mmu_context.h:127:48: warning: variable 'old_rr4' set but not used [-Wunused-but-set-variable]
     127 |         unsigned long rr0, rr1, rr2, rr3, rr4, old_rr4;
         |                                                ^~~~~~~
   In file included from include/linux/hugetlb.h:14,
                    from fs/proc/meminfo.c:6:
   include/linux/userfaultfd_k.h: In function 'pte_marker_entry_uffd_wp':
>> include/linux/userfaultfd_k.h:243:16: error: implicit declaration of function 'is_pte_marker_entry' [-Werror=implicit-function-declaration]
     243 |         return is_pte_marker_entry(entry) &&
         |                ^~~~~~~~~~~~~~~~~~~
>> include/linux/userfaultfd_k.h:244:14: error: implicit declaration of function 'pte_marker_get' [-Werror=implicit-function-declaration]
     244 |             (pte_marker_get(entry) & PTE_MARKER_UFFD_WP);
         |              ^~~~~~~~~~~~~~
>> include/linux/userfaultfd_k.h:244:38: error: 'PTE_MARKER_UFFD_WP' undeclared (first use in this function)
     244 |             (pte_marker_get(entry) & PTE_MARKER_UFFD_WP);
         |                                      ^~~~~~~~~~~~~~~~~~
   include/linux/userfaultfd_k.h:244:38: note: each undeclared identifier is reported only once for each function it appears in
   fs/proc/meminfo.c: At top level:
   fs/proc/meminfo.c:22:28: warning: no previous prototype for 'arch_report_meminfo' [-Wmissing-prototypes]
      22 | void __attribute__((weak)) arch_report_meminfo(struct seq_file *m)
         |                            ^~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/is_pte_marker_entry +243 include/linux/userfaultfd_k.h

   240	
   241	static inline bool pte_marker_entry_uffd_wp(swp_entry_t entry)
   242	{
 > 243		return is_pte_marker_entry(entry) &&
 > 244		    (pte_marker_get(entry) & PTE_MARKER_UFFD_WP);
   245	}
   246	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
