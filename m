Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9D62506352
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 06:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348304AbiDSEgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 00:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348274AbiDSEgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 00:36:11 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC95122BE5;
        Mon, 18 Apr 2022 21:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650342809; x=1681878809;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OPOfSS2uDyN/dVKScHcoTabGQVho8Vlfn+KbkTmz7eY=;
  b=gtKb7TAXgqcVKeRTPBw369lk82iKf9bfi91hsmfEiLiScnllyBsTnYXC
   F80/McEcaQ8QQx8Gq6Lzt2AoQdvln9vdnVMkx03Bxqet4WaoOlnFX9Sla
   92E607CuEBMrd1/t2IUGNG5wvUH5+jS8HJTwQdTlpQAoiTHSVs1M5SiuK
   yGbXe3VCnqO1FTkGoLuyP4xbGCmco1WNRx+s/07QjNeEknWhe2Am3Dz0f
   o3WdlncHINpl9GhGktOIWLNlqudaZVJ+jY5M5OcGFkoOCNWV/JPtcs3/Q
   qjmIn23mfBpx3gYbhQBgkS3rigdK0WfhGDV5Urp3Wo+qwpHYCxV9tjmC8
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="244256897"
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="244256897"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 21:33:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="665771758"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 18 Apr 2022 21:33:24 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ngfYJ-0005Lb-UD;
        Tue, 19 Apr 2022 04:33:23 +0000
Date:   Tue, 19 Apr 2022 12:32:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Paul Cercueil <paul@crapouillou.net>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     kbuild-all@lists.01.org, list@opendingux.net,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 5/5] rtc: jz4740: Support for fine-tuning the RTC clock
Message-ID: <202204191251.t9r8gFyI-lkp@intel.com>
References: <20220418184933.13172-6-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220418184933.13172-6-paul@crapouillou.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
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

[auto build test ERROR on abelloni/rtc-next]
[also build test ERROR on v5.18-rc3 next-20220414]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Paul-Cercueil/rtc-ingenic-various-updates/20220419-025341
base:   https://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git rtc-next
config: sparc64-randconfig-r024-20220418 (https://download.01.org/0day-ci/archive/20220419/202204191251.t9r8gFyI-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/ba459adc8c83dbdc469d0c6b5d57fd95d834513a
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Paul-Cercueil/rtc-ingenic-various-updates/20220419-025341
        git checkout ba459adc8c83dbdc469d0c6b5d57fd95d834513a
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=sparc64 SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from <command-line>:
   drivers/rtc/rtc-jz4740.c: In function 'jz4740_rtc_set_offset':
>> include/linux/compiler_types.h:346:45: error: call to '__compiletime_assert_229' declared with attribute error: FIELD_PREP: value too large for the field
     346 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:327:25: note: in definition of macro '__compiletime_assert'
     327 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:346:9: note: in expansion of macro '_compiletime_assert'
     346 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:65:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      65 |                 BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?           \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:111:17: note: in expansion of macro '__BF_FIELD_CHECK'
     111 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
         |                 ^~~~~~~~~~~~~~~~
   drivers/rtc/rtc-jz4740.c:261:17: note: in expansion of macro 'FIELD_PREP'
     261 |         nc1hz = FIELD_PREP(JZ_RTC_REGULATOR_NC1HZ_MASK, nc1hz);
         |                 ^~~~~~~~~~


vim +/__compiletime_assert_229 +346 include/linux/compiler_types.h

eb5c2d4b45e3d2 Will Deacon 2020-07-21  332  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  333  #define _compiletime_assert(condition, msg, prefix, suffix) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21  334  	__compiletime_assert(condition, msg, prefix, suffix)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  335  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  336  /**
eb5c2d4b45e3d2 Will Deacon 2020-07-21  337   * compiletime_assert - break build and emit msg if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  338   * @condition: a compile-time constant condition to check
eb5c2d4b45e3d2 Will Deacon 2020-07-21  339   * @msg:       a message to emit if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  340   *
eb5c2d4b45e3d2 Will Deacon 2020-07-21  341   * In tradition of POSIX assert, this macro will break the build if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  342   * supplied condition is *false*, emitting the supplied error message if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  343   * compiler has support to do so.
eb5c2d4b45e3d2 Will Deacon 2020-07-21  344   */
eb5c2d4b45e3d2 Will Deacon 2020-07-21  345  #define compiletime_assert(condition, msg) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21 @346  	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  347  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
