Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 992F05917F8
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 03:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234710AbiHMBJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 21:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237399AbiHMBJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 21:09:04 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CEC274340
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 18:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660352944; x=1691888944;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=fonEWxUD1NVi0zPRaFclDUuZQsesvxFDPxYtlbwH/co=;
  b=g1GxbA4ikd/jjqRf3xLXficCeWAsBe2Sk4N25u0kQVDCxNJYb/SOivCx
   4m9UHTwGdUr4PwTLuet82AYCpfQy6CE6HbsCFn2S6cqNuO4oOeYhVIyIr
   BkxY+KRytrowfqTUS5usDJDp/AzrQsPSYoQXgUtVWFTKGTqulG5o3qc2C
   rwxS76UeLyN7UnsQYpkJgsYL6Isbr+lw5JAKLJkwBMaVhbSRdcYpOKnSY
   VSOOq8p+IqPpenY4krpJdBso//UrItDYNoWsqeZElzNq5xxdDUn9oObTY
   B56CHuSIIiT3taB5X1Ath05g7jYMashkO64sEuOD6F8Q5+cBo4eAWBjgM
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="274770842"
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="274770842"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2022 18:09:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="582280709"
Received: from lkp-server02.sh.intel.com (HELO 8745164cafc7) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 12 Aug 2022 18:09:02 -0700
Received: from kbuild by 8745164cafc7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oMfe9-00019J-29;
        Sat, 13 Aug 2022 01:09:01 +0000
Date:   Sat, 13 Aug 2022 09:08:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: arch/arm/mach-omap2/board-generic.c:44:6: warning: no previous
 prototype for function 'tick_broadcast'
Message-ID: <202208130946.TObnunCr-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4a9350597aff50bbd0f4b80ccf49d2e02d1111f5
commit: 09f6b27d5ddd9ad0ec096d1b0f8decdacc70f0f8 ARM: dove: multiplatform support
date:   4 months ago
config: arm-randconfig-r021-20220812 (https://download.01.org/0day-ci/archive/20220813/202208130946.TObnunCr-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 5f1c7e2cc5a3c07cbc2412e851a7283c1841f520)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=09f6b27d5ddd9ad0ec096d1b0f8decdacc70f0f8
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 09f6b27d5ddd9ad0ec096d1b0f8decdacc70f0f8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/arm/mach-omap2/board-generic.c:44:6: warning: no previous prototype for function 'tick_broadcast' [-Wmissing-prototypes]
   void tick_broadcast(const struct cpumask *mask)
        ^
   arch/arm/mach-omap2/board-generic.c:44:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void tick_broadcast(const struct cpumask *mask)
   ^
   static 
   1 warning generated.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for TEGRA20_APB_DMA
   Depends on [n]: DMADEVICES [=n] && (ARCH_TEGRA [=y] || COMPILE_TEST [=y])
   Selected by [y]:
   - SOC_TEGRA_FUSE [=y] && ARCH_TEGRA [=y] && ARCH_TEGRA_2x_SOC [=y]


vim +/tick_broadcast +44 arch/arm/mach-omap2/board-generic.c

e69b4e1a7577c1 Tony Lindgren 2020-05-07  41  
d86ad463d6706d Tony Lindgren 2020-05-28  42  /* Used by am437x for ARM timer in non-SMP configurations */
d86ad463d6706d Tony Lindgren 2020-05-28  43  #if !defined(CONFIG_SMP) && defined(CONFIG_GENERIC_CLOCKEVENTS_BROADCAST)
d86ad463d6706d Tony Lindgren 2020-05-28 @44  void tick_broadcast(const struct cpumask *mask)
d86ad463d6706d Tony Lindgren 2020-05-28  45  {
d86ad463d6706d Tony Lindgren 2020-05-28  46  }
d86ad463d6706d Tony Lindgren 2020-05-28  47  #endif
d86ad463d6706d Tony Lindgren 2020-05-28  48  

:::::: The code at line 44 was first introduced by commit
:::::: d86ad463d6706d35167418660ae3293207ee9d1c ARM: OMAP2+: Fix regression for using local timer on non-SMP SoCs

:::::: TO: Tony Lindgren <tony@atomide.com>
:::::: CC: Arnd Bergmann <arnd@arndb.de>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
