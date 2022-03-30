Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C78C4ECA9A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 19:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346580AbiC3R1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 13:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349268AbiC3R1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 13:27:32 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64AE0E9C81;
        Wed, 30 Mar 2022 10:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648661146; x=1680197146;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2wbT9qjviMFXOJP9BA2NPmRzRlvFL8bjYWi5aL+brNc=;
  b=RGEA791UnlqAkNs3XqxFFoWLX7yJMqxTbqugDsBFvbzs0hXtNzJmgk3w
   s4P1WUFnv9eg5Tj0f2zDn16uwIzBkhvLz0tVv/Jtwjg+Ig6dqL3igMyw4
   3Xhi0tHige82a0G2mQgDzkGCW+GN1tSQlZmfxpM6NZAB2xzCFt3o2mLA2
   UuuOUVHQchQgUMmZCKgwWyV7oaGVDlPaGZHpO8qeP0l5a4XOXQxNd7wcn
   l5iLrgKRm6URt+KnYvowp2Nn2rjBbz9HILF5LmI/bV52IXV5xGgskY5Mm
   Vyy8sZUcwrVmNtOLBQELgbGOqMVjxD6kQufhf/PWXUb0VU5XzU8YR/qn1
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="322783551"
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="322783551"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 10:25:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="618607535"
Received: from lkp-server02.sh.intel.com (HELO 56431612eabd) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 30 Mar 2022 10:25:23 -0700
Received: from kbuild by 56431612eabd with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nZc4Q-0000EO-UL;
        Wed, 30 Mar 2022 17:25:22 +0000
Date:   Thu, 31 Mar 2022 01:25:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Qianggui Song <qianggui.song@amlogic.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Fabien Dessenne <fabien.dessenne@foss.st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-renesas-soc@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Cc:     kbuild-all@lists.01.org, Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>
Subject: Re: [PATCH v3 05/13] pinctrl: samsung: Switch to use
 for_each_gpiochip_node() helper
Message-ID: <202203310151.Iu2JvLIF-lkp@intel.com>
References: <20220330145030.1562-6-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220330145030.1562-6-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

I love your patch! Yet something to improve:

