Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC24E597B5C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 04:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242685AbiHRCK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 22:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239681AbiHRCK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 22:10:56 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD398D3C0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 19:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660788655; x=1692324655;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xKYu4GjaWrbMicsFF/yHeiHF/pFqFu1LXL7lGjPvXgk=;
  b=iKdiyAru6Qh0jtm21gic6Fyp8uvrU/bbGBWOf5DoPnfqXk7YVQ9fq5v9
   n8PngXgZxjeD7MntjyStbU1V5HbHOZSPlbMPhlbUDQYG366QNjr3AAgOv
   ZEi3CZAU0zoxDqusFBUKVkKbX7Y4+tlvJqpcO5EbijNG/8S1ZN4lRNHcd
   hom2rfZmmrtRpvSS5Xp10WXLwht54aVI5mpHGeqPzkAAxj8xpKO17NpEC
   VJacL2+KFCvTjxt8eyvQrplCcJlwApLvQDMSxnzkQoyOXndp8eWdw2CRh
   KtSu6y9+bYqkWqeMzCpNDQTsuQL5/XU6zWxlCDu2CB11Zv+7Otlbdo74x
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10442"; a="318662589"
X-IronPort-AV: E=Sophos;i="5.93,245,1654585200"; 
   d="scan'208";a="318662589"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 19:10:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,245,1654585200"; 
   d="scan'208";a="584009803"
Received: from lkp-server02.sh.intel.com (HELO 81d7e1ade3ba) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 17 Aug 2022 19:10:53 -0700
Received: from kbuild by 81d7e1ade3ba with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oOUzl-0001bu-0a;
        Thu, 18 Aug 2022 02:10:53 +0000
Date:   Thu, 18 Aug 2022 10:10:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     kbuild-all@lists.01.org, Mike Rapoport <rppt@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [rppt:crash-kernel/arm64-remap/v0.1 4/5]
 arch/arm64/mm/init.c:133:17: error: 'crashkres_protection_possible'
 undeclared
Message-ID: <202208181058.X0xvGjhJ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git crash-kernel/arm64-remap/v0.1
head:   083629d699170f5a86078d0a7afbe647c3a571cb
commit: 3aaa4a222ab056611236c4c42499d24c8317bc96 [4/5] arm64/mm: remap crash kernel with base pages even if rodata_full disabled
config: arm64-randconfig-r021-20220818 (https://download.01.org/0day-ci/archive/20220818/202208181058.X0xvGjhJ-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git/commit/?id=3aaa4a222ab056611236c4c42499d24c8317bc96
        git remote add rppt https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git
        git fetch --no-tags rppt crash-kernel/arm64-remap/v0.1
        git checkout 3aaa4a222ab056611236c4c42499d24c8317bc96
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/arm64/mm/init.c: In function 'reserve_remap_crashkernel':
>> arch/arm64/mm/init.c:133:17: error: 'crashkres_protection_possible' undeclared (first use in this function)
     133 |                 crashkres_protection_possible = true;
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/mm/init.c:133:17: note: each undeclared identifier is reported only once for each function it appears in


vim +/crashkres_protection_possible +133 arch/arm64/mm/init.c

   119	
   120	static unsigned long long __init
   121	reserve_remap_crashkernel(unsigned long long crash_base,
   122				  unsigned long long crash_size,
   123				  unsigned long long crash_max)
   124	{
   125		unsigned long long size;
   126	
   127		/*
   128		 * If linear map uses base pages or there is no ZONE_DMA/ZONE_DMA32
   129		 * the crashk_res will be mapped with PTEs in mmu::map_mem()
   130		 */
   131		if (can_set_direct_map() || IS_ENABLED(CONFIG_KFENCE) ||
   132		    !have_zone_dma()) {
 > 133			crashkres_protection_possible = true;
   134			return 0;
   135		}
   136	
   137		if (crash_base)
   138			return 0;
   139	
   140		size = ALIGN(crash_size, PUD_SIZE);
   141	
   142		crash_base = memblock_phys_alloc_range(size, PUD_SIZE, 0, crash_max);
   143		if (!crash_base)
   144			return 0;
   145	
   146		if (remap_crashkernel(crash_base, crash_size, size)) {
   147			memblock_phys_free(crash_base, size);
   148			return 0;
   149		}
   150	
   151		crashkres_protection_possible = true;
   152		memblock_phys_free(crash_base + crash_size, size - crash_size);
   153	
   154		return crash_base;
   155	}
   156	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
