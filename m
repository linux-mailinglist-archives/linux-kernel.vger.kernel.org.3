Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0AB5526F7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 00:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243338AbiFTWbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 18:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236639AbiFTWbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 18:31:14 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D49201CB39;
        Mon, 20 Jun 2022 15:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655764271; x=1687300271;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Re7rWL4abOLtS+lrprFgG6IQmQ4DOHCKTCHvuEvnm94=;
  b=CGVf4DsOCw+cQW0hnW6CECZiI8VHSjlPF/BREbANXGxNWzNiHNiQGUbM
   sXxCckmwOcTyZECuNjmEG6jRP4z5w4cXJdzSwe/U7WFO2YOABOkyCh0xD
   ZpzOX70J4ZV4JrDmgZ3eS9s/3OtebQtHXG60LJIGx5h8gV8qMmJg6Xmq4
   MRIaRG0U+3h6aRZtaaWQqRdA04MmnJGIyMQyoVnxm0ApHfj+SXYzJmdKv
   YmEeQdMDLd3jtDG6Vb/PIwCq+gxAidebv3HdbM4JOgFXvKRw+GIb24hBL
   PZbOyfjvn5yXA7BRfwY7k8xqwWMuGXoe3mcOcgK38t1NB9SfitZJEtDF0
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10384"; a="259801828"
X-IronPort-AV: E=Sophos;i="5.92,207,1650956400"; 
   d="scan'208";a="259801828"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 15:31:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,207,1650956400"; 
   d="scan'208";a="614530076"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 20 Jun 2022 15:31:09 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o3PvI-000Wkn-PL;
        Mon, 20 Jun 2022 22:31:08 +0000
Date:   Tue, 21 Jun 2022 06:30:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org
Subject: Re: [PATCH v1 1/1] pinctrl: nomadik: Convert drivers to use struct
 pingroup and PINCTRL_PINGROUP()
Message-ID: <202206210623.0U4Kh4D3-lkp@intel.com>
References: <20220620171136.84648-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220620171136.84648-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,SUSPICIOUS_RECIPS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

I love your patch! Yet something to improve:

