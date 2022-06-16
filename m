Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0A854D99C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 07:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358048AbiFPFP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 01:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350832AbiFPFPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 01:15:52 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F352590AA;
        Wed, 15 Jun 2022 22:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655356551; x=1686892551;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YT2kgex7dphQ7S9ilSj4A2Ap156islQSNJsnpcZvwqo=;
  b=UT3r6k4DrUH53mj+SVulIK/AqDFuOfcneskSXbHrhzYYyT+LnIQzrsGQ
   /8F/hNvFVG3l1DO0f8EvFOs16ewgSWgx51f6aJzcM8bO0q5bPylrgMxm8
   XxARUxYl1fi7OQWkiefS+FyjaqPK/kewUmndeYcLK92RAYEbuoCprO8SU
   7HFYjmJ1YvpKr/TyCy73sP6pCmllRs2KQayrWkwnWftZERuaYlZlWKoG+
   nRWfefvElsRwNE79GwDG7Jw3DOFOJH+8TDHzLRGrn2zrEr2nkUSyP2a2P
   RMayVOGkcsO02reoi74mssVD8xxQxCGBBe6BPZv+RskJ1nHyYO41RRRWq
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10379"; a="280201531"
X-IronPort-AV: E=Sophos;i="5.91,304,1647327600"; 
   d="scan'208";a="280201531"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 22:15:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,304,1647327600"; 
   d="scan'208";a="674863752"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Jun 2022 22:15:48 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o1hr9-000O57-Ib;
        Thu, 16 Jun 2022 05:15:47 +0000
Date:   Thu, 16 Jun 2022 13:15:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hongyu Xie <xy521521@gmail.com>, mathias.nyman@intel.com,
        gregkh@linuxfoundation.org
Cc:     kbuild-all@lists.01.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, 125707942@qq.com, wangqi@kylinos.cn,
        xiongxin@kylinos.cn, Hongyu Xie <xiehongyu1@kylinos.cn>
Subject: Re: [PATCH v3 -next] usb: xhci: disable irq during initialization
Message-ID: <202206161315.DjaJzxlY-lkp@intel.com>
References: <20220616025634.3693260-1-xiehongyu1@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220616025634.3693260-1-xiehongyu1@kylinos.cn>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hongyu,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on next-20220615]

url:    https://github.com/intel-lab-lkp/linux/commits/Hongyu-Xie/usb-xhci-disable-irq-during-initialization/20220616-110418
base:    6012273897fefb12566580efedee10bb06e5e6ed
config: xtensa-allyesconfig (https://download.01.org/0day-ci/archive/20220616/202206161315.DjaJzxlY-lkp@intel.com/config)
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
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=xtensa SHELL=/bin/bash drivers/usb/host/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

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
   drivers/usb/host/xhci.c:619:40: error: 'flags' undeclared (first use in this function)
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
>> include/linux/typecheck.h:12:25: warning: comparison of distinct pointer types lacks a cast
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


vim +12 include/linux/typecheck.h

e0deaff470900a Andrew Morton 2008-07-25   4  
e0deaff470900a Andrew Morton 2008-07-25   5  /*
e0deaff470900a Andrew Morton 2008-07-25   6   * Check at compile time that something is of a particular type.
e0deaff470900a Andrew Morton 2008-07-25   7   * Always evaluates to 1 so you may use it easily in comparisons.
e0deaff470900a Andrew Morton 2008-07-25   8   */
e0deaff470900a Andrew Morton 2008-07-25   9  #define typecheck(type,x) \
e0deaff470900a Andrew Morton 2008-07-25  10  ({	type __dummy; \
e0deaff470900a Andrew Morton 2008-07-25  11  	typeof(x) __dummy2; \
e0deaff470900a Andrew Morton 2008-07-25 @12  	(void)(&__dummy == &__dummy2); \
e0deaff470900a Andrew Morton 2008-07-25  13  	1; \
e0deaff470900a Andrew Morton 2008-07-25  14  })
e0deaff470900a Andrew Morton 2008-07-25  15  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
