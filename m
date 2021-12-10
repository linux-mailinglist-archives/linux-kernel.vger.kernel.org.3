Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6D5F470EF6
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 00:51:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243597AbhLJXzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 18:55:02 -0500
Received: from mga05.intel.com ([192.55.52.43]:34575 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233117AbhLJXzB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 18:55:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639180286; x=1670716286;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0wRqQ6iFdLPg8IYrh/pR7emU39pn5+hR9xRkzb6ing0=;
  b=HOp0ubUoq5juLVLR4Rbbqpa2PSDqKXL5L1ZiQni2slxPtSGXfNBFQbhP
   VJBMXRlwjIDXxVd6NKjxlU+uxMCl+pXB6T9CI7l1flmhB/WtztxM3Yul6
   vq/3nLUVgOSTQamclkkwju51QDc/8gB7FlvdggmFcRgtZveO4N+cslJol
   QZgZZ/lP92pOq8q/S+fcaWlw26UInSxn46/puKc2JVnMFcYaddvhdF9Jb
   jsq18hFK4Rxc9XMx1baJsnPQl9z2K2/7/4Ay93p87gxyhFtQ4p3DxPaFt
   GD7xv+CbKy5aOd54oDcTb5B+FTWPfl6GMA1uMMgHMiISwqtEtoqhjVfVa
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10194"; a="324750009"
X-IronPort-AV: E=Sophos;i="5.88,197,1635231600"; 
   d="scan'208";a="324750009"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2021 15:51:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,197,1635231600"; 
   d="scan'208";a="753337096"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 10 Dec 2021 15:51:22 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mvpfe-0003pJ-1R; Fri, 10 Dec 2021 23:51:22 +0000
Date:   Sat, 11 Dec 2021 07:50:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org,
        will@kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        iommu@lists.linux-foundation.org, suravee.suthikulpanit@amd.com,
        baolu.lu@linux.intel.com, willy@infradead.org,
        linux-kernel@vger.kernel.org, john.garry@huawei.com,
        linux-mm@kvack.org
Subject: Re: [PATCH v2 11/11] iommu: Move flush queue data into
 iommu_dma_cookie
Message-ID: <202112110744.cWU0wC1O-lkp@intel.com>
References: <e2e24e5f4174a56c725cde3164f86a3e234f6d7f.1639157090.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2e24e5f4174a56c725cde3164f86a3e234f6d7f.1639157090.git.robin.murphy@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

I love your patch! Yet something to improve:

[auto build test ERROR on joro-iommu/next]
[also build test ERROR on tegra/for-next v5.16-rc4]
[cannot apply to tegra-drm/drm/tegra/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Robin-Murphy/iommu-refactor-flush-queues-into-iommu-dma/20211211-015635
base:   https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git next
config: arm64-randconfig-r014-20211210 (https://download.01.org/0day-ci/archive/20211211/202112110744.cWU0wC1O-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 097a1cb1d5ebb3a0ec4bcaed8ba3ff6a8e33c00a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/0day-ci/linux/commit/3b6adb4a8ec42d7b5c1b3b1af2c857a2375fd7e1
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Robin-Murphy/iommu-refactor-flush-queues-into-iommu-dma/20211211-015635
        git checkout 3b6adb4a8ec42d7b5c1b3b1af2c857a2375fd7e1
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/gpu/drm/tegra/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/gpu/drm/tegra/hub.c:1043:17: error: implicit declaration of function 'dma_get_mask' [-Werror,-Wimplicit-function-declaration]
           u64 dma_mask = dma_get_mask(pdev->dev.parent);
                          ^
   drivers/gpu/drm/tegra/hub.c:1043:17: note: did you mean 'xa_get_mark'?
   include/linux/xarray.h:354:6: note: 'xa_get_mark' declared here
   bool xa_get_mark(struct xarray *, unsigned long index, xa_mark_t);
        ^
>> drivers/gpu/drm/tegra/hub.c:1050:8: error: implicit declaration of function 'dma_coerce_mask_and_coherent' [-Werror,-Wimplicit-function-declaration]
           err = dma_coerce_mask_and_coherent(&pdev->dev, dma_mask);
                 ^
   2 errors generated.
--
>> drivers/gpu/drm/tegra/plane.c:46:21: error: use of undeclared identifier 'DMA_MAPPING_ERROR'
                           state->iova[i] = DMA_MAPPING_ERROR;
                                            ^
   drivers/gpu/drm/tegra/plane.c:76:19: error: use of undeclared identifier 'DMA_MAPPING_ERROR'
                   copy->iova[i] = DMA_MAPPING_ERROR;
                                   ^
>> drivers/gpu/drm/tegra/plane.c:170:10: error: implicit declaration of function 'dma_map_sgtable' [-Werror,-Wimplicit-function-declaration]
                           err = dma_map_sgtable(dc->dev, sgt, DMA_TO_DEVICE, 0);
                                 ^
   drivers/gpu/drm/tegra/plane.c:170:10: note: did you mean 'iommu_map_sgtable'?
   include/linux/iommu.h:1097:22: note: 'iommu_map_sgtable' declared here
   static inline size_t iommu_map_sgtable(struct iommu_domain *domain,
                        ^
>> drivers/gpu/drm/tegra/plane.c:170:40: error: use of undeclared identifier 'DMA_TO_DEVICE'
                           err = dma_map_sgtable(dc->dev, sgt, DMA_TO_DEVICE, 0);
                                                               ^
>> drivers/gpu/drm/tegra/plane.c:202:4: error: implicit declaration of function 'dma_unmap_sgtable' [-Werror,-Wimplicit-function-declaration]
                           dma_unmap_sgtable(dc->dev, sgt, DMA_TO_DEVICE, 0);
                           ^
   drivers/gpu/drm/tegra/plane.c:202:4: note: did you mean 'iommu_map_sgtable'?
   include/linux/iommu.h:1097:22: note: 'iommu_map_sgtable' declared here
   static inline size_t iommu_map_sgtable(struct iommu_domain *domain,
                        ^
   drivers/gpu/drm/tegra/plane.c:202:36: error: use of undeclared identifier 'DMA_TO_DEVICE'
                           dma_unmap_sgtable(dc->dev, sgt, DMA_TO_DEVICE, 0);
                                                           ^
   drivers/gpu/drm/tegra/plane.c:205:20: error: use of undeclared identifier 'DMA_MAPPING_ERROR'
                   state->iova[i] = DMA_MAPPING_ERROR;
                                    ^
   drivers/gpu/drm/tegra/plane.c:221:4: error: implicit declaration of function 'dma_unmap_sgtable' [-Werror,-Wimplicit-function-declaration]
                           dma_unmap_sgtable(dc->dev, sgt, DMA_TO_DEVICE, 0);
                           ^
   drivers/gpu/drm/tegra/plane.c:221:36: error: use of undeclared identifier 'DMA_TO_DEVICE'
                           dma_unmap_sgtable(dc->dev, sgt, DMA_TO_DEVICE, 0);
                                                           ^
   drivers/gpu/drm/tegra/plane.c:224:20: error: use of undeclared identifier 'DMA_MAPPING_ERROR'
                   state->iova[i] = DMA_MAPPING_ERROR;
                                    ^
   10 errors generated.
--
   drivers/gpu/drm/tegra/dc.c:2225:31: warning: variable 'old_state' set but not used [-Wunused-but-set-variable]
           const struct drm_crtc_state *old_state;
                                        ^
>> drivers/gpu/drm/tegra/dc.c:2978:17: error: implicit declaration of function 'dma_get_mask' [-Werror,-Wimplicit-function-declaration]
           u64 dma_mask = dma_get_mask(pdev->dev.parent);
                          ^
   drivers/gpu/drm/tegra/dc.c:2978:17: note: did you mean 'xa_get_mark'?
   include/linux/xarray.h:354:6: note: 'xa_get_mark' declared here
   bool xa_get_mark(struct xarray *, unsigned long index, xa_mark_t);
        ^
>> drivers/gpu/drm/tegra/dc.c:2982:8: error: implicit declaration of function 'dma_coerce_mask_and_coherent' [-Werror,-Wimplicit-function-declaration]
           err = dma_coerce_mask_and_coherent(&pdev->dev, dma_mask);
                 ^
   1 warning and 2 errors generated.


vim +/dma_get_mask +1043 drivers/gpu/drm/tegra/hub.c

c4755fb9064f640 Thierry Reding 2017-11-13  1040  
c4755fb9064f640 Thierry Reding 2017-11-13  1041  static int tegra_display_hub_probe(struct platform_device *pdev)
c4755fb9064f640 Thierry Reding 2017-11-13  1042  {
86044e749be77a3 Thierry Reding 2021-03-26 @1043  	u64 dma_mask = dma_get_mask(pdev->dev.parent);
0cffbde2e318cc1 Thierry Reding 2018-11-29  1044  	struct device_node *child = NULL;
c4755fb9064f640 Thierry Reding 2017-11-13  1045  	struct tegra_display_hub *hub;
0cffbde2e318cc1 Thierry Reding 2018-11-29  1046  	struct clk *clk;
c4755fb9064f640 Thierry Reding 2017-11-13  1047  	unsigned int i;
c4755fb9064f640 Thierry Reding 2017-11-13  1048  	int err;
c4755fb9064f640 Thierry Reding 2017-11-13  1049  
86044e749be77a3 Thierry Reding 2021-03-26 @1050  	err = dma_coerce_mask_and_coherent(&pdev->dev, dma_mask);
86044e749be77a3 Thierry Reding 2021-03-26  1051  	if (err < 0) {
86044e749be77a3 Thierry Reding 2021-03-26  1052  		dev_err(&pdev->dev, "failed to set DMA mask: %d\n", err);
86044e749be77a3 Thierry Reding 2021-03-26  1053  		return err;
86044e749be77a3 Thierry Reding 2021-03-26  1054  	}
86044e749be77a3 Thierry Reding 2021-03-26  1055  
c4755fb9064f640 Thierry Reding 2017-11-13  1056  	hub = devm_kzalloc(&pdev->dev, sizeof(*hub), GFP_KERNEL);
c4755fb9064f640 Thierry Reding 2017-11-13  1057  	if (!hub)
c4755fb9064f640 Thierry Reding 2017-11-13  1058  		return -ENOMEM;
c4755fb9064f640 Thierry Reding 2017-11-13  1059  
c4755fb9064f640 Thierry Reding 2017-11-13  1060  	hub->soc = of_device_get_match_data(&pdev->dev);
c4755fb9064f640 Thierry Reding 2017-11-13  1061  
c4755fb9064f640 Thierry Reding 2017-11-13  1062  	hub->clk_disp = devm_clk_get(&pdev->dev, "disp");
c4755fb9064f640 Thierry Reding 2017-11-13  1063  	if (IS_ERR(hub->clk_disp)) {
c4755fb9064f640 Thierry Reding 2017-11-13  1064  		err = PTR_ERR(hub->clk_disp);
c4755fb9064f640 Thierry Reding 2017-11-13  1065  		return err;
c4755fb9064f640 Thierry Reding 2017-11-13  1066  	}
c4755fb9064f640 Thierry Reding 2017-11-13  1067  
5725daaab55ca02 Thierry Reding 2018-09-21  1068  	if (hub->soc->supports_dsc) {
c4755fb9064f640 Thierry Reding 2017-11-13  1069  		hub->clk_dsc = devm_clk_get(&pdev->dev, "dsc");
c4755fb9064f640 Thierry Reding 2017-11-13  1070  		if (IS_ERR(hub->clk_dsc)) {
c4755fb9064f640 Thierry Reding 2017-11-13  1071  			err = PTR_ERR(hub->clk_dsc);
c4755fb9064f640 Thierry Reding 2017-11-13  1072  			return err;
c4755fb9064f640 Thierry Reding 2017-11-13  1073  		}
5725daaab55ca02 Thierry Reding 2018-09-21  1074  	}
c4755fb9064f640 Thierry Reding 2017-11-13  1075  
c4755fb9064f640 Thierry Reding 2017-11-13  1076  	hub->clk_hub = devm_clk_get(&pdev->dev, "hub");
c4755fb9064f640 Thierry Reding 2017-11-13  1077  	if (IS_ERR(hub->clk_hub)) {
c4755fb9064f640 Thierry Reding 2017-11-13  1078  		err = PTR_ERR(hub->clk_hub);
c4755fb9064f640 Thierry Reding 2017-11-13  1079  		return err;
c4755fb9064f640 Thierry Reding 2017-11-13  1080  	}
c4755fb9064f640 Thierry Reding 2017-11-13  1081  
c4755fb9064f640 Thierry Reding 2017-11-13  1082  	hub->rst = devm_reset_control_get(&pdev->dev, "misc");
c4755fb9064f640 Thierry Reding 2017-11-13  1083  	if (IS_ERR(hub->rst)) {
c4755fb9064f640 Thierry Reding 2017-11-13  1084  		err = PTR_ERR(hub->rst);
c4755fb9064f640 Thierry Reding 2017-11-13  1085  		return err;
c4755fb9064f640 Thierry Reding 2017-11-13  1086  	}
c4755fb9064f640 Thierry Reding 2017-11-13  1087  
c4755fb9064f640 Thierry Reding 2017-11-13  1088  	hub->wgrps = devm_kcalloc(&pdev->dev, hub->soc->num_wgrps,
c4755fb9064f640 Thierry Reding 2017-11-13  1089  				  sizeof(*hub->wgrps), GFP_KERNEL);
c4755fb9064f640 Thierry Reding 2017-11-13  1090  	if (!hub->wgrps)
c4755fb9064f640 Thierry Reding 2017-11-13  1091  		return -ENOMEM;
c4755fb9064f640 Thierry Reding 2017-11-13  1092  
c4755fb9064f640 Thierry Reding 2017-11-13  1093  	for (i = 0; i < hub->soc->num_wgrps; i++) {
c4755fb9064f640 Thierry Reding 2017-11-13  1094  		struct tegra_windowgroup *wgrp = &hub->wgrps[i];
c4755fb9064f640 Thierry Reding 2017-11-13  1095  		char id[8];
c4755fb9064f640 Thierry Reding 2017-11-13  1096  
c4755fb9064f640 Thierry Reding 2017-11-13  1097  		snprintf(id, sizeof(id), "wgrp%u", i);
c4755fb9064f640 Thierry Reding 2017-11-13  1098  		mutex_init(&wgrp->lock);
c4755fb9064f640 Thierry Reding 2017-11-13  1099  		wgrp->usecount = 0;
c4755fb9064f640 Thierry Reding 2017-11-13  1100  		wgrp->index = i;
c4755fb9064f640 Thierry Reding 2017-11-13  1101  
c4755fb9064f640 Thierry Reding 2017-11-13  1102  		wgrp->rst = devm_reset_control_get(&pdev->dev, id);
c4755fb9064f640 Thierry Reding 2017-11-13  1103  		if (IS_ERR(wgrp->rst))
c4755fb9064f640 Thierry Reding 2017-11-13  1104  			return PTR_ERR(wgrp->rst);
c4755fb9064f640 Thierry Reding 2017-11-13  1105  
c4755fb9064f640 Thierry Reding 2017-11-13  1106  		err = reset_control_assert(wgrp->rst);
c4755fb9064f640 Thierry Reding 2017-11-13  1107  		if (err < 0)
c4755fb9064f640 Thierry Reding 2017-11-13  1108  			return err;
c4755fb9064f640 Thierry Reding 2017-11-13  1109  	}
c4755fb9064f640 Thierry Reding 2017-11-13  1110  
0cffbde2e318cc1 Thierry Reding 2018-11-29  1111  	hub->num_heads = of_get_child_count(pdev->dev.of_node);
0cffbde2e318cc1 Thierry Reding 2018-11-29  1112  
0cffbde2e318cc1 Thierry Reding 2018-11-29  1113  	hub->clk_heads = devm_kcalloc(&pdev->dev, hub->num_heads, sizeof(clk),
0cffbde2e318cc1 Thierry Reding 2018-11-29  1114  				      GFP_KERNEL);
0cffbde2e318cc1 Thierry Reding 2018-11-29  1115  	if (!hub->clk_heads)
0cffbde2e318cc1 Thierry Reding 2018-11-29  1116  		return -ENOMEM;
0cffbde2e318cc1 Thierry Reding 2018-11-29  1117  
0cffbde2e318cc1 Thierry Reding 2018-11-29  1118  	for (i = 0; i < hub->num_heads; i++) {
0cffbde2e318cc1 Thierry Reding 2018-11-29  1119  		child = of_get_next_child(pdev->dev.of_node, child);
0cffbde2e318cc1 Thierry Reding 2018-11-29  1120  		if (!child) {
0cffbde2e318cc1 Thierry Reding 2018-11-29  1121  			dev_err(&pdev->dev, "failed to find node for head %u\n",
0cffbde2e318cc1 Thierry Reding 2018-11-29  1122  				i);
0cffbde2e318cc1 Thierry Reding 2018-11-29  1123  			return -ENODEV;
0cffbde2e318cc1 Thierry Reding 2018-11-29  1124  		}
0cffbde2e318cc1 Thierry Reding 2018-11-29  1125  
0cffbde2e318cc1 Thierry Reding 2018-11-29  1126  		clk = devm_get_clk_from_child(&pdev->dev, child, "dc");
0cffbde2e318cc1 Thierry Reding 2018-11-29  1127  		if (IS_ERR(clk)) {
0cffbde2e318cc1 Thierry Reding 2018-11-29  1128  			dev_err(&pdev->dev, "failed to get clock for head %u\n",
0cffbde2e318cc1 Thierry Reding 2018-11-29  1129  				i);
0cffbde2e318cc1 Thierry Reding 2018-11-29  1130  			of_node_put(child);
0cffbde2e318cc1 Thierry Reding 2018-11-29  1131  			return PTR_ERR(clk);
0cffbde2e318cc1 Thierry Reding 2018-11-29  1132  		}
0cffbde2e318cc1 Thierry Reding 2018-11-29  1133  
0cffbde2e318cc1 Thierry Reding 2018-11-29  1134  		hub->clk_heads[i] = clk;
0cffbde2e318cc1 Thierry Reding 2018-11-29  1135  	}
0cffbde2e318cc1 Thierry Reding 2018-11-29  1136  
0cffbde2e318cc1 Thierry Reding 2018-11-29  1137  	of_node_put(child);
0cffbde2e318cc1 Thierry Reding 2018-11-29  1138  
c4755fb9064f640 Thierry Reding 2017-11-13  1139  	/* XXX: enable clock across reset? */
c4755fb9064f640 Thierry Reding 2017-11-13  1140  	err = reset_control_assert(hub->rst);
c4755fb9064f640 Thierry Reding 2017-11-13  1141  	if (err < 0)
c4755fb9064f640 Thierry Reding 2017-11-13  1142  		return err;
c4755fb9064f640 Thierry Reding 2017-11-13  1143  
c4755fb9064f640 Thierry Reding 2017-11-13  1144  	platform_set_drvdata(pdev, hub);
c4755fb9064f640 Thierry Reding 2017-11-13  1145  	pm_runtime_enable(&pdev->dev);
c4755fb9064f640 Thierry Reding 2017-11-13  1146  
c4755fb9064f640 Thierry Reding 2017-11-13  1147  	INIT_LIST_HEAD(&hub->client.list);
c4755fb9064f640 Thierry Reding 2017-11-13  1148  	hub->client.ops = &tegra_display_hub_ops;
c4755fb9064f640 Thierry Reding 2017-11-13  1149  	hub->client.dev = &pdev->dev;
c4755fb9064f640 Thierry Reding 2017-11-13  1150  
c4755fb9064f640 Thierry Reding 2017-11-13  1151  	err = host1x_client_register(&hub->client);
c4755fb9064f640 Thierry Reding 2017-11-13  1152  	if (err < 0)
c4755fb9064f640 Thierry Reding 2017-11-13  1153  		dev_err(&pdev->dev, "failed to register host1x client: %d\n",
c4755fb9064f640 Thierry Reding 2017-11-13  1154  			err);
c4755fb9064f640 Thierry Reding 2017-11-13  1155  
a101e3dad8a90a8 Thierry Reding 2020-06-12  1156  	err = devm_of_platform_populate(&pdev->dev);
a101e3dad8a90a8 Thierry Reding 2020-06-12  1157  	if (err < 0)
a101e3dad8a90a8 Thierry Reding 2020-06-12  1158  		goto unregister;
a101e3dad8a90a8 Thierry Reding 2020-06-12  1159  
a101e3dad8a90a8 Thierry Reding 2020-06-12  1160  	return err;
a101e3dad8a90a8 Thierry Reding 2020-06-12  1161  
a101e3dad8a90a8 Thierry Reding 2020-06-12  1162  unregister:
a101e3dad8a90a8 Thierry Reding 2020-06-12  1163  	host1x_client_unregister(&hub->client);
a101e3dad8a90a8 Thierry Reding 2020-06-12  1164  	pm_runtime_disable(&pdev->dev);
c4755fb9064f640 Thierry Reding 2017-11-13  1165  	return err;
c4755fb9064f640 Thierry Reding 2017-11-13  1166  }
c4755fb9064f640 Thierry Reding 2017-11-13  1167  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
