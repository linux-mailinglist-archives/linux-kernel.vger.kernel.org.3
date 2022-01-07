Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB9774873EC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 09:10:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235985AbiAGIKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 03:10:47 -0500
Received: from mga06.intel.com ([134.134.136.31]:34405 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235551AbiAGIKq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 03:10:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641543046; x=1673079046;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rJHQ2EXQ32CSxR4GIfL+NqZalhNUeXEkqCdnFMiF+g8=;
  b=hAg0799LhFfUOg+noHmAqAiDKGt7bVd822TqVLYSfYp0MXJIiA5rAstO
   N91LkJtCqYTnBC29/rL9rjB1wp5uQsOwORvy8wCRhKZIBwEfiK5DTwzkr
   QSHtuHEyKr5yZWnBWKtpbQ6N23RDRXspdnMZTDLquvtoABRKVan0FDLlm
   AAddQVAudVZwuDLe0iYDWQYpSqwOo0awYWnQzW7fnb7EmjxSNiJigJ1Ri
   lT+1NYcy7GFnzsIIVQhui67aBh2I3MJdf7UWTvyUtILANEO6gJ/FA1133
   hsDaP5UgqqjlWfGbCS0nS4Brmlm6EuB55pTfCRkKMJCzi6YJJFhrBeQbi
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10219"; a="303574585"
X-IronPort-AV: E=Sophos;i="5.88,269,1635231600"; 
   d="scan'208";a="303574585"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 00:10:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,269,1635231600"; 
   d="scan'208";a="621826259"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 07 Jan 2022 00:10:45 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n5kKi-000IRH-Gt; Fri, 07 Jan 2022 08:10:44 +0000
Date:   Fri, 7 Jan 2022 16:09:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:paulmck/linux-rcu/dev 51/53]
 kernel/time/tick-sched.c:1455:6: warning: no previous prototype for
 'tick_setup_sched_timer_dump'
Message-ID: <202201071623.rIzxzZ6C-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block paulmck/linux-rcu/dev
head:   56b8a9dc5e8aa4d625a09ce87015016ae339d44d
commit: feba9f855e1f9231392df9e7c2ba94e2fe1bc822 [51/53] EXP timers: Debugging for last-resort jiffies update
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20220107/202201071623.rIzxzZ6C-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/feba9f855e1f9231392df9e7c2ba94e2fe1bc822
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block paulmck/linux-rcu/dev
        git checkout feba9f855e1f9231392df9e7c2ba94e2fe1bc822
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=um SUBARCH=i386 SHELL=/bin/bash kernel/time/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> kernel/time/tick-sched.c:1455:6: warning: no previous prototype for 'tick_setup_sched_timer_dump' [-Wmissing-prototypes]
    1455 | void tick_setup_sched_timer_dump(void)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/tick_setup_sched_timer_dump +1455 kernel/time/tick-sched.c

  1454	
> 1455	void tick_setup_sched_timer_dump(void)
  1456	{
  1457		int cpu;
  1458		int j = jiffies;
  1459	
  1460		pr_alert("%s state", __func__);
  1461		for_each_possible_cpu(cpu)
  1462			pr_cont(" j/c %x/%d %c",
  1463				(int)(j - per_cpu(tick_setup_sched_timer_jiffies, cpu)) & 0xfff,
  1464				per_cpu(tick_setup_sched_timer_jiffies_count, cpu),
  1465				".H"[per_cpu(tick_setup_sched_timer_help_needed, cpu)]);
  1466		pr_cont("\n");
  1467	}
  1468	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
