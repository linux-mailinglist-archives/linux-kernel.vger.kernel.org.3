Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E90314FCC24
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 04:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241070AbiDLCGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 22:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiDLCGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 22:06:11 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4062431509;
        Mon, 11 Apr 2022 19:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649729035; x=1681265035;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=r4GRUR6zF+v37vBUgf/DDdpurM7HAtY37B8rErw3mbA=;
  b=JEe38TGTC2X7hqpCztRf3L6Y+bRFMM4jyuOFdAHvlpCs1HbAHpHgxkHu
   PruMz6yRsqL8YE1Q4DuhtMfm5dOr79i7v5NSqGHWxaHqMWefH6PKP+YHs
   hdPXeZZJYfSKFqeisSzWpygvaS1Be2YYkwiG4guongAkYqdvxyKp2yFIq
   Tudpz0Xcu6gOOfeg77U65KCWyBbkqXtsjW+FTf8UPx6Ns7eyLeDv0H91F
   I8mQ2dHYRiVprLBuIHHlcA5yMHM4niHcJy0yiUe0QvqS4ySFK9/Uu9YJN
   wc+3uFIdhtIOgRsFV58hgtySd25ceNvjfQk3hqJFdkHvoKF4OH5pub9OG
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="244140624"
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="244140624"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 19:03:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="854158711"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 11 Apr 2022 19:03:51 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ne5sk-0002QX-Cy;
        Tue, 12 Apr 2022 02:03:50 +0000
Date:   Tue, 12 Apr 2022 10:03:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        paul@crapouillou.net, robh+dt@kernel.org, krzk+dt@kernel.org,
        tsbogend@alpha.franken.de, mturquette@baylibre.com,
        sboyd@kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v4 2/2] clk: ingenic-tcu: Fix missing TCU clock for X1000
 SoCs
