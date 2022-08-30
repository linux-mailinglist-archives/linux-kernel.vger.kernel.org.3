Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 088555A70ED
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 00:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232069AbiH3Wks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 18:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbiH3Wkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 18:40:42 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 500FB6113A;
        Tue, 30 Aug 2022 15:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661899239; x=1693435239;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iai1vlWEA2pg8dROxxT4i9EYM8sBonRxpETPgAiBtNQ=;
  b=mXxTxJAvkooot9pJKCWnERE+iiKVStpXMEzdO2Va1tHiS41yKfGhh9B4
   tE+A/XjakmIm2CrM/FfWolV039FJ0ljxX04E5xs3PXWoFpggO7wQ0jzaB
   RyDxEyBF0mAot47GzeJlMSVRHSJZWg5+Kkg1rAmqCbvKJkLeQs8E6xlNL
   Qede8LNMrtJUeqwF3tHo+7mDlt89sadiiruJ9OExMZ4t4+GXBw2CeLYj3
   m1MvsyAku17T46kCyXDx40QZnr7Up/OwKADhMZnFpze2s7Eo1cV8id0sr
   ArUsJt83o/8/A3XIEoVylLhHOUXcooTfO+FvxAT0rOpdF/qe9BZ57rxhk
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="359283598"
X-IronPort-AV: E=Sophos;i="5.93,276,1654585200"; 
   d="scan'208";a="359283598"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 15:40:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,276,1654585200"; 
   d="scan'208";a="701170544"
Received: from lkp-server02.sh.intel.com (HELO 77b6d4e16fc5) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 30 Aug 2022 15:40:35 -0700
Received: from kbuild by 77b6d4e16fc5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oT9uM-0000hO-2a;
        Tue, 30 Aug 2022 22:40:34 +0000
Date:   Wed, 31 Aug 2022 06:39:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jianqun Xu <jay.xu@rock-chips.com>, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Bartosz Golaszewski <brgl@bgdev.pl>,
        Heiko Stuebner <heiko@sntech.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] gpio: rockchip: Switch to use fwnode instead of
 of_node
Message-ID: <202208310652.Xhve2TGB-lkp@intel.com>
References: <20220830191939.56436-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830191939.56436-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

I love your patch! Yet something to improve:

