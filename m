Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF23479882
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 05:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbhLRDxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 22:53:34 -0500
Received: from mga14.intel.com ([192.55.52.115]:53746 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230052AbhLRDxd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 22:53:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639799613; x=1671335613;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=e3QOI6p5iHhGvaVjtPRrYi7FHiFC6GxLLKPCJfwO5HA=;
  b=R8Npw+9pYb35xaQheDyO+K/fFrvMDpczpCulnz1r0d1TSDxaxwFvCAL8
   x28Z8sVG6UVETnDm8nYe+eqz82yTc0obLHukZr1+REfV5OFgYOxeF/eTC
   gFMoxLKaYwl95HO1Y1I1WDiQOyhuaKLVl38SlfcLxQdk9cjMovvYeuYsm
   FRa388NZm2AWsdN1avyHzIRpl/zGZnfPMix541Q0bAYY1NRjksNyEcZrg
   W5ynhkAzh+RS5ymNYQYdXVhukw6vtOcSEDeTES3cIbLlDcxABXC+aNHKi
   pzwqK80TWZL0UoMGAISwy2HV0rzSPr/Eaapirn6bXO52b7vz65zZn1ZwE
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10201"; a="240105087"
X-IronPort-AV: E=Sophos;i="5.88,215,1635231600"; 
   d="scan'208";a="240105087"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2021 19:53:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,215,1635231600"; 
   d="scan'208";a="507011729"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 17 Dec 2021 19:53:32 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1myQmp-0005ZT-Fo; Sat, 18 Dec 2021 03:53:31 +0000
Date:   Sat, 18 Dec 2021 11:52:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Gary Guo <gary@garyguo.net>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [nbdd0121:riscv 1/4] arch/riscv/kernel/head.S:232: Error:
 unrecognized opcode `csrw, CSR_MCOUNTEREN,2'
Message-ID: <202112181138.GXFKRI6J-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/nbdd0121/linux riscv
head:   696be59be32488c7c2417cd633008c2162f89fa8
commit: 4481ee1b02354fde9960268a3fd8d638124aba1a [1/4] riscv: enable TIME CSR in U mode
config: riscv-nommu_k210_defconfig (https://download.01.org/0day-ci/archive/20211218/202112181138.GXFKRI6J-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/nbdd0121/linux/commit/4481ee1b02354fde9960268a3fd8d638124aba1a
        git remote add nbdd0121 https://github.com/nbdd0121/linux
        git fetch --no-tags nbdd0121 riscv
        git checkout 4481ee1b02354fde9960268a3fd8d638124aba1a
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/riscv/kernel/head.S: Assembler messages:
>> arch/riscv/kernel/head.S:232: Error: unrecognized opcode `csrw, CSR_MCOUNTEREN,2'


vim +232 arch/riscv/kernel/head.S

   203	
   204	ENTRY(_start_kernel)
   205		/* Mask all interrupts */
   206		csrw CSR_IE, zero
   207		csrw CSR_IP, zero
   208	
   209	#ifdef CONFIG_RISCV_M_MODE
   210		/* flush the instruction cache */
   211		fence.i
   212	
   213		/* Reset all registers except ra, a0, a1 */
   214		call reset_regs
   215	
   216		/*
   217		 * Setup a PMP to permit access to all of memory.  Some machines may
   218		 * not implement PMPs, so we set up a quick trap handler to just skip
   219		 * touching the PMPs on any trap.
   220		 */
   221		la a0, pmp_done
   222		csrw CSR_TVEC, a0
   223	
   224		li a0, -1
   225		csrw CSR_PMPADDR0, a0
   226		li a0, (PMP_A_NAPOT | PMP_R | PMP_W | PMP_X)
   227		csrw CSR_PMPCFG0, a0
   228	.align 2
   229	pmp_done:
   230	
   231		/* Allow user-mode to access time CSR */
 > 232		csrw, CSR_MCOUNTEREN, 2
   233	
   234		/*
   235		 * The hartid in a0 is expected later on, and we have no firmware
   236		 * to hand it to us.
   237		 */
   238		csrr a0, CSR_MHARTID
   239	#endif /* CONFIG_RISCV_M_MODE */
   240	
   241		/* Allow user-mode to access time CSR */
   242		csrw CSR_SCOUNTEREN, 2
   243	
   244		/* Load the global pointer */
   245	.option push
   246	.option norelax
   247		la gp, __global_pointer$
   248	.option pop
   249	
   250		/*
   251		 * Disable FPU to detect illegal usage of
   252		 * floating point in kernel space
   253		 */
   254		li t0, SR_FS
   255		csrc CSR_STATUS, t0
   256	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
