Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CBDC58B415
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 08:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241668AbiHFGow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 02:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbiHFGou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 02:44:50 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78AB013F9D
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 23:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659768289; x=1691304289;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ry3VHPtJUq9DRVufUAgbwlmSsBxKa0FV3P1BsOxRPbU=;
  b=frLLv2Sdpdn3FE+V1t1FKrgOuEjnvRxPMYj533C2etTF/SzRBFaAkk/b
   BrKCE1FUrje2ShP++ut4EYche7UIDrn6pZbQt7oouW9LnEq+2BTexcJ1S
   0Ny3F2zLz2w9dLIdsN5S4beL/tc7doeqGCW9NVxblG7X/JO3Vt4b5Qoxr
   s1Bzz9wreRgJ0KS1eb402ipYSOQVHhFNKU8GkXrcGuPPveKh6K0eHpzyb
   vAU/iqTUnLzpp5Q9u9v31CSSz9+zg28oEO+REcNH6OXPi0ZQUwrXq0lE1
   ZIu4UmpBUnqmRW2uKYucbDVV5BmGje6VzAOAFTcssMlvpHRUG5Nqp/HP2
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10430"; a="291119704"
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="291119704"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 23:44:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="554359876"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 05 Aug 2022 23:44:47 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oKDYF-000K7z-0m;
        Sat, 06 Aug 2022 06:44:47 +0000
Date:   Sat, 6 Aug 2022 14:43:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [ambarus:at-hdmac-virt-dma-for-mainline 19/24]
 drivers/dma/at_hdmac.c:2484:1-6: WARNING: invalid free of devm_ allocated
 data
Message-ID: <202208061445.5jD7uQha-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ambarus/linux-0day at-hdmac-virt-dma-for-mainline
head:   71023d1cc2a923b031eda6f5002704e88c52d9bf
commit: 97345ba39da3b6afa4bebc4354a884ac7cbf550b [19/24] dmaengine: at_hdmac: Use devm_kzalloc() and struct_size()
config: arm-randconfig-c043-20220805 (https://download.01.org/0day-ci/archive/20220806/202208061445.5jD7uQha-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

cocci warnings: (new ones prefixed by >>)
>> drivers/dma/at_hdmac.c:2484:1-6: WARNING: invalid free of devm_ allocated data

vim +2484 drivers/dma/at_hdmac.c

dc78baa2b90b28 Nicolas Ferre     2009-07-03  2448  
1d1bbd305a7831 Maxin B. John     2013-02-20  2449  static int at_dma_remove(struct platform_device *pdev)
dc78baa2b90b28 Nicolas Ferre     2009-07-03  2450  {
dc78baa2b90b28 Nicolas Ferre     2009-07-03  2451  	struct at_dma		*atdma = platform_get_drvdata(pdev);
dc78baa2b90b28 Nicolas Ferre     2009-07-03  2452  	struct dma_chan		*chan, *_chan;
dc78baa2b90b28 Nicolas Ferre     2009-07-03  2453  	struct resource		*io;
dc78baa2b90b28 Nicolas Ferre     2009-07-03  2454  
dc78baa2b90b28 Nicolas Ferre     2009-07-03  2455  	at_dma_off(atdma);
77e75fda94d2eb Richard Genoud    2018-11-27  2456  	if (pdev->dev.of_node)
77e75fda94d2eb Richard Genoud    2018-11-27  2457  		of_dma_controller_free(pdev->dev.of_node);
13ec2a5d2d98bb Tudor Ambarus     2022-07-04  2458  	dma_async_device_unregister(&atdma->dma_device);
dc78baa2b90b28 Nicolas Ferre     2009-07-03  2459  
4d112426c3446d Maxime Ripard     2015-08-24  2460  	dma_pool_destroy(atdma->memset_pool);
dc78baa2b90b28 Nicolas Ferre     2009-07-03  2461  	dma_pool_destroy(atdma->dma_desc_pool);
dc78baa2b90b28 Nicolas Ferre     2009-07-03  2462  	free_irq(platform_get_irq(pdev, 0), atdma);
dc78baa2b90b28 Nicolas Ferre     2009-07-03  2463  
13ec2a5d2d98bb Tudor Ambarus     2022-07-04  2464  	list_for_each_entry_safe(chan, _chan, &atdma->dma_device.channels,
dc78baa2b90b28 Nicolas Ferre     2009-07-03  2465  			device_node) {
dc78baa2b90b28 Nicolas Ferre     2009-07-03  2466  		struct at_dma_chan	*atchan = to_at_dma_chan(chan);
dc78baa2b90b28 Nicolas Ferre     2009-07-03  2467  
dc78baa2b90b28 Nicolas Ferre     2009-07-03  2468  		/* Disable interrupts */
bda3a47c886664 Nikolaus Voss     2012-01-17  2469  		atc_disable_chan_irq(atdma, chan->chan_id);
dc78baa2b90b28 Nicolas Ferre     2009-07-03  2470  
dc78baa2b90b28 Nicolas Ferre     2009-07-03  2471  		tasklet_kill(&atchan->tasklet);
dc78baa2b90b28 Nicolas Ferre     2009-07-03  2472  		list_del(&chan->device_node);
dc78baa2b90b28 Nicolas Ferre     2009-07-03  2473  	}
dc78baa2b90b28 Nicolas Ferre     2009-07-03  2474  
f784d9c90469d7 Boris Brezillon   2013-06-19  2475  	clk_disable_unprepare(atdma->clk);
dc78baa2b90b28 Nicolas Ferre     2009-07-03  2476  	clk_put(atdma->clk);
dc78baa2b90b28 Nicolas Ferre     2009-07-03  2477  
dc78baa2b90b28 Nicolas Ferre     2009-07-03  2478  	iounmap(atdma->regs);
dc78baa2b90b28 Nicolas Ferre     2009-07-03  2479  	atdma->regs = NULL;
dc78baa2b90b28 Nicolas Ferre     2009-07-03  2480  
dc78baa2b90b28 Nicolas Ferre     2009-07-03  2481  	io = platform_get_resource(pdev, IORESOURCE_MEM, 0);
114df7d66efd5c H Hartley Sweeten 2011-06-01  2482  	release_mem_region(io->start, resource_size(io));
dc78baa2b90b28 Nicolas Ferre     2009-07-03  2483  
dc78baa2b90b28 Nicolas Ferre     2009-07-03 @2484  	kfree(atdma);
dc78baa2b90b28 Nicolas Ferre     2009-07-03  2485  
dc78baa2b90b28 Nicolas Ferre     2009-07-03  2486  	return 0;
dc78baa2b90b28 Nicolas Ferre     2009-07-03  2487  }
dc78baa2b90b28 Nicolas Ferre     2009-07-03  2488  

:::::: The code at line 2484 was first introduced by commit
:::::: dc78baa2b90b289590911b40b6800f77d0dc935a dmaengine: at_hdmac: new driver for the Atmel AHB DMA Controller

:::::: TO: Nicolas Ferre <nicolas.ferre@atmel.com>
:::::: CC: Dan Williams <dan.j.williams@intel.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
