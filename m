Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2115A87C0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 22:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbiHaUxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 16:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231210AbiHaUxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 16:53:30 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74484F23FD;
        Wed, 31 Aug 2022 13:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661979209; x=1693515209;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KKeRnnlsAo9bkSmskdePAcxdL6645n0Y/XUHlwuJx0o=;
  b=SaKNiuPnojNzQGV2huqO/KUa1HGfF26G/27w006x6I/reBQtTinHZrvh
   DWcgQPzAj1f1LZNZ9vNcDmIsvibIQNrS7lLT60TVejASsppspJ+rUcHpF
   ZO9nkjdf5kbp59Jiy3sMAs/e1K09/rxcj0vXIpMFYSgShH6ITyk0QFe0c
   CKooh9WkN3mmralYNPr1+rk5MEAIYwra3+eMXaMBRK6o7+vhkxnefbsD0
   8mqjVyc5nPd+HG6iHqYpdveM79P7sJuK3bruXJprItfO8A14CXJ9J37Ze
   10Kor8rgad3Yrapr5Th8vA15Yg4clkp5Y7YyygcckTkOfWd5LnYTtm4Ts
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10456"; a="275944005"
X-IronPort-AV: E=Sophos;i="5.93,279,1654585200"; 
   d="scan'208";a="275944005"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 13:53:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,279,1654585200"; 
   d="scan'208";a="680566751"
Received: from lkp-server02.sh.intel.com (HELO 811e2ceaf0e5) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 31 Aug 2022 13:53:27 -0700
Received: from kbuild by 811e2ceaf0e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oTUiE-0000hx-1r;
        Wed, 31 Aug 2022 20:53:26 +0000
Date:   Thu, 1 Sep 2022 04:52:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sascha Hauer <s.hauer@pengutronix.de>, linux-gpio@vger.kernel.org
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, kernel@pengutronix.de,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH v2 1/2] gpio: Add gpio latch driver
Message-ID: <202209010432.NKyeVosI-lkp@intel.com>
References: <20220831055811.1936613-2-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220831055811.1936613-2-s.hauer@pengutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sascha,

I love your patch! Yet something to improve:

[auto build test ERROR on brgl/gpio/for-next]
[also build test ERROR on linus/master v6.0-rc3 next-20220830]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sascha-Hauer/gpio-Add-gpio-latch-driver/20220831-135855
base:   https://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git gpio/for-next
config: s390-randconfig-r021-20220831 (https://download.01.org/0day-ci/archive/20220901/202209010432.NKyeVosI-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/8fab8b8c35fd4faebb003751d6d34fc06093c19e
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Sascha-Hauer/gpio-Add-gpio-latch-driver/20220831-135855
        git checkout 8fab8b8c35fd4faebb003751d6d34fc06093c19e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash drivers/gpio/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/gpio/gpio-latch.c: In function 'gpio_latch_probe':
>> drivers/gpio/gpio-latch.c:163:18: error: 'struct gpio_chip' has no member named 'of_node'; did you mean 'fwnode'?
     163 |         priv->gc.of_node = pdev->dev.of_node;
         |                  ^~~~~~~
         |                  fwnode


vim +163 drivers/gpio/gpio-latch.c

   123	
   124	static int gpio_latch_probe(struct platform_device *pdev)
   125	{
   126		struct gpio_latch_priv *priv;
   127	
   128		priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
   129		if (!priv)
   130			return -ENOMEM;
   131	
   132		priv->clk_gpios = devm_gpiod_get_array(&pdev->dev, "clk", GPIOD_OUT_LOW);
   133		if (IS_ERR(priv->clk_gpios))
   134			return PTR_ERR(priv->clk_gpios);
   135	
   136		priv->data_gpios = devm_gpiod_get_array(&pdev->dev, "data", GPIOD_OUT_LOW);
   137		if (IS_ERR(priv->data_gpios))
   138			return PTR_ERR(priv->data_gpios);
   139	
   140		priv->n_ports = priv->clk_gpios->ndescs;
   141		priv->n_pins = priv->data_gpios->ndescs;
   142	
   143		priv->shadow = devm_kcalloc(&pdev->dev, priv->n_ports, sizeof(*priv->shadow),
   144					    GFP_KERNEL);
   145		if (!priv->shadow)
   146			return -ENOMEM;
   147	
   148		if (gpio_latch_can_sleep(priv)) {
   149			priv->gc.can_sleep = true;
   150			priv->gc.set = gpio_latch_set_can_sleep;
   151			mutex_init(&priv->mutex);
   152		} else {
   153			priv->gc.can_sleep = false;
   154			priv->gc.set = gpio_latch_set;
   155			spin_lock_init(&priv->spinlock);
   156		}
   157	
   158		priv->gc.get_direction = gpio_latch_get_direction;
   159		priv->gc.ngpio = priv->n_ports * priv->n_pins;
   160		priv->gc.owner = THIS_MODULE;
   161		priv->gc.base = -1;
   162		priv->gc.parent = &pdev->dev;
 > 163		priv->gc.of_node = pdev->dev.of_node;
   164	
   165		platform_set_drvdata(pdev, priv);
   166	
   167		return devm_gpiochip_add_data(&pdev->dev, &priv->gc, priv);
   168	}
   169	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
