Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC094ECD9F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 22:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbiC3UBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 16:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbiC3UBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 16:01:15 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF43921272;
        Wed, 30 Mar 2022 12:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648670369; x=1680206369;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7tDoFQmVXXYn7rMUwMmyJcJFUqWlgwtXoTN80z/SlAk=;
  b=ndPoeMFo0sq77a3QNfaj+agRGQ3smF+xF/TP3i1mKey8jbZ6MfBO/he/
   gRrQGAwmT8qqaLVfoel7kDtQSVXDL72Q1/99Rr2AIESFQiXhTD0/PSs47
   BPAWHkoy6ueakXUDKVoyKFyl0BWxeK3KP8Qrdkgb4QFD8Tr8p2q+ixuhN
   60nQLwqrHYdmT96yIQFp21kpo5ZeTOHfSwPpa5fhGkamZqMyb4MDUY60B
   52tVrmo/mBwXysJd9r4eZjVA6jXS5lFGN0DOubHl0WTrgilQy9spnBOif
   zdyB8s1QTBm2Kdg8w4O12e+Eu2lSVNOh+PrNd3hpzDS8A3WCc/UrYYv4c
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="322816271"
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="322816271"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 12:59:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="639849777"
Received: from lkp-server02.sh.intel.com (HELO 56431612eabd) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 30 Mar 2022 12:59:21 -0700
Received: from kbuild by 56431612eabd with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nZeTQ-0000RU-Jy;
        Wed, 30 Mar 2022 19:59:20 +0000
