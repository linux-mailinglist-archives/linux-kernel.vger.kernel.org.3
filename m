Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF665694A7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 23:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234325AbiGFVq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 17:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233573AbiGFVq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 17:46:56 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D6522291
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 14:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657144015; x=1688680015;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=vWGrL0p+451e0Urj9P6SW1C0mu9h/ERUe2NztInapK8=;
  b=fv06xmWop10W3UAZmjL2uS9XurvUwo748M4pj1V6u5eWZlNK0YoylKa2
   tGkSXvuMr19NqsaZsH4gaxleq5/gR2pJWM/c82eqSByw1CDAmiGfU2PgV
   GD4BWIqPMgk7yf5PF794VeHesZGGd9z7jyPMcntNsDauL+y8ePvliC9Qq
   Rf7w5IQYhERkrLbSQ0ebNOcTNogNMMCfKppYdfofiy6XaPsyc7VNCfGnf
   JUaTDBNmwRjh/U9a3u29s6375OAumiUkgul3BXuDv8PTcQj575pZwprfF
   D35dx+CgRQFI/z6pMJewfI4W4K3Ef9zC/5iSXbpjMqukjfJkMsZRtq0VX
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10400"; a="263661223"
X-IronPort-AV: E=Sophos;i="5.92,251,1650956400"; 
   d="scan'208";a="263661223"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 14:46:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,251,1650956400"; 
   d="scan'208";a="568248435"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 06 Jul 2022 14:46:53 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o9CrE-000L5h-NV;
        Wed, 06 Jul 2022 21:46:52 +0000
Date:   Thu, 7 Jul 2022 05:46:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Viorel Suman <viorel.suman@nxp.com>
Subject: [ammarfaizi2-block:broonie/sound/for-next 322/353]
 sound/soc/fsl/fsl_utils.c:125:31: sparse: sparse: Using plain integer as
 NULL pointer
Message-ID: <202207070521.JjRAUeas-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shengjiu,

First bad commit (maybe != root cause):

