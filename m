Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EAB650462D
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 04:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233358AbiDQCxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 22:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232452AbiDQCxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 22:53:00 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 908FD1EC61
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 19:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650163826; x=1681699826;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=cYgEV3JP0tS1O9t+CQVI5564PNedtCa8/r4wgBo4RVo=;
  b=iUjdq59PQJc/NrCkvO51ZkIgXlkSM5FgQ7LMknAUxdNuVaTj2BuYN2Pu
   8bE23eY0hwLuYiPSsh0eYFb/OnNG0wRM3a3KITW1dXROjqsv2sUufa8+N
   Eez2h16j8WPwFj7hyjWXOquosF05pyQ3BnT2qSoP0OCdkSVgZQx2Ppu8F
   zb4jnDnsFKlaqN6yeX6ySViLX39TlCKAL1+4ermcGlnvlxrkGtZ2yPtVm
   W8mX1kOqEOp/GdlizAcrCley3Ft9SbL+yFlhaKgr3lcfCbF8QbFE44xun
   NH4DEPxVZsu7ie86MH4Z8L5gu4ttMZtKhGXVn5IWSzLQBdAQpDEMrd51U
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10318"; a="349805713"
X-IronPort-AV: E=Sophos;i="5.90,266,1643702400"; 
   d="scan'208";a="349805713"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2022 19:50:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,266,1643702400"; 
   d="scan'208";a="726235780"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 16 Apr 2022 19:50:25 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nfuzY-0003en-DP;
        Sun, 17 Apr 2022 02:50:24 +0000
Date:   Sun, 17 Apr 2022 10:49:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: arch/xtensa/boot/boot-elf/bootstrap.S:58: Error: invalid register
 'atomctl' for 'wsr' instruction
Message-ID: <202204171040.e6q398Ly-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
head:   a2c29ccd9477861b16ddc02c411a6c9665250558
commit: da0a4e5c8fbcce3d1afebf9f2a967083bb19634d xtensa: only build windowed register support code when needed
date:   6 months ago
config: xtensa-randconfig-r031-20220417 (https://download.01.org/0day-ci/archive/20220417/202204171040.e6q398Ly-lkp@intel.com/config)
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

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
