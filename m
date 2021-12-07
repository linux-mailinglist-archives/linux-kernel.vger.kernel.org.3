Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4ED46B8BC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 11:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235010AbhLGKZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 05:25:25 -0500
Received: from mga18.intel.com ([134.134.136.126]:25367 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232748AbhLGKZY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 05:25:24 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="224416186"
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="224416186"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 02:21:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="542753730"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 07 Dec 2021 02:21:52 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1muXbc-000MS9-4o; Tue, 07 Dec 2021 10:21:52 +0000
Date:   Tue, 7 Dec 2021 18:20:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>
Subject: arch/arm/mach-ep93xx/clock.c:210:35: sparse: sparse: Using plain
 integer as NULL pointer
Message-ID: <202112071840.2bl34nL3-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   cd8c917a56f20f48748dd43d9ae3caff51d5b987
commit: 9645ccc7bd7a16cd73c3be9dee70cd702b03be37 ep93xx: clock: convert in-place to COMMON_CLK
date:   7 weeks ago
config: arm-randconfig-s031-20211207 (https://download.01.org/0day-ci/archive/20211207/202112071840.2bl34nL3-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9645ccc7bd7a16cd73c3be9dee70cd702b03be37
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 9645ccc7bd7a16cd73c3be9dee70cd702b03be37
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> arch/arm/mach-ep93xx/clock.c:210:35: sparse: sparse: Using plain integer as NULL pointer
   arch/arm/mach-ep93xx/clock.c:99:9: sparse: sparse: context imbalance in 'ep93xx_clk_enable' - different lock contexts for basic block
   arch/arm/mach-ep93xx/clock.c:116:9: sparse: sparse: context imbalance in 'ep93xx_clk_disable' - different lock contexts for basic block
   arch/arm/mach-ep93xx/clock.c:197:9: sparse: sparse: context imbalance in 'ep93xx_mux_set_parent_lock' - different lock contexts for basic block

vim +210 arch/arm/mach-ep93xx/clock.c

   205	
   206	static int ep93xx_mux_determine_rate(struct clk_hw *hw,
   207					struct clk_rate_request *req)
   208	{
   209		unsigned long rate = req->rate;
 > 210		struct clk *best_parent = 0;
   211		unsigned long __parent_rate;
   212		unsigned long best_rate = 0, actual_rate, mclk_rate;
   213		unsigned long best_parent_rate;
   214		int __div = 0, __pdiv = 0;
   215		int i;
   216	
   217		/*
   218		 * Try the two pll's and the external clock
   219		 * Because the valid predividers are 2, 2.5 and 3, we multiply
   220		 * all the clocks by 2 to avoid floating point math.
   221		 *
   222		 * This is based on the algorithm in the ep93xx raster guide:
   223		 * http://be-a-maverick.com/en/pubs/appNote/AN269REV1.pdf
   224		 *
   225		 */
   226		for (i = 0; i < ARRAY_SIZE(mux_parents); i++) {
   227			struct clk *parent = clk_get_sys(mux_parents[i], NULL);
   228	
   229			__parent_rate = clk_get_rate(parent);
   230			mclk_rate = __parent_rate * 2;
   231	
   232			/* Try each predivider value */
   233			for (__pdiv = 4; __pdiv <= 6; __pdiv++) {
   234				__div = mclk_rate / (rate * __pdiv);
   235				if (__div < 2 || __div > 127)
   236					continue;
   237	
   238				actual_rate = mclk_rate / (__pdiv * __div);
   239				if (is_best(rate, actual_rate, best_rate)) {
   240					best_rate = actual_rate;
   241					best_parent_rate = __parent_rate;
   242					best_parent = parent;
   243				}
   244			}
   245		}
   246	
   247		if (!best_parent)
   248			return -EINVAL;
   249	
   250		req->best_parent_rate = best_parent_rate;
   251		req->best_parent_hw = __clk_get_hw(best_parent);
   252		req->rate = best_rate;
   253	
   254		return 0;
   255	}
   256	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
