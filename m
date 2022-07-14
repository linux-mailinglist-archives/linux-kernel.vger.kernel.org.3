Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7396F574ECF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 15:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239709AbiGNNPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 09:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239729AbiGNNPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 09:15:22 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2AE349B7B
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 06:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657804521; x=1689340521;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4U5I2ex4OwxZ/BuD3pYaRT1dyPT5Hq50fxa3/H/Z9DQ=;
  b=huovy/6J99Yy4Y5eItPMaTiOWHulC55NY/svcZtu+4hAAkraQKmwPeJT
   NOIHBPwVHYJAu7aAS1bTR5tVaEsFk9FO/ePqfVBIu5EykTUAcivT69e+X
   NeffxnaEOED/aH2VpRxhpk60YHrWT0986q5cPURmTlqyWk5UUpMQS3elO
   wH+BstLy46HsVXmBLnrg3jK1AQvCdM73k4oXewW0pdougoet+mEOcbYkG
   1b+DKa6zX3r+Ce6aYS9oJwlK3pCSJeWclFozskk4Rs5re17I4jmku0o+E
   JT2sc+t61BqWamlSrP/wEfy0ZgOaMZdLczxS78ZdicACGJ/AovAGtJS+C
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10407"; a="347187321"
X-IronPort-AV: E=Sophos;i="5.92,271,1650956400"; 
   d="scan'208";a="347187321"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 06:15:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,271,1650956400"; 
   d="scan'208";a="623408378"
Received: from lkp-server01.sh.intel.com (HELO fd2c14d642b4) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 14 Jul 2022 06:15:19 -0700
Received: from kbuild by fd2c14d642b4 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oBygZ-0000h7-04;
        Thu, 14 Jul 2022 13:15:19 +0000
Date:   Thu, 14 Jul 2022 21:14:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     kbuild-all@lists.01.org, Nicholas Piggin <npiggin@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "linux-kernel @ vger . kernel . org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 07/12] locking/qspinlock: remove arch
 qspinlock_paravirt.h includes
Message-ID: <202207142142.cpBOsrfO-lkp@intel.com>
References: <20220713070704.308394-8-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220713070704.308394-8-npiggin@gmail.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicholas,

I love your patch! Perhaps something to improve:

[auto build test WARNING on tip/locking/core]
[also build test WARNING on tip/x86/core powerpc/next linus/master v5.19-rc6 next-20220714]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Nicholas-Piggin/locking-qspinlock-simplify-code-generation/20220713-151009
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git eae6d58d67d9739be5f7ae2dbead1d0ef6528243
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220714/202207142142.cpBOsrfO-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/87679eeea9f1939c252d16df3ac6a01bf9daaa60
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Nicholas-Piggin/locking-qspinlock-simplify-code-generation/20220713-151009
        git checkout 87679eeea9f1939c252d16df3ac6a01bf9daaa60
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash kernel/locking/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from kernel/locking/qspinlock.c:29:
   kernel/locking/qspinlock_stat.h:36:9: warning: no previous prototype for 'lockevent_read' [-Wmissing-prototypes]
      36 | ssize_t lockevent_read(struct file *file, char __user *user_buf,
         |         ^~~~~~~~~~~~~~
   kernel/locking/qspinlock.c:705:1: warning: no previous prototype for '__pv_queued_spin_unlock_slowpath' [-Wmissing-prototypes]
     705 | __pv_queued_spin_unlock_slowpath(struct qspinlock *lock, u8 locked)
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> kernel/locking/qspinlock.c:749:16: warning: no previous prototype for '__pv_queued_spin_unlock' [-Wmissing-prototypes]
     749 | __visible void __pv_queued_spin_unlock(struct qspinlock *lock)
         |                ^~~~~~~~~~~~~~~~~~~~~~~


vim +/__pv_queued_spin_unlock +749 kernel/locking/qspinlock.c

91668ee1ed703d Nicholas Piggin 2022-07-13  747  
91668ee1ed703d Nicholas Piggin 2022-07-13  748  #ifndef __pv_queued_spin_unlock
91668ee1ed703d Nicholas Piggin 2022-07-13 @749  __visible void __pv_queued_spin_unlock(struct qspinlock *lock)
91668ee1ed703d Nicholas Piggin 2022-07-13  750  {
91668ee1ed703d Nicholas Piggin 2022-07-13  751  	u8 locked;
91668ee1ed703d Nicholas Piggin 2022-07-13  752  
91668ee1ed703d Nicholas Piggin 2022-07-13  753  	/*
91668ee1ed703d Nicholas Piggin 2022-07-13  754  	 * We must not unlock if SLOW, because in that case we must first
91668ee1ed703d Nicholas Piggin 2022-07-13  755  	 * unhash. Otherwise it would be possible to have multiple @lock
91668ee1ed703d Nicholas Piggin 2022-07-13  756  	 * entries, which would be BAD.
91668ee1ed703d Nicholas Piggin 2022-07-13  757  	 */
91668ee1ed703d Nicholas Piggin 2022-07-13  758  	locked = cmpxchg_release(&lock->locked, _Q_LOCKED_VAL, 0);
91668ee1ed703d Nicholas Piggin 2022-07-13  759  	if (likely(locked == _Q_LOCKED_VAL))
91668ee1ed703d Nicholas Piggin 2022-07-13  760  		return;
91668ee1ed703d Nicholas Piggin 2022-07-13  761  
91668ee1ed703d Nicholas Piggin 2022-07-13  762  	__pv_queued_spin_unlock_slowpath(lock, locked);
91668ee1ed703d Nicholas Piggin 2022-07-13  763  }
87679eeea9f193 Nicholas Piggin 2022-07-13  764  EXPORT_SYMBOL(__pv_queued_spin_unlock);
91668ee1ed703d Nicholas Piggin 2022-07-13  765  #endif
91668ee1ed703d Nicholas Piggin 2022-07-13  766  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
