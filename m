Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2656851968C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 06:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344593AbiEDEaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 00:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344542AbiEDEaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 00:30:16 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7990527CD3;
        Tue,  3 May 2022 21:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651638401; x=1683174401;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KL0VQr9q7v/ilrpm5D5wFlNTKVUad7oBMkfv8Plpj90=;
  b=Xxy5MJqT735nBEKQ3ckKDwXtOeaDZ1PflpNmn2i5uobHWea0lLFhjR+U
   leCSp9xiAq4YeZFKvKK5IO30GagbA93aQrVBFEQ8DglTfD/rL0LrDTgBo
   L68kdCHcGq3e29/GmLsF24BFEuZodKlbc/0gV79/SgkDzCAHBpw3+jwbs
   jXSO1He6kO0alZOUlXA4Jz5fBdhXk75zhWi6n1rgvZFwVm2x5VErccROM
   bjKM89OJ5FbbbGMnmhBe+BhRIQ1Q2eY6cvvY5wla/UaAjgA7KF9eCtY5Z
   PPN/3H0hE2T/AncpIFX54iWji9WCut7HmB+scem9RFiR1JJBR3OD7olgv
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10336"; a="354097572"
X-IronPort-AV: E=Sophos;i="5.91,196,1647327600"; 
   d="scan'208";a="354097572"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 21:26:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,196,1647327600"; 
   d="scan'208";a="653556113"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 03 May 2022 21:26:38 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nm6az-000B4N-HH;
        Wed, 04 May 2022 04:26:37 +0000
Date:   Wed, 4 May 2022 12:26:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 07/23] ata: libahci_platform: Convert to using devm
 bulk clocks API
Message-ID: <202205041215.o6Ubib6t-lkp@intel.com>
References: <20220503200938.18027-8-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220503200938.18027-8-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Serge,

I love your patch! Yet something to improve:

