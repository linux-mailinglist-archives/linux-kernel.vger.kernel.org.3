Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35BEA5173E9
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 18:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378574AbiEBQPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 12:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381745AbiEBQPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 12:15:13 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28EC4DF46
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 09:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651507904; x=1683043904;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=5RkFu7RGdekF8YRk+MaXd9FdONacRRdqciWJdrkldEc=;
  b=CF55sLDE+LlTahWHJPHegIHpKJrtYgbqP9YbkVjOZ0ei5qgxflZpPKQ3
   UtaxDNFA40xEuyJql58aWyY/Vi6P8EZzUlB2TXvlVL/utrPDgFlz7Oakx
   uuYBDeuqiq6C1Gt3+cPlL+CCElL9CAZbOJlhDgi82Ez8Zg20W4QOh+8d6
   tE4I9wOxvLjv3WJHP2U3At049rOdpnp6NMJxgt7eM/fEL/wRa8wCKv+dX
   TIIyCsnBVrZPn4DdNIq416oM09vAtv9dY6pVXSB3Pu+O4w27WJo6xrhPS
   taHpqKV1mkujYodFBmLCWM/aa1DpTWCB5blUDCYa3NS6gZyIytc0BIZGn
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10335"; a="330241762"
X-IronPort-AV: E=Sophos;i="5.91,192,1647327600"; 
   d="scan'208";a="330241762"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 09:11:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,192,1647327600"; 
   d="scan'208";a="652880913"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 02 May 2022 09:11:40 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nlYeC-0009g3-4q;
        Mon, 02 May 2022 16:11:40 +0000
Date:   Tue, 3 May 2022 00:11:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     John Efstathiades <john.efstathiades@pebblebay.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/net/usb/lan78xx.c:4573:8: warning: Local variable 'ret'
 shadows outer variable [shadowVariable]
Message-ID: <202205030045.IFzrRoky-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   672c0c5173427e6b3e2a9bbb7be51ceeec78093a
commit: 5f4cc6e25148cc141f97afb41b4dfe9eb1cce613 lan78xx: Fix race conditions in suspend/resume handling
date:   8 months ago
compiler: arc-elf-gcc (GCC) 11.3.0
reproduce (cppcheck warning):
        # apt-get install cppcheck
        git checkout 5f4cc6e25148cc141f97afb41b4dfe9eb1cce613
        cppcheck --quiet --enable=style,performance,portability --template=gcc FILE

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cppcheck warnings: (new ones prefixed by >>)
        ^
   drivers/net/usb/lan78xx.c:1873:6: note: ret is overwritten
    ret = lan78xx_write_reg(dev, MII_ACC, addr);
        ^
   drivers/net/usb/lan78xx.c:1131:7: warning: Local variable 'i' shadows outer variable [shadowVariable]
     int i;
         ^
   drivers/net/usb/lan78xx.c:1100:6: note: Shadowed declaration
    int i;
        ^
   drivers/net/usb/lan78xx.c:1131:7: note: Shadow variable
     int i;
         ^
>> drivers/net/usb/lan78xx.c:4573:8: warning: Local variable 'ret' shadows outer variable [shadowVariable]
      int ret = usb_submit_urb(dev->urb_intr, GFP_KERNEL);
          ^
   drivers/net/usb/lan78xx.c:4557:6: note: Shadowed declaration
    int ret;
        ^
   drivers/net/usb/lan78xx.c:4573:8: note: Shadow variable
      int ret = usb_submit_urb(dev->urb_intr, GFP_KERNEL);
          ^

cppcheck possible warnings: (new ones prefixed by >>, may not real problems)

        ^
   drivers/net/usb/lan78xx.c:1873:6: note: ret is overwritten
    ret = lan78xx_write_reg(dev, MII_ACC, addr);
        ^
>> drivers/net/usb/lan78xx.c:1048:23: warning: Parameter 'addr' can be declared with const [constParameter]
           int index, u8 addr[ETH_ALEN])
                         ^
>> drivers/net/usb/lan78xx.c:793:25: warning: Parameter 'data' can be declared with const [constParameter]
           u32 length, u8 *data)
                           ^

