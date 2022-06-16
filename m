Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F17854E30A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 16:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233077AbiFPOJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 10:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377101AbiFPOJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 10:09:06 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E39073BA66;
        Thu, 16 Jun 2022 07:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655388544; x=1686924544;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KbhRQpNJ/e3Byf+2uQ+3EqvHWdCIC7aeEObpWN1nN8g=;
  b=MX3hk770tNSyar9AnHYGE2wT6CRzsayEbTO3Hs1k8ViqeJYpjN/zjfce
   fZqY7xkW/hKayw+ff16goDiiHhI+fQDhq2i2TYLrBZ4IcUN/BlJVtWQ5Z
   e748fSVi6ze4nikCJm+kRSrnkZh35B6vlN8hUg1PWsHYGagLqnd4Y1xgP
   ctImGzkX3sh1MazwSu8y61PQFaIv3vNkaETxvfyGOi8pcTKTgbfZIf3AJ
   rQOpnU3uhNWQKOt/6CNju3pwUOO4rYV6qrRftsT+kSamL2JXswv4aazFs
   /9agZCdq9PWiR824B4ZAklHysB0oRHogwVENBo0/BqxjT19Dk2QS0sPIa
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10379"; a="278051784"
X-IronPort-AV: E=Sophos;i="5.92,305,1650956400"; 
   d="scan'208";a="278051784"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 07:09:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,305,1650956400"; 
   d="scan'208";a="613172888"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 16 Jun 2022 07:09:02 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o1qBB-000ORq-MZ;
        Thu, 16 Jun 2022 14:09:01 +0000
Date:   Thu, 16 Jun 2022 22:08:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Liang He <windhl@126.com>, linus.walleij@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org
Cc:     kbuild-all@lists.01.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        windhl@126.com
Subject: Re: [PATCH v2] drivers: clk: (clk-nomadik) Add missing of_node_put()
Message-ID: <202206162212.4SKEX9z6-lkp@intel.com>
References: <20220616032448.3974916-1-windhl@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220616032448.3974916-1-windhl@126.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Liang,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on clk/clk-next]
[also build test ERROR on linus/master v5.19-rc2 next-20220616]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Liang-He/drivers-clk-clk-nomadik-Add-missing-of_node_put/20220616-112612
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
config: arm-nhk8815_defconfig (https://download.01.org/0day-ci/archive/20220616/202206162212.4SKEX9z6-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/12a305918ea40c01116a3cab94fe62a487eac499
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Liang-He/drivers-clk-clk-nomadik-Add-missing-of_node_put/20220616-112612
        git checkout 12a305918ea40c01116a3cab94fe62a487eac499
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/clk/clk-nomadik.c: In function 'nomadik_src_init':
   drivers/clk/clk-nomadik.c:136:1: warning: label 'output' defined but not used [-Wunused-label]
     136 | output:
         | ^~~~~~
>> drivers/clk/clk-nomadik.c:102:17: error: label 'out_put' used but not defined
     102 |                 goto out_put;
         |                 ^~~~


vim +/out_put +102 drivers/clk/clk-nomadik.c

    87	
    88	static void __init nomadik_src_init(void)
    89	{
    90		struct device_node *np;
    91		u32 val;
    92	
    93		np = of_find_matching_node(NULL, nomadik_src_match);
    94		if (!np) {
    95			pr_crit("no matching node for SRC, aborting clock init\n");
    96			return;
    97		}
    98		src_base = of_iomap(np, 0);
    99		if (!src_base) {
   100			pr_err("%s: must have src parent node with REGS (%pOFn)\n",
   101			       __func__, np);
 > 102			goto out_put;
   103		}
   104	
   105		/* Set all timers to use the 2.4 MHz TIMCLK */
   106		val = readl(src_base + SRC_CR);
   107		val |= SRC_CR_T0_ENSEL;
   108		val |= SRC_CR_T1_ENSEL;
   109		val |= SRC_CR_T2_ENSEL;
   110		val |= SRC_CR_T3_ENSEL;
   111		val |= SRC_CR_T4_ENSEL;
   112		val |= SRC_CR_T5_ENSEL;
   113		val |= SRC_CR_T6_ENSEL;
   114		val |= SRC_CR_T7_ENSEL;
   115		writel(val, src_base + SRC_CR);
   116	
   117		val = readl(src_base + SRC_XTALCR);
   118		pr_info("SXTALO is %s\n",
   119			(val & SRC_XTALCR_SXTALDIS) ? "disabled" : "enabled");
   120		pr_info("MXTAL is %s\n",
   121			(val & SRC_XTALCR_MXTALSTAT) ? "enabled" : "disabled");
   122		if (of_property_read_bool(np, "disable-sxtalo")) {
   123			/* The machine uses an external oscillator circuit */
   124			val |= SRC_XTALCR_SXTALDIS;
   125			pr_info("disabling SXTALO\n");
   126		}
   127		if (of_property_read_bool(np, "disable-mxtalo")) {
   128			/* Disable this too: also run by external oscillator */
   129			val |= SRC_XTALCR_MXTALOVER;
   130			val &= ~SRC_XTALCR_MXTALEN;
   131			pr_info("disabling MXTALO\n");
   132		}
   133		writel(val, src_base + SRC_XTALCR);
   134		register_reboot_notifier(&nomadik_clk_reboot_notifier);
   135		
 > 136	output:
   137	    of_node_put(np);	
   138	}
   139	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
