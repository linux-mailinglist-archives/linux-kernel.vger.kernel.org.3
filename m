Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 505815A86C3
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 21:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbiHaTbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 15:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbiHaTb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 15:31:29 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5991E86A2;
        Wed, 31 Aug 2022 12:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661974287; x=1693510287;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yvh5Hf7vADVeYcVhEw21oWTTub2YF7Sisu+x+c8taZQ=;
  b=QxsVdFlslxc9GvjYaVz8Buqi6BBS0kTDrm5Geq+ShMLSmhLRJUxIhs2J
   XvNJ15xI+cmGBDBLOF5Jrkql/1Wlv2k1QnAh6hfEZh8fC6f8jQG6epDni
   hwR9rQpNIB4KbqVVrW8ie1Ad2ebYHKUj4C/CtG3GAqlf1Tjo2dAEXnLeE
   majv49LKkLoDb3wIw3kAHuXjP7DFL89lS6bD//jbFrCbJxWfDU5e9ZeY5
   fLYOtL4yalvnz8ot3EXancxx7KD7pDtn5I3sd2s5vFp2wUaKGkJOgzBZL
   9ePy9hJzi1Bm6CIfx2Q+lr4wCtqaHyMRUAoWMSBSyRnIB3GFdJjPkvX+x
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10456"; a="321669893"
X-IronPort-AV: E=Sophos;i="5.93,278,1654585200"; 
   d="scan'208";a="321669893"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 12:31:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,278,1654585200"; 
   d="scan'208";a="754528329"
Received: from lkp-server02.sh.intel.com (HELO 811e2ceaf0e5) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 31 Aug 2022 12:31:24 -0700
Received: from kbuild by 811e2ceaf0e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oTTQq-0000dG-0n;
        Wed, 31 Aug 2022 19:31:24 +0000
Date:   Thu, 1 Sep 2022 03:30:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jianqun Xu <jay.xu@rock-chips.com>, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Bartosz Golaszewski <brgl@bgdev.pl>,
        Heiko Stuebner <heiko@sntech.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 1/1] gpio: rockchip: Switch to use fwnode instead of
 of_node
Message-ID: <202209010347.s5HFnZfF-lkp@intel.com>
References: <20220831134516.78108-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220831134516.78108-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

I love your patch! Yet something to improve:

