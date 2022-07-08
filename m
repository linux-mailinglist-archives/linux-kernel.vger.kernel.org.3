Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74A2D56B30D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 09:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237296AbiGHHDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 03:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236733AbiGHHDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 03:03:37 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E296B241;
        Fri,  8 Jul 2022 00:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657263815; x=1688799815;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sLTf7xui5DUh0UIt7UN4rONb0R9ycQ6xpaAgmLAuY30=;
  b=DIn7+74MJtv0OoDLRw3CjxBEDjGFAZqqq3WNnnxPvglSJM73a7v1+qPg
   wB5Qv+Wf+SWV5R7xJ4kQAOfFF507DXgSHVeP3oGs2/o516yx5uS1q0bGG
   vxCKl2qG7fK9MjKeXvQXsD2Cu+FpG2Y+bJCqC1KSli6UDH2Ws8v6mg1Wg
   6fFyDiY7B+K7ZjPIWM9ZDoZd4DlcbHgka8yWYLpvqZxZ6dkwUTSwgU41R
   17H56m/mrrWb82mow/88bIxsXX2AeuQKUX2hLPsVdYfDdmyHGpSCtUiUj
   GeUA2Zba1c5eyHvezw/pXlaz02QfKQBRGIp1MzLNKZixBjKV876pw1Ahd
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10401"; a="281759989"
X-IronPort-AV: E=Sophos;i="5.92,254,1650956400"; 
   d="scan'208";a="281759989"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 00:03:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,254,1650956400"; 
   d="scan'208";a="920895624"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 08 Jul 2022 00:03:31 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o9i1S-000N4s-JB;
        Fri, 08 Jul 2022 07:03:30 +0000
Date:   Fri, 8 Jul 2022 15:02:33 +0800
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
Subject: Re: [V3] tty: serial: qcom-geni-serial: Fix get_clk_div_rate() which
 otherwise could return a sub-optimal clock rate.
Message-ID: <202207081429.4VXpQCls-lkp@intel.com>
References: <1657221457-32494-1-git-send-email-quic_vnivarth@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1657221457-32494-1-git-send-email-quic_vnivarth@quicinc.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
[also build test WARNING on linus/master v5.19-rc5 next-20220707]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Vijaya-Krishna-Nivarthi/tty-serial-qcom-geni-serial-Fix-get_clk_div_rate-which-otherwise-could-return-a-sub-optimal-clock-rate/20220708-031921
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
config: hexagon-randconfig-r023-20220707 (https://download.01.org/0day-ci/archive/20220708/202207081429.4VXpQCls-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 562c3467a6738aa89203f72fc1d1343e5baadf3c)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/fbd8a1a4b7d91ea5caa048e4557ab18b0d08ea86
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Vijaya-Krishna-Nivarthi/tty-serial-qcom-geni-serial-Fix-get_clk_div_rate-which-otherwise-could-return-a-sub-optimal-clock-rate/20220708-031921
        git checkout fbd8a1a4b7d91ea5caa048e4557ab18b0d08ea86
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/tty/serial/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/tty/serial/qcom_geni_serial.c:1007:26: warning: format specifies type 'unsigned long' but the argument has type 'unsigned int' [-Wformat]
                           desired_clk, ser_clk, *clk_div);
                                                 ^~~~~~~~
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
   1 warning generated.


vim +1007 drivers/tty/serial/qcom_geni_serial.c

   983	
   984	static unsigned long get_clk_div_rate(struct clk *clk, unsigned int baud,
   985				unsigned int sampling_rate, unsigned int *clk_div)
   986	{
   987		unsigned long ser_clk;
   988		unsigned long desired_clk;
   989	
   990		desired_clk = baud * sampling_rate;
   991		if (!desired_clk) {
   992			pr_err("%s: Invalid frequency\n", __func__);
   993			return 0;
   994		}
   995	
   996		/*
   997		 * try to find a clock rate within 2% tolerance, then within
   998		 */
   999		ser_clk = find_clk_rate_in_tol(clk, desired_clk, clk_div, 2);
  1000		if (!ser_clk)
  1001			ser_clk = find_clk_rate_in_tol(clk, desired_clk, clk_div, 5);
  1002	
  1003		if (!ser_clk)
  1004			pr_err("Couldn't find suitable clock rate for %lu\n", desired_clk);
  1005		else
  1006			pr_debug("desired_clk-%lu, ser_clk-%lu, clk_div-%lu\n",
> 1007				desired_clk, ser_clk, *clk_div);
  1008	
  1009		return ser_clk;
  1010	}
  1011	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