[auto build test ERROR on axboe-block/for-next]
[also build test ERROR on robh/for-next linus/master v5.18-rc5 next-20220503]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Serge-Semin/ata-ahci-Add-DWC-Baikal-T1-AHCI-SATA-support/20220504-041431
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
config: arm64-randconfig-r034-20220501 (https://download.01.org/0day-ci/archive/20220504/202205041215.o6Ubib6t-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 363b3a645a1e30011cc8da624f13dac5fd915628)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/2aa1a2fe25d3757c2c3a6c59ec00c135ba17fe96
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Serge-Semin/ata-ahci-Add-DWC-Baikal-T1-AHCI-SATA-support/20220504-041431
        git checkout 2aa1a2fe25d3757c2c3a6c59ec00c135ba17fe96
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/ata/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/ata/ahci_da850.c:181:6: error: invalid argument type 'struct clk_bulk_data' to unary expression
           if (!hpriv->clks[0]) {
               ^~~~~~~~~~~~~~~
>> drivers/ata/ahci_da850.c:186:18: error: assigning to 'struct clk_bulk_data' from incompatible type 'struct clk *'
                   hpriv->clks[0] = clk;
                                  ^ ~~~
   drivers/ata/ahci_da850.c:194:6: error: invalid argument type 'struct clk_bulk_data' to unary expression
           if (!hpriv->clks[1]) {
               ^~~~~~~~~~~~~~~
   drivers/ata/ahci_da850.c:201:18: error: assigning to 'struct clk_bulk_data' from incompatible type 'struct clk *'
                   hpriv->clks[1] = clk;
                                  ^ ~~~
>> drivers/ata/ahci_da850.c:204:46: error: passing 'struct clk_bulk_data' to parameter of incompatible type 'struct clk *'
           mpy = ahci_da850_calculate_mpy(clk_get_rate(hpriv->clks[1]));
                                                       ^~~~~~~~~~~~~~
   include/linux/clk.h:584:40: note: passing argument to parameter 'clk' here
   unsigned long clk_get_rate(struct clk *clk);
                                          ^
   5 errors generated.
--
>> drivers/ata/ahci_dm816.c:72:6: error: invalid argument type 'struct clk_bulk_data' to unary expression
           if (!hpriv->clks[1]) {
               ^~~~~~~~~~~~~~~
>> drivers/ata/ahci_dm816.c:77:29: error: passing 'struct clk_bulk_data' to parameter of incompatible type 'struct clk *'
           refclk_rate = clk_get_rate(hpriv->clks[1]);
                                      ^~~~~~~~~~~~~~
   include/linux/clk.h:584:40: note: passing argument to parameter 'clk' here
   unsigned long clk_get_rate(struct clk *clk);
                                          ^
   2 errors generated.


vim +181 drivers/ata/ahci_da850.c

018d5ef2048fca Akinobu Mita              2015-01-29  159  
ae8723f8a9c8e8 Bartlomiej Zolnierkiewicz 2014-03-25  160  static int ahci_da850_probe(struct platform_device *pdev)
ae8723f8a9c8e8 Bartlomiej Zolnierkiewicz 2014-03-25  161  {
ae8723f8a9c8e8 Bartlomiej Zolnierkiewicz 2014-03-25  162  	struct device *dev = &pdev->dev;
ae8723f8a9c8e8 Bartlomiej Zolnierkiewicz 2014-03-25  163  	struct ahci_host_priv *hpriv;
ae8723f8a9c8e8 Bartlomiej Zolnierkiewicz 2014-03-25  164  	void __iomem *pwrdn_reg;
cdf0ead3747200 Bartosz Golaszewski       2017-01-30  165  	struct resource *res;
82dbe1a68fd65a Bartosz Golaszewski       2017-01-30  166  	struct clk *clk;
cdf0ead3747200 Bartosz Golaszewski       2017-01-30  167  	u32 mpy;
ae8723f8a9c8e8 Bartlomiej Zolnierkiewicz 2014-03-25  168  	int rc;
ae8723f8a9c8e8 Bartlomiej Zolnierkiewicz 2014-03-25  169  
16af2d65842d34 Kunihiko Hayashi          2018-08-22  170  	hpriv = ahci_platform_get_resources(pdev, 0);
ae8723f8a9c8e8 Bartlomiej Zolnierkiewicz 2014-03-25  171  	if (IS_ERR(hpriv))
ae8723f8a9c8e8 Bartlomiej Zolnierkiewicz 2014-03-25  172  		return PTR_ERR(hpriv);
ae8723f8a9c8e8 Bartlomiej Zolnierkiewicz 2014-03-25  173  
82dbe1a68fd65a Bartosz Golaszewski       2017-01-30  174  	/*
82dbe1a68fd65a Bartosz Golaszewski       2017-01-30  175  	 * Internally ahci_platform_get_resources() calls clk_get(dev, NULL)
82dbe1a68fd65a Bartosz Golaszewski       2017-01-30  176  	 * when trying to obtain the functional clock. This SATA controller
82dbe1a68fd65a Bartosz Golaszewski       2017-01-30  177  	 * uses two clocks for which we specify two connection ids. If we don't
82dbe1a68fd65a Bartosz Golaszewski       2017-01-30  178  	 * have the functional clock at this point - call clk_get() again with
82dbe1a68fd65a Bartosz Golaszewski       2017-01-30  179  	 * con_id = "fck".
82dbe1a68fd65a Bartosz Golaszewski       2017-01-30  180  	 */
82dbe1a68fd65a Bartosz Golaszewski       2017-01-30 @181  	if (!hpriv->clks[0]) {
82dbe1a68fd65a Bartosz Golaszewski       2017-01-30  182  		clk = clk_get(dev, "fck");
82dbe1a68fd65a Bartosz Golaszewski       2017-01-30  183  		if (IS_ERR(clk))
82dbe1a68fd65a Bartosz Golaszewski       2017-01-30  184  			return PTR_ERR(clk);
82dbe1a68fd65a Bartosz Golaszewski       2017-01-30  185  
82dbe1a68fd65a Bartosz Golaszewski       2017-01-30 @186  		hpriv->clks[0] = clk;
82dbe1a68fd65a Bartosz Golaszewski       2017-01-30  187  	}
82dbe1a68fd65a Bartosz Golaszewski       2017-01-30  188  
cdf0ead3747200 Bartosz Golaszewski       2017-01-30  189  	/*
cdf0ead3747200 Bartosz Golaszewski       2017-01-30  190  	 * The second clock used by ahci-da850 is the external REFCLK. If we
cdf0ead3747200 Bartosz Golaszewski       2017-01-30  191  	 * didn't get it from ahci_platform_get_resources(), let's try to
cdf0ead3747200 Bartosz Golaszewski       2017-01-30  192  	 * specify the con_id in clk_get().
cdf0ead3747200 Bartosz Golaszewski       2017-01-30  193  	 */
cdf0ead3747200 Bartosz Golaszewski       2017-01-30  194  	if (!hpriv->clks[1]) {
cdf0ead3747200 Bartosz Golaszewski       2017-01-30  195  		clk = clk_get(dev, "refclk");
cdf0ead3747200 Bartosz Golaszewski       2017-01-30  196  		if (IS_ERR(clk)) {
cdf0ead3747200 Bartosz Golaszewski       2017-01-30  197  			dev_err(dev, "unable to obtain the reference clock");
cdf0ead3747200 Bartosz Golaszewski       2017-01-30  198  			return -ENODEV;
cdf0ead3747200 Bartosz Golaszewski       2017-01-30  199  		}
cdf0ead3747200 Bartosz Golaszewski       2017-01-30  200  
cdf0ead3747200 Bartosz Golaszewski       2017-01-30  201  		hpriv->clks[1] = clk;
cdf0ead3747200 Bartosz Golaszewski       2017-01-30  202  	}
cdf0ead3747200 Bartosz Golaszewski       2017-01-30  203  
cdf0ead3747200 Bartosz Golaszewski       2017-01-30 @204  	mpy = ahci_da850_calculate_mpy(clk_get_rate(hpriv->clks[1]));
cdf0ead3747200 Bartosz Golaszewski       2017-01-30  205  	if (mpy == 0) {
cdf0ead3747200 Bartosz Golaszewski       2017-01-30  206  		dev_err(dev, "invalid REFCLK multiplier value: 0x%x", mpy);
cdf0ead3747200 Bartosz Golaszewski       2017-01-30  207  		return -EINVAL;
cdf0ead3747200 Bartosz Golaszewski       2017-01-30  208  	}
cdf0ead3747200 Bartosz Golaszewski       2017-01-30  209  
ae8723f8a9c8e8 Bartlomiej Zolnierkiewicz 2014-03-25  210  	rc = ahci_platform_enable_resources(hpriv);
ae8723f8a9c8e8 Bartlomiej Zolnierkiewicz 2014-03-25  211  	if (rc)
ae8723f8a9c8e8 Bartlomiej Zolnierkiewicz 2014-03-25  212  		return rc;
ae8723f8a9c8e8 Bartlomiej Zolnierkiewicz 2014-03-25  213  
ae8723f8a9c8e8 Bartlomiej Zolnierkiewicz 2014-03-25  214  	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
c88c094985ad38 Christophe JAILLET        2017-08-16  215  	if (!res) {
c88c094985ad38 Christophe JAILLET        2017-08-16  216  		rc = -ENODEV;
ae8723f8a9c8e8 Bartlomiej Zolnierkiewicz 2014-03-25  217  		goto disable_resources;
c88c094985ad38 Christophe JAILLET        2017-08-16  218  	}
ae8723f8a9c8e8 Bartlomiej Zolnierkiewicz 2014-03-25  219  
ae8723f8a9c8e8 Bartlomiej Zolnierkiewicz 2014-03-25  220  	pwrdn_reg = devm_ioremap(dev, res->start, resource_size(res));
c88c094985ad38 Christophe JAILLET        2017-08-16  221  	if (!pwrdn_reg) {
c88c094985ad38 Christophe JAILLET        2017-08-16  222  		rc = -ENOMEM;
ae8723f8a9c8e8 Bartlomiej Zolnierkiewicz 2014-03-25  223  		goto disable_resources;
c88c094985ad38 Christophe JAILLET        2017-08-16  224  	}
ae8723f8a9c8e8 Bartlomiej Zolnierkiewicz 2014-03-25  225  
cdf0ead3747200 Bartosz Golaszewski       2017-01-30  226  	da850_sata_init(dev, pwrdn_reg, hpriv->mmio, mpy);
ae8723f8a9c8e8 Bartlomiej Zolnierkiewicz 2014-03-25  227  
018d5ef2048fca Akinobu Mita              2015-01-29  228  	rc = ahci_platform_init_host(pdev, hpriv, &ahci_da850_port_info,
018d5ef2048fca Akinobu Mita              2015-01-29  229  				     &ahci_platform_sht);
ae8723f8a9c8e8 Bartlomiej Zolnierkiewicz 2014-03-25  230  	if (rc)
ae8723f8a9c8e8 Bartlomiej Zolnierkiewicz 2014-03-25  231  		goto disable_resources;
ae8723f8a9c8e8 Bartlomiej Zolnierkiewicz 2014-03-25  232  
ae8723f8a9c8e8 Bartlomiej Zolnierkiewicz 2014-03-25  233  	return 0;
ae8723f8a9c8e8 Bartlomiej Zolnierkiewicz 2014-03-25  234  disable_resources:
ae8723f8a9c8e8 Bartlomiej Zolnierkiewicz 2014-03-25  235  	ahci_platform_disable_resources(hpriv);
ae8723f8a9c8e8 Bartlomiej Zolnierkiewicz 2014-03-25  236  	return rc;
ae8723f8a9c8e8 Bartlomiej Zolnierkiewicz 2014-03-25  237  }
ae8723f8a9c8e8 Bartlomiej Zolnierkiewicz 2014-03-25  238  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
