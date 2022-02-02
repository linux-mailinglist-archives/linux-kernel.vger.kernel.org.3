Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1328A4A7109
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 13:49:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344214AbiBBMtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 07:49:00 -0500
Received: from mga11.intel.com ([192.55.52.93]:22455 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231931AbiBBMs7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 07:48:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643806139; x=1675342139;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9R23Y71WY2/eFfRHa+sSGWQwsQOjWv/VYmz5SxLVrzM=;
  b=W1HGKL3nmBeG3SfZXC+NixIBj11D8n0IZQbaYjuqJ9+XGQfuZXD0z89I
   edFkN8w3UWq/2fLkI8566NV1B7/J8xUrRBzgPdx4wukxBvWh+YPJmXsJr
   p3MxtAxR8si1Jazll73U3/3TP0pLJOrsY8zKCfLWBLfWK0IGDv60qDFmv
   kS9CqwjmS3pXBA9e2s6KpWehgtd2Xky9h3Spg1N2zTLvocOS8W3CYr6ws
   zHsCy2lfzEPo3fiFCRPz1VymbvSkEf6h+bXSwpPHnS07WBLjl4/EBvadc
   M2J2D1C+ipOZ1IEA6lUZ3cITYBke2Zwp6mkcPsyUhaT/tC/qdQChm4hEH
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10245"; a="245501847"
X-IronPort-AV: E=Sophos;i="5.88,336,1635231600"; 
   d="scan'208";a="245501847"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 04:48:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,336,1635231600"; 
   d="scan'208";a="480094065"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 02 Feb 2022 04:48:56 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nFF4B-000UaO-M6; Wed, 02 Feb 2022 12:48:55 +0000
Date:   Wed, 2 Feb 2022 20:48:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>
Subject: Re: [PATCH 2/4] mm/kasan: Move kasan_pXX_table() and
 kasan_early_shadow_page_entry()
Message-ID: <202202022041.mkJKLdPP-lkp@intel.com>
References: <3fe9bf0867b2ffc7cd43fe7040ee18d245641ec1.1643791473.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3fe9bf0867b2ffc7cd43fe7040ee18d245641ec1.1643791473.git.christophe.leroy@csgroup.eu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

I love your patch! Yet something to improve:

[auto build test ERROR on tip/sched/core]
[also build test ERROR on linus/master v5.17-rc2]
[cannot apply to hnaz-mm/master next-20220202]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Christophe-Leroy/mm-kasan-Add-CONFIG_KASAN_SOFTWARE/20220202-164612
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git ec2444530612a886b406e2830d7f314d1a07d4bb
config: riscv-randconfig-r042-20220130 (https://download.01.org/0day-ci/archive/20220202/202202022041.mkJKLdPP-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/23eabd57613c3b304c1c54f1133ef5376cf5731d
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Christophe-Leroy/mm-kasan-Add-CONFIG_KASAN_SOFTWARE/20220202-164612
        git checkout 23eabd57613c3b304c1c54f1133ef5376cf5731d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=riscv SHELL=/bin/bash kernel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/slab.h:136,
                    from kernel/fork.c:16:
>> include/linux/kasan.h:102:36: error: unknown type name 'p4d_t'; did you mean 'pgd_t'?
     102 | static inline bool kasan_pud_table(p4d_t p4d)
         |                                    ^~~~~
         |                                    pgd_t
>> include/linux/kasan.h:113:36: error: unknown type name 'pud_t'; did you mean 'pgd_t'?
     113 | static inline bool kasan_pmd_table(pud_t pud)
         |                                    ^~~~~
         |                                    pgd_t
>> include/linux/kasan.h:130:36: error: unknown type name 'pmd_t'; did you mean 'pgd_t'?
     130 | static inline bool kasan_pte_table(pmd_t pmd)
         |                                    ^~~~~
         |                                    pgd_t
   kernel/fork.c:162:13: warning: no previous prototype for 'arch_release_task_struct' [-Wmissing-prototypes]
     162 | void __weak arch_release_task_struct(struct task_struct *tsk)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~
   kernel/fork.c:764:20: warning: no previous prototype for 'arch_task_cache_init' [-Wmissing-prototypes]
     764 | void __init __weak arch_task_cache_init(void) { }
         |                    ^~~~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/slab.h:136,
                    from kernel/resource.c:17:
>> include/linux/kasan.h:102:36: error: unknown type name 'p4d_t'; did you mean 'pgd_t'?
     102 | static inline bool kasan_pud_table(p4d_t p4d)
         |                                    ^~~~~
         |                                    pgd_t
>> include/linux/kasan.h:113:36: error: unknown type name 'pud_t'; did you mean 'pgd_t'?
     113 | static inline bool kasan_pmd_table(pud_t pud)
         |                                    ^~~~~
         |                                    pgd_t
>> include/linux/kasan.h:130:36: error: unknown type name 'pmd_t'; did you mean 'pgd_t'?
     130 | static inline bool kasan_pte_table(pmd_t pmd)
         |                                    ^~~~~
         |                                    pgd_t
--
   In file included from include/linux/slab.h:136,
                    from include/linux/resource_ext.h:11,
                    from include/linux/acpi.h:14,
                    from kernel/irq/irqdomain.c:5:
>> include/linux/kasan.h:102:36: error: unknown type name 'p4d_t'; did you mean 'pgd_t'?
     102 | static inline bool kasan_pud_table(p4d_t p4d)
         |                                    ^~~~~
         |                                    pgd_t
>> include/linux/kasan.h:113:36: error: unknown type name 'pud_t'; did you mean 'pgd_t'?
     113 | static inline bool kasan_pmd_table(pud_t pud)
         |                                    ^~~~~
         |                                    pgd_t
>> include/linux/kasan.h:130:36: error: unknown type name 'pmd_t'; did you mean 'pgd_t'?
     130 | static inline bool kasan_pte_table(pmd_t pmd)
         |                                    ^~~~~
         |                                    pgd_t
   kernel/irq/irqdomain.c:1918:13: warning: no previous prototype for 'irq_domain_debugfs_init' [-Wmissing-prototypes]
    1918 | void __init irq_domain_debugfs_init(struct dentry *root)
         |             ^~~~~~~~~~~~~~~~~~~~~~~


vim +102 include/linux/kasan.h

    84	
    85	#if defined(CONFIG_KASAN_SOFTWARE) && CONFIG_PGTABLE_LEVELS > 4
    86	static inline bool kasan_p4d_table(pgd_t pgd)
    87	{
    88		return pgd_page(pgd) == virt_to_page(lm_alias(kasan_early_shadow_p4d));
    89	}
    90	#else
    91	static inline bool kasan_p4d_table(pgd_t pgd)
    92	{
    93		return false;
    94	}
    95	#endif
    96	#if defined(CONFIG_KASAN_SOFTWARE) && CONFIG_PGTABLE_LEVELS > 3
    97	static inline bool kasan_pud_table(p4d_t p4d)
    98	{
    99		return p4d_page(p4d) == virt_to_page(lm_alias(kasan_early_shadow_pud));
   100	}
   101	#else
 > 102	static inline bool kasan_pud_table(p4d_t p4d)
   103	{
   104		return false;
   105	}
   106	#endif
   107	#if defined(CONFIG_KASAN_SOFTWARE) && CONFIG_PGTABLE_LEVELS > 2
   108	static inline bool kasan_pmd_table(pud_t pud)
   109	{
   110		return pud_page(pud) == virt_to_page(lm_alias(kasan_early_shadow_pmd));
   111	}
   112	#else
 > 113	static inline bool kasan_pmd_table(pud_t pud)
   114	{
   115		return false;
   116	}
   117	#endif
   118	
   119	#ifdef CONFIG_KASAN_SOFTWARE
   120	static inline bool kasan_pte_table(pmd_t pmd)
   121	{
   122		return pmd_page(pmd) == virt_to_page(lm_alias(kasan_early_shadow_pte));
   123	}
   124	
   125	static inline bool kasan_early_shadow_page_entry(pte_t pte)
   126	{
   127		return pte_page(pte) == virt_to_page(lm_alias(kasan_early_shadow_page));
   128	}
   129	#else
 > 130	static inline bool kasan_pte_table(pmd_t pmd)
   131	{
   132		return false;
   133	}
   134	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
