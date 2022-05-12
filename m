Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BACF55251BD
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 18:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356132AbiELQA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 12:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343533AbiELQAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 12:00:52 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1AEB1E3FB;
        Thu, 12 May 2022 09:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652371250; x=1683907250;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PixznmfLbZ75KymIuFBpx93Fn28FnO7RnanYYRV81Uc=;
  b=B5RjyNvVfL2uKpvQum35sX0buXjXNQz439w9rg4BAaM0+OqgDXoohMqv
   fU7yek5INPUzDHmjcIQK/Ix0gpZkXqTDF6Sj/5ALTyV9Vhjw7mH9e7aBR
   Pvc7RXRpUc/Nq/Ag6Rx+hHdLVA5uegZkvHpxfTRzvbiHOj3ijxzPnwWFU
   HwLjKgrmzdQsdvmxEAYjeRpGM/NY5TOOVfYE0zgqqmdZEDHnXHelS5Mw7
   2yKjWHFWgpx113DZjGHGhPQiZyYKaKiW4TGMa6sjS+81xK4ejb53VF7m7
   bX84gT+31wqSTsCvUmh1yXNnBz3FUT7EPmftA1PxAsQ/cmIMONnvWCYFy
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10345"; a="252092026"
X-IronPort-AV: E=Sophos;i="5.91,220,1647327600"; 
   d="scan'208";a="252092026"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 08:59:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,220,1647327600"; 
   d="scan'208";a="711970948"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 12 May 2022 08:59:34 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1npBDx-000Kdu-NO;
        Thu, 12 May 2022 15:59:33 +0000
Date:   Thu, 12 May 2022 23:59:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Jonas Paulsson <paulsson@linux.vnet.ibm.com>,
        Ulrich Weigand <ulrich.weigand@de.ibm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alexander Egorenkov <egorenar@linux.ibm.com>
Cc:     kbuild-all@lists.01.org, Sven Schnelle <svens@linux.ibm.com>,
        Andreas Krebbel <krebbel@linux.ibm.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 3/8] s390/entry: shorten OUTSIDE macro
Message-ID: <202205122320.fTZIQ9dT-lkp@intel.com>
References: <20220511120532.2228616-4-hca@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220511120532.2228616-4-hca@linux.ibm.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

I love your patch! Yet something to improve:

