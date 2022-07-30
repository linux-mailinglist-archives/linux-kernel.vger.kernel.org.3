Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 098D65857DB
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 03:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232463AbiG3Bvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 21:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbiG3Bvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 21:51:39 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631AB2AC69;
        Fri, 29 Jul 2022 18:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659145896; x=1690681896;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oXvrqgHJX/aXymOLI6Lbg84MsWqjCWPM0eFPadKnZeA=;
  b=WwPNwDV8PvM7ogfwNJmy/F7daIfhyfAPVcara4+c4ptVtvHjb+s6yICo
   n0e47mCKqPrGiPibcIBRR5sOOfNPG5/Vc6lj6HVX6s1CkUpq7c0iVNwn+
   z8eztzxgJb45fou3JWj77LnW2f2qDdnkqpnGhsUoFxsS4eQCLZE/hSMBR
   6RigKMj2WmGYPmQCgBju2Z7aNokbmR7xtTkA89zt1ZdF3lnWQpsIvBZe9
   l14R7qXpjbQmrgu57Ow8aBHvI8TPZBPgfbryt7tKYvkR1Qb2oyR2NHXMl
   5t7UyN5wL3G1KypSZ8MrR11fxa7gJ7gLCf6Qb4ZTE2J/PmEfQkxadGD0Q
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10423"; a="268649188"
X-IronPort-AV: E=Sophos;i="5.93,202,1654585200"; 
   d="scan'208";a="268649188"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 18:51:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,202,1654585200"; 
   d="scan'208";a="601464706"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 29 Jul 2022 18:51:32 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oHbdb-000CG5-2Y;
        Sat, 30 Jul 2022 01:51:31 +0000
Date:   Sat, 30 Jul 2022 09:51:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>
Cc:     kbuild-all@lists.01.org,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH RESEND v6 07/23] ata: libahci_platform: Convert to using
 devm bulk clocks API
Message-ID: <202207300915.8DDz66ju-lkp@intel.com>
References: <20220728111905.12427-8-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220728111905.12427-8-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Serge,

I love your patch! Yet something to improve:

