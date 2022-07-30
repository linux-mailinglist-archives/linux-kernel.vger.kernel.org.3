Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5A7585A58
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 14:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233650AbiG3MAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 08:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbiG3MAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 08:00:07 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C7625C78
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 05:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659182406; x=1690718406;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZIeBMkRde/fQ9qd7XVX6tONs0TVDZreYSIBeJirpvtw=;
  b=PUK2pXd4J1i/My2DInp9S4RBXbRqkYfLK9DcySYkqazqDAreCHjXpypz
   1bi/wg2vRMVMoJErGP0McdS/YbE5SkAADPuZRAxNPSLiQc9xk8AqTF4XT
   iNWVEyWDWAK+W/9RQAL4Qay/UddDdEu+UG2vPfeceGV5skVg4NThPAq0C
   KoVgFGM0nWqtUG1RvmX3e9kQo1hFuGqOTuZP1FwGjlqfOYjvPVAQjAKIm
   cKmZsxzx3q44mZHbHuEBuxAuRig6Zk8eUxkbLSFWGG4lYS3eWKDVQF+QS
   ZlCkjCpft4D3pzjclUqaIxmrpsLNBS3bX1Vp+G8mlzD9A7wK1L5Nxlfy8
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10423"; a="271952761"
X-IronPort-AV: E=Sophos;i="5.93,204,1654585200"; 
   d="scan'208";a="271952761"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2022 05:00:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,204,1654585200"; 
   d="scan'208";a="629680155"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 30 Jul 2022 05:00:04 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oHl8V-000CnX-1S;
        Sat, 30 Jul 2022 12:00:03 +0000
Date:   Sat, 30 Jul 2022 19:59:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Liu Chao <liuchao173@huawei.com>, linux-kernel@vger.kernel.org,
        tglx@linutronix.de
Cc:     kbuild-all@lists.01.org, hewenliang4@huawei.com,
        linfeilong@huawei.com
Subject: Re: [PATCH] add miss time to CPUTIME_USER when kernel boots with
 highres=off
Message-ID: <202207301919.eJn0Icey-lkp@intel.com>
References: <20220730091456.3741503-1-liuchao173@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220730091456.3741503-1-liuchao173@huawei.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Liu,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on tip/timers/core]
[also build test ERROR on linus/master v5.19-rc8 next-20220728]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Liu-Chao/add-miss-time-to-CPUTIME_USER-when-kernel-boots-with-highres-off/20220730-171718
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git cceeeb6a6d02e7b9a74ddd27a3225013b34174aa
config: arc-allnoconfig (https://download.01.org/0day-ci/archive/20220730/202207301919.eJn0Icey-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/7ac63e1383163d700eb4212b689a272a4763e185
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Liu-Chao/add-miss-time-to-CPUTIME_USER-when-kernel-boots-with-highres-off/20220730-171718
        git checkout 7ac63e1383163d700eb4212b689a272a4763e185
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash kernel/time/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   kernel/time/hrtimer.c:120:35: warning: initialized field overwritten [-Woverride-init]
     120 |         [CLOCK_REALTIME]        = HRTIMER_BASE_REALTIME,
         |                                   ^~~~~~~~~~~~~~~~~~~~~
   kernel/time/hrtimer.c:120:35: note: (near initialization for 'hrtimer_clock_to_base_table[0]')
   kernel/time/hrtimer.c:121:35: warning: initialized field overwritten [-Woverride-init]
     121 |         [CLOCK_MONOTONIC]       = HRTIMER_BASE_MONOTONIC,
         |                                   ^~~~~~~~~~~~~~~~~~~~~~
   kernel/time/hrtimer.c:121:35: note: (near initialization for 'hrtimer_clock_to_base_table[1]')
   kernel/time/hrtimer.c:122:35: warning: initialized field overwritten [-Woverride-init]
     122 |         [CLOCK_BOOTTIME]        = HRTIMER_BASE_BOOTTIME,
         |                                   ^~~~~~~~~~~~~~~~~~~~~
   kernel/time/hrtimer.c:122:35: note: (near initialization for 'hrtimer_clock_to_base_table[7]')
   kernel/time/hrtimer.c:123:35: warning: initialized field overwritten [-Woverride-init]
     123 |         [CLOCK_TAI]             = HRTIMER_BASE_TAI,
         |                                   ^~~~~~~~~~~~~~~~
   kernel/time/hrtimer.c:123:35: note: (near initialization for 'hrtimer_clock_to_base_table[11]')
>> kernel/time/hrtimer.c:754:19: error: static declaration of 'hrtimer_is_hres_enabled' follows non-static declaration
     754 | static inline int hrtimer_is_hres_enabled(void) { return 0; }
         |                   ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/sched.h:19,
                    from include/linux/ratelimit.h:6,
                    from include/linux/dev_printk.h:16,
                    from include/linux/device.h:15,
                    from include/linux/node.h:18,
                    from include/linux/cpu.h:17,
                    from kernel/time/hrtimer.c:25:
   include/linux/hrtimer.h:329:12: note: previous declaration of 'hrtimer_is_hres_enabled' with type 'int(void)'
     329 | extern int hrtimer_is_hres_enabled(void);
         |            ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/time/hrtimer.c: In function '__run_hrtimer':
   kernel/time/hrtimer.c:1648:14: warning: variable 'expires_in_hardirq' set but not used [-Wunused-but-set-variable]
    1648 |         bool expires_in_hardirq;
         |              ^~~~~~~~~~~~~~~~~~


vim +/hrtimer_is_hres_enabled +754 kernel/time/hrtimer.c

54cdfdb47f73b5a kernel/hrtimer.c      Thomas Gleixner 2007-02-16  753  
54cdfdb47f73b5a kernel/hrtimer.c      Thomas Gleixner 2007-02-16 @754  static inline int hrtimer_is_hres_enabled(void) { return 0; }
75e3b37d059856a kernel/time/hrtimer.c Luiz Capitulino 2015-08-11  755  static inline void hrtimer_switch_to_hres(void) { }
54cdfdb47f73b5a kernel/hrtimer.c      Thomas Gleixner 2007-02-16  756  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
