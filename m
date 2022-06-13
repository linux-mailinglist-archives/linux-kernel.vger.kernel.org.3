Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2143A549CCF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 21:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347785AbiFMTEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 15:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348906AbiFMTDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 15:03:52 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325B14BFC0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 09:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655138996; x=1686674996;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=H5TwxtMDpWeb8woE+m1i6Wbe3LB/WLAYIlsXGxdhqcI=;
  b=gIjRiffjSVB+o1qXX1v7bRhdktGnShYkzHqQ/UoHBX7Md22JZtqUT74f
   AwICkGg2pwvKS29RpAfyomXseG9ALIARmJrhX81q1/sb9n5PCAMIk4QRk
   P9/yS/FsMhQcOcc179wufUpKmNTAgxrtagPm7cCFOp/wRbchZUAGj7YSJ
   XrCQ0geySPpovrCytqGjmpFVmmjtfiNSnkd9Txih846jZ80pKzh7ANDKi
   rtJG0vzKwMYAeQQZ2v0ENLLHcpKg/QTAM3faj7/Nm+IHefdPDtEf4/N4+
   vyMVwtCLDYoMPRigIy5pZ8Af7U5DwvAm1G1CSYZMwDb9Z04s6REnxCM3n
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="279067652"
X-IronPort-AV: E=Sophos;i="5.91,297,1647327600"; 
   d="scan'208";a="279067652"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 09:49:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,297,1647327600"; 
   d="scan'208";a="617578863"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 13 Jun 2022 09:49:53 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o0nGD-000Kz3-24;
        Mon, 13 Jun 2022 16:49:53 +0000
Date:   Tue, 14 Jun 2022 00:49:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: drivers/usb/core/hub.c:5565:13: warning: stack frame size (2112)
 exceeds limit (2048) in 'hub_event'