[auto build test ERROR on robh/for-next]
[also build test ERROR on axboe-block/for-next linus/master v5.19-rc8 next-20220728]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Serge-Semin/ata-ahci-Add-DWC-Baikal-T1-AHCI-SATA-support/20220728-192315
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: csky-randconfig-r023-20220729 (https://download.01.org/0day-ci/archive/20220730/202207300915.8DDz66ju-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/a84e837dd293db69f2510f3036f2c83ce8b0167c
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Serge-Semin/ata-ahci-Add-DWC-Baikal-T1-AHCI-SATA-support/20220728-192315
        git checkout a84e837dd293db69f2510f3036f2c83ce8b0167c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=csky SHELL=/bin/bash drivers/ata/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/ata/ahci_da850.c: In function 'ahci_da850_probe':
>> drivers/ata/ahci_da850.c:181:13: error: wrong type argument to unary exclamation mark
     181 |         if (!hpriv->clks[0]) {
         |             ^
>> drivers/ata/ahci_da850.c:186:34: error: incompatible types when assigning to type 'struct clk_bulk_data' from type 'struct clk *'
     186 |                 hpriv->clks[0] = clk;
         |                                  ^~~
   drivers/ata/ahci_da850.c:194:13: error: wrong type argument to unary exclamation mark
     194 |         if (!hpriv->clks[1]) {
         |             ^
   drivers/ata/ahci_da850.c:201:34: error: incompatible types when assigning to type 'struct clk_bulk_data' from type 'struct clk *'
     201 |                 hpriv->clks[1] = clk;
         |                                  ^~~
>> drivers/ata/ahci_da850.c:204:64: error: incompatible type for argument 1 of 'clk_get_rate'
     204 |         mpy = ahci_da850_calculate_mpy(clk_get_rate(hpriv->clks[1]));
         |                                                     ~~~~~~~~~~~^~~
         |                                                                |
         |                                                                struct clk_bulk_data
   In file included from drivers/ata/ahci.h:23,
                    from drivers/ata/ahci_da850.c:13:
   include/linux/clk.h:584:40: note: expected 'struct clk *' but argument is of type 'struct clk_bulk_data'
     584 | unsigned long clk_get_rate(struct clk *clk);
         |                            ~~~~~~~~~~~~^~~
--
   drivers/ata/ahci_dm816.c: In function 'ahci_dm816_phy_init':
>> drivers/ata/ahci_dm816.c:72:13: error: wrong type argument to unary exclamation mark
      72 |         if (!hpriv->clks[1]) {
         |             ^
>> drivers/ata/ahci_dm816.c:77:47: error: incompatible type for argument 1 of 'clk_get_rate'
      77 |         refclk_rate = clk_get_rate(hpriv->clks[1]);
         |                                    ~~~~~~~~~~~^~~
         |                                               |
         |                                               struct clk_bulk_data
   In file included from drivers/ata/ahci.h:23,
                    from drivers/ata/ahci_dm816.c:16:
   include/linux/clk.h:584:40: note: expected 'struct clk *' but argument is of type 'struct clk_bulk_data'
     584 | unsigned long clk_get_rate(struct clk *clk);
         |                            ~~~~~~~~~~~~^~~


vim +186 drivers/ata/ahci_da850.c

018d5ef2048fcab Akinobu Mita              2015-01-29  159  
ae8723f8a9c8e80 Bartlomiej Zolnierkiewicz 2014-03-25  160  static int ahci_da850_probe(struct platform_device *pdev)
ae8723f8a9c8e80 Bartlomiej Zolnierkiewicz 2014-03-25  161  {
ae8723f8a9c8e80 Bartlomiej Zolnierkiewicz 2014-03-25  162  	struct device *dev = &pdev->dev;
ae8723f8a9c8e80 Bartlomiej Zolnierkiewicz 2014-03-25  163  	struct ahci_host_priv *hpriv;
ae8723f8a9c8e80 Bartlomiej Zolnierkiewicz 2014-03-25  164  	void __iomem *pwrdn_reg;
cdf0ead3747200d Bartosz Golaszewski       2017-01-30  165  	struct resource *res;
82dbe1a68fd65a4 Bartosz Golaszewski       2017-01-30  166  	struct clk *clk;
cdf0ead3747200d Bartosz Golaszewski       2017-01-30  167  	u32 mpy;
ae8723f8a9c8e80 Bartlomiej Zolnierkiewicz 2014-03-25  168  	int rc;
ae8723f8a9c8e80 Bartlomiej Zolnierkiewicz 2014-03-25  169  
16af2d65842d343 Kunihiko Hayashi          2018-08-22  170  	hpriv = ahci_platform_get_resources(pdev, 0);
ae8723f8a9c8e80 Bartlomiej Zolnierkiewicz 2014-03-25  171  	if (IS_ERR(hpriv))
ae8723f8a9c8e80 Bartlomiej Zolnierkiewicz 2014-03-25  172  		return PTR_ERR(hpriv);
ae8723f8a9c8e80 Bartlomiej Zolnierkiewicz 2014-03-25  173  
82dbe1a68fd65a4 Bartosz Golaszewski       2017-01-30  174  	/*
82dbe1a68fd65a4 Bartosz Golaszewski       2017-01-30  175  	 * Internally ahci_platform_get_resources() calls clk_get(dev, NULL)
82dbe1a68fd65a4 Bartosz Golaszewski       2017-01-30  176  	 * when trying to obtain the functional clock. This SATA controller
82dbe1a68fd65a4 Bartosz Golaszewski       2017-01-30  177  	 * uses two clocks for which we specify two connection ids. If we don't
82dbe1a68fd65a4 Bartosz Golaszewski       2017-01-30  178  	 * have the functional clock at this point - call clk_get() again with
82dbe1a68fd65a4 Bartosz Golaszewski       2017-01-30  179  	 * con_id = "fck".
82dbe1a68fd65a4 Bartosz Golaszewski       2017-01-30  180  	 */
82dbe1a68fd65a4 Bartosz Golaszewski       2017-01-30 @181  	if (!hpriv->clks[0]) {
82dbe1a68fd65a4 Bartosz Golaszewski       2017-01-30  182  		clk = clk_get(dev, "fck");
82dbe1a68fd65a4 Bartosz Golaszewski       2017-01-30  183  		if (IS_ERR(clk))
82dbe1a68fd65a4 Bartosz Golaszewski       2017-01-30  184  			return PTR_ERR(clk);
82dbe1a68fd65a4 Bartosz Golaszewski       2017-01-30  185  
82dbe1a68fd65a4 Bartosz Golaszewski       2017-01-30 @186  		hpriv->clks[0] = clk;
82dbe1a68fd65a4 Bartosz Golaszewski       2017-01-30  187  	}
82dbe1a68fd65a4 Bartosz Golaszewski       2017-01-30  188  
cdf0ead3747200d Bartosz Golaszewski       2017-01-30  189  	/*
cdf0ead3747200d Bartosz Golaszewski       2017-01-30  190  	 * The second clock used by ahci-da850 is the external REFCLK. If we
cdf0ead3747200d Bartosz Golaszewski       2017-01-30  191  	 * didn't get it from ahci_platform_get_resources(), let's try to
cdf0ead3747200d Bartosz Golaszewski       2017-01-30  192  	 * specify the con_id in clk_get().
cdf0ead3747200d Bartosz Golaszewski       2017-01-30  193  	 */
cdf0ead3747200d Bartosz Golaszewski       2017-01-30  194  	if (!hpriv->clks[1]) {
cdf0ead3747200d Bartosz Golaszewski       2017-01-30  195  		clk = clk_get(dev, "refclk");
cdf0ead3747200d Bartosz Golaszewski       2017-01-30  196  		if (IS_ERR(clk)) {
cdf0ead3747200d Bartosz Golaszewski       2017-01-30  197  			dev_err(dev, "unable to obtain the reference clock");
cdf0ead3747200d Bartosz Golaszewski       2017-01-30  198  			return -ENODEV;
cdf0ead3747200d Bartosz Golaszewski       2017-01-30  199  		}
cdf0ead3747200d Bartosz Golaszewski       2017-01-30  200  
cdf0ead3747200d Bartosz Golaszewski       2017-01-30  201  		hpriv->clks[1] = clk;
cdf0ead3747200d Bartosz Golaszewski       2017-01-30  202  	}
cdf0ead3747200d Bartosz Golaszewski       2017-01-30  203  
cdf0ead3747200d Bartosz Golaszewski       2017-01-30 @204  	mpy = ahci_da850_calculate_mpy(clk_get_rate(hpriv->clks[1]));
cdf0ead3747200d Bartosz Golaszewski       2017-01-30  205  	if (mpy == 0) {
cdf0ead3747200d Bartosz Golaszewski       2017-01-30  206  		dev_err(dev, "invalid REFCLK multiplier value: 0x%x", mpy);
cdf0ead3747200d Bartosz Golaszewski       2017-01-30  207  		return -EINVAL;
cdf0ead3747200d Bartosz Golaszewski       2017-01-30  208  	}
cdf0ead3747200d Bartosz Golaszewski       2017-01-30  209  
ae8723f8a9c8e80 Bartlomiej Zolnierkiewicz 2014-03-25  210  	rc = ahci_platform_enable_resources(hpriv);
ae8723f8a9c8e80 Bartlomiej Zolnierkiewicz 2014-03-25  211  	if (rc)
ae8723f8a9c8e80 Bartlomiej Zolnierkiewicz 2014-03-25  212  		return rc;
ae8723f8a9c8e80 Bartlomiej Zolnierkiewicz 2014-03-25  213  
ae8723f8a9c8e80 Bartlomiej Zolnierkiewicz 2014-03-25  214  	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
c88c094985ad38c Christophe JAILLET        2017-08-16  215  	if (!res) {
c88c094985ad38c Christophe JAILLET        2017-08-16  216  		rc = -ENODEV;
ae8723f8a9c8e80 Bartlomiej Zolnierkiewicz 2014-03-25  217  		goto disable_resources;
c88c094985ad38c Christophe JAILLET        2017-08-16  218  	}
ae8723f8a9c8e80 Bartlomiej Zolnierkiewicz 2014-03-25  219  
ae8723f8a9c8e80 Bartlomiej Zolnierkiewicz 2014-03-25  220  	pwrdn_reg = devm_ioremap(dev, res->start, resource_size(res));
c88c094985ad38c Christophe JAILLET        2017-08-16  221  	if (!pwrdn_reg) {
c88c094985ad38c Christophe JAILLET        2017-08-16  222  		rc = -ENOMEM;
ae8723f8a9c8e80 Bartlomiej Zolnierkiewicz 2014-03-25  223  		goto disable_resources;
c88c094985ad38c Christophe JAILLET        2017-08-16  224  	}
ae8723f8a9c8e80 Bartlomiej Zolnierkiewicz 2014-03-25  225  
cdf0ead3747200d Bartosz Golaszewski       2017-01-30  226  	da850_sata_init(dev, pwrdn_reg, hpriv->mmio, mpy);
ae8723f8a9c8e80 Bartlomiej Zolnierkiewicz 2014-03-25  227  
018d5ef2048fcab Akinobu Mita              2015-01-29  228  	rc = ahci_platform_init_host(pdev, hpriv, &ahci_da850_port_info,
018d5ef2048fcab Akinobu Mita              2015-01-29  229  				     &ahci_platform_sht);
ae8723f8a9c8e80 Bartlomiej Zolnierkiewicz 2014-03-25  230  	if (rc)
ae8723f8a9c8e80 Bartlomiej Zolnierkiewicz 2014-03-25  231  		goto disable_resources;
ae8723f8a9c8e80 Bartlomiej Zolnierkiewicz 2014-03-25  232  
ae8723f8a9c8e80 Bartlomiej Zolnierkiewicz 2014-03-25  233  	return 0;
ae8723f8a9c8e80 Bartlomiej Zolnierkiewicz 2014-03-25  234  disable_resources:
ae8723f8a9c8e80 Bartlomiej Zolnierkiewicz 2014-03-25  235  	ahci_platform_disable_resources(hpriv);
ae8723f8a9c8e80 Bartlomiej Zolnierkiewicz 2014-03-25  236  	return rc;
ae8723f8a9c8e80 Bartlomiej Zolnierkiewicz 2014-03-25  237  }
ae8723f8a9c8e80 Bartlomiej Zolnierkiewicz 2014-03-25  238  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
