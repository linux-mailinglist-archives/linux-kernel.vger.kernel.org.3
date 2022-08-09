Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E817658D1B2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 03:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244631AbiHIBTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 21:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236936AbiHIBTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 21:19:42 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED697113E
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 18:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660007981; x=1691543981;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2unbxtmKI3HOA32xe3/Q22QlnOEq5I5VFoL2Xtjdzdo=;
  b=HtVsHQ9T0I9Q+2vnZLOR2UITg9UNAZbd93WK9ISXqbM3cDx3xJ19OJCy
   qizRO/fYRBMC1qvK9UluO+MI7r+Y1Uqs/57x70SB1PJp2Vh3QSlw0cx37
   eWpaB8T7R7D4bM9p+z7XUWRdUO227a+bS1t697Pak274+OXghuEIdia0s
   mj8uMN2O71lkjtPFFc/xBmtv/IOv86jgaBm4whdsF+RXpiidELqDfbL5R
   o6oJ7VKPA/R3h9tIAL3XjuaRqyvSMHm8YmnFgoAw0VESs9HdGuHSFaunG
   kGxKNwjGwhrgWmjd5db2iSUnhzXnnbYn8Z5xPEwaX7k09uLLyzacQ6SbF
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10433"; a="277662036"
X-IronPort-AV: E=Sophos;i="5.93,223,1654585200"; 
   d="scan'208";a="277662036"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 18:19:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,223,1654585200"; 
   d="scan'208";a="932290779"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 08 Aug 2022 18:19:37 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oLDuC-000MdX-2V;
        Tue, 09 Aug 2022 01:19:36 +0000
Date:   Tue, 9 Aug 2022 09:18:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [peterz-queue:sched/idle 18/37] vmlinux.o: warning: objtool:
 intel_idle_ibrs+0x14: call to sched_smt_active() leaves .noinstr.text
 section
