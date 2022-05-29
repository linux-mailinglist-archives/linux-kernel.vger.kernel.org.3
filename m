Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04D13537245
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 21:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbiE2S77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 14:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbiE2S74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 14:59:56 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F2A340E0
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 11:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653850795; x=1685386795;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Zx1HAeSbK0xCGqOD8SoUEzCLApUT2KqRUMybrU473vQ=;
  b=Mvb0JeA7lJVr+SSZGND4DFm23/+QxF2vItsCdrqH61geJjAt80FmA2/7
   C/UlVdFCvrbfsi501EKCQovG7/vP6CXvd/wgOEzk+96FUAAXiUQLbkIlu
   AZmhgUF6Egu8bDEx8oq8PTgYwOkStvzr0C4PR57tazxOceiEPs89KXcIN
   I5HTEhUgQuvmSCWpRPicgpdhGSajVXL7VgYOsuVJoTArbtXzlks66i04p
   opb627wAUvOZt1fLBq7rVI1zuvy3k/svD8vM+ip/i/QTUSNmwnpOgRA2C
   G4qAWwSMH0q4Maf43L4RhoM+7lznOcMze4GsjhNQS2U3vftOBzj7NvwYg
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10362"; a="256894704"
X-IronPort-AV: E=Sophos;i="5.91,260,1647327600"; 
   d="scan'208";a="256894704"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2022 11:59:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,260,1647327600"; 
   d="scan'208";a="632344779"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 29 May 2022 11:59:53 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nvO8m-0001CA-MN;
        Sun, 29 May 2022 18:59:52 +0000
Date:   Mon, 30 May 2022 02:59:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: drivers/usb/host/max3421-hcd.c:1378:1: warning: stack frame size
 (11288) exceeds limit (8192) in 'max3421_spi_thread'
