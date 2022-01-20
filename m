Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEA0049535A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 18:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbiATRgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 12:36:18 -0500
Received: from mga12.intel.com ([192.55.52.136]:14914 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229712AbiATRgR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 12:36:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642700177; x=1674236177;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+dYWYcsVjO72w3HaxwuCXXUjMt6guX+HVrSAVR0okx0=;
  b=gqKmMJUsz8E8pg9vATKjG2dYiWmVtYntfM27mT1b+QRjl0cCBEIoPhP9
   TXLUGilorRohf8Vxc4HCU3pK82xlBGw9/Swa/h1sNIYxV71DUhPMRudAH
   sc2R7bg+XyeqRphnMfXRYVZDWDmBam+ybRak+UuiTcU+O/iMSSyyrAX6G
   5FKlTsj66thDkuGA2Ww9W3p5W3i81c6nmziarIA1SwMLbMkRyAtWpa+LP
   WVaORfAS6iaPW1yEkfaQy/tOe9AdyZjaJnuR2e/dyKP42p0JfZq/EKz3K
   QJQvtBiMk/jSajxBFX5+cE59Q53lMeVeAftbOXeYFtQuFbyH9Qu3xi0tM
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10233"; a="225387979"
X-IronPort-AV: E=Sophos;i="5.88,303,1635231600"; 
   d="scan'208";a="225387979"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2022 09:36:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,303,1635231600"; 
   d="scan'208";a="626391000"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 20 Jan 2022 09:36:13 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nAbM5-000EWZ-1L; Thu, 20 Jan 2022 17:36:13 +0000
Date:   Fri, 21 Jan 2022 01:35:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Laurent Vivier <laurent@vivier.eu>, linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org, John Stultz <john.stultz@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-m68k@lists.linux-m68k.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v11 3/5] rtc: goldfish: use gf_ioread32()/gf_iowrite32()
Message-ID: <202201210103.XWJt8hcA-lkp@intel.com>
References: <20220120080347.1595379-4-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220120080347.1595379-4-laurent@vivier.eu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on tip/timers/core]
[also build test ERROR on linux/master linus/master v5.16 next-20220120]
[cannot apply to geert-m68k/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Laurent-Vivier/m68k-Add-Virtual-M68k-Machine/20220120-160832
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git 35e13e9da9afbce13c1d36465504ece4e65f24fe
config: riscv-randconfig-r042-20220120 (https://download.01.org/0day-ci/archive/20220121/202201210103.XWJt8hcA-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project f7b7138a62648f4019c55e4671682af1f851f295)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/0day-ci/linux/commit/82ea64fc7cab43e258085769ed1d90b0685bf091
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Laurent-Vivier/m68k-Add-Virtual-M68k-Machine/20220120-160832
        git checkout 82ea64fc7cab43e258085769ed1d90b0685bf091
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/rtc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/rtc/rtc-goldfish.c:44:18: error: implicit declaration of function 'gf_ioread32' [-Werror,-Wimplicit-function-declaration]
           rtc_alarm_low = gf_ioread32(base + TIMER_ALARM_LOW);
                           ^
   drivers/rtc/rtc-goldfish.c:44:18: note: did you mean 'ioread32'?
   include/asm-generic/io.h:726:19: note: 'ioread32' declared here
   static inline u32 ioread32(const volatile void __iomem *addr)
                     ^
   include/asm-generic/io.h:725:18: note: expanded from macro 'ioread32'
   #define ioread32 ioread32
                    ^
>> drivers/rtc/rtc-goldfish.c:74:3: error: implicit declaration of function 'gf_iowrite32' [-Werror,-Wimplicit-function-declaration]
                   gf_iowrite32((rtc_alarm64 >> 32), base + TIMER_ALARM_HIGH);
                   ^
   drivers/rtc/rtc-goldfish.c:74:3: note: did you mean 'iowrite32'?
   include/asm-generic/io.h:760:20: note: 'iowrite32' declared here
   static inline void iowrite32(u32 value, volatile void __iomem *addr)
                      ^
   include/asm-generic/io.h:759:19: note: expanded from macro 'iowrite32'
   #define iowrite32 iowrite32
                     ^
   drivers/rtc/rtc-goldfish.c:83:20: error: implicit declaration of function 'gf_ioread32' [-Werror,-Wimplicit-function-declaration]
                   rtc_status_reg = gf_ioread32(base + TIMER_ALARM_STATUS);
                                    ^
   drivers/rtc/rtc-goldfish.c:85:4: error: implicit declaration of function 'gf_iowrite32' [-Werror,-Wimplicit-function-declaration]
                           gf_iowrite32(1, base + TIMER_CLEAR_ALARM);
                           ^
   drivers/rtc/rtc-goldfish.c:101:3: error: implicit declaration of function 'gf_iowrite32' [-Werror,-Wimplicit-function-declaration]
                   gf_iowrite32(1, base + TIMER_IRQ_ENABLED);
                   ^
   drivers/rtc/rtc-goldfish.c:113:2: error: implicit declaration of function 'gf_iowrite32' [-Werror,-Wimplicit-function-declaration]
           gf_iowrite32(1, base + TIMER_CLEAR_INTERRUPT);
           ^
   drivers/rtc/rtc-goldfish.c:131:13: error: implicit declaration of function 'gf_ioread32' [-Werror,-Wimplicit-function-declaration]
           time_low = gf_ioread32(base + TIMER_TIME_LOW);
                      ^
   drivers/rtc/rtc-goldfish.c:152:2: error: implicit declaration of function 'gf_iowrite32' [-Werror,-Wimplicit-function-declaration]
           gf_iowrite32((now64 >> 32), base + TIMER_TIME_HIGH);
           ^
   8 errors generated.


vim +/gf_ioread32 +44 drivers/rtc/rtc-goldfish.c

    31	
    32	static int goldfish_rtc_read_alarm(struct device *dev,
    33					   struct rtc_wkalrm *alrm)
    34	{
    35		u64 rtc_alarm;
    36		u64 rtc_alarm_low;
    37		u64 rtc_alarm_high;
    38		void __iomem *base;
    39		struct goldfish_rtc *rtcdrv;
    40	
    41		rtcdrv = dev_get_drvdata(dev);
    42		base = rtcdrv->base;
    43	
  > 44		rtc_alarm_low = gf_ioread32(base + TIMER_ALARM_LOW);
    45		rtc_alarm_high = gf_ioread32(base + TIMER_ALARM_HIGH);
    46		rtc_alarm = (rtc_alarm_high << 32) | rtc_alarm_low;
    47	
    48		do_div(rtc_alarm, NSEC_PER_SEC);
    49		memset(alrm, 0, sizeof(struct rtc_wkalrm));
    50	
    51		rtc_time64_to_tm(rtc_alarm, &alrm->time);
    52	
    53		if (gf_ioread32(base + TIMER_ALARM_STATUS))
    54			alrm->enabled = 1;
    55		else
    56			alrm->enabled = 0;
    57	
    58		return 0;
    59	}
    60	
    61	static int goldfish_rtc_set_alarm(struct device *dev,
    62					  struct rtc_wkalrm *alrm)
    63	{
    64		struct goldfish_rtc *rtcdrv;
    65		u64 rtc_alarm64;
    66		u64 rtc_status_reg;
    67		void __iomem *base;
    68	
    69		rtcdrv = dev_get_drvdata(dev);
    70		base = rtcdrv->base;
    71	
    72		if (alrm->enabled) {
    73			rtc_alarm64 = rtc_tm_to_time64(&alrm->time) * NSEC_PER_SEC;
  > 74			gf_iowrite32((rtc_alarm64 >> 32), base + TIMER_ALARM_HIGH);
    75			gf_iowrite32(rtc_alarm64, base + TIMER_ALARM_LOW);
    76			gf_iowrite32(1, base + TIMER_IRQ_ENABLED);
    77		} else {
    78			/*
    79			 * if this function was called with enabled=0
    80			 * then it could mean that the application is
    81			 * trying to cancel an ongoing alarm
    82			 */
    83			rtc_status_reg = gf_ioread32(base + TIMER_ALARM_STATUS);
    84			if (rtc_status_reg)
    85				gf_iowrite32(1, base + TIMER_CLEAR_ALARM);
    86		}
    87	
    88		return 0;
    89	}
    90	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
