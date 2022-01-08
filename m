Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C189D48858C
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 20:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232107AbiAHTQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 14:16:08 -0500
Received: from mga06.intel.com ([134.134.136.31]:9504 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230409AbiAHTQH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 14:16:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641669367; x=1673205367;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7/yNwRjBuPqq8LiFXACSCkIrACXXcME5E1K+Bsdj5PA=;
  b=NLTvm5ZaCRI6LEkJ9ikAHOITXMg6PuWcb/aTDc+O7tq1NW1hBp48q5jx
   Ryh/mVSncMn9sKyd6zPeSX5+/MPmi7tBDV89+jnPomk+lrLVaJXB0p98t
   bdIQhrUr3Ta7A2jG94ekY/nhtKLRRpXo4QsD4Vu8npv8RIXcatTkzJOJv
   LUY/CSGGSHfs359XmEdfIOxS6QE80TfVK9u970Bo1DQ7cL3x8To6JivdI
   WqOvrd7eZcao1Ss6Z5A9pq/v1ZvCVn//In//9YLRhsLIlqIY7tF11fOwi
   OUg8Z8aI9+/qPrgmRT8Uz4V2Yi+DwHkDieO4EYy8LAVjt+uMhAMjDHS9d
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10221"; a="303777170"
X-IronPort-AV: E=Sophos;i="5.88,273,1635231600"; 
   d="scan'208";a="303777170"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2022 11:16:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,273,1635231600"; 
   d="scan'208";a="514212197"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 08 Jan 2022 11:16:06 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n6HCA-0000xG-0s; Sat, 08 Jan 2022 19:16:06 +0000
Date:   Sun, 9 Jan 2022 03:15:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:paulmck/linux-rcu/dev 50/50]
 kernel/time/timer.c:1774:1: sparse: sparse: symbol
 '__pcpu_scope_tick_setup_sched_timer_help_needed' was not declared. Should
 it be static?
Message-ID: <202201090357.zengylDN-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block paulmck/linux-rcu/dev
head:   d0f29964f08485944aa4c850fbedc740ce216ff9
commit: d0f29964f08485944aa4c850fbedc740ce216ff9 [50/50] EXP timers: Non-nohz_full last-resort jiffies update on IRQ entry
config: i386-randconfig-s001-20220107 (https://download.01.org/0day-ci/archive/20220109/202201090357.zengylDN-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/ammarfaizi2/linux-block/commit/d0f29964f08485944aa4c850fbedc740ce216ff9
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block paulmck/linux-rcu/dev
        git checkout d0f29964f08485944aa4c850fbedc740ce216ff9
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash kernel/time/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> kernel/time/timer.c:1774:1: sparse: sparse: symbol '__pcpu_scope_tick_setup_sched_timer_help_needed' was not declared. Should it be static?

vim +/__pcpu_scope_tick_setup_sched_timer_help_needed +1774 kernel/time/timer.c

  1771	
  1772	static DEFINE_PER_CPU(unsigned long, tick_setup_sched_timer_jiffies);
  1773	static DEFINE_PER_CPU(int, tick_setup_sched_timer_jiffies_count);
> 1774	DEFINE_PER_CPU(bool, tick_setup_sched_timer_help_needed);
  1775	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
