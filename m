Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1BAB4EA310
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 00:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbiC1WiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 18:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbiC1WiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 18:38:18 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 851AB47560;
        Mon, 28 Mar 2022 15:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648506995; x=1680042995;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=afYqVHwiHVNSeLXUeEU0q+YnDh0ucsP8xpVz/aFfAqM=;
  b=Bg54M+NwP0JxtedEsdJJfdpXljr+mi8RW5G353Yd2Xb8/m5mGRPLRoIt
   yk3Fd3Fx+Vf7YbRwvb9IO1IAaCJ7m9dLAcKkafSjLTHURjMftDg7w9vfb
   fnj18iz/l/KhmMpAjEfP68k8Ps3Q1oCJrQhvHD1WXri7m6pfOqVL9krJ4
   lCPQoqvb53eXHp2FVnFOP41LgWEC0JrYR0z6X6H+uy4gja5kJ1YxYem+V
   tgYX/CoVb9PJQik4aWX/FhGAUH+mAYpNnd26WIUQA2NW0YzhpIi2vmjVa
   8Gl/E+HXHkr2GIsFGhc++BFzQY4YOM3tyP7F1M7hpfS6x3cOldtHeCytE
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10300"; a="239711139"
X-IronPort-AV: E=Sophos;i="5.90,218,1643702400"; 
   d="scan'208";a="239711139"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 15:36:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,218,1643702400"; 
   d="scan'208";a="652411975"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 28 Mar 2022 15:36:31 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nYxyQ-0002N8-VQ; Mon, 28 Mar 2022 22:36:30 +0000
Date:   Tue, 29 Mar 2022 06:36:14 +0800
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
Subject: Re: [PATCH 05/21] ata: libahci_platform: Convert to using devm bulk
 clocks API
Message-ID: <202203290643.0ExdJphD-lkp@intel.com>
References: <20220324001628.13028-6-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324001628.13028-6-Sergey.Semin@baikalelectronics.ru>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

