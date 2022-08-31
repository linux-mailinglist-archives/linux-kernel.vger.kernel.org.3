Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A95AA5A7553
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 06:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbiHaE7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 00:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiHaE7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 00:59:00 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 608E7B5E53;
        Tue, 30 Aug 2022 21:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661921939; x=1693457939;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UXwZdL0jjh4vfwy9s4JYZLaz8covq172P8dUfve+MB0=;
  b=WtRdO+SKEjuAChTW4lkCChgXeWokcq/jQNQa6UEQy8qB6hZsPfG5EEkM
   v4lUPSlzT5OmX9a8mQgEUsEmXhaum6Fq/psK+L1D9sqic/4tDNtZFvg7M
   BO5mJ1pSYu4rP8q6V6VqTl5mZIcxFUpPJrFih9GF0cW7reOwpRj3HQt7U
   NLXqk2cNlvrhDhX0BwUWrBwJh4MRKZc4qiLM8dm6AW3gQpnB8MQpqjMvA
   p5xviAd455J4osva9gwh0aAkaz3Ghi76ZhYK+XdkxY/lY5YzkksTSFCSV
   q5eygzZ/x1zOQjtSBkPyJmlB7lXzoUyQ5Eq7hVm4fvTk1kIVRLUToxXYB
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="321510942"
X-IronPort-AV: E=Sophos;i="5.93,276,1654585200"; 
   d="scan'208";a="321510942"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 21:58:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,276,1654585200"; 
   d="scan'208";a="562914998"
Received: from lkp-server02.sh.intel.com (HELO 77b6d4e16fc5) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 30 Aug 2022 21:58:55 -0700
Received: from kbuild by 77b6d4e16fc5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oTFoU-000111-0l;
        Wed, 31 Aug 2022 04:58:54 +0000
Date:   Wed, 31 Aug 2022 12:58:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Raul E Rangel <rrangel@chromium.org>, linux-acpi@vger.kernel.org,
        linux-input@vger.kernel.org
Cc:     kbuild-all@lists.01.org, hdegoede@redhat.com,
        mario.limonciello@amd.com, timvp@google.com, rafael@kernel.org,
        Raul E Rangel <rrangel@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Len Brown <lenb@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] gpiolib: acpi: Add wake_capable parameter to
 acpi_dev_gpio_irq_get_by
