Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45A4456C466
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239940AbiGHWcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 18:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239581AbiGHWcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 18:32:17 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F8C213B458;
        Fri,  8 Jul 2022 15:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657319537; x=1688855537;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pYUR5n3zSWGMe79Vz7YJD1vt8XQmHwETPJxWhHm8Fzs=;
  b=TjoquACbpslTbS1yj2yyeior5vpHP5uG124AWyqVdFGE+TtcRKjCugUW
   lGVGCfSjNYiLFwxgX3hSt46D1QhTLMegA/WOTqYnUgyBZFIEhBYDIXE9B
   0OWdSUzGxJMXdogpJM/PP3AAJ3LJCuPvqwGNVtEOlxjJivs/eoDoIhD0u
   WZgFZzpUJg+ob0mq7nRAV4Ue4Gl6le59sAMYRlEQtwxNtmSPb1h18UwYL
   f7S5ofXpXTG5Uh7RXC8txm6UEZ7MOj+L7SiIy9Ox9LW2BfqtgAetooHTt
   LYU+KP2o9+TAP4qDbomxs22ZVfU+w1l224+9O6mrTlahFf9blwCy0uYJJ
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10402"; a="346064522"
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="346064522"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 15:32:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="770919860"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 08 Jul 2022 15:32:11 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o9wWA-000O0k-Oy;
        Fri, 08 Jul 2022 22:32:10 +0000
Date:   Sat, 9 Jul 2022 06:31:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mia Lin <mimi05633@gmail.com>, avifishman70@gmail.com,
        tmaimon77@gmail.com, tali.perry1@gmail.com, venture@google.com,
        yuenn@google.com, benjaminfair@google.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, ctcchien@nuvoton.com,
        KWLIU@nuvoton.com, YSCHU@nuvoton.com, KFTING@nuvoton.com,
        JJLIU0@nuvoton.com, mylin1@nuvoton.com
Cc:     kbuild-all@lists.01.org, openbmc@lists.ozlabs.org,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] RTC: nuvoton: Add NCT3018Y real time clock driver
Message-ID: <202207090650.qVcM1Juo-lkp@intel.com>
References: <20220707073054.3954-4-mimi05633@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220707073054.3954-4-mimi05633@gmail.com>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mia,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on abelloni/rtc-next]
[also build test ERROR on robh/for-next linus/master v5.19-rc5 next-20220708]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mia-Lin/RTC-nuvoton-Add-nuvoton-real-time-clock-driver/20220707-153317
base:   https://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git rtc-next
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220709/202207090650.qVcM1Juo-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/028783fef7713ddc9f2d14a39f09741370f42e3c
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Mia-Lin/RTC-nuvoton-Add-nuvoton-real-time-clock-driver/20220707-153317
        git checkout 028783fef7713ddc9f2d14a39f09741370f42e3c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/rtc/rtc-nct3018y.c:553:23: error: unterminated argument list invoking macro "MODULE_AUTHOR"
     553 | MODULE_LICENSE("GPL");
         |                       ^
>> drivers/rtc/rtc-nct3018y.c:551:1: error: expected '=', ',', ';', 'asm' or '__attribute__' at end of input
     551 | MODULE_AUTHOR(("Mia Lin <mimi05633@gmail.com>");
         | ^~~~~~~~~~~~~


vim +/MODULE_AUTHOR +553 drivers/rtc/rtc-nct3018y.c

   549	
   550	MODULE_AUTHOR("Medad CChien <ctcchien@nuvoton.com>");
 > 551	MODULE_AUTHOR(("Mia Lin <mimi05633@gmail.com>");
   552	MODULE_DESCRIPTION("Nuvoton NCT3018Y RTC driver");
 > 553	MODULE_LICENSE("GPL");

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
