Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28A9E53D8B9
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 00:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241648AbiFDWU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 18:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235155AbiFDWU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 18:20:56 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB15D36163
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 15:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654381255; x=1685917255;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Fwt2bbBsSNkIiHrIhMNlO4PtOFm2jVz2HfiSx4+G4XM=;
  b=cLNOQKwXhN0ISUxXHSslo/enxA9GZHIg2R+Yy+ZXGnfTy8+dR+pQ50Um
   SSEihAKdCX8Dop+pgidChnJcCxqtfhNbUdIs/Vj+yESSmU8OI1Q+LMBkb
   J0+bn8x7pLhoXMX2SUUzXcP/oN4+lqhTVJ4aVj1L+j+tSW65chN7043Wg
   zXEj4anMcQE/dHkNC7JvFnoorCnLMct20IN2hy11OlAndeHG6ka378CwW
   Jcw5McppXohPiAyhfOn/ky38gEq67P8FMuzS7YpcYFRNErIHVSM4DPaSx
   1belDF4pwBXLjBThSTtqOBZ0Q6jEJ3M5UF8UMGgkV5pyYgFbfw8V1zVcD
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10368"; a="301864553"
X-IronPort-AV: E=Sophos;i="5.91,278,1647327600"; 
   d="scan'208";a="301864553"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2022 15:20:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,278,1647327600"; 
   d="scan'208";a="583068626"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 04 Jun 2022 15:20:54 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nxc8b-000BFe-Rz;
        Sat, 04 Jun 2022 22:20:53 +0000
Date:   Sun, 5 Jun 2022 06:20:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [frederic-dynticks:rcu/context-tracking-v4 9/20] ld.lld: error:
 undefined symbol: ct_irq_enter
Message-ID: <202206050636.tuRU0MhR-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git rcu/context-tracking-v4
head:   77493b1db618c61dec140cbab830832f77203d69
commit: ede17b80373d0c3e886b3b4d9533f6c12cf1e799 [9/20] context_tracking: Take IRQ eqs entrypoints over RCU
config: x86_64-randconfig-a001 (https://download.01.org/0day-ci/archive/20220605/202206050636.tuRU0MhR-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0a90b72c432d70aae035727ece4ba80ce820f381)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git/commit/?id=ede17b80373d0c3e886b3b4d9533f6c12cf1e799
        git remote add frederic-dynticks https://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
        git fetch --no-tags frederic-dynticks rcu/context-tracking-v4
        git checkout ede17b80373d0c3e886b3b4d9533f6c12cf1e799
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   vmlinux.o: warning: objtool: do_syscall_64()+0x1a: call to static_key_count() leaves .noinstr.text section
   vmlinux.o: warning: objtool: do_int80_syscall_32()+0x26: call to static_key_count() leaves .noinstr.text section
   vmlinux.o: warning: objtool: __do_fast_syscall_32()+0x28: call to static_key_count() leaves .noinstr.text section
   vmlinux.o: warning: objtool: fixup_bad_iret()+0x21: call to memset() leaves .noinstr.text section
   vmlinux.o: warning: objtool: in_task_stack()+0xc: call to task_stack_page() leaves .noinstr.text section
   vmlinux.o: warning: objtool: in_entry_stack()+0x9: call to cpu_entry_stack() leaves .noinstr.text section
>> vmlinux.o: warning: objtool: irqentry_exit()+0x65: call to ct_irq_exit() leaves .noinstr.text section
>> ld.lld: error: undefined symbol: ct_irq_enter
   >>> referenced by softirq.c
   >>> softirq.o:(irq_enter) in archive kernel/built-in.a
--
>> ld.lld: error: undefined symbol: ct_irq_exit
   >>> referenced by softirq.c
   >>> softirq.o:(irq_exit) in archive kernel/built-in.a
   >>> referenced by common.c
   >>> entry/common.o:(irqentry_exit) in archive kernel/built-in.a
   >>> referenced by common.c
   >>> entry/common.o:(irqentry_exit) in archive kernel/built-in.a
--
>> ld.lld: error: undefined symbol: ct_irq_enter_irqson
   >>> referenced by printk.c
   >>> printk/printk.o:(console_unlock) in archive kernel/built-in.a
   >>> referenced by tick-broadcast-hrtimer.c
   >>> time/tick-broadcast-hrtimer.o:(bc_set_next) in archive kernel/built-in.a
   >>> referenced by trace_preemptirq.c
   >>> trace/trace_preemptirq.o:(trace_hardirqs_on) in archive kernel/built-in.a
   >>> referenced 19 more times
--
>> ld.lld: error: undefined symbol: ct_irq_exit_irqson
   >>> referenced by printk.c
   >>> printk/printk.o:(console_unlock) in archive kernel/built-in.a
   >>> referenced by tick-broadcast-hrtimer.c
   >>> time/tick-broadcast-hrtimer.o:(bc_set_next) in archive kernel/built-in.a
   >>> referenced by trace_preemptirq.c
   >>> trace/trace_preemptirq.o:(trace_hardirqs_on) in archive kernel/built-in.a
   >>> referenced 19 more times

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
