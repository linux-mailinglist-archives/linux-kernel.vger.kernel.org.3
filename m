Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 398AF50B27F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 10:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445396AbiDVICa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 04:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445384AbiDVICR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 04:02:17 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0FBF527C6;
        Fri, 22 Apr 2022 00:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650614364; x=1682150364;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VNrOIsgR/2M+tjpgcaLOR6tT5XMMHe+vpYMTNT8yqJE=;
  b=FQnx7c+5lFmkzTIpWm/qcVESF6Nk/PeTaPlLahcNnkDin+IEW2njl9gX
   khJ85nsE4dX7LjZysRHd2pzWa4rrcbGHMpxJnuGV3ezsIrUHnTpvKG0dj
   IHvS/3nZdmIgM2ydWeS3VLyGnWC7LxJNmj7b5gxo8B6s9vp7LVUVlF7m2
   005SQlbnpEwKov3f6XSNyiTakVI6sj9EvWTa/zlsZmgHZ0L7zRB+yNii6
   m6lG161OTEJ3XHNvwqIX5FkezT17RTkyvQcBa+DdeDae6/bTyxSWD309E
   yX+9Ge9PCVA8N5dHsfIKn77z7KYg3tixmj0H24OVv2RqOzAdf11FE3MgT
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="264385685"
X-IronPort-AV: E=Sophos;i="5.90,281,1643702400"; 
   d="scan'208";a="264385685"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 00:59:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,281,1643702400"; 
   d="scan'208";a="648522037"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Apr 2022 00:59:19 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhoCF-0009uY-1P;
        Fri, 22 Apr 2022 07:59:19 +0000
Date:   Fri, 22 Apr 2022 15:58:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jianjun Wang <jianjun.wang@mediatek.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     kbuild-all@lists.01.org, Wei-Shun Chang <weishunc@google.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        rex-bc.chen@mediatek.com, randy.wu@mediatek.com,
        jieyy.yang@mediatek.com, chuanjia.liu@mediatek.com,
        qizhong.cheng@mediatek.com, jian.yang@mediatek.com
Subject: Re: [PATCH v6 2/2] phy: mediatek: Add PCIe PHY driver
Message-ID: <202204221513.SZZHW8dq-lkp@intel.com>
References: <20220422041125.12732-3-jianjun.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422041125.12732-3-jianjun.wang@mediatek.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jianjun,

I love your patch! Yet something to improve:

[auto build test ERROR on robh/for-next]
[also build test ERROR on linus/master v5.18-rc3 next-20220421]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Jianjun-Wang/phy-mediatek-Add-PCIe-PHY-driver/20220422-121407
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20220422/202204221513.SZZHW8dq-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/c2ea770ff29995df64bc82ad12ece5b671415a62
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jianjun-Wang/phy-mediatek-Add-PCIe-PHY-driver/20220422-121407
        git checkout c2ea770ff29995df64bc82ad12ece5b671415a62
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/phy/mediatek/phy-mtk-pcie.c: In function 'mtk_pcie_efuse_set_lane':
>> drivers/phy/mediatek/phy-mtk-pcie.c:92:29: error: implicit declaration of function 'FIELD_PREP' [-Werror=implicit-function-declaration]
      92 |                             FIELD_PREP(EFUSE_LN_TX_PMOS_SEL, data->tx_pmos));
         |                             ^~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/FIELD_PREP +92 drivers/phy/mediatek/phy-mtk-pcie.c

    78	
    79	static void mtk_pcie_efuse_set_lane(struct mtk_pcie_phy *pcie_phy,
    80					    unsigned int lane)
    81	{
    82		struct mtk_pcie_lane_efuse *data = &pcie_phy->efuse[lane];
    83		void __iomem *addr;
    84	
    85		if (!data->lane_efuse_supported)
    86			return;
    87	
    88		addr = pcie_phy->sif_base + PEXTP_ANA_LN0_TRX_REG +
    89		       lane * PEXTP_ANA_LANE_OFFSET;
    90	
    91		mtk_phy_update_bits(addr + PEXTP_ANA_TX_REG, EFUSE_LN_TX_PMOS_SEL,
  > 92				    FIELD_PREP(EFUSE_LN_TX_PMOS_SEL, data->tx_pmos));
    93	
    94		mtk_phy_update_bits(addr + PEXTP_ANA_TX_REG, EFUSE_LN_TX_NMOS_SEL,
    95				    FIELD_PREP(EFUSE_LN_TX_NMOS_SEL, data->tx_nmos));
    96	
    97		mtk_phy_update_bits(addr + PEXTP_ANA_RX_REG, EFUSE_LN_RX_SEL,
    98				    FIELD_PREP(EFUSE_LN_RX_SEL, data->rx_data));
    99	}
   100	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
