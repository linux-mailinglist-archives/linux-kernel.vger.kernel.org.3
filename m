Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A1B565E42
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 22:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233764AbiGDUJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 16:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiGDUJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 16:09:52 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34826391;
        Mon,  4 Jul 2022 13:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656965391; x=1688501391;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dORptIljIbU1gDl2c5HL9A7Fj0TfMaBEiP2o3fiaXmU=;
  b=QbpMYlgwxRi9sO+SJ+Nmze7nlhLZ1fh6/72/ZHLt08a7ZB7X7sqSojtF
   GjZjE6Lm3P7wrizSL5HDBuoMyduCrNPz7/rO08rG7tNE7i5HqcZC09zS8
   craqKYNEQgsw5Ug21z6DpbIFQhf+DPAs9KRQSjwjEBB3xPKioBMFI+j9Q
   RbnlZyY/5gaT6wIBNgkmhzbqerAY60je7grqcjTyvIBPt9omWv4Jt6tla
   NgwngxBl+Qfoqaj9L9RlrHlnuGEHv0vBSm03hbBPmoGUa8bzD75cc+8Y/
   826klEvGHzEx5+Tw4NuKRHrUgbPz0ZeO+t/onffCunumqHjgSTLsGwbZK
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10398"; a="281949639"
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="281949639"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2022 13:09:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="919458027"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 04 Jul 2022 13:09:49 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o8SOC-000I93-D6;
        Mon, 04 Jul 2022 20:09:48 +0000
Date:   Tue, 5 Jul 2022 04:09:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linus.walleij@linaro.org, brgl@bgdev.pl
Cc:     kbuild-all@lists.01.org, bjorn.andersson@linaro.org,
        sboyd@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        masneyb@onstation.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH] pinctrl: qcom-pmic-gpio: Make irqchip immutable
Message-ID: <202207050342.WcNFJKKy-lkp@intel.com>
References: <20220704150527.361470-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220704150527.361470-1-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Manivannan,

I love your patch! Perhaps something to improve:

[auto build test WARNING on linusw-pinctrl/devel]
[also build test WARNING on linus/master v5.19-rc5 next-20220704]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Manivannan-Sadhasivam/pinctrl-qcom-pmic-gpio-Make-irqchip-immutable/20220704-230712
base:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git devel
config: arm-defconfig (https://download.01.org/0day-ci/archive/20220705/202207050342.WcNFJKKy-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/4de81cf5dd3098fa10c3e384d497e024675cf068
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Manivannan-Sadhasivam/pinctrl-qcom-pmic-gpio-Make-irqchip-immutable/20220704-230712
        git checkout 4de81cf5dd3098fa10c3e384d497e024675cf068
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/pinctrl/qcom/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/pinctrl/qcom/pinctrl-spmi-gpio.c:998:37: warning: excess elements in struct initializer
     998 |         .flags = IRQCHIP_IMMUTABLE, IRQCHIP_MASK_ON_SUSPEND,
         |                                     ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/qcom/pinctrl-spmi-gpio.c:998:37: note: (near initialization for 'pmic_gpio_irqchip')


vim +998 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c

   990	
   991	static const struct irq_chip pmic_gpio_irqchip = {
   992		.name = "spmi-gpio",
   993		.irq_ack = irq_chip_ack_parent,
   994		.irq_mask = irq_chip_mask_parent,
   995		.irq_unmask = irq_chip_unmask_parent,
   996		.irq_set_type = irq_chip_set_type_parent,
   997		.irq_set_wake = irq_chip_set_wake_parent,
 > 998		.flags = IRQCHIP_IMMUTABLE, IRQCHIP_MASK_ON_SUSPEND,
   999		GPIOCHIP_IRQ_RESOURCE_HELPERS,
  1000	};
  1001	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
