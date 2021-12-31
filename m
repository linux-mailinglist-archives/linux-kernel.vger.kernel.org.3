Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 356BA4825C0
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 21:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbhLaUcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 15:32:14 -0500
Received: from mga14.intel.com ([192.55.52.115]:33005 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231671AbhLaUcN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 15:32:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640982733; x=1672518733;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Go5yzGKL92tGXSoXQDqUN8WiOo6UM+8mq4jUGoqKzhE=;
  b=iMuKOyM7A6hrzdEeIfYRDOtNixmNcGxaAqzJFp5/xYhONEMRnBHJ4V0A
   kznPAOgFGFzENyOJpKymHtEF02IfiKBPYIpGtfzRxwRuTpFmwuhtpeVSe
   UcQgsL6sy1sI2QQT0WIlOZHmjPPJ708uvNH5P5i+oTxTxzhzptODH0P7P
   1FIJqKH4NSDvSPQRdw8mA7iIV0uiw5RHxHUM+Nvb6Mw5zYI9jue8BRs7D
   HxvNwrYLwU2dDXJ3baYEhV13cgyogvQ5ojZoq5mAjxUfqPbdDcWQgbZkZ
   f88e4ajN3IYwMG72J9TgcjysYmpSt/esO6FGFf89VYW/pHmKpQI0EhhMs
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10213"; a="242052659"
X-IronPort-AV: E=Sophos;i="5.88,252,1635231600"; 
   d="scan'208";a="242052659"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2021 12:32:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,252,1635231600"; 
   d="scan'208";a="687568982"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 31 Dec 2021 12:32:12 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n3OZP-000Beg-EP; Fri, 31 Dec 2021 20:32:11 +0000
Date:   Sat, 1 Jan 2022 04:31:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Robert Hancock <robert.hancock@calian.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>
Subject: drivers/irqchip/irq-xilinx-intc.c:127:14: warning: no previous
 prototype for 'xintc_get_irq'
Message-ID: <202201010402.GsFaB29E-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robert,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4f3d93c6eaff6b84e43b63e0d7a119c5920e1020
commit: debf69cfd4c618c7036a13cc4edd1faf87ce7d53 irqchip/xilinx: Expose Kconfig option for Zynq/ZynqMP
date:   8 months ago
config: arm64-buildonly-randconfig-r005-20211231 (https://download.01.org/0day-ci/archive/20220101/202201010402.GsFaB29E-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=debf69cfd4c618c7036a13cc4edd1faf87ce7d53
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout debf69cfd4c618c7036a13cc4edd1faf87ce7d53
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/irqchip/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/irqchip/irq-xilinx-intc.c:127:14: warning: no previous prototype for 'xintc_get_irq' [-Wmissing-prototypes]
     127 | unsigned int xintc_get_irq(void)
         |              ^~~~~~~~~~~~~


vim +/xintc_get_irq +127 drivers/irqchip/irq-xilinx-intc.c

67862a3c47fcfc Mubin Sayyed 2020-03-17  126  
4cea749d56bec9 Marc Zyngier 2020-03-30 @127  unsigned int xintc_get_irq(void)
4cea749d56bec9 Marc Zyngier 2020-03-30  128  {
4cea749d56bec9 Marc Zyngier 2020-03-30  129  	unsigned int irq = -1;
4cea749d56bec9 Marc Zyngier 2020-03-30  130  	u32 hwirq;
4cea749d56bec9 Marc Zyngier 2020-03-30  131  
4cea749d56bec9 Marc Zyngier 2020-03-30  132  	hwirq = xintc_read(primary_intc, IVR);
4cea749d56bec9 Marc Zyngier 2020-03-30  133  	if (hwirq != -1U)
4cea749d56bec9 Marc Zyngier 2020-03-30  134  		irq = irq_find_mapping(primary_intc->root_domain, hwirq);
4cea749d56bec9 Marc Zyngier 2020-03-30  135  
4cea749d56bec9 Marc Zyngier 2020-03-30  136  	pr_debug("irq-xilinx: hwirq=%d, irq=%d\n", hwirq, irq);
4cea749d56bec9 Marc Zyngier 2020-03-30  137  
4cea749d56bec9 Marc Zyngier 2020-03-30  138  	return irq;
4cea749d56bec9 Marc Zyngier 2020-03-30  139  }
4cea749d56bec9 Marc Zyngier 2020-03-30  140  

:::::: The code at line 127 was first introduced by commit
:::::: 4cea749d56bec9409f3bd126d2b2f949dc6c66e2 Revert "irqchip/xilinx: Enable generic irq multi handler"

:::::: TO: Marc Zyngier <maz@kernel.org>
:::::: CC: Marc Zyngier <maz@kernel.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
