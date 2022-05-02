Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34914517743
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 21:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385114AbiEBTTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 15:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbiEBTTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 15:19:34 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E21DC22
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 12:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651518962; x=1683054962;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/U2kyEhyWhIKt8R+Ejy5LPzrlcI6LU4mrgzqXc7j0I0=;
  b=V/b1w6goY5uWDU2Vv/5syt0p9Iibra93bp2b0oWpBz1pkvy79TmDxPTT
   XKk7UzgSRy3iX+mlGSTpJZo9iE9reYhGyCqMyQrGiTFdokSy2XNuDjBDP
   HiiZtSd29w619ey0YtNu3J62ocOm8WxBTGKH6BKLs50K7N0d5jhFSMcUe
   JqugIfVMgk3xq+o+1KQ4c/SG/Mg1n7naKkbDfSEkX7Fj3d2x5zThw9Wiv
   XoEhj+ZGSy1zxc4YrDbLiOjOITOBAtdqwBTrsMolhI5muFVjOPXjJAk7l
   /3deLvDjkGK5d6B+XwLd3QPNwx8FmlJtZud9ZMD0NLeHsRig+6Ex9HNoU
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10335"; a="254766507"
X-IronPort-AV: E=Sophos;i="5.91,193,1647327600"; 
   d="scan'208";a="254766507"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 12:16:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,193,1647327600"; 
   d="scan'208";a="598764299"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 02 May 2022 12:15:59 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nlbWZ-0009nn-1w;
        Mon, 02 May 2022 19:15:59 +0000
Date:   Tue, 3 May 2022 03:15:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        John Dias <joaodias@google.com>,
        Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH] mm: fix is_pinnable_page against on cma page
Message-ID: <202205030306.in794Jr3-lkp@intel.com>
References: <20220502173558.2510641-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220502173558.2510641-1-minchan@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Minchan,

I love your patch! Yet something to improve:

[auto build test ERROR on hnaz-mm/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Minchan-Kim/mm-fix-is_pinnable_page-against-on-cma-page/20220503-013733
base:   https://github.com/hnaz/linux-mm master
config: nios2-defconfig (https://download.01.org/0day-ci/archive/20220503/202205030306.in794Jr3-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/1b8636710c31d44310f1d344e337c207562b851d
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Minchan-Kim/mm-fix-is_pinnable_page-against-on-cma-page/20220503-013733
        git checkout 1b8636710c31d44310f1d344e337c207562b851d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=nios2 prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/pid_namespace.h:7,
                    from include/linux/ptrace.h:10,
                    from arch/nios2/kernel/asm-offsets.c:9:
   include/linux/mm.h: In function 'is_pinnable_page':
>> include/linux/mm.h:1630:54: error: 'MIGRATE_CMA' undeclared (first use in this function); did you mean 'MIGRATE_SYNC'?
    1630 |         return !(is_zone_movable_page(page) || mt == MIGRATE_CMA ||
         |                                                      ^~~~~~~~~~~
         |                                                      MIGRATE_SYNC
   include/linux/mm.h:1630:54: note: each undeclared identifier is reported only once for each function it appears in
>> include/linux/mm.h:1631:23: error: 'MIGRATE_ISOLATE' undeclared (first use in this function); did you mean 'MIGRATE_MOVABLE'?
    1631 |                 mt == MIGRATE_ISOLATE || is_zero_pfn(page_to_pfn(page)));
         |                       ^~~~~~~~~~~~~~~
         |                       MIGRATE_MOVABLE
   make[2]: *** [scripts/Makefile.build:122: arch/nios2/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1283: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:226: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +1630 include/linux/mm.h

  1623	
  1624	/* MIGRATE_CMA and ZONE_MOVABLE do not allow pin pages */
  1625	#ifdef CONFIG_MIGRATION
  1626	static inline bool is_pinnable_page(struct page *page)
  1627	{
  1628		int mt = get_pageblock_migratetype(page);
  1629	
> 1630		return !(is_zone_movable_page(page) || mt == MIGRATE_CMA ||
> 1631			mt == MIGRATE_ISOLATE || is_zero_pfn(page_to_pfn(page)));
  1632	}
  1633	#else
  1634	static inline bool is_pinnable_page(struct page *page)
  1635	{
  1636		return true;
  1637	}
  1638	#endif
  1639	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
