Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1C54AA6A9
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 05:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379306AbiBEEvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 23:51:15 -0500
Received: from mga04.intel.com ([192.55.52.120]:8455 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232114AbiBEEvN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 23:51:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644036673; x=1675572673;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YBBQd19d8jkfz7lCEDb9wPwxNxhGt4PX9eI0f7VdM9Q=;
  b=Xai95qFLHKhV2KK4kWNTr3gwbECekJ9sFKPyxtHxApogXHtiUaWcAE27
   js7GLXcDpUhu1bIXdK73Pnf5xqaj6qHpoUWAwPcEFdXRzqUpAAZRUEgsf
   jBK60MXUVEic1XY+0Vq3uLQYmHz58zspjhuBZ+yoTb/LDlpRLmQfOm9WN
   Llfg5GhTYRc5Yxkm96pC2FpVwLvtS4oVJI+OIWef2rRTte2ORbeMxaT2M
   c/DOGDfKkLCpQeYfkKZ7IdSSbeTgAnws9ytGGSZeiax5L0h7MoLt59GGO
   XAd0yqzvqs3Z7EhpM7m5dOWQ6oYoC+Duzp85BnniHOVgedxL60Bn/t375
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10248"; a="247320741"
X-IronPort-AV: E=Sophos;i="5.88,344,1635231600"; 
   d="scan'208";a="247320741"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 20:51:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,344,1635231600"; 
   d="scan'208";a="584331719"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 04 Feb 2022 20:51:12 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nGD2V-000YbR-Il; Sat, 05 Feb 2022 04:51:11 +0000
Date:   Sat, 5 Feb 2022 12:51:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Russell King <rmk+kernel@arm.linux.org.uk>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Subject: [rmk-arm:clearfog 9/10] drivers/pci/pcie/portdrv_core.c:329
 pcie_port_device_register() warn: inconsistent indenting
Message-ID: <202202051233.wNW2l14n-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.armlinux.org.uk/~rmk/linux-arm clearfog
head:   76e9a0db445a3fdaa7685fe133a55673c94e9b5e
commit: 9d274182feb7642db60ac4b713ac6572b5dbd04b [9/10] mvebu/clearfog pcie updates
config: i386-randconfig-m021-20220131 (https://download.01.org/0day-ci/archive/20220205/202202051233.wNW2l14n-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

New smatch warnings:
drivers/pci/pcie/portdrv_core.c:329 pcie_port_device_register() warn: inconsistent indenting

Old smatch warnings:
drivers/pci/pcie/portdrv_core.c:355 pcie_port_device_register() warn: inconsistent indenting

vim +329 drivers/pci/pcie/portdrv_core.c

   307	
   308	/**
   309	 * pcie_port_device_register - register PCI Express port
   310	 * @dev: PCI Express port to register
   311	 *
   312	 * Allocate the port extension structure and register services associated with
   313	 * the port.
   314	 */
   315	int pcie_port_device_register(struct pci_dev *dev)
   316	{
   317		int status, capabilities, irq_services, i, nr_service;
   318		int irqs[PCIE_PORT_DEVICE_MAXSERVICES] = {
   319			[0 ... PCIE_PORT_DEVICE_MAXSERVICES-1] = -1
   320		};
   321	
   322		/* Enable PCI Express port device */
   323		status = pci_enable_device(dev);
   324		if (status)
   325			return status;
   326	
   327		/* Get and check PCI Express port services */
   328		capabilities = get_port_device_capability(dev);
 > 329	dev_info(&dev->dev, "PCIe capabilities: 0x%x\n", capabilities);
   330		if (!capabilities)
   331			return 0;
   332	
   333		pci_set_master(dev);
   334	
   335		irq_services = 0;
   336		if (IS_ENABLED(CONFIG_PCIE_PME))
   337			irq_services |= PCIE_PORT_SERVICE_PME;
   338		if (IS_ENABLED(CONFIG_PCIEAER))
   339			irq_services |= PCIE_PORT_SERVICE_AER;
   340		if (IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE))
   341			irq_services |= PCIE_PORT_SERVICE_HP;
   342		if (IS_ENABLED(CONFIG_PCIE_DPC))
   343			irq_services |= PCIE_PORT_SERVICE_DPC;
   344		irq_services &= capabilities;
   345	
   346		if (irq_services) {
   347			/*
   348			 * Initialize service IRQs. Don't use service devices that
   349			 * require interrupts if there is no way to generate them.
   350			 * However, some drivers may have a polling mode (e.g.
   351			 * pciehp_poll_mode) that can be used in the absence of IRQs.
   352			 * Allow them to determine if that is to be used.
   353			 */
   354			status = pcie_init_service_irqs(dev, irqs, irq_services);
   355	dev_info(&dev->dev, "init_service_irqs: %d\n", status);
   356			if (status) {
   357				irq_services &= PCIE_PORT_SERVICE_HP;
   358				if (!irq_services)
   359					goto error_disable;
   360			}
   361		}
   362	
   363		/* Allocate child services if any */
   364		status = -ENODEV;
   365		nr_service = 0;
   366		for (i = 0; i < PCIE_PORT_DEVICE_MAXSERVICES; i++) {
   367			int service = 1 << i;
   368			if (!(capabilities & service))
   369				continue;
   370			if (!pcie_device_init(dev, service, irqs[i]))
   371				nr_service++;
   372		}
   373		if (!nr_service)
   374			goto error_cleanup_irqs;
   375	
   376		return 0;
   377	
   378	error_cleanup_irqs:
   379		pci_free_irq_vectors(dev);
   380	error_disable:
   381		pci_disable_device(dev);
   382		return status;
   383	}
   384	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
