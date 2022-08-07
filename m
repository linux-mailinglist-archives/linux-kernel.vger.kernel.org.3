Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 985AD58BBF1
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 19:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233227AbiHGRNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 13:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbiHGRNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 13:13:47 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E4864DA
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 10:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659892425; x=1691428425;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NElEcQw9ZRxqyFgN5yMpPdXrJCyEfJVYIuIlecHucOo=;
  b=I3UTIQOBTyJeN9+h6/SgGg1/4Bp4ufrr7aIhnNfFpJnz/cE7hgI3iwBY
   05nK8yUozqoKi4s05caB7QoPN8u6Y4s8De/FuZGvGPfu80pyjqjco85q5
   4kxts2wlDYBvSJzt0l2/ekx2KxN0tUarnY0yukRzQPUPlsL1Odi5gMh26
   SVjfEF+yEDLRLeYo95sEn+pPuGl2KLeWswxTx6ktzzuCBA7PdIBZ4goFY
   +mFAG3r4ndsgVkyaMSM/96d+wSgq70lG9WJjZj4GMlXYzlTALFLseRsib
   qrZ0+umta4UBUltv7aNOHKFtFEbyaKWRbQe4bWXBCvYK+flk7q7WXjQNY
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10432"; a="270837840"
X-IronPort-AV: E=Sophos;i="5.93,220,1654585200"; 
   d="scan'208";a="270837840"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2022 10:13:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,220,1654585200"; 
   d="scan'208";a="672213150"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 07 Aug 2022 10:13:43 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oKjqQ-000LVV-2V;
        Sun, 07 Aug 2022 17:13:42 +0000
Date:   Mon, 8 Aug 2022 01:13:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Paul Cercueil <paul@crapouillou.net>,
        Lee Jones <lee.jones@linaro.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 26/28] mfd: stmpe: Remove #ifdef guards for PM related
 functions
Message-ID: <202208080127.BXcJl3Wk-lkp@intel.com>
References: <20220807145247.46107-27-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220807145247.46107-27-paul@crapouillou.net>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

I love your patch! Perhaps something to improve:

[auto build test WARNING on v5.19]
[cannot apply to lee-mfd/for-mfd-next linus/master next-20220805]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Paul-Cercueil/mfd-Remove-ifdef-guards-for-PM-functions/20220807-225947
base:    3d7cb6b04c3f3115719235cc6866b10326de34cd
config: i386-randconfig-a015 (https://download.01.org/0day-ci/archive/20220808/202208080127.BXcJl3Wk-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 5f1c7e2cc5a3c07cbc2412e851a7283c1841f520)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/e94df3ff809e588320625b95a2ef6485965ddc02
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Paul-Cercueil/mfd-Remove-ifdef-guards-for-PM-functions/20220807-225947
        git checkout e94df3ff809e588320625b95a2ef6485965ddc02
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/mfd/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/mfd/stmpe.c:1531:7: warning: duplicate 'const' declaration specifier [-Wduplicate-decl-specifier]
   const EXPORT_GPL_SIMPLE_DEV_PM_OPS(stmpe_dev_pm_ops,
         ^
   include/linux/pm.h:404:2: note: expanded from macro 'EXPORT_GPL_SIMPLE_DEV_PM_OPS'
           _EXPORT_DEV_PM_OPS(name, suspend_fn, resume_fn, NULL, NULL, NULL, "_gpl", "")
           ^
   include/linux/pm.h:380:2: note: expanded from macro '_EXPORT_DEV_PM_OPS'
           _DEFINE_DEV_PM_OPS(name, suspend_fn, resume_fn, runtime_suspend_fn, \
           ^
   include/linux/pm.h:371:55: note: expanded from macro '_DEFINE_DEV_PM_OPS'
                              runtime_suspend_fn, runtime_resume_fn, idle_fn) \
                                                                              ^
   1 warning generated.


vim +/const +1531 drivers/mfd/stmpe.c

  1530	
> 1531	const EXPORT_GPL_SIMPLE_DEV_PM_OPS(stmpe_dev_pm_ops,

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