[auto build test ERROR on v5.17]
[also build test ERROR on next-20220328]
[cannot apply to axboe-block/for-next robh/for-next linus/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Serge-Semin/ata-ahci-Add-DWC-Baikal-T1-AHCI-SATA-support/20220328-234809
base:    f443e374ae131c168a065ea1748feac6b2e76613
config: arm-buildonly-randconfig-r005-20220327 (https://download.01.org/0day-ci/archive/20220329/202203290643.0ExdJphD-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0f6d9501cf49ce02937099350d08f20c4af86f3d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/intel-lab-lkp/linux/commit/28cf1dcfb31bfca35af403a8774d0d880923fab3
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Serge-Semin/ata-ahci-Add-DWC-Baikal-T1-AHCI-SATA-support/20220328-234809
        git checkout 28cf1dcfb31bfca35af403a8774d0d880923fab3
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/ata/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

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


vim +72 drivers/ata/ahci_dm816.c

df46e6a4c06c89 Bartosz Golaszewski 2017-03-14   60  
df46e6a4c06c89 Bartosz Golaszewski 2017-03-14   61  static int ahci_dm816_phy_init(struct ahci_host_priv *hpriv, struct device *dev)
df46e6a4c06c89 Bartosz Golaszewski 2017-03-14   62  {
df46e6a4c06c89 Bartosz Golaszewski 2017-03-14   63  	unsigned long refclk_rate;
df46e6a4c06c89 Bartosz Golaszewski 2017-03-14   64  	int mpy;
df46e6a4c06c89 Bartosz Golaszewski 2017-03-14   65  	u32 val;
df46e6a4c06c89 Bartosz Golaszewski 2017-03-14   66  
df46e6a4c06c89 Bartosz Golaszewski 2017-03-14   67  	/*
df46e6a4c06c89 Bartosz Golaszewski 2017-03-14   68  	 * We should have been supplied two clocks: the functional and
df46e6a4c06c89 Bartosz Golaszewski 2017-03-14   69  	 * keep-alive clock and the external reference clock. We need the
df46e6a4c06c89 Bartosz Golaszewski 2017-03-14   70  	 * rate of the latter to calculate the correct value of MPY bits.
df46e6a4c06c89 Bartosz Golaszewski 2017-03-14   71  	 */
df46e6a4c06c89 Bartosz Golaszewski 2017-03-14  @72  	if (!hpriv->clks[1]) {
df46e6a4c06c89 Bartosz Golaszewski 2017-03-14   73  		dev_err(dev, "reference clock not supplied\n");
df46e6a4c06c89 Bartosz Golaszewski 2017-03-14   74  		return -EINVAL;
df46e6a4c06c89 Bartosz Golaszewski 2017-03-14   75  	}
df46e6a4c06c89 Bartosz Golaszewski 2017-03-14   76  
df46e6a4c06c89 Bartosz Golaszewski 2017-03-14  @77  	refclk_rate = clk_get_rate(hpriv->clks[1]);
df46e6a4c06c89 Bartosz Golaszewski 2017-03-14   78  	if ((refclk_rate % 100) != 0) {
df46e6a4c06c89 Bartosz Golaszewski 2017-03-14   79  		dev_err(dev, "reference clock rate must be divisible by 100\n");
df46e6a4c06c89 Bartosz Golaszewski 2017-03-14   80  		return -EINVAL;
df46e6a4c06c89 Bartosz Golaszewski 2017-03-14   81  	}
df46e6a4c06c89 Bartosz Golaszewski 2017-03-14   82  
df46e6a4c06c89 Bartosz Golaszewski 2017-03-14   83  	mpy = ahci_dm816_get_mpy_bits(refclk_rate);
df46e6a4c06c89 Bartosz Golaszewski 2017-03-14   84  	if (mpy < 0) {
df46e6a4c06c89 Bartosz Golaszewski 2017-03-14   85  		dev_err(dev, "can't calculate the MPY bits value\n");
df46e6a4c06c89 Bartosz Golaszewski 2017-03-14   86  		return -EINVAL;
df46e6a4c06c89 Bartosz Golaszewski 2017-03-14   87  	}
df46e6a4c06c89 Bartosz Golaszewski 2017-03-14   88  
df46e6a4c06c89 Bartosz Golaszewski 2017-03-14   89  	/* Enable the PHY and configure the first HBA port. */
df46e6a4c06c89 Bartosz Golaszewski 2017-03-14   90  	val = AHCI_DM816_PHY_MPY(mpy) | AHCI_DM816_PHY_LOS(1) |
df46e6a4c06c89 Bartosz Golaszewski 2017-03-14   91  	      AHCI_DM816_PHY_RXCDR(4) | AHCI_DM816_PHY_RXEQ(1) |
df46e6a4c06c89 Bartosz Golaszewski 2017-03-14   92  	      AHCI_DM816_PHY_TXSWING(3) | AHCI_DM816_PHY_ENPLL(1);
df46e6a4c06c89 Bartosz Golaszewski 2017-03-14   93  	writel(val, hpriv->mmio + AHCI_DM816_P0PHYCR_REG);
df46e6a4c06c89 Bartosz Golaszewski 2017-03-14   94  
df46e6a4c06c89 Bartosz Golaszewski 2017-03-14   95  	/* Configure the second HBA port. */
df46e6a4c06c89 Bartosz Golaszewski 2017-03-14   96  	val = AHCI_DM816_PHY_LOS(1) | AHCI_DM816_PHY_RXCDR(4) |
df46e6a4c06c89 Bartosz Golaszewski 2017-03-14   97  	      AHCI_DM816_PHY_RXEQ(1) | AHCI_DM816_PHY_TXSWING(3);
df46e6a4c06c89 Bartosz Golaszewski 2017-03-14   98  	writel(val, hpriv->mmio + AHCI_DM816_P1PHYCR_REG);
df46e6a4c06c89 Bartosz Golaszewski 2017-03-14   99  
df46e6a4c06c89 Bartosz Golaszewski 2017-03-14  100  	return 0;
df46e6a4c06c89 Bartosz Golaszewski 2017-03-14  101  }
df46e6a4c06c89 Bartosz Golaszewski 2017-03-14  102  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
