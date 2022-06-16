Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD9A054DDE3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 11:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376545AbiFPJJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 05:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376510AbiFPJJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 05:09:01 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BCB952E75;
        Thu, 16 Jun 2022 02:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655370536; x=1686906536;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=e39iPjtlH7fcnRcUI8u5CgfpMe1Z/O7RWwUN+TLHuDQ=;
  b=HZfoarxHFcHKdQOdMlcnV30alp0aFQwxcoooE20aZ2/YmpTwrRTbiC7z
   r048ORRFXikxADpMOdtCO57CNHQwoaVdukp388y0Or0/sBCpAZdzZ+tIL
   0IsE2beTdKViZc0LkFRB5eLgqOT7jLdGcqydCHc9DEaLI5msiz+n/slw8
   J9+32LmYo4GAmePYP6boUjucOwBlt739kQWeIxnku1WOXWaMKVYOkt173
   5Fs37SqbdGNAmTgPTO6KZeS2uCOgbw3VdLr/FyDW3gDm1tvVFQlwxaYhQ
   sQ20GDWp7Vic9gy1OK9AFEDdYvy/H5SxUbP7e5d9H6sbIQfw40+IrpBLS
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10379"; a="279263192"
X-IronPort-AV: E=Sophos;i="5.91,304,1647327600"; 
   d="scan'208";a="279263192"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 02:08:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,304,1647327600"; 
   d="scan'208";a="559666393"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 16 Jun 2022 02:08:53 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o1lUi-000OEX-QY;
        Thu, 16 Jun 2022 09:08:52 +0000
Date:   Thu, 16 Jun 2022 17:08:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hongyu Xie <xy521521@gmail.com>, mathias.nyman@intel.com,
        gregkh@linuxfoundation.org
Cc:     kbuild-all@lists.01.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, 125707942@qq.com, wangqi@kylinos.cn,
        xiongxin@kylinos.cn, Hongyu Xie <xiehongyu1@kylinos.cn>
Subject: Re: [PATCH v3 -next] usb: xhci: disable irq during initialization
Message-ID: <202206161602.1Lp2YCz7-lkp@intel.com>
References: <20220616025634.3693260-1-xiehongyu1@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220616025634.3693260-1-xiehongyu1@kylinos.cn>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hongyu,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on next-20220615]

