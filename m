Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6829A58B4E5
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 12:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238073AbiHFKBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 06:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbiHFKA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 06:00:57 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1157155A8;
        Sat,  6 Aug 2022 03:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659780056; x=1691316056;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DArrsJl+igQhfiejk3LBgfFW4Irk33+l5lRq4yjeRtA=;
  b=EDUnbtVZjxmb/o8UZs2ufBDLxQLWKM9Zq5rwg5rqeDyycaLDhkcPVcm3
   FzJToJny9MVymesJhCV6QnHQlBSYgw3+HhDpYPX2X0Xd4N3dAFVmUFNa4
   oJ+X5c9zTt8h3Xprzuu8L7+RlZ89NnXitrIc6BlUOCOQDC1c7s8iskOFI
   ZjvoqINjBbxF6i482MtWFvadGER64oLqq8Evp1emaja7DQ1rVgQ4bH1GM
   1GG5eoDkFta6isP6XXJZcxtU8V04k5b7EgE5xaZ99MgGyIWCtZLMVL0ty
   +o/UYla4ccd4NgMcZsOj6OaZxRut/ZUwqrB7Vi+DyXQNtj/Jy7tjeFowZ
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10430"; a="273404064"
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="273404064"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2022 03:00:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="746113166"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 06 Aug 2022 03:00:52 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oKGc0-000KG7-0R;
        Sat, 06 Aug 2022 10:00:52 +0000
Date:   Sat, 6 Aug 2022 18:00:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ben Dooks <ben.dooks@sifive.com>, linux-pwm@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        u.kleine-koenig@pengutronix.de,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        jarkko.nikula@linux.intel.com,
        William Salmon <william.salmon@sifive.com>,
        Jude Onyenegecha --subject-prefix=PATCH v3 
        <jude.onyenegecha@sifive.com>, Ben Dooks <ben.dooks@sifive.com>
Subject: Re: [PATCH 4/8] pwm: dwc: add of/platform support
Message-ID: <202208061741.ALGAZYcD-lkp@intel.com>
References: <20220805165033.140958-5-ben.dooks@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220805165033.140958-5-ben.dooks@sifive.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ben,

I love your patch! Yet something to improve:

[auto build test ERROR on thierry-reding-pwm/for-next]
[also build test ERROR on linus/master v5.19 next-20220805]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ben-Dooks/dt-bindings-pwm-Document-Synopsys-DesignWare-snps-pwm-dw-apb-timers-pwm2/20220806-015142
base:   https://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git for-next
config: hexagon-allyesconfig (https://download.01.org/0day-ci/archive/20220806/202208061741.ALGAZYcD-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 26dd42705c2af0b8f6e5d6cdb32c9bd5ed9524eb)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/3bd100d711908b7d16a2c4793b4f5b597acb8d7f
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Ben-Dooks/dt-bindings-pwm-Document-Synopsys-DesignWare-snps-pwm-dw-apb-timers-pwm2/20220806-015142
        git checkout 3bd100d711908b7d16a2c4793b4f5b597acb8d7f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/pwm/pwm-dwc.c:321:1: error: type specifier missing, defaults to 'int'; ISO C99 and later do not support implicit int [-Wimplicit-int]
   module_pci_driver(dwc_pwm_driver);
   ^
   int
>> drivers/pwm/pwm-dwc.c:321:19: error: a parameter list without types is only allowed in a function definition
   module_pci_driver(dwc_pwm_driver);
                     ^
   2 errors generated.


vim +/int +321 drivers/pwm/pwm-dwc.c

1ed2b3fca64516 Jarkko Nikula 2020-10-02  320  
1ed2b3fca64516 Jarkko Nikula 2020-10-02 @321  module_pci_driver(dwc_pwm_driver);
1ed2b3fca64516 Jarkko Nikula 2020-10-02  322  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
