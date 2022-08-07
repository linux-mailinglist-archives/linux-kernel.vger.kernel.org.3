Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC6A358BB13
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 15:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234304AbiHGNrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 09:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231732AbiHGNrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 09:47:36 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F1AE63D6
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 06:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659880056; x=1691416056;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1wjeDtgjXIiXdVp/aTmmCQyW/BpVcMKTWoJpvFqfEew=;
  b=JuMNlmkvBIbyPNTy56CnJBBBWXl4xPoqqd6z3czHFCMySWF7YYtut9zz
   AgbEZlsbnPWZ1Mt2qvK2r19sBojB8guyogKuFQDfApQgTVrXm5b5V5TWB
   j9qndXm0t7P6uX8lnpAcOEHNl6EEcVRbgpl4AU2zaGN9c27h2/Lp4e2Av
   wfKkJA+OPN1SX+JOQQ/HRgUYBGv6TllgQuFoXRYM5WgiruV8cqVssbhwg
   qLCYNpN4jTS1QJShX6uudlP/sIT+BCUlrWHL63nmyY2ngj5syS/Mog/OR
   gDlIP3DF1s9vCzGU2ulukRWrHQupbfQYYqX14CwS3F+hUxbMzXRuDRkxi
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10432"; a="288002729"
X-IronPort-AV: E=Sophos;i="5.93,220,1654585200"; 
   d="scan'208";a="288002729"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2022 06:47:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,220,1654585200"; 
   d="scan'208";a="672183210"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 07 Aug 2022 06:47:33 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oKgcv-000LKp-0f;
        Sun, 07 Aug 2022 13:47:33 +0000
Date:   Sun, 7 Aug 2022 21:47:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Qi Zheng <zhengqi.arch@bytedance.com>, will@kernel.org,
        arnd@arndb.de, catalin.marinas@arm.com, mark.rutland@arm.com
Cc:     kbuild-all@lists.01.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v2] arm64: run softirqs on the per-CPU IRQ stack
Message-ID: <202208072123.sWU13g72-lkp@intel.com>
References: <20220802065325.39740-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220802065325.39740-1-zhengqi.arch@bytedance.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qi,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on soc/for-next]
[also build test WARNING on v5.19]
[cannot apply to arm64/for-next/core linus/master next-20220805]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Qi-Zheng/arm64-run-softirqs-on-the-per-CPU-IRQ-stack/20220802-145547
base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
config: arm64-randconfig-r024-20220801 (https://download.01.org/0day-ci/archive/20220807/202208072123.sWU13g72-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/34ac9375ce5e75127084159f724fcb2208c022a3
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Qi-Zheng/arm64-run-softirqs-on-the-per-CPU-IRQ-stack/20220802-145547
        git checkout 34ac9375ce5e75127084159f724fcb2208c022a3
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/kernel/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/arm64/kernel/irq.c:81:6: warning: no previous prototype for 'do_softirq_own_stack' [-Wmissing-prototypes]
      81 | void do_softirq_own_stack(void)
         |      ^~~~~~~~~~~~~~~~~~~~
   arch/arm64/kernel/irq.c:120:13: warning: no previous prototype for 'init_IRQ' [-Wmissing-prototypes]
     120 | void __init init_IRQ(void)
         |             ^~~~~~~~


vim +/do_softirq_own_stack +81 arch/arm64/kernel/irq.c

    80	
  > 81	void do_softirq_own_stack(void)
    82	{
    83		call_on_irq_stack(NULL, ____do_softirq);
    84	}
    85	#endif
    86	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
