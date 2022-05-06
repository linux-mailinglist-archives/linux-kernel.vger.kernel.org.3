Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01D9251D6A1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 13:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391333AbiEFL3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 07:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391324AbiEFL3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 07:29:48 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9815C326E9;
        Fri,  6 May 2022 04:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651836357; x=1683372357;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kyfzg+1FMV7p3SGw9zcFubkJsd+r/h4xK7eZfqId260=;
  b=E722gsuaVpr0914oJJy+Q24LS2+YK9Atw9YMGkBoI2w7UKmaCbPO09gq
   rTkp7VJcN5ZZpSDozAjLrd5LgiML00ivUEx+KeBAZu5RyD9jqgW2YxLBq
   w16/XqfpJXe09IAL6VKcG08fYMcph7gFJQ4swsmyjcnhisZLUz70NimeB
   prutlEAtzikdiOjpt1zagZC11CRxRBgWFStPAbztp7sVi2yRmJ+JivNZ5
   hTcTpi6fvPv5suyTbYd2HiaEkoU5K7ZjAYTvBxI13+I5snAN+Z4HAGMDF
   oL/Yn5sERSfyr0nnmG+bNCIJ6ZPRGsrkyHTJklBbOKS13DJWKfdGMh86w
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="331431175"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="331431175"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 04:25:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="709423885"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 06 May 2022 04:25:53 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nmw5o-000DPn-M6;
        Fri, 06 May 2022 11:25:52 +0000
Date:   Fri, 6 May 2022 19:25:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Qin Jian <qinjian@cqplus1.com>, krzysztof.kozlowski@linaro.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org, robh+dt@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, tglx@linutronix.de,
        maz@kernel.org, p.zabel@pengutronix.de, linux@armlinux.org.uk,
        arnd@arndb.de, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, Qin Jian <qinjian@cqplus1.com>
Subject: Re: [PATCH v14 8/9] ARM: sunplus: Add initial support for Sunplus
 SP7021 SoC
Message-ID: <202205061902.b3IMQRUc-lkp@intel.com>
References: <e15ca64a9c62fe8cae970d6fe2b73f8a73966dd3.1651805790.git.qinjian@cqplus1.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e15ca64a9c62fe8cae970d6fe2b73f8a73966dd3.1651805790.git.qinjian@cqplus1.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qin,

I love your patch! Perhaps something to improve:

[auto build test WARNING on pza/reset/next]
[also build test WARNING on clk/clk-next tip/irq/core linus/master v5.18-rc5 next-20220506]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Qin-Jian/Add-Sunplus-SP7021-SoC-Support/20220506-113239
base:   https://git.pengutronix.de/git/pza/linux reset/next
config: arm-defconfig (https://download.01.org/0day-ci/archive/20220506/202205061902.b3IMQRUc-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 5e004fb787698440a387750db7f8028e7cb14cfc)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/intel-lab-lkp/linux/commit/5e6762b3fc12b5c86bf345c0c3bbfa788ed1bda7
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Qin-Jian/Add-Sunplus-SP7021-SoC-Support/20220506-113239
        git checkout 5e6762b3fc12b5c86bf345c0c3bbfa788ed1bda7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/clk/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/clk/clk-sp7021.c:325:9: warning: result of comparison of constant 18446744073709551615 with expression of type 'typeof (_Generic((m), char: (unsigned char)0, unsigned char: (unsigned char)0, signed char: (unsigned char)0, unsigned short: (unsigned short)0, short: (unsigned short)0, unsigned int: (unsigned int)0, int: (unsigned int)0, unsigned long: (unsigned long)0, long: (unsigned long)0, unsigned long long: (unsigned long long)0, long long: (unsigned long long)0, default: (m)))' (aka 'unsigned int') is always false [-Wtautological-constant-out-of-range-compare]
           reg  = HWM_FIELD_PREP(MASK_SEL_FRA, clk->p[SEL_FRA]);
                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/clk/clk-sp7021.c:53:14: note: expanded from macro 'HWM_FIELD_PREP'
           (m << 16) | FIELD_PREP(m, value);       \
                       ^~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:114:3: note: expanded from macro 'FIELD_PREP'
                   __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:71:53: note: expanded from macro '__BF_FIELD_CHECK'
                   BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >     \
                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:352:22: note: expanded from macro 'compiletime_assert'
           _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
           ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:340:23: note: expanded from macro '_compiletime_assert'
           __compiletime_assert(condition, msg, prefix, suffix)
           ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:332:9: note: expanded from macro '__compiletime_assert'
                   if (!(condition))                                       \
                         ^~~~~~~~~
   drivers/clk/clk-sp7021.c:326:9: warning: result of comparison of constant 18446744073709551615 with expression of type 'typeof (_Generic((m), char: (unsigned char)0, unsigned char: (unsigned char)0, signed char: (unsigned char)0, unsigned short: (unsigned short)0, short: (unsigned short)0, unsigned int: (unsigned int)0, int: (unsigned int)0, unsigned long: (unsigned long)0, long: (unsigned long)0, unsigned long long: (unsigned long long)0, long long: (unsigned long long)0, default: (m)))' (aka 'unsigned int') is always false [-Wtautological-constant-out-of-range-compare]
           reg |= HWM_FIELD_PREP(MASK_SDM_MOD, clk->p[SDM_MOD]);
                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/clk/clk-sp7021.c:53:14: note: expanded from macro 'HWM_FIELD_PREP'
           (m << 16) | FIELD_PREP(m, value);       \
                       ^~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:114:3: note: expanded from macro 'FIELD_PREP'
                   __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:71:53: note: expanded from macro '__BF_FIELD_CHECK'
                   BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >     \
                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:352:22: note: expanded from macro 'compiletime_assert'
           _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
           ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:340:23: note: expanded from macro '_compiletime_assert'
           __compiletime_assert(condition, msg, prefix, suffix)
           ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:332:9: note: expanded from macro '__compiletime_assert'
                   if (!(condition))                                       \
                         ^~~~~~~~~
   drivers/clk/clk-sp7021.c:327:9: warning: result of comparison of constant 18446744073709551615 with expression of type 'typeof (_Generic((m), char: (unsigned char)0, unsigned char: (unsigned char)0, signed char: (unsigned char)0, unsigned short: (unsigned short)0, short: (unsigned short)0, unsigned int: (unsigned int)0, int: (unsigned int)0, unsigned long: (unsigned long)0, long: (unsigned long)0, unsigned long long: (unsigned long long)0, long long: (unsigned long long)0, default: (m)))' (aka 'unsigned int') is always false [-Wtautological-constant-out-of-range-compare]
           reg |= HWM_FIELD_PREP(MASK_PH_SEL, clk->p[PH_SEL]);
                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/clk/clk-sp7021.c:53:14: note: expanded from macro 'HWM_FIELD_PREP'
           (m << 16) | FIELD_PREP(m, value);       \
                       ^~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:114:3: note: expanded from macro 'FIELD_PREP'
                   __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:71:53: note: expanded from macro '__BF_FIELD_CHECK'
                   BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >     \
                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:352:22: note: expanded from macro 'compiletime_assert'
           _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
           ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:340:23: note: expanded from macro '_compiletime_assert'
           __compiletime_assert(condition, msg, prefix, suffix)
           ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:332:9: note: expanded from macro '__compiletime_assert'
                   if (!(condition))                                       \
                         ^~~~~~~~~
   drivers/clk/clk-sp7021.c:328:9: warning: result of comparison of constant 18446744073709551615 with expression of type 'typeof (_Generic((m), char: (unsigned char)0, unsigned char: (unsigned char)0, signed char: (unsigned char)0, unsigned short: (unsigned short)0, short: (unsigned short)0, unsigned int: (unsigned int)0, int: (unsigned int)0, unsigned long: (unsigned long)0, long: (unsigned long)0, unsigned long long: (unsigned long long)0, long long: (unsigned long long)0, default: (m)))' (aka 'unsigned int') is always false [-Wtautological-constant-out-of-range-compare]
           reg |= HWM_FIELD_PREP(MASK_NFRA, clk->p[NFRA]);
                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/clk/clk-sp7021.c:53:14: note: expanded from macro 'HWM_FIELD_PREP'
           (m << 16) | FIELD_PREP(m, value);       \
                       ^~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:114:3: note: expanded from macro 'FIELD_PREP'
                   __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:71:53: note: expanded from macro '__BF_FIELD_CHECK'
                   BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >     \
                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:352:22: note: expanded from macro 'compiletime_assert'
           _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
           ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:340:23: note: expanded from macro '_compiletime_assert'
           __compiletime_assert(condition, msg, prefix, suffix)
           ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:332:9: note: expanded from macro '__compiletime_assert'
                   if (!(condition))                                       \
                         ^~~~~~~~~
   drivers/clk/clk-sp7021.c:331:9: warning: result of comparison of constant 18446744073709551615 with expression of type 'typeof (_Generic((m), char: (unsigned char)0, unsigned char: (unsigned char)0, signed char: (unsigned char)0, unsigned short: (unsigned short)0, short: (unsigned short)0, unsigned int: (unsigned int)0, int: (unsigned int)0, unsigned long: (unsigned long)0, long: (unsigned long)0, unsigned long long: (unsigned long long)0, long long: (unsigned long long)0, default: (m)))' (aka 'unsigned int') is always false [-Wtautological-constant-out-of-range-compare]
           reg  = HWM_FIELD_PREP(MASK_DIVR, clk->p[DIVR]);
                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/clk/clk-sp7021.c:53:14: note: expanded from macro 'HWM_FIELD_PREP'
           (m << 16) | FIELD_PREP(m, value);       \
                       ^~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:114:3: note: expanded from macro 'FIELD_PREP'
                   __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:71:53: note: expanded from macro '__BF_FIELD_CHECK'
                   BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >     \
                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)