Message-ID: <202206140018.kYHiXZn8-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b13baccc3850ca8b8cccbf8ed9912dbaa0fdf7f3
commit: cf3ee3c8c29dc349b2cf52e5e72e8cb805ff5e57 locking/atomic: add generic arch_*() bitops
date:   11 months ago
config: powerpc64-randconfig-r003-20220613 (https://download.01.org/0day-ci/archive/20220614/202206140018.kYHiXZn8-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d378268ead93c85803c270277f0243737b536ae7)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install powerpc64 cross compiling tool for clang build
        # apt-get install binutils-powerpc64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=cf3ee3c8c29dc349b2cf52e5e72e8cb805ff5e57
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout cf3ee3c8c29dc349b2cf52e5e72e8cb805ff5e57
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/usb/core/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/usb/core/hub.c:23:
   In file included from include/linux/usb.h:16:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/powerpc/include/asm/hardirq.h:6:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/powerpc/include/asm/io.h:619:
   arch/powerpc/include/asm/io-defs.h:45:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   DEF_PCI_AC_NORET(insw, (unsigned long p, void *b, unsigned long c),
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:616:3: note: expanded from macro 'DEF_PCI_AC_NORET'
                   __do_##name al;                                 \
                   ^~~~~~~~~~~~~~
   <scratch space>:87:1: note: expanded from here
   __do_insw
   ^
   arch/powerpc/include/asm/io.h:557:56: note: expanded from macro '__do_insw'
   #define __do_insw(p, b, n)      readsw((PCI_IO_ADDR)_IO_BASE+(p), (b), (n))
                                          ~~~~~~~~~~~~~~~~~~~~~^
   In file included from drivers/usb/core/hub.c:23:
   In file included from include/linux/usb.h:16:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/powerpc/include/asm/hardirq.h:6:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/powerpc/include/asm/io.h:619:
   arch/powerpc/include/asm/io-defs.h:47:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   DEF_PCI_AC_NORET(insl, (unsigned long p, void *b, unsigned long c),
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:616:3: note: expanded from macro 'DEF_PCI_AC_NORET'
                   __do_##name al;                                 \
                   ^~~~~~~~~~~~~~
   <scratch space>:91:1: note: expanded from here
   __do_insl
   ^
   arch/powerpc/include/asm/io.h:558:56: note: expanded from macro '__do_insl'
   #define __do_insl(p, b, n)      readsl((PCI_IO_ADDR)_IO_BASE+(p), (b), (n))
                                          ~~~~~~~~~~~~~~~~~~~~~^
   In file included from drivers/usb/core/hub.c:23:
   In file included from include/linux/usb.h:16:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/powerpc/include/asm/hardirq.h:6:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/powerpc/include/asm/io.h:619:
   arch/powerpc/include/asm/io-defs.h:49:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   DEF_PCI_AC_NORET(outsb, (unsigned long p, const void *b, unsigned long c),
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:616:3: note: expanded from macro 'DEF_PCI_AC_NORET'
                   __do_##name al;                                 \
                   ^~~~~~~~~~~~~~
   <scratch space>:95:1: note: expanded from here
   __do_outsb
   ^
   arch/powerpc/include/asm/io.h:559:58: note: expanded from macro '__do_outsb'
   #define __do_outsb(p, b, n)     writesb((PCI_IO_ADDR)_IO_BASE+(p),(b),(n))
                                           ~~~~~~~~~~~~~~~~~~~~~^
   In file included from drivers/usb/core/hub.c:23:
   In file included from include/linux/usb.h:16:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/powerpc/include/asm/hardirq.h:6:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/powerpc/include/asm/io.h:619:
   arch/powerpc/include/asm/io-defs.h:51:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   DEF_PCI_AC_NORET(outsw, (unsigned long p, const void *b, unsigned long c),
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:616:3: note: expanded from macro 'DEF_PCI_AC_NORET'
                   __do_##name al;                                 \
                   ^~~~~~~~~~~~~~
   <scratch space>:99:1: note: expanded from here
   __do_outsw
   ^
   arch/powerpc/include/asm/io.h:560:58: note: expanded from macro '__do_outsw'
   #define __do_outsw(p, b, n)     writesw((PCI_IO_ADDR)_IO_BASE+(p),(b),(n))
                                           ~~~~~~~~~~~~~~~~~~~~~^
   In file included from drivers/usb/core/hub.c:23:
   In file included from include/linux/usb.h:16:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/powerpc/include/asm/hardirq.h:6:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/powerpc/include/asm/io.h:619:
   arch/powerpc/include/asm/io-defs.h:53:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   DEF_PCI_AC_NORET(outsl, (unsigned long p, const void *b, unsigned long c),
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:616:3: note: expanded from macro 'DEF_PCI_AC_NORET'
                   __do_##name al;                                 \
                   ^~~~~~~~~~~~~~
   <scratch space>:103:1: note: expanded from here
   __do_outsl
   ^
   arch/powerpc/include/asm/io.h:561:58: note: expanded from macro '__do_outsl'
   #define __do_outsl(p, b, n)     writesl((PCI_IO_ADDR)_IO_BASE+(p),(b),(n))
                                           ~~~~~~~~~~~~~~~~~~~~~^
>> drivers/usb/core/hub.c:5565:13: warning: stack frame size (2112) exceeds limit (2048) in 'hub_event' [-Wframe-larger-than]
   static void hub_event(struct work_struct *work)
               ^
   14 warnings generated.


vim +/hub_event +5565 drivers/usb/core/hub.c

714b07be3bbf94 Sarah Sharp      2012-01-24  5564  
32a6958998c52e Petr Mladek      2014-09-19 @5565  static void hub_event(struct work_struct *work)
^1da177e4c3f41 Linus Torvalds   2005-04-16  5566  {
^1da177e4c3f41 Linus Torvalds   2005-04-16  5567  	struct usb_device *hdev;
^1da177e4c3f41 Linus Torvalds   2005-04-16  5568  	struct usb_interface *intf;
^1da177e4c3f41 Linus Torvalds   2005-04-16  5569  	struct usb_hub *hub;
^1da177e4c3f41 Linus Torvalds   2005-04-16  5570  	struct device *hub_dev;
^1da177e4c3f41 Linus Torvalds   2005-04-16  5571  	u16 hubstatus;
^1da177e4c3f41 Linus Torvalds   2005-04-16  5572  	u16 hubchange;
^1da177e4c3f41 Linus Torvalds   2005-04-16  5573  	int i, ret;
^1da177e4c3f41 Linus Torvalds   2005-04-16  5574  
32a6958998c52e Petr Mladek      2014-09-19  5575  	hub = container_of(work, struct usb_hub, events);
5d14f323834eeb Petr Mladek      2014-09-19  5576  	hdev = hub->hdev;
e8054854221d9d Alan Stern       2007-05-04  5577  	hub_dev = hub->intfdev;
e8054854221d9d Alan Stern       2007-05-04  5578  	intf = to_usb_interface(hub_dev);
32a6958998c52e Petr Mladek      2014-09-19  5579  
95d23dc27bde0a Andrey Konovalov 2019-12-04  5580  	kcov_remote_start_usb((u64)hdev->bus->busnum);
95d23dc27bde0a Andrey Konovalov 2019-12-04  5581  
40f122f343797d Alan Stern       2006-11-09  5582  	dev_dbg(hub_dev, "state %d ports %d chg %04x evt %04x\n",
3bbc47d8b07aba Krzysztof Mazur  2013-08-22  5583  			hdev->state, hdev->maxchild,
^1da177e4c3f41 Linus Torvalds   2005-04-16  5584  			/* NOTE: expects max 15 ports... */
^1da177e4c3f41 Linus Torvalds   2005-04-16  5585  			(u16) hub->change_bits[0],
40f122f343797d Alan Stern       2006-11-09  5586  			(u16) hub->event_bits[0]);
^1da177e4c3f41 Linus Torvalds   2005-04-16  5587  
^1da177e4c3f41 Linus Torvalds   2005-04-16  5588  	/* Lock the device, then check to see if we were
^1da177e4c3f41 Linus Torvalds   2005-04-16  5589  	 * disconnected while waiting for the lock to succeed. */
06b84e8adcad82 Alan Stern       2007-05-04  5590  	usb_lock_device(hdev);
e8054854221d9d Alan Stern       2007-05-04  5591  	if (unlikely(hub->disconnected))
32a6958998c52e Petr Mladek      2014-09-19  5592  		goto out_hdev_lock;
^1da177e4c3f41 Linus Torvalds   2005-04-16  5593  
^1da177e4c3f41 Linus Torvalds   2005-04-16  5594  	/* If the hub has died, clean up after it */
^1da177e4c3f41 Linus Torvalds   2005-04-16  5595  	if (hdev->state == USB_STATE_NOTATTACHED) {
7de18d8bf4b470 Alan Stern       2006-06-01  5596  		hub->error = -ENODEV;
4330354f766082 Alan Stern       2008-04-28  5597  		hub_quiesce(hub, HUB_DISCONNECT);
32a6958998c52e Petr Mladek      2014-09-19  5598  		goto out_hdev_lock;
^1da177e4c3f41 Linus Torvalds   2005-04-16  5599  	}
^1da177e4c3f41 Linus Torvalds   2005-04-16  5600  
40f122f343797d Alan Stern       2006-11-09  5601  	/* Autoresume */
40f122f343797d Alan Stern       2006-11-09  5602  	ret = usb_autopm_get_interface(intf);
40f122f343797d Alan Stern       2006-11-09  5603  	if (ret) {
40f122f343797d Alan Stern       2006-11-09  5604  		dev_dbg(hub_dev, "Can't autoresume: %d\n", ret);
32a6958998c52e Petr Mladek      2014-09-19  5605  		goto out_hdev_lock;
40f122f343797d Alan Stern       2006-11-09  5606  	}
a8e7c5653562f8 Alan Stern       2006-07-01  5607  
40f122f343797d Alan Stern       2006-11-09  5608  	/* If this is an inactive hub, do nothing */
^1da177e4c3f41 Linus Torvalds   2005-04-16  5609  	if (hub->quiescing)
eb6e29248714d7 Petr Mladek      2014-09-19  5610  		goto out_autopm;
^1da177e4c3f41 Linus Torvalds   2005-04-16  5611  
^1da177e4c3f41 Linus Torvalds   2005-04-16  5612  	if (hub->error) {
eb6e29248714d7 Petr Mladek      2014-09-19  5613  		dev_dbg(hub_dev, "resetting for error %d\n", hub->error);
^1da177e4c3f41 Linus Torvalds   2005-04-16  5614  
742120c6313865 Ming Lei         2008-06-18  5615  		ret = usb_reset_device(hdev);
^1da177e4c3f41 Linus Torvalds   2005-04-16  5616  		if (ret) {
eb6e29248714d7 Petr Mladek      2014-09-19  5617  			dev_dbg(hub_dev, "error resetting hub: %d\n", ret);
eb6e29248714d7 Petr Mladek      2014-09-19  5618  			goto out_autopm;
^1da177e4c3f41 Linus Torvalds   2005-04-16  5619  		}
^1da177e4c3f41 Linus Torvalds   2005-04-16  5620  
^1da177e4c3f41 Linus Torvalds   2005-04-16  5621  		hub->nerrors = 0;
^1da177e4c3f41 Linus Torvalds   2005-04-16  5622  		hub->error = 0;
^1da177e4c3f41 Linus Torvalds   2005-04-16  5623  	}
^1da177e4c3f41 Linus Torvalds   2005-04-16  5624  
^1da177e4c3f41 Linus Torvalds   2005-04-16  5625  	/* deal with port status changes */
3bbc47d8b07aba Krzysztof Mazur  2013-08-22  5626  	for (i = 1; i <= hdev->maxchild; i++) {
097a155f05e88d Dan Williams     2014-05-20  5627  		struct usb_port *port_dev = hub->ports[i - 1];
^1da177e4c3f41 Linus Torvalds   2005-04-16  5628  
5c79a1e303363d Dan Williams     2014-05-20  5629  		if (test_bit(i, hub->event_bits)
af376a461cf075 Dan Williams     2014-05-20  5630  				|| test_bit(i, hub->change_bits)
5c79a1e303363d Dan Williams     2014-05-20  5631  				|| test_bit(i, hub->wakeup_bits)) {
^1da177e4c3f41 Linus Torvalds   2005-04-16  5632  			/*
097a155f05e88d Dan Williams     2014-05-20  5633  			 * The get_noresume and barrier ensure that if
097a155f05e88d Dan Williams     2014-05-20  5634  			 * the port was in the process of resuming, we
097a155f05e88d Dan Williams     2014-05-20  5635  			 * flush that work and keep the port active for
097a155f05e88d Dan Williams     2014-05-20  5636  			 * the duration of the port_event().  However,
097a155f05e88d Dan Williams     2014-05-20  5637  			 * if the port is runtime pm suspended
097a155f05e88d Dan Williams     2014-05-20  5638  			 * (powered-off), we leave it in that state, run
097a155f05e88d Dan Williams     2014-05-20  5639  			 * an abbreviated port_event(), and move on.
097a155f05e88d Dan Williams     2014-05-20  5640  			 */
097a155f05e88d Dan Williams     2014-05-20  5641  			pm_runtime_get_noresume(&port_dev->dev);
097a155f05e88d Dan Williams     2014-05-20  5642  			pm_runtime_barrier(&port_dev->dev);
5c79a1e303363d Dan Williams     2014-05-20  5643  			usb_lock_port(port_dev);
af376a461cf075 Dan Williams     2014-05-20  5644  			port_event(hub, i);
5c79a1e303363d Dan Williams     2014-05-20  5645  			usb_unlock_port(port_dev);
097a155f05e88d Dan Williams     2014-05-20  5646  			pm_runtime_put_sync(&port_dev->dev);
5e467f6ebab151 Andiry Xu        2011-04-27  5647  		}
f3e94aa15dc3d9 Julius Werner    2013-07-30  5648  	}
5e467f6ebab151 Andiry Xu        2011-04-27  5649  
^1da177e4c3f41 Linus Torvalds   2005-04-16  5650  	/* deal with hub status changes */
^1da177e4c3f41 Linus Torvalds   2005-04-16  5651  	if (test_and_clear_bit(0, hub->event_bits) == 0)
^1da177e4c3f41 Linus Torvalds   2005-04-16  5652  		;	/* do nothing */
^1da177e4c3f41 Linus Torvalds   2005-04-16  5653  	else if (hub_hub_status(hub, &hubstatus, &hubchange) < 0)
^1da177e4c3f41 Linus Torvalds   2005-04-16  5654  		dev_err(hub_dev, "get_hub_status failed\n");
^1da177e4c3f41 Linus Torvalds   2005-04-16  5655  	else {
^1da177e4c3f41 Linus Torvalds   2005-04-16  5656  		if (hubchange & HUB_CHANGE_LOCAL_POWER) {
^1da177e4c3f41 Linus Torvalds   2005-04-16  5657  			dev_dbg(hub_dev, "power change\n");
^1da177e4c3f41 Linus Torvalds   2005-04-16  5658  			clear_hub_feature(hdev, C_HUB_LOCAL_POWER);
55c527187c9d78 Alan Stern       2005-11-23  5659  			if (hubstatus & HUB_STATUS_LOCAL_POWER)
55c527187c9d78 Alan Stern       2005-11-23  5660  				/* FIXME: Is this always true? */
55c527187c9d78 Alan Stern       2005-11-23  5661  				hub->limited_power = 1;
403fae78d73888 jidong xiao      2007-09-14  5662  			else
403fae78d73888 jidong xiao      2007-09-14  5663  				hub->limited_power = 0;
^1da177e4c3f41 Linus Torvalds   2005-04-16  5664  		}
^1da177e4c3f41 Linus Torvalds   2005-04-16  5665  		if (hubchange & HUB_CHANGE_OVERCURRENT) {
752d57a8b7b974 Paul Bolle       2011-03-11  5666  			u16 status = 0;
752d57a8b7b974 Paul Bolle       2011-03-11  5667  			u16 unused;
752d57a8b7b974 Paul Bolle       2011-03-11  5668  
752d57a8b7b974 Paul Bolle       2011-03-11  5669  			dev_dbg(hub_dev, "over-current change\n");
^1da177e4c3f41 Linus Torvalds   2005-04-16  5670  			clear_hub_feature(hdev, C_HUB_OVER_CURRENT);
752d57a8b7b974 Paul Bolle       2011-03-11  5671  			msleep(500);	/* Cool down */
8520f38099ccfd Alan Stern       2008-09-22  5672  			hub_power_on(hub, true);
752d57a8b7b974 Paul Bolle       2011-03-11  5673  			hub_hub_status(hub, &status, &unused);
752d57a8b7b974 Paul Bolle       2011-03-11  5674  			if (status & HUB_STATUS_OVERCURRENT)
eb6e29248714d7 Petr Mladek      2014-09-19  5675  				dev_err(hub_dev, "over-current condition\n");
^1da177e4c3f41 Linus Torvalds   2005-04-16  5676  		}
^1da177e4c3f41 Linus Torvalds   2005-04-16  5677  	}
^1da177e4c3f41 Linus Torvalds   2005-04-16  5678  
eb6e29248714d7 Petr Mladek      2014-09-19  5679  out_autopm:
8e4ceb38eb5bba Alan Stern       2009-12-07  5680  	/* Balance the usb_autopm_get_interface() above */
8e4ceb38eb5bba Alan Stern       2009-12-07  5681  	usb_autopm_put_interface_no_suspend(intf);
32a6958998c52e Petr Mladek      2014-09-19  5682  out_hdev_lock:
^1da177e4c3f41 Linus Torvalds   2005-04-16  5683  	usb_unlock_device(hdev);
^1da177e4c3f41 Linus Torvalds   2005-04-16  5684  
32a6958998c52e Petr Mladek      2014-09-19  5685  	/* Balance the stuff in kick_hub_wq() and allow autosuspend */
32a6958998c52e Petr Mladek      2014-09-19  5686  	usb_autopm_put_interface(intf);
32a6958998c52e Petr Mladek      2014-09-19  5687  	kref_put(&hub->kref, hub_release);
95d23dc27bde0a Andrey Konovalov 2019-12-04  5688  
95d23dc27bde0a Andrey Konovalov 2019-12-04  5689  	kcov_remote_stop();
^1da177e4c3f41 Linus Torvalds   2005-04-16  5690  }
^1da177e4c3f41 Linus Torvalds   2005-04-16  5691  

:::::: The code at line 5565 was first introduced by commit
:::::: 32a6958998c52e2b00c2f6459acf9a1f09f054ad usb: hub: convert khubd into workqueue

:::::: TO: Petr Mladek <pmladek@suse.cz>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
