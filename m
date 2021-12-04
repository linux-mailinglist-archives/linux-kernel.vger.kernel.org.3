Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5804686EB
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 19:13:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385385AbhLDSP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 13:15:28 -0500
Received: from mga04.intel.com ([192.55.52.120]:14848 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229534AbhLDSP1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 13:15:27 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10188"; a="235872337"
X-IronPort-AV: E=Sophos;i="5.87,287,1631602800"; 
   d="scan'208";a="235872337"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2021 10:12:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,287,1631602800"; 
   d="scan'208";a="501594662"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 04 Dec 2021 10:11:57 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mtZVs-000JHV-D8; Sat, 04 Dec 2021 18:11:56 +0000
Date:   Sun, 5 Dec 2021 02:11:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Dinh Nguyen <dinguyen@kernel.org>
Subject: arch/arm/mach-socfpga/pm.c:75:25: sparse: sparse: incorrect type in
 argument 1 (different address spaces)
Message-ID: <202112050248.97q4WQ5F-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   12119cfa1052d512a92524e90ebee85029a918f8
commit: 4483397b03536506535d611b0cb28a81a69e8edf ARM: socfpga: drop ARCH_SOCFPGA
date:   9 months ago
config: arm-allyesconfig (https://download.01.org/0day-ci/archive/20211205/202112050248.97q4WQ5F-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4483397b03536506535d611b0cb28a81a69e8edf
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 4483397b03536506535d611b0cb28a81a69e8edf
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm SHELL=/bin/bash arch/arm/mach-socfpga/ drivers/dma/ drivers/edac/ drivers/gpu/drm/msm/ drivers/gpu/drm/tegra/ drivers/interconnect/qcom/ drivers/net/ethernet/mediatek/ drivers/net/vmxnet3/ drivers/net/wireless/mediatek/mt76/mt7915/ drivers/remoteproc/ drivers/scsi/bnx2fc/ drivers/scsi/lpfc/ drivers/staging/ fs/proc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> arch/arm/mach-socfpga/pm.c:75:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *dest @@     got void [noderef] __iomem *[assigned] suspend_ocram_base @@
   arch/arm/mach-socfpga/pm.c:75:25: sparse:     expected void *dest
   arch/arm/mach-socfpga/pm.c:75:25: sparse:     got void [noderef] __iomem *[assigned] suspend_ocram_base
--
>> drivers/edac/altera_edac.c:886:28: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __be32 const [usertype] *p @@     got unsigned int const [usertype] *handle @@
   drivers/edac/altera_edac.c:886:28: sparse:     expected restricted __be32 const [usertype] *p
   drivers/edac/altera_edac.c:886:28: sparse:     got unsigned int const [usertype] *handle

vim +75 arch/arm/mach-socfpga/pm.c

44fd8c7d4005f6 Alan Tull          2015-06-05  24  
44fd8c7d4005f6 Alan Tull          2015-06-05  25  static int socfpga_setup_ocram_self_refresh(void)
44fd8c7d4005f6 Alan Tull          2015-06-05  26  {
44fd8c7d4005f6 Alan Tull          2015-06-05  27  	struct platform_device *pdev;
44fd8c7d4005f6 Alan Tull          2015-06-05  28  	phys_addr_t ocram_pbase;
44fd8c7d4005f6 Alan Tull          2015-06-05  29  	struct device_node *np;
44fd8c7d4005f6 Alan Tull          2015-06-05  30  	struct gen_pool *ocram_pool;
44fd8c7d4005f6 Alan Tull          2015-06-05  31  	unsigned long ocram_base;
44fd8c7d4005f6 Alan Tull          2015-06-05  32  	void __iomem *suspend_ocram_base;
44fd8c7d4005f6 Alan Tull          2015-06-05  33  	int ret = 0;
44fd8c7d4005f6 Alan Tull          2015-06-05  34  
44fd8c7d4005f6 Alan Tull          2015-06-05  35  	np = of_find_compatible_node(NULL, NULL, "mmio-sram");
44fd8c7d4005f6 Alan Tull          2015-06-05  36  	if (!np) {
44fd8c7d4005f6 Alan Tull          2015-06-05  37  		pr_err("%s: Unable to find mmio-sram in dtb\n", __func__);
44fd8c7d4005f6 Alan Tull          2015-06-05  38  		return -ENODEV;
44fd8c7d4005f6 Alan Tull          2015-06-05  39  	}
44fd8c7d4005f6 Alan Tull          2015-06-05  40  
44fd8c7d4005f6 Alan Tull          2015-06-05  41  	pdev = of_find_device_by_node(np);
44fd8c7d4005f6 Alan Tull          2015-06-05  42  	if (!pdev) {
44fd8c7d4005f6 Alan Tull          2015-06-05  43  		pr_warn("%s: failed to find ocram device!\n", __func__);
44fd8c7d4005f6 Alan Tull          2015-06-05  44  		ret = -ENODEV;
44fd8c7d4005f6 Alan Tull          2015-06-05  45  		goto put_node;
44fd8c7d4005f6 Alan Tull          2015-06-05  46  	}
44fd8c7d4005f6 Alan Tull          2015-06-05  47  
73858173593c31 Vladimir Zapolskiy 2015-09-04  48  	ocram_pool = gen_pool_get(&pdev->dev, NULL);
44fd8c7d4005f6 Alan Tull          2015-06-05  49  	if (!ocram_pool) {
44fd8c7d4005f6 Alan Tull          2015-06-05  50  		pr_warn("%s: ocram pool unavailable!\n", __func__);
44fd8c7d4005f6 Alan Tull          2015-06-05  51  		ret = -ENODEV;
3ad7b4e8f89d6b Yu Kuai            2020-07-21  52  		goto put_device;
44fd8c7d4005f6 Alan Tull          2015-06-05  53  	}
44fd8c7d4005f6 Alan Tull          2015-06-05  54  
44fd8c7d4005f6 Alan Tull          2015-06-05  55  	ocram_base = gen_pool_alloc(ocram_pool, socfpga_sdram_self_refresh_sz);
44fd8c7d4005f6 Alan Tull          2015-06-05  56  	if (!ocram_base) {
44fd8c7d4005f6 Alan Tull          2015-06-05  57  		pr_warn("%s: unable to alloc ocram!\n", __func__);
44fd8c7d4005f6 Alan Tull          2015-06-05  58  		ret = -ENOMEM;
3ad7b4e8f89d6b Yu Kuai            2020-07-21  59  		goto put_device;
44fd8c7d4005f6 Alan Tull          2015-06-05  60  	}
44fd8c7d4005f6 Alan Tull          2015-06-05  61  
44fd8c7d4005f6 Alan Tull          2015-06-05  62  	ocram_pbase = gen_pool_virt_to_phys(ocram_pool, ocram_base);
44fd8c7d4005f6 Alan Tull          2015-06-05  63  
44fd8c7d4005f6 Alan Tull          2015-06-05  64  	suspend_ocram_base = __arm_ioremap_exec(ocram_pbase,
44fd8c7d4005f6 Alan Tull          2015-06-05  65  						socfpga_sdram_self_refresh_sz,
44fd8c7d4005f6 Alan Tull          2015-06-05  66  						false);
44fd8c7d4005f6 Alan Tull          2015-06-05  67  	if (!suspend_ocram_base) {
44fd8c7d4005f6 Alan Tull          2015-06-05  68  		pr_warn("%s: __arm_ioremap_exec failed!\n", __func__);
44fd8c7d4005f6 Alan Tull          2015-06-05  69  		ret = -ENOMEM;
3ad7b4e8f89d6b Yu Kuai            2020-07-21  70  		goto put_device;
44fd8c7d4005f6 Alan Tull          2015-06-05  71  	}
44fd8c7d4005f6 Alan Tull          2015-06-05  72  
44fd8c7d4005f6 Alan Tull          2015-06-05  73  	/* Copy the code that puts DDR in self refresh to ocram */
44fd8c7d4005f6 Alan Tull          2015-06-05  74  	socfpga_sdram_self_refresh_in_ocram =
44fd8c7d4005f6 Alan Tull          2015-06-05 @75  		(void *)fncpy(suspend_ocram_base,
44fd8c7d4005f6 Alan Tull          2015-06-05  76  			      &socfpga_sdram_self_refresh,
44fd8c7d4005f6 Alan Tull          2015-06-05  77  			      socfpga_sdram_self_refresh_sz);
44fd8c7d4005f6 Alan Tull          2015-06-05  78  
44fd8c7d4005f6 Alan Tull          2015-06-05  79  	WARN(!socfpga_sdram_self_refresh_in_ocram,
44fd8c7d4005f6 Alan Tull          2015-06-05  80  	     "could not copy function to ocram");
44fd8c7d4005f6 Alan Tull          2015-06-05  81  	if (!socfpga_sdram_self_refresh_in_ocram)
44fd8c7d4005f6 Alan Tull          2015-06-05  82  		ret = -EFAULT;
44fd8c7d4005f6 Alan Tull          2015-06-05  83  
3ad7b4e8f89d6b Yu Kuai            2020-07-21  84  put_device:
3ad7b4e8f89d6b Yu Kuai            2020-07-21  85  	put_device(&pdev->dev);
44fd8c7d4005f6 Alan Tull          2015-06-05  86  put_node:
44fd8c7d4005f6 Alan Tull          2015-06-05  87  	of_node_put(np);
44fd8c7d4005f6 Alan Tull          2015-06-05  88  
44fd8c7d4005f6 Alan Tull          2015-06-05  89  	return ret;
44fd8c7d4005f6 Alan Tull          2015-06-05  90  }
44fd8c7d4005f6 Alan Tull          2015-06-05  91  

:::::: The code at line 75 was first introduced by commit
:::::: 44fd8c7d4005f660f48679439f0a54225ba234a4 ARM: socfpga: support suspend to ram

:::::: TO: Alan Tull <atull@opensource.altera.com>
:::::: CC: Kevin Hilman <khilman@linaro.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
