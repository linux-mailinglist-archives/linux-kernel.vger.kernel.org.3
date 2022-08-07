Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41E3A58BC4D
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 20:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234432AbiHGSQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 14:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234777AbiHGSPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 14:15:49 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5236964D9
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 11:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659896148; x=1691432148;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SzlJQkY7FhUA15heqPBSFMQ71M01/eJ0bitLZcONHA0=;
  b=K9wDDw9Obkisr4ETK2zPSoRZIcOjVDFpV6DpZFnc/vJ8OW/bic0p8I/O
   /dJoAHfrRjuY7zWQauaIC3EJuYDcNwrARu1Cc7UbdzVSTyCNdGQ7z022q
   NGvdRdVq3PCyZCidV/ecskyxasEHaItX92M2M6i5hStExAkDmpLcLHHoF
   vMZNXUOr8PAJw54YQN0w1pEm+hO3wXsWPVEFszo1KrcJHPkMAFp4oD9SB
   /hY1O/cxrR99gJS9DwTPMorGS9Ou5G8lzhTkN+TkFIVZclN6OvRydAv3x
   lQapAhtUXU7OBTR4Y0MwmGH+IIMzBv5A6HGNY9X8xyzl4vGkgYdreZuiy
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10432"; a="288019381"
X-IronPort-AV: E=Sophos;i="5.93,220,1654585200"; 
   d="scan'208";a="288019381"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2022 11:15:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,220,1654585200"; 
   d="scan'208";a="849836383"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 07 Aug 2022 11:15:46 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oKkoT-000LY1-15;
        Sun, 07 Aug 2022 18:15:45 +0000
Date:   Mon, 8 Aug 2022 02:15:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Paul Cercueil <paul@crapouillou.net>,
        Lee Jones <lee.jones@linaro.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 25/28] mfd: stmfx: Remove #ifdef guards for PM related
 functions
Message-ID: <202208080225.Hm01SP8r-lkp@intel.com>
References: <20220807145247.46107-26-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220807145247.46107-26-paul@crapouillou.net>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

I love your patch! Yet something to improve:

[auto build test ERROR on v5.19]
[cannot apply to lee-mfd/for-mfd-next linus/master next-20220805]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Paul-Cercueil/mfd-Remove-ifdef-guards-for-PM-functions/20220807-225947
base:    3d7cb6b04c3f3115719235cc6866b10326de34cd
config: hexagon-randconfig-r013-20220807 (https://download.01.org/0day-ci/archive/20220808/202208080225.Hm01SP8r-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 5f1c7e2cc5a3c07cbc2412e851a7283c1841f520)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/5a39bd52d549e3f3be743fb336dd710eac75055d
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Paul-Cercueil/mfd-Remove-ifdef-guards-for-PM-functions/20220807-225947
        git checkout 5a39bd52d549e3f3be743fb336dd710eac75055d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/mfd/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/mfd/stmfx.c:485:18: error: no member named 'bkp_sysctrl' in 'struct stmfx'
                                 &stmfx->bkp_sysctrl, sizeof(stmfx->bkp_sysctrl));
                                  ~~~~~  ^
   drivers/mfd/stmfx.c:485:45: error: no member named 'bkp_sysctrl' in 'struct stmfx'
                                 &stmfx->bkp_sysctrl, sizeof(stmfx->bkp_sysctrl));
                                                             ~~~~~  ^
>> drivers/mfd/stmfx.c:490:18: error: no member named 'bkp_irqoutpin' in 'struct stmfx'
                                 &stmfx->bkp_irqoutpin,
                                  ~~~~~  ^
   drivers/mfd/stmfx.c:491:24: error: no member named 'bkp_irqoutpin' in 'struct stmfx'
                                 sizeof(stmfx->bkp_irqoutpin));
                                        ~~~~~  ^
   drivers/mfd/stmfx.c:525:19: error: no member named 'bkp_sysctrl' in 'struct stmfx'
                                  &stmfx->bkp_sysctrl, sizeof(stmfx->bkp_sysctrl));
                                   ~~~~~  ^
   drivers/mfd/stmfx.c:525:46: error: no member named 'bkp_sysctrl' in 'struct stmfx'
                                  &stmfx->bkp_sysctrl, sizeof(stmfx->bkp_sysctrl));
                                                              ~~~~~  ^
   drivers/mfd/stmfx.c:530:19: error: no member named 'bkp_irqoutpin' in 'struct stmfx'
                                  &stmfx->bkp_irqoutpin,
                                   ~~~~~  ^
   drivers/mfd/stmfx.c:531:25: error: no member named 'bkp_irqoutpin' in 'struct stmfx'
                                  sizeof(stmfx->bkp_irqoutpin));
                                         ~~~~~  ^
   8 errors generated.


vim +485 drivers/mfd/stmfx.c

06252ade915665 Amelie Delaunay 2019-05-09  478  
06252ade915665 Amelie Delaunay 2019-05-09  479  static int stmfx_suspend(struct device *dev)
06252ade915665 Amelie Delaunay 2019-05-09  480  {
06252ade915665 Amelie Delaunay 2019-05-09  481  	struct stmfx *stmfx = dev_get_drvdata(dev);
06252ade915665 Amelie Delaunay 2019-05-09  482  	int ret;
06252ade915665 Amelie Delaunay 2019-05-09  483  
06252ade915665 Amelie Delaunay 2019-05-09  484  	ret = regmap_raw_read(stmfx->map, STMFX_REG_SYS_CTRL,
06252ade915665 Amelie Delaunay 2019-05-09 @485  			      &stmfx->bkp_sysctrl, sizeof(stmfx->bkp_sysctrl));
06252ade915665 Amelie Delaunay 2019-05-09  486  	if (ret)
06252ade915665 Amelie Delaunay 2019-05-09  487  		return ret;
06252ade915665 Amelie Delaunay 2019-05-09  488  
06252ade915665 Amelie Delaunay 2019-05-09  489  	ret = regmap_raw_read(stmfx->map, STMFX_REG_IRQ_OUT_PIN,
06252ade915665 Amelie Delaunay 2019-05-09 @490  			      &stmfx->bkp_irqoutpin,
06252ade915665 Amelie Delaunay 2019-05-09  491  			      sizeof(stmfx->bkp_irqoutpin));
06252ade915665 Amelie Delaunay 2019-05-09  492  	if (ret)
06252ade915665 Amelie Delaunay 2019-05-09  493  		return ret;
06252ade915665 Amelie Delaunay 2019-05-09  494  
97eda5dcc2cde5 Amelie Delaunay 2020-04-22  495  	disable_irq(stmfx->irq);
97eda5dcc2cde5 Amelie Delaunay 2020-04-22  496  
06252ade915665 Amelie Delaunay 2019-05-09  497  	if (stmfx->vdd)
06252ade915665 Amelie Delaunay 2019-05-09  498  		return regulator_disable(stmfx->vdd);
06252ade915665 Amelie Delaunay 2019-05-09  499  
06252ade915665 Amelie Delaunay 2019-05-09  500  	return 0;
06252ade915665 Amelie Delaunay 2019-05-09  501  }
06252ade915665 Amelie Delaunay 2019-05-09  502  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
