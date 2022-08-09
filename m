Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9CAA58D399
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 08:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236500AbiHIGNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 02:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbiHIGNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 02:13:45 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38FFFCE0D
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 23:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660025624; x=1691561624;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=PloXNkWjL/hVy6Ax356sEdGlcR52d+O5OuA02rByTAI=;
  b=Yzux7renqbcHSCorx5SvUuOJRFl59mvW519ZO0WO7g37UXh0IvOP+k0h
   m6k2EHl0nRXmsrTxk/JVgF6fKJtrDm5s0cOwke8E2K866MkuO5MfMaaH/
   V3Nq6S1rpyR20TH4gLapUF0nSgqJgUawvQb4pV1V07rCojLiYFQFtdFUJ
   A6ifumeiTNdqCrBFR5lSsjhAMfbP7x13+XMTQ/Q6C4ipW29s3wGSPWIO0
   DgAkMLCzYg6cYAGWVotUWcQMOLEz2+4zvQ6uSWBmHpvalVJ9oQxsGaczw
   BKaGgKWfLyirhOW7K6N/Msu54kvU/8CwnAlM+H6cHMEM+1JRpQl35f9aw
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10433"; a="354765561"
X-IronPort-AV: E=Sophos;i="5.93,223,1654585200"; 
   d="scan'208";a="354765561"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 23:13:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,223,1654585200"; 
   d="scan'208";a="633206548"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 08 Aug 2022 23:13:42 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oLIUo-000MnR-0a;
        Tue, 09 Aug 2022 06:13:42 +0000
Date:   Tue, 9 Aug 2022 14:13:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [peterz-queue:sched/idle 25/37] vmlinux.o: warning: objtool:
 cpu_idle_poll.isra.0+0x63: call to tick_check_broadcast_expired() leaves
 .noinstr.text section