[auto build test ERROR on a67ba3cf9551f8c92d5ec9d7eae1aadbb9127b57]

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/gpiolib-Two-new-helpers-and-way-toward-fwnode/20220330-225341
base:   a67ba3cf9551f8c92d5ec9d7eae1aadbb9127b57
config: riscv-buildonly-randconfig-r006-20220330 (https://download.01.org/0day-ci/archive/20220331/202203310151.Iu2JvLIF-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/3539d23dd289ca77a85d66fe8721e4febfc50ea4
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Andy-Shevchenko/gpiolib-Two-new-helpers-and-way-toward-fwnode/20220330-225341
        git checkout 3539d23dd289ca77a85d66fe8721e4febfc50ea4
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/pinctrl/samsung/pinctrl-s3c64xx.c: In function 's3c64xx_eint_gpio_init':
>> drivers/pinctrl/samsung/pinctrl-s3c64xx.c:474:64: error: 'struct samsung_pin_bank' has no member named 'of_node'; did you mean 'fwnode'?
     474 |                 bank->irq_domain = irq_domain_add_linear(bank->of_node,
         |                                                                ^~~~~~~
         |                                                                fwnode
   drivers/pinctrl/samsung/pinctrl-s3c64xx.c: In function 's3c64xx_eint_eint0_init':
   drivers/pinctrl/samsung/pinctrl-s3c64xx.c:746:64: error: 'struct samsung_pin_bank' has no member named 'of_node'; did you mean 'fwnode'?
     746 |                 bank->irq_domain = irq_domain_add_linear(bank->of_node,
         |                                                                ^~~~~~~
         |                                                                fwnode


vim +474 drivers/pinctrl/samsung/pinctrl-s3c64xx.c

61dd7261317770 drivers/pinctrl/pinctrl-s3c64xx.c         Tomasz Figa      2013-03-18  444  
61dd7261317770 drivers/pinctrl/pinctrl-s3c64xx.c         Tomasz Figa      2013-03-18  445  /**
61dd7261317770 drivers/pinctrl/pinctrl-s3c64xx.c         Tomasz Figa      2013-03-18  446   * s3c64xx_eint_gpio_init() - setup handling of external gpio interrupts.
61dd7261317770 drivers/pinctrl/pinctrl-s3c64xx.c         Tomasz Figa      2013-03-18  447   * @d: driver data of samsung pinctrl driver.
61dd7261317770 drivers/pinctrl/pinctrl-s3c64xx.c         Tomasz Figa      2013-03-18  448   */
61dd7261317770 drivers/pinctrl/pinctrl-s3c64xx.c         Tomasz Figa      2013-03-18  449  static int s3c64xx_eint_gpio_init(struct samsung_pinctrl_drv_data *d)
61dd7261317770 drivers/pinctrl/pinctrl-s3c64xx.c         Tomasz Figa      2013-03-18  450  {
61dd7261317770 drivers/pinctrl/pinctrl-s3c64xx.c         Tomasz Figa      2013-03-18  451  	struct s3c64xx_eint_gpio_data *data;
61dd7261317770 drivers/pinctrl/pinctrl-s3c64xx.c         Tomasz Figa      2013-03-18  452  	struct samsung_pin_bank *bank;
61dd7261317770 drivers/pinctrl/pinctrl-s3c64xx.c         Tomasz Figa      2013-03-18  453  	struct device *dev = d->dev;
61dd7261317770 drivers/pinctrl/pinctrl-s3c64xx.c         Tomasz Figa      2013-03-18  454  	unsigned int nr_domains;
61dd7261317770 drivers/pinctrl/pinctrl-s3c64xx.c         Tomasz Figa      2013-03-18  455  	unsigned int i;
61dd7261317770 drivers/pinctrl/pinctrl-s3c64xx.c         Tomasz Figa      2013-03-18  456  
61dd7261317770 drivers/pinctrl/pinctrl-s3c64xx.c         Tomasz Figa      2013-03-18  457  	if (!d->irq) {
61dd7261317770 drivers/pinctrl/pinctrl-s3c64xx.c         Tomasz Figa      2013-03-18  458  		dev_err(dev, "irq number not available\n");
61dd7261317770 drivers/pinctrl/pinctrl-s3c64xx.c         Tomasz Figa      2013-03-18  459  		return -EINVAL;
61dd7261317770 drivers/pinctrl/pinctrl-s3c64xx.c         Tomasz Figa      2013-03-18  460  	}
61dd7261317770 drivers/pinctrl/pinctrl-s3c64xx.c         Tomasz Figa      2013-03-18  461  
61dd7261317770 drivers/pinctrl/pinctrl-s3c64xx.c         Tomasz Figa      2013-03-18  462  	nr_domains = 0;
1bf00d7a6dbff0 drivers/pinctrl/samsung/pinctrl-s3c64xx.c Tomasz Figa      2014-09-23  463  	bank = d->pin_banks;
1bf00d7a6dbff0 drivers/pinctrl/samsung/pinctrl-s3c64xx.c Tomasz Figa      2014-09-23  464  	for (i = 0; i < d->nr_banks; ++i, ++bank) {
61dd7261317770 drivers/pinctrl/pinctrl-s3c64xx.c         Tomasz Figa      2013-03-18  465  		unsigned int nr_eints;
61dd7261317770 drivers/pinctrl/pinctrl-s3c64xx.c         Tomasz Figa      2013-03-18  466  		unsigned int mask;
61dd7261317770 drivers/pinctrl/pinctrl-s3c64xx.c         Tomasz Figa      2013-03-18  467  
61dd7261317770 drivers/pinctrl/pinctrl-s3c64xx.c         Tomasz Figa      2013-03-18  468  		if (bank->eint_type != EINT_TYPE_GPIO)
61dd7261317770 drivers/pinctrl/pinctrl-s3c64xx.c         Tomasz Figa      2013-03-18  469  			continue;
61dd7261317770 drivers/pinctrl/pinctrl-s3c64xx.c         Tomasz Figa      2013-03-18  470  
61dd7261317770 drivers/pinctrl/pinctrl-s3c64xx.c         Tomasz Figa      2013-03-18  471  		mask = bank->eint_mask;
61dd7261317770 drivers/pinctrl/pinctrl-s3c64xx.c         Tomasz Figa      2013-03-18  472  		nr_eints = fls(mask);
61dd7261317770 drivers/pinctrl/pinctrl-s3c64xx.c         Tomasz Figa      2013-03-18  473  
61dd7261317770 drivers/pinctrl/pinctrl-s3c64xx.c         Tomasz Figa      2013-03-18 @474  		bank->irq_domain = irq_domain_add_linear(bank->of_node,
61dd7261317770 drivers/pinctrl/pinctrl-s3c64xx.c         Tomasz Figa      2013-03-18  475  					nr_eints, &s3c64xx_gpio_irqd_ops, bank);
61dd7261317770 drivers/pinctrl/pinctrl-s3c64xx.c         Tomasz Figa      2013-03-18  476  		if (!bank->irq_domain) {
61dd7261317770 drivers/pinctrl/pinctrl-s3c64xx.c         Tomasz Figa      2013-03-18  477  			dev_err(dev, "gpio irq domain add failed\n");
61dd7261317770 drivers/pinctrl/pinctrl-s3c64xx.c         Tomasz Figa      2013-03-18  478  			return -ENXIO;
61dd7261317770 drivers/pinctrl/pinctrl-s3c64xx.c         Tomasz Figa      2013-03-18  479  		}
61dd7261317770 drivers/pinctrl/pinctrl-s3c64xx.c         Tomasz Figa      2013-03-18  480  
61dd7261317770 drivers/pinctrl/pinctrl-s3c64xx.c         Tomasz Figa      2013-03-18  481  		++nr_domains;
61dd7261317770 drivers/pinctrl/pinctrl-s3c64xx.c         Tomasz Figa      2013-03-18  482  	}
61dd7261317770 drivers/pinctrl/pinctrl-s3c64xx.c         Tomasz Figa      2013-03-18  483  
0ed2dd03b94b7b drivers/pinctrl/samsung/pinctrl-s3c64xx.c Kees Cook        2018-05-08  484  	data = devm_kzalloc(dev, struct_size(data, domains, nr_domains),
0ed2dd03b94b7b drivers/pinctrl/samsung/pinctrl-s3c64xx.c Kees Cook        2018-05-08  485  			    GFP_KERNEL);
fa5c0f46e2b9a1 drivers/pinctrl/samsung/pinctrl-s3c64xx.c Marek Szyprowski 2017-01-19  486  	if (!data)
61dd7261317770 drivers/pinctrl/pinctrl-s3c64xx.c         Tomasz Figa      2013-03-18  487  		return -ENOMEM;
61dd7261317770 drivers/pinctrl/pinctrl-s3c64xx.c         Tomasz Figa      2013-03-18  488  	data->drvdata = d;
61dd7261317770 drivers/pinctrl/pinctrl-s3c64xx.c         Tomasz Figa      2013-03-18  489  
1bf00d7a6dbff0 drivers/pinctrl/samsung/pinctrl-s3c64xx.c Tomasz Figa      2014-09-23  490  	bank = d->pin_banks;
61dd7261317770 drivers/pinctrl/pinctrl-s3c64xx.c         Tomasz Figa      2013-03-18  491  	nr_domains = 0;
1bf00d7a6dbff0 drivers/pinctrl/samsung/pinctrl-s3c64xx.c Tomasz Figa      2014-09-23  492  	for (i = 0; i < d->nr_banks; ++i, ++bank) {
61dd7261317770 drivers/pinctrl/pinctrl-s3c64xx.c         Tomasz Figa      2013-03-18  493  		if (bank->eint_type != EINT_TYPE_GPIO)
61dd7261317770 drivers/pinctrl/pinctrl-s3c64xx.c         Tomasz Figa      2013-03-18  494  			continue;
61dd7261317770 drivers/pinctrl/pinctrl-s3c64xx.c         Tomasz Figa      2013-03-18  495  
61dd7261317770 drivers/pinctrl/pinctrl-s3c64xx.c         Tomasz Figa      2013-03-18  496  		data->domains[nr_domains++] = bank->irq_domain;
61dd7261317770 drivers/pinctrl/pinctrl-s3c64xx.c         Tomasz Figa      2013-03-18  497  	}
61dd7261317770 drivers/pinctrl/pinctrl-s3c64xx.c         Tomasz Figa      2013-03-18  498  
623a650ebc886f drivers/pinctrl/samsung/pinctrl-s3c64xx.c Thomas Gleixner  2015-06-21  499  	irq_set_chained_handler_and_data(d->irq, s3c64xx_eint_gpio_irq, data);
61dd7261317770 drivers/pinctrl/pinctrl-s3c64xx.c         Tomasz Figa      2013-03-18  500  
61dd7261317770 drivers/pinctrl/pinctrl-s3c64xx.c         Tomasz Figa      2013-03-18  501  	return 0;
61dd7261317770 drivers/pinctrl/pinctrl-s3c64xx.c         Tomasz Figa      2013-03-18  502  }
61dd7261317770 drivers/pinctrl/pinctrl-s3c64xx.c         Tomasz Figa      2013-03-18  503  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
