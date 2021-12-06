Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15AFE46A305
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 18:30:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242740AbhLFReB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 12:34:01 -0500
Received: from mga14.intel.com ([192.55.52.115]:29125 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242650AbhLFReB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 12:34:01 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="237589443"
X-IronPort-AV: E=Sophos;i="5.87,292,1631602800"; 
   d="scan'208";a="237589443"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 09:30:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,292,1631602800"; 
   d="scan'208";a="502211132"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 06 Dec 2021 09:30:13 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1muHob-000LWl-4B; Mon, 06 Dec 2021 17:30:13 +0000
Date:   Tue, 7 Dec 2021 01:29:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [tglx-devel:msi 20/90] drivers/pci/probe.c:2312:32: error: 'struct
 pci_dev' has no member named 'msi_lock'
Message-ID: <202112070134.V7oCHNbu-lkp@intel.com>
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
config: xtensa-randconfig-r033-20211206 (https://download.01.org/0day-ci/archive/20211207/202112070134.V7oCHNbu-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git/commit/?id=7ea486fb224a3869f662839f110b4c2f2be17fa3
        git remote add tglx-devel https://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git
        git fetch --no-tags tglx-devel msi
        git checkout 7ea486fb224a3869f662839f110b4c2f2be17fa3
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=xtensa SHELL=/bin/bash drivers/pci/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:6,
                    from include/linux/radix-tree.h:12,
                    from include/linux/idr.h:15,
                    from include/linux/kernfs.h:13,
                    from include/linux/sysfs.h:16,
                    from include/linux/kobject.h:20,
                    from include/linux/pci.h:35,
                    from drivers/pci/probe.c:9:
   drivers/pci/probe.c: In function 'pci_alloc_dev':
>> drivers/pci/probe.c:2312:32: error: 'struct pci_dev' has no member named 'msi_lock'
    2312 |         raw_spin_lock_init(&dev->msi_lock);
         |                                ^~
   include/linux/spinlock.h:106:31: note: in definition of macro 'raw_spin_lock_init'
     106 |         __raw_spin_lock_init((lock), #lock, &__key, LD_WAIT_SPIN);      \
         |                               ^~~~


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
