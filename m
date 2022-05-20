Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75BD052F06F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 18:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351531AbiETQUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 12:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbiETQUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 12:20:02 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA2E84A05;
        Fri, 20 May 2022 09:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653063599; x=1684599599;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xyoX3wJFV08KmJUKWtkfILCFbxxU1mCoQdXyEQyxFyM=;
  b=VvfLxkh5P69VrogfFXb8tkYBrKbI3Yn5b5qF8QwBgjW0TyCggqXdFwxd
   3nQYJYaYExG9dOvvooBaXsGRB4qL/BIsgCZ+2S+YqAWLlqTPovc+6BIF0
   AAmQKBuoFGKgJKMGUSf+RDRprMyMuqt8670yQVK/zi34ZJznZQnqkKb4W
   ErRCJgLBpxvk9C/8WmC2pRT0F3u8/rVm/MwB6WRsAVim1VKU40YaiV5Xj
   BbezH1IdLaGD9n7YiFd+wQJvqb9dlxQ6oyvy+1L56mLBJ3Nv44gEW+Qr4
   vQ7IsQclJkcOWg7uShuU4D2NTKk63inAgJT1fALNG7ZKzotolDiOalduV
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10353"; a="270237768"
X-IronPort-AV: E=Sophos;i="5.91,239,1647327600"; 
   d="scan'208";a="270237768"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 09:19:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,239,1647327600"; 
   d="scan'208";a="628238945"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 20 May 2022 09:19:52 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ns5Lz-0004uI-MF;
        Fri, 20 May 2022 16:19:51 +0000
Date:   Sat, 21 May 2022 00:19:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, rjw@rjwysocki.net,
        Oleg Nesterov <oleg@redhat.com>, mingo@kernel.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, mgorman@suse.de, bigeasy@linutronix.de,
        Will Deacon <will@kernel.org>, tj@kernel.org,
        linux-pm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, linux-ia64@vger.kernel.org,
        Robert OCallahan <roc@pernos.co>, Kyle Huey <khuey@pernos.co>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [PATCH 16/16] signal: Always call do_notify_parent_cldstop with
 siglock held
