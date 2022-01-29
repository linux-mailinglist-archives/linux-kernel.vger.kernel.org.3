Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7825B4A2C41
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 08:03:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347735AbiA2HDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 02:03:49 -0500
Received: from mga01.intel.com ([192.55.52.88]:2285 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233593AbiA2HDq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 02:03:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643439826; x=1674975826;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Gy+amLjM7g3mHU1szM7Bq3uoZ8SJyvAh77TBOs8M1rk=;
  b=Xjh62I3wGbQsBf/2HsqZJRxGthfcaz28BVLPGeps+SGV6AxClY8Gq/AJ
   J5IspoFFw5T7wU1vFnWN3Nj153FgkBkcGtw5B+sYtMF37x18kMgush17Y
   IRvmQJJxqsy2Cu+UM353HSfPtYw5POtNTl27CSJDeKeRNUEN09Xec/aXN
   B7opeamza0IihfKFbZ5m8JnwDzFudOdkyCpJo/AOaj/VuYFRWc9KxgUYS
   5FFpgUZEvJi0H6xWMGFyzU1C0g8bFru5EudCnhPA5Lhw6KLGnMtYE9hIi
   nHb2pP/HYlaWwYOWiSc50dqn+Tk6kFg4zhSVfj/4BPYFeZ5BFx8Vi14gB
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10241"; a="271713934"
X-IronPort-AV: E=Sophos;i="5.88,326,1635231600"; 
   d="scan'208";a="271713934"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 23:03:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,326,1635231600"; 
   d="scan'208";a="629361273"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 28 Jan 2022 23:03:44 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nDhlv-000OuM-Bg; Sat, 29 Jan 2022 07:03:43 +0000
Date:   Sat, 29 Jan 2022 15:02:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Justin M. Forbes" <jforbes@fedoraproject.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        "Jason A. Donenfeld" <zx2c4@kernel.org>
Subject: arch/arm/lib/xor-neon.c:30:2: warning: This code requires at least
 version 4.6 of GCC
Message-ID: <202201291408.Pkylyt75-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Justin,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   169387e2aa291a4e3cb856053730fe99d6cec06f
commit: e56e18985596617ae426ed5997fb2e737cffb58b lib/crypto: add prompts back to crypto libraries
date:   11 days ago
config: arm-randconfig-r004-20220128 (https://download.01.org/0day-ci/archive/20220129/202201291408.Pkylyt75-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 33b45ee44b1f32ffdbc995e6fec806271b4b3ba4)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e56e18985596617ae426ed5997fb2e737cffb58b
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout e56e18985596617ae426ed5997fb2e737cffb58b
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/arm/lib/xor-neon.c:30:2: warning: This code requires at least version 4.6 of GCC [-W#warnings]
   #warning This code requires at least version 4.6 of GCC
    ^
   1 warning generated.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for TEGRA20_APB_DMA
   Depends on DMADEVICES && (ARCH_TEGRA || COMPILE_TEST
   Selected by
   - SOC_TEGRA_FUSE && ARCH_TEGRA && ARCH_TEGRA_2x_SOC


vim +30 arch/arm/lib/xor-neon.c

01956597cbc46d Ard Biesheuvel 2013-05-17  16  
01956597cbc46d Ard Biesheuvel 2013-05-17  17  /*
01956597cbc46d Ard Biesheuvel 2013-05-17  18   * Pull in the reference implementations while instructing GCC (through
01956597cbc46d Ard Biesheuvel 2013-05-17  19   * -ftree-vectorize) to attempt to exploit implicit parallelism and emit
01956597cbc46d Ard Biesheuvel 2013-05-17  20   * NEON instructions.
01956597cbc46d Ard Biesheuvel 2013-05-17  21   */
01956597cbc46d Ard Biesheuvel 2013-05-17  22  #if __GNUC__ > 4 || (__GNUC__ == 4 && __GNUC_MINOR__ >= 6)
01956597cbc46d Ard Biesheuvel 2013-05-17  23  #pragma GCC optimize "tree-vectorize"
01956597cbc46d Ard Biesheuvel 2013-05-17  24  #else
01956597cbc46d Ard Biesheuvel 2013-05-17  25  /*
01956597cbc46d Ard Biesheuvel 2013-05-17  26   * While older versions of GCC do not generate incorrect code, they fail to
01956597cbc46d Ard Biesheuvel 2013-05-17  27   * recognize the parallel nature of these functions, and emit plain ARM code,
01956597cbc46d Ard Biesheuvel 2013-05-17  28   * which is known to be slower than the optimized ARM code in asm-arm/xor.h.
01956597cbc46d Ard Biesheuvel 2013-05-17  29   */
01956597cbc46d Ard Biesheuvel 2013-05-17 @30  #warning This code requires at least version 4.6 of GCC
01956597cbc46d Ard Biesheuvel 2013-05-17  31  #endif
01956597cbc46d Ard Biesheuvel 2013-05-17  32  

:::::: The code at line 30 was first introduced by commit
:::::: 01956597cbc46df072f20f90a40eebe356200c38 ARM: crypto: add NEON accelerated XOR implementation

:::::: TO: Ard Biesheuvel <ard.biesheuvel@linaro.org>
:::::: CC: Ard Biesheuvel <ard.biesheuvel@linaro.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
