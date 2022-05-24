Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80B5C532B2F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 15:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237757AbiEXNVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 09:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237746AbiEXNVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 09:21:38 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E274819C35;
        Tue, 24 May 2022 06:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653398497; x=1684934497;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BFliaCv+cB0PXbv3YekuYdrRznvm76kroRO4soD7CkE=;
  b=KBkjTpswLxKWjYjgsyjJaZdzLDyK5nUav6G2PYxRLLlf4ZZpfL9oL43S
   JIq8VQ78qnFyzeTIG7PzoZ6yrwj0HcfeSpTZq2BiiO/TPCFP0AS0QlFp1
   vT+5gu9TL4/hz+4+2zJYwJBfr72cqgDgOA4OV6Kz0vLLpbmgxWIS0vSVB
   tfA7su2U4LtGEylq3dDndujtDlM3JKYg+XJfsy3FodJ74+AJy73x36BmV
   SJeDofi2aoTPY+05Sa0+OXI9oF8s5/FZ5gaJqGvD1U9Zii26YTXysV0M6
   ocB1IbMvyCyTQaKVBNzrPQhsVhCX7B1TDupbcwALwzQjWN/mdTHwEdKLj
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10356"; a="298847583"
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; 
   d="scan'208";a="298847583"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 06:21:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; 
   d="scan'208";a="641935455"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 24 May 2022 06:21:34 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ntUTe-00025e-17;
        Tue, 24 May 2022 13:21:34 +0000
Date:   Tue, 24 May 2022 21:20:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Miles Chen <miles.chen@mediatek.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/7] clk: mediatek: mt6779: use mtk_clk_simple_probe
 to simplify driver
Message-ID: <202205242129.DezL7Tp0-lkp@intel.com>
References: <20220524083843.9994-5-miles.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220524083843.9994-5-miles.chen@mediatek.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miles,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on clk/clk-next]
[also build test ERROR on next-20220524]
[cannot apply to v5.18]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Miles-Chen/clk-mediatek-mt2701-use-mtk_clk_simple_probe-to-simplify-driver/20220524-173952
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
config: arm-randconfig-r014-20220524 (https://download.01.org/0day-ci/archive/20220524/202205242129.DezL7Tp0-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 10c9ecce9f6096e18222a331c5e7d085bd813f75)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/intel-lab-lkp/linux/commit/22d101bc8621971e234c34276dce52c37b82b498
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Miles-Chen/clk-mediatek-mt2701-use-mtk_clk_simple_probe-to-simplify-driver/20220524-173952
        git checkout 22d101bc8621971e234c34276dce52c37b82b498
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

ERROR: modpost: missing MODULE_LICENSE() in drivers/clk/imx/clk-imxrt1050.o
ERROR: modpost: "vmf_insert_pfn" [drivers/gpu/drm/drm_shmem_helper.ko] undefined!
>> ERROR: modpost: "mtk_clk_simple_remove" [drivers/clk/mediatek/clk-mt6779-aud.ko] undefined!
>> ERROR: modpost: "mtk_clk_simple_probe" [drivers/clk/mediatek/clk-mt6779-aud.ko] undefined!
>> ERROR: modpost: "mtk_clk_simple_remove" [drivers/clk/mediatek/clk-mt6779-vdec.ko] undefined!
>> ERROR: modpost: "mtk_clk_simple_probe" [drivers/clk/mediatek/clk-mt6779-vdec.ko] undefined!
>> ERROR: modpost: "mtk_clk_simple_remove" [drivers/clk/mediatek/clk-mt6779-cam.ko] undefined!
>> ERROR: modpost: "mtk_clk_simple_probe" [drivers/clk/mediatek/clk-mt6779-cam.ko] undefined!
>> ERROR: modpost: "mtk_clk_simple_remove" [drivers/clk/mediatek/clk-mt6779-ipe.ko] undefined!
>> ERROR: modpost: "mtk_clk_simple_probe" [drivers/clk/mediatek/clk-mt6779-ipe.ko] undefined!
ERROR: modpost: "imx_clk_hw_pfd" [drivers/clk/imx/clk-imxrt1050.ko] undefined!
WARNING: modpost: suppressed 1 unresolved symbol warnings because there were too many)

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for DRM_GEM_SHMEM_HELPER
   Depends on HAS_IOMEM && DRM && MMU
   Selected by
   - DRM_SSD130X && HAS_IOMEM && DRM

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
