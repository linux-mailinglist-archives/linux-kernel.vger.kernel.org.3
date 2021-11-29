Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBA79462346
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 22:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbhK2V3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 16:29:54 -0500
Received: from mga18.intel.com ([134.134.136.126]:45645 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229490AbhK2V1w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 16:27:52 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10183"; a="222965064"
X-IronPort-AV: E=Sophos;i="5.87,273,1631602800"; 
   d="scan'208";a="222965064"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 13:24:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,273,1631602800"; 
   d="scan'208";a="594837886"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Nov 2021 13:24:28 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mro8J-000CLz-Rm; Mon, 29 Nov 2021 21:24:19 +0000
Date:   Tue, 30 Nov 2021 05:23:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [norov:bitmap_tmp 12/12] include/linux/bitmap.h:417:41: error:
 expected identifier or '(' before '!' token
Message-ID: <202111300512.lNfKWylS-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/norov/linux bitmap_tmp
head:   985b0047eb9f4a5916eeb4f85e9e173d220d8fc7
commit: 985b0047eb9f4a5916eeb4f85e9e173d220d8fc7 [12/12] aaa
config: arc-randconfig-r043-20211129 (https://download.01.org/0day-ci/archive/20211130/202111300512.lNfKWylS-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/norov/linux/commit/985b0047eb9f4a5916eeb4f85e9e173d220d8fc7
        git remote add norov https://github.com/norov/linux
        git fetch --no-tags norov bitmap_tmp
        git checkout 985b0047eb9f4a5916eeb4f85e9e173d220d8fc7
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/cpumask.h:12,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/rcupdate.h:29,
                    from include/linux/rculist.h:11,
                    from include/linux/pid.h:5,
                    from include/linux/sched.h:14,
                    from arch/arc/kernel/asm-offsets.c:6:
>> include/linux/bitmap.h:417:41: error: expected identifier or '(' before '!' token
     417 | #define bitmap_weight_le(src, nbits, n) !bitmap_weight_gt((src), (nbits), (n))
         |                                         ^
   include/linux/bitmap.h:419:29: note: in expansion of macro 'bitmap_weight_le'
     419 | static __always_inline bool bitmap_weight_le(const unsigned long *src,
         |                             ^~~~~~~~~~~~~~~~
   make[2]: *** [scripts/Makefile.build:122: arch/arc/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1284: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:226: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +417 include/linux/bitmap.h

   414	
   415	#define bitmap_weight_gt(src, nbits, n)	 bitmap_weight_ge((src), (nbits), (n) + 1)
   416	#define bitmap_weight_lt(src, nbits, n)	!bitmap_weight_ge((src), (nbits), (n))
 > 417	#define bitmap_weight_le(src, nbits, n)	!bitmap_weight_gt((src), (nbits), (n))
   418	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
