Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68EA658BA4C
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 10:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233270AbiHGIkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 04:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiHGIka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 04:40:30 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C5F63DB
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 01:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659861629; x=1691397629;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zbjwoVkmrnY9d5tbbfVbu86HN2692MVb1+gQEclP/fE=;
  b=g6haSOuIb0WtvqbCgzcsrQ8KTMhH8uGFBntMP3fkFOK02pFUAp0+Iw4G
   DAhVPOz2bXBMnDyyiyqWiZZ8He345G6kbxJeuScIx82JuL1PUeeDAW4xm
   6RQUdu/iGk7UOOyuZ/VMSM8XDBuHbWD+DEANFNb0cG0kPRZNhVz7zU/IE
   7tTjAg8pNUr6MyFkLS6ntu4YxoIL/BStXcGicz1WwgA5sjzb9XmCuSArh
   YFGZ6R+RNBK1Z7ZayvcnU9Et6d4uanvElP7Q2vsR0Yk7VfVeXDJFZXvtb
   V8ag0vsqx044B9iVV5TUxckGlX9pFNKRYCzcinhwbuETfDyGTAOe5uOMd
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10431"; a="270196302"
X-IronPort-AV: E=Sophos;i="5.93,219,1654585200"; 
   d="scan'208";a="270196302"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2022 01:40:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,219,1654585200"; 
   d="scan'208";a="693432924"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Aug 2022 01:40:27 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oKbpi-000LAV-1f;
        Sun, 07 Aug 2022 08:40:26 +0000
Date:   Sun, 7 Aug 2022 16:39:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hao Lee <haolee.swjtu@gmail.com>, akpm@linux-foundation.org
Cc:     kbuild-all@lists.01.org, david@redhat.com,
        yang.shi@linux.alibaba.com, hannes@cmpxchg.org,
        haolee.swjtu@gmail.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] mm: add DEVICE_ZONE to FOR_ALL_ZONES
Message-ID: <202208071635.HaS64efE-lkp@intel.com>
References: <20220804074730.GA3269@haolee.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220804074730.GA3269@haolee.io>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hao,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Hao-Lee/mm-add-DEVICE_ZONE-to-FOR_ALL_ZONES/20220804-154805
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
config: x86_64-randconfig-m001 (https://download.01.org/0day-ci/archive/20220807/202208071635.HaS64efE-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/dba18359aee97f43008e19ffa78421e652b1b102
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Hao-Lee/mm-add-DEVICE_ZONE-to-FOR_ALL_ZONES/20220804-154805
        git checkout dba18359aee97f43008e19ffa78421e652b1b102
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 prepare

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/memcontrol.h:14,
                    from include/linux/swap.h:9,
                    from include/linux/suspend.h:5,
                    from arch/x86/kernel/asm-offsets.c:13:
   include/linux/vm_event_item.h:29:27: error: expected identifier before '(' token
      29 | #define FOR_ALL_ZONES(xx) (DMA_ZONE(xx) DMA32_ZONE(xx) xx##_NORMAL, \
         |                           ^
   include/linux/vm_event_item.h:33:17: note: in expansion of macro 'FOR_ALL_ZONES'
      33 |                 FOR_ALL_ZONES(PGALLOC),
         |                 ^~~~~~~~~~~~~
   In file included from include/linux/swap.h:9,
                    from include/linux/suspend.h:5,
                    from arch/x86/kernel/asm-offsets.c:13:
>> include/linux/memcontrol.h:86:40: error: 'NR_VM_EVENT_ITEMS' undeclared here (not in a function); did you mean 'NR_VM_NUMA_EVENT_ITEMS'?
      86 |         unsigned long           events[NR_VM_EVENT_ITEMS];
         |                                        ^~~~~~~~~~~~~~~~~
         |                                        NR_VM_NUMA_EVENT_ITEMS
   make[2]: *** [scripts/Makefile.build:117: arch/x86/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1200: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +86 include/linux/memcontrol.h

33398cf2f360c5 Michal Hocko    2015-09-08  82  
871789d4af807d Chris Down      2019-05-14  83  struct memcg_vmstats_percpu {
2d146aa3aa842d Johannes Weiner 2021-04-29  84  	/* Local (CPU and cgroup) page state & events */
2d146aa3aa842d Johannes Weiner 2021-04-29  85  	long			state[MEMCG_NR_STAT];
e27be240df53f1 Johannes Weiner 2018-04-10 @86  	unsigned long		events[NR_VM_EVENT_ITEMS];
2d146aa3aa842d Johannes Weiner 2021-04-29  87  
2d146aa3aa842d Johannes Weiner 2021-04-29  88  	/* Delta calculation for lockless upward propagation */
2d146aa3aa842d Johannes Weiner 2021-04-29  89  	long			state_prev[MEMCG_NR_STAT];
2d146aa3aa842d Johannes Weiner 2021-04-29  90  	unsigned long		events_prev[NR_VM_EVENT_ITEMS];
2d146aa3aa842d Johannes Weiner 2021-04-29  91  
2d146aa3aa842d Johannes Weiner 2021-04-29  92  	/* Cgroup1: threshold notifications & softlimit tree updates */
33398cf2f360c5 Michal Hocko    2015-09-08  93  	unsigned long		nr_page_events;
33398cf2f360c5 Michal Hocko    2015-09-08  94  	unsigned long		targets[MEM_CGROUP_NTARGETS];
33398cf2f360c5 Michal Hocko    2015-09-08  95  };
33398cf2f360c5 Michal Hocko    2015-09-08  96  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