vim +/ret +4573 drivers/net/usb/lan78xx.c

  4552	
  4553	static int lan78xx_resume(struct usb_interface *intf)
  4554	{
  4555		struct lan78xx_net *dev = usb_get_intfdata(intf);
  4556		bool dev_open;
  4557		int ret;
  4558	
  4559		mutex_lock(&dev->dev_mutex);
  4560	
  4561		netif_dbg(dev, ifup, dev->net, "resuming device");
  4562	
  4563		dev_open = test_bit(EVENT_DEV_OPEN, &dev->flags);
  4564	
  4565		if (dev_open) {
  4566			bool pipe_halted = false;
  4567	
  4568			ret = lan78xx_flush_tx_fifo(dev);
  4569			if (ret < 0)
  4570				goto out;
  4571	
  4572			if (dev->urb_intr) {
> 4573				int ret = usb_submit_urb(dev->urb_intr, GFP_KERNEL);
  4574	
  4575				if (ret < 0) {
  4576					if (ret == -ENODEV)
  4577						netif_device_detach(dev->net);
  4578	
  4579				netdev_warn(dev->net, "Failed to submit intr URB");
  4580				}
  4581			}
  4582	
  4583			spin_lock_irq(&dev->txq.lock);
  4584	
  4585			if (netif_device_present(dev->net)) {
  4586				pipe_halted = lan78xx_submit_deferred_urbs(dev);
  4587	
  4588				if (pipe_halted)
  4589					lan78xx_defer_kevent(dev, EVENT_TX_HALT);
  4590			}
  4591	
  4592			clear_bit(EVENT_DEV_ASLEEP, &dev->flags);
  4593	
  4594			spin_unlock_irq(&dev->txq.lock);
  4595	
  4596			if (!pipe_halted &&
  4597			    netif_device_present(dev->net) &&
  4598			    (skb_queue_len(&dev->txq) < dev->tx_qlen))
  4599				netif_start_queue(dev->net);
  4600	
  4601			ret = lan78xx_start_tx_path(dev);
  4602			if (ret < 0)
  4603				goto out;
  4604	
  4605			tasklet_schedule(&dev->bh);
  4606	
  4607			if (!timer_pending(&dev->stat_monitor)) {
  4608				dev->delta = 1;
  4609				mod_timer(&dev->stat_monitor,
  4610					  jiffies + STAT_UPDATE_TIMER);
  4611			}
  4612	
  4613		} else {
  4614			clear_bit(EVENT_DEV_ASLEEP, &dev->flags);
  4615		}
  4616	
  4617		ret = lan78xx_write_reg(dev, WUCSR2, 0);
  4618		if (ret < 0)
  4619			goto out;
  4620		ret = lan78xx_write_reg(dev, WUCSR, 0);
  4621		if (ret < 0)
  4622			goto out;
  4623		ret = lan78xx_write_reg(dev, WK_SRC, 0xFFF1FF1FUL);
  4624		if (ret < 0)
  4625			goto out;
  4626	
  4627		ret = lan78xx_write_reg(dev, WUCSR2, WUCSR2_NS_RCD_ |
  4628						     WUCSR2_ARP_RCD_ |
  4629						     WUCSR2_IPV6_TCPSYN_RCD_ |
  4630						     WUCSR2_IPV4_TCPSYN_RCD_);
  4631		if (ret < 0)
  4632			goto out;
  4633	
  4634		ret = lan78xx_write_reg(dev, WUCSR, WUCSR_EEE_TX_WAKE_ |
  4635						    WUCSR_EEE_RX_WAKE_ |
  4636						    WUCSR_PFDA_FR_ |
  4637						    WUCSR_RFE_WAKE_FR_ |
  4638						    WUCSR_WUFR_ |
  4639						    WUCSR_MPR_ |
  4640						    WUCSR_BCST_FR_);
  4641		if (ret < 0)
  4642			goto out;
  4643	
  4644		ret = 0;
  4645	out:
  4646		mutex_unlock(&dev->dev_mutex);
  4647	
  4648		return ret;
  4649	}
  4650	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
