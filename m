Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44F3A57E84C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 22:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236033AbiGVU2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 16:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233965AbiGVU2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 16:28:40 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7932B2CE13
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 13:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658521719; x=1690057719;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tk8c4H0PJtQjAl1YnenNzKuP0fDYiNI4HAH+T6P3of4=;
  b=W45CUzbuhL89iLBcqQzvu58P4m6/8r9AFTeOP6gnvFjXUdIBvOMr6FTd
   6m4LTDGh22xx1uenmoX7nQmZlnxPNe0CM4SwZf1lE+9RS0KJ0SO3oUksa
   arSx31daSoEbOVAUlPx958irngYrXb43L8vzTG62Xu0zUe9piNbb9kmWT
   l0SUENhtPpLftWGmbPnbNMWF2rrc1+6e5quSJacpyEHRM7S64C/64eFiL
   ugg5bsvJx4VtUdKm5r/XSuV4qJeNIv6tSJbiZ3mpK5+bQU/cl9CkmX3Kx
   8KltgOpj/oRJ58UJbH6UJlBdlJew5zg/Umytbg3Sv7dW+DD7OPa1NsVZG
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10416"; a="373706359"
X-IronPort-AV: E=Sophos;i="5.93,186,1654585200"; 
   d="scan'208";a="373706359"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2022 13:28:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,186,1654585200"; 
   d="scan'208";a="626696224"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 22 Jul 2022 13:28:37 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oEzGH-0001nt-09;
        Fri, 22 Jul 2022 20:28:37 +0000
Date:   Sat, 23 Jul 2022 04:28:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [peterz-queue:sched/idle 18/37] vmlinux.o: warning: objtool:
 intel_idle_ibrs+0x16: call to spec_ctrl_current() leaves .noinstr.text
 section
