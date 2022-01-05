Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80194485494
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 15:32:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240887AbiAEObb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 09:31:31 -0500
Received: from mga12.intel.com ([192.55.52.136]:39251 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240845AbiAEObZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 09:31:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641393085; x=1672929085;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vnFsN2Xd6VIYLzjaK59BLACJXya+VDbw2JZKFLsW7NU=;
  b=TG+7grRTWvit2WtSKA7l10OIIbaGygFP1xNnVSOYRKTSJ9gslbnpi96M
   NcoWhj8bgmRTI3vrOwPCEML9pLfx9esaaPce1ElLfh8XD5Kc/b+dIJ3Sq
   PQk+mBDpxXIazpu8M8xjtCzqyFk2BxY9g/B9fEuWv+zocY7xUI6pHaZAU
   zdNjRE+/B4TXWEEYGJIfo7kdAElP5YPqIMD/gNtPsNIjraHgC1709bZ6I
   15UcH0bfDofezqKmPnheLG0q4UBFokjcEU2hZNR8WfRpPFs//RMQ+vxco
   iKULuEVqu2SLiteP3QR8x2JRw4rIBeM/61TIkS4W3nb6vjjrJjavL6kBb
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="222447534"
X-IronPort-AV: E=Sophos;i="5.88,264,1635231600"; 
   d="scan'208";a="222447534"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 06:16:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,264,1635231600"; 
   d="scan'208";a="556543340"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 05 Jan 2022 06:16:43 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n575m-000GiW-I6; Wed, 05 Jan 2022 14:16:42 +0000
Date:   Wed, 5 Jan 2022 22:16:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org, linmq006@gmail.com,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Roger Quadros <rogerq@ti.com>, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] phy: ti: Add missing pm_runtime_disable() in probe
 function
Message-ID: <202201052240.Rjl0xRWG-lkp@intel.com>
References: <20220105090225.20507-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220105090225.20507-1-linmq006@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miaoqian,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v5.16-rc8 next-20220105]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Miaoqian-Lin/phy-ti-Add-missing-pm_runtime_disable-in-probe-function/20220105-170334
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git c9e6606c7fe92b50a02ce51dda82586ebdf99b48
config: riscv-randconfig-r013-20220105 (https://download.01.org/0day-ci/archive/20220105/202201052240.Rjl0xRWG-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project d5b6e30ed3acad794dd0aec400e617daffc6cc3d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/0day-ci/linux/commit/dc404b65a54364bb2937baba85bb37960c514167
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Miaoqian-Lin/phy-ti-Add-missing-pm_runtime_disable-in-probe-function/20220105-170334
        git checkout dc404b65a54364bb2937baba85bb37960c514167
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/phy/ti/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/phy/ti/phy-am654-serdes.c:841:1: warning: unused label 'err_pm_disable' [-Wunused-label]
   err_pm_disable:
   ^~~~~~~~~~~~~~~
   1 warning generated.


vim +/err_pm_disable +841 drivers/phy/ti/phy-am654-serdes.c

   751	
   752	static int serdes_am654_probe(struct platform_device *pdev)
   753	{
   754		struct phy_provider *phy_provider;
   755		struct device *dev = &pdev->dev;
   756		struct device_node *node = dev->of_node;
   757		struct clk_onecell_data *clk_data;
   758		struct serdes_am654 *am654_phy;
   759		struct mux_control *control;
   760		const char *clock_name;
   761		struct regmap *regmap;
   762		void __iomem *base;
   763		struct phy *phy;
   764		int ret;
   765		int i;
   766	
   767		am654_phy = devm_kzalloc(dev, sizeof(*am654_phy), GFP_KERNEL);
   768		if (!am654_phy)
   769			return -ENOMEM;
   770	
   771		base = devm_platform_ioremap_resource(pdev, 0);
   772		if (IS_ERR(base))
   773			return PTR_ERR(base);
   774	
   775		regmap = devm_regmap_init_mmio(dev, base, &serdes_am654_regmap_config);
   776		if (IS_ERR(regmap)) {
   777			dev_err(dev, "Failed to initialize regmap\n");
   778			return PTR_ERR(regmap);
   779		}
   780	
   781		control = devm_mux_control_get(dev, NULL);
   782		if (IS_ERR(control))
   783			return PTR_ERR(control);
   784	
   785		am654_phy->dev = dev;
   786		am654_phy->of_node = node;
   787		am654_phy->regmap = regmap;
   788		am654_phy->control = control;
   789		am654_phy->type = PHY_NONE;
   790	
   791		ret = serdes_am654_regfield_init(am654_phy);
   792		if (ret) {
   793			dev_err(dev, "Failed to initialize regfields\n");
   794			return ret;
   795		}
   796	
   797		platform_set_drvdata(pdev, am654_phy);
   798	
   799		for (i = 0; i < SERDES_NUM_CLOCKS; i++) {
   800			ret = of_property_read_string_index(node, "clock-output-names",
   801							    i, &clock_name);
   802			if (ret) {
   803				dev_err(dev, "Failed to get clock name\n");
   804				return ret;
   805			}
   806	
   807			ret = serdes_am654_clk_register(am654_phy, clock_name, i);
   808			if (ret) {
   809				dev_err(dev, "Failed to initialize clock %s\n",
   810					clock_name);
   811				return ret;
   812			}
   813		}
   814	
   815		clk_data = &am654_phy->clk_data;
   816		clk_data->clks = am654_phy->clks;
   817		clk_data->clk_num = SERDES_NUM_CLOCKS;
   818		ret = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
   819		if (ret)
   820			return ret;
   821	
   822		pm_runtime_enable(dev);
   823	
   824		phy = devm_phy_create(dev, NULL, &ops);
   825		if (IS_ERR(phy)) {
   826			ret = PTR_ERR(phy);
   827			goto clk_err;
   828		}
   829	
   830		phy_set_drvdata(phy, am654_phy);
   831		phy_provider = devm_of_phy_provider_register(dev, serdes_am654_xlate);
   832		if (IS_ERR(phy_provider)) {
   833			ret = PTR_ERR(phy_provider);
   834			goto clk_err;
   835		}
   836	
   837		return 0;
   838	
   839	clk_err:
   840		of_clk_del_provider(node);
 > 841	err_pm_disable:
   842		pm_runtime_disable(dev);
   843		return ret;
   844	}
   845	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