[auto build test ERROR on rockchip/for-next]
[also build test ERROR on linus/master v6.0-rc3 next-20220830]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/gpio-rockchip-Switch-to-use-fwnode-instead-of-of_node/20220831-032131
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git for-next
config: arc-randconfig-r043-20220830 (https://download.01.org/0day-ci/archive/20220831/202208310652.Xhve2TGB-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/678cf6450de6a016c041c3cd2ce58d1383d070e6
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Andy-Shevchenko/gpio-rockchip-Switch-to-use-fwnode-instead-of-of_node/20220831-032131
        git checkout 678cf6450de6a016c041c3cd2ce58d1383d070e6
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash drivers/gpio/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/gpio/gpio-rockchip.c: In function 'rockchip_gpiolib_register':
>> drivers/gpio/gpio-rockchip.c:614:22: error: 'pctlnp' undeclared (first use in this function)
     614 |                 if (!pctlnp)
         |                      ^~~~~~
   drivers/gpio/gpio-rockchip.c:614:22: note: each undeclared identifier is reported only once for each function it appears in


vim +/pctlnp +614 drivers/gpio/gpio-rockchip.c

936ee2675eee1f Jianqun Xu      2021-08-16  579  
936ee2675eee1f Jianqun Xu      2021-08-16  580  static int rockchip_gpiolib_register(struct rockchip_pin_bank *bank)
936ee2675eee1f Jianqun Xu      2021-08-16  581  {
936ee2675eee1f Jianqun Xu      2021-08-16  582  	struct gpio_chip *gc;
936ee2675eee1f Jianqun Xu      2021-08-16  583  	int ret;
936ee2675eee1f Jianqun Xu      2021-08-16  584  
936ee2675eee1f Jianqun Xu      2021-08-16  585  	bank->gpio_chip = rockchip_gpiolib_chip;
936ee2675eee1f Jianqun Xu      2021-08-16  586  
936ee2675eee1f Jianqun Xu      2021-08-16  587  	gc = &bank->gpio_chip;
936ee2675eee1f Jianqun Xu      2021-08-16  588  	gc->base = bank->pin_base;
936ee2675eee1f Jianqun Xu      2021-08-16  589  	gc->ngpio = bank->nr_pins;
936ee2675eee1f Jianqun Xu      2021-08-16  590  	gc->label = bank->name;
936ee2675eee1f Jianqun Xu      2021-08-16  591  	gc->parent = bank->dev;
936ee2675eee1f Jianqun Xu      2021-08-16  592  
936ee2675eee1f Jianqun Xu      2021-08-16  593  	ret = gpiochip_add_data(gc, bank);
936ee2675eee1f Jianqun Xu      2021-08-16  594  	if (ret) {
936ee2675eee1f Jianqun Xu      2021-08-16  595  		dev_err(bank->dev, "failed to add gpiochip %s, %d\n",
936ee2675eee1f Jianqun Xu      2021-08-16  596  			gc->label, ret);
936ee2675eee1f Jianqun Xu      2021-08-16  597  		return ret;
936ee2675eee1f Jianqun Xu      2021-08-16  598  	}
936ee2675eee1f Jianqun Xu      2021-08-16  599  
936ee2675eee1f Jianqun Xu      2021-08-16  600  	/*
936ee2675eee1f Jianqun Xu      2021-08-16  601  	 * For DeviceTree-supported systems, the gpio core checks the
936ee2675eee1f Jianqun Xu      2021-08-16  602  	 * pinctrl's device node for the "gpio-ranges" property.
936ee2675eee1f Jianqun Xu      2021-08-16  603  	 * If it is present, it takes care of adding the pin ranges
936ee2675eee1f Jianqun Xu      2021-08-16  604  	 * for the driver. In this case the driver can skip ahead.
936ee2675eee1f Jianqun Xu      2021-08-16  605  	 *
936ee2675eee1f Jianqun Xu      2021-08-16  606  	 * In order to remain compatible with older, existing DeviceTree
936ee2675eee1f Jianqun Xu      2021-08-16  607  	 * files which don't set the "gpio-ranges" property or systems that
936ee2675eee1f Jianqun Xu      2021-08-16  608  	 * utilize ACPI the driver has to call gpiochip_add_pin_range().
936ee2675eee1f Jianqun Xu      2021-08-16  609  	 */
678cf6450de6a0 Andy Shevchenko 2022-08-30  610  	if (!fwnode_property_read_bool(bank->fwnode, "gpio-ranges")) {
678cf6450de6a0 Andy Shevchenko 2022-08-30  611  		struct fwnode_handle *parent = fwnode_get_parent(bank->fwnode);
936ee2675eee1f Jianqun Xu      2021-08-16  612  		struct pinctrl_dev *pctldev = NULL;
936ee2675eee1f Jianqun Xu      2021-08-16  613  
936ee2675eee1f Jianqun Xu      2021-08-16 @614  		if (!pctlnp)
936ee2675eee1f Jianqun Xu      2021-08-16  615  			return -ENODATA;
936ee2675eee1f Jianqun Xu      2021-08-16  616  
678cf6450de6a0 Andy Shevchenko 2022-08-30  617  		pctldev = of_pinctrl_get(to_of_node(parent));
936ee2675eee1f Jianqun Xu      2021-08-16  618  		if (!pctldev)
936ee2675eee1f Jianqun Xu      2021-08-16  619  			return -ENODEV;
936ee2675eee1f Jianqun Xu      2021-08-16  620  
936ee2675eee1f Jianqun Xu      2021-08-16  621  		ret = gpiochip_add_pin_range(gc, dev_name(pctldev->dev), 0,
936ee2675eee1f Jianqun Xu      2021-08-16  622  					     gc->base, gc->ngpio);
936ee2675eee1f Jianqun Xu      2021-08-16  623  		if (ret) {
936ee2675eee1f Jianqun Xu      2021-08-16  624  			dev_err(bank->dev, "Failed to add pin range\n");
936ee2675eee1f Jianqun Xu      2021-08-16  625  			goto fail;
936ee2675eee1f Jianqun Xu      2021-08-16  626  		}
936ee2675eee1f Jianqun Xu      2021-08-16  627  	}
936ee2675eee1f Jianqun Xu      2021-08-16  628  
936ee2675eee1f Jianqun Xu      2021-08-16  629  	ret = rockchip_interrupts_register(bank);
936ee2675eee1f Jianqun Xu      2021-08-16  630  	if (ret) {
936ee2675eee1f Jianqun Xu      2021-08-16  631  		dev_err(bank->dev, "failed to register interrupt, %d\n", ret);
936ee2675eee1f Jianqun Xu      2021-08-16  632  		goto fail;
936ee2675eee1f Jianqun Xu      2021-08-16  633  	}
936ee2675eee1f Jianqun Xu      2021-08-16  634  
936ee2675eee1f Jianqun Xu      2021-08-16  635  	return 0;
936ee2675eee1f Jianqun Xu      2021-08-16  636  
936ee2675eee1f Jianqun Xu      2021-08-16  637  fail:
936ee2675eee1f Jianqun Xu      2021-08-16  638  	gpiochip_remove(&bank->gpio_chip);
936ee2675eee1f Jianqun Xu      2021-08-16  639  
936ee2675eee1f Jianqun Xu      2021-08-16  640  	return ret;
936ee2675eee1f Jianqun Xu      2021-08-16  641  }
936ee2675eee1f Jianqun Xu      2021-08-16  642  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
