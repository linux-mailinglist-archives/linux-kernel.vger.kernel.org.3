Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA51557E7B7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 21:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234830AbiGVT6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 15:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233440AbiGVT6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 15:58:39 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74BE1A025A
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 12:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658519918; x=1690055918;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=I/9zIYJGS9Ulm/gqa7l2eor0Zj/xAa+Qcql4eMR2IG8=;
  b=G2n3l+VmwZKoHQiHUAjPBhOf2ZfUXSw9GvdlYiBkY+5m/Qv8SAN4VTxg
   ikAWZ2EIpeSE9iQZZME1AdcOK8fCqcxrglQa7R20CRJ07+jJAOOKaMCFB
   Ycl+6fdpp2fMaJsd/S5wkGRfUXwZR43c5lPW7u9cVd0k1g0+HHHRgC4UT
   dOyH7QYsTjW4y6+blwNXjChREfgTtCjTJ81zX6bS0Ov/Q/+oHIWpHDON1
   ydH+XYq+J2WfwGBVt4hVfgtaUS1hyf3nufTR163hCnbCUvXieVV5XIlxB
   XROlqIzo5s48/XAmwOCDd7eHEhLQXkopymaVtAyFZ19IJmLWYLwloYLrU
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10416"; a="287407885"
X-IronPort-AV: E=Sophos;i="5.93,186,1654585200"; 
   d="scan'208";a="287407885"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2022 12:58:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,186,1654585200"; 
   d="scan'208";a="626688493"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 22 Jul 2022 12:58:36 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oEynD-0001lx-2M;
        Fri, 22 Jul 2022 19:58:35 +0000
Date:   Sat, 23 Jul 2022 03:57:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [peterz-queue:sched/idle 15/37] vmlinux.o: warning: objtool:
 rcu_idle_exit+0x22: call to ftrace_likely_update() leaves .noinstr.text
 section
Message-ID: <202207230315.jSthR6sK-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/idle
head:   84fd27c4b216dc4083d0a62c61d4c48205ad0a28
commit: af156b88b9c17b196b6034fd9df9737c42cd4c09 [15/37] rcu: Fix rcu_idle_exit()
config: x86_64-randconfig-a011-20220718 (https://download.01.org/0day-ci/archive/20220723/202207230315.jSthR6sK-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=af156b88b9c17b196b6034fd9df9737c42cd4c09
        git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
        git fetch --no-tags peterz-queue sched/idle
        git checkout af156b88b9c17b196b6034fd9df9737c42cd4c09
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   vmlinux.o: warning: objtool: __wrgsbase_inactive+0x27: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: __rdgsbase_inactive+0x26: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: fixup_bad_iret+0x72: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: noist_exc_debug+0x3c: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: exc_nmi+0x31: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: poke_int3_handler+0x3e: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: mce_check_crashing_cpu+0x2c: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: mce_start+0x66: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: do_machine_check+0x4a: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: exc_machine_check+0x4e: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: rcu_dynticks_eqs_enter+0x31: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: rcu_dynticks_eqs_exit+0x2f: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: rcu_eqs_exit.constprop.0+0x2a: call to ftrace_likely_update() leaves .noinstr.text section
>> vmlinux.o: warning: objtool: rcu_idle_exit+0x22: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: rcu_eqs_enter.constprop.0+0x43: call to ftrace_likely_update() leaves .noinstr.text section
>> vmlinux.o: warning: objtool: rcu_idle_enter+0x22: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: rcu_irq_exit+0x22: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: rcu_nmi_enter+0x31: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: rcu_irq_enter+0x22: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: irqentry_nmi_enter+0x48: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: irqentry_nmi_exit+0x43: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: enter_from_user_mode+0x57: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: syscall_enter_from_user_mode+0x5c: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: syscall_enter_from_user_mode_prepare+0x57: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: irqentry_enter_from_user_mode+0x57: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: irqentry_exit+0x29: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: acpi_idle_enter_bm+0x8b: call to acpi_idle_do_entry() leaves .noinstr.text section
   vmlinux.o: warning: objtool: acpi_idle_enter_s2idle+0x7c: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: acpi_idle_enter+0x5e: call to ftrace_likely_update() leaves .noinstr.text section


objdump-func vmlinux.o rcu_idle_exit:
0000 0000000000004e50 <rcu_idle_exit>:
0000     4e50:	8b 05 00 00 00 00    	mov    0x0(%rip),%eax        # 4e56 <rcu_idle_exit+0x6>	4e52: R_X86_64_PC32	debug_locks-0x4
0006     4e56:	85 c0                	test   %eax,%eax
0008     4e58:	74 0b                	je     4e65 <rcu_idle_exit+0x15>
000a     4e5a:	65 8b 05 00 00 00 00 	mov    %gs:0x0(%rip),%eax        # 4e61 <rcu_idle_exit+0x11>	4e5d: R_X86_64_PC32	lockdep_recursion-0x4
0011     4e61:	85 c0                	test   %eax,%eax
0013     4e63:	74 29                	je     4e8e <rcu_idle_exit+0x3e>
0015     4e65:	31 f6                	xor    %esi,%esi
0017     4e67:	31 c9                	xor    %ecx,%ecx
0019     4e69:	31 d2                	xor    %edx,%edx
001b     4e6b:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	4e6e: R_X86_64_32S	_ftrace_annotated_branch+0x35df0
0022     4e72:	e8 00 00 00 00       	call   4e77 <rcu_idle_exit+0x27>	4e73: R_X86_64_PLT32	ftrace_likely_update-0x4
0027     4e77:	31 f6                	xor    %esi,%esi
0029     4e79:	31 c9                	xor    %ecx,%ecx
002b     4e7b:	31 d2                	xor    %edx,%edx
002d     4e7d:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	4e80: R_X86_64_32S	_ftrace_annotated_branch+0x35dc0
0034     4e84:	e8 00 00 00 00       	call   4e89 <rcu_idle_exit+0x39>	4e85: R_X86_64_PLT32	ftrace_likely_update-0x4
0039     4e89:	e9 d2 fd ff ff       	jmp    4c60 <rcu_eqs_exit.constprop.0>
003e     4e8e:	65 8b 05 00 00 00 00 	mov    %gs:0x0(%rip),%eax        # 4e95 <rcu_idle_exit+0x45>	4e91: R_X86_64_PC32	hardirqs_enabled-0x4
0045     4e95:	85 c0                	test   %eax,%eax
0047     4e97:	74 cc                	je     4e65 <rcu_idle_exit+0x15>
0049     4e99:	31 c9                	xor    %ecx,%ecx
004b     4e9b:	31 d2                	xor    %edx,%edx
004d     4e9d:	be 01 00 00 00       	mov    $0x1,%esi
0052     4ea2:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	4ea5: R_X86_64_32S	_ftrace_annotated_branch+0x35df0
0059     4ea9:	e8 00 00 00 00       	call   4eae <rcu_idle_exit+0x5e>	4eaa: R_X86_64_PLT32	ftrace_likely_update-0x4
005e     4eae:	90                   	nop
005f     4eaf:	0f 0b                	ud2    
0061     4eb1:	90                   	nop
0062     4eb2:	be 01 00 00 00       	mov    $0x1,%esi
0067     4eb7:	eb c0                	jmp    4e79 <rcu_idle_exit+0x29>
0069     4eb9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