Message-ID: <202208311235.pxWOoHPE-lkp@intel.com>
References: <20220830171332.3.I4ff95ba7e884a486d7814ee888bf864be2ebdef4@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830171332.3.I4ff95ba7e884a486d7814ee888bf864be2ebdef4@changeid>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Raul,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on hid/for-next]
[also build test ERROR on brgl/gpio/for-next rafael-pm/linux-next linus/master v6.0-rc3 next-20220830]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Raul-E-Rangel/acpi-i2c-Use-SharedAndWake-and-ExclusiveAndWake-to-enable-wake-irq/20220831-071916
base:   https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-next
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20220831/202208311235.pxWOoHPE-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/131a07025a591f4ca6d7540f1055bc03f8cf64af
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Raul-E-Rangel/acpi-i2c-Use-SharedAndWake-and-ExclusiveAndWake-to-enable-wake-irq/20220831-071916
        git checkout 131a07025a591f4ca6d7540f1055bc03f8cf64af
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sh SHELL=/bin/bash drivers/net/ethernet/mellanox/mlxbf_gige/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c: In function 'mlxbf_gige_probe':
>> drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c:343:19: error: too few arguments to function 'acpi_dev_gpio_irq_get_by'
     343 |         phy_irq = acpi_dev_gpio_irq_get_by(ACPI_COMPANION(&pdev->dev), "phy-gpios", 0);
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c:8:
   include/linux/acpi.h:1212:19: note: declared here
    1212 | static inline int acpi_dev_gpio_irq_get_by(struct acpi_device *adev,
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~


vim +/acpi_dev_gpio_irq_get_by +343 drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c

f92e1869d74e1a David Thompson 2021-06-24  272  
f92e1869d74e1a David Thompson 2021-06-24  273  static int mlxbf_gige_probe(struct platform_device *pdev)
f92e1869d74e1a David Thompson 2021-06-24  274  {
f92e1869d74e1a David Thompson 2021-06-24  275  	struct phy_device *phydev;
f92e1869d74e1a David Thompson 2021-06-24  276  	struct net_device *netdev;
f92e1869d74e1a David Thompson 2021-06-24  277  	struct mlxbf_gige *priv;
f92e1869d74e1a David Thompson 2021-06-24  278  	void __iomem *llu_base;
f92e1869d74e1a David Thompson 2021-06-24  279  	void __iomem *plu_base;
f92e1869d74e1a David Thompson 2021-06-24  280  	void __iomem *base;
6c2a6ddca76327 Asmaa Mnebhi   2021-10-15  281  	int addr, phy_irq;
f92e1869d74e1a David Thompson 2021-06-24  282  	u64 control;
f92e1869d74e1a David Thompson 2021-06-24  283  	int err;
f92e1869d74e1a David Thompson 2021-06-24  284  
464a57281f29af Cai Huoqing    2021-08-31  285  	base = devm_platform_ioremap_resource(pdev, MLXBF_GIGE_RES_MAC);
f92e1869d74e1a David Thompson 2021-06-24  286  	if (IS_ERR(base))
f92e1869d74e1a David Thompson 2021-06-24  287  		return PTR_ERR(base);
f92e1869d74e1a David Thompson 2021-06-24  288  
464a57281f29af Cai Huoqing    2021-08-31  289  	llu_base = devm_platform_ioremap_resource(pdev, MLXBF_GIGE_RES_LLU);
f92e1869d74e1a David Thompson 2021-06-24  290  	if (IS_ERR(llu_base))
f92e1869d74e1a David Thompson 2021-06-24  291  		return PTR_ERR(llu_base);
f92e1869d74e1a David Thompson 2021-06-24  292  
464a57281f29af Cai Huoqing    2021-08-31  293  	plu_base = devm_platform_ioremap_resource(pdev, MLXBF_GIGE_RES_PLU);
f92e1869d74e1a David Thompson 2021-06-24  294  	if (IS_ERR(plu_base))
f92e1869d74e1a David Thompson 2021-06-24  295  		return PTR_ERR(plu_base);
f92e1869d74e1a David Thompson 2021-06-24  296  
f92e1869d74e1a David Thompson 2021-06-24  297  	/* Perform general init of GigE block */
f92e1869d74e1a David Thompson 2021-06-24  298  	control = readq(base + MLXBF_GIGE_CONTROL);
f92e1869d74e1a David Thompson 2021-06-24  299  	control |= MLXBF_GIGE_CONTROL_PORT_EN;
f92e1869d74e1a David Thompson 2021-06-24  300  	writeq(control, base + MLXBF_GIGE_CONTROL);
f92e1869d74e1a David Thompson 2021-06-24  301  
f92e1869d74e1a David Thompson 2021-06-24  302  	netdev = devm_alloc_etherdev(&pdev->dev, sizeof(*priv));
f92e1869d74e1a David Thompson 2021-06-24  303  	if (!netdev)
f92e1869d74e1a David Thompson 2021-06-24  304  		return -ENOMEM;
f92e1869d74e1a David Thompson 2021-06-24  305  
f92e1869d74e1a David Thompson 2021-06-24  306  	SET_NETDEV_DEV(netdev, &pdev->dev);
f92e1869d74e1a David Thompson 2021-06-24  307  	netdev->netdev_ops = &mlxbf_gige_netdev_ops;
f92e1869d74e1a David Thompson 2021-06-24  308  	netdev->ethtool_ops = &mlxbf_gige_ethtool_ops;
f92e1869d74e1a David Thompson 2021-06-24  309  	priv = netdev_priv(netdev);
f92e1869d74e1a David Thompson 2021-06-24  310  	priv->netdev = netdev;
f92e1869d74e1a David Thompson 2021-06-24  311  
f92e1869d74e1a David Thompson 2021-06-24  312  	platform_set_drvdata(pdev, priv);
f92e1869d74e1a David Thompson 2021-06-24  313  	priv->dev = &pdev->dev;
f92e1869d74e1a David Thompson 2021-06-24  314  	priv->pdev = pdev;
f92e1869d74e1a David Thompson 2021-06-24  315  
f92e1869d74e1a David Thompson 2021-06-24  316  	spin_lock_init(&priv->lock);
f92e1869d74e1a David Thompson 2021-06-24  317  
f92e1869d74e1a David Thompson 2021-06-24  318  	/* Attach MDIO device */
f92e1869d74e1a David Thompson 2021-06-24  319  	err = mlxbf_gige_mdio_probe(pdev, priv);
f92e1869d74e1a David Thompson 2021-06-24  320  	if (err)
f92e1869d74e1a David Thompson 2021-06-24  321  		return err;
f92e1869d74e1a David Thompson 2021-06-24  322  
f92e1869d74e1a David Thompson 2021-06-24  323  	priv->base = base;
f92e1869d74e1a David Thompson 2021-06-24  324  	priv->llu_base = llu_base;
f92e1869d74e1a David Thompson 2021-06-24  325  	priv->plu_base = plu_base;
f92e1869d74e1a David Thompson 2021-06-24  326  
f92e1869d74e1a David Thompson 2021-06-24  327  	priv->rx_q_entries = MLXBF_GIGE_DEFAULT_RXQ_SZ;
f92e1869d74e1a David Thompson 2021-06-24  328  	priv->tx_q_entries = MLXBF_GIGE_DEFAULT_TXQ_SZ;
f92e1869d74e1a David Thompson 2021-06-24  329  
f92e1869d74e1a David Thompson 2021-06-24  330  	/* Write initial MAC address to hardware */
f92e1869d74e1a David Thompson 2021-06-24  331  	mlxbf_gige_initial_mac(priv);
f92e1869d74e1a David Thompson 2021-06-24  332  
f92e1869d74e1a David Thompson 2021-06-24  333  	err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
f92e1869d74e1a David Thompson 2021-06-24  334  	if (err) {
f92e1869d74e1a David Thompson 2021-06-24  335  		dev_err(&pdev->dev, "DMA configuration failed: 0x%x\n", err);
f92e1869d74e1a David Thompson 2021-06-24  336  		goto out;
f92e1869d74e1a David Thompson 2021-06-24  337  	}
f92e1869d74e1a David Thompson 2021-06-24  338  
f92e1869d74e1a David Thompson 2021-06-24  339  	priv->error_irq = platform_get_irq(pdev, MLXBF_GIGE_ERROR_INTR_IDX);
f92e1869d74e1a David Thompson 2021-06-24  340  	priv->rx_irq = platform_get_irq(pdev, MLXBF_GIGE_RECEIVE_PKT_INTR_IDX);
f92e1869d74e1a David Thompson 2021-06-24  341  	priv->llu_plu_irq = platform_get_irq(pdev, MLXBF_GIGE_LLU_PLU_INTR_IDX);
f92e1869d74e1a David Thompson 2021-06-24  342  
6c2a6ddca76327 Asmaa Mnebhi   2021-10-15 @343  	phy_irq = acpi_dev_gpio_irq_get_by(ACPI_COMPANION(&pdev->dev), "phy-gpios", 0);
6c2a6ddca76327 Asmaa Mnebhi   2021-10-15  344  	if (phy_irq < 0) {
6c2a6ddca76327 Asmaa Mnebhi   2021-10-15  345  		dev_err(&pdev->dev, "Error getting PHY irq. Use polling instead");
6c2a6ddca76327 Asmaa Mnebhi   2021-10-15  346  		phy_irq = PHY_POLL;
6c2a6ddca76327 Asmaa Mnebhi   2021-10-15  347  	}
6c2a6ddca76327 Asmaa Mnebhi   2021-10-15  348  
f92e1869d74e1a David Thompson 2021-06-24  349  	phydev = phy_find_first(priv->mdiobus);
f92e1869d74e1a David Thompson 2021-06-24  350  	if (!phydev) {
f92e1869d74e1a David Thompson 2021-06-24  351  		err = -ENODEV;
f92e1869d74e1a David Thompson 2021-06-24  352  		goto out;
f92e1869d74e1a David Thompson 2021-06-24  353  	}
f92e1869d74e1a David Thompson 2021-06-24  354  
f92e1869d74e1a David Thompson 2021-06-24  355  	addr = phydev->mdio.addr;
6c2a6ddca76327 Asmaa Mnebhi   2021-10-15  356  	priv->mdiobus->irq[addr] = phy_irq;
6c2a6ddca76327 Asmaa Mnebhi   2021-10-15  357  	phydev->irq = phy_irq;
f92e1869d74e1a David Thompson 2021-06-24  358  
f92e1869d74e1a David Thompson 2021-06-24  359  	err = phy_connect_direct(netdev, phydev,
f92e1869d74e1a David Thompson 2021-06-24  360  				 mlxbf_gige_adjust_link,
f92e1869d74e1a David Thompson 2021-06-24  361  				 PHY_INTERFACE_MODE_GMII);
f92e1869d74e1a David Thompson 2021-06-24  362  	if (err) {
f92e1869d74e1a David Thompson 2021-06-24  363  		dev_err(&pdev->dev, "Could not attach to PHY\n");
f92e1869d74e1a David Thompson 2021-06-24  364  		goto out;
f92e1869d74e1a David Thompson 2021-06-24  365  	}
f92e1869d74e1a David Thompson 2021-06-24  366  
f92e1869d74e1a David Thompson 2021-06-24  367  	/* MAC only supports 1000T full duplex mode */
f92e1869d74e1a David Thompson 2021-06-24  368  	phy_remove_link_mode(phydev, ETHTOOL_LINK_MODE_1000baseT_Half_BIT);
f92e1869d74e1a David Thompson 2021-06-24  369  	phy_remove_link_mode(phydev, ETHTOOL_LINK_MODE_100baseT_Full_BIT);
f92e1869d74e1a David Thompson 2021-06-24  370  	phy_remove_link_mode(phydev, ETHTOOL_LINK_MODE_100baseT_Half_BIT);
f92e1869d74e1a David Thompson 2021-06-24  371  	phy_remove_link_mode(phydev, ETHTOOL_LINK_MODE_10baseT_Full_BIT);
f92e1869d74e1a David Thompson 2021-06-24  372  	phy_remove_link_mode(phydev, ETHTOOL_LINK_MODE_10baseT_Half_BIT);
f92e1869d74e1a David Thompson 2021-06-24  373  
f92e1869d74e1a David Thompson 2021-06-24  374  	/* Only symmetric pause with flow control enabled is supported so no
f92e1869d74e1a David Thompson 2021-06-24  375  	 * need to negotiate pause.
f92e1869d74e1a David Thompson 2021-06-24  376  	 */
f92e1869d74e1a David Thompson 2021-06-24  377  	linkmode_clear_bit(ETHTOOL_LINK_MODE_Pause_BIT, phydev->advertising);
f92e1869d74e1a David Thompson 2021-06-24  378  	linkmode_clear_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT, phydev->advertising);
f92e1869d74e1a David Thompson 2021-06-24  379  
f92e1869d74e1a David Thompson 2021-06-24  380  	/* Display information about attached PHY device */
f92e1869d74e1a David Thompson 2021-06-24  381  	phy_attached_info(phydev);
f92e1869d74e1a David Thompson 2021-06-24  382  
f92e1869d74e1a David Thompson 2021-06-24  383  	err = register_netdev(netdev);
f92e1869d74e1a David Thompson 2021-06-24  384  	if (err) {
f92e1869d74e1a David Thompson 2021-06-24  385  		dev_err(&pdev->dev, "Failed to register netdev\n");
f92e1869d74e1a David Thompson 2021-06-24  386  		phy_disconnect(phydev);
f92e1869d74e1a David Thompson 2021-06-24  387  		goto out;
f92e1869d74e1a David Thompson 2021-06-24  388  	}
f92e1869d74e1a David Thompson 2021-06-24  389  
f92e1869d74e1a David Thompson 2021-06-24  390  	return 0;
f92e1869d74e1a David Thompson 2021-06-24  391  
f92e1869d74e1a David Thompson 2021-06-24  392  out:
f92e1869d74e1a David Thompson 2021-06-24  393  	mlxbf_gige_mdio_remove(priv);
f92e1869d74e1a David Thompson 2021-06-24  394  	return err;
f92e1869d74e1a David Thompson 2021-06-24  395  }
f92e1869d74e1a David Thompson 2021-06-24  396  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