Message-ID: <202207230401.YslgKIV1-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/idle
head:   84fd27c4b216dc4083d0a62c61d4c48205ad0a28
commit: 2f33657142b2ba7f7193734e5de4fc37c409b6f6 [18/37] objtool/idle: Validate __cpuidle code as noinstr
config: x86_64-randconfig-a016-20220718 (https://download.01.org/0day-ci/archive/20220723/202207230401.YslgKIV1-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=2f33657142b2ba7f7193734e5de4fc37c409b6f6
        git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
        git fetch --no-tags peterz-queue sched/idle
        git checkout 2f33657142b2ba7f7193734e5de4fc37c409b6f6
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   vmlinux.o: warning: objtool: default_idle+0x4: call to mds_idle_clear_cpu_buffers() leaves .noinstr.text section
   vmlinux.o: warning: objtool: mwait_idle+0x49: call to mds_idle_clear_cpu_buffers() leaves .noinstr.text section
>> vmlinux.o: warning: objtool: intel_idle_ibrs+0x16: call to spec_ctrl_current() leaves .noinstr.text section
   vmlinux.o: warning: objtool: intel_idle_irq+0x46: call to current_set_polling_and_test() leaves .noinstr.text section
   vmlinux.o: warning: objtool: intel_idle_s2idle+0x40: call to current_set_polling_and_test() leaves .noinstr.text section
   vmlinux.o: warning: objtool: intel_idle+0x45: call to current_set_polling_and_test() leaves .noinstr.text section


objdump-func vmlinux.o intel_idle_ibrs:
0000 00000000000002a9 <intel_idle_ibrs>:
0000  2a9:	f3 0f 1e fa          	endbr64 
0004  2ad:	41 54                	push   %r12
0006  2af:	55                   	push   %rbp
0007  2b0:	48 89 f5             	mov    %rsi,%rbp
000a  2b3:	53                   	push   %rbx
000b  2b4:	48 63 da             	movslq %edx,%rbx
000e  2b7:	49 89 dc             	mov    %rbx,%r12
0011  2ba:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)	2bb: R_X86_64_NONE	__sanitizer_cov_trace_pc-0x4
0016  2bf:	e8 00 00 00 00       	call   2c4 <intel_idle_ibrs+0x1b>	2c0: R_X86_64_PLT32	spec_ctrl_current-0x4
001b  2c4:	48 83 fb 0a          	cmp    $0xa,%rbx
001f  2c8:	76 0f                	jbe    2d9 <intel_idle_ibrs+0x30>
0021  2ca:	48 89 de             	mov    %rbx,%rsi
0024  2cd:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	2d0: R_X86_64_32S	.data+0x69c240
002b  2d4:	e8 00 00 00 00       	call   2d9 <intel_idle_ibrs+0x30>	2d5: R_X86_64_PLT32	__ubsan_handle_out_of_bounds-0x4
0030  2d9:	48 6b db 68          	imul   $0x68,%rbx,%rbx
0034  2dd:	0f b6 6c 1d 5b       	movzbl 0x5b(%rbp,%rbx,1),%ebp
0039  2e2:	e9 00 00 00 00       	jmp    2e7 <intel_idle_ibrs+0x3e>	2e3: R_X86_64_PC32	.altinstr_aux+0x16b2
003e  2e7:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)	2e8: R_X86_64_NONE	__sanitizer_cov_trace_pc-0x4
0043  2ec:	eb 19                	jmp    307 <intel_idle_ibrs+0x5e>
0045  2ee:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)	2ef: R_X86_64_NONE	__sanitizer_cov_trace_pc-0x4
004a  2f3:	e8 00 00 00 00       	call   2f8 <intel_idle_ibrs+0x4f>	2f4: R_X86_64_PC32	.text+0x81bd14
004f  2f8:	31 ff                	xor    %edi,%edi
0051  2fa:	89 c3                	mov    %eax,%ebx
0053  2fc:	89 c6                	mov    %eax,%esi
0055  2fe:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)	2ff: R_X86_64_NONE	__sanitizer_cov_trace_const_cmp1-0x4
005a  303:	84 db                	test   %bl,%bl
005c  305:	75 68                	jne    36f <intel_idle_ibrs+0xc6>
005e  307:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)	308: R_X86_64_NONE	__sanitizer_cov_trace_pc-0x4
0063  30c:	e9 00 00 00 00       	jmp    311 <intel_idle_ibrs+0x68>	30d: R_X86_64_PC32	.altinstr_aux+0x16c4
0068  311:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)	312: R_X86_64_NONE	__sanitizer_cov_trace_pc-0x4
006d  316:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)	317: R_X86_64_NONE	__sanitizer_cov_trace_pc-0x4
0072  31b:	0f ae f0             	mfence 
0075  31e:	48 8b 04 25 00 00 00 00 	mov    0x0,%rax	322: R_X86_64_32S	current_task
007d  326:	0f ae 38             	clflush (%rax)
0080  329:	0f ae f0             	mfence 
0083  32c:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)	32d: R_X86_64_NONE	__sanitizer_cov_trace_pc-0x4
0088  331:	31 d2                	xor    %edx,%edx
008a  333:	48 89 d1             	mov    %rdx,%rcx
008d  336:	48 8b 04 25 00 00 00 00 	mov    0x0,%rax	33a: R_X86_64_32S	current_task
0095  33e:	0f 01 c8             	monitor %rax,%ecx,%edx
0098  341:	48 8b 18             	mov    (%rax),%rbx
009b  344:	31 ff                	xor    %edi,%edi
009d  346:	48 c1 eb 03          	shr    $0x3,%rbx
00a1  34a:	83 e3 01             	and    $0x1,%ebx
00a4  34d:	48 89 de             	mov    %rbx,%rsi
00a7  350:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)	351: R_X86_64_NONE	__sanitizer_cov_trace_const_cmp8-0x4
00ac  355:	48 85 db             	test   %rbx,%rbx
00af  358:	75 15                	jne    36f <intel_idle_ibrs+0xc6>
00b1  35a:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)	35b: R_X86_64_NONE	__sanitizer_cov_trace_pc-0x4
00b6  35f:	e8 00 00 00 00       	call   364 <intel_idle_ibrs+0xbb>	360: R_X86_64_PC32	.text+0x81bd34
00bb  364:	b9 01 00 00 00       	mov    $0x1,%ecx
00c0  369:	48 89 e8             	mov    %rbp,%rax
00c3  36c:	0f 01 c9             	mwait  %eax,%ecx
00c6  36f:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)	370: R_X86_64_NONE	__sanitizer_cov_trace_pc-0x4
00cb  374:	e8 00 00 00 00       	call   379 <intel_idle_ibrs+0xd0>	375: R_X86_64_PC32	.text+0x81bcd6
00d0  379:	5b                   	pop    %rbx
00d1  37a:	44 89 e0             	mov    %r12d,%eax
00d4  37d:	5d                   	pop    %rbp
00d5  37e:	41 5c                	pop    %r12
00d7  380:	e9 00 00 00 00       	jmp    385 <intel_idle_irq>	381: R_X86_64_PLT32	__x86_return_thunk-0x4

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