Message-ID: <202208091414.YahWDXwt-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/idle
head:   769b3ef979a1016d45e34b71df278f51ae32271d
commit: 7bc2c865a4d3abf5fd0e71c72a459d8e88d33128 [25/37] cpuidle,sched: Remove annotations from TIF_{POLLING_NRFLAG,NEED_RESCHED}
config: x86_64-randconfig-a002-20220718 (https://download.01.org/0day-ci/archive/20220809/202208091414.YahWDXwt-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=7bc2c865a4d3abf5fd0e71c72a459d8e88d33128
        git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
        git fetch --no-tags peterz-queue sched/idle
        git checkout 7bc2c865a4d3abf5fd0e71c72a459d8e88d33128
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   vmlinux.o: warning: objtool: acpi_idle_enter_s2idle+0x69: call to wbinvd() leaves .noinstr.text section
   vmlinux.o: warning: objtool: acpi_idle_enter+0x62: call to wbinvd() leaves .noinstr.text section
   vmlinux.o: warning: objtool: default_idle+0x4: call to mds_idle_clear_cpu_buffers() leaves .noinstr.text section
   vmlinux.o: warning: objtool: mwait_idle+0x39: call to __monitor.constprop.0() leaves .noinstr.text section
   vmlinux.o: warning: objtool: acpi_processor_ffh_cstate_enter+0x58: call to __monitor.constprop.0() leaves .noinstr.text section
>> vmlinux.o: warning: objtool: cpu_idle_poll.isra.0+0x63: call to tick_check_broadcast_expired() leaves .noinstr.text section
   vmlinux.o: warning: objtool: intel_idle_ibrs+0x12: call to sched_smt_active() leaves .noinstr.text section
   vmlinux.o: warning: objtool: intel_idle_s2idle+0x67: call to __monitor.constprop.0() leaves .noinstr.text section
   vmlinux.o: warning: objtool: intel_idle_irq+0x6d: call to __monitor.constprop.0() leaves .noinstr.text section
   vmlinux.o: warning: objtool: intel_idle+0x6c: call to __monitor.constprop.0() leaves .noinstr.text section
   vmlinux.o: warning: objtool: acpi_safe_halt+0xf: call to mds_idle_clear_cpu_buffers() leaves .noinstr.text section
   vmlinux.o: warning: objtool: io_idle+0x3: call to __inb.isra.0() leaves .noinstr.text section


objdump-func vmlinux.o cpu_idle_poll.isra.0:
0000 000000000000010c <cpu_idle_poll.isra.0>:
0000  10c:	53                   	push   %rbx
0001  10d:	90                   	nop
0002  10e:	31 ff                	xor    %edi,%edi
0004  110:	e8 00 00 00 00       	call   115 <cpu_idle_poll.isra.0+0x9>	111: R_X86_64_PC32	.text+0x14abf6
0009  115:	e8 00 00 00 00       	call   11a <cpu_idle_poll.isra.0+0xe>	116: R_X86_64_PLT32	stop_critical_timings-0x4
000e  11a:	83 3d 00 00 00 00 00 	cmpl   $0x0,0x0(%rip)        # 121 <cpu_idle_poll.isra.0+0x15>	11c: R_X86_64_PC32	debug_locks-0x5
0015  121:	74 18                	je     13b <cpu_idle_poll.isra.0+0x2f>
0017  123:	8b 05 00 00 00 00    	mov    0x0(%rip),%eax        # 129 <cpu_idle_poll.isra.0+0x1d>	125: R_X86_64_PC32	lockdep_recursion-0x4
001d  129:	85 c0                	test   %eax,%eax
001f  12b:	75 0e                	jne    13b <cpu_idle_poll.isra.0+0x2f>
0021  12d:	8b 05 00 00 00 00    	mov    0x0(%rip),%eax        # 133 <cpu_idle_poll.isra.0+0x27>	12f: R_X86_64_PC32	hardirqs_enabled-0x4
0027  133:	85 c0                	test   %eax,%eax
0029  135:	74 04                	je     13b <cpu_idle_poll.isra.0+0x2f>
002b  137:	90                   	nop
002c  138:	0f 0b                	ud2    
002e  13a:	90                   	nop
002f  13b:	e8 00 00 00 00       	call   140 <cpu_idle_poll.isra.0+0x34>	13c: R_X86_64_PLT32	trace_hardirqs_on_prepare-0x4
0034  140:	e8 00 00 00 00       	call   145 <cpu_idle_poll.isra.0+0x39>	141: R_X86_64_PLT32	lockdep_hardirqs_on_prepare-0x4
0039  145:	90                   	nop
003a  146:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	149: R_X86_64_32S	.cpuidle.text+0x13b
0041  14d:	e8 00 00 00 00       	call   152 <cpu_idle_poll.isra.0+0x46>	14e: R_X86_64_PLT32	lockdep_hardirqs_on-0x4
0046  152:	fb                   	sti    
0047  153:	48 8b 1c 25 00 00 00 00 	mov    0x0,%rbx	157: R_X86_64_32S	current_task
004f  15b:	48 8b 03             	mov    (%rbx),%rax
0052  15e:	a8 08                	test   $0x8,%al
0054  160:	75 16                	jne    178 <cpu_idle_poll.isra.0+0x6c>
0056  162:	83 3d 00 00 00 00 00 	cmpl   $0x0,0x0(%rip)        # 169 <cpu_idle_poll.isra.0+0x5d>	164: R_X86_64_PC32	.data..read_mostly+0x2627
005d  169:	74 04                	je     16f <cpu_idle_poll.isra.0+0x63>
005f  16b:	f3 90                	pause  
0061  16d:	eb ec                	jmp    15b <cpu_idle_poll.isra.0+0x4f>
0063  16f:	e8 00 00 00 00       	call   174 <cpu_idle_poll.isra.0+0x68>	170: R_X86_64_PC32	.text+0x14730f
0068  174:	85 c0                	test   %eax,%eax
006a  176:	75 f3                	jne    16b <cpu_idle_poll.isra.0+0x5f>
006c  178:	fa                   	cli    
006d  179:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	17c: R_X86_64_32S	.cpuidle.text+0x178
0074  180:	e8 00 00 00 00       	call   185 <cpu_idle_poll.isra.0+0x79>	181: R_X86_64_PLT32	lockdep_hardirqs_off-0x4
0079  185:	90                   	nop
007a  186:	e8 00 00 00 00       	call   18b <cpu_idle_poll.isra.0+0x7f>	187: R_X86_64_PLT32	start_critical_timings-0x4
007f  18b:	83 cf ff             	or     $0xffffffff,%edi
0082  18e:	e8 00 00 00 00       	call   193 <cpu_idle_poll.isra.0+0x87>	18f: R_X86_64_PC32	.text+0x14abf6
0087  193:	e8 00 00 00 00       	call   198 <cpu_idle_poll.isra.0+0x8c>	194: R_X86_64_PLT32	trace_hardirqs_on-0x4
008c  198:	fb                   	sti    
008d  199:	90                   	nop
008e  19a:	5b                   	pop    %rbx
008f  19b:	31 c0                	xor    %eax,%eax
0091  19d:	89 c7                	mov    %eax,%edi
0093  19f:	c3                   	ret    

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