Message-ID: <202205210010.E4Hyn2kD-lkp@intel.com>
References: <20220518225355.784371-16-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220518225355.784371-16-ebiederm@xmission.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi "Eric,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on next-20220518]
[cannot apply to linux/master powerpc/next wireless-next/main wireless/main linus/master v5.18-rc7 v5.18-rc6 v5.18-rc5 v5.18-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Eric-W-Biederman/signal-alpha-Remove-unused-definition-of-TASK_REAL_PARENT/20220519-065947
base:    736ee37e2e8eed7fe48d0a37ee5a709514d478b3
config: parisc-randconfig-s032-20220519 (https://download.01.org/0day-ci/archive/20220521/202205210010.E4Hyn2kD-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/intel-lab-lkp/linux/commit/4b66a617bf6d095d33fe43e9dbcfdf2e0de9fb29
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Eric-W-Biederman/signal-alpha-Remove-unused-definition-of-TASK_REAL_PARENT/20220519-065947
        git checkout 4b66a617bf6d095d33fe43e9dbcfdf2e0de9fb29
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=parisc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   kernel/signal.c: note: in included file (through arch/parisc/include/uapi/asm/signal.h, arch/parisc/include/asm/signal.h, include/uapi/linux/signal.h, ...):
   include/uapi/asm-generic/signal-defs.h:83:29: sparse: sparse: multiple address spaces given
   kernel/signal.c:195:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:195:31: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:195:31: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:198:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:198:33: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:198:33: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:480:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:480:9: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:480:9: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:484:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:484:34: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:484:34: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:542:53: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct k_sigaction *ka @@     got struct k_sigaction [noderef] __rcu * @@
   kernel/signal.c:542:53: sparse:     expected struct k_sigaction *ka
   kernel/signal.c:542:53: sparse:     got struct k_sigaction [noderef] __rcu *
   include/uapi/asm-generic/signal-defs.h:83:29: sparse: sparse: multiple address spaces given
   kernel/signal.c:1261:9: sparse: sparse: no member 'ip' in struct pt_regs
   kernel/signal.c:1267:29: sparse: sparse: no member 'ip' in struct pt_regs
   kernel/signal.c:1267:29: sparse: sparse: cast from unknown type
   kernel/signal.c:1267:29: sparse: sparse: cannot dereference this type
   kernel/signal.c:1267:29: sparse: sparse: no member 'ip' in struct pt_regs
   kernel/signal.c:1267:29: sparse: sparse: cast from unknown type
   kernel/signal.c:1267:29: sparse: sparse: no member 'ip' in struct pt_regs
   kernel/signal.c:1267:29: sparse: sparse: cast from unknown type
   kernel/signal.c:1267:29: sparse: sparse: cannot dereference this type
   kernel/signal.c:1267:29: sparse: sparse: no member 'ip' in struct pt_regs
   kernel/signal.c:1267:29: sparse: sparse: cast from unknown type
   kernel/signal.c:1267:29: sparse: sparse: no member 'ip' in struct pt_regs
   kernel/signal.c:1267:29: sparse: sparse: cast from unknown type
   kernel/signal.c:1267:29: sparse: sparse: cannot dereference this type
   kernel/signal.c:1267:29: sparse: sparse: no member 'ip' in struct pt_regs
   kernel/signal.c:1267:29: sparse: sparse: cast from unknown type
   kernel/signal.c:1267:29: sparse: sparse: no member 'ip' in struct pt_regs
   kernel/signal.c:1267:29: sparse: sparse: cast from unknown type
   kernel/signal.c:1267:29: sparse: sparse: cannot dereference this type
   kernel/signal.c:1267:29: sparse: sparse: no member 'ip' in struct pt_regs
   kernel/signal.c:1267:29: sparse: sparse: cast from unknown type
   kernel/signal.c:1267:29: sparse: sparse: cannot dereference this type
   kernel/signal.c:1267:29: sparse: sparse: no member 'ip' in struct pt_regs
   kernel/signal.c:1267:29: sparse: sparse: cast from unknown type
   kernel/signal.c:1267:29: sparse: sparse: incompatible types for 'case' statement
   kernel/signal.c:1267:29: sparse: sparse: incompatible types for 'case' statement
   kernel/signal.c:1267:29: sparse: sparse: incompatible types for 'case' statement
   kernel/signal.c:1267:29: sparse: sparse: incompatible types for 'case' statement
   kernel/signal.c:1328:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:1328:9: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:1328:9: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:1329:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct k_sigaction *action @@     got struct k_sigaction [noderef] __rcu * @@
   kernel/signal.c:1329:16: sparse:     expected struct k_sigaction *action
   kernel/signal.c:1329:16: sparse:     got struct k_sigaction [noderef] __rcu *
   kernel/signal.c:1349:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:1349:34: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:1349:34: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:1938:36: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:1938:36: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:1938:36: sparse:     got struct spinlock [noderef] __rcu *
>> kernel/signal.c:2048:46: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct sighand_struct *m_sighand @@     got struct sighand_struct [noderef] __rcu *sighand @@
   kernel/signal.c:2048:46: sparse:     expected struct sighand_struct *m_sighand
   kernel/signal.c:2048:46: sparse:     got struct sighand_struct [noderef] __rcu *sighand
   kernel/signal.c:2057:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *parent @@     got struct task_struct [noderef] __rcu *real_parent @@
   kernel/signal.c:2057:24: sparse:     expected struct task_struct *parent
   kernel/signal.c:2057:24: sparse:     got struct task_struct [noderef] __rcu *real_parent
   kernel/signal.c:2087:21: sparse: sparse: incompatible types in comparison expression (different address spaces):
>> kernel/signal.c:2087:21: sparse:    struct task_struct [noderef] __rcu *
>> kernel/signal.c:2087:21: sparse:    struct task_struct *
>> kernel/signal.c:2117:40: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *parent @@     got struct task_struct [noderef] __rcu *real_parent @@
   kernel/signal.c:2117:40: sparse:     expected struct task_struct *parent
   kernel/signal.c:2117:40: sparse:     got struct task_struct [noderef] __rcu *real_parent
   kernel/signal.c:2119:46: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct sighand_struct *m_sighand @@     got struct sighand_struct [noderef] __rcu *sighand @@
   kernel/signal.c:2119:46: sparse:     expected struct sighand_struct *m_sighand
   kernel/signal.c:2119:46: sparse:     got struct sighand_struct [noderef] __rcu *sighand
>> kernel/signal.c:2120:50: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct sighand_struct *p_sighand @@     got struct sighand_struct [noderef] __rcu *sighand @@
   kernel/signal.c:2120:50: sparse:     expected struct sighand_struct *p_sighand
   kernel/signal.c:2120:50: sparse:     got struct sighand_struct [noderef] __rcu *sighand
>> kernel/signal.c:2125:58: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct sighand_struct *t_sighand @@     got struct sighand_struct [noderef] __rcu *sighand @@
   kernel/signal.c:2125:58: sparse:     expected struct sighand_struct *t_sighand
   kernel/signal.c:2125:58: sparse:     got struct sighand_struct [noderef] __rcu *sighand
   kernel/signal.c:2171:44: sparse: sparse: cast removes address space '__rcu' of expression
   kernel/signal.c:2190:65: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *tsk @@     got struct task_struct [noderef] __rcu *parent @@
   kernel/signal.c:2190:65: sparse:     expected struct task_struct *tsk
   kernel/signal.c:2190:65: sparse:     got struct task_struct [noderef] __rcu *parent
   kernel/signal.c:2191:40: sparse: sparse: cast removes address space '__rcu' of expression
   kernel/signal.c:2209:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sighand_struct *psig @@     got struct sighand_struct [noderef] __rcu *[noderef] __rcu sighand @@
   kernel/signal.c:2209:14: sparse:     expected struct sighand_struct *psig
   kernel/signal.c:2209:14: sparse:     got struct sighand_struct [noderef] __rcu *[noderef] __rcu sighand
   kernel/signal.c:2238:53: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected struct task_struct *t @@     got struct task_struct [noderef] __rcu *parent @@
   kernel/signal.c:2238:53: sparse:     expected struct task_struct *t
   kernel/signal.c:2238:53: sparse:     got struct task_struct [noderef] __rcu *parent
   kernel/signal.c:2239:34: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *parent @@     got struct task_struct [noderef] __rcu *parent @@
   kernel/signal.c:2239:34: sparse:     expected struct task_struct *parent
   kernel/signal.c:2239:34: sparse:     got struct task_struct [noderef] __rcu *parent
   kernel/signal.c:2269:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *parent @@     got struct task_struct [noderef] __rcu *parent @@
   kernel/signal.c:2269:24: sparse:     expected struct task_struct *parent
   kernel/signal.c:2269:24: sparse:     got struct task_struct [noderef] __rcu *parent
   kernel/signal.c:2272:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *parent @@     got struct task_struct [noderef] __rcu *real_parent @@
   kernel/signal.c:2272:24: sparse:     expected struct task_struct *parent
   kernel/signal.c:2272:24: sparse:     got struct task_struct [noderef] __rcu *real_parent
   kernel/signal.c:2307:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sighand_struct *sighand @@     got struct sighand_struct [noderef] __rcu *sighand @@
   kernel/signal.c:2307:17: sparse:     expected struct sighand_struct *sighand
   kernel/signal.c:2307:17: sparse:     got struct sighand_struct [noderef] __rcu *sighand
   kernel/signal.c:2341:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:2341:41: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:2341:41: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:2343:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:2343:39: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:2343:39: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:2428:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:2428:33: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:2428:33: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:2440:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:2440:31: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:2440:31: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:2479:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:2479:31: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:2479:31: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:2481:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:2481:33: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:2481:33: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:2584:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:2584:41: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:2584:41: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:2599:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:2599:33: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:2599:33: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:2656:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:2656:41: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:2656:41: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:2668:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:2668:33: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:2668:33: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:2726:49: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct sighand_struct *sighand @@     got struct sighand_struct [noderef] __rcu *sighand @@
   kernel/signal.c:2726:49: sparse:     expected struct sighand_struct *sighand
   kernel/signal.c:2726:49: sparse:     got struct sighand_struct [noderef] __rcu *sighand
   kernel/signal.c:3052:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:3052:27: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:3052:27: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:3081:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:3081:29: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:3081:29: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:3138:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:3138:27: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:3138:27: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:3140:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:3140:29: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:3140:29: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:3291:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:3291:31: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:3291:31: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:3294:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:3294:33: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:3294:33: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:3683:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:3683:27: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:3683:27: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:3695:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:3695:37: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:3695:37: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:3700:35: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:3700:35: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:3700:35: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:3705:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:3705:29: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:3705:29: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:4159:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:4159:31: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:4159:31: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:4171:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:4171:33: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:4171:33: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:4189:11: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct k_sigaction *k @@     got struct k_sigaction [noderef] __rcu * @@
   kernel/signal.c:4189:11: sparse:     expected struct k_sigaction *k
   kernel/signal.c:4189:11: sparse:     got struct k_sigaction [noderef] __rcu *
   kernel/signal.c:4191:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:4191:25: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:4191:25: sparse:     got struct spinlock [noderef] __rcu *

vim +2048 kernel/signal.c

  1934	
  1935	void sigqueue_free(struct sigqueue *q)
  1936	{
  1937		unsigned long flags;
> 1938		spinlock_t *lock = &current->sighand->siglock;
  1939	
  1940		BUG_ON(!(q->flags & SIGQUEUE_PREALLOC));
  1941		/*
  1942		 * We must hold ->siglock while testing q->list
  1943		 * to serialize with collect_signal() or with
  1944		 * __exit_signal()->flush_sigqueue().
  1945		 */
  1946		spin_lock_irqsave(lock, flags);
  1947		q->flags &= ~SIGQUEUE_PREALLOC;
  1948		/*
  1949		 * If it is queued it will be freed when dequeued,
  1950		 * like the "regular" sigqueue.
  1951		 */
  1952		if (!list_empty(&q->list))
  1953			q = NULL;
  1954		spin_unlock_irqrestore(lock, flags);
  1955	
  1956		if (q)
  1957			__sigqueue_free(q);
  1958	}
  1959	
  1960	int send_sigqueue(struct sigqueue *q, struct pid *pid, enum pid_type type)
  1961	{
  1962		int sig = q->info.si_signo;
  1963		struct sigpending *pending;
  1964		struct task_struct *t;
  1965		unsigned long flags;
  1966		int ret, result;
  1967	
  1968		BUG_ON(!(q->flags & SIGQUEUE_PREALLOC));
  1969	
  1970		ret = -1;
  1971		rcu_read_lock();
  1972		t = pid_task(pid, type);
  1973		if (!t || !likely(lock_task_sighand(t, &flags)))
  1974			goto ret;
  1975	
  1976		ret = 1; /* the signal is ignored */
  1977		result = TRACE_SIGNAL_IGNORED;
  1978		if (!prepare_signal(sig, t, false))
  1979			goto out;
  1980	
  1981		ret = 0;
  1982		if (unlikely(!list_empty(&q->list))) {
  1983			/*
  1984			 * If an SI_TIMER entry is already queue just increment
  1985			 * the overrun count.
  1986			 */
  1987			BUG_ON(q->info.si_code != SI_TIMER);
  1988			q->info.si_overrun++;
  1989			result = TRACE_SIGNAL_ALREADY_PENDING;
  1990			goto out;
  1991		}
  1992		q->info.si_overrun = 0;
  1993	
  1994		signalfd_notify(t, sig);
  1995		pending = (type != PIDTYPE_PID) ? &t->signal->shared_pending : &t->pending;
  1996		list_add_tail(&q->list, &pending->list);
  1997		sigaddset(&pending->signal, sig);
  1998		complete_signal(sig, t, type);
  1999		result = TRACE_SIGNAL_DELIVERED;
  2000	out:
  2001		trace_signal_generate(sig, &q->info, t, type != PIDTYPE_PID, result);
  2002		unlock_task_sighand(t, &flags);
  2003	ret:
  2004		rcu_read_unlock();
  2005		return ret;
  2006	}
  2007	
  2008	/**
  2009	 * lock_parents_siglocks - Take current, real_parent, and parent's siglock
  2010	 * @lock_tracer: The tracers siglock is needed.
  2011	 *
  2012	 * There is no natural ordering to these locks so they must be sorted
  2013	 * before being taken.
  2014	 *
  2015	 * There are two complicating factors here:
  2016	 * - The locks live in sighand and sighand can be arbitrarily shared
  2017	 * - parent and real_parent can change when current's siglock is unlocked.
  2018	 *
  2019	 * To deal with this first the all of the sighand pointers are
  2020	 * gathered under current's siglock, and the sighand pointers are
  2021	 * sorted.  As siglock lives inside of sighand this also sorts the
  2022	 * siglock's by address.
  2023	 *
  2024	 * Then the siglocks are taken in order dropping current's siglock if
  2025	 * necessary.
  2026	 *
  2027	 * Finally if parent and real_parent have not changed return.
  2028	 * If they either parent has changed drop their locks and try again.
  2029	 *
  2030	 * Changing sighand is an infrequent and somewhat expensive operation
  2031	 * (unshare or exec) and so even in the worst case this loop
  2032	 * should not loop too many times before all of the proper locks are
  2033	 * taken in order.
  2034	 *
  2035	 * CONTEXT:
  2036	 * Must be called with @current->sighand->siglock held
  2037	 *
  2038	 * RETURNS:
  2039	 * current's, real_parent's, and parent's siglock held.
  2040	 */
  2041	static void lock_parents_siglocks(bool lock_tracer)
  2042		__releases(&current->sighand->siglock)
  2043		__acquires(&current->sighand->siglock)
  2044		__acquires(&current->real_parent->sighand->siglock)
  2045		__acquires(&current->parent->sighand->siglock)
  2046	{
  2047		struct task_struct *me = current;
> 2048		struct sighand_struct *m_sighand = me->sighand;
  2049	
  2050		lockdep_assert_held(&m_sighand->siglock);
  2051	
  2052		rcu_read_lock();
  2053		for (;;) {
  2054			struct task_struct *parent, *tracer;
  2055			struct sighand_struct *p_sighand, *t_sighand, *s1, *s2, *s3;
  2056	
  2057			parent = me->real_parent;
  2058			tracer = ptrace_parent(me);
  2059			if (!tracer || !lock_tracer)
  2060				tracer = parent;
  2061	
  2062			p_sighand = rcu_dereference(parent->sighand);
  2063			t_sighand = rcu_dereference(tracer->sighand);
  2064	
  2065			/* Sort the sighands so that s1 >= s2 >= s3 */
  2066			s1 = m_sighand;
  2067			s2 = p_sighand;
  2068			s3 = t_sighand;
  2069			if (s1 > s2)
  2070				swap(s1, s2);
  2071			if (s1 > s3)
  2072				swap(s1, s3);
  2073			if (s2 > s3)
  2074				swap(s2, s3);
  2075	
  2076			/* Take the locks in order */
  2077			if (s1 != m_sighand) {
  2078				spin_unlock(&m_sighand->siglock);
  2079				spin_lock(&s1->siglock);
  2080			}
  2081			if (s1 != s2)
  2082				spin_lock_nested(&s2->siglock, 1);
  2083			if (s2 != s3)
  2084				spin_lock_nested(&s3->siglock, 2);
  2085	
  2086			/* Verify the proper locks are held */
> 2087			if (likely((s1 == m_sighand) ||
  2088				   ((me->real_parent == parent) &&
  2089				    (me->parent == tracer) &&
  2090				    (parent->sighand == p_sighand) &&
  2091				    (tracer->sighand == t_sighand)))) {
  2092				break;
  2093			}
  2094	
  2095			/* Drop all but current's siglock */
  2096			if (p_sighand != m_sighand)
  2097				spin_unlock(&p_sighand->siglock);
  2098			if (t_sighand != p_sighand)
  2099				spin_unlock(&t_sighand->siglock);
  2100	
  2101			/*
  2102			 * Since [pt]_sighand will likely change if we go
  2103			 * around, and m_sighand is the only one held, make sure
  2104			 * it is subclass-0, since the above 's1 != m_sighand'
  2105			 * clause very much relies on that.
  2106			 */
  2107			lock_set_subclass(&m_sighand->siglock.dep_map, 0, _RET_IP_);
  2108		}
  2109		rcu_read_unlock();
  2110	}
  2111	
  2112	static void unlock_parents_siglocks(bool unlock_tracer)
  2113		__releases(&current->real_parent->sighand->siglock)
  2114		__releases(&current->parent->sighand->siglock)
  2115	{
  2116		struct task_struct *me = current;
> 2117		struct task_struct *parent = me->real_parent;
  2118		struct task_struct *tracer = ptrace_parent(me);
  2119		struct sighand_struct *m_sighand = me->sighand;
> 2120		struct sighand_struct *p_sighand = parent->sighand;
  2121	
  2122		if (p_sighand != m_sighand)
  2123			spin_unlock(&p_sighand->siglock);
  2124		if (tracer && unlock_tracer) {
> 2125			struct sighand_struct *t_sighand = tracer->sighand;
  2126			if (t_sighand != p_sighand)
  2127				spin_unlock(&t_sighand->siglock);
  2128		}
  2129	}
  2130	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