Message-ID: <202204120958.uBiGandq-lkp@intel.com>
References: <20220411154241.50834-3-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220411154241.50834-3-aidanmacdonald.0x0@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aidan,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on robh/for-next]
[also build test WARNING on clk/clk-next linus/master linux/master v5.18-rc2 next-20220411]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Aidan-MacDonald/Fix-missing-TCU-clock-for-X1000-X1830-SoCs/20220411-234531
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: mips-randconfig-c004-20220411 (https://download.01.org/0day-ci/archive/20220412/202204120958.uBiGandq-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c6e83f560f06cdfe8aa47b248d8bdc58f947274b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/8c04eee82a9d67a768bb6c787d66724782fce89b
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Aidan-MacDonald/Fix-missing-TCU-clock-for-X1000-X1830-SoCs/20220411-234531
        git checkout 8c04eee82a9d67a768bb6c787d66724782fce89b
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/clk/ingenic/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/clk/ingenic/tcu.c:366:8: warning: variable 'ret' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
                           if (tcu->soc_info->allow_missing_tcu_clk &&
                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/clk/ingenic/tcu.c:456:9: note: uninitialized use occurs here
           return ret;
                  ^~~
   drivers/clk/ingenic/tcu.c:366:4: note: remove the 'if' if its condition is always true
                           if (tcu->soc_info->allow_missing_tcu_clk &&
                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/clk/ingenic/tcu.c:366:8: warning: variable 'ret' is used uninitialized whenever '&&' condition is false [-Wsometimes-uninitialized]
                           if (tcu->soc_info->allow_missing_tcu_clk &&
                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/clk/ingenic/tcu.c:456:9: note: uninitialized use occurs here
           return ret;
                  ^~~
   drivers/clk/ingenic/tcu.c:366:8: note: remove the '&&' if its condition is always true
                           if (tcu->soc_info->allow_missing_tcu_clk &&
                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/clk/ingenic/tcu.c:343:9: note: initialize the variable 'ret' to silence this warning
           int ret;
                  ^
                   = 0
   2 warnings generated.


vim +366 drivers/clk/ingenic/tcu.c

   336	
   337	static int __init ingenic_tcu_probe(struct device_node *np)
   338	{
   339		const struct of_device_id *id = of_match_node(ingenic_tcu_of_match, np);
   340		struct ingenic_tcu *tcu;
   341		struct regmap *map;
   342		unsigned int i;
   343		int ret;
   344	
   345		map = device_node_to_regmap(np);
   346		if (IS_ERR(map))
   347			return PTR_ERR(map);
   348	
   349		tcu = kzalloc(sizeof(*tcu), GFP_KERNEL);
   350		if (!tcu)
   351			return -ENOMEM;
   352	
   353		tcu->map = map;
   354		tcu->soc_info = id->data;
   355	
   356		if (tcu->soc_info->has_tcu_clk) {
   357			tcu->clk = of_clk_get_by_name(np, "tcu");
   358			if (IS_ERR(tcu->clk)) {
   359				/*
   360				 * Old device trees for some SoCs did not include the
   361				 * TCU clock because this driver (incorrectly) didn't
   362				 * use it. In this case we complain loudly and attempt
   363				 * to continue without the clock, which might work if
   364				 * booting with workarounds like "clk_ignore_unused".
   365				 */
 > 366				if (tcu->soc_info->allow_missing_tcu_clk &&
   367				    PTR_ERR(tcu->clk) == -EINVAL) {
   368					pr_warn("TCU clock missing from device tree, please update your device tree\n");
   369					tcu->clk = NULL;
   370				} else {
   371					pr_crit("Cannot get TCU clock from device tree\n");
   372					goto err_free_tcu;
   373				}
   374			} else {
   375				ret = clk_prepare_enable(tcu->clk);
   376				if (ret) {
   377					pr_crit("Unable to enable TCU clock\n");
   378					goto err_put_clk;
   379				}
   380			}
   381		}
   382	
   383		tcu->clocks = kzalloc(struct_size(tcu->clocks, hws, TCU_CLK_COUNT),
   384				      GFP_KERNEL);
   385		if (!tcu->clocks) {
   386			ret = -ENOMEM;
   387			goto err_clk_disable;
   388		}
   389	
   390		tcu->clocks->num = TCU_CLK_COUNT;
   391	
   392		for (i = 0; i < tcu->soc_info->num_channels; i++) {
   393			ret = ingenic_tcu_register_clock(tcu, i, TCU_PARENT_EXT,
   394							 &ingenic_tcu_clk_info[i],
   395							 tcu->clocks);
   396			if (ret) {
   397				pr_crit("cannot register clock %d\n", i);
   398				goto err_unregister_timer_clocks;
   399			}
   400		}
   401	
   402		/*
   403		 * We set EXT as the default parent clock for all the TCU clocks
   404		 * except for the watchdog one, where we set the RTC clock as the
   405		 * parent. Since the EXT and PCLK are much faster than the RTC clock,
   406		 * the watchdog would kick after a maximum time of 5s, and we might
   407		 * want a slower kicking time.
   408		 */
   409		ret = ingenic_tcu_register_clock(tcu, TCU_CLK_WDT, TCU_PARENT_RTC,
   410						 &ingenic_tcu_watchdog_clk_info,
   411						 tcu->clocks);
   412		if (ret) {
   413			pr_crit("cannot register watchdog clock\n");
   414			goto err_unregister_timer_clocks;
   415		}
   416	
   417		if (tcu->soc_info->has_ost) {
   418			ret = ingenic_tcu_register_clock(tcu, TCU_CLK_OST,
   419							 TCU_PARENT_EXT,
   420							 &ingenic_tcu_ost_clk_info,
   421							 tcu->clocks);
   422			if (ret) {
   423				pr_crit("cannot register ost clock\n");
   424				goto err_unregister_watchdog_clock;
   425			}
   426		}
   427	
   428		ret = of_clk_add_hw_provider(np, of_clk_hw_onecell_get, tcu->clocks);
   429		if (ret) {
   430			pr_crit("cannot add OF clock provider\n");
   431			goto err_unregister_ost_clock;
   432		}
   433	
   434		ingenic_tcu = tcu;
   435	
   436		return 0;
   437	
   438	err_unregister_ost_clock:
   439		if (tcu->soc_info->has_ost)
   440			clk_hw_unregister(tcu->clocks->hws[i + 1]);
   441	err_unregister_watchdog_clock:
   442		clk_hw_unregister(tcu->clocks->hws[i]);
   443	err_unregister_timer_clocks:
   444		for (i = 0; i < tcu->clocks->num; i++)
   445			if (tcu->clocks->hws[i])
   446				clk_hw_unregister(tcu->clocks->hws[i]);
   447		kfree(tcu->clocks);
   448	err_clk_disable:
   449		if (tcu->clk)
   450			clk_disable_unprepare(tcu->clk);
   451	err_put_clk:
   452		if (tcu->clk)
   453			clk_put(tcu->clk);
   454	err_free_tcu:
   455		kfree(tcu);
   456		return ret;
   457	}
   458	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
