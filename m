Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96D27538C58
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 09:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244680AbiEaH5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 03:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244669AbiEaH5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 03:57:06 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56D271FCED
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 00:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653983825; x=1685519825;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=mbEQGFWIKh6nQXzuCyrRbduPAjAThuLrxU23QLzRwlY=;
  b=F0ie0fmRDM0eDXHW2VYBzKDJNuSpAFS68xTO1wUYiSZPYkp9EwiOhjtI
   HuVXFTqmVBLFbPXyQkZLXvSllgpdIkYDH+s4eayDens7mr87VBlTE1mhZ
   RYVH5vcHj6NZR1Jhc7caNYY6MkGDiCwsh9wgYF6Ug2lGLHYzkfP384P2B
   NmZA8hYzjImaQLeZSNJVPpTZ5LpPvCsyaTWHCeCsSeCnuMiITwBhfMk/G
   M8GhQ99nvz1Rle/ode5aBttKVJlsbva+q13CVjlUAFf9OAryzLIpFrIlb
   VQxwMQ+ukZb7+6SzZ6IVmYBy8EXB/aGffGfYXOd0UcE3pH4XMSfv8zGGL
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10363"; a="255657659"
X-IronPort-AV: E=Sophos;i="5.91,264,1647327600"; 
   d="scan'208";a="255657659"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2022 00:57:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,264,1647327600"; 
   d="scan'208";a="605542564"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 31 May 2022 00:57:03 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nvwkQ-0002Uo-BQ;
        Tue, 31 May 2022 07:57:02 +0000
Date:   Tue, 31 May 2022 15:56:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: drivers/vlynq/vlynq.c:717:6: warning: variable 'result' is used
 uninitialized whenever 'if' condition is true