Date:   Thu, 31 Mar 2022 03:58:20 +0800
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
Message-ID: <202203310305.QZp98VzT-lkp@intel.com>
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
config: alpha-randconfig-r013-20220330 (https://download.01.org/0day-ci/archive/20220331/202203310305.QZp98VzT-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/3539d23dd289ca77a85d66fe8721e4febfc50ea4
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Andy-Shevchenko/gpiolib-Two-new-helpers-and-way-toward-fwnode/20220330-225341
        git checkout 3539d23dd289ca77a85d66fe8721e4febfc50ea4
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=alpha SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/pinctrl/samsung/pinctrl-s3c24xx.c: In function 's3c24xx_eint_init':
>> drivers/pinctrl/samsung/pinctrl-s3c24xx.c:528:64: error: 'struct samsung_pin_bank' has no member named 'of_node'; did you mean 'fwnode'?
     528 |                 bank->irq_domain = irq_domain_add_linear(bank->of_node,
         |                                                                ^~~~~~~
         |                                                                fwnode


vim +528 drivers/pinctrl/samsung/pinctrl-s3c24xx.c

af99a7507469d4 drivers/pinctrl/pinctrl-s3c24xx.c         Heiko Stuebner      2013-05-21  457  
af99a7507469d4 drivers/pinctrl/pinctrl-s3c24xx.c         Heiko Stuebner      2013-05-21  458  static int s3c24xx_eint_init(struct samsung_pinctrl_drv_data *d)
af99a7507469d4 drivers/pinctrl/pinctrl-s3c24xx.c         Heiko Stuebner      2013-05-21  459  {
af99a7507469d4 drivers/pinctrl/pinctrl-s3c24xx.c         Heiko Stuebner      2013-05-21  460  	struct device *dev = d->dev;
af99a7507469d4 drivers/pinctrl/pinctrl-s3c24xx.c         Heiko Stuebner      2013-05-21  461  	const struct of_device_id *match;
af99a7507469d4 drivers/pinctrl/pinctrl-s3c24xx.c         Heiko Stuebner      2013-05-21  462  	struct device_node *eint_np = NULL;
af99a7507469d4 drivers/pinctrl/pinctrl-s3c24xx.c         Heiko Stuebner      2013-05-21  463  	struct device_node *np;
af99a7507469d4 drivers/pinctrl/pinctrl-s3c24xx.c         Heiko Stuebner      2013-05-21  464  	struct samsung_pin_bank *bank;
af99a7507469d4 drivers/pinctrl/pinctrl-s3c24xx.c         Heiko Stuebner      2013-05-21  465  	struct s3c24xx_eint_data *eint_data;
af99a7507469d4 drivers/pinctrl/pinctrl-s3c24xx.c         Heiko Stuebner      2013-05-21  466  	const struct irq_domain_ops *ops;
af99a7507469d4 drivers/pinctrl/pinctrl-s3c24xx.c         Heiko Stuebner      2013-05-21  467  	unsigned int i;
af99a7507469d4 drivers/pinctrl/pinctrl-s3c24xx.c         Heiko Stuebner      2013-05-21  468  	bool eint0_3_parent_only;
af99a7507469d4 drivers/pinctrl/pinctrl-s3c24xx.c         Heiko Stuebner      2013-05-21  469  	irq_flow_handler_t *handlers;
af99a7507469d4 drivers/pinctrl/pinctrl-s3c24xx.c         Heiko Stuebner      2013-05-21  470  
af99a7507469d4 drivers/pinctrl/pinctrl-s3c24xx.c         Heiko Stuebner      2013-05-21  471  	for_each_child_of_node(dev->of_node, np) {
af99a7507469d4 drivers/pinctrl/pinctrl-s3c24xx.c         Heiko Stuebner      2013-05-21  472  		match = of_match_node(s3c24xx_eint_irq_ids, np);
af99a7507469d4 drivers/pinctrl/pinctrl-s3c24xx.c         Heiko Stuebner      2013-05-21  473  		if (match) {
af99a7507469d4 drivers/pinctrl/pinctrl-s3c24xx.c         Heiko Stuebner      2013-05-21  474  			eint_np = np;
af99a7507469d4 drivers/pinctrl/pinctrl-s3c24xx.c         Heiko Stuebner      2013-05-21  475  			eint0_3_parent_only = (bool)match->data;
af99a7507469d4 drivers/pinctrl/pinctrl-s3c24xx.c         Heiko Stuebner      2013-05-21  476  			break;
af99a7507469d4 drivers/pinctrl/pinctrl-s3c24xx.c         Heiko Stuebner      2013-05-21  477  		}
af99a7507469d4 drivers/pinctrl/pinctrl-s3c24xx.c         Heiko Stuebner      2013-05-21  478  	}
af99a7507469d4 drivers/pinctrl/pinctrl-s3c24xx.c         Heiko Stuebner      2013-05-21  479  	if (!eint_np)
af99a7507469d4 drivers/pinctrl/pinctrl-s3c24xx.c         Heiko Stuebner      2013-05-21  480  		return -ENODEV;
af99a7507469d4 drivers/pinctrl/pinctrl-s3c24xx.c         Heiko Stuebner      2013-05-21  481  
af99a7507469d4 drivers/pinctrl/pinctrl-s3c24xx.c         Heiko Stuebner      2013-05-21  482  	eint_data = devm_kzalloc(dev, sizeof(*eint_data), GFP_KERNEL);
6fbbcb050802d6 drivers/pinctrl/samsung/pinctrl-s3c24xx.c Krzysztof Kozlowski 2019-08-05  483  	if (!eint_data) {
6fbbcb050802d6 drivers/pinctrl/samsung/pinctrl-s3c24xx.c Krzysztof Kozlowski 2019-08-05  484  		of_node_put(eint_np);
af99a7507469d4 drivers/pinctrl/pinctrl-s3c24xx.c         Heiko Stuebner      2013-05-21  485  		return -ENOMEM;
6fbbcb050802d6 drivers/pinctrl/samsung/pinctrl-s3c24xx.c Krzysztof Kozlowski 2019-08-05  486  	}
af99a7507469d4 drivers/pinctrl/pinctrl-s3c24xx.c         Heiko Stuebner      2013-05-21  487  
af99a7507469d4 drivers/pinctrl/pinctrl-s3c24xx.c         Heiko Stuebner      2013-05-21  488  	eint_data->drvdata = d;
af99a7507469d4 drivers/pinctrl/pinctrl-s3c24xx.c         Heiko Stuebner      2013-05-21  489  
af99a7507469d4 drivers/pinctrl/pinctrl-s3c24xx.c         Heiko Stuebner      2013-05-21  490  	handlers = eint0_3_parent_only ? s3c2410_eint_handlers
af99a7507469d4 drivers/pinctrl/pinctrl-s3c24xx.c         Heiko Stuebner      2013-05-21  491  				       : s3c2412_eint_handlers;
af99a7507469d4 drivers/pinctrl/pinctrl-s3c24xx.c         Heiko Stuebner      2013-05-21  492  	for (i = 0; i < NUM_EINT_IRQ; ++i) {
af99a7507469d4 drivers/pinctrl/pinctrl-s3c24xx.c         Heiko Stuebner      2013-05-21  493  		unsigned int irq;
af99a7507469d4 drivers/pinctrl/pinctrl-s3c24xx.c         Heiko Stuebner      2013-05-21  494  
af99a7507469d4 drivers/pinctrl/pinctrl-s3c24xx.c         Heiko Stuebner      2013-05-21  495  		irq = irq_of_parse_and_map(eint_np, i);
af99a7507469d4 drivers/pinctrl/pinctrl-s3c24xx.c         Heiko Stuebner      2013-05-21  496  		if (!irq) {
af99a7507469d4 drivers/pinctrl/pinctrl-s3c24xx.c         Heiko Stuebner      2013-05-21  497  			dev_err(dev, "failed to get wakeup EINT IRQ %d\n", i);
6fbbcb050802d6 drivers/pinctrl/samsung/pinctrl-s3c24xx.c Krzysztof Kozlowski 2019-08-05  498  			of_node_put(eint_np);
af99a7507469d4 drivers/pinctrl/pinctrl-s3c24xx.c         Heiko Stuebner      2013-05-21  499  			return -ENXIO;
af99a7507469d4 drivers/pinctrl/pinctrl-s3c24xx.c         Heiko Stuebner      2013-05-21  500  		}
af99a7507469d4 drivers/pinctrl/pinctrl-s3c24xx.c         Heiko Stuebner      2013-05-21  501  
af99a7507469d4 drivers/pinctrl/pinctrl-s3c24xx.c         Heiko Stuebner      2013-05-21  502  		eint_data->parents[i] = irq;
0cfc45cfdf5065 drivers/pinctrl/samsung/pinctrl-s3c24xx.c Thomas Gleixner     2015-06-21  503  		irq_set_chained_handler_and_data(irq, handlers[i], eint_data);
af99a7507469d4 drivers/pinctrl/pinctrl-s3c24xx.c         Heiko Stuebner      2013-05-21  504  	}
6fbbcb050802d6 drivers/pinctrl/samsung/pinctrl-s3c24xx.c Krzysztof Kozlowski 2019-08-05  505  	of_node_put(eint_np);
af99a7507469d4 drivers/pinctrl/pinctrl-s3c24xx.c         Heiko Stuebner      2013-05-21  506  
1bf00d7a6dbff0 drivers/pinctrl/samsung/pinctrl-s3c24xx.c Tomasz Figa         2014-09-23  507  	bank = d->pin_banks;
1bf00d7a6dbff0 drivers/pinctrl/samsung/pinctrl-s3c24xx.c Tomasz Figa         2014-09-23  508  	for (i = 0; i < d->nr_banks; ++i, ++bank) {
af99a7507469d4 drivers/pinctrl/pinctrl-s3c24xx.c         Heiko Stuebner      2013-05-21  509  		struct s3c24xx_eint_domain_data *ddata;
af99a7507469d4 drivers/pinctrl/pinctrl-s3c24xx.c         Heiko Stuebner      2013-05-21  510  		unsigned int mask;
af99a7507469d4 drivers/pinctrl/pinctrl-s3c24xx.c         Heiko Stuebner      2013-05-21  511  		unsigned int irq;
af99a7507469d4 drivers/pinctrl/pinctrl-s3c24xx.c         Heiko Stuebner      2013-05-21  512  		unsigned int pin;
af99a7507469d4 drivers/pinctrl/pinctrl-s3c24xx.c         Heiko Stuebner      2013-05-21  513  
af99a7507469d4 drivers/pinctrl/pinctrl-s3c24xx.c         Heiko Stuebner      2013-05-21  514  		if (bank->eint_type != EINT_TYPE_WKUP)
af99a7507469d4 drivers/pinctrl/pinctrl-s3c24xx.c         Heiko Stuebner      2013-05-21  515  			continue;
af99a7507469d4 drivers/pinctrl/pinctrl-s3c24xx.c         Heiko Stuebner      2013-05-21  516  
af99a7507469d4 drivers/pinctrl/pinctrl-s3c24xx.c         Heiko Stuebner      2013-05-21  517  		ddata = devm_kzalloc(dev, sizeof(*ddata), GFP_KERNEL);
af99a7507469d4 drivers/pinctrl/pinctrl-s3c24xx.c         Heiko Stuebner      2013-05-21  518  		if (!ddata)
af99a7507469d4 drivers/pinctrl/pinctrl-s3c24xx.c         Heiko Stuebner      2013-05-21  519  			return -ENOMEM;
af99a7507469d4 drivers/pinctrl/pinctrl-s3c24xx.c         Heiko Stuebner      2013-05-21  520  
af99a7507469d4 drivers/pinctrl/pinctrl-s3c24xx.c         Heiko Stuebner      2013-05-21  521  		ddata->bank = bank;
af99a7507469d4 drivers/pinctrl/pinctrl-s3c24xx.c         Heiko Stuebner      2013-05-21  522  		ddata->eint_data = eint_data;
af99a7507469d4 drivers/pinctrl/pinctrl-s3c24xx.c         Heiko Stuebner      2013-05-21  523  		ddata->eint0_3_parent_only = eint0_3_parent_only;
af99a7507469d4 drivers/pinctrl/pinctrl-s3c24xx.c         Heiko Stuebner      2013-05-21  524  
af99a7507469d4 drivers/pinctrl/pinctrl-s3c24xx.c         Heiko Stuebner      2013-05-21  525  		ops = (bank->eint_offset == 0) ? &s3c24xx_gpf_irq_ops
af99a7507469d4 drivers/pinctrl/pinctrl-s3c24xx.c         Heiko Stuebner      2013-05-21  526  					       : &s3c24xx_gpg_irq_ops;
af99a7507469d4 drivers/pinctrl/pinctrl-s3c24xx.c         Heiko Stuebner      2013-05-21  527  
af99a7507469d4 drivers/pinctrl/pinctrl-s3c24xx.c         Heiko Stuebner      2013-05-21 @528  		bank->irq_domain = irq_domain_add_linear(bank->of_node,
af99a7507469d4 drivers/pinctrl/pinctrl-s3c24xx.c         Heiko Stuebner      2013-05-21  529  				bank->nr_pins, ops, ddata);
af99a7507469d4 drivers/pinctrl/pinctrl-s3c24xx.c         Heiko Stuebner      2013-05-21  530  		if (!bank->irq_domain) {
af99a7507469d4 drivers/pinctrl/pinctrl-s3c24xx.c         Heiko Stuebner      2013-05-21  531  			dev_err(dev, "wkup irq domain add failed\n");
af99a7507469d4 drivers/pinctrl/pinctrl-s3c24xx.c         Heiko Stuebner      2013-05-21  532  			return -ENXIO;
af99a7507469d4 drivers/pinctrl/pinctrl-s3c24xx.c         Heiko Stuebner      2013-05-21  533  		}
af99a7507469d4 drivers/pinctrl/pinctrl-s3c24xx.c         Heiko Stuebner      2013-05-21  534  
af99a7507469d4 drivers/pinctrl/pinctrl-s3c24xx.c         Heiko Stuebner      2013-05-21  535  		irq = bank->eint_offset;
af99a7507469d4 drivers/pinctrl/pinctrl-s3c24xx.c         Heiko Stuebner      2013-05-21  536  		mask = bank->eint_mask;
af99a7507469d4 drivers/pinctrl/pinctrl-s3c24xx.c         Heiko Stuebner      2013-05-21  537  		for (pin = 0; mask; ++pin, mask >>= 1) {
774e2d981f517e drivers/pinctrl/pinctrl-s3c24xx.c         Dan Carpenter       2013-08-27  538  			if (irq >= NUM_EINT)
af99a7507469d4 drivers/pinctrl/pinctrl-s3c24xx.c         Heiko Stuebner      2013-05-21  539  				break;
af99a7507469d4 drivers/pinctrl/pinctrl-s3c24xx.c         Heiko Stuebner      2013-05-21  540  			if (!(mask & 1))
af99a7507469d4 drivers/pinctrl/pinctrl-s3c24xx.c         Heiko Stuebner      2013-05-21  541  				continue;
af99a7507469d4 drivers/pinctrl/pinctrl-s3c24xx.c         Heiko Stuebner      2013-05-21  542  			eint_data->domains[irq] = bank->irq_domain;
af99a7507469d4 drivers/pinctrl/pinctrl-s3c24xx.c         Heiko Stuebner      2013-05-21  543  			++irq;
af99a7507469d4 drivers/pinctrl/pinctrl-s3c24xx.c         Heiko Stuebner      2013-05-21  544  		}
af99a7507469d4 drivers/pinctrl/pinctrl-s3c24xx.c         Heiko Stuebner      2013-05-21  545  	}
af99a7507469d4 drivers/pinctrl/pinctrl-s3c24xx.c         Heiko Stuebner      2013-05-21  546  
af99a7507469d4 drivers/pinctrl/pinctrl-s3c24xx.c         Heiko Stuebner      2013-05-21  547  	return 0;
af99a7507469d4 drivers/pinctrl/pinctrl-s3c24xx.c         Heiko Stuebner      2013-05-21  548  }
af99a7507469d4 drivers/pinctrl/pinctrl-s3c24xx.c         Heiko Stuebner      2013-05-21  549  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
