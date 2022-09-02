Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59D3F5AB8AB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 21:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbiIBTBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 15:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbiIBTBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 15:01:42 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D2FBB846;
        Fri,  2 Sep 2022 12:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662145301; x=1693681301;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9wyuSCNRmLxt1ljwXxGTY8XQYWyF2LtplpHjFbjivII=;
  b=dFaBMWJbbDGT0oLrR6uT3fil4PfLhZ7Z2vv3ehRHNpYxiC6sXeLixvMz
   7zmCVyNa29FndEnGegZopRoNjlkwO4RxWxeVOadnphtpywJHEBpcJ8K3L
   sNOiEmMfIjtm6AU5tDLI+l8jeHKTbA6FCKQ35Nx8TgMrEo+jnjzk4W7yE
   3rN8QQqJ2g6HbdnJFKiJtwdGeEzY4fDuuao76C1RO5QdGhy0cJzoY1Idt
   xKDxqiR2qTcAUVi94atVMCGtOp+x00i5amMdm0nudpb0/f+kS5KhTHxUv
   x/RmV2IwHNBTuSjjACV69aNbXQdrD0JxRI2To3RmXnYKrMH9oBHcC0Q/t
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10458"; a="296844082"
X-IronPort-AV: E=Sophos;i="5.93,285,1654585200"; 
   d="scan'208";a="296844082"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 12:01:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,285,1654585200"; 
   d="scan'208";a="646211769"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 02 Sep 2022 12:01:17 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oUBum-0000UR-2T;
        Fri, 02 Sep 2022 19:01:16 +0000
Date:   Sat, 3 Sep 2022 03:01:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        rcu@vger.kernel.org
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, paulmck@kernel.org,
        rostedt@goodmis.org, vineeth@bitbyteword.org, boqun.feng@gmail.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: Re: [PATCH v5 08/18] rcu: Add per-CB tracing for queuing, flush and
 invocation.
Message-ID: <202209030201.w42TEYCt-lkp@intel.com>
References: <20220901221720.1105021-9-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901221720.1105021-9-joel@joelfernandes.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi "Joel,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on paulmck-rcu/dev]
[also build test WARNING on pcmoore-selinux/next drm-intel/for-linux-next linus/master v6.0-rc3]
[cannot apply to vbabka-slab/for-next rostedt-trace/for-next tip/timers/core next-20220901]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Joel-Fernandes-Google/Implement-call_rcu_lazy-and-miscellaneous-fixes/20220902-062156
base:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev
config: sparc-allyesconfig (https://download.01.org/0day-ci/archive/20220903/202209030201.w42TEYCt-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/c0f09b1d42d06649680f74a78ca363e7f1c158b2
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Joel-Fernandes-Google/Implement-call_rcu_lazy-and-miscellaneous-fixes/20220902-062156
        git checkout c0f09b1d42d06649680f74a78ca363e7f1c158b2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sparc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/init.h:6,
                    from arch/sparc/kernel/head_64.S:13:
>> include/linux/types.h:233:44: warning: missing terminating ' character
     233 |         // at HZ=1000 before wrapping. That's enough for debug.
         |                                            ^


vim +233 include/linux/types.h

   230	
   231	struct cb_debug_info {
   232		// 16-bit jiffie deltas can provide about 60 seconds of resolution
 > 233		// at HZ=1000 before wrapping. That's enough for debug.
   234		u16 cb_queue_jiff;
   235		u16 first_bp_jiff;
   236		u16 cb_flush_jiff;
   237		enum cb_debug_flags flags:16;
   238	};
   239	#endif
   240	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
