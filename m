Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACD2B4EA3D1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 01:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbiC1XpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 19:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbiC1XpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 19:45:16 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF7D126FAD;
        Mon, 28 Mar 2022 16:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648511014; x=1680047014;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zEIGwNUSsN3Knn+dKmUBLWTQkdtxNtR3DpeKL/caZA0=;
  b=gLn7QPRprEv87RZdV+m2UZfyRGs4cI8UaeiN9GD+vPMQrYgt/hkJCnDD
   QLSQ+4nt83HJ5pYTzGttz2Q45Oq6sTMN8eS65HwNzf22G3w0VFs/vzQXG
   OyujWk+88eMC6Zzil3khO1j28TzV/Ykg8RKaoRPslOvh1/RX3bmpS4COJ
   0DYjW+h9jHRN6F5rDx/JjFeox6loKbgRT6+K9shBX34VLGn10EZak/U8K
   5DWFj+jAIuva9vtwFf6fnSRfL6bPyT/6IPJnr4ahHbuTgIIB58D93GVLn
   8v2BiNOV6Y+hZxfWBg4jj5rLsCj8rSBmkblaAIlWDjaYRlUogY4wpppDg
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10300"; a="284018344"
X-IronPort-AV: E=Sophos;i="5.90,218,1643702400"; 
   d="scan'208";a="284018344"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 16:43:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,218,1643702400"; 
   d="scan'208";a="518517325"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 28 Mar 2022 16:43:31 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nYz1G-0002QB-8k; Mon, 28 Mar 2022 23:43:30 +0000
Date:   Tue, 29 Mar 2022 07:42:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     kbuild-all@lists.01.org,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 05/21] ata: libahci_platform: Convert to using devm bulk
 clocks API
Message-ID: <202203290730.f6OTgSOz-lkp@intel.com>
References: <20220324001628.13028-6-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324001628.13028-6-Sergey.Semin@baikalelectronics.ru>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Serge,

I love your patch! Yet something to improve:

[auto build test ERROR on v5.17]
[also build test ERROR on next-20220328]
[cannot apply to axboe-block/for-next robh/for-next linus/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Serge-Semin/ata-ahci-Add-DWC-Baikal-T1-AHCI-SATA-support/20220328-234809
base:    f443e374ae131c168a065ea1748feac6b2e76613
config: alpha-randconfig-r034-20220327 (https://download.01.org/0day-ci/archive/20220329/202203290730.f6OTgSOz-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/28cf1dcfb31bfca35af403a8774d0d880923fab3
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Serge-Semin/ata-ahci-Add-DWC-Baikal-T1-AHCI-SATA-support/20220328-234809
        git checkout 28cf1dcfb31bfca35af403a8774d0d880923fab3
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=alpha SHELL=/bin/bash drivers/ata/

If you fix the issue, kindly add following tag as appropriate
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
   include/linux/clk.h:880:54: note: expected 'struct clk *' but argument is of type 'struct clk_bulk_data'
     880 | static inline unsigned long clk_get_rate(struct clk *clk)
         |                                          ~~~~~~~~~~~~^~~
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
   include/linux/clk.h:880:54: note: expected 'struct clk *' but argument is of type 'struct clk_bulk_data'
     880 | static inline unsigned long clk_get_rate(struct clk *clk)
         |                                          ~~~~~~~~~~~~^~~


vim +186 drivers/ata/ahci_da850.c

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