vim +325 drivers/clk/clk-sp7021.c

835254e31aec3c Qin Jian 2022-05-06  320  
835254e31aec3c Qin Jian 2022-05-06  321  static void plltv_set_rate(struct sp_pll *clk)
835254e31aec3c Qin Jian 2022-05-06  322  {
835254e31aec3c Qin Jian 2022-05-06  323  	u32 reg;
835254e31aec3c Qin Jian 2022-05-06  324  
835254e31aec3c Qin Jian 2022-05-06 @325  	reg  = HWM_FIELD_PREP(MASK_SEL_FRA, clk->p[SEL_FRA]);
835254e31aec3c Qin Jian 2022-05-06  326  	reg |= HWM_FIELD_PREP(MASK_SDM_MOD, clk->p[SDM_MOD]);
835254e31aec3c Qin Jian 2022-05-06  327  	reg |= HWM_FIELD_PREP(MASK_PH_SEL, clk->p[PH_SEL]);
835254e31aec3c Qin Jian 2022-05-06  328  	reg |= HWM_FIELD_PREP(MASK_NFRA, clk->p[NFRA]);
835254e31aec3c Qin Jian 2022-05-06  329  	writel(reg, clk->reg);
835254e31aec3c Qin Jian 2022-05-06  330  
835254e31aec3c Qin Jian 2022-05-06  331  	reg  = HWM_FIELD_PREP(MASK_DIVR, clk->p[DIVR]);
835254e31aec3c Qin Jian 2022-05-06  332  	writel(reg, clk->reg + 4);
835254e31aec3c Qin Jian 2022-05-06  333  
835254e31aec3c Qin Jian 2022-05-06  334  	reg  = HWM_FIELD_PREP(MASK_DIVN, clk->p[DIVN] - 1);
835254e31aec3c Qin Jian 2022-05-06  335  	reg |= HWM_FIELD_PREP(MASK_DIVM, clk->p[DIVM] - 1);
835254e31aec3c Qin Jian 2022-05-06  336  	writel(reg, clk->reg + 8);
835254e31aec3c Qin Jian 2022-05-06  337  }
835254e31aec3c Qin Jian 2022-05-06  338  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