Message-ID: <202205311515.i7SmNVZZ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   8ab2afa23bd197df47819a87f0265c0ac95c5b6a
commit: c434b9f80b0923e6460031b0fd964f8b0bf3c6a6 MIPS: Kconfig: add MIPS_GENERIC_KERNEL symbol
date:   1 year, 8 months ago
config: mips-randconfig-c004-20220531 (https://download.01.org/0day-ci/archive/20220531/202205311515.i7SmNVZZ-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c825abd6b0198fb088d9752f556a70705bc99dfd)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mipsel-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c434b9f80b0923e6460031b0fd964f8b0bf3c6a6
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout c434b9f80b0923e6460031b0fd964f8b0bf3c6a6
        # save the config file
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross 

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/vlynq/vlynq.c:717:6: warning: variable 'result' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
           if (device_register(&dev->dev))
               ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/vlynq/vlynq.c:743:9: note: uninitialized use occurs here
           return result;
                  ^~~~~~
   drivers/vlynq/vlynq.c:717:2: note: remove the 'if' if its condition is always false
           if (device_register(&dev->dev))
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/vlynq/vlynq.c:659:17: note: initialize the variable 'result' to silence this warning
           int len, result;
                          ^
                           = 0
   1 warning generated.


vim +717 drivers/vlynq/vlynq.c

55e331cf7ebe20 Florian Fainelli 2009-06-16  654  
55e331cf7ebe20 Florian Fainelli 2009-06-16  655  static int vlynq_probe(struct platform_device *pdev)
55e331cf7ebe20 Florian Fainelli 2009-06-16  656  {
55e331cf7ebe20 Florian Fainelli 2009-06-16  657  	struct vlynq_device *dev;
55e331cf7ebe20 Florian Fainelli 2009-06-16  658  	struct resource *regs_res, *mem_res, *irq_res;
55e331cf7ebe20 Florian Fainelli 2009-06-16  659  	int len, result;
55e331cf7ebe20 Florian Fainelli 2009-06-16  660  
55e331cf7ebe20 Florian Fainelli 2009-06-16  661  	regs_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "regs");
55e331cf7ebe20 Florian Fainelli 2009-06-16  662  	if (!regs_res)
55e331cf7ebe20 Florian Fainelli 2009-06-16  663  		return -ENODEV;
55e331cf7ebe20 Florian Fainelli 2009-06-16  664  
55e331cf7ebe20 Florian Fainelli 2009-06-16  665  	mem_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "mem");
55e331cf7ebe20 Florian Fainelli 2009-06-16  666  	if (!mem_res)
55e331cf7ebe20 Florian Fainelli 2009-06-16  667  		return -ENODEV;
55e331cf7ebe20 Florian Fainelli 2009-06-16  668  
55e331cf7ebe20 Florian Fainelli 2009-06-16  669  	irq_res = platform_get_resource_byname(pdev, IORESOURCE_IRQ, "devirq");
55e331cf7ebe20 Florian Fainelli 2009-06-16  670  	if (!irq_res)
55e331cf7ebe20 Florian Fainelli 2009-06-16  671  		return -ENODEV;
55e331cf7ebe20 Florian Fainelli 2009-06-16  672  
55e331cf7ebe20 Florian Fainelli 2009-06-16  673  	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
55e331cf7ebe20 Florian Fainelli 2009-06-16  674  	if (!dev) {
55e331cf7ebe20 Florian Fainelli 2009-06-16  675  		printk(KERN_ERR
55e331cf7ebe20 Florian Fainelli 2009-06-16  676  		       "vlynq: failed to allocate device structure\n");
55e331cf7ebe20 Florian Fainelli 2009-06-16  677  		return -ENOMEM;
55e331cf7ebe20 Florian Fainelli 2009-06-16  678  	}
55e331cf7ebe20 Florian Fainelli 2009-06-16  679  
55e331cf7ebe20 Florian Fainelli 2009-06-16  680  	dev->id = pdev->id;
55e331cf7ebe20 Florian Fainelli 2009-06-16  681  	dev->dev.bus = &vlynq_bus_type;
55e331cf7ebe20 Florian Fainelli 2009-06-16  682  	dev->dev.parent = &pdev->dev;
55e331cf7ebe20 Florian Fainelli 2009-06-16  683  	dev_set_name(&dev->dev, "vlynq%d", dev->id);
55e331cf7ebe20 Florian Fainelli 2009-06-16  684  	dev->dev.platform_data = pdev->dev.platform_data;
55e331cf7ebe20 Florian Fainelli 2009-06-16  685  	dev->dev.release = vlynq_device_release;
55e331cf7ebe20 Florian Fainelli 2009-06-16  686  
55e331cf7ebe20 Florian Fainelli 2009-06-16  687  	dev->regs_start = regs_res->start;
55e331cf7ebe20 Florian Fainelli 2009-06-16  688  	dev->regs_end = regs_res->end;
55e331cf7ebe20 Florian Fainelli 2009-06-16  689  	dev->mem_start = mem_res->start;
55e331cf7ebe20 Florian Fainelli 2009-06-16  690  	dev->mem_end = mem_res->end;
55e331cf7ebe20 Florian Fainelli 2009-06-16  691  
3354f73b24c6d3 Julia Lawall     2009-09-23  692  	len = resource_size(regs_res);
55e331cf7ebe20 Florian Fainelli 2009-06-16  693  	if (!request_mem_region(regs_res->start, len, dev_name(&dev->dev))) {
55e331cf7ebe20 Florian Fainelli 2009-06-16  694  		printk(KERN_ERR "%s: Can't request vlynq registers\n",
55e331cf7ebe20 Florian Fainelli 2009-06-16  695  		       dev_name(&dev->dev));
55e331cf7ebe20 Florian Fainelli 2009-06-16  696  		result = -ENXIO;
55e331cf7ebe20 Florian Fainelli 2009-06-16  697  		goto fail_request;
55e331cf7ebe20 Florian Fainelli 2009-06-16  698  	}
55e331cf7ebe20 Florian Fainelli 2009-06-16  699  
55e331cf7ebe20 Florian Fainelli 2009-06-16  700  	dev->local = ioremap(regs_res->start, len);
55e331cf7ebe20 Florian Fainelli 2009-06-16  701  	if (!dev->local) {
55e331cf7ebe20 Florian Fainelli 2009-06-16  702  		printk(KERN_ERR "%s: Can't remap vlynq registers\n",
55e331cf7ebe20 Florian Fainelli 2009-06-16  703  		       dev_name(&dev->dev));
55e331cf7ebe20 Florian Fainelli 2009-06-16  704  		result = -ENXIO;
55e331cf7ebe20 Florian Fainelli 2009-06-16  705  		goto fail_remap;
55e331cf7ebe20 Florian Fainelli 2009-06-16  706  	}
55e331cf7ebe20 Florian Fainelli 2009-06-16  707  
55e331cf7ebe20 Florian Fainelli 2009-06-16  708  	dev->remote = (struct vlynq_regs *)((void *)dev->local +
55e331cf7ebe20 Florian Fainelli 2009-06-16  709  					    VLYNQ_REMOTE_OFFSET);
55e331cf7ebe20 Florian Fainelli 2009-06-16  710  
55e331cf7ebe20 Florian Fainelli 2009-06-16  711  	dev->irq = platform_get_irq_byname(pdev, "irq");
55e331cf7ebe20 Florian Fainelli 2009-06-16  712  	dev->irq_start = irq_res->start;
55e331cf7ebe20 Florian Fainelli 2009-06-16  713  	dev->irq_end = irq_res->end;
55e331cf7ebe20 Florian Fainelli 2009-06-16  714  	dev->local_irq = dev->irq_end - dev->irq_start;
55e331cf7ebe20 Florian Fainelli 2009-06-16  715  	dev->remote_irq = dev->local_irq - 1;
55e331cf7ebe20 Florian Fainelli 2009-06-16  716  
55e331cf7ebe20 Florian Fainelli 2009-06-16 @717  	if (device_register(&dev->dev))
55e331cf7ebe20 Florian Fainelli 2009-06-16  718  		goto fail_register;
55e331cf7ebe20 Florian Fainelli 2009-06-16  719  	platform_set_drvdata(pdev, dev);
55e331cf7ebe20 Florian Fainelli 2009-06-16  720  
55e331cf7ebe20 Florian Fainelli 2009-06-16  721  	printk(KERN_INFO "%s: regs 0x%p, irq %d, mem 0x%p\n",
55e331cf7ebe20 Florian Fainelli 2009-06-16  722  	       dev_name(&dev->dev), (void *)dev->regs_start, dev->irq,
55e331cf7ebe20 Florian Fainelli 2009-06-16  723  	       (void *)dev->mem_start);
55e331cf7ebe20 Florian Fainelli 2009-06-16  724  
55e331cf7ebe20 Florian Fainelli 2009-06-16  725  	dev->dev_id = 0;
55e331cf7ebe20 Florian Fainelli 2009-06-16  726  	dev->divisor = vlynq_div_auto;
55e331cf7ebe20 Florian Fainelli 2009-06-16  727  	result = __vlynq_enable_device(dev);
55e331cf7ebe20 Florian Fainelli 2009-06-16  728  	if (result == 0) {
55e331cf7ebe20 Florian Fainelli 2009-06-16  729  		dev->dev_id = readl(&dev->remote->chip);
55e331cf7ebe20 Florian Fainelli 2009-06-16  730  		((struct plat_vlynq_ops *)(dev->dev.platform_data))->off(dev);
55e331cf7ebe20 Florian Fainelli 2009-06-16  731  	}
55e331cf7ebe20 Florian Fainelli 2009-06-16  732  	if (dev->dev_id)
55e331cf7ebe20 Florian Fainelli 2009-06-16  733  		printk(KERN_INFO "Found a VLYNQ device: %08x\n", dev->dev_id);
55e331cf7ebe20 Florian Fainelli 2009-06-16  734  
55e331cf7ebe20 Florian Fainelli 2009-06-16  735  	return 0;
55e331cf7ebe20 Florian Fainelli 2009-06-16  736  
55e331cf7ebe20 Florian Fainelli 2009-06-16  737  fail_register:
55e331cf7ebe20 Florian Fainelli 2009-06-16  738  	iounmap(dev->local);
55e331cf7ebe20 Florian Fainelli 2009-06-16  739  fail_remap:
55e331cf7ebe20 Florian Fainelli 2009-06-16  740  fail_request:
55e331cf7ebe20 Florian Fainelli 2009-06-16  741  	release_mem_region(regs_res->start, len);
55e331cf7ebe20 Florian Fainelli 2009-06-16  742  	kfree(dev);
55e331cf7ebe20 Florian Fainelli 2009-06-16  743  	return result;
55e331cf7ebe20 Florian Fainelli 2009-06-16  744  }
55e331cf7ebe20 Florian Fainelli 2009-06-16  745  

:::::: The code at line 717 was first introduced by commit
:::::: 55e331cf7ebe20665253770589cd9eb06048bf25 drivers: add support for the TI VLYNQ bus

:::::: TO: Florian Fainelli <florian@openwrt.org>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