Message-ID: <202208090943.FbDovn86-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/idle
head:   769b3ef979a1016d45e34b71df278f51ae32271d
commit: 3aa38daa6591ae8d2c51b06295f239b1d1458b93 [18/37] objtool/idle: Validate __cpuidle code as noinstr
config: x86_64-randconfig-a002-20220718 (https://download.01.org/0day-ci/archive/20220809/202208090943.FbDovn86-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=3aa38daa6591ae8d2c51b06295f239b1d1458b93
        git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
        git fetch --no-tags peterz-queue sched/idle
        git checkout 3aa38daa6591ae8d2c51b06295f239b1d1458b93
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   vmlinux.o: warning: objtool: acpi_idle_enter_s2idle+0x69: call to wbinvd() leaves .noinstr.text section
   vmlinux.o: warning: objtool: acpi_idle_enter+0x62: call to wbinvd() leaves .noinstr.text section
   vmlinux.o: warning: objtool: default_idle+0x4: call to mds_idle_clear_cpu_buffers() leaves .noinstr.text section
   vmlinux.o: warning: objtool: mwait_idle+0x5: call to current_set_polling_and_test() leaves .noinstr.text section
   vmlinux.o: warning: objtool: acpi_processor_ffh_cstate_enter+0x24: call to current_set_polling_and_test() leaves .noinstr.text section
   vmlinux.o: warning: objtool: cpu_idle_poll.isra.0+0x52: call to test_ti_thread_flag.constprop.0() leaves .noinstr.text section
   vmlinux.o: warning: objtool: intel_idle+0x39: call to current_set_polling_and_test() leaves .noinstr.text section
   vmlinux.o: warning: objtool: intel_idle_irq+0x3a: call to current_set_polling_and_test() leaves .noinstr.text section
   vmlinux.o: warning: objtool: intel_idle_s2idle+0x34: call to current_set_polling_and_test() leaves .noinstr.text section
>> vmlinux.o: warning: objtool: intel_idle_ibrs+0x14: call to sched_smt_active() leaves .noinstr.text section
   vmlinux.o: warning: objtool: acpi_safe_halt+0x8: call to test_ti_thread_flag.constprop.0() leaves .noinstr.text section
   vmlinux.o: warning: objtool: io_idle+0x3: call to __inb.isra.0() leaves .noinstr.text section


objdump-func vmlinux.o intel_idle_ibrs:
0000 00000000000003b3 <intel_idle_ibrs>:
0000  3b3:	f3 0f 1e fa          	endbr64 
0004  3b7:	41 57                	push   %r15
0006  3b9:	41 56                	push   %r14
0008  3bb:	49 89 f6             	mov    %rsi,%r14
000b  3be:	41 55                	push   %r13
000d  3c0:	41 54                	push   %r12
000f  3c2:	41 89 d4             	mov    %edx,%r12d
0012  3c5:	55                   	push   %rbp
0013  3c6:	53                   	push   %rbx
0014  3c7:	e8 00 00 00 00       	call   3cc <intel_idle_ibrs+0x19>	3c8: R_X86_64_PC32	.text+0x97f3f9
0019  3cc:	89 c5                	mov    %eax,%ebp
001b  3ce:	e8 00 00 00 00       	call   3d3 <intel_idle_ibrs+0x20>	3cf: R_X86_64_PLT32	spec_ctrl_current-0x4
0020  3d3:	49 89 c5             	mov    %rax,%r13
0023  3d6:	40 84 ed             	test   %bpl,%bpl
0026  3d9:	74 0c                	je     3e7 <intel_idle_ibrs+0x34>
0028  3db:	31 f6                	xor    %esi,%esi
002a  3dd:	bf 48 00 00 00       	mov    $0x48,%edi
002f  3e2:	e8 00 00 00 00       	call   3e7 <intel_idle_ibrs+0x34>	3e3: R_X86_64_PC32	.text+0x97f45f
0034  3e7:	49 63 dc             	movslq %r12d,%rbx
0037  3ea:	48 83 fb 0a          	cmp    $0xa,%rbx
003b  3ee:	76 0f                	jbe    3ff <intel_idle_ibrs+0x4c>
003d  3f0:	48 89 de             	mov    %rbx,%rsi
0040  3f3:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	3f6: R_X86_64_32S	.data+0x8fafc0
0047  3fa:	e8 00 00 00 00       	call   3ff <intel_idle_ibrs+0x4c>	3fb: R_X86_64_PLT32	__ubsan_handle_out_of_bounds-0x4
004c  3ff:	48 6b db 68          	imul   $0x68,%rbx,%rbx
0050  403:	45 0f b6 7c 1e 5b    	movzbl 0x5b(%r14,%rbx,1),%r15d
0056  409:	e9 00 00 00 00       	jmp    40e <intel_idle_ibrs+0x5b>	40a: R_X86_64_PC32	.altinstr_aux+0x99e
005b  40e:	eb 09                	jmp    419 <intel_idle_ibrs+0x66>
005d  410:	e8 00 00 00 00       	call   415 <intel_idle_ibrs+0x62>	411: R_X86_64_PC32	.text+0x97f6f7
0062  415:	84 c0                	test   %al,%al
0064  417:	75 3c                	jne    455 <intel_idle_ibrs+0xa2>
0066  419:	e9 00 00 00 00       	jmp    41e <intel_idle_ibrs+0x6b>	41a: R_X86_64_PC32	.altinstr_aux+0x9b0
006b  41e:	0f ae f0             	mfence 
006e  421:	48 8b 3c 25 00 00 00 00 	mov    0x0,%rdi	425: R_X86_64_32S	current_task
0076  429:	e8 00 00 00 00       	call   42e <intel_idle_ibrs+0x7b>	42a: R_X86_64_PC32	.text+0x97f3f3
007b  42e:	0f ae f0             	mfence 
007e  431:	4c 8b 34 25 00 00 00 00 	mov    0x0,%r14	435: R_X86_64_32S	current_task
0086  439:	4c 89 f7             	mov    %r14,%rdi
0089  43c:	e8 00 00 00 00       	call   441 <intel_idle_ibrs+0x8e>	43d: R_X86_64_PC32	.text+0x97f66d
008e  441:	4c 89 f7             	mov    %r14,%rdi
0091  444:	e8 00 00 00 00       	call   449 <intel_idle_ibrs+0x96>	445: R_X86_64_PC32	.text+0x97f681
0096  449:	85 c0                	test   %eax,%eax
0098  44b:	75 08                	jne    455 <intel_idle_ibrs+0xa2>
009a  44d:	4c 89 ff             	mov    %r15,%rdi
009d  450:	e8 00 00 00 00       	call   455 <intel_idle_ibrs+0xa2>	451: R_X86_64_PC32	.text+0x97f60f
00a2  455:	e8 00 00 00 00       	call   45a <intel_idle_ibrs+0xa7>	456: R_X86_64_PC32	.text+0x97f6bf
00a7  45a:	40 84 ed             	test   %bpl,%bpl
00aa  45d:	74 0d                	je     46c <intel_idle_ibrs+0xb9>
00ac  45f:	4c 89 ee             	mov    %r13,%rsi
00af  462:	bf 48 00 00 00       	mov    $0x48,%edi
00b4  467:	e8 00 00 00 00       	call   46c <intel_idle_ibrs+0xb9>	468: R_X86_64_PC32	.text+0x97f45f
00b9  46c:	5b                   	pop    %rbx
00ba  46d:	44 89 e0             	mov    %r12d,%eax
00bd  470:	5d                   	pop    %rbp
00be  471:	41 5c                	pop    %r12
00c0  473:	41 5d                	pop    %r13
00c2  475:	41 5e                	pop    %r14
00c4  477:	41 5f                	pop    %r15
00c6  479:	31 d2                	xor    %edx,%edx
00c8  47b:	89 d6                	mov    %edx,%esi
00ca  47d:	89 d7                	mov    %edx,%edi
00cc  47f:	c3                   	ret    

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
