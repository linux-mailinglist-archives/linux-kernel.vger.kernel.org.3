Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C964746D8C9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 17:45:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237241AbhLHQt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 11:49:26 -0500
Received: from mga11.intel.com ([192.55.52.93]:30442 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237230AbhLHQt0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 11:49:26 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10192"; a="235379384"
X-IronPort-AV: E=Sophos;i="5.88,190,1635231600"; 
   d="scan'208";a="235379384"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 08:45:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,190,1635231600"; 
   d="scan'208";a="600818280"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Dec 2021 08:45:50 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mv04j-0000oS-RM; Wed, 08 Dec 2021 16:45:49 +0000
Date:   Thu, 9 Dec 2021 00:45:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [arnd-playground:randconfig-5.17-next 148/205]
 drivers/spi/spi-mpc52xx.c:441:29: error: invalid use of flexible array
 member
Message-ID: <202112090049.RctnOUxU-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git randconfig-5.17-next
head:   fdcc9acc26de65e7b1b8cebc3089b7666be25681
commit: 5de8ac6b8ccee6f1f892b4fa6dc16781de0c3ba8 [148/205] replace most of_gpio_get
config: powerpc-randconfig-p001-20211207 (https://download.01.org/0day-ci/archive/20211209/202112090049.RctnOUxU-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git/commit/?id=5de8ac6b8ccee6f1f892b4fa6dc16781de0c3ba8
        git remote add arnd-playground https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git
        git fetch --no-tags arnd-playground randconfig-5.17-next
        git checkout 5de8ac6b8ccee6f1f892b4fa6dc16781de0c3ba8
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/spi/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/spi/spi-mpc52xx.c: In function 'mpc52xx_spi_probe':
>> drivers/spi/spi-mpc52xx.c:441:29: error: invalid use of flexible array member
     441 |                 ms->gpio_cs = kmalloc_array(ms->gpio_cs_count,
         |                             ^
>> drivers/spi/spi-mpc52xx.c:497:17: error: implicit declaration of function 'gpio_put'; did you mean 'gpiod_put'? [-Werror=implicit-function-declaration]
     497 |                 gpio_put(ms->gpio_cs[i]);
         |                 ^~~~~~~~
         |                 gpiod_put
   cc1: some warnings being treated as errors


vim +441 drivers/spi/spi-mpc52xx.c

42bbb70980f372 drivers/spi/mpc52xx_spi.c Grant Likely       2009-11-04  377  
42bbb70980f372 drivers/spi/mpc52xx_spi.c Grant Likely       2009-11-04  378  /*
42bbb70980f372 drivers/spi/mpc52xx_spi.c Grant Likely       2009-11-04  379   * OF Platform Bus Binding
42bbb70980f372 drivers/spi/mpc52xx_spi.c Grant Likely       2009-11-04  380   */
fd4a319bc933ae drivers/spi/spi-mpc52xx.c Grant Likely       2012-12-07  381  static int mpc52xx_spi_probe(struct platform_device *op)
42bbb70980f372 drivers/spi/mpc52xx_spi.c Grant Likely       2009-11-04  382  {
42bbb70980f372 drivers/spi/mpc52xx_spi.c Grant Likely       2009-11-04  383  	struct spi_master *master;
42bbb70980f372 drivers/spi/mpc52xx_spi.c Grant Likely       2009-11-04  384  	struct mpc52xx_spi *ms;
42bbb70980f372 drivers/spi/mpc52xx_spi.c Grant Likely       2009-11-04  385  	void __iomem *regs;
4a495b1c43ed2e drivers/spi/mpc52xx_spi.c Luotao Fu          2009-11-13  386  	u8 ctrl1;
b8d4e2ce60b632 drivers/spi/mpc52xx_spi.c Luotao Fu          2009-11-13  387  	int rc, i = 0;
5de8ac6b8ccee6 drivers/spi/spi-mpc52xx.c Arnd Bergmann      2021-11-08  388  	struct gpio_desc *gpio_cs;
42bbb70980f372 drivers/spi/mpc52xx_spi.c Grant Likely       2009-11-04  389  
42bbb70980f372 drivers/spi/mpc52xx_spi.c Grant Likely       2009-11-04  390  	/* MMIO registers */
42bbb70980f372 drivers/spi/mpc52xx_spi.c Grant Likely       2009-11-04  391  	dev_dbg(&op->dev, "probing mpc5200 SPI device\n");
61c7a080a5a061 drivers/spi/mpc52xx_spi.c Grant Likely       2010-04-13  392  	regs = of_iomap(op->dev.of_node, 0);
42bbb70980f372 drivers/spi/mpc52xx_spi.c Grant Likely       2009-11-04  393  	if (!regs)
42bbb70980f372 drivers/spi/mpc52xx_spi.c Grant Likely       2009-11-04  394  		return -ENODEV;
42bbb70980f372 drivers/spi/mpc52xx_spi.c Grant Likely       2009-11-04  395  
42bbb70980f372 drivers/spi/mpc52xx_spi.c Grant Likely       2009-11-04  396  	/* initialize the device */
4a495b1c43ed2e drivers/spi/mpc52xx_spi.c Luotao Fu          2009-11-13  397  	ctrl1 = SPI_CTRL1_SPIE | SPI_CTRL1_SPE | SPI_CTRL1_MSTR;
4a495b1c43ed2e drivers/spi/mpc52xx_spi.c Luotao Fu          2009-11-13  398  	out_8(regs + SPI_CTRL1, ctrl1);
42bbb70980f372 drivers/spi/mpc52xx_spi.c Grant Likely       2009-11-04  399  	out_8(regs + SPI_CTRL2, 0x0);
42bbb70980f372 drivers/spi/mpc52xx_spi.c Grant Likely       2009-11-04  400  	out_8(regs + SPI_DATADIR, 0xe);	/* Set output pins */
42bbb70980f372 drivers/spi/mpc52xx_spi.c Grant Likely       2009-11-04  401  	out_8(regs + SPI_PORTDATA, 0x8);	/* Deassert /SS signal */
42bbb70980f372 drivers/spi/mpc52xx_spi.c Grant Likely       2009-11-04  402  
42bbb70980f372 drivers/spi/mpc52xx_spi.c Grant Likely       2009-11-04  403  	/* Clear the status register and re-read it to check for a MODF
42bbb70980f372 drivers/spi/mpc52xx_spi.c Grant Likely       2009-11-04  404  	 * failure.  This driver cannot currently handle multiple masters
42bbb70980f372 drivers/spi/mpc52xx_spi.c Grant Likely       2009-11-04  405  	 * on the SPI bus.  This fault will also occur if the SPI signals
42bbb70980f372 drivers/spi/mpc52xx_spi.c Grant Likely       2009-11-04  406  	 * are not connected to any pins (port_config setting) */
42bbb70980f372 drivers/spi/mpc52xx_spi.c Grant Likely       2009-11-04  407  	in_8(regs + SPI_STATUS);
4a495b1c43ed2e drivers/spi/mpc52xx_spi.c Luotao Fu          2009-11-13  408  	out_8(regs + SPI_CTRL1, ctrl1);
4a495b1c43ed2e drivers/spi/mpc52xx_spi.c Luotao Fu          2009-11-13  409  
42bbb70980f372 drivers/spi/mpc52xx_spi.c Grant Likely       2009-11-04  410  	in_8(regs + SPI_DATA);
42bbb70980f372 drivers/spi/mpc52xx_spi.c Grant Likely       2009-11-04  411  	if (in_8(regs + SPI_STATUS) & SPI_STATUS_MODF) {
42bbb70980f372 drivers/spi/mpc52xx_spi.c Grant Likely       2009-11-04  412  		dev_err(&op->dev, "mode fault; is port_config correct?\n");
42bbb70980f372 drivers/spi/mpc52xx_spi.c Grant Likely       2009-11-04  413  		rc = -EIO;
42bbb70980f372 drivers/spi/mpc52xx_spi.c Grant Likely       2009-11-04  414  		goto err_init;
42bbb70980f372 drivers/spi/mpc52xx_spi.c Grant Likely       2009-11-04  415  	}
42bbb70980f372 drivers/spi/mpc52xx_spi.c Grant Likely       2009-11-04  416  
42bbb70980f372 drivers/spi/mpc52xx_spi.c Grant Likely       2009-11-04  417  	dev_dbg(&op->dev, "allocating spi_master struct\n");
ac7357ac769e3b drivers/spi/spi-mpc52xx.c Zhiqi Song         2021-05-18  418  	master = spi_alloc_master(&op->dev, sizeof(*ms));
42bbb70980f372 drivers/spi/mpc52xx_spi.c Grant Likely       2009-11-04  419  	if (!master) {
42bbb70980f372 drivers/spi/mpc52xx_spi.c Grant Likely       2009-11-04  420  		rc = -ENOMEM;
42bbb70980f372 drivers/spi/mpc52xx_spi.c Grant Likely       2009-11-04  421  		goto err_alloc;
42bbb70980f372 drivers/spi/mpc52xx_spi.c Grant Likely       2009-11-04  422  	}
b8d4e2ce60b632 drivers/spi/mpc52xx_spi.c Luotao Fu          2009-11-13  423  
42bbb70980f372 drivers/spi/mpc52xx_spi.c Grant Likely       2009-11-04  424  	master->transfer = mpc52xx_spi_transfer;
d65aea99bd9e1d drivers/spi/mpc52xx_spi.c Luotao Fu          2009-11-13  425  	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_LSB_FIRST;
5c5989ccd32c37 drivers/spi/spi-mpc52xx.c Axel Lin           2014-03-28  426  	master->bits_per_word_mask = SPI_BPW_MASK(8);
12b15e83289bc7 drivers/spi/mpc52xx_spi.c Anatolij Gustschin 2010-07-27  427  	master->dev.of_node = op->dev.of_node;
d65aea99bd9e1d drivers/spi/mpc52xx_spi.c Luotao Fu          2009-11-13  428  
24b5a82cf5709a drivers/spi/spi-mpc52xx.c Jingoo Han         2013-05-23  429  	platform_set_drvdata(op, master);
42bbb70980f372 drivers/spi/mpc52xx_spi.c Grant Likely       2009-11-04  430  
42bbb70980f372 drivers/spi/mpc52xx_spi.c Grant Likely       2009-11-04  431  	ms = spi_master_get_devdata(master);
42bbb70980f372 drivers/spi/mpc52xx_spi.c Grant Likely       2009-11-04  432  	ms->master = master;
42bbb70980f372 drivers/spi/mpc52xx_spi.c Grant Likely       2009-11-04  433  	ms->regs = regs;
61c7a080a5a061 drivers/spi/mpc52xx_spi.c Grant Likely       2010-04-13  434  	ms->irq0 = irq_of_parse_and_map(op->dev.of_node, 0);
61c7a080a5a061 drivers/spi/mpc52xx_spi.c Grant Likely       2010-04-13  435  	ms->irq1 = irq_of_parse_and_map(op->dev.of_node, 1);
42bbb70980f372 drivers/spi/mpc52xx_spi.c Grant Likely       2009-11-04  436  	ms->state = mpc52xx_spi_fsmstate_idle;
61c7a080a5a061 drivers/spi/mpc52xx_spi.c Grant Likely       2010-04-13  437  	ms->ipb_freq = mpc5xxx_get_bus_frequency(op->dev.of_node);
61c7a080a5a061 drivers/spi/mpc52xx_spi.c Grant Likely       2010-04-13  438  	ms->gpio_cs_count = of_gpio_count(op->dev.of_node);
b8d4e2ce60b632 drivers/spi/mpc52xx_spi.c Luotao Fu          2009-11-13  439  	if (ms->gpio_cs_count > 0) {
b8d4e2ce60b632 drivers/spi/mpc52xx_spi.c Luotao Fu          2009-11-13  440  		master->num_chipselect = ms->gpio_cs_count;
8b6c8955b5dc21 drivers/spi/spi-mpc52xx.c Markus Elfring     2017-01-13 @441  		ms->gpio_cs = kmalloc_array(ms->gpio_cs_count,
8b6c8955b5dc21 drivers/spi/spi-mpc52xx.c Markus Elfring     2017-01-13  442  					    sizeof(*ms->gpio_cs),
b8d4e2ce60b632 drivers/spi/mpc52xx_spi.c Luotao Fu          2009-11-13  443  					    GFP_KERNEL);
b8d4e2ce60b632 drivers/spi/mpc52xx_spi.c Luotao Fu          2009-11-13  444  		if (!ms->gpio_cs) {
b8d4e2ce60b632 drivers/spi/mpc52xx_spi.c Luotao Fu          2009-11-13  445  			rc = -ENOMEM;
866c0f25d2dc89 drivers/spi/spi-mpc52xx.c Guenter Roeck      2012-08-18  446  			goto err_alloc_gpio;
b8d4e2ce60b632 drivers/spi/mpc52xx_spi.c Luotao Fu          2009-11-13  447  		}
b8d4e2ce60b632 drivers/spi/mpc52xx_spi.c Luotao Fu          2009-11-13  448  
b8d4e2ce60b632 drivers/spi/mpc52xx_spi.c Luotao Fu          2009-11-13  449  		for (i = 0; i < ms->gpio_cs_count; i++) {
5de8ac6b8ccee6 drivers/spi/spi-mpc52xx.c Arnd Bergmann      2021-11-08  450  			gpio_cs = gpiod_get_index(&op->dev, NULL, i, GPIOD_OUT_LOW);
5de8ac6b8ccee6 drivers/spi/spi-mpc52xx.c Arnd Bergmann      2021-11-08  451  			if (IS_ERR(gpio_cs)) {
b8d4e2ce60b632 drivers/spi/mpc52xx_spi.c Luotao Fu          2009-11-13  452  				dev_err(&op->dev,
5de8ac6b8ccee6 drivers/spi/spi-mpc52xx.c Arnd Bergmann      2021-11-08  453  					"can't request spi cs gpio #%d on gpio line\n", i);
b8d4e2ce60b632 drivers/spi/mpc52xx_spi.c Luotao Fu          2009-11-13  454  				goto err_gpio;
b8d4e2ce60b632 drivers/spi/mpc52xx_spi.c Luotao Fu          2009-11-13  455  			}
b8d4e2ce60b632 drivers/spi/mpc52xx_spi.c Luotao Fu          2009-11-13  456  
b8d4e2ce60b632 drivers/spi/mpc52xx_spi.c Luotao Fu          2009-11-13  457  			ms->gpio_cs[i] = gpio_cs;
b8d4e2ce60b632 drivers/spi/mpc52xx_spi.c Luotao Fu          2009-11-13  458  		}
937041e21634ff drivers/spi/mpc52xx_spi.c Wolfram Sang       2009-11-24  459  	}
b8d4e2ce60b632 drivers/spi/mpc52xx_spi.c Luotao Fu          2009-11-13  460  
42bbb70980f372 drivers/spi/mpc52xx_spi.c Grant Likely       2009-11-04  461  	spin_lock_init(&ms->lock);
42bbb70980f372 drivers/spi/mpc52xx_spi.c Grant Likely       2009-11-04  462  	INIT_LIST_HEAD(&ms->queue);
42bbb70980f372 drivers/spi/mpc52xx_spi.c Grant Likely       2009-11-04  463  	INIT_WORK(&ms->work, mpc52xx_spi_wq);
42bbb70980f372 drivers/spi/mpc52xx_spi.c Grant Likely       2009-11-04  464  
42bbb70980f372 drivers/spi/mpc52xx_spi.c Grant Likely       2009-11-04  465  	/* Decide if interrupts can be used */
42bbb70980f372 drivers/spi/mpc52xx_spi.c Grant Likely       2009-11-04  466  	if (ms->irq0 && ms->irq1) {
937041e21634ff drivers/spi/mpc52xx_spi.c Wolfram Sang       2009-11-24  467  		rc = request_irq(ms->irq0, mpc52xx_spi_irq, 0,
42bbb70980f372 drivers/spi/mpc52xx_spi.c Grant Likely       2009-11-04  468  				  "mpc5200-spi-modf", ms);
937041e21634ff drivers/spi/mpc52xx_spi.c Wolfram Sang       2009-11-24  469  		rc |= request_irq(ms->irq1, mpc52xx_spi_irq, 0,
937041e21634ff drivers/spi/mpc52xx_spi.c Wolfram Sang       2009-11-24  470  				  "mpc5200-spi-spif", ms);
42bbb70980f372 drivers/spi/mpc52xx_spi.c Grant Likely       2009-11-04  471  		if (rc) {
42bbb70980f372 drivers/spi/mpc52xx_spi.c Grant Likely       2009-11-04  472  			free_irq(ms->irq0, ms);
42bbb70980f372 drivers/spi/mpc52xx_spi.c Grant Likely       2009-11-04  473  			free_irq(ms->irq1, ms);
42bbb70980f372 drivers/spi/mpc52xx_spi.c Grant Likely       2009-11-04  474  			ms->irq0 = ms->irq1 = 0;
42bbb70980f372 drivers/spi/mpc52xx_spi.c Grant Likely       2009-11-04  475  		}
42bbb70980f372 drivers/spi/mpc52xx_spi.c Grant Likely       2009-11-04  476  	} else {
42bbb70980f372 drivers/spi/mpc52xx_spi.c Grant Likely       2009-11-04  477  		/* operate in polled mode */
42bbb70980f372 drivers/spi/mpc52xx_spi.c Grant Likely       2009-11-04  478  		ms->irq0 = ms->irq1 = 0;
42bbb70980f372 drivers/spi/mpc52xx_spi.c Grant Likely       2009-11-04  479  	}
42bbb70980f372 drivers/spi/mpc52xx_spi.c Grant Likely       2009-11-04  480  
42bbb70980f372 drivers/spi/mpc52xx_spi.c Grant Likely       2009-11-04  481  	if (!ms->irq0)
42bbb70980f372 drivers/spi/mpc52xx_spi.c Grant Likely       2009-11-04  482  		dev_info(&op->dev, "using polled mode\n");
42bbb70980f372 drivers/spi/mpc52xx_spi.c Grant Likely       2009-11-04  483  
42bbb70980f372 drivers/spi/mpc52xx_spi.c Grant Likely       2009-11-04  484  	dev_dbg(&op->dev, "registering spi_master struct\n");
42bbb70980f372 drivers/spi/mpc52xx_spi.c Grant Likely       2009-11-04  485  	rc = spi_register_master(master);
42bbb70980f372 drivers/spi/mpc52xx_spi.c Grant Likely       2009-11-04  486  	if (rc)
42bbb70980f372 drivers/spi/mpc52xx_spi.c Grant Likely       2009-11-04  487  		goto err_register;
42bbb70980f372 drivers/spi/mpc52xx_spi.c Grant Likely       2009-11-04  488  
42bbb70980f372 drivers/spi/mpc52xx_spi.c Grant Likely       2009-11-04  489  	dev_info(&ms->master->dev, "registered MPC5200 SPI bus\n");
42bbb70980f372 drivers/spi/mpc52xx_spi.c Grant Likely       2009-11-04  490  
42bbb70980f372 drivers/spi/mpc52xx_spi.c Grant Likely       2009-11-04  491  	return rc;
42bbb70980f372 drivers/spi/mpc52xx_spi.c Grant Likely       2009-11-04  492  
42bbb70980f372 drivers/spi/mpc52xx_spi.c Grant Likely       2009-11-04  493   err_register:
42bbb70980f372 drivers/spi/mpc52xx_spi.c Grant Likely       2009-11-04  494  	dev_err(&ms->master->dev, "initialization failed\n");
b8d4e2ce60b632 drivers/spi/mpc52xx_spi.c Luotao Fu          2009-11-13  495   err_gpio:
b8d4e2ce60b632 drivers/spi/mpc52xx_spi.c Luotao Fu          2009-11-13  496  	while (i-- > 0)
5de8ac6b8ccee6 drivers/spi/spi-mpc52xx.c Arnd Bergmann      2021-11-08 @497  		gpio_put(ms->gpio_cs[i]);
b8d4e2ce60b632 drivers/spi/mpc52xx_spi.c Luotao Fu          2009-11-13  498  
b8d4e2ce60b632 drivers/spi/mpc52xx_spi.c Luotao Fu          2009-11-13  499  	kfree(ms->gpio_cs);
866c0f25d2dc89 drivers/spi/spi-mpc52xx.c Guenter Roeck      2012-08-18  500   err_alloc_gpio:
866c0f25d2dc89 drivers/spi/spi-mpc52xx.c Guenter Roeck      2012-08-18  501  	spi_master_put(master);
42bbb70980f372 drivers/spi/mpc52xx_spi.c Grant Likely       2009-11-04  502   err_alloc:
42bbb70980f372 drivers/spi/mpc52xx_spi.c Grant Likely       2009-11-04  503   err_init:
42bbb70980f372 drivers/spi/mpc52xx_spi.c Grant Likely       2009-11-04  504  	iounmap(regs);
42bbb70980f372 drivers/spi/mpc52xx_spi.c Grant Likely       2009-11-04  505  	return rc;
42bbb70980f372 drivers/spi/mpc52xx_spi.c Grant Likely       2009-11-04  506  }
42bbb70980f372 drivers/spi/mpc52xx_spi.c Grant Likely       2009-11-04  507  

:::::: The code at line 441 was first introduced by commit
:::::: 8b6c8955b5dc21358cb1f67cadc5514d2353375d spi/mpc52xx: Use kmalloc_array() in mpc52xx_spi_probe()

:::::: TO: Markus Elfring <elfring@users.sourceforge.net>
:::::: CC: Mark Brown <broonie@kernel.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
