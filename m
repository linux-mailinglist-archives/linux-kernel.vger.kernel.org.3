Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30C324E1EBB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 02:31:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343988AbiCUBcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 21:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343993AbiCUBct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 21:32:49 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 529E4D081F
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 18:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647826285; x=1679362285;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=sDaBFDHczn8EV0ExSJZeUSB/7+NqtoywTR2VeCEITGQ=;
  b=ZPZQ9ZJ5Qxy01IOb7Wej2fHJRYyAWGrcp+Ie9l7XTNxR6mWu5vbyfa/h
   DN5+S5YWfDskYGpMezvgCkc6nvxFpWuJb7A9VrV+VAY0SpuKaZMw0lIUn
   2fbTHDNI3lMPxn93JH9z+u7rw8Bl4yYdm00HDfdK9fbOpMpRAbaloQO2z
   k27J6Gqcn81HKM4gpLTVqWPZxBAC/pIVdsb/GIj6Bvl4C4KKnMs26KGjB
   BXQr887mCGHXMyuRwZaxtTCbPKYAsoHe8rYS96dD7PrFS8LCPQz/Wk4Iy
   2V270w1jP/GK0G5msALmGG17flvpkdr5UT9wWkSozIPTjb0tMfoTz3Z3n
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10292"; a="255011516"
X-IronPort-AV: E=Sophos;i="5.90,197,1643702400"; 
   d="scan'208";a="255011516"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2022 18:31:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,197,1643702400"; 
   d="scan'208";a="514767184"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 20 Mar 2022 18:31:22 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nW6tF-000HMO-T3; Mon, 21 Mar 2022 01:31:21 +0000
Date:   Mon, 21 Mar 2022 09:30:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Kees Cook <keescook@chromium.org>
Subject: arch/xtensa/boot/boot-elf/bootstrap.S:56: Error: invalid register
 'atomctl' for 'wsr' instruction
Message-ID: <202203210945.7IEjQF7k-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f443e374ae131c168a065ea1748feac6b2e76613
commit: 606b102876e3741851dfb09d53f3ee57f650a52c drm: fb_helper: fix CONFIG_FB dependency
date:   6 months ago
config: xtensa-randconfig-r011-20220321 (https://download.01.org/0day-ci/archive/20220321/202203210945.7IEjQF7k-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=606b102876e3741851dfb09d53f3ee57f650a52c
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 606b102876e3741851dfb09d53f3ee57f650a52c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=xtensa SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/xtensa/boot/boot-elf/bootstrap.S: Assembler messages:
>> arch/xtensa/boot/boot-elf/bootstrap.S:56: Error: invalid register 'atomctl' for 'wsr' instruction
   arch/xtensa/boot/boot-elf/bootstrap.S:66: Warning: value 0x1a0003000 truncated to 0xa0003000


vim +56 arch/xtensa/boot/boot-elf/bootstrap.S

e85e335f8ff615 Max Filippov 2012-12-03  42  
e85e335f8ff615 Max Filippov 2012-12-03  43  	.align  4
e85e335f8ff615 Max Filippov 2012-12-03  44  _SetupMMU:
e85e335f8ff615 Max Filippov 2012-12-03  45  	movi	a0, 0
e85e335f8ff615 Max Filippov 2012-12-03  46  	wsr	a0, windowbase
e85e335f8ff615 Max Filippov 2012-12-03  47  	rsync
e85e335f8ff615 Max Filippov 2012-12-03  48  	movi	a0, 1
e85e335f8ff615 Max Filippov 2012-12-03  49  	wsr	a0, windowstart
e85e335f8ff615 Max Filippov 2012-12-03  50  	rsync
e85e335f8ff615 Max Filippov 2012-12-03  51  	movi	a0, 0x1F
e85e335f8ff615 Max Filippov 2012-12-03  52  	wsr	a0, ps
e85e335f8ff615 Max Filippov 2012-12-03  53  	rsync
e85e335f8ff615 Max Filippov 2012-12-03  54  
e85e335f8ff615 Max Filippov 2012-12-03  55  #ifndef CONFIG_INITIALIZE_XTENSA_MMU_INSIDE_VMLINUX
e85e335f8ff615 Max Filippov 2012-12-03 @56  	initialize_mmu

:::::: The code at line 56 was first introduced by commit
:::::: e85e335f8ff615f74e29e09cc2599f095600114b xtensa: add MMU v3 support

:::::: TO: Max Filippov <jcmvbkbc@gmail.com>
:::::: CC: Chris Zankel <chris@zankel.net>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
