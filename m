Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D694659A46C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 20:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350763AbiHSRGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 13:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350215AbiHSRGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 13:06:20 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C18FD13CFAE
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 09:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660926420; x=1692462420;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=6Ii/b/fTZ1slbFJDpvOAdK2S4LOO9TQ06d1ongMPeuw=;
  b=TRPmOJUpp6tEfKjamJRv7/Ch9mznfOJE73GD1BJIIeYIQ8xMLTlXFmxM
   wm08KNGr+3Q2tr6elRgmMSoucJiOgPZmkMthpTIF2BGy3TZd76VZ6gB/s
   KWXj6zhJQCiRtWDuzscH3rhK4u8uW5YbdPaGZOSQPtFGE8YZAMqxttTQE
   XtZgRic6r17S0aNtV1UL5L++2t9jPtv42WziI+W0EjKQKdPRHtaeFLE+W
   gKrPnI75geZgLUgD+VUNoXiLxetMntJfm/Yd2df9xI8rQPCfh54LPa6pV
   FE00Uo+cAW7L/KrqxofwbWNcaF869ATiwiScn/EZCJTL8mN3VZ6dqiqbj
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10444"; a="273439923"
X-IronPort-AV: E=Sophos;i="5.93,248,1654585200"; 
   d="scan'208";a="273439923"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2022 09:24:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,248,1654585200"; 
   d="scan'208";a="584713349"
Received: from lkp-server01.sh.intel.com (HELO 44b6dac04a33) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 19 Aug 2022 09:24:04 -0700
Received: from kbuild by 44b6dac04a33 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oP4mx-0001cd-2J;
        Fri, 19 Aug 2022 16:24:03 +0000
