Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F85B468AA7
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 12:54:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233466AbhLELz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 06:55:59 -0500
Received: from mga12.intel.com ([192.55.52.136]:7878 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233115AbhLELz4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 06:55:56 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10188"; a="217205612"
X-IronPort-AV: E=Sophos;i="5.87,289,1631602800"; 
   d="scan'208";a="217205612"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2021 03:52:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,289,1631602800"; 
   d="scan'208";a="678668813"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 05 Dec 2021 03:52:27 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mtq4B-000K6H-7M; Sun, 05 Dec 2021 11:52:27 +0000
Date:   Sun, 5 Dec 2021 19:52:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chris Down <chris@chrisdown.name>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>
Subject: arch/parisc/math-emu/driver.c:88:17: sparse: sparse: Using plain
 integer as NULL pointer
Message-ID: <202112051946.nbvqPk1h-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   79a72162048e42a677bc7336a9f5d86fc3ff9558
commit: 337015573718b161891a3473d25f59273f2e626b printk: Userspace format indexing support
date:   5 months ago
config: parisc-allyesconfig (https://download.01.org/0day-ci/archive/20211205/202112051946.nbvqPk1h-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=337015573718b161891a3473d25f59273f2e626b
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 337015573718b161891a3473d25f59273f2e626b
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=parisc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> arch/parisc/math-emu/driver.c:88:17: sparse: sparse: Using plain integer as NULL pointer
>> arch/parisc/math-emu/driver.c:88:17: sparse: sparse: Using plain integer as NULL pointer
>> arch/parisc/math-emu/driver.c:88:17: sparse: sparse: Using plain integer as NULL pointer
   arch/parisc/math-emu/driver.c:90:17: sparse: sparse: Using plain integer as NULL pointer
   arch/parisc/math-emu/driver.c:90:17: sparse: sparse: Using plain integer as NULL pointer
   arch/parisc/math-emu/driver.c:90:17: sparse: sparse: Using plain integer as NULL pointer
   arch/parisc/math-emu/driver.c:93:22: sparse: sparse: undefined identifier 'decode_fpu'

vim +88 arch/parisc/math-emu/driver.c

^1da177e4c3f41 Linus Torvalds 2005-04-16  64  
^1da177e4c3f41 Linus Torvalds 2005-04-16  65  /* Handle a floating point exception.  Return zero if the faulting
^1da177e4c3f41 Linus Torvalds 2005-04-16  66     instruction can be completed successfully. */
^1da177e4c3f41 Linus Torvalds 2005-04-16  67  int
^1da177e4c3f41 Linus Torvalds 2005-04-16  68  handle_fpe(struct pt_regs *regs)
^1da177e4c3f41 Linus Torvalds 2005-04-16  69  {
^1da177e4c3f41 Linus Torvalds 2005-04-16  70  	extern void printbinary(unsigned long x, int nbits);
^1da177e4c3f41 Linus Torvalds 2005-04-16  71  	unsigned int orig_sw, sw;
^1da177e4c3f41 Linus Torvalds 2005-04-16  72  	int signalcode;
^1da177e4c3f41 Linus Torvalds 2005-04-16  73  	/* need an intermediate copy of float regs because FPU emulation
^1da177e4c3f41 Linus Torvalds 2005-04-16  74  	 * code expects an artificial last entry which contains zero
^1da177e4c3f41 Linus Torvalds 2005-04-16  75  	 *
^1da177e4c3f41 Linus Torvalds 2005-04-16  76  	 * also, the passed in fr registers contain one word that defines
^1da177e4c3f41 Linus Torvalds 2005-04-16  77  	 * the fpu type. the fpu type information is constructed 
^1da177e4c3f41 Linus Torvalds 2005-04-16  78  	 * inside the emulation code
^1da177e4c3f41 Linus Torvalds 2005-04-16  79  	 */
^1da177e4c3f41 Linus Torvalds 2005-04-16  80  	__u64 frcopy[36];
^1da177e4c3f41 Linus Torvalds 2005-04-16  81  
^1da177e4c3f41 Linus Torvalds 2005-04-16  82  	memcpy(frcopy, regs->fr, sizeof regs->fr);
^1da177e4c3f41 Linus Torvalds 2005-04-16  83  	frcopy[32] = 0;
^1da177e4c3f41 Linus Torvalds 2005-04-16  84  
^1da177e4c3f41 Linus Torvalds 2005-04-16  85  	memcpy(&orig_sw, frcopy, sizeof(orig_sw));
^1da177e4c3f41 Linus Torvalds 2005-04-16  86  
^1da177e4c3f41 Linus Torvalds 2005-04-16  87  	if (FPUDEBUG) {
^1da177e4c3f41 Linus Torvalds 2005-04-16 @88  		printk(KERN_DEBUG "FP VZOUICxxxxCQCQCQCQCQCRMxxTDVZOUI ->\n   ");

:::::: The code at line 88 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
