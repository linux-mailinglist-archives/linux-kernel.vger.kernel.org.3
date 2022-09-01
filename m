Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5055B5AA157
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 23:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234970AbiIAVCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 17:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234764AbiIAVCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 17:02:25 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C522673;
        Thu,  1 Sep 2022 14:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662066119; x=1693602119;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6CtZqoEW7JkL01E8OL8dqhLmQxJbdBw2knnKAl5jhTU=;
  b=nLd/NdFUTpAMgYKosLbx/gY6tCWxCaBuqKDzQXajwA0An4/QPcJp4OMh
   RN40zpunh2RpL5DiD7zY17Vllz5vChNneZUGk3fV7/bLepAFMvs3SWnf4
   Rg/iPsjzSK+LIUXxT9MJ1+6sLrdQKRPDeeJ2KFrV1lij5KMFviAjrGYtU
   IwQ0wgsQEio7JxdPZ2zfveiky8M/RtD+r+dtd6Y7kheYo3hy4r1HrsYVN
   uyJH/1l3gLvlpcUp7DBzk0r+shb5vc2BgRqqgvZoagfbvFwLG3GMdGyaz
   Rdmc2e6oH2rYbjtYL+xKeH87bmSkZHU0mzNtzKWPE6CPCpa1pXd+DLmR6
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="294567561"
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="294567561"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 14:01:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="615476370"
Received: from lkp-server02.sh.intel.com (HELO b138c9e8658c) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 01 Sep 2022 14:01:57 -0700
Received: from kbuild by b138c9e8658c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oTrK1-0000lX-08;
        Thu, 01 Sep 2022 21:01:57 +0000
Date:   Fri, 2 Sep 2022 05:01:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 1/1] pinctrl: pistachio: Switch to use fwnode instead
 of of_node
Message-ID: <202209020416.0LCiignM-lkp@intel.com>
References: <20220830193938.56826-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830193938.56826-1-andriy.shevchenko@linux.intel.com>
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

[auto build test ERROR on linusw-pinctrl/devel]
[also build test ERROR on linus/master v6.0-rc3 next-20220901]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/pinctrl-pistachio-Switch-to-use-fwnode-instead-of-of_node/20220831-034037
base:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git devel
config: arm-randconfig-r006-20220901 (https://download.01.org/0day-ci/archive/20220902/202209020416.0LCiignM-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project c55b41d5199d2394dd6cdb8f52180d8b81d809d4)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/intel-lab-lkp/linux/commit/6802887aaf094f08bc139caf331767217f7318a4
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Andy-Shevchenko/pinctrl-pistachio-Switch-to-use-fwnode-instead-of-of_node/20220831-034037
        git checkout 6802887aaf094f08bc139caf331767217f7318a4
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/pinctrl/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/pinctrl/pinctrl-pistachio.c:1360:39: error: use of undeclared identifier 'dev'
                   child = device_get_named_child_node(dev, child_name);
                                                       ^
   1 error generated.


vim +/dev +1360 drivers/pinctrl/pinctrl-pistachio.c

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
