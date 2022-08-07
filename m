Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF3F58BC0A
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 19:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234452AbiHGRet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 13:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiHGRer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 13:34:47 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2380559A
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 10:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659893686; x=1691429686;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PJb6sgcaW6XwsPmmIIc5VDGbnksrZ6P+StXKyk0O5vk=;
  b=MLJnGOQucGr4lxonCBhtLYaZcPDzJBnzASRsRb0gdw6UdTFIB9X/5oSq
   XXOitkNUcI35F9YKgkGwUxLHlu1eqPNcJbyedalHPARONqpmY2gFLSJwO
   wUS4ipTCKFJ/L99FA6ai7pgSpia3+mtOb4l4uppdbluKKd3RInWJs2fxI
   iUGw7feIUGb+yS0QnyHuv14vm8H46jY/ZpRfqiACJfd/M+C4JKZoE3Pi7
   KCYX9NyUk280pSI8jhAzrtwUyS78cfU7oIoetFPKINstNeiytTSko310c
   fWpsgyF2RZstd5XlvyNBDrSBJ142DfuArz3Vb8lEYSbnvviX4nbtyD3lJ
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10432"; a="291682653"
X-IronPort-AV: E=Sophos;i="5.93,220,1654585200"; 
   d="scan'208";a="291682653"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2022 10:34:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,220,1654585200"; 
   d="scan'208";a="672215752"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 07 Aug 2022 10:34:44 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oKkAm-000LWL-0C;
        Sun, 07 Aug 2022 17:34:44 +0000
Date:   Mon, 8 Aug 2022 01:33:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Paul Cercueil <paul@crapouillou.net>,
        Lee Jones <lee.jones@linaro.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        patches@opensource.cirrus.com
Subject: Re: [PATCH 20/28] mfd: arizona: Remove #ifdef guards for PM related
 functions
Message-ID: <202208080141.UIoxRyzL-lkp@intel.com>
References: <20220807145247.46107-21-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220807145247.46107-21-paul@crapouillou.net>
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

I love your patch! Yet something to improve:

[auto build test ERROR on v5.19]
[cannot apply to lee-mfd/for-mfd-next linus/master next-20220805]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Paul-Cercueil/mfd-Remove-ifdef-guards-for-PM-functions/20220807-225947
base:    3d7cb6b04c3f3115719235cc6866b10326de34cd
config: hexagon-randconfig-r013-20220807 (https://download.01.org/0day-ci/archive/20220808/202208080141.UIoxRyzL-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 5f1c7e2cc5a3c07cbc2412e851a7283c1841f520)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/03342844cafff973ffa39ce471f64a76c4d87b06
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Paul-Cercueil/mfd-Remove-ifdef-guards-for-PM-functions/20220807-225947
        git checkout 03342844cafff973ffa39ce471f64a76c4d87b06
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/mfd/arizona-core.c:788:25: error: static declaration of 'arizona_pm_ops' follows non-static declaration
   const struct dev_pm_ops arizona_pm_ops = {
                           ^
   drivers/mfd/arizona.h:29:32: note: previous declaration is here
   extern const struct dev_pm_ops arizona_pm_ops;
                                  ^
   1 error generated.


vim +/arizona_pm_ops +788 drivers/mfd/arizona-core.c

dc781d0e10fca2 Mark Brown     2013-01-27  784  
03342844cafff9 Paul Cercueil  2022-08-07  785  #ifndef CONFIG_PM
03342844cafff9 Paul Cercueil  2022-08-07  786  static __maybe_unused
03342844cafff9 Paul Cercueil  2022-08-07  787  #endif
3cc72986947501 Mark Brown     2012-06-19 @788  const struct dev_pm_ops arizona_pm_ops = {
03342844cafff9 Paul Cercueil  2022-08-07  789  	RUNTIME_PM_OPS(arizona_runtime_suspend,
3cc72986947501 Mark Brown     2012-06-19  790  		       arizona_runtime_resume,
3cc72986947501 Mark Brown     2012-06-19  791  		       NULL)
03342844cafff9 Paul Cercueil  2022-08-07  792  	SYSTEM_SLEEP_PM_OPS(arizona_suspend, arizona_resume)
03342844cafff9 Paul Cercueil  2022-08-07  793  	NOIRQ_SYSTEM_SLEEP_PM_OPS(arizona_suspend_noirq,
3612b27cfb4a07 Charles Keepax 2016-08-30  794  				  arizona_resume_noirq)
3cc72986947501 Mark Brown     2012-06-19  795  };
03342844cafff9 Paul Cercueil  2022-08-07  796  #ifdef CONFIG_PM
3cc72986947501 Mark Brown     2012-06-19  797  EXPORT_SYMBOL_GPL(arizona_pm_ops);
03342844cafff9 Paul Cercueil  2022-08-07  798  #endif
3cc72986947501 Mark Brown     2012-06-19  799  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
