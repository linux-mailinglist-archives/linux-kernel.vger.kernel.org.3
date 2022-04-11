Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD004FC7ED
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 00:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235862AbiDKXAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 19:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232006AbiDKXAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 19:00:39 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D2A1A39E;
        Mon, 11 Apr 2022 15:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649717903; x=1681253903;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=u42J75qB4lknUofiHM409aSW/A8cShqmdeuKFIraw5A=;
  b=dkL5SIuTjOxi1Z3pxf0+T/suDibtw6hyjXB+KCqD2MyWS3I4blowvwym
   bZmWKnwjF3hQ4ZY+ziQy6trXa8y/feiTzbFiMrv1PBEEhXADp2GbEUTgp
   1Bx3BUUpJOG4sJuDEnjWhT8ejl3nxnB28nvQr3xfEvMUjM8lOEukGt5Tl
   It+gEaP5Vwbr5PAQOtSPJlP/H255Nx18ypciq2Ona21dX74mw5OQLqyj2
   3fotgbrVog5efi1DC8v5nJyjqC61o2GrkMDBwjItLjk2X8zhU52xWAbLW
   4CcqG0O6F2aGC9Jl4VTybfu9GsNbi6tfQoLxdoh73sLaJ+fQsfs+TFy0+
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="322677613"
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="322677613"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 15:58:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="611186540"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 11 Apr 2022 15:58:19 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ne2zC-0002I7-B7;
        Mon, 11 Apr 2022 22:58:18 +0000
Date:   Tue, 12 Apr 2022 06:57:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Qin Jian <qinjian@cqplus1.com>, krzysztof.kozlowski@linaro.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org, robh+dt@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, tglx@linutronix.de,
        maz@kernel.org, p.zabel@pengutronix.de, linux@armlinux.org.uk,
        arnd@arndb.de, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, Qin Jian <qinjian@cqplus1.com>
Subject: Re: [PATCH v13 5/9] clk: Add Sunplus SP7021 clock driver
Message-ID: <202204120632.PVpfb7QH-lkp@intel.com>
References: <c66c84f1c834a16ca0cba6272b73644946a4d09b.1649659095.git.qinjian@cqplus1.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c66c84f1c834a16ca0cba6272b73644946a4d09b.1649659095.git.qinjian@cqplus1.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
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
[also build test WARNING on clk/clk-next tip/irq/core linus/master v5.18-rc2 next-20220411]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Qin-Jian/Add-Sunplus-SP7021-SoC-Support/20220411-145949
base:   https://git.pengutronix.de/git/pza/linux reset/next
config: hexagon-allyesconfig (https://download.01.org/0day-ci/archive/20220412/202204120632.PVpfb7QH-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c6e83f560f06cdfe8aa47b248d8bdc58f947274b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/813495df844458a19418ac2d6ac45894c68dcb39
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Qin-Jian/Add-Sunplus-SP7021-SoC-Support/20220411-145949
        git checkout 813495df844458a19418ac2d6ac45894c68dcb39
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/clk/ drivers/gpu/drm/sun4i/

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
   include/linux/compiler_types.h:352:22: note: expanded from macro 'compiletime_assert'
           _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
           ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:340:23: note: expanded from macro '_compiletime_assert'
           __compiletime_assert(condition, msg, prefix, suffix)
           ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:332:9: note: expanded from macro '__compiletime_assert'
                   if (!(condition))                                       \
                         ^~~~~~~~~
   drivers/clk/clk-sp7021.c:334:9: warning: result of comparison of constant 18446744073709551615 with expression of type 'typeof (_Generic((m), char: (unsigned char)0, unsigned char: (unsigned char)0, signed char: (unsigned char)0, unsigned short: (unsigned short)0, short: (unsigned short)0, unsigned int: (unsigned int)0, int: (unsigned int)0, unsigned long: (unsigned long)0, long: (unsigned long)0, unsigned long long: (unsigned long long)0, long long: (unsigned long long)0, default: (m)))' (aka 'unsigned int') is always false [-Wtautological-constant-out-of-range-compare]
           reg  = HWM_FIELD_PREP(MASK_DIVN, clk->p[DIVN] - 1);
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
   drivers/clk/clk-sp7021.c:335:9: warning: result of comparison of constant 18446744073709551615 with expression of type 'typeof (_Generic((m), char: (unsigned char)0, unsigned char: (unsigned char)0, signed char: (unsigned char)0, unsigned short: (unsigned short)0, short: (unsigned short)0, unsigned int: (unsigned int)0, int: (unsigned int)0, unsigned long: (unsigned long)0, long: (unsigned long)0, unsigned long long: (unsigned long long)0, long long: (unsigned long long)0, default: (m)))' (aka 'unsigned int') is always false [-Wtautological-constant-out-of-range-compare]
           reg |= HWM_FIELD_PREP(MASK_DIVM, clk->p[DIVM] - 1);
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
>> drivers/clk/clk-sp7021.c:557:16: warning: no previous prototype for function 'sp_pll_register' [-Wmissing-prototypes]
   struct clk_hw *sp_pll_register(struct device *dev, const char *name,
                  ^
   drivers/clk/clk-sp7021.c:557:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   struct clk_hw *sp_pll_register(struct device *dev, const char *name,
   ^
   static 
   8 warnings generated.


vim +325 drivers/clk/clk-sp7021.c

   320	
   321	static void plltv_set_rate(struct sp_pll *clk)
   322	{
   323		u32 reg;
   324	
 > 325		reg  = HWM_FIELD_PREP(MASK_SEL_FRA, clk->p[SEL_FRA]);
   326		reg |= HWM_FIELD_PREP(MASK_SDM_MOD, clk->p[SDM_MOD]);
   327		reg |= HWM_FIELD_PREP(MASK_PH_SEL, clk->p[PH_SEL]);
   328		reg |= HWM_FIELD_PREP(MASK_NFRA, clk->p[NFRA]);
   329		writel(reg, clk->reg);
   330	
   331		reg  = HWM_FIELD_PREP(MASK_DIVR, clk->p[DIVR]);
   332		writel(reg, clk->reg + 4);
   333	
   334		reg  = HWM_FIELD_PREP(MASK_DIVN, clk->p[DIVN] - 1);
   335		reg |= HWM_FIELD_PREP(MASK_DIVM, clk->p[DIVM] - 1);
   336		writel(reg, clk->reg + 8);
   337	}
   338	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
