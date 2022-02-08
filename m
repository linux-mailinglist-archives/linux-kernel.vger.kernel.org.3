Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6F0C4AE46B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 23:30:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386937AbiBHWak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 17:30:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387039AbiBHVtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 16:49:17 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F94DC0612BC;
        Tue,  8 Feb 2022 13:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644356956; x=1675892956;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2yTF4CDelmoVvKA+lxgQXMC3zxjRDLz1IzX04021fBU=;
  b=FhmdHXO3QOH0Xm/MTollnnRNTpqPAaOmaU5WEuaETk/PYWYrG/ik4Kv2
   8hw7NDU6JClsNUoIprBPUJsNXGfbLPwAxG/WLACpCBAHzshV3X4fn/FO0
   KHGI4zhE23sWsuAKY7/+KopeTzOEaJr46lE0yB1a0tQEGuXSh34WrvdJc
   fnISWH7TA4rZ647S1Ou42elqTTmoCRnKcEGXgl59qrD6BBE09xv5ln4ud
   +9TuvQ/6fbWJMnJyCQ7l49YWZavqNN6L/n2Z1aeGMaRxzWesJ2IMc9MZF
   TvjspQJOW0igz+bGbO4wWkNwfKV9c98Csi8pmadpptbSF8S+tVaourEFa
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="312356249"
X-IronPort-AV: E=Sophos;i="5.88,353,1635231600"; 
   d="scan'208";a="312356249"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 13:49:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,353,1635231600"; 
   d="scan'208";a="536710481"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 08 Feb 2022 13:49:11 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nHYMI-0000me-A5; Tue, 08 Feb 2022 21:49:10 +0000
Date:   Wed, 9 Feb 2022 05:48:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Carlos Bilbao <carlos.bilbao@amd.com>, john.stultz@linaro.org,
        tglx@linutronix.de, sboyd@kernel.org,
        alexandre.belloni@bootlin.com, gregkh@linuxfoundation.org
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        bilbao@vt.edu, geert@linux-m68k.org,
        linux-arm-kernel@lists.infradead.org, rostedt@goodmis.org,
        boon.leong.ong@intel.com, mhiramat@kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-rtc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-stm32@st-md-mailman.stormreply.com, jgross@suse.com,
        Carlos Bilbao <carlos.bilbao@amd.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] include: linux: Reorganize timekeeping and ktime
 headers
Message-ID: <202202090554.VWOt2B2w-lkp@intel.com>
References: <20220208161049.865402-1-carlos.bilbao@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220208161049.865402-1-carlos.bilbao@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Carlos,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on geert-m68k/for-next]
[also build test ERROR on tip/timers/core tip/x86/core linus/master v5.17-rc3]
[cannot apply to next-20220208]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Carlos-Bilbao/include-linux-Reorganize-timekeeping-and-ktime-headers/20220209-001309
base:   https://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git for-next
config: m68k-randconfig-r024-20220208 (https://download.01.org/0day-ci/archive/20220209/202202090554.VWOt2B2w-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/5ed7d76f2d6aabedc437bc0b99020dc655ab5719
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Carlos-Bilbao/include-linux-Reorganize-timekeeping-and-ktime-headers/20220209-001309
        git checkout 5ed7d76f2d6aabedc437bc0b99020dc655ab5719
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/m68k/68000/timers.c: In function 'hw_tick':
>> arch/m68k/68000/timers.c:64:9: error: implicit declaration of function 'legacy_timer_tick' [-Werror=implicit-function-declaration]
      64 |         legacy_timer_tick(1);
         |         ^~~~~~~~~~~~~~~~~
   arch/m68k/68000/timers.c: At top level:
   arch/m68k/68000/timers.c:120:5: warning: no previous prototype for 'm68328_hwclk' [-Wmissing-prototypes]
     120 | int m68328_hwclk(int set, struct rtc_time *t)
         |     ^~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/legacy_timer_tick +64 arch/m68k/68000/timers.c

36a90f26aa24c5 arch/m68knommu/platform/68328/timers.c Greg Ungerer  2008-02-01  57  
36a90f26aa24c5 arch/m68knommu/platform/68328/timers.c Greg Ungerer  2008-02-01  58  static irqreturn_t hw_tick(int irq, void *dummy)
36a90f26aa24c5 arch/m68knommu/platform/68328/timers.c Greg Ungerer  2008-02-01  59  {
36a90f26aa24c5 arch/m68knommu/platform/68328/timers.c Greg Ungerer  2008-02-01  60  	/* Reset Timer1 */
36a90f26aa24c5 arch/m68knommu/platform/68328/timers.c Greg Ungerer  2008-02-01  61  	TSTAT &= 0;
36a90f26aa24c5 arch/m68knommu/platform/68328/timers.c Greg Ungerer  2008-02-01  62  
36a90f26aa24c5 arch/m68knommu/platform/68328/timers.c Greg Ungerer  2008-02-01  63  	m68328_tick_cnt += TICKS_PER_JIFFY;
09323308f63708 arch/m68k/68000/timers.c               Arnd Bergmann 2020-09-24 @64  	legacy_timer_tick(1);
09323308f63708 arch/m68k/68000/timers.c               Arnd Bergmann 2020-09-24  65  	return IRQ_HANDLED;
36a90f26aa24c5 arch/m68knommu/platform/68328/timers.c Greg Ungerer  2008-02-01  66  }
36a90f26aa24c5 arch/m68knommu/platform/68328/timers.c Greg Ungerer  2008-02-01  67  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
