Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 204B75178DC
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 23:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387589AbiEBVOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 17:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387577AbiEBVOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 17:14:49 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A126DFBA
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 14:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651525879; x=1683061879;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=e51YJRAyK2oFyodJN78dW1B+cSnosSuF7pHpOHVfPBM=;
  b=mNN7X9lhpbLIcryVYnzuKS3u15g6XrkIm7kTpZ2xNLDyEkoAUfScgLlP
   0J4cuCE2Csy6tFGnqRl/+voKA6fqF2dfMRL3PnC4k8N5H6F06elKf7bB+
   2ZZRsZt32sj42aMmuvfKYh6Er/naUiJN034GJGdyxi9qJ2JIyp+62+5yp
   xlYR5rHfTaa/8cujWibd7IdtNFDBZZnasoTr9Rd6pR3pz/43H8hotorNl
   UbP3F68wUO/irL64yLIBf+B41q26D+3qKk/fMai4RaUIejdzxReoAjaqq
   WoSHMuh/5RIsMCFKE+hkubrow4MAajcIWoyAhDeSe55GWbFwEQYDZD3tz
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10335"; a="266917355"
X-IronPort-AV: E=Sophos;i="5.91,193,1647327600"; 
   d="scan'208";a="266917355"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 14:11:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,193,1647327600"; 
   d="scan'208";a="583902533"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 02 May 2022 14:11:15 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nldK4-0009sV-FJ;
        Mon, 02 May 2022 21:11:12 +0000
Date:   Tue, 3 May 2022 05:10:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        John Dias <joaodias@google.com>,
        Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH] mm: fix is_pinnable_page against on cma page
Message-ID: <202205030525.VFo3Ds9w-lkp@intel.com>
References: <20220502173558.2510641-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220502173558.2510641-1-minchan@kernel.org>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
config: x86_64-randconfig-a012-20220502 (https://download.01.org/0day-ci/archive/20220503/202205030525.VFo3Ds9w-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 09325d36061e42b495d1f4c7e933e260eac260ed)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/1b8636710c31d44310f1d344e337c207562b851d
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Minchan-Kim/mm-fix-is_pinnable_page-against-on-cma-page/20220503-013733
        git checkout 1b8636710c31d44310f1d344e337c207562b851d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/x86/kernel/asm-offsets.c:13:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:20:
>> include/linux/mm.h:1630:47: error: use of undeclared identifier 'MIGRATE_CMA'; did you mean 'MIGRATE_SYNC'?
           return !(is_zone_movable_page(page) || mt == MIGRATE_CMA ||
                                                        ^~~~~~~~~~~
                                                        MIGRATE_SYNC
   include/linux/migrate_mode.h:18:2: note: 'MIGRATE_SYNC' declared here
           MIGRATE_SYNC,
           ^
   In file included from arch/x86/kernel/asm-offsets.c:13:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:20:
>> include/linux/mm.h:1631:9: error: use of undeclared identifier 'MIGRATE_ISOLATE'; did you mean 'MIGRATE_MOVABLE'?
                   mt == MIGRATE_ISOLATE || is_zero_pfn(page_to_pfn(page)));
                         ^~~~~~~~~~~~~~~
                         MIGRATE_MOVABLE
   include/linux/mmzone.h:44:2: note: 'MIGRATE_MOVABLE' declared here
           MIGRATE_MOVABLE,
           ^
   2 errors generated.
   make[2]: *** [scripts/Makefile.build:122: arch/x86/kernel/asm-offsets.s] Error 1
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
