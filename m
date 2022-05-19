Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 474F452D969
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 17:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241389AbiESPxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 11:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240167AbiESPwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 11:52:50 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 881B980208;
        Thu, 19 May 2022 08:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652975569; x=1684511569;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BdIcZ28kMML4JTbMVnqd6Nbq0SV8x9x9A1cu4p4O3hU=;
  b=YEtgoOGHIuXPdNd0sJI8advn11leef/vcHBEnUu80ismfV9rzcjYfLDo
   FUuBnIJB4GH7aMYvEqITTfvw7shBJbgIeaShDb2S11g+V8iuawMh7hEEt
   Jadv7SYIGENeNvQM1yQlEu5STfvOdqscRGgj0J12F61fI9Jt+Xu5bKK6C
   +sxLcGjNG0RRPHPRSqqgkmDOeDxcukEJQoLGLb+h1s4mPvPyowD2Cgj++
   9E2qqSVy5fTZHtP+RWHt45/IUlDBsdrb9eAJfo2lUPJsO3uwkQBf4sKrM
   EyOTopJZxDQihoUXqGYnMKwLk/JOjOxj1Ry/nYWeVmL8/7Sqzfj9IK79l
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10352"; a="259832383"
X-IronPort-AV: E=Sophos;i="5.91,237,1647327600"; 
   d="scan'208";a="259832383"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 08:52:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,237,1647327600"; 
   d="scan'208";a="742984853"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 19 May 2022 08:52:42 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nriSA-0003hv-6e;
        Thu, 19 May 2022 15:52:42 +0000
Date:   Thu, 19 May 2022 23:51:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Muchun Song <songmuchun@bytedance.com>, corbet@lwn.net,
        akpm@linux-foundation.org, paulmck@kernel.org,
        mike.kravetz@oracle.com, osalvador@suse.de, david@redhat.com
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com, smuchun@gmail.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH 1/2] mm: memory_hotplug: enumerate all supported section
 flags
Message-ID: <202205192323.hAhv52wX-lkp@intel.com>
References: <20220519124632.92091-2-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519124632.92091-2-songmuchun@bytedance.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Muchun,

I love your patch! Yet something to improve:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on linux/master linus/master v5.18-rc7 next-20220519]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Muchun-Song/make-hugetlb_optimize_vmemmap-compatible-with-memmap_on_memory/20220519-204849
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
config: x86_64-randconfig-a016 (https://download.01.org/0day-ci/archive/20220519/202205192323.hAhv52wX-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project e00cbbec06c08dc616a0d52a20f678b8fbd4e304)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/94ab57cfaebf53ff1c57cc6c8b3ecc48bef31c5e
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Muchun-Song/make-hugetlb_optimize_vmemmap-compatible-with-memmap_on_memory/20220519-204849
        git checkout 94ab57cfaebf53ff1c57cc6c8b3ecc48bef31c5e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/x86/kernel/asm-offsets.c:9:
   In file included from include/linux/crypto.h:20:
   In file included from include/linux/slab.h:15:
   In file included from include/linux/gfp.h:6:
>> include/linux/mmzone.h:1506:44: error: use of undeclared identifier 'SECTION_TAINT_ZONE_DEVICE'
           unsigned long flags = SECTION_IS_ONLINE | SECTION_TAINT_ZONE_DEVICE;
                                                     ^
   In file included from arch/x86/kernel/asm-offsets.c:13:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:17:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:97:11: warning: array index 3 is past the end of the array (which contains 1 element) [-Warray-bounds]
                   return (set->sig[3] | set->sig[2] |
                           ^        ~
   arch/x86/include/asm/signal.h:24:2: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   In file included from arch/x86/kernel/asm-offsets.c:13:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:17:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:97:25: warning: array index 2 is past the end of the array (which contains 1 element) [-Warray-bounds]
                   return (set->sig[3] | set->sig[2] |
                                         ^        ~
   arch/x86/include/asm/signal.h:24:2: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   In file included from arch/x86/kernel/asm-offsets.c:13:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:17:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:98:4: warning: array index 1 is past the end of the array (which contains 1 element) [-Warray-bounds]
                           set->sig[1] | set->sig[0]) == 0;
                           ^        ~
   arch/x86/include/asm/signal.h:24:2: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   In file included from arch/x86/kernel/asm-offsets.c:13:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:17:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:100:11: warning: array index 1 is past the end of the array (which contains 1 element) [-Warray-bounds]
                   return (set->sig[1] | set->sig[0]) == 0;
                           ^        ~
   arch/x86/include/asm/signal.h:24:2: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   In file included from arch/x86/kernel/asm-offsets.c:13:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:17:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:113:11: warning: array index 3 is past the end of the array (which contains 1 element) [-Warray-bounds]
                   return  (set1->sig[3] == set2->sig[3]) &&
                            ^         ~
   arch/x86/include/asm/signal.h:24:2: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   In file included from arch/x86/kernel/asm-offsets.c:13:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:17:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:113:27: warning: array index 3 is past the end of the array (which contains 1 element) [-Warray-bounds]
                   return  (set1->sig[3] == set2->sig[3]) &&
                                            ^         ~
   arch/x86/include/asm/signal.h:24:2: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   In file included from arch/x86/kernel/asm-offsets.c:13:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:17:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:


vim +/SECTION_TAINT_ZONE_DEVICE +1506 include/linux/mmzone.h

2d070eab2e8270 Michal Hocko 2017-07-06  1503  
1f90a3477df3ff Dan Williams 2021-02-25  1504  static inline int online_device_section(struct mem_section *section)
1f90a3477df3ff Dan Williams 2021-02-25  1505  {
1f90a3477df3ff Dan Williams 2021-02-25 @1506  	unsigned long flags = SECTION_IS_ONLINE | SECTION_TAINT_ZONE_DEVICE;
1f90a3477df3ff Dan Williams 2021-02-25  1507  
1f90a3477df3ff Dan Williams 2021-02-25  1508  	return section && ((section->section_mem_map & flags) == flags);
1f90a3477df3ff Dan Williams 2021-02-25  1509  }
1f90a3477df3ff Dan Williams 2021-02-25  1510  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
