Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD6635777C3
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 20:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232096AbiGQS0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 14:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiGQS0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 14:26:04 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A04912613;
        Sun, 17 Jul 2022 11:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658082362; x=1689618362;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Lev7I62R+ZkqbUI7VHug5zWd6VrLgETsZS6J/rKaTh4=;
  b=fd4mhEviOKTZdNKWjWz1adon0TUAyVZ2rxS7mx8hgFyz8wB3rkAURtJc
   4fiyw/uxVwqVi5BTteV26NzWeB8aXuxRC2/61ei022S/qm3jCoEDLje7Q
   bZbQJlkwi3BC1s60Hlmd5PCKL7BgEB0CDYUWfg8Sd3foC9BCE0xkJ5xWw
   oUTMpom5BL5h+eswURHSuoAG1fe52BuH0sY9Rp5ZNy75tdTH82sK9Np9W
   wAZQnTdWEF6e7sLnqLk3DJBrFo3FLJKveCZxNIxVDheyqgerE8cssI+10
   Z6yP0AdeqAKB+KeuQDcdOzqqUGGuscmyWCJts1quov4UfMCf4zO6v2a1W
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10411"; a="347770619"
X-IronPort-AV: E=Sophos;i="5.92,279,1650956400"; 
   d="scan'208";a="347770619"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2022 11:26:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,279,1650956400"; 
   d="scan'208";a="624455965"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 17 Jul 2022 11:25:59 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oD8xq-0003ZM-NH;
        Sun, 17 Jul 2022 18:25:58 +0000
Date:   Mon, 18 Jul 2022 02:25:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Zqiang <qiang1.zhang@intel.com>, paulmck@kernel.org,
        frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu-tasks: Make RCU Tasks Trace checking for userspace
 execution
Message-ID: <202207180246.5cKJdGrg-lkp@intel.com>
References: <20220717143801.189865-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220717143801.189865-1-qiang1.zhang@intel.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zqiang,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on paulmck-rcu/dev]
[also build test ERROR on linus/master v5.19-rc6 next-20220715]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Zqiang/rcu-tasks-Make-RCU-Tasks-Trace-checking-for-userspace-execution/20220717-223556
base:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev
config: hexagon-randconfig-r041-20220717 (https://download.01.org/0day-ci/archive/20220718/202207180246.5cKJdGrg-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 45067f8fbf61284839c739807c2da2e2505661eb)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/d078656cad783fefa6506b05e7dfd1ce43f23eb0
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Zqiang/rcu-tasks-Make-RCU-Tasks-Trace-checking-for-userspace-execution/20220717-223556
        git checkout d078656cad783fefa6506b05e7dfd1ce43f23eb0
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from kernel/rcu/tree.c:4638:
>> kernel/rcu/tree_plugin.h:979:3: error: call to undeclared function 'rcu_tasks_trace_qs'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                   rcu_tasks_trace_qs(current);
                   ^
   1 error generated.


vim +/rcu_tasks_trace_qs +979 kernel/rcu/tree_plugin.h

   959	
   960	/*
   961	 * Check to see if this CPU is in a non-context-switch quiescent state,
   962	 * namely user mode and idle loop.
   963	 */
   964	static void rcu_flavor_sched_clock_irq(int user)
   965	{
   966		if (user || rcu_is_cpu_rrupt_from_idle()) {
   967	
   968			/*
   969			 * Get here if this CPU took its interrupt from user
   970			 * mode or from the idle loop, and if this is not a
   971			 * nested interrupt.  In this case, the CPU is in
   972			 * a quiescent state, so note it.
   973			 *
   974			 * No memory barrier is required here because rcu_qs()
   975			 * references only CPU-local variables that other CPUs
   976			 * neither access nor modify, at least not while the
   977			 * corresponding CPU is online.
   978			 */
 > 979			rcu_tasks_trace_qs(current);
   980			rcu_qs();
   981		}
   982	}
   983	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
