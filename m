Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C389B468248
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 05:42:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377800AbhLDEqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 23:46:03 -0500
Received: from mga09.intel.com ([134.134.136.24]:52118 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238601AbhLDEqA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 23:46:00 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10187"; a="236908588"
X-IronPort-AV: E=Sophos;i="5.87,286,1631602800"; 
   d="scan'208";a="236908588"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2021 20:42:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,286,1631602800"; 
   d="scan'208";a="610642327"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 03 Dec 2021 20:42:31 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mtMsY-000ITk-U1; Sat, 04 Dec 2021 04:42:30 +0000
Date:   Sat, 4 Dec 2021 12:41:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Gabriel Somlo <gsomlo@gmail.com>, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, kgugala@antmicro.com,
        mholenko@antmicro.com, krakoczy@antmicro.com,
        mdudek@internships.antmicro.com, paulus@ozlabs.org
Subject: Re: [PATCH v1 3/3] mmc: Add driver for LiteX's LiteSDCard interface
Message-ID: <202112041255.X6DL0sKx-lkp@intel.com>
References: <20211203234155.2319803-4-gsomlo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211203234155.2319803-4-gsomlo@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gabriel,

I love your patch! Yet something to improve:

[auto build test ERROR on robh/for-next]
[also build test ERROR on linux/master ulf-hansson-mmc-mirror/next linus/master v5.16-rc3 next-20211203]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Gabriel-Somlo/mmc-Add-LiteSDCard-mmc-driver/20211204-074318
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20211204/202112041255.X6DL0sKx-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/f967027b6ffe6f577773d3607edcf6677f7e56c5
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Gabriel-Somlo/mmc-Add-LiteSDCard-mmc-driver/20211204-074318
        git checkout f967027b6ffe6f577773d3607edcf6677f7e56c5
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=sh SHELL=/bin/bash drivers/mmc/host/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/mmc/host/litex_mmc.c: In function 'litex_mmc_probe':
>> drivers/mmc/host/litex_mmc.c:617:23: error: implicit declaration of function 'request_irq'; did you mean 'request_key'? [-Werror=implicit-function-declaration]
     617 |                 ret = request_irq(host->irq, litex_mmc_interrupt, 0,
         |                       ^~~~~~~~~~~
         |                       request_key
   drivers/mmc/host/litex_mmc.c: In function 'litex_mmc_remove':
>> drivers/mmc/host/litex_mmc.c:651:17: error: implicit declaration of function 'free_irq' [-Werror=implicit-function-declaration]
     651 |                 free_irq(host->irq, host->mmc);
         |                 ^~~~~~~~
   cc1: some warnings being treated as errors


vim +617 drivers/mmc/host/litex_mmc.c

   496	
   497	static int
   498	litex_mmc_probe(struct platform_device *pdev)
   499	{
   500		struct litex_mmc_host *host;
   501		struct mmc_host *mmc;
   502		struct device_node *cpu;
   503		int ret;
   504	
   505		mmc = mmc_alloc_host(sizeof(struct litex_mmc_host), &pdev->dev);
   506		/* NOTE: defaults to max_[req,seg]_size=PAGE_SIZE, max_blk_size=512,
   507		 * and max_blk_count accordingly set to 8;
   508		 * If for some reason we need to modify max_blk_count, we must also
   509		 * re-calculate `max_[req,seg]_size = max_blk_size * max_blk_count;`
   510		 */
   511		if (!mmc)
   512			return -ENOMEM;
   513	
   514		host = mmc_priv(mmc);
   515		host->mmc = mmc;
   516		host->dev = pdev;
   517	
   518		host->clock = 0;
   519		cpu = of_get_next_cpu_node(NULL);
   520		ret = of_property_read_u32(cpu, "clock-frequency", &host->freq);
   521		of_node_put(cpu);
   522		if (ret) {
   523			dev_err(&pdev->dev, "No \"clock-frequency\" property in DT\n");
   524			goto err_free_host;
   525		}
   526	
   527		init_completion(&host->cmd_done);
   528		host->irq = platform_get_irq(pdev, 0);
   529		if (host->irq < 0)
   530			dev_err(&pdev->dev, "Failed to get IRQ, using polling\n");
   531	
   532		/* LiteSDCard only supports 4-bit bus width; therefore, we MUST inject
   533		 * a SET_BUS_WIDTH (acmd6) before the very first data transfer, earlier
   534		 * than when the mmc subsystem would normally get around to it!
   535		 */
   536		host->is_bus_width_set = false;
   537		host->app_cmd = false;
   538	
   539		ret = dma_set_mask(&pdev->dev, DMA_BIT_MASK(32));
   540		if (ret)
   541			goto err_free_host;
   542	
   543		host->buf_size = mmc->max_req_size * 2;
   544		host->buffer = dma_alloc_coherent(&pdev->dev, host->buf_size,
   545						  &host->dma, GFP_DMA);
   546		if (host->buffer == NULL) {
   547			ret = -ENOMEM;
   548			goto err_free_host;
   549		}
   550	
   551		host->sdphy = devm_platform_ioremap_resource_byname(pdev, "phy");
   552		if (IS_ERR(host->sdphy)) {
   553			ret = PTR_ERR(host->sdphy);
   554			goto err_free_dma;
   555		}
   556	
   557		host->sdcore = devm_platform_ioremap_resource_byname(pdev, "core");
   558		if (IS_ERR(host->sdcore)) {
   559			ret = PTR_ERR(host->sdcore);
   560			goto err_free_dma;
   561		}
   562	
   563		host->sdreader = devm_platform_ioremap_resource_byname(pdev, "reader");
   564		if (IS_ERR(host->sdreader)) {
   565			ret = PTR_ERR(host->sdreader);
   566			goto err_free_dma;
   567		}
   568	
   569		host->sdwriter = devm_platform_ioremap_resource_byname(pdev, "writer");
   570		if (IS_ERR(host->sdwriter)) {
   571			ret = PTR_ERR(host->sdwriter);
   572			goto err_free_dma;
   573		}
   574	
   575		if (host->irq > 0) {
   576			host->sdirq = devm_platform_ioremap_resource_byname(pdev, "irq");
   577			if (IS_ERR(host->sdirq)) {
   578				ret = PTR_ERR(host->sdirq);
   579				goto err_free_dma;
   580			}
   581		}
   582	
   583		mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34;
   584		mmc->ops = &litex_mmc_ops;
   585	
   586		mmc->f_min = 12.5e6;
   587		mmc->f_max = 50e6;
   588	
   589		ret = mmc_of_parse(mmc);
   590		if (ret)
   591			goto err_free_dma;
   592	
   593		/* force 4-bit bus_width (only width supported by hardware) */
   594		mmc->caps &= ~MMC_CAP_8_BIT_DATA;
   595		mmc->caps |= MMC_CAP_4_BIT_DATA;
   596	
   597		/* set default capabilities */
   598		mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY |
   599			     MMC_CAP_DRIVER_TYPE_D |
   600			     MMC_CAP_CMD23;
   601		mmc->caps2 |= MMC_CAP2_NO_WRITE_PROTECT |
   602			      MMC_CAP2_FULL_PWR_CYCLE |
   603			      MMC_CAP2_NO_SDIO;
   604	
   605		platform_set_drvdata(pdev, host);
   606	
   607		ret = mmc_add_host(mmc);
   608		if (ret < 0)
   609			goto err_free_dma;
   610	
   611		/* ensure DMA bus masters are disabled */
   612		litex_write8(host->sdreader + LITEX_BLK2MEM_ENA, 0);
   613		litex_write8(host->sdwriter + LITEX_MEM2BLK_ENA, 0);
   614	
   615		/* set up interrupt handler */
   616		if (host->irq > 0) {
 > 617			ret = request_irq(host->irq, litex_mmc_interrupt, 0,
   618					  "litex-mmc", mmc);
   619			if (ret < 0) {
   620				dev_err(&pdev->dev,
   621					"irq setup error %d, using polling\n", ret);
   622				host->irq = 0;
   623			}
   624		}
   625	
   626		/* enable card-change interrupts, or else ask for polling */
   627		if (host->irq > 0) {
   628			litex_write32(host->sdirq + LITEX_IRQ_PENDING,
   629				      SDIRQ_CARD_DETECT);	/* clears it */
   630			litex_write32(host->sdirq + LITEX_IRQ_ENABLE,
   631				      SDIRQ_CARD_DETECT);
   632		} else {
   633			mmc->caps |= MMC_CAP_NEEDS_POLL;
   634		}
   635	
   636		return 0;
   637	
   638	err_free_dma:
   639		dma_free_coherent(&pdev->dev, host->buf_size, host->buffer, host->dma);
   640	err_free_host:
   641		mmc_free_host(mmc);
   642		return ret;
   643	}
   644	
   645	static int
   646	litex_mmc_remove(struct platform_device *pdev)
   647	{
   648		struct litex_mmc_host *host = dev_get_drvdata(&pdev->dev);
   649	
   650		if (host->irq > 0)
 > 651			free_irq(host->irq, host->mmc);
   652		mmc_remove_host(host->mmc);
   653		dma_free_coherent(&pdev->dev, host->buf_size, host->buffer, host->dma);
   654		mmc_free_host(host->mmc);
   655	
   656		return 0;
   657	}
   658	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
