Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64F7D52058B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 21:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240716AbiEIT55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 15:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiEIT5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 15:57:55 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F8126A702;
        Mon,  9 May 2022 12:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652126040; x=1683662040;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TQPJMVgr8Y0+pWZ1dG23nKFgTtXv/p/Uqh4dA7ld2SY=;
  b=e0EheOJiI74jhMylzHiUmbJnuTYjsKvNNBWAI/j4Bv1GsbCA0X20PXgv
   bVxAB11ykd/UkPBRGbWYWgHfknsi74oM7Zza5Ns6g5DSiKAcniewruYUX
   /AoJxdLXvbKU6tJuo/2HZkSFgrLTpdn3HCnzzd153qHZvBygSjHYGFAgb
   IKL0Qqx/+nFHRSBVLZdkkURKoOvgEaZsgtLQvsWY5wo5M6WNoXH+8yC4p
   hUtD9gmubJ/i/JIFT5Gp0PBzoA5oJ+qjKoE6nL6rHzwtMGVFzvcYfvrzt
   +pIn/RrATc5gSczOg+BBYrTK85sY0EBWrg+gz1CSzxcpG9zaFd7ribwgJ
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10342"; a="269086723"
X-IronPort-AV: E=Sophos;i="5.91,212,1647327600"; 
   d="scan'208";a="269086723"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 12:53:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,212,1647327600"; 
   d="scan'208";a="669507546"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 09 May 2022 12:53:55 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1no9S7-000GqY-6u;
        Mon, 09 May 2022 19:53:55 +0000
Date:   Tue, 10 May 2022 03:53:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        daniel.lezcano@linaro.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org, tglx@linutronix.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, konrad.dybcio@somainline.org,
        marijn.suijten@somainline.org, martin.botka@somainline.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        paul.bouchara@somainline.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH 2/2] clocksource/drivers/timer-mediatek: Implement
 CPUXGPT timers
Message-ID: <202205100325.mvo9fxmN-lkp@intel.com>
References: <20220509102058.3064215-3-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220509102058.3064215-3-angelogioacchino.delregno@collabora.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi AngeloGioacchino,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on tip/timers/core]
[also build test WARNING on robh/for-next v5.18-rc6 next-20220509]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/AngeloGioacchino-Del-Regno/MediaTek-SoC-ARM-ARM64-System-Timer/20220509-182806
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git f4b62e1e1137507268c2c63dc4e6da279dc58e9f
config: mips-randconfig-r015-20220509 (https://download.01.org/0day-ci/archive/20220510/202205100325.mvo9fxmN-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project a385645b470e2d3a1534aae618ea56b31177639f)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/cd08992dd0c0e2c02229be62ecb2a51da4c1d315
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review AngeloGioacchino-Del-Regno/MediaTek-SoC-ARM-ARM64-System-Timer/20220509-182806
        git checkout cd08992dd0c0e2c02229be62ecb2a51da4c1d315
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/clocksource/ drivers/gpu/drm/mgag200/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/clocksource/timer-mediatek.c:103:6: warning: variable 'val' set but not used [-Wunused-but-set-variable]
           u32 val;
               ^
   1 warning generated.


vim +/val +103 drivers/clocksource/timer-mediatek.c

    99	
   100	static void mtk_cpux_disable_irq(struct timer_of *to)
   101	{
   102		const unsigned long *irq_mask = cpumask_bits(cpu_possible_mask);
 > 103		u32 val;
   104	
   105		val = mtk_cpux_readl(CPUX_IDX_GLOBAL_IRQ, to);
   106		val &= ~(*irq_mask);
   107	}
   108	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