Date:   Sat, 20 Aug 2022 00:23:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [broonie-misc:arm64-sysreg-gen-4 11/28]
 arch/arm64/kernel/hibernate-asm.S:53: Error: invalid operands (*ABS* and
 *UND* sections) for `<<'
Message-ID: <202208200005.RKBoLVDt-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arch/arm64/include/asm/sysreg.h
arch/arm64/kernel/cpufeature.c
Hi Mark,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/misc.git arm64-sysreg-gen-4
head:   033a9c641ed02d565771b605ce223a217a78ba5b
commit: 4c58057614042c492fca23584e04c8bf2cf3a0f8 [11/28] arm64/sysreg: Standardise naming for ID_AA64MMFR2_EL1.VARange
config: arm64-randconfig-c032-20220819 (https://download.01.org/0day-ci/archive/20220820/202208200005.RKBoLVDt-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/broonie/misc.git/commit/?id=4c58057614042c492fca23584e04c8bf2cf3a0f8
        git remote add broonie-misc https://git.kernel.org/pub/scm/linux/kernel/git/broonie/misc.git
        git fetch --no-tags broonie-misc arm64-sysreg-gen-4
        git checkout 4c58057614042c492fca23584e04c8bf2cf3a0f8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/arm64/kernel/hibernate-asm.S: Assembler messages:
>> arch/arm64/kernel/hibernate-asm.S:53: Error: invalid operands (*ABS* and *UND* sections) for `<<'
   arch/arm64/kernel/hibernate-asm.S:85: Error: invalid operands (*ABS* and *UND* sections) for `<<'


vim +53 arch/arm64/kernel/hibernate-asm.S

82869ac57b5d3b5 James Morse  2016-04-27  17  
82869ac57b5d3b5 James Morse  2016-04-27  18  /*
82869ac57b5d3b5 James Morse  2016-04-27  19   * Resume from hibernate
82869ac57b5d3b5 James Morse  2016-04-27  20   *
82869ac57b5d3b5 James Morse  2016-04-27  21   * Loads temporary page tables then restores the memory image.
82869ac57b5d3b5 James Morse  2016-04-27  22   * Finally branches to cpu_resume() to restore the state saved by
82869ac57b5d3b5 James Morse  2016-04-27  23   * swsusp_arch_suspend().
82869ac57b5d3b5 James Morse  2016-04-27  24   *
82869ac57b5d3b5 James Morse  2016-04-27  25   * Because this code has to be copied to a 'safe' page, it can't call out to
82869ac57b5d3b5 James Morse  2016-04-27  26   * other functions by PC-relative address. Also remember that it may be
82869ac57b5d3b5 James Morse  2016-04-27  27   * mid-way through over-writing other functions. For this reason it contains
fade9c2c6ee2bae Fuad Tabba   2021-05-24  28   * code from caches_clean_inval_pou() and uses the copy_page() macro.
82869ac57b5d3b5 James Morse  2016-04-27  29   *
82869ac57b5d3b5 James Morse  2016-04-27  30   * This 'safe' page is mapped via ttbr0, and executed from there. This function
82869ac57b5d3b5 James Morse  2016-04-27  31   * switches to a copy of the linear map in ttbr1, performs the restore, then
82869ac57b5d3b5 James Morse  2016-04-27  32   * switches ttbr1 to the original kernel's swapper_pg_dir.
82869ac57b5d3b5 James Morse  2016-04-27  33   *
82869ac57b5d3b5 James Morse  2016-04-27  34   * All of memory gets written to, including code. We need to clean the kernel
82869ac57b5d3b5 James Morse  2016-04-27  35   * text to the Point of Coherence (PoC) before secondary cores can be booted.
82869ac57b5d3b5 James Morse  2016-04-27  36   * Because the kernel modules and executable pages mapped to user space are
82869ac57b5d3b5 James Morse  2016-04-27  37   * also written as data, we clean all pages we touch to the Point of
82869ac57b5d3b5 James Morse  2016-04-27  38   * Unification (PoU).
82869ac57b5d3b5 James Morse  2016-04-27  39   *
82869ac57b5d3b5 James Morse  2016-04-27  40   * x0: physical address of temporary page tables
82869ac57b5d3b5 James Morse  2016-04-27  41   * x1: physical address of swapper page tables
82869ac57b5d3b5 James Morse  2016-04-27  42   * x2: address of cpu_resume
82869ac57b5d3b5 James Morse  2016-04-27  43   * x3: linear map address of restore_pblist in the current kernel
82869ac57b5d3b5 James Morse  2016-04-27  44   * x4: physical address of __hyp_stub_vectors, or 0
82869ac57b5d3b5 James Morse  2016-04-27  45   * x5: physical address of a  zero page that remains zero after resume
82869ac57b5d3b5 James Morse  2016-04-27  46   */
82869ac57b5d3b5 James Morse  2016-04-27  47  .pushsection    ".hibernate_exit.text", "ax"
0343a7e46362c38 Mark Brown   2020-05-01  48  SYM_CODE_START(swsusp_arch_suspend_exit)
82869ac57b5d3b5 James Morse  2016-04-27  49  	/*
82869ac57b5d3b5 James Morse  2016-04-27  50  	 * We execute from ttbr0, change ttbr1 to our copied linear map tables
82869ac57b5d3b5 James Morse  2016-04-27  51  	 * with a break-before-make via the zero page
82869ac57b5d3b5 James Morse  2016-04-27  52  	 */
c812026c54cfaec Steve Capper 2019-08-07 @53  	break_before_make_ttbr_switch	x5, x0, x6, x8
82869ac57b5d3b5 James Morse  2016-04-27  54  
82869ac57b5d3b5 James Morse  2016-04-27  55  	mov	x21, x1
82869ac57b5d3b5 James Morse  2016-04-27  56  	mov	x30, x2
82869ac57b5d3b5 James Morse  2016-04-27  57  	mov	x24, x4
82869ac57b5d3b5 James Morse  2016-04-27  58  	mov	x25, x5
82869ac57b5d3b5 James Morse  2016-04-27  59  
82869ac57b5d3b5 James Morse  2016-04-27  60  	/* walk the restore_pblist and use copy_page() to over-write memory */
82869ac57b5d3b5 James Morse  2016-04-27  61  	mov	x19, x3
82869ac57b5d3b5 James Morse  2016-04-27  62  

:::::: The code at line 53 was first introduced by commit
:::::: c812026c54cfaec23fa1d78cdbfd0e56e787470a arm64: mm: Logic to make offset_ttbr1 conditional

:::::: TO: Steve Capper <steve.capper@arm.com>
:::::: CC: Will Deacon <will@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
