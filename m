Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48DC6463FF8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 22:24:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344112AbhK3V1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 16:27:18 -0500
Received: from mga05.intel.com ([192.55.52.43]:42041 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344169AbhK3V0u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 16:26:50 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10184"; a="322564435"
X-IronPort-AV: E=Sophos;i="5.87,277,1631602800"; 
   d="scan'208";a="322564435"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2021 13:23:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,277,1631602800"; 
   d="scan'208";a="459768272"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 30 Nov 2021 13:23:28 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1msAb1-000Dn1-E0; Tue, 30 Nov 2021 21:23:27 +0000
Date:   Wed, 1 Dec 2021 05:22:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [ardb:for-kernelci 18/28] arch/arm/mach-footbridge/common.c:102:6:
 warning: no previous prototype for 'dc21285_handle_irq'
Message-ID: <202112010520.F2sIDAwN-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git for-kernelci
head:   6999340fcf7f37e2a82eb35452b08c5893a2872d
commit: 9a2235df531e427be5777a894b3fa355ce127894 [18/28] ARM: footbridge: use GENERIC_IRQ_MULTI_HANDLER
config: arm-footbridge_defconfig (https://download.01.org/0day-ci/archive/20211201/202112010520.F2sIDAwN-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/commit/?id=9a2235df531e427be5777a894b3fa355ce127894
        git remote add ardb git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git
        git fetch --no-tags ardb for-kernelci
        git checkout 9a2235df531e427be5777a894b3fa355ce127894
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/arm/mach-footbridge/common.c:102:6: warning: no previous prototype for 'dc21285_handle_irq' [-Wmissing-prototypes]
     102 | void dc21285_handle_irq(struct pt_regs *regs)
         |      ^~~~~~~~~~~~~~~~~~


vim +/dc21285_handle_irq +102 arch/arm/mach-footbridge/common.c

   101	
 > 102	void dc21285_handle_irq(struct pt_regs *regs)
   103	{
   104		int irq;
   105		do {
   106			irq = dc21285_get_irq();
   107			if (!irq)
   108				break;
   109	
   110			generic_handle_irq(irq);
   111		} while (1);
   112	}
   113	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
