Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C78F656B1E8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 07:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237318AbiGHEsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 00:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237246AbiGHEsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 00:48:30 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B35EDB7C5;
        Thu,  7 Jul 2022 21:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657255708; x=1688791708;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JMwN4AOFcj3XnN0nw4WIO8eRYRgOHL+c7NhVdR93iTc=;
  b=KxwSwRdmmObG689t8WjU2EtDLUK0hTqpj1Gh3CmZ9OdU9fV1XBb4ixEE
   p/iWA7COYTqKo3qeho+z9t8uSVYjgViahRzAB8bp4/0yAgrBvqCLqtRlv
   hk5Kw+dAv2ryNhZ4eujmzQaTNWgmm/0pvBwys43QV39Lo4pSB+U/+s9B1
   4QpPS8Ylg5AI23DlmA6zWnO4Wh4qrSCqpL8jnYxX/SOjySfKF4ziy0KyK
   7AUslSDkWwbSmt7BzzYaZDKFg7LS2bFciwp1LUagNhRstUUiMMziHMEuJ
   twmqLLf9JCoSNOc0vN+wg7GL0RGFx2N2TzgbAbQTM3HJ/lBO5lSdfMRQH
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10401"; a="267220402"
X-IronPort-AV: E=Sophos;i="5.92,254,1650956400"; 
   d="scan'208";a="267220402"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2022 21:48:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,254,1650956400"; 
   d="scan'208";a="920860672"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 07 Jul 2022 21:48:25 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o9fui-000Mvu-B1;
        Fri, 08 Jul 2022 04:48:24 +0000
Date:   Fri, 8 Jul 2022 12:48:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>,
        agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, quic_msavaliy@quicinc.com,
        dianders@chromium.org, mka@chromium.org, swboyd@chromium.org,
        Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Subject: Re: [V3] tty: serial: qcom-geni-serial: Fix get_clk_div_rate() which
 otherwise could return a sub-optimal clock rate.
Message-ID: <202207081234.3SPgl4KO-lkp@intel.com>
References: <1657221457-32494-1-git-send-email-quic_vnivarth@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1657221457-32494-1-git-send-email-quic_vnivarth@quicinc.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
config: nios2-randconfig-r024-20220707 (https://download.01.org/0day-ci/archive/20220708/202207081234.3SPgl4KO-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/fbd8a1a4b7d91ea5caa048e4557ab18b0d08ea86
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Vijaya-Krishna-Nivarthi/tty-serial-qcom-geni-serial-Fix-get_clk_div_rate-which-otherwise-could-return-a-sub-optimal-clock-rate/20220708-031921
        git checkout fbd8a1a4b7d91ea5caa048e4557ab18b0d08ea86
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=nios2 SHELL=/bin/bash drivers/tty/serial/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/kernel.h:29,
                    from include/linux/clk.h:13,
                    from drivers/tty/serial/qcom_geni_serial.c:4:
   drivers/tty/serial/qcom_geni_serial.c: In function 'get_clk_div_rate':
>> drivers/tty/serial/qcom_geni_serial.c:1006:26: warning: format '%lu' expects argument of type 'long unsigned int', but argument 5 has type 'unsigned int' [-Wformat=]
    1006 |                 pr_debug("desired_clk-%lu, ser_clk-%lu, clk_div-%lu\n",
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/printk.h:370:21: note: in definition of macro 'pr_fmt'
     370 | #define pr_fmt(fmt) fmt
         |                     ^~~
   include/linux/dynamic_debug.h:152:9: note: in expansion of macro '__dynamic_func_call'
     152 |         __dynamic_func_call(__UNIQUE_ID(ddebug), fmt, func, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:162:9: note: in expansion of macro '_dynamic_func_call'
     162 |         _dynamic_func_call(fmt, __dynamic_pr_debug,             \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/printk.h:604:9: note: in expansion of macro 'dynamic_pr_debug'
     604 |         dynamic_pr_debug(fmt, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~
   drivers/tty/serial/qcom_geni_serial.c:1006:17: note: in expansion of macro 'pr_debug'
    1006 |                 pr_debug("desired_clk-%lu, ser_clk-%lu, clk_div-%lu\n",
         |                 ^~~~~~~~
   drivers/tty/serial/qcom_geni_serial.c:1006:67: note: format string is defined here
    1006 |                 pr_debug("desired_clk-%lu, ser_clk-%lu, clk_div-%lu\n",
         |                                                                 ~~^
         |                                                                   |
         |                                                                   long unsigned int
         |                                                                 %u


vim +1006 drivers/tty/serial/qcom_geni_serial.c

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
> 1006			pr_debug("desired_clk-%lu, ser_clk-%lu, clk_div-%lu\n",
  1007				desired_clk, ser_clk, *clk_div);
  1008	
  1009		return ser_clk;
  1010	}
  1011	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
