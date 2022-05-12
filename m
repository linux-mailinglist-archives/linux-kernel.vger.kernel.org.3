Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EADCC5242E5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 04:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243845AbiELCwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 22:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243697AbiELCwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 22:52:20 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C22041B1CDA;
        Wed, 11 May 2022 19:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652323938; x=1683859938;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iPovg244m5lB0ST8KaA8boWcMETie163IiQLz7k5qJk=;
  b=L/GI1HzsMa+cDzMLOz2EEBMihyRofAgS3/RsuNCniY2dbqGrcB+MkQuW
   Rh0h13dH1EDfRNvG+1GtAr1QKJ0hY462ZRj+EGypDQp5KBTcSwQztkFrz
   /LshXxd5vloSHVdp6xVifxFeloGPjJ3ui5mCX9SzxgLInCAqPch+Q7Zi8
   TTMv+IV+gCTjhblsRMvdbie3z8tv17MI2QxwGtEP+zYzlA3KwBs2t2v+l
   y5EndX1Fq8hGHBWQQ0eFo7pBLqtVt0zOHrvV3i5bDxRYA8c6+ihNuLav3
   ctC7NGsg5AR2dUiWxpnEsDzfla96E+gRnzICJyl3JX92c1y8MLiJfFesx
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="257419742"
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; 
   d="scan'208";a="257419742"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 19:52:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; 
   d="scan'208";a="636662834"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 11 May 2022 19:52:15 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1noyw2-000Jrz-Oi;
        Thu, 12 May 2022 02:52:14 +0000
Date:   Thu, 12 May 2022 10:51:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Henning Schild <henning.schild@siemens.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Mark Gross <markgross@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-watchdog@vger.kernel.org, Enrico Weigelt <lkml@metux.net>,
        Gerd Haeussler <gerd.haeussler.ext@siemens.com>,
        Henning Schild <henning.schild@siemens.com>
Subject: Re: [PATCH v2 2/4] watchdog: simatic-ipc-wdt: convert to use P2SB
 accessor
Message-ID: <202205121056.jp0pcxHa-lkp@intel.com>
References: <20220511153905.13980-3-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220511153905.13980-3-henning.schild@siemens.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Henning,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on pavel-leds/for-next]
[also build test ERROR on groeck-staging/hwmon-next linus/master v5.18-rc6 next-20220511]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Henning-Schild/simatic-ipc-additions-to-p2sb-apl-lake-gpio/20220511-234148
base:   git://git.kernel.org/pub/scm/linux/kernel/git/pavel/linux-leds.git for-next
config: i386-randconfig-a004-20220509 (https://download.01.org/0day-ci/archive/20220512/202205121056.jp0pcxHa-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 18dd123c56754edf62c7042dcf23185c3727610f)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/f9374205615fb91a7d289a6acaeafcd5f9c16ac4
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Henning-Schild/simatic-ipc-additions-to-p2sb-apl-lake-gpio/20220511-234148
        git checkout f9374205615fb91a7d289a6acaeafcd5f9c16ac4
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/watchdog/simatic-ipc-wdt.c:19:10: fatal error: 'linux/platform_data/x86/p2sb.h' file not found
   #include <linux/platform_data/x86/p2sb.h>
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 error generated.


vim +19 drivers/watchdog/simatic-ipc-wdt.c

  > 19	#include <linux/platform_data/x86/p2sb.h>
    20	#include <linux/platform_data/x86/simatic-ipc-base.h>
    21	#include <linux/platform_device.h>
    22	#include <linux/sizes.h>
    23	#include <linux/util_macros.h>
    24	#include <linux/watchdog.h>
    25	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
