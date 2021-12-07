Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB24546C79B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 23:39:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241986AbhLGWmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 17:42:49 -0500
Received: from mga06.intel.com ([134.134.136.31]:16207 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232475AbhLGWms (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 17:42:48 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10191"; a="298497417"
X-IronPort-AV: E=Sophos;i="5.87,295,1631602800"; 
   d="scan'208";a="298497417"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 14:39:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,295,1631602800"; 
   d="scan'208";a="462509013"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 07 Dec 2021 14:39:15 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1muj7C-000N24-V2; Tue, 07 Dec 2021 22:39:14 +0000
Date:   Wed, 8 Dec 2021 06:38:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [intel-tdx:guest 108/144] arch/x86/kernel/tdx.c:714:15: warning: no
 previous prototype for 'tdx_mmio_readq'
Message-ID: <202112080635.7JcdsSvJ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git guest
head:   41fe88a1b3c28543f49fa6ed9e0e9b6650ed7614
commit: e429db7ac5ebc20d80a407ff29424e5bb710d057 [108/144] x86/tdx: Enable direct iomap MMIO optimizations
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20211208/202112080635.7JcdsSvJ-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel/tdx/commit/e429db7ac5ebc20d80a407ff29424e5bb710d057
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx guest
        git checkout e429db7ac5ebc20d80a407ff29424e5bb710d057
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/kernel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   arch/x86/kernel/tdx.c:269:5: warning: no previous prototype for 'tdx_hcall_set_notify_intr' [-Wmissing-prototypes]
     269 | int tdx_hcall_set_notify_intr(u8 vector)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/kernel/tdx.c:492:14: warning: no previous prototype for 'tdx_write_msr' [-Wmissing-prototypes]
     492 | void notrace tdx_write_msr(unsigned int msr, u32 low, u32 high)
         |              ^~~~~~~~~~~~~
>> arch/x86/kernel/tdx.c:714:15: warning: no previous prototype for 'tdx_mmio_readq' [-Wmissing-prototypes]
     714 | unsigned long tdx_mmio_readq(void __iomem *addr)
         |               ^~~~~~~~~~~~~~


vim +/tdx_mmio_readq +714 arch/x86/kernel/tdx.c

   713	
 > 714	unsigned long tdx_mmio_readq(void __iomem *addr)
   715	{
   716		unsigned long val;
   717	
   718		if (tdx_virt_mmio(8, false, (unsigned long)addr, &val))
   719			return 0xffffffffffffffff;
   720		return val;
   721	}
   722	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
