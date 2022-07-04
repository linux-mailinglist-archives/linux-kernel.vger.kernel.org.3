Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6F54565EDF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 23:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233384AbiGDVWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 17:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232178AbiGDVVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 17:21:54 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE58660DC;
        Mon,  4 Jul 2022 14:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656969713; x=1688505713;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Zj9zKOViwF87Jpta7XyEh+jsdVWawQj34qnK9rX7MFA=;
  b=JXfV1nQKgko1rLrHOZVGnVKuwA4j03tfifiW+/B6PI4g2vSywILF7CdR
   QFxD4m0eUqP5HNL2QvegaXfUVgGaPZ+kQO5qx71h5hg4NoZ8b6lyHxcA7
   CIix88NMzN1STJ/XExxIzb99G96qD/crAbcMJWRGu0+mYXup1VSaSaupY
   0Oeuq5+UxLRrkW4g0adpPLJsZh3frtF9ZfnSfRzTJgZdRwFFS9Q3xGLuM
   7DFooN+n5xmepx7zBimqRh8YmUWpHUtkSS+aNBtHKwI47+CrVoq35Vls4
   ScW0eL1dEezdjwVhMsnrtIjAvX0MUSW6TCRKjj+HM9Y248XcKfbRwBO22
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10398"; a="281956878"
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="281956878"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2022 14:21:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="660315704"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 04 Jul 2022 14:21:50 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o8TVt-000IBB-Mt;
        Mon, 04 Jul 2022 21:21:49 +0000
Date:   Tue, 5 Jul 2022 05:20:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>,
        agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        quic_msavaliy@quicinc.com, dianders@chromium.org, mka@chromium.org,
        swboyd@chromium.org,
        Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Subject: Re: [V2] tty: serial: qcom-geni-serial: Fix get_clk_div_rate() which
 otherwise could return a sub-optimal clock rate.
Message-ID: <202207050527.wrtnyin5-lkp@intel.com>
References: <1656496841-5853-1-git-send-email-quic_vnivarth@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1656496841-5853-1-git-send-email-quic_vnivarth@quicinc.com>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vijaya,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on tty/tty-testing]
[also build test WARNING on linus/master v5.19-rc5 next-20220704]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Vijaya-Krishna-Nivarthi/tty-serial-qcom-geni-serial-Fix-get_clk_div_rate-which-otherwise-could-return-a-sub-optimal-clock-rate/20220629-180330
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
config: hexagon-buildonly-randconfig-r006-20220703 (https://download.01.org/0day-ci/archive/20220705/202207050527.wrtnyin5-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project f7a80c3d08d4821e621fc88d6a2e435291f82dff)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/a70b5a9759aef627b6882576f38399ed8c092b74
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Vijaya-Krishna-Nivarthi/tty-serial-qcom-geni-serial-Fix-get_clk_div_rate-which-otherwise-could-return-a-sub-optimal-clock-rate/20220629-180330
        git checkout a70b5a9759aef627b6882576f38399ed8c092b74
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/tty/serial/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/tty/serial/qcom_geni_serial.c:1044:56: warning: format specifies type 'int' but the argument has type 'unsigned long' [-Wformat]
                   pr_err("Couldn't find suitable clock rate for %d\n", desired_clk);
                                                                 ~~     ^~~~~~~~~~~
                                                                 %lu
   include/linux/printk.h:523:33: note: expanded from macro 'pr_err'
           printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
                                  ~~~     ^~~~~~~~~~~
   include/linux/printk.h:480:60: note: expanded from macro 'printk'
   #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
                                                       ~~~    ^~~~~~~~~~~
   include/linux/printk.h:452:19: note: expanded from macro 'printk_index_wrap'
                   _p_func(_fmt, ##__VA_ARGS__);                           \
                           ~~~~    ^~~~~~~~~~~
   drivers/tty/serial/qcom_geni_serial.c:1047:4: warning: format specifies type 'int' but the argument has type 'unsigned long' [-Wformat]
                           desired_clk, ser_clk, *clk_div);
                           ^~~~~~~~~~~
   include/linux/printk.h:610:38: note: expanded from macro 'pr_debug'
           no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
                                       ~~~     ^~~~~~~~~~~
   include/linux/printk.h:131:17: note: expanded from macro 'no_printk'
                   printk(fmt, ##__VA_ARGS__);             \
                          ~~~    ^~~~~~~~~~~
   include/linux/printk.h:480:60: note: expanded from macro 'printk'
   #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
                                                       ~~~    ^~~~~~~~~~~
   include/linux/printk.h:452:19: note: expanded from macro 'printk_index_wrap'
                   _p_func(_fmt, ##__VA_ARGS__);                           \
                           ~~~~    ^~~~~~~~~~~
   drivers/tty/serial/qcom_geni_serial.c:1047:17: warning: format specifies type 'int' but the argument has type 'unsigned long' [-Wformat]
                           desired_clk, ser_clk, *clk_div);
                                        ^~~~~~~
   include/linux/printk.h:610:38: note: expanded from macro 'pr_debug'
           no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
                                       ~~~     ^~~~~~~~~~~
   include/linux/printk.h:131:17: note: expanded from macro 'no_printk'
                   printk(fmt, ##__VA_ARGS__);             \
                          ~~~    ^~~~~~~~~~~
   include/linux/printk.h:480:60: note: expanded from macro 'printk'
   #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
                                                       ~~~    ^~~~~~~~~~~
   include/linux/printk.h:452:19: note: expanded from macro 'printk_index_wrap'
                   _p_func(_fmt, ##__VA_ARGS__);                           \
                           ~~~~    ^~~~~~~~~~~
   3 warnings generated.


vim +1044 drivers/tty/serial/qcom_geni_serial.c

  1021	
  1022	static unsigned long get_clk_div_rate(struct clk *clk, unsigned int baud,
  1023				unsigned int sampling_rate, unsigned int *clk_div)
  1024	{
  1025		unsigned long ser_clk;
  1026		unsigned long desired_clk;
  1027	
  1028		desired_clk = baud * sampling_rate;
  1029		if (!desired_clk) {
  1030			pr_err("%s: Invalid frequency\n", __func__);
  1031			return 0;
  1032		}
  1033	
  1034		ser_clk = 0;
  1035		/*
  1036		 * try to find exact clock rate or within 2% tolerance,
  1037		 * then within 5% tolerance
  1038		 */
  1039		ser_clk = find_clk_rate_in_tol(clk, desired_clk, clk_div, 2, true);
  1040		if (!ser_clk)
  1041			ser_clk = find_clk_rate_in_tol(clk, desired_clk, clk_div, 5, false);
  1042	
  1043		if (!ser_clk)
> 1044			pr_err("Couldn't find suitable clock rate for %d\n", desired_clk);
  1045		else
  1046			pr_debug("desired_clk-%d, ser_clk-%d, clk_div-%d\n",
  1047				desired_clk, ser_clk, *clk_div);
  1048	
  1049		return ser_clk;
  1050	}
  1051	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
