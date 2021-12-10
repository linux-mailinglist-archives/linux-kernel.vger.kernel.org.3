Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2EA470EAE
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 00:30:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241069AbhLJXeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 18:34:01 -0500
Received: from mga11.intel.com ([192.55.52.93]:12080 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240676AbhLJXeA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 18:34:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639179024; x=1670715024;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=m2GhuwJ4UnyKyqy83lVmEBmiMbGKiHLXbCCHqnR/ajM=;
  b=J7hMM7tdV+JSNC7UxtPTEPsReEWzMo2sN7w10LLaNZds5eqw9QCtX7dP
   EHBa7KlgJdfnqOkh0msWLluddc8to4UaG46i69LLh+6JI6ISoE3l8XKnI
   03ms05ywYm9TbTn1vpSHi8e9LGiWgaVObpB1k2jc8MXkPNG6qBYQoWX95
   3VaPPq4a6q53vW2LID2rJhOaXDCIt7j7gzNZKzETXnjRo//HxaX7XPIgU
   4rjMzX+V3AYDY57KdWTgSWo7BlueLx+ThkTJyvXK9VaxaT8t4+Qi4u5Lj
   8PKSR7IBFL1GQ/qYLgCpEb9Sbmi9vuQIMfmRSd5FhXaY/fd6snjJq9CoB
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10194"; a="235993819"
X-IronPort-AV: E=Sophos;i="5.88,196,1635231600"; 
   d="scan'208";a="235993819"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2021 15:30:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,196,1635231600"; 
   d="scan'208";a="565479477"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 10 Dec 2021 15:30:21 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mvpLI-0003nt-Si; Fri, 10 Dec 2021 23:30:20 +0000
Date:   Sat, 11 Dec 2021 07:30:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org,
        will@kernel.org
Cc:     kbuild-all@lists.01.org, iommu@lists.linux-foundation.org,
        suravee.suthikulpanit@amd.com, baolu.lu@linux.intel.com,
        willy@infradead.org, linux-kernel@vger.kernel.org,
        john.garry@huawei.com, linux-mm@kvack.org
Subject: Re: [PATCH v2 11/11] iommu: Move flush queue data into
 iommu_dma_cookie
Message-ID: <202112110753.vYbSlMnq-lkp@intel.com>
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
config: arm-randconfig-r013-20211210 (https://download.01.org/0day-ci/archive/20211211/202112110753.vYbSlMnq-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/3b6adb4a8ec42d7b5c1b3b1af2c857a2375fd7e1
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Robin-Murphy/iommu-refactor-flush-queues-into-iommu-dma/20211211-015635
        git checkout 3b6adb4a8ec42d7b5c1b3b1af2c857a2375fd7e1
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash drivers/gpu/drm/tegra/ drivers/iommu/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/gpu/drm/tegra/hub.c: In function 'tegra_display_hub_probe':
>> drivers/gpu/drm/tegra/hub.c:1043:24: error: implicit declaration of function 'dma_get_mask'; did you mean 'xa_get_mark'? [-Werror=implicit-function-declaration]
    1043 |         u64 dma_mask = dma_get_mask(pdev->dev.parent);
         |                        ^~~~~~~~~~~~
         |                        xa_get_mark
>> drivers/gpu/drm/tegra/hub.c:1050:15: error: implicit declaration of function 'dma_coerce_mask_and_coherent' [-Werror=implicit-function-declaration]
    1050 |         err = dma_coerce_mask_and_coherent(&pdev->dev, dma_mask);
         |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   drivers/gpu/drm/tegra/plane.c: In function 'tegra_plane_reset':
>> drivers/gpu/drm/tegra/plane.c:46:42: error: 'DMA_MAPPING_ERROR' undeclared (first use in this function)
      46 |                         state->iova[i] = DMA_MAPPING_ERROR;
         |                                          ^~~~~~~~~~~~~~~~~
   drivers/gpu/drm/tegra/plane.c:46:42: note: each undeclared identifier is reported only once for each function it appears in
   drivers/gpu/drm/tegra/plane.c: In function 'tegra_plane_atomic_duplicate_state':
   drivers/gpu/drm/tegra/plane.c:76:33: error: 'DMA_MAPPING_ERROR' undeclared (first use in this function)
      76 |                 copy->iova[i] = DMA_MAPPING_ERROR;
         |                                 ^~~~~~~~~~~~~~~~~
   drivers/gpu/drm/tegra/plane.c: In function 'tegra_dc_pin':
>> drivers/gpu/drm/tegra/plane.c:170:31: error: implicit declaration of function 'dma_map_sgtable'; did you mean 'iommu_map_sgtable'? [-Werror=implicit-function-declaration]
     170 |                         err = dma_map_sgtable(dc->dev, sgt, DMA_TO_DEVICE, 0);
         |                               ^~~~~~~~~~~~~~~
         |                               iommu_map_sgtable
>> drivers/gpu/drm/tegra/plane.c:170:61: error: 'DMA_TO_DEVICE' undeclared (first use in this function); did you mean 'MT_DEVICE'?
     170 |                         err = dma_map_sgtable(dc->dev, sgt, DMA_TO_DEVICE, 0);
         |                                                             ^~~~~~~~~~~~~
         |                                                             MT_DEVICE
>> drivers/gpu/drm/tegra/plane.c:202:25: error: implicit declaration of function 'dma_unmap_sgtable'; did you mean 'iommu_map_sgtable'? [-Werror=implicit-function-declaration]
     202 |                         dma_unmap_sgtable(dc->dev, sgt, DMA_TO_DEVICE, 0);
         |                         ^~~~~~~~~~~~~~~~~
         |                         iommu_map_sgtable
   drivers/gpu/drm/tegra/plane.c:205:34: error: 'DMA_MAPPING_ERROR' undeclared (first use in this function)
     205 |                 state->iova[i] = DMA_MAPPING_ERROR;
         |                                  ^~~~~~~~~~~~~~~~~
   drivers/gpu/drm/tegra/plane.c: In function 'tegra_dc_unpin':
   drivers/gpu/drm/tegra/plane.c:221:57: error: 'DMA_TO_DEVICE' undeclared (first use in this function); did you mean 'MT_DEVICE'?
     221 |                         dma_unmap_sgtable(dc->dev, sgt, DMA_TO_DEVICE, 0);
         |                                                         ^~~~~~~~~~~~~
         |                                                         MT_DEVICE
   drivers/gpu/drm/tegra/plane.c:224:34: error: 'DMA_MAPPING_ERROR' undeclared (first use in this function)
     224 |                 state->iova[i] = DMA_MAPPING_ERROR;
         |                                  ^~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   drivers/gpu/drm/tegra/dc.c: In function 'tegra_crtc_calculate_memory_bandwidth':
   drivers/gpu/drm/tegra/dc.c:2225:38: warning: variable 'old_state' set but not used [-Wunused-but-set-variable]
    2225 |         const struct drm_crtc_state *old_state;
         |                                      ^~~~~~~~~
   drivers/gpu/drm/tegra/dc.c: In function 'tegra_dc_probe':
>> drivers/gpu/drm/tegra/dc.c:2978:24: error: implicit declaration of function 'dma_get_mask'; did you mean 'xa_get_mark'? [-Werror=implicit-function-declaration]
    2978 |         u64 dma_mask = dma_get_mask(pdev->dev.parent);
         |                        ^~~~~~~~~~~~
         |                        xa_get_mark
>> drivers/gpu/drm/tegra/dc.c:2982:15: error: implicit declaration of function 'dma_coerce_mask_and_coherent' [-Werror=implicit-function-declaration]
    2982 |         err = dma_coerce_mask_and_coherent(&pdev->dev, dma_mask);
         |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +1043 drivers/gpu/drm/tegra/hub.c

c4755fb9064f64 Thierry Reding 2017-11-13  1040  
c4755fb9064f64 Thierry Reding 2017-11-13  1041  static int tegra_display_hub_probe(struct platform_device *pdev)
c4755fb9064f64 Thierry Reding 2017-11-13  1042  {
86044e749be77a Thierry Reding 2021-03-26 @1043  	u64 dma_mask = dma_get_mask(pdev->dev.parent);
0cffbde2e318cc Thierry Reding 2018-11-29  1044  	struct device_node *child = NULL;
c4755fb9064f64 Thierry Reding 2017-11-13  1045  	struct tegra_display_hub *hub;
0cffbde2e318cc Thierry Reding 2018-11-29  1046  	struct clk *clk;
c4755fb9064f64 Thierry Reding 2017-11-13  1047  	unsigned int i;
c4755fb9064f64 Thierry Reding 2017-11-13  1048  	int err;
c4755fb9064f64 Thierry Reding 2017-11-13  1049  
86044e749be77a Thierry Reding 2021-03-26 @1050  	err = dma_coerce_mask_and_coherent(&pdev->dev, dma_mask);
86044e749be77a Thierry Reding 2021-03-26  1051  	if (err < 0) {
86044e749be77a Thierry Reding 2021-03-26  1052  		dev_err(&pdev->dev, "failed to set DMA mask: %d\n", err);
86044e749be77a Thierry Reding 2021-03-26  1053  		return err;
86044e749be77a Thierry Reding 2021-03-26  1054  	}
86044e749be77a Thierry Reding 2021-03-26  1055  
c4755fb9064f64 Thierry Reding 2017-11-13  1056  	hub = devm_kzalloc(&pdev->dev, sizeof(*hub), GFP_KERNEL);
c4755fb9064f64 Thierry Reding 2017-11-13  1057  	if (!hub)
c4755fb9064f64 Thierry Reding 2017-11-13  1058  		return -ENOMEM;
c4755fb9064f64 Thierry Reding 2017-11-13  1059  
c4755fb9064f64 Thierry Reding 2017-11-13  1060  	hub->soc = of_device_get_match_data(&pdev->dev);
c4755fb9064f64 Thierry Reding 2017-11-13  1061  
c4755fb9064f64 Thierry Reding 2017-11-13  1062  	hub->clk_disp = devm_clk_get(&pdev->dev, "disp");
c4755fb9064f64 Thierry Reding 2017-11-13  1063  	if (IS_ERR(hub->clk_disp)) {
c4755fb9064f64 Thierry Reding 2017-11-13  1064  		err = PTR_ERR(hub->clk_disp);
c4755fb9064f64 Thierry Reding 2017-11-13  1065  		return err;
c4755fb9064f64 Thierry Reding 2017-11-13  1066  	}
c4755fb9064f64 Thierry Reding 2017-11-13  1067  
5725daaab55ca0 Thierry Reding 2018-09-21  1068  	if (hub->soc->supports_dsc) {
c4755fb9064f64 Thierry Reding 2017-11-13  1069  		hub->clk_dsc = devm_clk_get(&pdev->dev, "dsc");
c4755fb9064f64 Thierry Reding 2017-11-13  1070  		if (IS_ERR(hub->clk_dsc)) {
c4755fb9064f64 Thierry Reding 2017-11-13  1071  			err = PTR_ERR(hub->clk_dsc);
c4755fb9064f64 Thierry Reding 2017-11-13  1072  			return err;
c4755fb9064f64 Thierry Reding 2017-11-13  1073  		}
5725daaab55ca0 Thierry Reding 2018-09-21  1074  	}
c4755fb9064f64 Thierry Reding 2017-11-13  1075  
c4755fb9064f64 Thierry Reding 2017-11-13  1076  	hub->clk_hub = devm_clk_get(&pdev->dev, "hub");
c4755fb9064f64 Thierry Reding 2017-11-13  1077  	if (IS_ERR(hub->clk_hub)) {
c4755fb9064f64 Thierry Reding 2017-11-13  1078  		err = PTR_ERR(hub->clk_hub);
c4755fb9064f64 Thierry Reding 2017-11-13  1079  		return err;
c4755fb9064f64 Thierry Reding 2017-11-13  1080  	}
c4755fb9064f64 Thierry Reding 2017-11-13  1081  
c4755fb9064f64 Thierry Reding 2017-11-13  1082  	hub->rst = devm_reset_control_get(&pdev->dev, "misc");
c4755fb9064f64 Thierry Reding 2017-11-13  1083  	if (IS_ERR(hub->rst)) {
c4755fb9064f64 Thierry Reding 2017-11-13  1084  		err = PTR_ERR(hub->rst);
c4755fb9064f64 Thierry Reding 2017-11-13  1085  		return err;
c4755fb9064f64 Thierry Reding 2017-11-13  1086  	}
c4755fb9064f64 Thierry Reding 2017-11-13  1087  
c4755fb9064f64 Thierry Reding 2017-11-13  1088  	hub->wgrps = devm_kcalloc(&pdev->dev, hub->soc->num_wgrps,
c4755fb9064f64 Thierry Reding 2017-11-13  1089  				  sizeof(*hub->wgrps), GFP_KERNEL);
c4755fb9064f64 Thierry Reding 2017-11-13  1090  	if (!hub->wgrps)
c4755fb9064f64 Thierry Reding 2017-11-13  1091  		return -ENOMEM;
c4755fb9064f64 Thierry Reding 2017-11-13  1092  
c4755fb9064f64 Thierry Reding 2017-11-13  1093  	for (i = 0; i < hub->soc->num_wgrps; i++) {
c4755fb9064f64 Thierry Reding 2017-11-13  1094  		struct tegra_windowgroup *wgrp = &hub->wgrps[i];
c4755fb9064f64 Thierry Reding 2017-11-13  1095  		char id[8];
c4755fb9064f64 Thierry Reding 2017-11-13  1096  
c4755fb9064f64 Thierry Reding 2017-11-13  1097  		snprintf(id, sizeof(id), "wgrp%u", i);
c4755fb9064f64 Thierry Reding 2017-11-13  1098  		mutex_init(&wgrp->lock);
c4755fb9064f64 Thierry Reding 2017-11-13  1099  		wgrp->usecount = 0;
c4755fb9064f64 Thierry Reding 2017-11-13  1100  		wgrp->index = i;
c4755fb9064f64 Thierry Reding 2017-11-13  1101  
c4755fb9064f64 Thierry Reding 2017-11-13  1102  		wgrp->rst = devm_reset_control_get(&pdev->dev, id);
c4755fb9064f64 Thierry Reding 2017-11-13  1103  		if (IS_ERR(wgrp->rst))
c4755fb9064f64 Thierry Reding 2017-11-13  1104  			return PTR_ERR(wgrp->rst);
c4755fb9064f64 Thierry Reding 2017-11-13  1105  
c4755fb9064f64 Thierry Reding 2017-11-13  1106  		err = reset_control_assert(wgrp->rst);
c4755fb9064f64 Thierry Reding 2017-11-13  1107  		if (err < 0)
c4755fb9064f64 Thierry Reding 2017-11-13  1108  			return err;
c4755fb9064f64 Thierry Reding 2017-11-13  1109  	}
c4755fb9064f64 Thierry Reding 2017-11-13  1110  
0cffbde2e318cc Thierry Reding 2018-11-29  1111  	hub->num_heads = of_get_child_count(pdev->dev.of_node);
0cffbde2e318cc Thierry Reding 2018-11-29  1112  
0cffbde2e318cc Thierry Reding 2018-11-29  1113  	hub->clk_heads = devm_kcalloc(&pdev->dev, hub->num_heads, sizeof(clk),
0cffbde2e318cc Thierry Reding 2018-11-29  1114  				      GFP_KERNEL);
0cffbde2e318cc Thierry Reding 2018-11-29  1115  	if (!hub->clk_heads)
0cffbde2e318cc Thierry Reding 2018-11-29  1116  		return -ENOMEM;
0cffbde2e318cc Thierry Reding 2018-11-29  1117  
0cffbde2e318cc Thierry Reding 2018-11-29  1118  	for (i = 0; i < hub->num_heads; i++) {
0cffbde2e318cc Thierry Reding 2018-11-29  1119  		child = of_get_next_child(pdev->dev.of_node, child);
0cffbde2e318cc Thierry Reding 2018-11-29  1120  		if (!child) {
0cffbde2e318cc Thierry Reding 2018-11-29  1121  			dev_err(&pdev->dev, "failed to find node for head %u\n",
0cffbde2e318cc Thierry Reding 2018-11-29  1122  				i);
0cffbde2e318cc Thierry Reding 2018-11-29  1123  			return -ENODEV;
0cffbde2e318cc Thierry Reding 2018-11-29  1124  		}
0cffbde2e318cc Thierry Reding 2018-11-29  1125  
0cffbde2e318cc Thierry Reding 2018-11-29  1126  		clk = devm_get_clk_from_child(&pdev->dev, child, "dc");
0cffbde2e318cc Thierry Reding 2018-11-29  1127  		if (IS_ERR(clk)) {
0cffbde2e318cc Thierry Reding 2018-11-29  1128  			dev_err(&pdev->dev, "failed to get clock for head %u\n",
0cffbde2e318cc Thierry Reding 2018-11-29  1129  				i);
0cffbde2e318cc Thierry Reding 2018-11-29  1130  			of_node_put(child);
0cffbde2e318cc Thierry Reding 2018-11-29  1131  			return PTR_ERR(clk);
0cffbde2e318cc Thierry Reding 2018-11-29  1132  		}
0cffbde2e318cc Thierry Reding 2018-11-29  1133  
0cffbde2e318cc Thierry Reding 2018-11-29  1134  		hub->clk_heads[i] = clk;
0cffbde2e318cc Thierry Reding 2018-11-29  1135  	}
0cffbde2e318cc Thierry Reding 2018-11-29  1136  
0cffbde2e318cc Thierry Reding 2018-11-29  1137  	of_node_put(child);
0cffbde2e318cc Thierry Reding 2018-11-29  1138  
c4755fb9064f64 Thierry Reding 2017-11-13  1139  	/* XXX: enable clock across reset? */
c4755fb9064f64 Thierry Reding 2017-11-13  1140  	err = reset_control_assert(hub->rst);
c4755fb9064f64 Thierry Reding 2017-11-13  1141  	if (err < 0)
c4755fb9064f64 Thierry Reding 2017-11-13  1142  		return err;
c4755fb9064f64 Thierry Reding 2017-11-13  1143  
c4755fb9064f64 Thierry Reding 2017-11-13  1144  	platform_set_drvdata(pdev, hub);
c4755fb9064f64 Thierry Reding 2017-11-13  1145  	pm_runtime_enable(&pdev->dev);
c4755fb9064f64 Thierry Reding 2017-11-13  1146  
c4755fb9064f64 Thierry Reding 2017-11-13  1147  	INIT_LIST_HEAD(&hub->client.list);
c4755fb9064f64 Thierry Reding 2017-11-13  1148  	hub->client.ops = &tegra_display_hub_ops;
c4755fb9064f64 Thierry Reding 2017-11-13  1149  	hub->client.dev = &pdev->dev;
c4755fb9064f64 Thierry Reding 2017-11-13  1150  
c4755fb9064f64 Thierry Reding 2017-11-13  1151  	err = host1x_client_register(&hub->client);
c4755fb9064f64 Thierry Reding 2017-11-13  1152  	if (err < 0)
c4755fb9064f64 Thierry Reding 2017-11-13  1153  		dev_err(&pdev->dev, "failed to register host1x client: %d\n",
c4755fb9064f64 Thierry Reding 2017-11-13  1154  			err);
c4755fb9064f64 Thierry Reding 2017-11-13  1155  
a101e3dad8a90a Thierry Reding 2020-06-12  1156  	err = devm_of_platform_populate(&pdev->dev);
a101e3dad8a90a Thierry Reding 2020-06-12  1157  	if (err < 0)
a101e3dad8a90a Thierry Reding 2020-06-12  1158  		goto unregister;
a101e3dad8a90a Thierry Reding 2020-06-12  1159  
a101e3dad8a90a Thierry Reding 2020-06-12  1160  	return err;
a101e3dad8a90a Thierry Reding 2020-06-12  1161  
a101e3dad8a90a Thierry Reding 2020-06-12  1162  unregister:
a101e3dad8a90a Thierry Reding 2020-06-12  1163  	host1x_client_unregister(&hub->client);
a101e3dad8a90a Thierry Reding 2020-06-12  1164  	pm_runtime_disable(&pdev->dev);
c4755fb9064f64 Thierry Reding 2017-11-13  1165  	return err;
c4755fb9064f64 Thierry Reding 2017-11-13  1166  }
c4755fb9064f64 Thierry Reding 2017-11-13  1167  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
