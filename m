Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB80B554625
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355234AbiFVJ2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 05:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356378AbiFVJ1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 05:27:45 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E6A37A14
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 02:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655890064; x=1687426064;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iiFLOMxIIm5NPds5E0AcgENCgnumF65jA2ZbRysJsY0=;
  b=lShDsCpPjFsjZfQz4wF5pUsm0Dg3VL/atre8FQI36rp7vINMxGmMlSjs
   +flEP++N+EDhtPeqXHGK5d/+c6ZAX4Oy2+rxj3I665rhN8rblQ5Laeu7a
   bkD6oBzzVYIZoLGXJ0rAFQ0XuuCFIgm3IV0NBFx6u1zH8lxpufX2yNuYr
   ZPjHijQDlBpQW38XS/CAfTZ9K9atgVf0jEpUz1GRj/5nhUPYErv5FdAz0
   BJt/L5EarPf0ef43/pXgzR3TQIVy+DxOe2391u68c87s5DpJMVhnyQQeP
   ydJacvSQBaN1o3VDNQg4TwHHdLoxDM6FxOg7Ja+Jxiobd7b4H5SAYJEg/
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10385"; a="263401180"
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="263401180"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 02:27:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="620835546"
Received: from lkp-server02.sh.intel.com (HELO a67cc04a5eeb) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 22 Jun 2022 02:27:41 -0700
Received: from kbuild by a67cc04a5eeb with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o3weC-00015d-Ot;
        Wed, 22 Jun 2022 09:27:40 +0000
Date:   Wed, 22 Jun 2022 17:26:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Laurent Dufour <ldufour@linux.ibm.com>, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org, nathanl@linux.ibm.com,
        haren@linux.vnet.ibm.com, npiggin@gmail.com
Cc:     kbuild-all@lists.01.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] powerpc/watchdog: introduce a LPM factor
Message-ID: <202206221732.AujJ8kWm-lkp@intel.com>
References: <20220614135414.37746-4-ldufour@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220614135414.37746-4-ldufour@linux.ibm.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on powerpc/next]
[also build test ERROR on linus/master v5.19-rc3 next-20220621]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Laurent-Dufour/Extending-NMI-watchdog-during-LPM/20220614-215716
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
config: powerpc-mgcoge_defconfig (https://download.01.org/0day-ci/archive/20220622/202206221732.AujJ8kWm-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/368bca30c0737461c2ed32a788293018c25fc9c7
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Laurent-Dufour/Extending-NMI-watchdog-during-LPM/20220614-215716
        git checkout 368bca30c0737461c2ed32a788293018c25fc9c7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash arch/powerpc/kernel/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/powerpc/kernel/traps.c:69:
>> arch/powerpc/include/asm/nmi.h:11:13: error: 'watchdog_nmi_set_lpm_factor' defined but not used [-Werror=unused-function]
      11 | static void watchdog_nmi_set_lpm_factor(u64 factor) {}
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors


vim +/watchdog_nmi_set_lpm_factor +11 arch/powerpc/include/asm/nmi.h

     4	
     5	#ifdef CONFIG_PPC_WATCHDOG
     6	extern void arch_touch_nmi_watchdog(void);
     7	long soft_nmi_interrupt(struct pt_regs *regs);
     8	void watchdog_nmi_set_lpm_factor(u64 factor);
     9	#else
    10	static inline void arch_touch_nmi_watchdog(void) {}
  > 11	static void watchdog_nmi_set_lpm_factor(u64 factor) {}
    12	#endif
    13	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
