Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2C55460FB4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 09:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241698AbhK2IGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 03:06:22 -0500
Received: from mga05.intel.com ([192.55.52.43]:31090 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239425AbhK2IEU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 03:04:20 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10182"; a="322149542"
X-IronPort-AV: E=Sophos;i="5.87,272,1631602800"; 
   d="scan'208";a="322149542"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 00:01:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,272,1631602800"; 
   d="scan'208";a="476609584"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 29 Nov 2021 00:01:01 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mrbau-000Bi0-MG; Mon, 29 Nov 2021 08:01:00 +0000
Date:   Mon, 29 Nov 2021 16:00:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>
Subject: drivers/dma/mmp_tdma.c:650:10: warning: cast to smaller integer type
 'enum mmp_tdma_type' from 'const void *'
Message-ID: <202111291545.kyRNP20w-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lubomir,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d58071a8a76d779eedab38033ae4c821c30295a5
commit: 9f3c14d4433b98c87f958128045539f297a2fa6d dmaengine: mmp_tdma: Allow building as a module
date:   10 months ago
config: riscv-randconfig-r042-20211111 (https://download.01.org/0day-ci/archive/20211129/202111291545.kyRNP20w-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 63ef0e17e28827eae53133b3467bdac7d9729318)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9f3c14d4433b98c87f958128045539f297a2fa6d
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 9f3c14d4433b98c87f958128045539f297a2fa6d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/kernel/ drivers/clocksource/ drivers/dma/ drivers/infiniband/core/ drivers/input/ drivers/misc/habanalabs/ drivers/mtd/nand/raw/ drivers/thermal/ fs/ceph/ fs/cifs/ fs/nfs/ kernel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/dma/mmp_tdma.c:650:10: warning: cast to smaller integer type 'enum mmp_tdma_type' from 'const void *' [-Wvoid-pointer-to-enum-cast]
                   type = (enum mmp_tdma_type) of_id->data;
                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 warning generated.


vim +650 drivers/dma/mmp_tdma.c

f1a7757008b810 Zhangfei Gao       2012-09-03  636  
463a1f8b3ceebe Bill Pemberton     2012-11-19  637  static int mmp_tdma_probe(struct platform_device *pdev)
c6da0ba8dfc826 Zhangfei Gao       2012-06-15  638  {
f1a7757008b810 Zhangfei Gao       2012-09-03  639  	enum mmp_tdma_type type;
f1a7757008b810 Zhangfei Gao       2012-09-03  640  	const struct of_device_id *of_id;
c6da0ba8dfc826 Zhangfei Gao       2012-06-15  641  	struct mmp_tdma_device *tdev;
c6da0ba8dfc826 Zhangfei Gao       2012-06-15  642  	struct resource *iores;
c6da0ba8dfc826 Zhangfei Gao       2012-06-15  643  	int i, ret;
f1a7757008b810 Zhangfei Gao       2012-09-03  644  	int irq = 0, irq_num = 0;
c6da0ba8dfc826 Zhangfei Gao       2012-06-15  645  	int chan_num = TDMA_CHANNEL_NUM;
1eed601a5b02a1 Qiao Zhou          2015-03-03  646  	struct gen_pool *pool = NULL;
c6da0ba8dfc826 Zhangfei Gao       2012-06-15  647  
f1a7757008b810 Zhangfei Gao       2012-09-03  648  	of_id = of_match_device(mmp_tdma_dt_ids, &pdev->dev);
f1a7757008b810 Zhangfei Gao       2012-09-03  649  	if (of_id)
f1a7757008b810 Zhangfei Gao       2012-09-03 @650  		type = (enum mmp_tdma_type) of_id->data;
f1a7757008b810 Zhangfei Gao       2012-09-03  651  	else
f1a7757008b810 Zhangfei Gao       2012-09-03  652  		type = platform_get_device_id(pdev)->driver_data;
f1a7757008b810 Zhangfei Gao       2012-09-03  653  
c6da0ba8dfc826 Zhangfei Gao       2012-06-15  654  	/* always have couple channels */
c6da0ba8dfc826 Zhangfei Gao       2012-06-15  655  	tdev = devm_kzalloc(&pdev->dev, sizeof(*tdev), GFP_KERNEL);
c6da0ba8dfc826 Zhangfei Gao       2012-06-15  656  	if (!tdev)
c6da0ba8dfc826 Zhangfei Gao       2012-06-15  657  		return -ENOMEM;
c6da0ba8dfc826 Zhangfei Gao       2012-06-15  658  
c6da0ba8dfc826 Zhangfei Gao       2012-06-15  659  	tdev->dev = &pdev->dev;
c6da0ba8dfc826 Zhangfei Gao       2012-06-15  660  
f1a7757008b810 Zhangfei Gao       2012-09-03  661  	for (i = 0; i < chan_num; i++) {
f1a7757008b810 Zhangfei Gao       2012-09-03  662  		if (platform_get_irq(pdev, i) > 0)
f1a7757008b810 Zhangfei Gao       2012-09-03  663  			irq_num++;
f1a7757008b810 Zhangfei Gao       2012-09-03  664  	}
c6da0ba8dfc826 Zhangfei Gao       2012-06-15  665  
c6da0ba8dfc826 Zhangfei Gao       2012-06-15  666  	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
7331205a9662a7 Thierry Reding     2013-01-21  667  	tdev->base = devm_ioremap_resource(&pdev->dev, iores);
7331205a9662a7 Thierry Reding     2013-01-21  668  	if (IS_ERR(tdev->base))
7331205a9662a7 Thierry Reding     2013-01-21  669  		return PTR_ERR(tdev->base);
c6da0ba8dfc826 Zhangfei Gao       2012-06-15  670  
f1a7757008b810 Zhangfei Gao       2012-09-03  671  	INIT_LIST_HEAD(&tdev->device.channels);
f1a7757008b810 Zhangfei Gao       2012-09-03  672  
3b0f4a54f247b2 Nenghua Cao        2013-12-13  673  	if (pdev->dev.of_node)
abdd4a7025282f Vladimir Zapolskiy 2015-06-30  674  		pool = of_gen_pool_get(pdev->dev.of_node, "asram", 0);
3b0f4a54f247b2 Nenghua Cao        2013-12-13  675  	else
3b0f4a54f247b2 Nenghua Cao        2013-12-13  676  		pool = sram_get_gpool("asram");
3b0f4a54f247b2 Nenghua Cao        2013-12-13  677  	if (!pool) {
3b0f4a54f247b2 Nenghua Cao        2013-12-13  678  		dev_err(&pdev->dev, "asram pool not available\n");
3b0f4a54f247b2 Nenghua Cao        2013-12-13  679  		return -ENOMEM;
3b0f4a54f247b2 Nenghua Cao        2013-12-13  680  	}
3b0f4a54f247b2 Nenghua Cao        2013-12-13  681  
f1a7757008b810 Zhangfei Gao       2012-09-03  682  	if (irq_num != chan_num) {
f1a7757008b810 Zhangfei Gao       2012-09-03  683  		irq = platform_get_irq(pdev, 0);
f1a7757008b810 Zhangfei Gao       2012-09-03  684  		ret = devm_request_irq(&pdev->dev, irq,
c09a7ce668a666 Lubomir Rintel     2020-06-01  685  			mmp_tdma_int_handler, IRQF_SHARED, "tdma", tdev);
c6da0ba8dfc826 Zhangfei Gao       2012-06-15  686  		if (ret)
c6da0ba8dfc826 Zhangfei Gao       2012-06-15  687  			return ret;
c6da0ba8dfc826 Zhangfei Gao       2012-06-15  688  	}
c6da0ba8dfc826 Zhangfei Gao       2012-06-15  689  
c6da0ba8dfc826 Zhangfei Gao       2012-06-15  690  	/* initialize channel parameters */
c6da0ba8dfc826 Zhangfei Gao       2012-06-15  691  	for (i = 0; i < chan_num; i++) {
f1a7757008b810 Zhangfei Gao       2012-09-03  692  		irq = (irq_num != chan_num) ? 0 : platform_get_irq(pdev, i);
3b0f4a54f247b2 Nenghua Cao        2013-12-13  693  		ret = mmp_tdma_chan_init(tdev, i, irq, type, pool);
c6da0ba8dfc826 Zhangfei Gao       2012-06-15  694  		if (ret)
c6da0ba8dfc826 Zhangfei Gao       2012-06-15  695  			return ret;
c6da0ba8dfc826 Zhangfei Gao       2012-06-15  696  	}
c6da0ba8dfc826 Zhangfei Gao       2012-06-15  697  
f1a7757008b810 Zhangfei Gao       2012-09-03  698  	dma_cap_set(DMA_SLAVE, tdev->device.cap_mask);
f1a7757008b810 Zhangfei Gao       2012-09-03  699  	dma_cap_set(DMA_CYCLIC, tdev->device.cap_mask);
c6da0ba8dfc826 Zhangfei Gao       2012-06-15  700  	tdev->device.dev = &pdev->dev;
c6da0ba8dfc826 Zhangfei Gao       2012-06-15  701  	tdev->device.device_alloc_chan_resources =
c6da0ba8dfc826 Zhangfei Gao       2012-06-15  702  					mmp_tdma_alloc_chan_resources;
c6da0ba8dfc826 Zhangfei Gao       2012-06-15  703  	tdev->device.device_free_chan_resources =
c6da0ba8dfc826 Zhangfei Gao       2012-06-15  704  					mmp_tdma_free_chan_resources;
c6da0ba8dfc826 Zhangfei Gao       2012-06-15  705  	tdev->device.device_prep_dma_cyclic = mmp_tdma_prep_dma_cyclic;
c6da0ba8dfc826 Zhangfei Gao       2012-06-15  706  	tdev->device.device_tx_status = mmp_tdma_tx_status;
c6da0ba8dfc826 Zhangfei Gao       2012-06-15  707  	tdev->device.device_issue_pending = mmp_tdma_issue_pending;
f43a6fd400ba66 Maxime Ripard      2014-11-17  708  	tdev->device.device_config = mmp_tdma_config;
f43a6fd400ba66 Maxime Ripard      2014-11-17  709  	tdev->device.device_pause = mmp_tdma_pause_chan;
f43a6fd400ba66 Maxime Ripard      2014-11-17  710  	tdev->device.device_resume = mmp_tdma_resume_chan;
f43a6fd400ba66 Maxime Ripard      2014-11-17  711  	tdev->device.device_terminate_all = mmp_tdma_terminate_all;
77a68e56aae141 Maxime Ripard      2015-07-20  712  	tdev->device.copy_align = DMAENGINE_ALIGN_8_BYTES;
c6da0ba8dfc826 Zhangfei Gao       2012-06-15  713  
baed6b34ceea87 Lubomir Rintel     2020-04-19  714  	tdev->device.directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
baed6b34ceea87 Lubomir Rintel     2020-04-19  715  	if (type == MMP_AUD_TDMA) {
baed6b34ceea87 Lubomir Rintel     2020-04-19  716  		tdev->device.max_burst = SZ_128;
baed6b34ceea87 Lubomir Rintel     2020-04-19  717  		tdev->device.src_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
baed6b34ceea87 Lubomir Rintel     2020-04-19  718  		tdev->device.dst_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
baed6b34ceea87 Lubomir Rintel     2020-04-19  719  	} else if (type == PXA910_SQU) {
baed6b34ceea87 Lubomir Rintel     2020-04-19  720  		tdev->device.max_burst = SZ_32;
baed6b34ceea87 Lubomir Rintel     2020-04-19  721  	}
baed6b34ceea87 Lubomir Rintel     2020-04-19  722  	tdev->device.residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
baed6b34ceea87 Lubomir Rintel     2020-04-19  723  	tdev->device.descriptor_reuse = true;
baed6b34ceea87 Lubomir Rintel     2020-04-19  724  
c6da0ba8dfc826 Zhangfei Gao       2012-06-15  725  	dma_set_mask(&pdev->dev, DMA_BIT_MASK(64));
c6da0ba8dfc826 Zhangfei Gao       2012-06-15  726  	platform_set_drvdata(pdev, tdev);
c6da0ba8dfc826 Zhangfei Gao       2012-06-15  727  
a5f99a95869e30 Huang Shijie       2018-08-06  728  	ret = dmaenginem_async_device_register(&tdev->device);
c6da0ba8dfc826 Zhangfei Gao       2012-06-15  729  	if (ret) {
c6da0ba8dfc826 Zhangfei Gao       2012-06-15  730  		dev_err(tdev->device.dev, "unable to register\n");
c6da0ba8dfc826 Zhangfei Gao       2012-06-15  731  		return ret;
c6da0ba8dfc826 Zhangfei Gao       2012-06-15  732  	}
c6da0ba8dfc826 Zhangfei Gao       2012-06-15  733  
7dedc002c0ec67 Nenghua Cao        2014-01-20  734  	if (pdev->dev.of_node) {
7dedc002c0ec67 Nenghua Cao        2014-01-20  735  		ret = of_dma_controller_register(pdev->dev.of_node,
7dedc002c0ec67 Nenghua Cao        2014-01-20  736  							mmp_tdma_xlate, tdev);
7dedc002c0ec67 Nenghua Cao        2014-01-20  737  		if (ret) {
7dedc002c0ec67 Nenghua Cao        2014-01-20  738  			dev_err(tdev->device.dev,
7dedc002c0ec67 Nenghua Cao        2014-01-20  739  				"failed to register controller\n");
a5f99a95869e30 Huang Shijie       2018-08-06  740  			return ret;
7dedc002c0ec67 Nenghua Cao        2014-01-20  741  		}
7dedc002c0ec67 Nenghua Cao        2014-01-20  742  	}
7dedc002c0ec67 Nenghua Cao        2014-01-20  743  
c6da0ba8dfc826 Zhangfei Gao       2012-06-15  744  	dev_info(tdev->device.dev, "initialized\n");
c6da0ba8dfc826 Zhangfei Gao       2012-06-15  745  	return 0;
c6da0ba8dfc826 Zhangfei Gao       2012-06-15  746  }
c6da0ba8dfc826 Zhangfei Gao       2012-06-15  747  

:::::: The code at line 650 was first introduced by commit
:::::: f1a7757008b810217b2380d01b740244f21c09bd dmaengine: mmp_tdma: add dt support

:::::: TO: Zhangfei Gao <zhangfei.gao@marvell.com>
:::::: CC: Vinod Koul <vinod.koul@linux.intel.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
