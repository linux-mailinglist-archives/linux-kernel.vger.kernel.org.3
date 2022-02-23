Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 963504C0C42
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 06:51:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237990AbiBWFvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 00:51:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236743AbiBWFvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 00:51:47 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C1843AF4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 21:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645595480; x=1677131480;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=8EFrPs1xiRRVF5w1/jRlZCuCqrPp2F8vOyo8y2fWGLo=;
  b=EuyJjky77N/Md8G8NGu5REhIaS/EI5IN573R89Hfl8SM5q7t7A8h/VNF
   JW6Q/BO+S3rkHcvcm+7/UCibXLe5Z/PT/RoKRgOkNWQWu6DOwgF1bTH/w
   O3wGG77P6bvrotkRxvu0j4ShdUFODXw3wsWJlD1ybvEwT0bJpMsXk3tQs
   N/DpyqcPo11Qm+S1ZXokLTCI6VALFOpg7auuvE3e/sWyHB3nLfIEC7llN
   CHaokvnoN1ofK/sRs8rt2EBmk6cK/nSVsQaN664/K6+SGICtM7t9outhE
   MEEBuX8iFsiRe+5rDv1tO+X3xJ2Q28Mh03jyD/senQt11G8Tw5MTj0ldo
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10266"; a="312605511"
X-IronPort-AV: E=Sophos;i="5.88,390,1635231600"; 
   d="scan'208";a="312605511"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 21:51:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,390,1635231600"; 
   d="scan'208";a="639188679"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 22 Feb 2022 21:51:17 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nMkYW-00012V-Qu; Wed, 23 Feb 2022 05:51:16 +0000
Date:   Wed, 23 Feb 2022 13:50:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>,
        Russell King <linux@armlinux.org.uk>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Cc:     kbuild-all@lists.01.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>
Subject: Re: [PATCH 3/4] ARM: at91: pm: add support for sama5d2 secure suspend
Message-ID: <202202231329.2hzbFwiR-lkp@intel.com>
References: <20220222150846.255307-4-clement.leger@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220222150846.255307-4-clement.leger@bootlin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi "Clément,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on soc/for-next]
[also build test WARNING on arm/for-next abelloni/rtc-next linus/master v5.17-rc5 next-20220217]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Cl-ment-L-ger/ARM-at91-add-support-for-secure-suspend-on-sama5d2/20220222-231305
base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
config: arm-allmodconfig (https://download.01.org/0day-ci/archive/20220223/202202231329.2hzbFwiR-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/e7f524a6f3693c0e84b0258766c98a24046c9ba1
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Cl-ment-L-ger/ARM-at91-add-support-for-secure-suspend-on-sama5d2/20220222-231305
        git checkout e7f524a6f3693c0e84b0258766c98a24046c9ba1
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/arm/mach-at91/pm_secure.c:50:5: warning: no previous prototype for 'at91_suspend_entering_slow_clock' [-Wmissing-prototypes]
      50 | int at91_suspend_entering_slow_clock(void)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for ATMEL_PM
   Depends on ARCH_AT91 && !ATMEL_SECURE_PM
   Selected by
   - SOC_SAMA7 && ARCH_AT91 && PM


vim +/at91_suspend_entering_slow_clock +50 arch/arm/mach-at91/pm_secure.c

    49	
  > 50	int at91_suspend_entering_slow_clock(void)
    51	{
    52		return (suspend_mode >= AT91_PM_ULP0);
    53	}
    54	EXPORT_SYMBOL(at91_suspend_entering_slow_clock);
    55	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
