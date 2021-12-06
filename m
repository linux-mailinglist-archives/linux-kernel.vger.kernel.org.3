Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94B6646A4D1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 19:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347226AbhLFSpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 13:45:47 -0500
Received: from mga14.intel.com ([192.55.52.115]:35940 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346908AbhLFSpq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 13:45:46 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="237604836"
X-IronPort-AV: E=Sophos;i="5.87,292,1631602800"; 
   d="scan'208";a="237604836"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 10:42:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,292,1631602800"; 
   d="scan'208";a="461945803"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 06 Dec 2021 10:42:16 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1muIwJ-000LaY-Cp; Mon, 06 Dec 2021 18:42:15 +0000
Date:   Tue, 7 Dec 2021 02:41:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [tglx-devel:msi 20/90] drivers/pci/probe.c:2312:27: error: no member
 named 'msi_lock' in 'struct pci_dev'
Message-ID: <202112070219.xshR2G9z-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git msi
head:   36b5ae08d9cb4a60d6ea0f7ff6a3415223dbb289
commit: 7ea486fb224a3869f662839f110b4c2f2be17fa3 [20/90] PCI/MSI: Move msi_lock to struct pci_dev
config: x86_64-buildonly-randconfig-r005-20211206 (https://download.01.org/0day-ci/archive/20211207/202112070219.xshR2G9z-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project f50be8eb0a12a61d23db6cda452c693001d76898)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git/commit/?id=7ea486fb224a3869f662839f110b4c2f2be17fa3
        git remote add tglx-devel https://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git
        git fetch --no-tags tglx-devel msi
        git checkout 7ea486fb224a3869f662839f110b4c2f2be17fa3
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/pci/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/pci/probe.c:2312:27: error: no member named 'msi_lock' in 'struct pci_dev'
           raw_spin_lock_init(&dev->msi_lock);
                               ~~~  ^
   include/linux/spinlock.h:106:24: note: expanded from macro 'raw_spin_lock_init'
           __raw_spin_lock_init((lock), #lock, &__key, LD_WAIT_SPIN);      \
                                 ^~~~
   1 error generated.


vim +2312 drivers/pci/probe.c

  2302	
  2303	struct pci_dev *pci_alloc_dev(struct pci_bus *bus)
  2304	{
  2305		struct pci_dev *dev;
  2306	
  2307		dev = kzalloc(sizeof(struct pci_dev), GFP_KERNEL);
  2308		if (!dev)
  2309			return NULL;
  2310	
  2311		INIT_LIST_HEAD(&dev->bus_list);
> 2312		raw_spin_lock_init(&dev->msi_lock);
  2313		dev->dev.type = &pci_dev_type;
  2314		dev->bus = pci_bus_get(bus);
  2315	
  2316		return dev;
  2317	}
  2318	EXPORT_SYMBOL(pci_alloc_dev);
  2319	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
