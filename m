Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40DE95A70EB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 00:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232030AbiH3Wkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 18:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiH3Wkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 18:40:39 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 714B661139;
        Tue, 30 Aug 2022 15:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661899237; x=1693435237;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7KStPjHsVShLi+LNjXTCuUly40pj1Id1xR+kRJZWZTg=;
  b=jDWrAi7NR2l5EfAy4EB6wmGQUNfI7JjH6787jJ+3bEk7wvehM+UfkaLM
   w5/lTYPmxebd9u2mK8H6h8azA3FDST9WxATeTQfq+E7aRxhm3tNlR7lZ5
   zZJUxZuv9+TGRFJWWgI7mM0WtrHdvPIi+YdVIh9hkZrRtHaEK0jY8Z7Rs
   zKf9ODWnXVbXwC4az/pnmYxcLTtioRzfa/7/t61BiN5C/Xx3UxwAqz0JI
   GOwFHOT/gk4asacaVxVOvUKRuaNXJry50pzpEDR5yTRj+XzYf4stP8dk8
   9yLseYCvFJo/MRpdVBgxQZDXDhqjV9QZmguKHFMJK2wfhWT5vjhzisBZs
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="275071211"
X-IronPort-AV: E=Sophos;i="5.93,276,1654585200"; 
   d="scan'208";a="275071211"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 15:40:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,276,1654585200"; 
   d="scan'208";a="562835616"
Received: from lkp-server02.sh.intel.com (HELO 77b6d4e16fc5) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 30 Aug 2022 15:40:35 -0700
Received: from kbuild by 77b6d4e16fc5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oT9uM-0000hL-2K;
        Tue, 30 Aug 2022 22:40:34 +0000
Date:   Wed, 31 Aug 2022 06:39:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 1/1] pinctrl: pistachio: Switch to use fwnode instead
 of of_node
Message-ID: <202208310643.sf31JN8Y-lkp@intel.com>
References: <20220830193938.56826-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830193938.56826-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

I love your patch! Yet something to improve:

[auto build test ERROR on linusw-pinctrl/devel]
[also build test ERROR on linus/master v6.0-rc3 next-20220830]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/pinctrl-pistachio-Switch-to-use-fwnode-instead-of-of_node/20220831-034037
base:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git devel
config: arc-randconfig-r043-20220830 (https://download.01.org/0day-ci/archive/20220831/202208310643.sf31JN8Y-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/6802887aaf094f08bc139caf331767217f7318a4
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Andy-Shevchenko/pinctrl-pistachio-Switch-to-use-fwnode-instead-of-of_node/20220831-034037
        git checkout 6802887aaf094f08bc139caf331767217f7318a4
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/pinctrl/pinctrl-pistachio.c: In function 'pistachio_gpio_register':
>> drivers/pinctrl/pinctrl-pistachio.c:1360:53: error: 'dev' undeclared (first use in this function); did you mean 'cdev'?
    1360 |                 child = device_get_named_child_node(dev, child_name);
         |                                                     ^~~
         |                                                     cdev
   drivers/pinctrl/pinctrl-pistachio.c:1360:53: note: each undeclared identifier is reported only once for each function it appears in


vim +1360 drivers/pinctrl/pinctrl-pistachio.c

  1347	
  1348	static int pistachio_gpio_register(struct pistachio_pinctrl *pctl)
  1349	{
  1350		struct pistachio_gpio_bank *bank;
  1351		unsigned int i;
  1352		int irq, ret = 0;
  1353	
  1354		for (i = 0; i < pctl->nbanks; i++) {
  1355			char child_name[sizeof("gpioXX")];
  1356			struct fwnode_handle *child;
  1357			struct gpio_irq_chip *girq;
  1358	
  1359			snprintf(child_name, sizeof(child_name), "gpio%d", i);
> 1360			child = device_get_named_child_node(dev, child_name);
  1361			if (!child) {
  1362				dev_err(pctl->dev, "No node for bank %u\n", i);
  1363				ret = -ENODEV;
  1364				goto err;
  1365			}
  1366	
  1367			if (!fwnode_property_present(child, "gpio-controller")) {
  1368				fwnode_handle_put(child);
  1369				dev_err(pctl->dev,
  1370					"No gpio-controller property for bank %u\n", i);
  1371				ret = -ENODEV;
  1372				goto err;
  1373			}
  1374	
  1375			ret = fwnode_irq_get(child, 0);
  1376			if (ret < 0) {
  1377				fwnode_handle_put(child);
  1378				dev_err(pctl->dev, "No IRQ for bank %u\n", i);
  1379				goto err;
  1380			}
  1381			irq = ret;
  1382	
  1383			bank = &pctl->gpio_banks[i];
  1384			bank->pctl = pctl;
  1385			bank->base = pctl->base + GPIO_BANK_BASE(i);
  1386	
  1387			bank->gpio_chip.parent = pctl->dev;
  1388			bank->gpio_chip.fwnode = child;
  1389	
  1390			girq = &bank->gpio_chip.irq;
  1391			girq->chip = &bank->irq_chip;
  1392			girq->parent_handler = pistachio_gpio_irq_handler;
  1393			girq->num_parents = 1;
  1394			girq->parents = devm_kcalloc(pctl->dev, 1,
  1395						     sizeof(*girq->parents),
  1396						     GFP_KERNEL);
  1397			if (!girq->parents) {
  1398				ret = -ENOMEM;
  1399				goto err;
  1400			}
  1401			girq->parents[0] = irq;
  1402			girq->default_type = IRQ_TYPE_NONE;
  1403			girq->handler = handle_level_irq;
  1404	
  1405			ret = gpiochip_add_data(&bank->gpio_chip, bank);
  1406			if (ret < 0) {
  1407				dev_err(pctl->dev, "Failed to add GPIO chip %u: %d\n",
  1408					i, ret);
  1409				goto err;
  1410			}
  1411	
  1412			ret = gpiochip_add_pin_range(&bank->gpio_chip,
  1413						     dev_name(pctl->dev), 0,
  1414						     bank->pin_base, bank->npins);
  1415			if (ret < 0) {
  1416				dev_err(pctl->dev, "Failed to add GPIO range %u: %d\n",
  1417					i, ret);
  1418				gpiochip_remove(&bank->gpio_chip);
  1419				goto err;
  1420			}
  1421		}
  1422	
  1423		return 0;
  1424	err:
  1425		for (; i > 0; i--) {
  1426			bank = &pctl->gpio_banks[i - 1];
  1427			gpiochip_remove(&bank->gpio_chip);
  1428		}
  1429		return ret;
  1430	}
  1431	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