[auto build test ERROR on s390/features]
[also build test ERROR on tip/locking/core masahiroy-kbuild/for-next linus/master v5.18-rc6]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Heiko-Carstens/s390-allow-to-build-with-llvm-s-integrated-assembler/20220511-201054
base:   https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git features
config: s390-randconfig-p001-20220512 (https://download.01.org/0day-ci/archive/20220512/202205122320.fTZIQ9dT-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/ad8a0a6488ba252aaa84b813dee2c949ae59d88a
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Heiko-Carstens/s390-allow-to-build-with-llvm-s-integrated-assembler/20220511-201054
        git checkout ad8a0a6488ba252aaa84b813dee2c949ae59d88a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash arch/s390/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/s390/kernel/entry.S: Assembler messages:
>> arch/s390/kernel/entry.S:378: Error: Unrecognized opcode: `slgrk'
   arch/s390/kernel/entry.S:488: Error: Unrecognized opcode: `slgrk'
   arch/s390/kernel/entry.S:489: Error: Unrecognized opcode: `slgrk'
   arch/s390/kernel/entry.S:554: Error: Unrecognized opcode: `slgrk'
   arch/s390/kernel/entry.S:555: Error: Unrecognized opcode: `slgrk'


vim +378 arch/s390/kernel/entry.S

26a374ae7af8d7 arch/s390/kernel/entry.S   Martin Schwidefsky 2019-01-17  359  
^1da177e4c3f41 arch/s390/kernel/entry64.S Linus Torvalds     2005-04-16  360  /*
^1da177e4c3f41 arch/s390/kernel/entry64.S Linus Torvalds     2005-04-16  361   * Program check handler routine
^1da177e4c3f41 arch/s390/kernel/entry64.S Linus Torvalds     2005-04-16  362   */
^1da177e4c3f41 arch/s390/kernel/entry64.S Linus Torvalds     2005-04-16  363  
144d634a21caff arch/s390/kernel/entry64.S Jan Glauber        2011-07-24  364  ENTRY(pgm_check_handler)
56e62a73702836 arch/s390/kernel/entry.S   Sven Schnelle      2020-11-21  365  	stpt	__LC_SYS_ENTER_TIMER
d768bd892fc8f0 arch/s390/kernel/entry.S   Martin Schwidefsky 2018-01-16  366  	BPOFF
c5328901aa1db1 arch/s390/kernel/entry64.S Martin Schwidefsky 2011-12-27  367  	stmg	%r8,%r15,__LC_SAVE_AREA_SYNC
56e62a73702836 arch/s390/kernel/entry.S   Sven Schnelle      2020-11-21  368  	lg	%r12,__LC_CURRENT
56e62a73702836 arch/s390/kernel/entry.S   Sven Schnelle      2020-11-21  369  	lghi	%r10,0
c5328901aa1db1 arch/s390/kernel/entry64.S Martin Schwidefsky 2011-12-27  370  	lmg	%r8,%r9,__LC_PGM_OLD_PSW
87d5986345219a arch/s390/kernel/entry.S   Heiko Carstens     2020-11-16  371  	tmhh	%r8,0x0001		# coming from user space?
87d5986345219a arch/s390/kernel/entry.S   Heiko Carstens     2020-11-16  372  	jno	.Lpgm_skip_asce
87d5986345219a arch/s390/kernel/entry.S   Heiko Carstens     2020-11-16  373  	lctlg	%c1,%c1,__LC_KERNEL_ASCE
56e62a73702836 arch/s390/kernel/entry.S   Sven Schnelle      2020-11-21  374  	j	3f			# -> fault in user space
87d5986345219a arch/s390/kernel/entry.S   Heiko Carstens     2020-11-16  375  .Lpgm_skip_asce:
d0fc41071a6884 arch/s390/kernel/entry.S   Martin Schwidefsky 2015-06-22  376  #if IS_ENABLED(CONFIG_KVM)
0a5e2ec2647737 arch/s390/kernel/entry.S   Martin Schwidefsky 2017-10-05  377  	# cleanup critical section for program checks in sie64a
b5415c8f975506 arch/s390/kernel/entry.S   Alexander Gordeev  2021-06-07 @378  	OUTSIDE	%r9,.Lsie_gmap,.Lsie_done,1f
fbbdfca5c5535f arch/s390/kernel/entry.S   Alexander Gordeev  2021-06-18  379  	SIEEXIT
56e62a73702836 arch/s390/kernel/entry.S   Sven Schnelle      2020-11-21  380  	lghi	%r10,_PIF_GUEST_FAULT
d0fc41071a6884 arch/s390/kernel/entry.S   Martin Schwidefsky 2015-06-22  381  #endif
0b38b5e1d0e2f3 arch/s390/kernel/entry.S   Sven Schnelle      2020-01-22  382  1:	tmhh	%r8,0x4000		# PER bit set in old PSW ?
0b38b5e1d0e2f3 arch/s390/kernel/entry.S   Sven Schnelle      2020-01-22  383  	jnz	2f			# -> enabled, can't be a double fault
c5328901aa1db1 arch/s390/kernel/entry64.S Martin Schwidefsky 2011-12-27  384  	tm	__LC_PGM_ILC+3,0x80	# check for per exception
86ed42f401cb8f arch/s390/kernel/entry64.S Martin Schwidefsky 2014-12-03  385  	jnz	.Lpgm_svcper		# -> single stepped svc
0b38b5e1d0e2f3 arch/s390/kernel/entry.S   Sven Schnelle      2020-01-22  386  2:	CHECK_STACK __LC_SAVE_AREA_SYNC
dc7ee00d4771b3 arch/s390/kernel/entry64.S Martin Schwidefsky 2013-04-24  387  	aghi	%r15,-(STACK_FRAME_OVERHEAD + __PT_SIZE)
56e62a73702836 arch/s390/kernel/entry.S   Sven Schnelle      2020-11-21  388  	# CHECK_VMAP_STACK branches to stack_overflow or 4f
56e62a73702836 arch/s390/kernel/entry.S   Sven Schnelle      2020-11-21  389  	CHECK_VMAP_STACK __LC_SAVE_AREA_SYNC,4f
56e62a73702836 arch/s390/kernel/entry.S   Sven Schnelle      2020-11-21  390  3:	BPENTER __TI_flags(%r12),_TIF_ISOLATE_BP
c5328901aa1db1 arch/s390/kernel/entry64.S Martin Schwidefsky 2011-12-27  391  	lg	%r15,__LC_KERNEL_STACK
56e62a73702836 arch/s390/kernel/entry.S   Sven Schnelle      2020-11-21  392  4:	la	%r11,STACK_FRAME_OVERHEAD(%r15)
56e62a73702836 arch/s390/kernel/entry.S   Sven Schnelle      2020-11-21  393  	stg	%r10,__PT_FLAGS(%r11)
56e62a73702836 arch/s390/kernel/entry.S   Sven Schnelle      2020-11-21  394  	xc	__SF_BACKCHAIN(8,%r15),__SF_BACKCHAIN(%r15)
c5328901aa1db1 arch/s390/kernel/entry64.S Martin Schwidefsky 2011-12-27  395  	stmg	%r0,%r7,__PT_R0(%r11)
56e62a73702836 arch/s390/kernel/entry.S   Sven Schnelle      2020-11-21  396  	mvc	__PT_R8(64,%r11),__LC_SAVE_AREA_SYNC
3b051e89da70d4 arch/s390/kernel/entry.S   Sven Schnelle      2021-04-07  397  	mvc	__PT_LAST_BREAK(8,%r11),__LC_PGM_LAST_BREAK
56e62a73702836 arch/s390/kernel/entry.S   Sven Schnelle      2020-11-21  398  	stmg	%r8,%r9,__PT_PSW(%r11)
56e62a73702836 arch/s390/kernel/entry.S   Sven Schnelle      2020-11-21  399  
7041d28115e91f arch/s390/kernel/entry.S   Martin Schwidefsky 2018-01-16  400  	# clear user controlled registers to prevent speculative use
7041d28115e91f arch/s390/kernel/entry.S   Martin Schwidefsky 2018-01-16  401  	xgr	%r0,%r0
7041d28115e91f arch/s390/kernel/entry.S   Martin Schwidefsky 2018-01-16  402  	xgr	%r1,%r1
7041d28115e91f arch/s390/kernel/entry.S   Martin Schwidefsky 2018-01-16  403  	xgr	%r3,%r3
7041d28115e91f arch/s390/kernel/entry.S   Martin Schwidefsky 2018-01-16  404  	xgr	%r4,%r4
7041d28115e91f arch/s390/kernel/entry.S   Martin Schwidefsky 2018-01-16  405  	xgr	%r5,%r5
7041d28115e91f arch/s390/kernel/entry.S   Martin Schwidefsky 2018-01-16  406  	xgr	%r6,%r6
7041d28115e91f arch/s390/kernel/entry.S   Martin Schwidefsky 2018-01-16  407  	xgr	%r7,%r7
56e62a73702836 arch/s390/kernel/entry.S   Sven Schnelle      2020-11-21  408  	lgr	%r2,%r11
56e62a73702836 arch/s390/kernel/entry.S   Sven Schnelle      2020-11-21  409  	brasl	%r14,__do_pgm_check
56e62a73702836 arch/s390/kernel/entry.S   Sven Schnelle      2020-11-21  410  	tmhh	%r8,0x0001		# returning to user space?
56e62a73702836 arch/s390/kernel/entry.S   Sven Schnelle      2020-11-21  411  	jno	.Lpgm_exit_kernel
56e62a73702836 arch/s390/kernel/entry.S   Sven Schnelle      2020-11-21  412  	lctlg	%c1,%c1,__LC_USER_ASCE
56e62a73702836 arch/s390/kernel/entry.S   Sven Schnelle      2020-11-21  413  	BPEXIT __TI_flags(%r12),_TIF_ISOLATE_BP
0cd9b7230cc57b arch/s390/kernel/entry.S   Heiko Carstens     2020-11-11  414  	stpt	__LC_EXIT_TIMER
56e62a73702836 arch/s390/kernel/entry.S   Sven Schnelle      2020-11-21  415  .Lpgm_exit_kernel:
56e62a73702836 arch/s390/kernel/entry.S   Sven Schnelle      2020-11-21  416  	mvc	__LC_RETURN_PSW(16),STACK_FRAME_OVERHEAD+__PT_PSW(%r15)
3b051e89da70d4 arch/s390/kernel/entry.S   Sven Schnelle      2021-04-07  417  	LBEAR	STACK_FRAME_OVERHEAD+__PT_LAST_BREAK(%r15)
56e62a73702836 arch/s390/kernel/entry.S   Sven Schnelle      2020-11-21  418  	lmg	%r0,%r15,STACK_FRAME_OVERHEAD+__PT_R0(%r15)
3b051e89da70d4 arch/s390/kernel/entry.S   Sven Schnelle      2021-04-07  419  	LPSWEY	__LC_RETURN_PSW,__LC_RETURN_LPSWE
^1da177e4c3f41 arch/s390/kernel/entry64.S Linus Torvalds     2005-04-16  420  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
