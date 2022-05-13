Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB7C5259C9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 04:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376570AbiEMCng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 22:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376539AbiEMCnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 22:43:32 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C270E52B0B
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 19:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652409810; x=1683945810;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+cUtYQK4Km2C++rGq/ah79HG9mDpGf2y1yRstGxDmSo=;
  b=FwEJtlF+S7TN5FFzpbJjdgpGGPkoL/l3VZTOzV1FZx5AR8JlNAxOMJnR
   Y/eogD/Xk+wTMKdLBY+GzmUoIQDEDXCkoTQL6PrR9A2aHq+X18qk8edG0
   1qQu3Kd/Ohv3tjEDQQ4W17KwBczWEkOKcTPKQC8Z6d1zeRad877TrovVJ
   WlMpSnxh5uizFHtSfFKVdCugG/916eH4cAcjEZ9vkheB32rlCqxpCZEaZ
   GDCxBzdI+jtuOTVlVvNTRQeymTSMBJmiv+iOP4KG48Xz0uWI2vMN8U28K
   l5GO152vkhfpRHdbow2p6cLh8CEXJpiilpXkNZGK964EzaFNYZ5A6ufI2
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10345"; a="333230777"
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="333230777"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 19:43:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="566987110"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 12 May 2022 19:43:26 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1npLH3-000LCz-Bl;
        Fri, 13 May 2022 02:43:25 +0000
Date:   Fri, 13 May 2022 10:43:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     yf.wang@mediatek.com, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Isaac J. Manjarres" <isaacm@codeaurora.org>,
        Georgi Djakov <quic_c_gdjako@quicinc.com>,
        Sven Peter <sven@svenpeter.dev>,
        "moderated list:ARM SMMU DRIVERS" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Cc:     kbuild-all@lists.01.org, wsd_upstream@mediatek.com,
        Libo Kang <Libo.Kang@mediatek.com>,
        Yong Wu <Yong.Wu@mediatek.com>, Ning Li <ning.li@mediatek.com>
Subject: Re: [PATCH v3 1/2] iommu/io-pgtable-arm-v7s: Add a quirk to allow
 pgtable PA up to 35bit
Message-ID: <202205131021.3GskEbg2-lkp@intel.com>
References: <20220512144557.18025-2-yf.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220512144557.18025-2-yf.wang@mediatek.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on arm-perf/for-next/perf]
[also build test WARNING on linus/master v5.18-rc6]
[cannot apply to joro-iommu/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/yf-wang-mediatek-com/iommu-io-pgtable-arm-v7s-Add-a-quirk-to-allow-pgtable-PA-up-to-35bit/20220512-234603
base:   https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-next/perf
config: arm-qcom_defconfig (https://download.01.org/0day-ci/archive/20220513/202205131021.3GskEbg2-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/916a5fc41cbb8ddfe343193598f250d06b09e3fa
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review yf-wang-mediatek-com/iommu-io-pgtable-arm-v7s-Add-a-quirk-to-allow-pgtable-PA-up-to-35bit/20220512-234603
        git checkout 916a5fc41cbb8ddfe343193598f250d06b09e3fa
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/iommu/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/ratelimit_types.h:5,
                    from include/linux/ratelimit.h:5,
                    from include/linux/dev_printk.h:16,
                    from include/linux/device.h:15,
                    from include/linux/dma-mapping.h:7,
                    from drivers/iommu/io-pgtable-arm-v7s.c:25:
   drivers/iommu/io-pgtable-arm-v7s.c: In function 'arm_v7s_alloc_pgtable':
   include/linux/bits.h:35:29: warning: left shift count >= width of type [-Wshift-count-overflow]
      35 |         (((~UL(0)) - (UL(1) << (l)) + 1) & \
         |                             ^~
   include/linux/bits.h:38:38: note: in expansion of macro '__GENMASK'
      38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/iommu/io-pgtable-arm-v7s.c:154:46: note: in expansion of macro 'GENMASK'
     154 |         ((ttbr & ((u32)(~0U << 3))) | ((pa & GENMASK(34, 32)) >> 32))
         |                                              ^~~~~~~
   drivers/iommu/io-pgtable-arm-v7s.c:886:25: note: in expansion of macro 'ARM_V7S_TTBR_35BIT_PA'
     886 |                         ARM_V7S_TTBR_35BIT_PA(cfg->arm_v7s_cfg.ttbr, paddr);
         |                         ^~~~~~~~~~~~~~~~~~~~~
   include/linux/bits.h:36:18: warning: right shift count is negative [-Wshift-count-negative]
      36 |          (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
         |                  ^~
   include/linux/bits.h:38:38: note: in expansion of macro '__GENMASK'
      38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/iommu/io-pgtable-arm-v7s.c:154:46: note: in expansion of macro 'GENMASK'
     154 |         ((ttbr & ((u32)(~0U << 3))) | ((pa & GENMASK(34, 32)) >> 32))
         |                                              ^~~~~~~
   drivers/iommu/io-pgtable-arm-v7s.c:886:25: note: in expansion of macro 'ARM_V7S_TTBR_35BIT_PA'
     886 |                         ARM_V7S_TTBR_35BIT_PA(cfg->arm_v7s_cfg.ttbr, paddr);
         |                         ^~~~~~~~~~~~~~~~~~~~~
>> drivers/iommu/io-pgtable-arm-v7s.c:154:63: warning: right shift count >= width of type [-Wshift-count-overflow]
     154 |         ((ttbr & ((u32)(~0U << 3))) | ((pa & GENMASK(34, 32)) >> 32))
         |                                                               ^~
   drivers/iommu/io-pgtable-arm-v7s.c:886:25: note: in expansion of macro 'ARM_V7S_TTBR_35BIT_PA'
     886 |                         ARM_V7S_TTBR_35BIT_PA(cfg->arm_v7s_cfg.ttbr, paddr);
         |                         ^~~~~~~~~~~~~~~~~~~~~


vim +154 drivers/iommu/io-pgtable-arm-v7s.c

   145	
   146	#define ARM_V7S_TTBR_S			BIT(1)
   147	#define ARM_V7S_TTBR_NOS		BIT(5)
   148	#define ARM_V7S_TTBR_ORGN_ATTR(attr)	(((attr) & 0x3) << 3)
   149	#define ARM_V7S_TTBR_IRGN_ATTR(attr)					\
   150		((((attr) & 0x1) << 6) | (((attr) & 0x2) >> 1))
   151	
   152	/* Mediatek extend ttbr bits[2:0] for PA bits[34:32] */
   153	#define ARM_V7S_TTBR_35BIT_PA(ttbr, pa)					\
 > 154		((ttbr & ((u32)(~0U << 3))) | ((pa & GENMASK(34, 32)) >> 32))
   155	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
