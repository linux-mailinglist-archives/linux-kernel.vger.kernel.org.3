Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4C24C934A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 19:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235523AbiCASbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 13:31:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232775AbiCASbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 13:31:43 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C01E91D325
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 10:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646159460; x=1677695460;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=yKxAsKI3Bw2uJ99wfRb4YxkFI9rNw+16sDrjlUNVN0I=;
  b=j3vBqguuNHHAfxgZnkPrZvrvde8A1xMd+3laDK1ZlaNjLx5llgzXifEh
   +swN9e2djxqibP9zNLFP8cJ55uL2vAfqRV5LHjevFKr3RkrtvV9jGNJMg
   d/TCuB1QEp1YkQ58y4EBEdtNu9gI3dck/w3AZHveGGuBHwJh0f8GpT++l
   PMHw46cdJ4DxelxPsaUQDh0UNbMrKmsoUOGMGaIPBhaHKamhutQFkOjX6
   v4sIfrjU3iHQrtNSFmVWl22EmFYvQCeObzorZ5eLRBMrc3cLivE6B/TTs
   XbxZWmDm9K6M6qwHC2+qRAn2s5jKBBLnWjVSTV9O8DUAO4HwsaOtD+PXQ
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10273"; a="316423716"
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="316423716"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 10:31:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="641375064"
Received: from lkp-server01.sh.intel.com (HELO 2146afe809fb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 01 Mar 2022 10:30:59 -0800
Received: from kbuild by 2146afe809fb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nP7H0-0000ru-A5; Tue, 01 Mar 2022 18:30:58 +0000
Date:   Wed, 2 Mar 2022 02:30:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: arch/xtensa/boot/boot-elf/bootstrap.S:58: Error: invalid register
 'atomctl' for 'wsr' instruction
Message-ID: <202203020253.8RoGTnyX-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Max,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   719fce7539cd3e186598e2aed36325fe892150cf
commit: da0a4e5c8fbcce3d1afebf9f2a967083bb19634d xtensa: only build windowed register support code when needed
date:   4 months ago
config: xtensa-randconfig-r003-20220301 (https://download.01.org/0day-ci/archive/20220302/202203020253.8RoGTnyX-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=da0a4e5c8fbcce3d1afebf9f2a967083bb19634d
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout da0a4e5c8fbcce3d1afebf9f2a967083bb19634d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=xtensa SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/xtensa/boot/boot-elf/bootstrap.S: Assembler messages:
>> arch/xtensa/boot/boot-elf/bootstrap.S:58: Error: invalid register 'atomctl' for 'wsr' instruction
   arch/xtensa/boot/boot-elf/bootstrap.S:68: Warning: value 0x1a0003000 truncated to 0xa0003000


vim +58 arch/xtensa/boot/boot-elf/bootstrap.S

e85e335f8ff615 Max Filippov 2012-12-03  42  
e85e335f8ff615 Max Filippov 2012-12-03  43  	.align  4
e85e335f8ff615 Max Filippov 2012-12-03  44  _SetupMMU:
09af39f649dac6 Max Filippov 2021-07-26  45  #if XCHAL_HAVE_WINDOWED
e85e335f8ff615 Max Filippov 2012-12-03  46  	movi	a0, 0
e85e335f8ff615 Max Filippov 2012-12-03  47  	wsr	a0, windowbase
e85e335f8ff615 Max Filippov 2012-12-03  48  	rsync
e85e335f8ff615 Max Filippov 2012-12-03  49  	movi	a0, 1
e85e335f8ff615 Max Filippov 2012-12-03  50  	wsr	a0, windowstart
e85e335f8ff615 Max Filippov 2012-12-03  51  	rsync
09af39f649dac6 Max Filippov 2021-07-26  52  #endif
e85e335f8ff615 Max Filippov 2012-12-03  53  	movi	a0, 0x1F
e85e335f8ff615 Max Filippov 2012-12-03  54  	wsr	a0, ps
e85e335f8ff615 Max Filippov 2012-12-03  55  	rsync
e85e335f8ff615 Max Filippov 2012-12-03  56  
e85e335f8ff615 Max Filippov 2012-12-03  57  #ifndef CONFIG_INITIALIZE_XTENSA_MMU_INSIDE_VMLINUX
e85e335f8ff615 Max Filippov 2012-12-03 @58  	initialize_mmu

:::::: The code at line 58 was first introduced by commit
:::::: e85e335f8ff615f74e29e09cc2599f095600114b xtensa: add MMU v3 support

:::::: TO: Max Filippov <jcmvbkbc@gmail.com>
:::::: CC: Chris Zankel <chris@zankel.net>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
