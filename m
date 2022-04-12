Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E36144FD900
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 12:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234608AbiDLJmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 05:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389431AbiDLJXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 05:23:45 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8A2546A4;
        Tue, 12 Apr 2022 01:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649752685; x=1681288685;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QLFnvFZjCBbBm1WrCuQHfneVU5wUafBRZqi1LfvDPoE=;
  b=mOSYN6HK4TTZts/UuOsNetTBcqvyjMVC1a0D+ojBhnMOq+qp/DfZzFbe
   SZZd0R1XMKE2AVTGwe71xb776qGNwb/JKHiu8u5R3Gg6NEINTVeNp2nzt
   zog34OBxVUkcZ1DyXbXlT+mGV/V5CVcd/2YY8PDelPgu0Lw9Jo+AAHdnC
   gUKeiMmpQlNva+a/hI3RvUr84VXxCQUiecuMIMWU5fzHkZPZJev6RAIvr
   tQDWapMylYMEFsk7JrduTu7s4GKFMcV3PPEwWbI5pAJNftVT89bqqzKc5
   Pto7hwxOyz42XkMACv/eRIM8pxvmoe+JdGVY2NhOP5OJoScakqnP3KW07
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="242257568"
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="242257568"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 01:38:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="611341789"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 12 Apr 2022 01:38:03 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1neC2E-0002fc-Oa;
        Tue, 12 Apr 2022 08:38:02 +0000
Date:   Tue, 12 Apr 2022 16:37:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Patrick Wang <patrick.wang.shcn@gmail.com>, robh+dt@kernel.org,
        frowand.list@gmail.com
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        patrick.wang.shcn@gmail.com
Subject: Re: [PATCH] of: fdt: do not reserve memory below MIN_MEMBLOCK_ADDR
Message-ID: <202204121637.4ZHpTqwT-lkp@intel.com>
References: <20220412045228.35306-1-patrick.wang.shcn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220412045228.35306-1-patrick.wang.shcn@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Patrick,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on robh/for-next]
[also build test WARNING on v5.18-rc2 next-20220412]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Patrick-Wang/of-fdt-do-not-reserve-memory-below-MIN_MEMBLOCK_ADDR/20220412-125309
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: arm-buildonly-randconfig-r006-20220411 (https://download.01.org/0day-ci/archive/20220412/202204121637.4ZHpTqwT-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project fe2478d44e4f7f191c43fef629ac7a23d0251e72)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/intel-lab-lkp/linux/commit/d362274832c02bb7812c13eff968322a76f10ed3
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Patrick-Wang/of-fdt-do-not-reserve-memory-below-MIN_MEMBLOCK_ADDR/20220412-125309
        git checkout d362274832c02bb7812c13eff968322a76f10ed3
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/of/fdt.c:494:4: warning: format specifies type 'unsigned long long' but the argument has type 'phys_addr_t' (aka 'unsigned int') [-Wformat]
                           base, phys_offset);
                           ^~~~
   include/linux/printk.h:499:37: note: expanded from macro 'pr_warn'
           printk(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
                                      ~~~     ^~~~~~~~~~~
   include/linux/printk.h:446:60: note: expanded from macro 'printk'
   #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
                                                       ~~~    ^~~~~~~~~~~
   include/linux/printk.h:418:19: note: expanded from macro 'printk_index_wrap'
                   _p_func(_fmt, ##__VA_ARGS__);                           \
                           ~~~~    ^~~~~~~~~~~
   1 warning generated.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for DRM_GEM_SHMEM_HELPER
   Depends on HAS_IOMEM && DRM && MMU
   Selected by
   - DRM_SSD130X && HAS_IOMEM && DRM


vim +494 drivers/of/fdt.c

   486	
   487	static int __init early_init_dt_reserve_memory_arch(phys_addr_t base,
   488						phys_addr_t size, bool nomap)
   489	{
   490		const u64 phys_offset = MIN_MEMBLOCK_ADDR;
   491	
   492		if (base < phys_offset) {
   493			pr_warn("Ignoring reserved memory range 0x%llx - 0x%llx\n",
 > 494				base, phys_offset);
   495			size = (phys_offset - base) < size ?
   496				size - (phys_offset - base) : 0;
   497			base = phys_offset;
   498	
   499			if (!size)
   500				return -EFAULT;
   501		}
   502	
   503		if (nomap) {
   504			/*
   505			 * If the memory is already reserved (by another region), we
   506			 * should not allow it to be marked nomap, but don't worry
   507			 * if the region isn't memory as it won't be mapped.
   508			 */
   509			if (memblock_overlaps_region(&memblock.memory, base, size) &&
   510			    memblock_is_region_reserved(base, size))
   511				return -EBUSY;
   512	
   513			return memblock_mark_nomap(base, size);
   514		}
   515		return memblock_reserve(base, size);
   516	}
   517	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