Message-ID: <202205300232.RIbBypzl-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   664a393a2663a0f62fc1b18157ccae33dcdbb8c8
commit: a52f8a59aef46b59753e583bf4b28fccb069ce64 fortify: Explicitly disable Clang support
date:   8 months ago
config: x86_64-randconfig-a012-20220530 (https://download.01.org/0day-ci/archive/20220530/202205300232.RIbBypzl-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0fbe3f3f486e01448121f7931a4ca29fac1504ab)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a52f8a59aef46b59753e583bf4b28fccb069ce64
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout a52f8a59aef46b59753e583bf4b28fccb069ce64
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/usb/host/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/usb/host/max3421-hcd.c:1968:34: warning: unused variable 'max3421_of_match_table' [-Wunused-const-variable]
   static const struct of_device_id max3421_of_match_table[] = {
                                    ^
>> drivers/usb/host/max3421-hcd.c:1378:1: warning: stack frame size (11288) exceeds limit (8192) in 'max3421_spi_thread' [-Wframe-larger-than]
   max3421_spi_thread(void *dev_id)
   ^
   2 warnings generated.


vim +/max3421_spi_thread +1378 drivers/usb/host/max3421-hcd.c

2d53139f31626b David Mosberger      2014-04-28  1376  
2d53139f31626b David Mosberger      2014-04-28  1377  static int
2d53139f31626b David Mosberger      2014-04-28 @1378  max3421_spi_thread(void *dev_id)
2d53139f31626b David Mosberger      2014-04-28  1379  {
2d53139f31626b David Mosberger      2014-04-28  1380  	struct usb_hcd *hcd = dev_id;
2d53139f31626b David Mosberger      2014-04-28  1381  	struct spi_device *spi = to_spi_device(hcd->self.controller);
2d53139f31626b David Mosberger      2014-04-28  1382  	struct max3421_hcd *max3421_hcd = hcd_to_max3421(hcd);
2d53139f31626b David Mosberger      2014-04-28  1383  	int i, i_worked = 1;
2d53139f31626b David Mosberger      2014-04-28  1384  
2d53139f31626b David Mosberger      2014-04-28  1385  	/* set full-duplex SPI mode, low-active interrupt pin: */
2d53139f31626b David Mosberger      2014-04-28  1386  	spi_wr8(hcd, MAX3421_REG_PINCTL,
2d53139f31626b David Mosberger      2014-04-28  1387  		(BIT(MAX3421_PINCTL_FDUPSPI_BIT) |	/* full-duplex */
2d53139f31626b David Mosberger      2014-04-28  1388  		 BIT(MAX3421_PINCTL_INTLEVEL_BIT)));	/* low-active irq */
2d53139f31626b David Mosberger      2014-04-28  1389  
2d53139f31626b David Mosberger      2014-04-28  1390  	while (!kthread_should_stop()) {
2d53139f31626b David Mosberger      2014-04-28  1391  		max3421_hcd->rev = spi_rd8(hcd, MAX3421_REG_REVISION);
2d53139f31626b David Mosberger      2014-04-28  1392  		if (max3421_hcd->rev == 0x12 || max3421_hcd->rev == 0x13)
2d53139f31626b David Mosberger      2014-04-28  1393  			break;
2d53139f31626b David Mosberger      2014-04-28  1394  		dev_err(&spi->dev, "bad rev 0x%02x", max3421_hcd->rev);
2d53139f31626b David Mosberger      2014-04-28  1395  		msleep(10000);
2d53139f31626b David Mosberger      2014-04-28  1396  	}
2d53139f31626b David Mosberger      2014-04-28  1397  	dev_info(&spi->dev, "rev 0x%x, SPI clk %dHz, bpw %u, irq %d\n",
2d53139f31626b David Mosberger      2014-04-28  1398  		 max3421_hcd->rev, spi->max_speed_hz, spi->bits_per_word,
2d53139f31626b David Mosberger      2014-04-28  1399  		 spi->irq);
2d53139f31626b David Mosberger      2014-04-28  1400  
2d53139f31626b David Mosberger      2014-04-28  1401  	while (!kthread_should_stop()) {
2d53139f31626b David Mosberger      2014-04-28  1402  		if (!i_worked) {
2d53139f31626b David Mosberger      2014-04-28  1403  			/*
2d53139f31626b David Mosberger      2014-04-28  1404  			 * We'll be waiting for wakeups from the hard
2d53139f31626b David Mosberger      2014-04-28  1405  			 * interrupt handler, so now is a good time to
2d53139f31626b David Mosberger      2014-04-28  1406  			 * sync our hien with the chip:
2d53139f31626b David Mosberger      2014-04-28  1407  			 */
2d53139f31626b David Mosberger      2014-04-28  1408  			spi_wr8(hcd, MAX3421_REG_HIEN, max3421_hcd->hien);
2d53139f31626b David Mosberger      2014-04-28  1409  
2d53139f31626b David Mosberger      2014-04-28  1410  			set_current_state(TASK_INTERRUPTIBLE);
2eb5dbdd1263a4 David Mosberger-Tang 2014-06-19  1411  			if (test_and_clear_bit(ENABLE_IRQ, &max3421_hcd->todo))
2d53139f31626b David Mosberger      2014-04-28  1412  				enable_irq(spi->irq);
2d53139f31626b David Mosberger      2014-04-28  1413  			schedule();
2d53139f31626b David Mosberger      2014-04-28  1414  			__set_current_state(TASK_RUNNING);
2d53139f31626b David Mosberger      2014-04-28  1415  		}
2d53139f31626b David Mosberger      2014-04-28  1416  
2d53139f31626b David Mosberger      2014-04-28  1417  		i_worked = 0;
2d53139f31626b David Mosberger      2014-04-28  1418  
2d53139f31626b David Mosberger      2014-04-28  1419  		if (max3421_hcd->urb_done)
2d53139f31626b David Mosberger      2014-04-28  1420  			i_worked |= max3421_urb_done(hcd);
2d53139f31626b David Mosberger      2014-04-28  1421  		else if (max3421_handle_irqs(hcd))
2d53139f31626b David Mosberger      2014-04-28  1422  			i_worked = 1;
2d53139f31626b David Mosberger      2014-04-28  1423  		else if (!max3421_hcd->curr_urb)
2d53139f31626b David Mosberger      2014-04-28  1424  			i_worked |= max3421_select_and_start_urb(hcd);
2d53139f31626b David Mosberger      2014-04-28  1425  
2eb5dbdd1263a4 David Mosberger-Tang 2014-06-19  1426  		if (test_and_clear_bit(RESET_HCD, &max3421_hcd->todo))
2d53139f31626b David Mosberger      2014-04-28  1427  			/* reset the HCD: */
2d53139f31626b David Mosberger      2014-04-28  1428  			i_worked |= max3421_reset_hcd(hcd);
2eb5dbdd1263a4 David Mosberger-Tang 2014-06-19  1429  		if (test_and_clear_bit(RESET_PORT, &max3421_hcd->todo)) {
2d53139f31626b David Mosberger      2014-04-28  1430  			/* perform a USB bus reset: */
2d53139f31626b David Mosberger      2014-04-28  1431  			spi_wr8(hcd, MAX3421_REG_HCTL,
2d53139f31626b David Mosberger      2014-04-28  1432  				BIT(MAX3421_HCTL_BUSRST_BIT));
2d53139f31626b David Mosberger      2014-04-28  1433  			i_worked = 1;
2d53139f31626b David Mosberger      2014-04-28  1434  		}
2eb5dbdd1263a4 David Mosberger-Tang 2014-06-19  1435  		if (test_and_clear_bit(CHECK_UNLINK, &max3421_hcd->todo))
2d53139f31626b David Mosberger      2014-04-28  1436  			i_worked |= max3421_check_unlink(hcd);
2eb5dbdd1263a4 David Mosberger-Tang 2014-06-19  1437  		if (test_and_clear_bit(IOPIN_UPDATE, &max3421_hcd->todo)) {
2d53139f31626b David Mosberger      2014-04-28  1438  			/*
2d53139f31626b David Mosberger      2014-04-28  1439  			 * IOPINS1/IOPINS2 do not auto-increment, so we can't
2d53139f31626b David Mosberger      2014-04-28  1440  			 * use spi_wr_buf().
2d53139f31626b David Mosberger      2014-04-28  1441  			 */
2d53139f31626b David Mosberger      2014-04-28  1442  			for (i = 0; i < ARRAY_SIZE(max3421_hcd->iopins); ++i) {
2d53139f31626b David Mosberger      2014-04-28  1443  				u8 val = spi_rd8(hcd, MAX3421_REG_IOPINS1);
2d53139f31626b David Mosberger      2014-04-28  1444  
2d53139f31626b David Mosberger      2014-04-28  1445  				val = ((val & 0xf0) |
2d53139f31626b David Mosberger      2014-04-28  1446  				       (max3421_hcd->iopins[i] & 0x0f));
2d53139f31626b David Mosberger      2014-04-28  1447  				spi_wr8(hcd, MAX3421_REG_IOPINS1 + i, val);
2d53139f31626b David Mosberger      2014-04-28  1448  				max3421_hcd->iopins[i] = val;
2d53139f31626b David Mosberger      2014-04-28  1449  			}
2d53139f31626b David Mosberger      2014-04-28  1450  			i_worked = 1;
2d53139f31626b David Mosberger      2014-04-28  1451  		}
2d53139f31626b David Mosberger      2014-04-28  1452  	}
2d53139f31626b David Mosberger      2014-04-28  1453  	set_current_state(TASK_RUNNING);
2d53139f31626b David Mosberger      2014-04-28  1454  	dev_info(&spi->dev, "SPI thread exiting");
2d53139f31626b David Mosberger      2014-04-28  1455  	return 0;
2d53139f31626b David Mosberger      2014-04-28  1456  }
2d53139f31626b David Mosberger      2014-04-28  1457  

:::::: The code at line 1378 was first introduced by commit
:::::: 2d53139f31626bad6f8983d8e519ddde2cbba921 Add support for using a MAX3421E chip as a host driver.

:::::: TO: David Mosberger <davidm@egauge.net>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