url:    https://github.com/intel-lab-lkp/linux/commits/Hongyu-Xie/usb-xhci-disable-irq-during-initialization/20220616-110418
base:    6012273897fefb12566580efedee10bb06e5e6ed
config: xtensa-allyesconfig (https://download.01.org/0day-ci/archive/20220616/202206161602.1Lp2YCz7-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/b8e08f7da837bf7aff0a032d4dbd6633c5a76f7d
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Hongyu-Xie/usb-xhci-disable-irq-during-initialization/20220616-110418
        git checkout b8e08f7da837bf7aff0a032d4dbd6633c5a76f7d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=xtensa SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/bitops.h:7,
                    from include/linux/log2.h:12,
                    from include/asm-generic/div64.h:55,
                    from ./arch/xtensa/include/generated/asm/div64.h:1,
                    from include/linux/math.h:6,
                    from include/linux/math64.h:6,
                    from include/linux/time64.h:5,
                    from include/linux/restart_block.h:10,
                    from include/linux/thread_info.h:14,
                    from arch/xtensa/include/asm/current.h:18,
                    from include/linux/mutex.h:14,
                    from include/linux/kernfs.h:11,
                    from include/linux/sysfs.h:16,
                    from include/linux/kobject.h:20,
                    from include/linux/pci.h:35,
                    from drivers/usb/host/xhci.c:11:
   drivers/usb/host/xhci.c: In function 'xhci_run_finished':
>> drivers/usb/host/xhci.c:619:40: error: 'flags' undeclared (first use in this function)
     619 |         spin_lock_irqsave(&xhci->lock, flags);
         |                                        ^~~~~
   include/linux/typecheck.h:11:16: note: in definition of macro 'typecheck'
      11 |         typeof(x) __dummy2; \
         |                ^
   include/linux/spinlock.h:390:9: note: in expansion of macro 'raw_spin_lock_irqsave'
     390 |         raw_spin_lock_irqsave(spinlock_check(lock), flags);     \
         |         ^~~~~~~~~~~~~~~~~~~~~
   drivers/usb/host/xhci.c:619:9: note: in expansion of macro 'spin_lock_irqsave'
     619 |         spin_lock_irqsave(&xhci->lock, flags);
         |         ^~~~~~~~~~~~~~~~~
   drivers/usb/host/xhci.c:619:40: note: each undeclared identifier is reported only once for each function it appears in
     619 |         spin_lock_irqsave(&xhci->lock, flags);
         |                                        ^~~~~
   include/linux/typecheck.h:11:16: note: in definition of macro 'typecheck'
      11 |         typeof(x) __dummy2; \
         |                ^
   include/linux/spinlock.h:390:9: note: in expansion of macro 'raw_spin_lock_irqsave'
     390 |         raw_spin_lock_irqsave(spinlock_check(lock), flags);     \
         |         ^~~~~~~~~~~~~~~~~~~~~
   drivers/usb/host/xhci.c:619:9: note: in expansion of macro 'spin_lock_irqsave'
     619 |         spin_lock_irqsave(&xhci->lock, flags);
         |         ^~~~~~~~~~~~~~~~~
   include/linux/typecheck.h:12:25: warning: comparison of distinct pointer types lacks a cast
      12 |         (void)(&__dummy == &__dummy2); \
         |                         ^~
   include/linux/spinlock.h:247:17: note: in expansion of macro 'typecheck'
     247 |                 typecheck(unsigned long, flags);        \
         |                 ^~~~~~~~~
   include/linux/spinlock.h:390:9: note: in expansion of macro 'raw_spin_lock_irqsave'
     390 |         raw_spin_lock_irqsave(spinlock_check(lock), flags);     \
         |         ^~~~~~~~~~~~~~~~~~~~~
   drivers/usb/host/xhci.c:619:9: note: in expansion of macro 'spin_lock_irqsave'
     619 |         spin_lock_irqsave(&xhci->lock, flags);
         |         ^~~~~~~~~~~~~~~~~


vim +/flags +619 drivers/usb/host/xhci.c

   610	
   611	
   612	static int xhci_run_finished(struct xhci_hcd *xhci)
   613	{
   614		u32 temp;
   615	
   616		/* Prevent receiving irqs in the small window between enabling interrupt
   617		 * and setting Run/Stop bit
   618		 */
 > 619		spin_lock_irqsave(&xhci->lock, flags);
   620	
   621		/* Enable interrupt right before setting Run/Stop bit according to spec
   622		 * 4.2
   623		 */
   624		/* Set the HCD state before we enable the irqs */
   625		temp = readl(&xhci->op_regs->command);
   626		temp |= (CMD_EIE);
   627		xhci_dbg_trace(xhci, trace_xhci_dbg_init,
   628				"// Enable interrupts, cmd = 0x%x.", temp);
   629		writel(temp, &xhci->op_regs->command);
   630	
   631		temp = readl(&xhci->ir_set->irq_pending);
   632		xhci_dbg_trace(xhci, trace_xhci_dbg_init,
   633				"// %s %p by writing 0x%x %s",
   634				"Enabling event ring interrupter",
   635				"to irq_pending", xhci->ir_set,
   636				(unsigned int) ER_IRQ_ENABLE(temp));
   637		writel(ER_IRQ_ENABLE(temp), &xhci->ir_set->irq_pending);
   638		if (xhci_start(xhci)) {
   639			xhci_halt(xhci);
   640			spin_unlock_irqrestore(&xhci->lock, flags);
   641			return -ENODEV;
   642		}
   643		xhci->cmd_ring_state = CMD_RING_STATE_RUNNING;
   644	
   645		if (xhci->quirks & XHCI_NEC_HOST)
   646			xhci_ring_cmd_db(xhci);
   647		spin_unlock_irqrestore(&xhci->lock, flags);
   648		return 0;
   649	}
   650	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