[auto build test ERROR on linusw-pinctrl/devel]
[also build test ERROR on linus/master v5.19-rc2 next-20220617]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/pinctrl-nomadik-Convert-drivers-to-use-struct-pingroup-and-PINCTRL_PINGROUP/20220621-011251
base:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git devel
config: arm-randconfig-r015-20220619 (https://download.01.org/0day-ci/archive/20220621/202206210623.0U4Kh4D3-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project af6d2a0b6825e71965f3e2701a63c239fa0ad70f)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/intel-lab-lkp/linux/commit/b4fae758bbe7d632c6bac2fe8070634f41a7f9bf
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Andy-Shevchenko/pinctrl-nomadik-Convert-drivers-to-use-struct-pingroup-and-PINCTRL_PINGROUP/20220621-011251
        git checkout b4fae758bbe7d632c6bac2fe8070634f41a7f9bf
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/pinctrl/nomadik/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/pinctrl/nomadik/pinctrl-nomadik.c:1529:4: error: incompatible pointer types assigning to 'const struct nmk_pingroup *' from 'const struct pingroup *' [-Werror,-Wincompatible-pointer-types]
           g = &npct->soc->groups[group].grp;
             ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/pinctrl/nomadik/pinctrl-nomadik.c:1533:54: error: no member named 'name' in 'struct nmk_pingroup'
           dev_dbg(npct->dev, "enable group %s, %u pins\n", g->name, g->npins);
                                                            ~  ^
   include/linux/dev_printk.h:163:47: note: expanded from macro 'dev_dbg'
                   dev_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__); \
                                                               ^~~~~~~~~~~
   include/linux/dev_printk.h:129:34: note: expanded from macro 'dev_printk'
                   _dev_printk(level, dev, fmt, ##__VA_ARGS__);            \
                                                  ^~~~~~~~~~~
>> drivers/pinctrl/nomadik/pinctrl-nomadik.c:1533:63: error: no member named 'npins' in 'struct nmk_pingroup'
           dev_dbg(npct->dev, "enable group %s, %u pins\n", g->name, g->npins);
                                                                     ~  ^
   include/linux/dev_printk.h:163:47: note: expanded from macro 'dev_dbg'
                   dev_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__); \
                                                               ^~~~~~~~~~~
   include/linux/dev_printk.h:129:34: note: expanded from macro 'dev_printk'
                   _dev_printk(level, dev, fmt, ##__VA_ARGS__);            \
                                                  ^~~~~~~~~~~
   drivers/pinctrl/nomadik/pinctrl-nomadik.c:1568:22: error: no member named 'npins' in 'struct nmk_pingroup'
                   for (i = 0; i < g->npins; i++)
                                   ~  ^
>> drivers/pinctrl/nomadik/pinctrl-nomadik.c:1569:12: error: no member named 'pins' in 'struct nmk_pingroup'
                           slpm[g->pins[i] / NMK_GPIO_PER_CHIP] &= ~BIT(g->pins[i]);
                                ~  ^
   drivers/pinctrl/nomadik/pinctrl-nomadik.c:1569:52: error: no member named 'pins' in 'struct nmk_pingroup'
                           slpm[g->pins[i] / NMK_GPIO_PER_CHIP] &= ~BIT(g->pins[i]);
                                                                        ~  ^
   include/vdso/bits.h:7:30: note: expanded from macro 'BIT'
   #define BIT(nr)                 (UL(1) << (nr))
                                              ^~
   drivers/pinctrl/nomadik/pinctrl-nomadik.c:1573:21: error: no member named 'npins' in 'struct nmk_pingroup'
           for (i = 0; i < g->npins; i++) {
                           ~  ^
   drivers/pinctrl/nomadik/pinctrl-nomadik.c:1577:40: error: no member named 'pins' in 'struct nmk_pingroup'
                   nmk_chip = find_nmk_gpio_from_pin(g->pins[i]);
                                                     ~  ^
   drivers/pinctrl/nomadik/pinctrl-nomadik.c:1581:8: error: no member named 'pins' in 'struct nmk_pingroup'
                                   g->pins[i], g->name, i);
                                   ~  ^
   include/linux/dev_printk.h:144:65: note: expanded from macro 'dev_err'
           dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
                                                                          ^~~~~~~~~~~
   include/linux/dev_printk.h:110:23: note: expanded from macro 'dev_printk_index_wrap'
                   _p_func(dev, fmt, ##__VA_ARGS__);                       \
                                       ^~~~~~~~~~~
   drivers/pinctrl/nomadik/pinctrl-nomadik.c:1581:20: error: no member named 'name' in 'struct nmk_pingroup'
                                   g->pins[i], g->name, i);
                                               ~  ^
   include/linux/dev_printk.h:144:65: note: expanded from macro 'dev_err'
           dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
                                                                          ^~~~~~~~~~~
   include/linux/dev_printk.h:110:23: note: expanded from macro 'dev_printk_index_wrap'
                   _p_func(dev, fmt, ##__VA_ARGS__);                       \
                                       ^~~~~~~~~~~
   drivers/pinctrl/nomadik/pinctrl-nomadik.c:1584:62: error: no member named 'pins' in 'struct nmk_pingroup'
                   dev_dbg(npct->dev, "setting pin %d to altsetting %d\n", g->pins[i], g->altsetting);
                                                                           ~  ^
   include/linux/dev_printk.h:163:47: note: expanded from macro 'dev_dbg'
                   dev_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__); \
                                                               ^~~~~~~~~~~
   include/linux/dev_printk.h:129:34: note: expanded from macro 'dev_printk'
                   _dev_printk(level, dev, fmt, ##__VA_ARGS__);            \
                                                  ^~~~~~~~~~~
   drivers/pinctrl/nomadik/pinctrl-nomadik.c:1587:12: error: no member named 'pins' in 'struct nmk_pingroup'
                   bit = g->pins[i] % NMK_GPIO_PER_CHIP;
                         ~  ^
   drivers/pinctrl/nomadik/pinctrl-nomadik.c:1610:37: error: no member named 'pins' in 'struct nmk_pingroup'
                           nmk_prcm_altcx_set_mode(npct, g->pins[i],
                                                         ~  ^
   13 errors generated.


vim +1529 drivers/pinctrl/nomadik/pinctrl-nomadik.c

  1517	
  1518	static int nmk_pmx_set(struct pinctrl_dev *pctldev, unsigned function,
  1519			       unsigned group)
  1520	{
  1521		struct nmk_pinctrl *npct = pinctrl_dev_get_drvdata(pctldev);
  1522		const struct nmk_pingroup *g;
  1523		static unsigned int slpm[NUM_BANKS];
  1524		unsigned long flags = 0;
  1525		bool glitch;
  1526		int ret = -EINVAL;
  1527		int i;
  1528	
> 1529		g = &npct->soc->groups[group].grp;
  1530		if (g->altsetting < 0)
  1531			return -EINVAL;
  1532	
> 1533		dev_dbg(npct->dev, "enable group %s, %u pins\n", g->name, g->npins);
  1534	
  1535		/*
  1536		 * If we're setting altfunc C by setting both AFSLA and AFSLB to 1,
  1537		 * we may pass through an undesired state. In this case we take
  1538		 * some extra care.
  1539		 *
  1540		 * Safe sequence used to switch IOs between GPIO and Alternate-C mode:
  1541		 *  - Save SLPM registers (since we have a shadow register in the
  1542		 *    nmk_chip we're using that as backup)
  1543		 *  - Set SLPM=0 for the IOs you want to switch and others to 1
  1544		 *  - Configure the GPIO registers for the IOs that are being switched
  1545		 *  - Set IOFORCE=1
  1546		 *  - Modify the AFLSA/B registers for the IOs that are being switched
  1547		 *  - Set IOFORCE=0
  1548		 *  - Restore SLPM registers
  1549		 *  - Any spurious wake up event during switch sequence to be ignored
  1550		 *    and cleared
  1551		 *
  1552		 * We REALLY need to save ALL slpm registers, because the external
  1553		 * IOFORCE will switch *all* ports to their sleepmode setting to as
  1554		 * to avoid glitches. (Not just one port!)
  1555		 */
  1556		glitch = ((g->altsetting & NMK_GPIO_ALT_C) == NMK_GPIO_ALT_C);
  1557	
  1558		if (glitch) {
  1559			spin_lock_irqsave(&nmk_gpio_slpm_lock, flags);
  1560	
  1561			/* Initially don't put any pins to sleep when switching */
  1562			memset(slpm, 0xff, sizeof(slpm));
  1563	
  1564			/*
  1565			 * Then mask the pins that need to be sleeping now when we're
  1566			 * switching to the ALT C function.
  1567			 */
  1568			for (i = 0; i < g->npins; i++)
> 1569				slpm[g->pins[i] / NMK_GPIO_PER_CHIP] &= ~BIT(g->pins[i]);
  1570			nmk_gpio_glitch_slpm_init(slpm);
  1571		}
  1572	
  1573		for (i = 0; i < g->npins; i++) {
  1574			struct nmk_gpio_chip *nmk_chip;
  1575			unsigned bit;
  1576	
  1577			nmk_chip = find_nmk_gpio_from_pin(g->pins[i]);
  1578			if (!nmk_chip) {
  1579				dev_err(npct->dev,
  1580					"invalid pin offset %d in group %s at index %d\n",
  1581					g->pins[i], g->name, i);
  1582				goto out_glitch;
  1583			}
  1584			dev_dbg(npct->dev, "setting pin %d to altsetting %d\n", g->pins[i], g->altsetting);
  1585	
  1586			clk_enable(nmk_chip->clk);
  1587			bit = g->pins[i] % NMK_GPIO_PER_CHIP;
  1588			/*
  1589			 * If the pin is switching to altfunc, and there was an
  1590			 * interrupt installed on it which has been lazy disabled,
  1591			 * actually mask the interrupt to prevent spurious interrupts
  1592			 * that would occur while the pin is under control of the
  1593			 * peripheral. Only SKE does this.
  1594			 */
  1595			nmk_gpio_disable_lazy_irq(nmk_chip, bit);
  1596	
  1597			__nmk_gpio_set_mode_safe(nmk_chip, bit,
  1598				(g->altsetting & NMK_GPIO_ALT_C), glitch);
  1599			clk_disable(nmk_chip->clk);
  1600	
  1601			/*
  1602			 * Call PRCM GPIOCR config function in case ALTC
  1603			 * has been selected:
  1604			 * - If selection is a ALTCx, some bits in PRCM GPIOCR registers
  1605			 *   must be set.
  1606			 * - If selection is pure ALTC and previous selection was ALTCx,
  1607			 *   then some bits in PRCM GPIOCR registers must be cleared.
  1608			 */
  1609			if ((g->altsetting & NMK_GPIO_ALT_C) == NMK_GPIO_ALT_C)
  1610				nmk_prcm_altcx_set_mode(npct, g->pins[i],
  1611					g->altsetting >> NMK_GPIO_ALT_CX_SHIFT);
  1612		}
  1613	
  1614		/* When all pins are successfully reconfigured we get here */
  1615		ret = 0;
  1616	
  1617	out_glitch:
  1618		if (glitch) {
  1619			nmk_gpio_glitch_slpm_restore(slpm);
  1620			spin_unlock_irqrestore(&nmk_gpio_slpm_lock, flags);
  1621		}
  1622	
  1623		return ret;
  1624	}
  1625	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