[auto build test ERROR on rockchip/for-next]
[also build test ERROR on linus/master v6.0-rc3 next-20220831]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/gpio-rockchip-Switch-to-use-fwnode-instead-of-of_node/20220831-214721
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git for-next
config: loongarch-buildonly-randconfig-r003-20220830 (https://download.01.org/0day-ci/archive/20220901/202209010347.s5HFnZfF-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/1adf1d7efa2837b148a47d10749922358e6f1b8f
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Andy-Shevchenko/gpio-rockchip-Switch-to-use-fwnode-instead-of-of_node/20220831-214721
        git checkout 1adf1d7efa2837b148a47d10749922358e6f1b8f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=loongarch SHELL=/bin/bash drivers/gpio/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   drivers/gpio/gpio-rockchip.c: In function 'rockchip_gpiolib_register':
>> drivers/gpio/gpio-rockchip.c:611:27: error: implicit declaration of function 'pinctrl_get'; did you mean 'of_pinctrl_get'? [-Werror=implicit-function-declaration]
     611 |                 pctldev = pinctrl_get(bank->dev->parent);
         |                           ^~~~~~~~~~~
         |                           of_pinctrl_get
>> drivers/gpio/gpio-rockchip.c:611:25: warning: assignment to 'struct pinctrl_dev *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     611 |                 pctldev = pinctrl_get(bank->dev->parent);
         |                         ^
   drivers/gpio/gpio-rockchip.c: In function 'rockchip_get_bank_data':
   drivers/gpio/gpio-rockchip.c:639:40: error: implicit declaration of function 'to_platform_device' [-Werror=implicit-function-declaration]
     639 |         struct platform_device *pdev = to_platform_device(bank->dev);
         |                                        ^~~~~~~~~~~~~~~~~~
   drivers/gpio/gpio-rockchip.c:639:40: warning: initialization of 'struct platform_device *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
   drivers/gpio/gpio-rockchip.c:644:26: error: implicit declaration of function 'devm_platform_ioremap_resource'; did you mean 'devm_ioremap_resource'? [-Werror=implicit-function-declaration]
     644 |         bank->reg_base = devm_platform_ioremap_resource(pdev, 0);
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                          devm_ioremap_resource
   drivers/gpio/gpio-rockchip.c:644:24: warning: assignment to 'void *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     644 |         bank->reg_base = devm_platform_ioremap_resource(pdev, 0);
         |                        ^
   drivers/gpio/gpio-rockchip.c:648:21: error: implicit declaration of function 'platform_get_irq'; did you mean 'platform_notify'? [-Werror=implicit-function-declaration]
     648 |         bank->irq = platform_get_irq(pdev, 0);
         |                     ^~~~~~~~~~~~~~~~
         |                     platform_notify
   drivers/gpio/gpio-rockchip.c:641:25: warning: unused variable 'res' [-Wunused-variable]
     641 |         struct resource res;
         |                         ^~~
   drivers/gpio/gpio-rockchip.c: At top level:
   drivers/gpio/gpio-rockchip.c:696:39: warning: 'struct platform_device' declared inside parameter list will not be visible outside of this definition or declaration
     696 | static int rockchip_gpio_probe(struct platform_device *pdev)
         |                                       ^~~~~~~~~~~~~~~
   drivers/gpio/gpio-rockchip.c: In function 'rockchip_gpio_probe':
   drivers/gpio/gpio-rockchip.c:698:35: error: invalid use of undefined type 'struct platform_device'
     698 |         struct device *dev = &pdev->dev;
         |                                   ^~
   drivers/gpio/gpio-rockchip.c:709:17: warning: assignment to 'struct pinctrl_dev *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     709 |         pctldev = pinctrl_get(dev->parent);
         |                 ^
   drivers/gpio/gpio-rockchip.c:768:9: error: implicit declaration of function 'platform_set_drvdata' [-Werror=implicit-function-declaration]
     768 |         platform_set_drvdata(pdev, bank);
         |         ^~~~~~~~~~~~~~~~~~~~
   drivers/gpio/gpio-rockchip.c: At top level:
   drivers/gpio/gpio-rockchip.c:774:40: warning: 'struct platform_device' declared inside parameter list will not be visible outside of this definition or declaration
     774 | static int rockchip_gpio_remove(struct platform_device *pdev)
         |                                        ^~~~~~~~~~~~~~~
   drivers/gpio/gpio-rockchip.c: In function 'rockchip_gpio_remove':
   drivers/gpio/gpio-rockchip.c:776:42: error: implicit declaration of function 'platform_get_drvdata' [-Werror=implicit-function-declaration]
     776 |         struct rockchip_pin_bank *bank = platform_get_drvdata(pdev);
         |                                          ^~~~~~~~~~~~~~~~~~~~
   drivers/gpio/gpio-rockchip.c:776:42: warning: initialization of 'struct rockchip_pin_bank *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
   drivers/gpio/gpio-rockchip.c: At top level:
   drivers/gpio/gpio-rockchip.c:790:15: error: variable 'rockchip_gpio_driver' has initializer but incomplete type
     790 | static struct platform_driver rockchip_gpio_driver = {
         |               ^~~~~~~~~~~~~~~
   drivers/gpio/gpio-rockchip.c:791:10: error: 'struct platform_driver' has no member named 'probe'
     791 |         .probe          = rockchip_gpio_probe,
         |          ^~~~~
   drivers/gpio/gpio-rockchip.c:791:27: warning: excess elements in struct initializer
     791 |         .probe          = rockchip_gpio_probe,
         |                           ^~~~~~~~~~~~~~~~~~~
   drivers/gpio/gpio-rockchip.c:791:27: note: (near initialization for 'rockchip_gpio_driver')
   drivers/gpio/gpio-rockchip.c:792:10: error: 'struct platform_driver' has no member named 'remove'
     792 |         .remove         = rockchip_gpio_remove,
         |          ^~~~~~
   drivers/gpio/gpio-rockchip.c:792:27: warning: excess elements in struct initializer
     792 |         .remove         = rockchip_gpio_remove,
         |                           ^~~~~~~~~~~~~~~~~~~~
   drivers/gpio/gpio-rockchip.c:792:27: note: (near initialization for 'rockchip_gpio_driver')
   drivers/gpio/gpio-rockchip.c:793:10: error: 'struct platform_driver' has no member named 'driver'
     793 |         .driver         = {
         |          ^~~~~~
   drivers/gpio/gpio-rockchip.c:793:27: error: extra brace group at end of initializer
     793 |         .driver         = {
         |                           ^
   drivers/gpio/gpio-rockchip.c:793:27: note: (near initialization for 'rockchip_gpio_driver')
   drivers/gpio/gpio-rockchip.c:793:27: warning: excess elements in struct initializer
   drivers/gpio/gpio-rockchip.c:793:27: note: (near initialization for 'rockchip_gpio_driver')
   drivers/gpio/gpio-rockchip.c: In function 'rockchip_gpio_init':
   drivers/gpio/gpio-rockchip.c:801:16: error: implicit declaration of function 'platform_driver_register' [-Werror=implicit-function-declaration]
     801 |         return platform_driver_register(&rockchip_gpio_driver);
         |                ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpio/gpio-rockchip.c: In function 'rockchip_gpio_exit':
   drivers/gpio/gpio-rockchip.c:807:9: error: implicit declaration of function 'platform_driver_unregister'; did you mean 'driver_unregister'? [-Werror=implicit-function-declaration]
     807 |         platform_driver_unregister(&rockchip_gpio_driver);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
         |         driver_unregister
   drivers/gpio/gpio-rockchip.c: At top level:
   drivers/gpio/gpio-rockchip.c:790:31: error: storage size of 'rockchip_gpio_driver' isn't known
     790 | static struct platform_driver rockchip_gpio_driver = {
         |                               ^~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for PCI_LOONGSON
   Depends on [n]: PCI [=y] && (MACH_LOONGSON64 [=y] || COMPILE_TEST [=y]) && (OF [=y] || ACPI [=y]) && PCI_QUIRKS [=n]
   Selected by [y]:
   - LOONGARCH [=y]


vim +611 drivers/gpio/gpio-rockchip.c

   577	
   578	static int rockchip_gpiolib_register(struct rockchip_pin_bank *bank)
   579	{
   580		struct gpio_chip *gc;
   581		int ret;
   582	
   583		bank->gpio_chip = rockchip_gpiolib_chip;
   584	
   585		gc = &bank->gpio_chip;
   586		gc->base = bank->pin_base;
   587		gc->ngpio = bank->nr_pins;
   588		gc->label = bank->name;
   589		gc->parent = bank->dev;
   590	
   591		ret = gpiochip_add_data(gc, bank);
   592		if (ret) {
   593			dev_err(bank->dev, "failed to add gpiochip %s, %d\n",
   594				gc->label, ret);
   595			return ret;
   596		}
   597	
   598		/*
   599		 * For DeviceTree-supported systems, the gpio core checks the
   600		 * pinctrl's device node for the "gpio-ranges" property.
   601		 * If it is present, it takes care of adding the pin ranges
   602		 * for the driver. In this case the driver can skip ahead.
   603		 *
   604		 * In order to remain compatible with older, existing DeviceTree
   605		 * files which don't set the "gpio-ranges" property or systems that
   606		 * utilize ACPI the driver has to call gpiochip_add_pin_range().
   607		 */
   608		if (!device_property_read_bool(bank->dev, "gpio-ranges")) {
   609			struct pinctrl_dev *pctldev = NULL;
   610	
 > 611			pctldev = pinctrl_get(bank->dev->parent);
   612			if (!pctldev)
   613				return -ENODEV;
   614	
   615			ret = gpiochip_add_pin_range(gc, dev_name(pctldev->dev), 0,
   616						     gc->base, gc->ngpio);
   617			if (ret) {
   618				dev_err(bank->dev, "Failed to add pin range\n");
   619				goto fail;
   620			}
   621		}
   622	
   623		ret = rockchip_interrupts_register(bank);
   624		if (ret) {
   625			dev_err(bank->dev, "failed to register interrupt, %d\n", ret);
   626			goto fail;
   627		}
   628	
   629		return 0;
   630	
   631	fail:
   632		gpiochip_remove(&bank->gpio_chip);
   633	
   634		return ret;
   635	}
   636	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
