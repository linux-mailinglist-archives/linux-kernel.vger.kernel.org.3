Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 043CD554981
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355080AbiFVIhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 04:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354489AbiFVIhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 04:37:06 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 999933982C;
        Wed, 22 Jun 2022 01:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655887003; x=1687423003;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Asx2uLZqEWA1Ku8lHPlIL6BlvP7Vxo6bP4XGBrldJgE=;
  b=nE1Y3T4p7z17RpcLYwdRpYzbWJF07mj0WUV8CYeX5vKZ3JdpZfhKLa9x
   7Zx1H/2CT1QFgz/tt+XPwzZXaFaiE4sFI5oSLTwbRVM/hho51GHLmWiK+
   mg0YrMrBAzsw6EWhpQRmJyifmmTeysCZ6307eIBpjh4lpak/WhRZOCKIi
   h4AsTWnqk7CVqsQmLCPReLqdfbqZbHpwD/2lWUgK2vVTSHq0BZ0OKLeap
   xFDmdWgE6pSaQMyMUToAzEFtAxTlFbw5qnnbRonG/C0Dmd//pXRAbhcF3
   Qzh+e19VYIb/kZeRdr+qk6rMvGp+IzOJoei2MoYFjhGnz86Oh8+WEKWye
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10385"; a="269075683"
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="269075683"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 01:36:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="615080835"
Received: from lkp-server02.sh.intel.com (HELO a67cc04a5eeb) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 22 Jun 2022 01:36:40 -0700
Received: from kbuild by a67cc04a5eeb with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o3vqp-00013U-Op;
        Wed, 22 Jun 2022 08:36:39 +0000
Date:   Wed, 22 Jun 2022 16:35:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Liang He <windhl@126.com>, krzysztof.kozlowski@linaro.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org, windhl@126.com,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH] memory/tegra: Add missing of_node_get() in
 tegra_emc_find_node_by_ram_code
Message-ID: <202206221602.odN70SHs-lkp@intel.com>
References: <20220622042824.4094625-1-windhl@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622042824.4094625-1-windhl@126.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Liang,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on tegra/for-next]
[also build test ERROR on tegra-drm/drm/tegra/for-next linus/master v5.19-rc3 next-20220621]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Liang-He/memory-tegra-Add-missing-of_node_get-in-tegra_emc_find_node_by_ram_code/20220622-123052
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git for-next
config: hexagon-randconfig-r041-20220622 (https://download.01.org/0day-ci/archive/20220622/202206221602.odN70SHs-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 8b8d126598ce7bd5243da7f94f69fa1104288bee)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/6f5dd7a2fb5c7d45a25cdf4409c5aa03c4df0a96
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Liang-He/memory-tegra-Add-missing-of_node_get-in-tegra_emc_find_node_by_ram_code/20220622-123052
        git checkout 6f5dd7a2fb5c7d45a25cdf4409c5aa03c4df0a96
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/memory/tegra/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/memory/tegra/tegra20-emc.c:480:2: error: call to undeclared function 'of_get_node'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           of_get_node(dev->of_node);
           ^
   1 error generated.


vim +/of_get_node +480 drivers/memory/tegra/tegra20-emc.c

   456	
   457	static struct device_node *
   458	tegra_emc_find_node_by_ram_code(struct tegra_emc *emc)
   459	{
   460		struct device *dev = emc->dev;
   461		struct device_node *np;
   462		u32 value, ram_code;
   463		int err;
   464	
   465		if (emc->mrr_error) {
   466			dev_warn(dev, "memory timings skipped due to MRR error\n");
   467			return NULL;
   468		}
   469	
   470		if (of_get_child_count(dev->of_node) == 0) {
   471			dev_info_once(dev, "device-tree doesn't have memory timings\n");
   472			return NULL;
   473		}
   474	
   475		if (!of_property_read_bool(dev->of_node, "nvidia,use-ram-code"))
   476			return of_node_get(dev->of_node);
   477	
   478		ram_code = tegra_read_ram_code();
   479	
 > 480		of_get_node(dev->of_node);
   481		for (np = of_find_node_by_name(dev->of_node, "emc-tables"); np;
   482		     np = of_find_node_by_name(np, "emc-tables")) {
   483			err = of_property_read_u32(np, "nvidia,ram-code", &value);
   484			if (err || value != ram_code) {
   485				struct device_node *lpddr2_np;
   486				bool cfg_mismatches = false;
   487	
   488				of_node_get(np);
   489				lpddr2_np = of_find_node_by_name(np, "lpddr2");
   490				if (lpddr2_np) {
   491					const struct lpddr2_info *info;
   492	
   493					info = of_lpddr2_get_info(lpddr2_np, dev);
   494					if (info) {
   495						if (info->manufacturer_id >= 0 &&
   496						    info->manufacturer_id != emc->manufacturer_id)
   497							cfg_mismatches = true;
   498	
   499						if (info->revision_id1 >= 0 &&
   500						    info->revision_id1 != emc->revision_id1)
   501							cfg_mismatches = true;
   502	
   503						if (info->revision_id2 >= 0 &&
   504						    info->revision_id2 != emc->revision_id2)
   505							cfg_mismatches = true;
   506	
   507						if (info->density != emc->basic_conf4.density)
   508							cfg_mismatches = true;
   509	
   510						if (info->io_width != emc->basic_conf4.io_width)
   511							cfg_mismatches = true;
   512	
   513						if (info->arch_type != emc->basic_conf4.arch_type)
   514							cfg_mismatches = true;
   515					} else {
   516						dev_err(dev, "failed to parse %pOF\n", lpddr2_np);
   517						cfg_mismatches = true;
   518					}
   519	
   520					of_node_put(lpddr2_np);
   521				} else {
   522					cfg_mismatches = true;
   523				}
   524	
   525				if (cfg_mismatches) {
   526					continue;
   527				}
   528			}
   529	
   530			return np;
   531		}
   532	
   533		dev_err(dev, "no memory timings for RAM code %u found in device tree\n",
   534			ram_code);
   535	
   536		return NULL;
   537	}
   538	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
