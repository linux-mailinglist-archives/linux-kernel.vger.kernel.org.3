Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F15AB4D66F2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 17:58:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350473AbiCKQ7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 11:59:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350333AbiCKQ7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 11:59:49 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3509673D5;
        Fri, 11 Mar 2022 08:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647017925; x=1678553925;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8tt9qgzw4Kq/v31eFaRN55hhJVALG1NfF2eNwvPj8zw=;
  b=FFuzbEmifR9Mv+P/oR61YORAEDnHvtTxYLeriALSpZSlmGKbQ5zjteij
   gy24c15yxVshe2kNaCdaVHnqSpySoEhztgIFCH27/X4f+gVp62WC8ER0b
   c5JDPkT7Hnsw6kM/PpdCMKrNmGeeiwaiX81k9Vjpy2Zerogm5OpzCOg7F
   Mar4UOAwIXXcjMPemrwnElLq41qoaVI8s7sLwFEQGTCnJaUWCZX5LbSPp
   sUKyHvlL1xgG5PBmxZz7FnB6xTYFQq78YOSw8ioZ75LFshGE7vObcj447
   /LwwXyq/I3Ygk6hxpZp4egs9FfoVMb3+yvuYU+sNEJIJFI9N6S4c+Lz24
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10283"; a="255342698"
X-IronPort-AV: E=Sophos;i="5.90,174,1643702400"; 
   d="scan'208";a="255342698"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2022 08:58:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,174,1643702400"; 
   d="scan'208";a="555375546"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 11 Mar 2022 08:58:37 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nSib6-0006nH-EB; Fri, 11 Mar 2022 16:58:36 +0000
Date:   Sat, 12 Mar 2022 00:57:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tinghan Shen <tinghan.shen@mediatek.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Tinghan Shen <tinghan.shen@mediatek.com>
Subject: Re: [PATCH v2] remoteproc: mediatek: fix side effect of mt8195 sram
 power on
Message-ID: <202203120056.qtDEVoye-lkp@intel.com>
References: <20220311123056.32689-1-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220311123056.32689-1-tinghan.shen@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tinghan,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on remoteproc/rproc-next]
[also build test ERROR on v5.17-rc7 next-20220310]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Tinghan-Shen/remoteproc-mediatek-fix-side-effect-of-mt8195-sram-power-on/20220311-203255
base:   git://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git rproc-next
config: parisc-randconfig-r031-20220310 (https://download.01.org/0day-ci/archive/20220312/202203120056.qtDEVoye-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/6d56ab3bae4e0d5e07d295169602883ba7d7de08
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Tinghan-Shen/remoteproc-mediatek-fix-side-effect-of-mt8195-sram-power-on/20220311-203255
        git checkout 6d56ab3bae4e0d5e07d295169602883ba7d7de08
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=parisc SHELL=/bin/bash drivers/remoteproc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/remoteproc/mtk_scp.c: In function 'mt8195_scp_before_load':
>> drivers/remoteproc/mtk_scp.c:418:27: error: 'MT8195_L1TCM_SRAM_PDN_RESERVED_BITS' undeclared (first use in this function); did you mean 'MT8195_L1TCM_SRAM_PDN_RESERVED_RSI_BITS'?
     418 |                           MT8195_L1TCM_SRAM_PDN_RESERVED_BITS);
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                           MT8195_L1TCM_SRAM_PDN_RESERVED_RSI_BITS
   drivers/remoteproc/mtk_scp.c:418:27: note: each undeclared identifier is reported only once for each function it appears in
   drivers/remoteproc/mtk_scp.c: In function 'mt8195_scp_stop':
   drivers/remoteproc/mtk_scp.c:592:28: error: 'MT8195_L1TCM_SRAM_PDN_RESERVED_BITS' undeclared (first use in this function); did you mean 'MT8195_L1TCM_SRAM_PDN_RESERVED_RSI_BITS'?
     592 |                            MT8195_L1TCM_SRAM_PDN_RESERVED_BITS);
         |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                            MT8195_L1TCM_SRAM_PDN_RESERVED_RSI_BITS


vim +418 drivers/remoteproc/mtk_scp.c

   405	
   406	static int mt8195_scp_before_load(struct mtk_scp *scp)
   407	{
   408		/* clear SPM interrupt, SCP2SPM_IPC_CLR */
   409		writel(0xff, scp->reg_base + MT8192_SCP2SPM_IPC_CLR);
   410	
   411		writel(1, scp->reg_base + MT8192_CORE0_SW_RSTN_SET);
   412	
   413		/* enable SRAM clock */
   414		scp_sram_power_on(scp->reg_base + MT8192_L2TCM_SRAM_PD_0, 0);
   415		scp_sram_power_on(scp->reg_base + MT8192_L2TCM_SRAM_PD_1, 0);
   416		scp_sram_power_on(scp->reg_base + MT8192_L2TCM_SRAM_PD_2, 0);
   417		scp_sram_power_on(scp->reg_base + MT8192_L1TCM_SRAM_PDN,
 > 418				  MT8195_L1TCM_SRAM_PDN_RESERVED_BITS);
   419		scp_sram_power_on(scp->reg_base + MT8192_CPU0_SRAM_PD, 0);
   420	
   421		/* enable MPU for all memory regions */
   422		writel(0xff, scp->reg_base + MT8192_CORE0_MEM_ATT_PREDEF);
   423	
   424		return 0;
   425	}
   426	

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
