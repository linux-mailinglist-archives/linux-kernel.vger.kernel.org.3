Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAE674C752B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 18:51:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237002AbiB1RwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 12:52:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238499AbiB1Rpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 12:45:33 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E1B47562
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 09:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646069871; x=1677605871;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SiZFexYAsMbDBWKC0i6qZTmB2eWvi9q/m/x6dShxuvo=;
  b=fESeRcfcMwrXEM/KjvrVzOqaK3YSizDHdHMMy0j0sx9od3BOfEblDqeF
   yWe8IbqmE2dcy244sLFHIx8JnN83i0qaMpEUHHv+a9i5ptCKN3+MRDLS0
   1rCnX4fnKOuShVefJ9sUNH7XfNMcjIKd+HifjEg1MF5vj4XK7GdRiKo25
   2Rx/fPUSsHksg/14eoj/BgJBZAV27QhwVCGd6mCGsazhv72qzUUoWGQZ4
   tdaQ/DvmvCt8CLCVeZo8si7DNdALbsFZqsETAicUjCAfDehoZQLoIIryW
   bhDHA0l3++Fvg8IZNQEHeWGi5jFp8vAPav1n9XZLfwObesF+GYBhA+Ro9
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="316154520"
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="316154520"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 09:37:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="544807684"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 28 Feb 2022 09:37:20 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nOjxS-0007cW-MA; Mon, 28 Feb 2022 17:37:14 +0000
Date:   Tue, 1 Mar 2022 01:37:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        daniel.lezcano@linaro.org, tglx@linutronix.de
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: Re: [PATCH 7/7] clocksource/drivers/timer-microchip-pit64b: use
 mchp_pit64b_{suspend, resume}
Message-ID: <202203010158.D812WMzG-lkp@intel.com>
References: <20220228111923.1400049-8-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228111923.1400049-8-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Claudiu,

I love your patch! Perhaps something to improve:

[auto build test WARNING on tip/timers/core]
[also build test WARNING on soc/for-next linus/master v5.17-rc6 next-20220225]
[cannot apply to daniel-lezcano/clockevents/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Claudiu-Beznea/clocksource-drivers-timer-microchip-pit64b-fixes-and-improvements/20220228-191933
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git 35e13e9da9afbce13c1d36465504ece4e65f24fe
config: i386-randconfig-a002-20220228 (https://download.01.org/0day-ci/archive/20220301/202203010158.D812WMzG-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/a354e98d1b37361a46d6272ffccc149e3b8bbbca
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Claudiu-Beznea/clocksource-drivers-timer-microchip-pit64b-fixes-and-improvements/20220228-191933
        git checkout a354e98d1b37361a46d6272ffccc149e3b8bbbca
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/clocksource/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/clocksource/timer-microchip-pit64b.c:97:27: warning: tentative definition of variable with internal linkage has incomplete non-array type 'struct delay_timer' [-Wtentative-definition-incomplete-type]
   static struct delay_timer mchp_pit64b_dt;
                             ^
   drivers/clocksource/timer-microchip-pit64b.c:97:15: note: forward declaration of 'struct delay_timer'
   static struct delay_timer mchp_pit64b_dt;
                 ^
   drivers/clocksource/timer-microchip-pit64b.c:385:16: error: incomplete definition of type 'struct delay_timer'
           mchp_pit64b_dt.read_current_timer = mchp_pit64b_dt_read;
           ~~~~~~~~~~~~~~^
   drivers/clocksource/timer-microchip-pit64b.c:97:15: note: forward declaration of 'struct delay_timer'
   static struct delay_timer mchp_pit64b_dt;
                 ^
   drivers/clocksource/timer-microchip-pit64b.c:386:16: error: incomplete definition of type 'struct delay_timer'
           mchp_pit64b_dt.freq = clk_rate;
           ~~~~~~~~~~~~~~^
   drivers/clocksource/timer-microchip-pit64b.c:97:15: note: forward declaration of 'struct delay_timer'
   static struct delay_timer mchp_pit64b_dt;
                 ^
   drivers/clocksource/timer-microchip-pit64b.c:387:2: error: implicit declaration of function 'register_current_timer_delay' [-Werror,-Wimplicit-function-declaration]
           register_current_timer_delay(&mchp_pit64b_dt);
           ^
>> drivers/clocksource/timer-microchip-pit64b.c:484:1: warning: unused label 'pclk_unprepare' [-Wunused-label]
   pclk_unprepare:
   ^~~~~~~~~~~~~~~
   drivers/clocksource/timer-microchip-pit64b.c:97:27: error: tentative definition has type 'struct delay_timer' that is never completed
   static struct delay_timer mchp_pit64b_dt;
                             ^
   drivers/clocksource/timer-microchip-pit64b.c:97:15: note: forward declaration of 'struct delay_timer'
   static struct delay_timer mchp_pit64b_dt;
                 ^
   2 warnings and 4 errors generated.


vim +/pclk_unprepare +484 drivers/clocksource/timer-microchip-pit64b.c

625022a5f16061 Claudiu Beznea 2019-12-13  430  
625022a5f16061 Claudiu Beznea 2019-12-13  431  static int __init mchp_pit64b_dt_init_timer(struct device_node *node,
625022a5f16061 Claudiu Beznea 2019-12-13  432  					    bool clkevt)
625022a5f16061 Claudiu Beznea 2019-12-13  433  {
b9c60a741f06ed Claudiu Beznea 2020-01-06  434  	struct mchp_pit64b_timer timer;
625022a5f16061 Claudiu Beznea 2019-12-13  435  	unsigned long clk_rate;
625022a5f16061 Claudiu Beznea 2019-12-13  436  	u32 irq = 0;
625022a5f16061 Claudiu Beznea 2019-12-13  437  	int ret;
625022a5f16061 Claudiu Beznea 2019-12-13  438  
625022a5f16061 Claudiu Beznea 2019-12-13  439  	/* Parse DT node. */
625022a5f16061 Claudiu Beznea 2019-12-13  440  	timer.pclk = of_clk_get_by_name(node, "pclk");
625022a5f16061 Claudiu Beznea 2019-12-13  441  	if (IS_ERR(timer.pclk))
625022a5f16061 Claudiu Beznea 2019-12-13  442  		return PTR_ERR(timer.pclk);
625022a5f16061 Claudiu Beznea 2019-12-13  443  
625022a5f16061 Claudiu Beznea 2019-12-13  444  	timer.gclk = of_clk_get_by_name(node, "gclk");
625022a5f16061 Claudiu Beznea 2019-12-13  445  	if (IS_ERR(timer.gclk))
625022a5f16061 Claudiu Beznea 2019-12-13  446  		return PTR_ERR(timer.gclk);
625022a5f16061 Claudiu Beznea 2019-12-13  447  
625022a5f16061 Claudiu Beznea 2019-12-13  448  	timer.base = of_iomap(node, 0);
625022a5f16061 Claudiu Beznea 2019-12-13  449  	if (!timer.base)
625022a5f16061 Claudiu Beznea 2019-12-13  450  		return -ENXIO;
625022a5f16061 Claudiu Beznea 2019-12-13  451  
625022a5f16061 Claudiu Beznea 2019-12-13  452  	if (clkevt) {
625022a5f16061 Claudiu Beznea 2019-12-13  453  		irq = irq_of_parse_and_map(node, 0);
625022a5f16061 Claudiu Beznea 2019-12-13  454  		if (!irq) {
625022a5f16061 Claudiu Beznea 2019-12-13  455  			ret = -ENODEV;
625022a5f16061 Claudiu Beznea 2019-12-13  456  			goto io_unmap;
625022a5f16061 Claudiu Beznea 2019-12-13  457  		}
625022a5f16061 Claudiu Beznea 2019-12-13  458  	}
625022a5f16061 Claudiu Beznea 2019-12-13  459  
625022a5f16061 Claudiu Beznea 2019-12-13  460  	/* Initialize mode (prescaler + SGCK bit). To be used at runtime. */
0faff1ca60d69f Claudiu Beznea 2022-02-28  461  	ret = mchp_pit64b_init_mode(&timer, MCHP_PIT64B_DEF_FREQ);
625022a5f16061 Claudiu Beznea 2019-12-13  462  	if (ret)
625022a5f16061 Claudiu Beznea 2019-12-13  463  		goto irq_unmap;
625022a5f16061 Claudiu Beznea 2019-12-13  464  
a354e98d1b3736 Claudiu Beznea 2022-02-28  465  	if (timer.mode & MCHP_PIT64B_MR_SGCLK)
625022a5f16061 Claudiu Beznea 2019-12-13  466  		clk_rate = clk_get_rate(timer.gclk);
a354e98d1b3736 Claudiu Beznea 2022-02-28  467  	else
625022a5f16061 Claudiu Beznea 2019-12-13  468  		clk_rate = clk_get_rate(timer.pclk);
625022a5f16061 Claudiu Beznea 2019-12-13  469  	clk_rate = clk_rate / (MCHP_PIT64B_MODE_TO_PRES(timer.mode) + 1);
625022a5f16061 Claudiu Beznea 2019-12-13  470  
625022a5f16061 Claudiu Beznea 2019-12-13  471  	if (clkevt)
625022a5f16061 Claudiu Beznea 2019-12-13  472  		ret = mchp_pit64b_init_clkevt(&timer, clk_rate, irq);
625022a5f16061 Claudiu Beznea 2019-12-13  473  	else
625022a5f16061 Claudiu Beznea 2019-12-13  474  		ret = mchp_pit64b_init_clksrc(&timer, clk_rate);
625022a5f16061 Claudiu Beznea 2019-12-13  475  
625022a5f16061 Claudiu Beznea 2019-12-13  476  	if (ret)
625022a5f16061 Claudiu Beznea 2019-12-13  477  		goto gclk_unprepare;
625022a5f16061 Claudiu Beznea 2019-12-13  478  
625022a5f16061 Claudiu Beznea 2019-12-13  479  	return 0;
625022a5f16061 Claudiu Beznea 2019-12-13  480  
625022a5f16061 Claudiu Beznea 2019-12-13  481  gclk_unprepare:
625022a5f16061 Claudiu Beznea 2019-12-13  482  	if (timer.mode & MCHP_PIT64B_MR_SGCLK)
625022a5f16061 Claudiu Beznea 2019-12-13  483  		clk_disable_unprepare(timer.gclk);
625022a5f16061 Claudiu Beznea 2019-12-13 @484  pclk_unprepare:
625022a5f16061 Claudiu Beznea 2019-12-13  485  	clk_disable_unprepare(timer.pclk);
625022a5f16061 Claudiu Beznea 2019-12-13  486  irq_unmap:
625022a5f16061 Claudiu Beznea 2019-12-13  487  	irq_dispose_mapping(irq);
625022a5f16061 Claudiu Beznea 2019-12-13  488  io_unmap:
625022a5f16061 Claudiu Beznea 2019-12-13  489  	iounmap(timer.base);
625022a5f16061 Claudiu Beznea 2019-12-13  490  
625022a5f16061 Claudiu Beznea 2019-12-13  491  	return ret;
625022a5f16061 Claudiu Beznea 2019-12-13  492  }
625022a5f16061 Claudiu Beznea 2019-12-13  493  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