tree:   https://github.com/ammarfaizi2/linux-block broonie/sound/for-next
head:   3f4322bb413adb7f9d8b5e9005eb1b9bc85f9312
commit: 93f54100fbdedc22e8d88d037a8a3e32101724eb [322/353] ASoC: fsl_micfil: Add support for PLL switch at runtime
config: powerpc-randconfig-s031-20220706 (https://download.01.org/0day-ci/archive/20220707/202207070521.JjRAUeas-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/ammarfaizi2/linux-block/commit/93f54100fbdedc22e8d88d037a8a3e32101724eb
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block broonie/sound/for-next
        git checkout 93f54100fbdedc22e8d88d037a8a3e32101724eb
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=powerpc SHELL=/bin/bash sound/soc/fsl/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> sound/soc/fsl/fsl_utils.c:125:31: sparse: sparse: Using plain integer as NULL pointer
   sound/soc/fsl/fsl_utils.c:125:42: sparse: sparse: Using plain integer as NULL pointer

vim +125 sound/soc/fsl/fsl_utils.c

7bad8125549cda Shengjiu Wang 2022-07-01  109  
7bad8125549cda Shengjiu Wang 2022-07-01  110  /**
7bad8125549cda Shengjiu Wang 2022-07-01  111   * fsl_asoc_reparent_pll_clocks - set clock parent if necessary
7bad8125549cda Shengjiu Wang 2022-07-01  112   *
7bad8125549cda Shengjiu Wang 2022-07-01  113   * @dev: device pointer
7bad8125549cda Shengjiu Wang 2022-07-01  114   * @clk: root clock pointer
7bad8125549cda Shengjiu Wang 2022-07-01  115   * @pll8k_clk: PLL clock pointer for 8kHz
7bad8125549cda Shengjiu Wang 2022-07-01  116   * @pll11k_clk: PLL clock pointer for 11kHz
7bad8125549cda Shengjiu Wang 2022-07-01  117   * @ratio: target requency for root clock
7bad8125549cda Shengjiu Wang 2022-07-01  118   *
7bad8125549cda Shengjiu Wang 2022-07-01  119   * This function set root clock parent according to the target ratio
7bad8125549cda Shengjiu Wang 2022-07-01  120   */
7bad8125549cda Shengjiu Wang 2022-07-01  121  void fsl_asoc_reparent_pll_clocks(struct device *dev, struct clk *clk,
7bad8125549cda Shengjiu Wang 2022-07-01  122  				  struct clk *pll8k_clk,
7bad8125549cda Shengjiu Wang 2022-07-01  123  				  struct clk *pll11k_clk, u64 ratio)
7bad8125549cda Shengjiu Wang 2022-07-01  124  {
7bad8125549cda Shengjiu Wang 2022-07-01 @125  	struct clk *p, *pll = 0, *npll = 0;
7bad8125549cda Shengjiu Wang 2022-07-01  126  	bool reparent = false;
7bad8125549cda Shengjiu Wang 2022-07-01  127  	int ret = 0;
7bad8125549cda Shengjiu Wang 2022-07-01  128  
7bad8125549cda Shengjiu Wang 2022-07-01  129  	if (!clk || !pll8k_clk || !pll11k_clk)
7bad8125549cda Shengjiu Wang 2022-07-01  130  		return;
7bad8125549cda Shengjiu Wang 2022-07-01  131  
7bad8125549cda Shengjiu Wang 2022-07-01  132  	p = clk;
7bad8125549cda Shengjiu Wang 2022-07-01  133  	while (p && pll8k_clk && pll11k_clk) {
7bad8125549cda Shengjiu Wang 2022-07-01  134  		struct clk *pp = clk_get_parent(p);
7bad8125549cda Shengjiu Wang 2022-07-01  135  
7bad8125549cda Shengjiu Wang 2022-07-01  136  		if (clk_is_match(pp, pll8k_clk) ||
7bad8125549cda Shengjiu Wang 2022-07-01  137  		    clk_is_match(pp, pll11k_clk)) {
7bad8125549cda Shengjiu Wang 2022-07-01  138  			pll = pp;
7bad8125549cda Shengjiu Wang 2022-07-01  139  			break;
7bad8125549cda Shengjiu Wang 2022-07-01  140  		}
7bad8125549cda Shengjiu Wang 2022-07-01  141  		p = pp;
7bad8125549cda Shengjiu Wang 2022-07-01  142  	}
7bad8125549cda Shengjiu Wang 2022-07-01  143  
7bad8125549cda Shengjiu Wang 2022-07-01  144  	npll = (do_div(ratio, 8000) ? pll11k_clk : pll8k_clk);
7bad8125549cda Shengjiu Wang 2022-07-01  145  	reparent = (pll && !clk_is_match(pll, npll));
7bad8125549cda Shengjiu Wang 2022-07-01  146  
7bad8125549cda Shengjiu Wang 2022-07-01  147  	if (reparent) {
7bad8125549cda Shengjiu Wang 2022-07-01  148  		ret = clk_set_parent(p, npll);
7bad8125549cda Shengjiu Wang 2022-07-01  149  		if (ret < 0)
7bad8125549cda Shengjiu Wang 2022-07-01  150  			dev_warn(dev, "failed to set parent %s: %d\n", __clk_get_name(npll), ret);
7bad8125549cda Shengjiu Wang 2022-07-01  151  	}
7bad8125549cda Shengjiu Wang 2022-07-01  152  }
7bad8125549cda Shengjiu Wang 2022-07-01  153  EXPORT_SYMBOL(fsl_asoc_reparent_pll_clocks);
7bad8125549cda Shengjiu Wang 2022-07-01  154  

:::::: The code at line 125 was first introduced by commit
:::::: 7bad8125549cda14d9ccf97d7d76f7ef6ac9d206 ASoC: fsl_utils: Add function to handle PLL clock source

:::::: TO: Shengjiu Wang <shengjiu.wang@nxp.com>
:::::: CC: Mark Brown <broonie@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
