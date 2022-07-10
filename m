Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3FE56CE6B
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 11:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiGJJbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 05:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGJJbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 05:31:34 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E18552729
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 02:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657445485; x=1688981485;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=25yDkKCI2sgPnaoJHEvOY/ZCF1IJUPPKGrkcW4A2WeI=;
  b=hVBUsq8+/zCC8/2sZ8oftByBWy9rrmVwFM2fbj5GpE2rwEEsTIAEclRW
   Wa18m47llGeozfy+sOVfjEwfooa+qCA18aYX6lQOBdfDYTTjb6N/Oudi0
   iM89NPSQo5HJiMIO+5cazCkrmLhQzEmA1f5SMWCzNCHcw/YrgUG5C9fen
   CBkYjGe5IKNlXYZ+iFVCmty40jh3dRr7LabP3IXW9RirrmN+E4KZTYsgS
   uQODRepX6ax44hof34Ty2/+glGeqDDw05rzTsgD5wpOk20GuChHw/e5lN
   2+eKGS8oxm4U/6IBWSU07nhkwYviqJcPZrYsub/fmjzSnSzSqzE19TzpH
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10403"; a="285623455"
X-IronPort-AV: E=Sophos;i="5.92,260,1650956400"; 
   d="xz'?scan'208";a="285623455"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2022 02:31:24 -0700
X-IronPort-AV: E=Sophos;i="5.92,260,1650956400"; 
   d="xz'?scan'208";a="652078733"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.143])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2022 02:31:21 -0700
Date:   Sun, 10 Jul 2022 17:31:14 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Alexander Potapenko <glider@google.com>
Cc:     elver@google.com, linux-kernel@vger.kernel.org, lkp@lists.01.org,
        lkp@intel.com
Subject: [x86]  9724330ed6: kernel-selftests.x86.fsgsbase_restore_64.fail
Message-ID: <YsqcYkFRw1pNuvB+@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="c7ijwEYYO4C8FEwX"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--c7ijwEYYO4C8FEwX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline



Greeting,

FYI, we noticed the following commit (built with gcc-11):

commit: 9724330ed6ddddf7aae3a57ab04292e4c138eb3a ("x86: asm: instrument usercopy in get_user() and __put_user_size()")
https://git.kernel.org/cgit/linux/kernel/git/melver/linux.git review/kmsan

in testcase: kernel-selftests
version: kernel-selftests-x86_64-37f3cb9b-1_20220704
with following parameters:

	group: x86

test-description: The kernel contains a set of "self tests" under the tools/testing/selftests/ directory. These are intended to be small unit tests to exercise individual code paths in the kernel.
test-url: https://www.kernel.org/doc/Documentation/kselftest.txt


on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):



If you fix the issue, kindly add following tag
Reported-by: kernel test robot <oliver.sang@intel.com>


please be noted we also observed other tests failed on this commit, but pass on
parent, as below. as well as a segfault.

ed05586b54c05b64 9724330ed6ddddf7aae3a57ab04
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :9          100%           9:9     kmsg.segfault_at_ip_sp_error
           :9          100%           9:9     kernel-selftests.x86.fsgsbase_restore_32.fail
           :9          100%           9:9     kernel-selftests.x86.fsgsbase_restore_64.fail
           :9          100%           9:9     kernel-selftests.x86.ioperm_32.fail
           :9          100%           9:9     kernel-selftests.x86.iopl_32.fail
           :9          100%           9:9     kernel-selftests.x86.ptrace_syscall_32.fail
           :9          100%           9:9     kernel-selftests.x86.ptrace_syscall_64.fail
           :9          100%           9:9     kernel-selftests.x86.syscall_numbering_64.fail

segfault looks like below (from attached dmesg):

[  492.679630][ T3357] ptrace_syscall_[3357]: segfault at 7ffecfd253e8 ip 00007ffecfd253e8 sp 00007ffecfd25118 error 15
[  492.683931][ T3357] Code: 00 00 c8 53 d2 cf fe 7f 00 00 1c 00 00 00 00 00 00 00 01 00 00 00 00 00 00 00 93 5a d2 cf fe 7f 00 00 00 00 00 00 00 00 00 00 <a7> 5a d2 cf fe 7f 00 00 44 5b d2 cf fe 7f 00 00 85 5b d2 cf fe 7f



# selftests: x86: iopl_32
# iopl_32: sched_setaffinity to CPU 0: Invalid argument
not ok 7 selftests: x86: iopl_32 # exit=1
# selftests: x86: ioperm_32
# ioperm_32: sched_setaffinity to CPU 0: Invalid argument
not ok 8 selftests: x86: ioperm_32 # exit=1
...
# selftests: x86: fsgsbase_restore_32
# fsgsbase_restore_32: PTRACE_GETREGS: Input/output error
# 	Setting up a segment
# 	segment base address = 0xf7fb8000
# 	using LDT slot 0
# [OK]	The segment points to the right place.
# 	Child FS=0x7
# 	Tracer: redirecting tracee to tracee_zap_segment()
not ok 11 selftests: x86: fsgsbase_restore_32 # exit=1
...
# selftests: x86: ptrace_syscall_32
# ptrace_syscall_32: PTRACE_SETREGS: Input/output error
# [RUN]	Check int80 return regs
# [OK]	getpid() preserves regs
# [OK]	kill(getpid(), SIGUSR1) preserves regs
# [RUN]	Check AT_SYSINFO return regs
# [OK]	getpid() preserves regs
# [OK]	kill(getpid(), SIGUSR1) preserves regs
# [RUN]	ptrace-induced syscall restart
# [RUN]	SYSEMU
# [OK]	Initial nr and args are correct
# [RUN]	Restart the syscall (ip = 0xf7f5c549)
not ok 21 selftests: x86: ptrace_syscall_32 # exit=1
...
# selftests: x86: fsgsbase_restore_64
# fsgsbase_restore_64: PTRACE_GETREGS: Input/output error
# 	Setting up a segment
# 	segment base address = 0x40c52000
# 	using LDT slot 0
# [OK]	The segment points to the right place.
# 	Child GS=0x7, GSBASE=0x40c52000
# 	Tracer: redirecting tracee to tracee_zap_segment()
not ok 32 selftests: x86: fsgsbase_restore_64 # exit=1
...
# selftests: x86: syscall_numbering_64
# [RUN]   Checking for x32 by calling x32 getpid()
# [INFO]      x32 is not supported
# [RUN]   Running tests without ptrace...
# [RUN]       Checking system calls with msb = 0 (0x0)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall 0:0 returned 0 as expected
# [OK]                x64 syscall 0:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall 0:19 returned 0 as expected
# [OK]                x64 syscall 0:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls 0:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall 0:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls 0:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls 0:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls 0:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls 0:0..999 returned -ENOSYS as expected
# [RUN]       Checking system calls with msb = 1 (0x1)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall 1:0 returned 0 as expected
# [OK]                x64 syscall 1:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall 1:19 returned 0 as expected
# [OK]                x64 syscall 1:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls 1:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall 1:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls 1:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls 1:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls 1:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls 1:0..999 returned -ENOSYS as expected
# [RUN]       Checking system calls with msb = -1 (0xffffffff)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall -1:0 returned 0 as expected
# [OK]                x64 syscall -1:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall -1:19 returned 0 as expected
# [OK]                x64 syscall -1:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls -1:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall -1:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls -1:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls -1:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls -1:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls -1:0..999 returned -ENOSYS as expected
# [RUN]       Checking system calls with msb = 1073741823 (0x3fffffff)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall 1073741823:0 returned 0 as expected
# [OK]                x64 syscall 1073741823:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall 1073741823:19 returned 0 as expected
# [OK]                x64 syscall 1073741823:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls 1073741823:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall 1073741823:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls 1073741823:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls 1073741823:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls 1073741823:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls 1073741823:0..999 returned -ENOSYS as expected
# [RUN]       Checking system calls with msb = 1073741824 (0x40000000)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall 1073741824:0 returned 0 as expected
# [OK]                x64 syscall 1073741824:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall 1073741824:19 returned 0 as expected
# [OK]                x64 syscall 1073741824:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls 1073741824:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall 1073741824:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls 1073741824:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls 1073741824:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls 1073741824:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls 1073741824:0..999 returned -ENOSYS as expected
# [RUN]       Checking system calls with msb = 1073741823 (0x3fffffff)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall 1073741823:0 returned 0 as expected
# [OK]                x64 syscall 1073741823:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall 1073741823:19 returned 0 as expected
# [OK]                x64 syscall 1073741823:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls 1073741823:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall 1073741823:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls 1073741823:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls 1073741823:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls 1073741823:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls 1073741823:0..999 returned -ENOSYS as expected
# [RUN]       Checking system calls with msb = -1073741824 (0xc0000000)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall -1073741824:0 returned 0 as expected
# [OK]                x64 syscall -1073741824:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall -1073741824:19 returned 0 as expected
# [OK]                x64 syscall -1073741824:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls -1073741824:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall -1073741824:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls -1073741824:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls -1073741824:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls -1073741824:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls -1073741824:0..999 returned -ENOSYS as expected
# [RUN]       Checking system calls with msb = 2147483647 (0x7fffffff)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall 2147483647:0 returned 0 as expected
# [OK]                x64 syscall 2147483647:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall 2147483647:19 returned 0 as expected
# [OK]                x64 syscall 2147483647:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls 2147483647:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall 2147483647:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls 2147483647:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls 2147483647:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls 2147483647:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls 2147483647:0..999 returned -ENOSYS as expected
# [RUN]       Checking system calls with msb = -2147483648 (0x80000000)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall -2147483648:0 returned 0 as expected
# [OK]                x64 syscall -2147483648:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall -2147483648:19 returned 0 as expected
# [OK]                x64 syscall -2147483648:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls -2147483648:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall -2147483648:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls -2147483648:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls -2147483648:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls -2147483648:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls -2147483648:0..999 returned -ENOSYS as expected
# [RUN]       Checking system calls with msb = -2147483647 (0x80000001)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall -2147483647:0 returned 0 as expected
# [OK]                x64 syscall -2147483647:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall -2147483647:19 returned 0 as expected
# [OK]                x64 syscall -2147483647:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls -2147483647:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall -2147483647:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls -2147483647:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls -2147483647:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls -2147483647:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls -2147483647:0..999 returned -ENOSYS as expected
# [RUN]   Running tests under ptrace: just stop, no data read
# [RUN]       Checking system calls with msb = 0 (0x0)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall 0:0 returned 0 as expected
# [OK]                x64 syscall 0:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall 0:19 returned 0 as expected
# [OK]                x64 syscall 0:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls 0:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall 0:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls 0:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls 0:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls 0:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls 0:0..999 returned -ENOSYS as expected
# [RUN]       Checking system calls with msb = 1 (0x1)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall 1:0 returned 0 as expected
# [OK]                x64 syscall 1:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall 1:19 returned 0 as expected
# [OK]                x64 syscall 1:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls 1:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall 1:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls 1:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls 1:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls 1:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls 1:0..999 returned -ENOSYS as expected
# [RUN]       Checking system calls with msb = -1 (0xffffffff)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall -1:0 returned 0 as expected
# [OK]                x64 syscall -1:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall -1:19 returned 0 as expected
# [OK]                x64 syscall -1:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls -1:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall -1:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls -1:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls -1:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls -1:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls -1:0..999 returned -ENOSYS as expected
# [RUN]       Checking system calls with msb = 1073741823 (0x3fffffff)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall 1073741823:0 returned 0 as expected
# [OK]                x64 syscall 1073741823:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall 1073741823:19 returned 0 as expected
# [OK]                x64 syscall 1073741823:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls 1073741823:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall 1073741823:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls 1073741823:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls 1073741823:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls 1073741823:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls 1073741823:0..999 returned -ENOSYS as expected
# [RUN]       Checking system calls with msb = 1073741824 (0x40000000)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall 1073741824:0 returned 0 as expected
# [OK]                x64 syscall 1073741824:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall 1073741824:19 returned 0 as expected
# [OK]                x64 syscall 1073741824:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls 1073741824:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall 1073741824:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls 1073741824:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls 1073741824:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls 1073741824:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls 1073741824:0..999 returned -ENOSYS as expected
# [RUN]       Checking system calls with msb = 1073741823 (0x3fffffff)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall 1073741823:0 returned 0 as expected
# [OK]                x64 syscall 1073741823:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall 1073741823:19 returned 0 as expected
# [OK]                x64 syscall 1073741823:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls 1073741823:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall 1073741823:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls 1073741823:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls 1073741823:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls 1073741823:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls 1073741823:0..999 returned -ENOSYS as expected
# [RUN]       Checking system calls with msb = -1073741824 (0xc0000000)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall -1073741824:0 returned 0 as expected
# [OK]                x64 syscall -1073741824:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall -1073741824:19 returned 0 as expected
# [OK]                x64 syscall -1073741824:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls -1073741824:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall -1073741824:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls -1073741824:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls -1073741824:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls -1073741824:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls -1073741824:0..999 returned -ENOSYS as expected
# [RUN]       Checking system calls with msb = 2147483647 (0x7fffffff)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall 2147483647:0 returned 0 as expected
# [OK]                x64 syscall 2147483647:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall 2147483647:19 returned 0 as expected
# [OK]                x64 syscall 2147483647:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls 2147483647:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall 2147483647:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls 2147483647:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls 2147483647:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls 2147483647:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls 2147483647:0..999 returned -ENOSYS as expected
# [RUN]       Checking system calls with msb = -2147483648 (0x80000000)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall -2147483648:0 returned 0 as expected
# [OK]                x64 syscall -2147483648:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall -2147483648:19 returned 0 as expected
# [OK]                x64 syscall -2147483648:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls -2147483648:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall -2147483648:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls -2147483648:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls -2147483648:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls -2147483648:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls -2147483648:0..999 returned -ENOSYS as expected
# [RUN]       Checking system calls with msb = -2147483647 (0x80000001)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall -2147483647:0 returned 0 as expected
# [OK]                x64 syscall -2147483647:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall -2147483647:19 returned 0 as expected
# [OK]                x64 syscall -2147483647:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls -2147483647:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall -2147483647:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls -2147483647:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls -2147483647:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls -2147483647:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls -2147483647:0..999 returned -ENOSYS as expected
# [RUN]   Running tests under ptrace: only getregs
# [RUN]       Checking system calls with msb = 0 (0x0)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall 0:0 returned 0 as expected
# [OK]                x64 syscall 0:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall 0:19 returned 0 as expected
# [OK]                x64 syscall 0:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls 0:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall 0:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls 0:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls 0:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls 0:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls 0:0..999 returned -ENOSYS as expected
# [RUN]       Checking system calls with msb = 1 (0x1)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall 1:0 returned 0 as expected
# [OK]                x64 syscall 1:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall 1:19 returned 0 as expected
# [OK]                x64 syscall 1:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls 1:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall 1:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls 1:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls 1:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls 1:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls 1:0..999 returned -ENOSYS as expected
# [RUN]       Checking system calls with msb = -1 (0xffffffff)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall -1:0 returned 0 as expected
# [OK]                x64 syscall -1:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall -1:19 returned 0 as expected
# [OK]                x64 syscall -1:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls -1:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall -1:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls -1:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls -1:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls -1:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls -1:0..999 returned -ENOSYS as expected
# [RUN]       Checking system calls with msb = 1073741823 (0x3fffffff)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall 1073741823:0 returned 0 as expected
# [OK]                x64 syscall 1073741823:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall 1073741823:19 returned 0 as expected
# [OK]                x64 syscall 1073741823:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls 1073741823:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall 1073741823:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls 1073741823:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls 1073741823:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls 1073741823:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls 1073741823:0..999 returned -ENOSYS as expected
# [RUN]       Checking system calls with msb = 1073741824 (0x40000000)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall 1073741824:0 returned 0 as expected
# [OK]                x64 syscall 1073741824:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall 1073741824:19 returned 0 as expected
# [OK]                x64 syscall 1073741824:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls 1073741824:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall 1073741824:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls 1073741824:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls 1073741824:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls 1073741824:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls 1073741824:0..999 returned -ENOSYS as expected
# [RUN]       Checking system calls with msb = 1073741823 (0x3fffffff)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall 1073741823:0 returned 0 as expected
# [OK]                x64 syscall 1073741823:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall 1073741823:19 returned 0 as expected
# [OK]                x64 syscall 1073741823:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls 1073741823:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall 1073741823:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls 1073741823:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls 1073741823:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls 1073741823:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls 1073741823:0..999 returned -ENOSYS as expected
# [RUN]       Checking system calls with msb = -1073741824 (0xc0000000)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall -1073741824:0 returned 0 as expected
# [OK]                x64 syscall -1073741824:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall -1073741824:19 returned 0 as expected
# [OK]                x64 syscall -1073741824:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls -1073741824:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall -1073741824:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls -1073741824:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls -1073741824:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls -1073741824:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls -1073741824:0..999 returned -ENOSYS as expected
# [RUN]       Checking system calls with msb = 2147483647 (0x7fffffff)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall 2147483647:0 returned 0 as expected
# [OK]                x64 syscall 2147483647:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall 2147483647:19 returned 0 as expected
# [OK]                x64 syscall 2147483647:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls 2147483647:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall 2147483647:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls 2147483647:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls 2147483647:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls 2147483647:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls 2147483647:0..999 returned -ENOSYS as expected
# [RUN]       Checking system calls with msb = -2147483648 (0x80000000)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall -2147483648:0 returned 0 as expected
# [OK]                x64 syscall -2147483648:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall -2147483648:19 returned 0 as expected
# [OK]                x64 syscall -2147483648:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls -2147483648:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall -2147483648:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls -2147483648:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls -2147483648:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls -2147483648:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls -2147483648:0..999 returned -ENOSYS as expected
# [RUN]       Checking system calls with msb = -2147483647 (0x80000001)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall -2147483647:0 returned 0 as expected
# [OK]                x64 syscall -2147483647:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall -2147483647:19 returned 0 as expected
# [OK]                x64 syscall -2147483647:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls -2147483647:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall -2147483647:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls -2147483647:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls -2147483647:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls -2147483647:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls -2147483647:0..999 returned -ENOSYS as expected
# [RUN]   Running tests under ptrace: getregs, unmodified setregs
# [RUN]       Checking system calls with msb = 0 (0x0)
# [RUN]           Checking some common syscalls as 64 bit
#
not ok 36 selftests: x86: syscall_numbering_64 # TIMEOUT 300 seconds
...
# selftests: x86: ptrace_syscall_64
# ptrace_syscall_64: PTRACE_SETREGS: Input/output error
# [RUN]	Check int80 return regs
# [OK]	getpid() preserves regs
# [OK]	kill(getpid(), SIGUSR1) preserves regs
# [RUN]	ptrace-induced syscall restart
# [RUN]	SYSEMU
# [OK]	Initial nr and args are correct
# [RUN]	Restart the syscall (ip = 0x7f4fa21289b9)
not ok 40 selftests: x86: ptrace_syscall_64 # exit=1



To reproduce:

        # build kernel
	cd linux
	cp config-5.19.0-rc5-00004-g9724330ed6dd .config
	make HOSTCC=gcc-11 CC=gcc-11 ARCH=x86_64 olddefconfig prepare modules_prepare bzImage modules
	make HOSTCC=gcc-11 CC=gcc-11 ARCH=x86_64 INSTALL_MOD_PATH=<mod-install-dir> modules_install
	cd <mod-install-dir>
	find lib/ | cpio -o -H newc --quiet | gzip > modules.cgz


        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        bin/lkp qemu -k <bzImage> -m modules.cgz job-script # job-script is attached in this email

        # if come across any failure that blocks the test,
        # please remove ~/.lkp and /lkp dir to run from a clean state.



-- 
0-DAY CI Kernel Test Service
https://01.org/lkp



--c7ijwEYYO4C8FEwX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="config-5.19.0-rc5-00004-g9724330ed6dd"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 5.19.0-rc5 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="gcc-11 (Debian 11.3.0-3) 11.3.0"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=110300
CONFIG_CLANG_VERSION=0
CONFIG_AS_IS_GNU=y
CONFIG_AS_VERSION=23800
CONFIG_LD_IS_BFD=y
CONFIG_LD_VERSION=23800
CONFIG_LLD_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_CAN_LINK_STATIC=y
CONFIG_CC_HAS_ASM_GOTO=y
CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_CC_HAS_NO_PROFILE_FN_ATTR=y
CONFIG_PAHOLE_VERSION=123
CONFIG_CONSTRUCTORS=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_TABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
# CONFIG_WERROR is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
CONFIG_HAVE_KERNEL_ZSTD=y
CONFIG_KERNEL_GZIP=y
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
# CONFIG_KERNEL_ZSTD is not set
CONFIG_DEFAULT_INIT=""
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_SYSVIPC_COMPAT=y
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
# CONFIG_WATCH_QUEUE is not set
CONFIG_CROSS_MEMORY_ATTACH=y
# CONFIG_USELIB is not set
CONFIG_AUDIT=y
CONFIG_HAVE_ARCH_AUDITSYSCALL=y
CONFIG_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_GENERIC_IRQ_INJECTION=y
CONFIG_HARDIRQS_SW_RESEND=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
CONFIG_IRQ_MSI_IOMMU=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
# end of IRQ subsystem

CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_INIT=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y
CONFIG_HAVE_POSIX_CPU_TIMERS_TASK_WORK=y
CONFIG_POSIX_CPU_TIMERS_TASK_WORK=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ_FULL=y
CONFIG_CONTEXT_TRACKING=y
# CONFIG_CONTEXT_TRACKING_FORCE is not set
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US=100
# end of Timers subsystem

CONFIG_BPF=y
CONFIG_HAVE_EBPF_JIT=y
CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y

#
# BPF subsystem
#
CONFIG_BPF_SYSCALL=y
CONFIG_BPF_JIT=y
CONFIG_BPF_JIT_ALWAYS_ON=y
CONFIG_BPF_JIT_DEFAULT_ON=y
CONFIG_BPF_UNPRIV_DEFAULT_OFF=y
# CONFIG_BPF_PRELOAD is not set
# CONFIG_BPF_LSM is not set
# end of BPF subsystem

CONFIG_PREEMPT_VOLUNTARY_BUILD=y
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y
# CONFIG_PREEMPT_DYNAMIC is not set
# CONFIG_SCHED_CORE is not set

#
# CPU/Task time and stats accounting
#
CONFIG_VIRT_CPU_ACCOUNTING=y
CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_SCHED_AVG_IRQ=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
CONFIG_TASKSTATS=y
CONFIG_TASK_DELAY_ACCT=y
CONFIG_TASK_XACCT=y
CONFIG_TASK_IO_ACCOUNTING=y
# CONFIG_PSI is not set
# end of CPU/Task time and stats accounting

CONFIG_CPU_ISOLATION=y

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_TASKS_RUDE_RCU=y
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_NOCB_CPU=y
# end of RCU Subsystem

CONFIG_BUILD_BIN2C=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_IKHEADERS is not set
CONFIG_LOG_BUF_SHIFT=20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
# CONFIG_PRINTK_INDEX is not set
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y

#
# Scheduler features
#
# CONFIG_UCLAMP_TASK is not set
# end of Scheduler features

CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CC_HAS_INT128=y
CONFIG_CC_IMPLICIT_FALLTHROUGH="-Wimplicit-fallthrough=5"
CONFIG_GCC12_NO_ARRAY_BOUNDS=y
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_NUMA_BALANCING=y
CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
CONFIG_MEMCG=y
CONFIG_MEMCG_SWAP=y
CONFIG_MEMCG_KMEM=y
CONFIG_BLK_CGROUP=y
CONFIG_CGROUP_WRITEBACK=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
CONFIG_RT_GROUP_SCHED=y
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_HUGETLB=y
CONFIG_CPUSETS=y
CONFIG_PROC_PID_CPUSET=y
CONFIG_CGROUP_DEVICE=y
CONFIG_CGROUP_CPUACCT=y
CONFIG_CGROUP_PERF=y
CONFIG_CGROUP_BPF=y
# CONFIG_CGROUP_MISC is not set
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
CONFIG_TIME_NS=y
CONFIG_IPC_NS=y
CONFIG_USER_NS=y
CONFIG_PID_NS=y
CONFIG_NET_NS=y
CONFIG_CHECKPOINT_RESTORE=y
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
CONFIG_RD_ZSTD=y
# CONFIG_BOOT_CONFIG is not set
CONFIG_INITRAMFS_PRESERVE_MTIME=y
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_LD_ORPHAN_WARN=y
CONFIG_SYSCTL=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_EXPERT=y
CONFIG_UID16=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_PCSPKR_PLATFORM=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_IO_URING=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_KCMP=y
CONFIG_RSEQ=y
# CONFIG_DEBUG_RSEQ is not set
CONFIG_EMBEDDED=y
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_GUEST_PERF_EVENTS=y
# CONFIG_PC104 is not set

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

CONFIG_SYSTEM_DATA_VERIFICATION=y
CONFIG_PROFILING=y
CONFIG_TRACEPOINTS=y
# end of General setup

CONFIG_64BIT=y
CONFIG_X86_64=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf64-x86-64"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=28
CONFIG_ARCH_MMAP_RND_BITS_MAX=32
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_NR_GPIO=1024
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_AUDIT_ARCH=y
CONFIG_KASAN_SHADOW_OFFSET=0xdffffc0000000000
CONFIG_HAVE_INTEL_TXT=y
CONFIG_X86_64_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=5
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_X2APIC=y
CONFIG_X86_MPPARSE=y
# CONFIG_GOLDFISH is not set
CONFIG_RETPOLINE=y
CONFIG_CC_HAS_SLS=y
# CONFIG_SLS is not set
CONFIG_X86_CPU_RESCTRL=y
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_NUMACHIP is not set
# CONFIG_X86_VSMP is not set
CONFIG_X86_UV=y
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_MID is not set
CONFIG_X86_INTEL_LPSS=y
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_PARAVIRT_SPINLOCKS=y
CONFIG_X86_HV_CALLBACK_VECTOR=y
# CONFIG_XEN is not set
CONFIG_KVM_GUEST=y
CONFIG_ARCH_CPUIDLE_HALTPOLL=y
# CONFIG_PVH is not set
CONFIG_PARAVIRT_TIME_ACCOUNTING=y
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_JAILHOUSE_GUEST is not set
# CONFIG_ACRN_GUEST is not set
# CONFIG_INTEL_TDX_GUEST is not set
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_GENERIC_CPU=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=64
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_IA32_FEAT_CTL=y
CONFIG_X86_VMX_FEATURE_NAMES=y
# CONFIG_PROCESSOR_SELECT is not set
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_HYGON=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_ZHAOXIN=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
# CONFIG_GART_IOMMU is not set
CONFIG_BOOT_VESA_SUPPORT=y
CONFIG_MAXSMP=y
CONFIG_NR_CPUS_RANGE_BEGIN=8192
CONFIG_NR_CPUS_RANGE_END=8192
CONFIG_NR_CPUS_DEFAULT=8192
CONFIG_NR_CPUS=8192
CONFIG_SCHED_CLUSTER=y
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
CONFIG_SCHED_MC_PRIO=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
CONFIG_X86_MCE=y
CONFIG_X86_MCELOG_LEGACY=y
CONFIG_X86_MCE_INTEL=y
# CONFIG_X86_MCE_AMD is not set
CONFIG_X86_MCE_THRESHOLD=y
CONFIG_X86_MCE_INJECT=m

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=m
CONFIG_PERF_EVENTS_INTEL_RAPL=m
CONFIG_PERF_EVENTS_INTEL_CSTATE=m
# CONFIG_PERF_EVENTS_AMD_POWER is not set
# CONFIG_PERF_EVENTS_AMD_UNCORE is not set
# CONFIG_PERF_EVENTS_AMD_BRS is not set
# end of Performance monitoring

CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX64=y
CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_X86_IOPL_IOPERM=y
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
# CONFIG_MICROCODE_AMD is not set
CONFIG_MICROCODE_LATE_LOADING=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_X86_5LEVEL=y
CONFIG_X86_DIRECT_GBPAGES=y
# CONFIG_X86_CPA_STATISTICS is not set
# CONFIG_AMD_MEM_ENCRYPT is not set
CONFIG_NUMA=y
# CONFIG_AMD_NUMA is not set
CONFIG_X86_64_ACPI_NUMA=y
CONFIG_NUMA_EMU=y
CONFIG_NODES_SHIFT=10
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
# CONFIG_ARCH_MEMORY_PROBE is not set
CONFIG_ARCH_PROC_KCORE_TEXT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_X86_PMEM_LEGACY_DEVICE=y
CONFIG_X86_PMEM_LEGACY=m
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
# CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK is not set
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=1
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_ARCH_RANDOM=y
CONFIG_X86_UMIP=y
CONFIG_CC_HAS_IBT=y
# CONFIG_X86_KERNEL_IBT is not set
CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
CONFIG_X86_INTEL_TSX_MODE_OFF=y
# CONFIG_X86_INTEL_TSX_MODE_ON is not set
# CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
CONFIG_X86_SGX=y
CONFIG_EFI=y
CONFIG_EFI_STUB=y
CONFIG_EFI_MIXED=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
CONFIG_KEXEC_FILE=y
CONFIG_ARCH_HAS_KEXEC_PURGATORY=y
# CONFIG_KEXEC_SIG is not set
CONFIG_CRASH_DUMP=y
CONFIG_KEXEC_JUMP=y
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
CONFIG_RANDOMIZE_BASE=y
CONFIG_X86_NEED_RELOCS=y
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_DYNAMIC_MEMORY_LAYOUT=y
CONFIG_RANDOMIZE_MEMORY=y
CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING=0xa
CONFIG_HOTPLUG_CPU=y
CONFIG_BOOTPARAM_HOTPLUG_CPU0=y
# CONFIG_DEBUG_HOTPLUG_CPU0 is not set
# CONFIG_COMPAT_VDSO is not set
CONFIG_LEGACY_VSYSCALL_XONLY=y
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
# CONFIG_STRICT_SIGALTSTACK_SIZE is not set
CONFIG_HAVE_LIVEPATCH=y
CONFIG_LIVEPATCH=y
# end of Processor type and features

CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE=y

#
# Power management and ACPI options
#
CONFIG_ARCH_HIBERNATION_HEADER=y
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
# CONFIG_SUSPEND_SKIP_SYNC is not set
CONFIG_HIBERNATE_CALLBACKS=y
CONFIG_HIBERNATION=y
CONFIG_HIBERNATION_SNAPSHOT_DEV=y
CONFIG_PM_STD_PARTITION=""
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
# CONFIG_PM_AUTOSLEEP is not set
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
# CONFIG_PM_ADVANCED_DEBUG is not set
# CONFIG_PM_TEST_SUSPEND is not set
CONFIG_PM_SLEEP_DEBUG=y
# CONFIG_DPM_WATCHDOG is not set
# CONFIG_PM_TRACE_RTC is not set
CONFIG_PM_CLK=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
# CONFIG_ENERGY_MODEL is not set
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
# CONFIG_ACPI_FPDT is not set
CONFIG_ACPI_LPIT=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
CONFIG_ACPI_EC_DEBUGFS=m
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_FAN=y
CONFIG_ACPI_TAD=m
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_CPPC_LIB=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_IPMI=m
CONFIG_ACPI_HOTPLUG_CPU=y
CONFIG_ACPI_PROCESSOR_AGGREGATOR=m
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_PLATFORM_PROFILE=m
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_PCI_SLOT=y
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_MEMORY=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_SBS=m
CONFIG_ACPI_HED=y
# CONFIG_ACPI_CUSTOM_METHOD is not set
CONFIG_ACPI_BGRT=y
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
CONFIG_ACPI_NFIT=m
# CONFIG_NFIT_SECURITY_DEBUG is not set
CONFIG_ACPI_NUMA=y
# CONFIG_ACPI_HMAT is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
CONFIG_ACPI_APEI=y
CONFIG_ACPI_APEI_GHES=y
CONFIG_ACPI_APEI_PCIEAER=y
CONFIG_ACPI_APEI_MEMORY_FAILURE=y
CONFIG_ACPI_APEI_EINJ=m
# CONFIG_ACPI_APEI_ERST_DEBUG is not set
# CONFIG_ACPI_DPTF is not set
CONFIG_ACPI_WATCHDOG=y
CONFIG_ACPI_EXTLOG=m
CONFIG_ACPI_ADXL=y
# CONFIG_ACPI_CONFIGFS is not set
# CONFIG_ACPI_PFRUT is not set
CONFIG_ACPI_PCC=y
CONFIG_PMIC_OPREGION=y
CONFIG_X86_PM_TIMER=y
CONFIG_ACPI_PRMT=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
CONFIG_CPU_FREQ_STAT=y
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y

#
# CPU frequency scaling drivers
#
CONFIG_X86_INTEL_PSTATE=y
# CONFIG_X86_PCC_CPUFREQ is not set
# CONFIG_X86_AMD_PSTATE is not set
CONFIG_X86_ACPI_CPUFREQ=m
CONFIG_X86_ACPI_CPUFREQ_CPB=y
CONFIG_X86_POWERNOW_K8=m
# CONFIG_X86_AMD_FREQ_SENSITIVITY is not set
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
CONFIG_X86_P4_CLOCKMOD=m

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=m
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
# CONFIG_CPU_IDLE_GOV_LADDER is not set
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_CPU_IDLE_GOV_TEO is not set
# CONFIG_CPU_IDLE_GOV_HALTPOLL is not set
CONFIG_HALTPOLL_CPUIDLE=y
# end of CPU Idle

CONFIG_INTEL_IDLE=y
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_MMCONF_FAM10H=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
# CONFIG_ISA_BUS is not set
CONFIG_ISA_DMA_API=y
CONFIG_AMD_NB=y
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
CONFIG_IA32_EMULATION=y
# CONFIG_X86_X32_ABI is not set
CONFIG_COMPAT_32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
# end of Binary Emulations

CONFIG_HAVE_KVM=y
CONFIG_HAVE_KVM_PFNCACHE=y
CONFIG_HAVE_KVM_IRQCHIP=y
CONFIG_HAVE_KVM_IRQFD=y
CONFIG_HAVE_KVM_IRQ_ROUTING=y
CONFIG_HAVE_KVM_DIRTY_RING=y
CONFIG_HAVE_KVM_EVENTFD=y
CONFIG_KVM_MMIO=y
CONFIG_KVM_ASYNC_PF=y
CONFIG_HAVE_KVM_MSI=y
CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=y
CONFIG_KVM_VFIO=y
CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=y
CONFIG_KVM_COMPAT=y
CONFIG_HAVE_KVM_IRQ_BYPASS=y
CONFIG_HAVE_KVM_NO_POLL=y
CONFIG_KVM_XFER_TO_GUEST_WORK=y
CONFIG_HAVE_KVM_PM_NOTIFIER=y
CONFIG_VIRTUALIZATION=y
CONFIG_KVM=y
# CONFIG_KVM_WERROR is not set
CONFIG_KVM_INTEL=y
# CONFIG_X86_SGX_KVM is not set
# CONFIG_KVM_AMD is not set
# CONFIG_KVM_XEN is not set
CONFIG_AS_AVX512=y
CONFIG_AS_SHA1_NI=y
CONFIG_AS_SHA256_NI=y
CONFIG_AS_TPAUSE=y

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_HOTPLUG_SMT=y
CONFIG_GENERIC_ENTRY=y
CONFIG_KPROBES=y
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
# CONFIG_STATIC_CALL_SELFTEST is not set
CONFIG_OPTPROBES=y
CONFIG_KPROBES_ON_FTRACE=y
CONFIG_UPROBES=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_KRETPROBES=y
CONFIG_KRETPROBE_ON_RETHOOK=y
CONFIG_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_ARCH_CORRECT_STACKTRACE_ON_KRETPROBE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_ARCH_WANTS_NO_INSTR=y
CONFIG_HAVE_ASM_MODVERSIONS=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
CONFIG_MMU_GATHER_TABLE_FREE=y
CONFIG_MMU_GATHER_RCU_TABLE_FREE=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
CONFIG_HAVE_ARCH_SECCOMP=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP=y
CONFIG_SECCOMP_FILTER=y
# CONFIG_SECCOMP_CACHE_DEBUG is not set
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR_STRONG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG_THIN=y
CONFIG_LTO_NONE=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING=y
CONFIG_HAVE_CONTEXT_TRACKING_OFFSTACK=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PUD=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_HAVE_ARCH_HUGE_VMALLOC=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=28
CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
CONFIG_PAGE_SIZE_LESS_THAN_64KB=y
CONFIG_PAGE_SIZE_LESS_THAN_256KB=y
CONFIG_HAVE_OBJTOOL=y
CONFIG_HAVE_JUMP_LABEL_HACK=y
CONFIG_HAVE_NOINSTR_HACK=y
CONFIG_HAVE_NOINSTR_VALIDATION=y
CONFIG_HAVE_UACCESS_VALIDATION=y
CONFIG_HAVE_STACK_VALIDATION=y
CONFIG_HAVE_RELIABLE_STACKTRACE=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_COMPAT_OLD_SIGACTION=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_VMAP_STACK=y
CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET=y
CONFIG_RANDOMIZE_KSTACK_OFFSET=y
CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT=y
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
CONFIG_ARCH_USE_MEMREMAP_PROT=y
# CONFIG_LOCK_EVENT_COUNTS is not set
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_HAVE_STATIC_CALL=y
CONFIG_HAVE_STATIC_CALL_INLINE=y
CONFIG_HAVE_PREEMPT_DYNAMIC=y
CONFIG_HAVE_PREEMPT_DYNAMIC_CALL=y
CONFIG_ARCH_WANT_LD_ORPHAN_WARN=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_ARCH_SUPPORTS_PAGE_TABLE_CHECK=y
CONFIG_ARCH_HAS_ELFCORE_COMPAT=y
CONFIG_ARCH_HAS_PARANOID_L1D_FLUSH=y
CONFIG_DYNAMIC_SIGFRAME=y
CONFIG_HAVE_ARCH_NODE_DEV_GROUP=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_HAVE_GCC_PLUGINS=y
CONFIG_GCC_PLUGINS=y
# CONFIG_GCC_PLUGIN_LATENT_ENTROPY is not set
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULE_SIG_FORMAT=y
CONFIG_MODULES=y
CONFIG_MODULE_FORCE_LOAD=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODULE_UNLOAD_TAINT_TRACKING is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_MODULE_SIG=y
# CONFIG_MODULE_SIG_FORCE is not set
CONFIG_MODULE_SIG_ALL=y
# CONFIG_MODULE_SIG_SHA1 is not set
# CONFIG_MODULE_SIG_SHA224 is not set
CONFIG_MODULE_SIG_SHA256=y
# CONFIG_MODULE_SIG_SHA384 is not set
# CONFIG_MODULE_SIG_SHA512 is not set
CONFIG_MODULE_SIG_HASH="sha256"
CONFIG_MODULE_COMPRESS_NONE=y
# CONFIG_MODULE_COMPRESS_GZIP is not set
# CONFIG_MODULE_COMPRESS_XZ is not set
# CONFIG_MODULE_COMPRESS_ZSTD is not set
# CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
CONFIG_MODPROBE_PATH="/sbin/modprobe"
# CONFIG_TRIM_UNUSED_KSYMS is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLOCK_LEGACY_AUTOLOAD=y
CONFIG_BLK_CGROUP_RWSTAT=y
CONFIG_BLK_DEV_BSG_COMMON=y
CONFIG_BLK_ICQ=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_INTEGRITY_T10=m
# CONFIG_BLK_DEV_ZONED is not set
CONFIG_BLK_DEV_THROTTLING=y
# CONFIG_BLK_DEV_THROTTLING_LOW is not set
CONFIG_BLK_WBT=y
CONFIG_BLK_WBT_MQ=y
# CONFIG_BLK_CGROUP_IOLATENCY is not set
# CONFIG_BLK_CGROUP_IOCOST is not set
# CONFIG_BLK_CGROUP_IOPRIO is not set
CONFIG_BLK_DEBUG_FS=y
# CONFIG_BLK_SED_OPAL is not set
# CONFIG_BLK_INLINE_ENCRYPTION is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_EFI_PARTITION=y
# end of Partition Types

CONFIG_BLOCK_COMPAT=y
CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_PM=y
CONFIG_BLOCK_HOLDER_DEPRECATED=y
CONFIG_BLK_MQ_STACKING=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=y
CONFIG_IOSCHED_BFQ=y
CONFIG_BFQ_GROUP_IOSCHED=y
# CONFIG_BFQ_CGROUP_DEBUG is not set
# end of IO Schedulers

CONFIG_PREEMPT_NOTIFIERS=y
CONFIG_PADATA=y
CONFIG_ASN1=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_COMPAT_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=m
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
CONFIG_ZPOOL=y
CONFIG_SWAP=y
CONFIG_ZSWAP=y
# CONFIG_ZSWAP_DEFAULT_ON is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_DEFLATE is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZO=y
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_842 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4HC is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_ZSTD is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT="lzo"
CONFIG_ZSWAP_ZPOOL_DEFAULT_ZBUD=y
# CONFIG_ZSWAP_ZPOOL_DEFAULT_Z3FOLD is not set
# CONFIG_ZSWAP_ZPOOL_DEFAULT_ZSMALLOC is not set
CONFIG_ZSWAP_ZPOOL_DEFAULT="zbud"
CONFIG_ZBUD=y
# CONFIG_Z3FOLD is not set
CONFIG_ZSMALLOC=y
CONFIG_ZSMALLOC_STAT=y

#
# SLAB allocator options
#
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB is not set
CONFIG_SLAB_MERGE_DEFAULT=y
CONFIG_SLAB_FREELIST_RANDOM=y
CONFIG_SLAB_FREELIST_HARDENED=y
# CONFIG_SLUB_STATS is not set
CONFIG_SLUB_CPU_PARTIAL=y
# end of SLAB allocator options

CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
# CONFIG_COMPAT_BRK is not set
CONFIG_SPARSEMEM=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_NUMA_KEEP_MEMINFO=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_EXCLUSIVE_SYSTEM_RAM=y
CONFIG_HAVE_BOOTMEM_INFO_NODE=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_MEMORY_HOTPLUG=y
# CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_MHP_MEMMAP_ON_MEMORY=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_MEMORY_BALLOON=y
CONFIG_BALLOON_COMPACTION=y
CONFIG_COMPACTION=y
CONFIG_PAGE_REPORTING=y
CONFIG_MIGRATION=y
CONFIG_DEVICE_MIGRATION=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_VIRT_TO_BUS=y
CONFIG_MMU_NOTIFIER=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
CONFIG_MEMORY_FAILURE=y
CONFIG_HWPOISON_INJECT=m
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
CONFIG_THP_SWAP=y
# CONFIG_READ_ONLY_THP_FOR_FS is not set
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_FRONTSWAP=y
# CONFIG_CMA is not set
CONFIG_MEM_SOFT_DIRTY=y
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
CONFIG_PAGE_IDLE_FLAG=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_CURRENT_STACK_POINTER=y
CONFIG_ARCH_HAS_VM_GET_PAGE_PROT=y
CONFIG_ARCH_HAS_PTE_DEVMAP=y
CONFIG_ARCH_HAS_ZONE_DMA_SET=y
CONFIG_ZONE_DMA=y
CONFIG_ZONE_DMA32=y
CONFIG_ZONE_DEVICE=y
CONFIG_HMM_MIRROR=y
CONFIG_DEVICE_PRIVATE=y
CONFIG_VMAP_PFN=y
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
CONFIG_ARCH_HAS_PKEYS=y
CONFIG_VM_EVENT_COUNTERS=y
# CONFIG_PERCPU_STATS is not set
CONFIG_GUP_TEST=y
CONFIG_ARCH_HAS_PTE_SPECIAL=y
# CONFIG_ANON_VMA_NAME is not set
CONFIG_USERFAULTFD=y
CONFIG_HAVE_ARCH_USERFAULTFD_WP=y
CONFIG_HAVE_ARCH_USERFAULTFD_MINOR=y
CONFIG_PTE_MARKER=y
CONFIG_PTE_MARKER_UFFD_WP=y

#
# Data Access Monitoring
#
CONFIG_DAMON=y
CONFIG_DAMON_VADDR=y
CONFIG_DAMON_PADDR=y
# CONFIG_DAMON_SYSFS is not set
CONFIG_DAMON_DBGFS=y
# CONFIG_DAMON_RECLAIM is not set
# end of Data Access Monitoring
# end of Memory Management options

CONFIG_NET=y
CONFIG_NET_INGRESS=y
CONFIG_NET_EGRESS=y
CONFIG_NET_REDIRECT=y
CONFIG_SKB_EXTENSIONS=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_DIAG=m
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
CONFIG_AF_UNIX_OOB=y
CONFIG_UNIX_DIAG=m
CONFIG_TLS=m
CONFIG_TLS_DEVICE=y
# CONFIG_TLS_TOE is not set
CONFIG_XFRM=y
CONFIG_XFRM_OFFLOAD=y
CONFIG_XFRM_ALGO=y
CONFIG_XFRM_USER=y
# CONFIG_XFRM_USER_COMPAT is not set
# CONFIG_XFRM_INTERFACE is not set
CONFIG_XFRM_SUB_POLICY=y
CONFIG_XFRM_MIGRATE=y
CONFIG_XFRM_STATISTICS=y
CONFIG_XFRM_AH=m
CONFIG_XFRM_ESP=m
CONFIG_XFRM_IPCOMP=m
CONFIG_NET_KEY=m
CONFIG_NET_KEY_MIGRATE=y
CONFIG_XDP_SOCKETS=y
# CONFIG_XDP_SOCKETS_DIAG is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_FIB_TRIE_STATS=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IP_ROUTE_CLASSID=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
CONFIG_NET_IPIP=y
CONFIG_NET_IPGRE_DEMUX=y
CONFIG_NET_IP_TUNNEL=y
CONFIG_NET_IPGRE=y
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE_COMMON=y
CONFIG_IP_MROUTE=y
CONFIG_IP_MROUTE_MULTIPLE_TABLES=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
CONFIG_SYN_COOKIES=y
CONFIG_NET_IPVTI=m
CONFIG_NET_UDP_TUNNEL=y
CONFIG_NET_FOU=y
CONFIG_NET_FOU_IP_TUNNELS=y
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
CONFIG_INET_ESP_OFFLOAD=m
# CONFIG_INET_ESPINTCP is not set
CONFIG_INET_IPCOMP=m
CONFIG_INET_XFRM_TUNNEL=m
CONFIG_INET_TUNNEL=y
CONFIG_INET_DIAG=m
CONFIG_INET_TCP_DIAG=m
CONFIG_INET_UDP_DIAG=m
CONFIG_INET_RAW_DIAG=m
# CONFIG_INET_DIAG_DESTROY is not set
CONFIG_TCP_CONG_ADVANCED=y
CONFIG_TCP_CONG_BIC=m
CONFIG_TCP_CONG_CUBIC=y
CONFIG_TCP_CONG_WESTWOOD=m
CONFIG_TCP_CONG_HTCP=m
CONFIG_TCP_CONG_HSTCP=m
CONFIG_TCP_CONG_HYBLA=m
CONFIG_TCP_CONG_VEGAS=m
CONFIG_TCP_CONG_NV=m
CONFIG_TCP_CONG_SCALABLE=m
CONFIG_TCP_CONG_LP=m
CONFIG_TCP_CONG_VENO=m
CONFIG_TCP_CONG_YEAH=m
CONFIG_TCP_CONG_ILLINOIS=m
CONFIG_TCP_CONG_DCTCP=m
# CONFIG_TCP_CONG_CDG is not set
CONFIG_TCP_CONG_BBR=m
CONFIG_DEFAULT_CUBIC=y
# CONFIG_DEFAULT_RENO is not set
CONFIG_DEFAULT_TCP_CONG="cubic"
CONFIG_TCP_MD5SIG=y
CONFIG_IPV6=y
CONFIG_IPV6_ROUTER_PREF=y
CONFIG_IPV6_ROUTE_INFO=y
CONFIG_IPV6_OPTIMISTIC_DAD=y
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=m
CONFIG_INET6_ESP_OFFLOAD=m
# CONFIG_INET6_ESPINTCP is not set
CONFIG_INET6_IPCOMP=m
CONFIG_IPV6_MIP6=m
# CONFIG_IPV6_ILA is not set
CONFIG_INET6_XFRM_TUNNEL=m
CONFIG_INET6_TUNNEL=y
CONFIG_IPV6_VTI=m
CONFIG_IPV6_SIT=m
CONFIG_IPV6_SIT_6RD=y
CONFIG_IPV6_NDISC_NODETYPE=y
CONFIG_IPV6_TUNNEL=y
CONFIG_IPV6_GRE=y
CONFIG_IPV6_FOU=y
CONFIG_IPV6_FOU_TUNNEL=y
CONFIG_IPV6_MULTIPLE_TABLES=y
# CONFIG_IPV6_SUBTREES is not set
CONFIG_IPV6_MROUTE=y
CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
CONFIG_IPV6_PIMSM_V2=y
CONFIG_IPV6_SEG6_LWTUNNEL=y
# CONFIG_IPV6_SEG6_HMAC is not set
CONFIG_IPV6_SEG6_BPF=y
# CONFIG_IPV6_RPL_LWTUNNEL is not set
CONFIG_IPV6_IOAM6_LWTUNNEL=y
CONFIG_NETLABEL=y
CONFIG_MPTCP=y
CONFIG_INET_MPTCP_DIAG=m
CONFIG_MPTCP_IPV6=y
CONFIG_NETWORK_SECMARK=y
CONFIG_NET_PTP_CLASSIFY=y
CONFIG_NETWORK_PHY_TIMESTAMPING=y
CONFIG_NETFILTER=y
CONFIG_NETFILTER_ADVANCED=y
CONFIG_BRIDGE_NETFILTER=m

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_INGRESS=y
CONFIG_NETFILTER_EGRESS=y
CONFIG_NETFILTER_SKIP_EGRESS=y
CONFIG_NETFILTER_NETLINK=m
CONFIG_NETFILTER_FAMILY_BRIDGE=y
CONFIG_NETFILTER_FAMILY_ARP=y
# CONFIG_NETFILTER_NETLINK_HOOK is not set
# CONFIG_NETFILTER_NETLINK_ACCT is not set
CONFIG_NETFILTER_NETLINK_QUEUE=m
CONFIG_NETFILTER_NETLINK_LOG=m
CONFIG_NETFILTER_NETLINK_OSF=m
CONFIG_NF_CONNTRACK=m
CONFIG_NF_LOG_SYSLOG=m
CONFIG_NETFILTER_CONNCOUNT=m
CONFIG_NF_CONNTRACK_MARK=y
CONFIG_NF_CONNTRACK_SECMARK=y
CONFIG_NF_CONNTRACK_ZONES=y
CONFIG_NF_CONNTRACK_PROCFS=y
CONFIG_NF_CONNTRACK_EVENTS=y
CONFIG_NF_CONNTRACK_TIMEOUT=y
CONFIG_NF_CONNTRACK_TIMESTAMP=y
CONFIG_NF_CONNTRACK_LABELS=y
CONFIG_NF_CT_PROTO_DCCP=y
CONFIG_NF_CT_PROTO_GRE=y
CONFIG_NF_CT_PROTO_SCTP=y
CONFIG_NF_CT_PROTO_UDPLITE=y
CONFIG_NF_CONNTRACK_AMANDA=m
CONFIG_NF_CONNTRACK_FTP=m
CONFIG_NF_CONNTRACK_H323=m
CONFIG_NF_CONNTRACK_IRC=m
CONFIG_NF_CONNTRACK_BROADCAST=m
CONFIG_NF_CONNTRACK_NETBIOS_NS=m
CONFIG_NF_CONNTRACK_SNMP=m
CONFIG_NF_CONNTRACK_PPTP=m
CONFIG_NF_CONNTRACK_SANE=m
CONFIG_NF_CONNTRACK_SIP=m
CONFIG_NF_CONNTRACK_TFTP=m
CONFIG_NF_CT_NETLINK=m
CONFIG_NF_CT_NETLINK_TIMEOUT=m
CONFIG_NF_CT_NETLINK_HELPER=m
CONFIG_NETFILTER_NETLINK_GLUE_CT=y
CONFIG_NF_NAT=m
CONFIG_NF_NAT_AMANDA=m
CONFIG_NF_NAT_FTP=m
CONFIG_NF_NAT_IRC=m
CONFIG_NF_NAT_SIP=m
CONFIG_NF_NAT_TFTP=m
CONFIG_NF_NAT_REDIRECT=y
CONFIG_NF_NAT_MASQUERADE=y
CONFIG_NETFILTER_SYNPROXY=m
CONFIG_NF_TABLES=m
CONFIG_NF_TABLES_INET=y
CONFIG_NF_TABLES_NETDEV=y
CONFIG_NFT_NUMGEN=m
CONFIG_NFT_CT=m
CONFIG_NFT_FLOW_OFFLOAD=m
CONFIG_NFT_CONNLIMIT=m
CONFIG_NFT_LOG=m
CONFIG_NFT_LIMIT=m
CONFIG_NFT_MASQ=m
CONFIG_NFT_REDIR=m
CONFIG_NFT_NAT=m
# CONFIG_NFT_TUNNEL is not set
CONFIG_NFT_OBJREF=m
CONFIG_NFT_QUEUE=m
CONFIG_NFT_QUOTA=m
CONFIG_NFT_REJECT=m
CONFIG_NFT_REJECT_INET=m
CONFIG_NFT_COMPAT=m
CONFIG_NFT_HASH=m
CONFIG_NFT_FIB=m
CONFIG_NFT_FIB_INET=m
# CONFIG_NFT_XFRM is not set
CONFIG_NFT_SOCKET=m
# CONFIG_NFT_OSF is not set
CONFIG_NFT_TPROXY=m
CONFIG_NFT_SYNPROXY=m
CONFIG_NF_DUP_NETDEV=m
CONFIG_NFT_DUP_NETDEV=m
CONFIG_NFT_FWD_NETDEV=m
CONFIG_NFT_FIB_NETDEV=m
# CONFIG_NFT_REJECT_NETDEV is not set
CONFIG_NF_FLOW_TABLE_INET=m
CONFIG_NF_FLOW_TABLE=m
CONFIG_NETFILTER_XTABLES=y
CONFIG_NETFILTER_XTABLES_COMPAT=y

#
# Xtables combined modules
#
CONFIG_NETFILTER_XT_MARK=m
CONFIG_NETFILTER_XT_CONNMARK=m
CONFIG_NETFILTER_XT_SET=m

#
# Xtables targets
#
CONFIG_NETFILTER_XT_TARGET_AUDIT=m
CONFIG_NETFILTER_XT_TARGET_CHECKSUM=m
CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
CONFIG_NETFILTER_XT_TARGET_CONNMARK=m
CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=m
CONFIG_NETFILTER_XT_TARGET_CT=m
CONFIG_NETFILTER_XT_TARGET_DSCP=m
CONFIG_NETFILTER_XT_TARGET_HL=m
CONFIG_NETFILTER_XT_TARGET_HMARK=m
CONFIG_NETFILTER_XT_TARGET_IDLETIMER=m
# CONFIG_NETFILTER_XT_TARGET_LED is not set
CONFIG_NETFILTER_XT_TARGET_LOG=m
CONFIG_NETFILTER_XT_TARGET_MARK=m
CONFIG_NETFILTER_XT_NAT=m
CONFIG_NETFILTER_XT_TARGET_NETMAP=m
CONFIG_NETFILTER_XT_TARGET_NFLOG=m
CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
CONFIG_NETFILTER_XT_TARGET_NOTRACK=m
CONFIG_NETFILTER_XT_TARGET_RATEEST=m
CONFIG_NETFILTER_XT_TARGET_REDIRECT=m
CONFIG_NETFILTER_XT_TARGET_MASQUERADE=m
CONFIG_NETFILTER_XT_TARGET_TEE=m
CONFIG_NETFILTER_XT_TARGET_TPROXY=m
CONFIG_NETFILTER_XT_TARGET_TRACE=m
CONFIG_NETFILTER_XT_TARGET_SECMARK=m
CONFIG_NETFILTER_XT_TARGET_TCPMSS=m
CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=m

#
# Xtables matches
#
CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
CONFIG_NETFILTER_XT_MATCH_BPF=m
CONFIG_NETFILTER_XT_MATCH_CGROUP=m
CONFIG_NETFILTER_XT_MATCH_CLUSTER=m
CONFIG_NETFILTER_XT_MATCH_COMMENT=m
CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
CONFIG_NETFILTER_XT_MATCH_CONNLABEL=m
CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=m
CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
CONFIG_NETFILTER_XT_MATCH_CPU=m
CONFIG_NETFILTER_XT_MATCH_DCCP=m
CONFIG_NETFILTER_XT_MATCH_DEVGROUP=m
CONFIG_NETFILTER_XT_MATCH_DSCP=m
CONFIG_NETFILTER_XT_MATCH_ECN=m
CONFIG_NETFILTER_XT_MATCH_ESP=m
CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=m
CONFIG_NETFILTER_XT_MATCH_HELPER=m
CONFIG_NETFILTER_XT_MATCH_HL=m
# CONFIG_NETFILTER_XT_MATCH_IPCOMP is not set
CONFIG_NETFILTER_XT_MATCH_IPRANGE=m
CONFIG_NETFILTER_XT_MATCH_IPVS=m
# CONFIG_NETFILTER_XT_MATCH_L2TP is not set
CONFIG_NETFILTER_XT_MATCH_LENGTH=m
CONFIG_NETFILTER_XT_MATCH_LIMIT=m
CONFIG_NETFILTER_XT_MATCH_MAC=m
CONFIG_NETFILTER_XT_MATCH_MARK=m
CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
# CONFIG_NETFILTER_XT_MATCH_NFACCT is not set
CONFIG_NETFILTER_XT_MATCH_OSF=m
CONFIG_NETFILTER_XT_MATCH_OWNER=m
CONFIG_NETFILTER_XT_MATCH_POLICY=m
CONFIG_NETFILTER_XT_MATCH_PHYSDEV=m
CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
CONFIG_NETFILTER_XT_MATCH_QUOTA=m
CONFIG_NETFILTER_XT_MATCH_RATEEST=m
CONFIG_NETFILTER_XT_MATCH_REALM=m
CONFIG_NETFILTER_XT_MATCH_RECENT=m
CONFIG_NETFILTER_XT_MATCH_SCTP=m
CONFIG_NETFILTER_XT_MATCH_SOCKET=m
CONFIG_NETFILTER_XT_MATCH_STATE=m
CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
CONFIG_NETFILTER_XT_MATCH_STRING=m
CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
# CONFIG_NETFILTER_XT_MATCH_TIME is not set
# CONFIG_NETFILTER_XT_MATCH_U32 is not set
# end of Core Netfilter Configuration

CONFIG_IP_SET=m
CONFIG_IP_SET_MAX=256
CONFIG_IP_SET_BITMAP_IP=m
CONFIG_IP_SET_BITMAP_IPMAC=m
CONFIG_IP_SET_BITMAP_PORT=m
CONFIG_IP_SET_HASH_IP=m
CONFIG_IP_SET_HASH_IPMARK=m
CONFIG_IP_SET_HASH_IPPORT=m
CONFIG_IP_SET_HASH_IPPORTIP=m
CONFIG_IP_SET_HASH_IPPORTNET=m
CONFIG_IP_SET_HASH_IPMAC=m
CONFIG_IP_SET_HASH_MAC=m
CONFIG_IP_SET_HASH_NETPORTNET=m
CONFIG_IP_SET_HASH_NET=m
CONFIG_IP_SET_HASH_NETNET=m
CONFIG_IP_SET_HASH_NETPORT=m
CONFIG_IP_SET_HASH_NETIFACE=m
CONFIG_IP_SET_LIST_SET=m
CONFIG_IP_VS=m
CONFIG_IP_VS_IPV6=y
# CONFIG_IP_VS_DEBUG is not set
CONFIG_IP_VS_TAB_BITS=12

#
# IPVS transport protocol load balancing support
#
CONFIG_IP_VS_PROTO_TCP=y
CONFIG_IP_VS_PROTO_UDP=y
CONFIG_IP_VS_PROTO_AH_ESP=y
CONFIG_IP_VS_PROTO_ESP=y
CONFIG_IP_VS_PROTO_AH=y
CONFIG_IP_VS_PROTO_SCTP=y

#
# IPVS scheduler
#
CONFIG_IP_VS_RR=m
CONFIG_IP_VS_WRR=m
CONFIG_IP_VS_LC=m
CONFIG_IP_VS_WLC=m
CONFIG_IP_VS_FO=m
CONFIG_IP_VS_OVF=m
CONFIG_IP_VS_LBLC=m
CONFIG_IP_VS_LBLCR=m
CONFIG_IP_VS_DH=m
CONFIG_IP_VS_SH=m
# CONFIG_IP_VS_MH is not set
CONFIG_IP_VS_SED=m
CONFIG_IP_VS_NQ=m
# CONFIG_IP_VS_TWOS is not set

#
# IPVS SH scheduler
#
CONFIG_IP_VS_SH_TAB_BITS=8

#
# IPVS MH scheduler
#
CONFIG_IP_VS_MH_TAB_INDEX=12

#
# IPVS application helper
#
CONFIG_IP_VS_FTP=m
CONFIG_IP_VS_NFCT=y
CONFIG_IP_VS_PE_SIP=m

#
# IP: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV4=m
CONFIG_NF_SOCKET_IPV4=m
CONFIG_NF_TPROXY_IPV4=m
CONFIG_NF_TABLES_IPV4=y
CONFIG_NFT_REJECT_IPV4=m
CONFIG_NFT_DUP_IPV4=m
CONFIG_NFT_FIB_IPV4=m
CONFIG_NF_TABLES_ARP=y
CONFIG_NF_DUP_IPV4=m
CONFIG_NF_LOG_ARP=m
CONFIG_NF_LOG_IPV4=m
CONFIG_NF_REJECT_IPV4=m
CONFIG_NF_NAT_SNMP_BASIC=m
CONFIG_NF_NAT_PPTP=m
CONFIG_NF_NAT_H323=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_AH=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_RPFILTER=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_SYNPROXY=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_MANGLE=m
# CONFIG_IP_NF_TARGET_CLUSTERIP is not set
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_TTL=m
CONFIG_IP_NF_RAW=m
CONFIG_IP_NF_SECURITY=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m
# end of IP: Netfilter Configuration

#
# IPv6: Netfilter Configuration
#
CONFIG_NF_SOCKET_IPV6=m
CONFIG_NF_TPROXY_IPV6=m
CONFIG_NF_TABLES_IPV6=y
CONFIG_NFT_REJECT_IPV6=m
CONFIG_NFT_DUP_IPV6=m
CONFIG_NFT_FIB_IPV6=m
CONFIG_NF_DUP_IPV6=m
CONFIG_NF_REJECT_IPV6=m
CONFIG_NF_LOG_IPV6=m
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_AH=m
CONFIG_IP6_NF_MATCH_EUI64=m
CONFIG_IP6_NF_MATCH_FRAG=m
CONFIG_IP6_NF_MATCH_OPTS=m
CONFIG_IP6_NF_MATCH_HL=m
CONFIG_IP6_NF_MATCH_IPV6HEADER=m
CONFIG_IP6_NF_MATCH_MH=m
CONFIG_IP6_NF_MATCH_RPFILTER=m
CONFIG_IP6_NF_MATCH_RT=m
# CONFIG_IP6_NF_MATCH_SRH is not set
# CONFIG_IP6_NF_TARGET_HL is not set
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_REJECT=m
CONFIG_IP6_NF_TARGET_SYNPROXY=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_RAW=m
CONFIG_IP6_NF_SECURITY=m
CONFIG_IP6_NF_NAT=m
CONFIG_IP6_NF_TARGET_MASQUERADE=m
CONFIG_IP6_NF_TARGET_NPT=m
# end of IPv6: Netfilter Configuration

CONFIG_NF_DEFRAG_IPV6=m
CONFIG_NF_TABLES_BRIDGE=m
# CONFIG_NFT_BRIDGE_META is not set
CONFIG_NFT_BRIDGE_REJECT=m
# CONFIG_NF_CONNTRACK_BRIDGE is not set
CONFIG_BRIDGE_NF_EBTABLES=m
CONFIG_BRIDGE_EBT_BROUTE=m
CONFIG_BRIDGE_EBT_T_FILTER=m
CONFIG_BRIDGE_EBT_T_NAT=m
CONFIG_BRIDGE_EBT_802_3=m
CONFIG_BRIDGE_EBT_AMONG=m
CONFIG_BRIDGE_EBT_ARP=m
CONFIG_BRIDGE_EBT_IP=m
CONFIG_BRIDGE_EBT_IP6=m
CONFIG_BRIDGE_EBT_LIMIT=m
CONFIG_BRIDGE_EBT_MARK=m
CONFIG_BRIDGE_EBT_PKTTYPE=m
CONFIG_BRIDGE_EBT_STP=m
CONFIG_BRIDGE_EBT_VLAN=m
CONFIG_BRIDGE_EBT_ARPREPLY=m
CONFIG_BRIDGE_EBT_DNAT=m
CONFIG_BRIDGE_EBT_MARK_T=m
CONFIG_BRIDGE_EBT_REDIRECT=m
CONFIG_BRIDGE_EBT_SNAT=m
CONFIG_BRIDGE_EBT_LOG=m
CONFIG_BRIDGE_EBT_NFLOG=m
# CONFIG_BPFILTER is not set
# CONFIG_IP_DCCP is not set
CONFIG_IP_SCTP=m
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5 is not set
CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1=y
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
CONFIG_SCTP_COOKIE_HMAC_MD5=y
CONFIG_SCTP_COOKIE_HMAC_SHA1=y
CONFIG_INET_SCTP_DIAG=m
# CONFIG_RDS is not set
CONFIG_TIPC=m
CONFIG_TIPC_MEDIA_UDP=y
CONFIG_TIPC_CRYPTO=y
CONFIG_TIPC_DIAG=m
CONFIG_ATM=m
CONFIG_ATM_CLIP=m
# CONFIG_ATM_CLIP_NO_ICMP is not set
CONFIG_ATM_LANE=m
# CONFIG_ATM_MPOA is not set
CONFIG_ATM_BR2684=m
# CONFIG_ATM_BR2684_IPFILTER is not set
CONFIG_L2TP=m
CONFIG_L2TP_DEBUGFS=m
CONFIG_L2TP_V3=y
CONFIG_L2TP_IP=m
CONFIG_L2TP_ETH=m
CONFIG_STP=y
CONFIG_GARP=y
CONFIG_MRP=y
CONFIG_BRIDGE=y
CONFIG_BRIDGE_IGMP_SNOOPING=y
CONFIG_BRIDGE_VLAN_FILTERING=y
# CONFIG_BRIDGE_MRP is not set
# CONFIG_BRIDGE_CFM is not set
# CONFIG_NET_DSA is not set
CONFIG_VLAN_8021Q=y
CONFIG_VLAN_8021Q_GVRP=y
CONFIG_VLAN_8021Q_MVRP=y
# CONFIG_DECNET is not set
CONFIG_LLC=y
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
CONFIG_6LOWPAN=m
# CONFIG_6LOWPAN_DEBUGFS is not set
# CONFIG_6LOWPAN_NHC is not set
CONFIG_IEEE802154=m
# CONFIG_IEEE802154_NL802154_EXPERIMENTAL is not set
CONFIG_IEEE802154_SOCKET=m
CONFIG_IEEE802154_6LOWPAN=m
CONFIG_MAC802154=m
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_HFSC=m
CONFIG_NET_SCH_ATM=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_MULTIQ=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFB=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
# CONFIG_NET_SCH_CBS is not set
CONFIG_NET_SCH_ETF=m
# CONFIG_NET_SCH_TAPRIO is not set
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_NETEM=y
CONFIG_NET_SCH_DRR=m
CONFIG_NET_SCH_MQPRIO=m
# CONFIG_NET_SCH_SKBPRIO is not set
CONFIG_NET_SCH_CHOKE=m
CONFIG_NET_SCH_QFQ=m
CONFIG_NET_SCH_CODEL=m
CONFIG_NET_SCH_FQ_CODEL=y
# CONFIG_NET_SCH_CAKE is not set
CONFIG_NET_SCH_FQ=m
CONFIG_NET_SCH_HHF=m
CONFIG_NET_SCH_PIE=m
CONFIG_NET_SCH_FQ_PIE=m
CONFIG_NET_SCH_INGRESS=y
CONFIG_NET_SCH_PLUG=m
CONFIG_NET_SCH_ETS=m
CONFIG_NET_SCH_DEFAULT=y
# CONFIG_DEFAULT_FQ is not set
# CONFIG_DEFAULT_CODEL is not set
CONFIG_DEFAULT_FQ_CODEL=y
# CONFIG_DEFAULT_FQ_PIE is not set
# CONFIG_DEFAULT_SFQ is not set
# CONFIG_DEFAULT_PFIFO_FAST is not set
CONFIG_DEFAULT_NET_SCH="fq_codel"

#
# Classification
#
CONFIG_NET_CLS=y
CONFIG_NET_CLS_BASIC=m
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_CLS_U32_PERF=y
CONFIG_CLS_U32_MARK=y
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_RSVP6=m
CONFIG_NET_CLS_FLOW=m
CONFIG_NET_CLS_CGROUP=y
CONFIG_NET_CLS_BPF=m
CONFIG_NET_CLS_FLOWER=m
CONFIG_NET_CLS_MATCHALL=m
CONFIG_NET_EMATCH=y
CONFIG_NET_EMATCH_STACK=32
CONFIG_NET_EMATCH_CMP=m
CONFIG_NET_EMATCH_NBYTE=m
CONFIG_NET_EMATCH_U32=m
CONFIG_NET_EMATCH_META=m
CONFIG_NET_EMATCH_TEXT=m
CONFIG_NET_EMATCH_CANID=m
CONFIG_NET_EMATCH_IPSET=m
CONFIG_NET_EMATCH_IPT=m
CONFIG_NET_CLS_ACT=y
CONFIG_NET_ACT_POLICE=m
CONFIG_NET_ACT_GACT=m
CONFIG_GACT_PROB=y
CONFIG_NET_ACT_MIRRED=m
CONFIG_NET_ACT_SAMPLE=m
CONFIG_NET_ACT_IPT=m
CONFIG_NET_ACT_NAT=m
CONFIG_NET_ACT_PEDIT=m
CONFIG_NET_ACT_SIMP=m
CONFIG_NET_ACT_SKBEDIT=m
CONFIG_NET_ACT_CSUM=m
CONFIG_NET_ACT_MPLS=m
CONFIG_NET_ACT_VLAN=m
CONFIG_NET_ACT_BPF=m
CONFIG_NET_ACT_CONNMARK=m
CONFIG_NET_ACT_CTINFO=m
CONFIG_NET_ACT_SKBMOD=m
CONFIG_NET_ACT_IFE=m
CONFIG_NET_ACT_TUNNEL_KEY=m
CONFIG_NET_ACT_CT=m
# CONFIG_NET_ACT_GATE is not set
CONFIG_NET_IFE_SKBMARK=m
CONFIG_NET_IFE_SKBPRIO=m
CONFIG_NET_IFE_SKBTCINDEX=m
# CONFIG_NET_TC_SKB_EXT is not set
CONFIG_NET_SCH_FIFO=y
CONFIG_DCB=y
CONFIG_DNS_RESOLVER=m
# CONFIG_BATMAN_ADV is not set
CONFIG_OPENVSWITCH=m
CONFIG_OPENVSWITCH_GRE=m
CONFIG_OPENVSWITCH_VXLAN=m
CONFIG_OPENVSWITCH_GENEVE=m
CONFIG_VSOCKETS=m
CONFIG_VSOCKETS_DIAG=m
CONFIG_VSOCKETS_LOOPBACK=m
CONFIG_VMWARE_VMCI_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS_COMMON=m
CONFIG_NETLINK_DIAG=m
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=m
CONFIG_MPLS_ROUTING=m
CONFIG_MPLS_IPTUNNEL=m
CONFIG_NET_NSH=y
# CONFIG_HSR is not set
CONFIG_NET_SWITCHDEV=y
CONFIG_NET_L3_MASTER_DEV=y
# CONFIG_QRTR is not set
# CONFIG_NET_NCSI is not set
CONFIG_PCPU_DEV_REFCNT=y
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_SOCK_RX_QUEUE_MAPPING=y
CONFIG_XPS=y
CONFIG_CGROUP_NET_PRIO=y
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_BPF_STREAM_PARSER=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
CONFIG_NET_PKTGEN=m
CONFIG_NET_DROP_MONITOR=y
# end of Network testing
# end of Networking options

# CONFIG_HAMRADIO is not set
CONFIG_CAN=m
CONFIG_CAN_RAW=m
CONFIG_CAN_BCM=m
CONFIG_CAN_GW=m
# CONFIG_CAN_J1939 is not set
# CONFIG_CAN_ISOTP is not set

#
# CAN Device Drivers
#
CONFIG_CAN_VCAN=m
# CONFIG_CAN_VXCAN is not set
CONFIG_CAN_SLCAN=m
CONFIG_CAN_DEV=m
CONFIG_CAN_CALC_BITTIMING=y
# CONFIG_CAN_KVASER_PCIEFD is not set
CONFIG_CAN_C_CAN=m
CONFIG_CAN_C_CAN_PLATFORM=m
CONFIG_CAN_C_CAN_PCI=m
CONFIG_CAN_CC770=m
# CONFIG_CAN_CC770_ISA is not set
CONFIG_CAN_CC770_PLATFORM=m
# CONFIG_CAN_CTUCANFD_PCI is not set
# CONFIG_CAN_IFI_CANFD is not set
# CONFIG_CAN_M_CAN is not set
# CONFIG_CAN_PEAK_PCIEFD is not set
CONFIG_CAN_SJA1000=m
CONFIG_CAN_EMS_PCI=m
# CONFIG_CAN_F81601 is not set
CONFIG_CAN_KVASER_PCI=m
CONFIG_CAN_PEAK_PCI=m
CONFIG_CAN_PEAK_PCIEC=y
CONFIG_CAN_PLX_PCI=m
# CONFIG_CAN_SJA1000_ISA is not set
CONFIG_CAN_SJA1000_PLATFORM=m
CONFIG_CAN_SOFTING=m

#
# CAN SPI interfaces
#
# CONFIG_CAN_HI311X is not set
# CONFIG_CAN_MCP251X is not set
# CONFIG_CAN_MCP251XFD is not set
# end of CAN SPI interfaces

#
# CAN USB interfaces
#
# CONFIG_CAN_8DEV_USB is not set
# CONFIG_CAN_EMS_USB is not set
# CONFIG_CAN_ESD_USB2 is not set
# CONFIG_CAN_ETAS_ES58X is not set
# CONFIG_CAN_GS_USB is not set
# CONFIG_CAN_KVASER_USB is not set
# CONFIG_CAN_MCBA_USB is not set
# CONFIG_CAN_PEAK_USB is not set
# CONFIG_CAN_UCAN is not set
# end of CAN USB interfaces

# CONFIG_CAN_DEBUG_DEVICES is not set
# end of CAN Device Drivers

# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_STREAM_PARSER=y
# CONFIG_MCTP is not set
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
CONFIG_CFG80211=m
# CONFIG_NL80211_TESTMODE is not set
# CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
# CONFIG_CFG80211_CERTIFICATION_ONUS is not set
CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=y
CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=y
CONFIG_CFG80211_DEFAULT_PS=y
# CONFIG_CFG80211_DEBUGFS is not set
CONFIG_CFG80211_CRDA_SUPPORT=y
# CONFIG_CFG80211_WEXT is not set
CONFIG_MAC80211=m
CONFIG_MAC80211_HAS_RC=y
CONFIG_MAC80211_RC_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT="minstrel_ht"
# CONFIG_MAC80211_MESH is not set
CONFIG_MAC80211_LEDS=y
CONFIG_MAC80211_DEBUGFS=y
# CONFIG_MAC80211_MESSAGE_TRACING is not set
# CONFIG_MAC80211_DEBUG_MENU is not set
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
CONFIG_RFKILL=m
CONFIG_RFKILL_LEDS=y
CONFIG_RFKILL_INPUT=y
# CONFIG_RFKILL_GPIO is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_FD=y
CONFIG_NET_9P_VIRTIO=y
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
CONFIG_CEPH_LIB=m
# CONFIG_CEPH_LIB_PRETTYDEBUG is not set
CONFIG_CEPH_LIB_USE_DNS_RESOLVER=y
CONFIG_NFC=m
# CONFIG_NFC_DIGITAL is not set
CONFIG_NFC_NCI=m
# CONFIG_NFC_NCI_SPI is not set
# CONFIG_NFC_NCI_UART is not set
# CONFIG_NFC_HCI is not set

#
# Near Field Communication (NFC) devices
#
CONFIG_NFC_VIRTUAL_NCI=m
# CONFIG_NFC_FDP is not set
# CONFIG_NFC_PN533_USB is not set
# CONFIG_NFC_PN533_I2C is not set
# CONFIG_NFC_MRVL_USB is not set
# CONFIG_NFC_ST_NCI_I2C is not set
# CONFIG_NFC_ST_NCI_SPI is not set
# CONFIG_NFC_NXP_NCI is not set
# CONFIG_NFC_S3FWRN5_I2C is not set
# end of Near Field Communication (NFC) devices

CONFIG_PSAMPLE=m
CONFIG_NET_IFE=m
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_SOCK_VALIDATE_XMIT=y
CONFIG_NET_SELFTESTS=y
CONFIG_NET_SOCK_MSG=y
CONFIG_NET_DEVLINK=y
CONFIG_PAGE_POOL=y
# CONFIG_PAGE_POOL_STATS is not set
CONFIG_FAILOVER=m
CONFIG_ETHTOOL_NETLINK=y

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
# CONFIG_EISA is not set
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCIEPORTBUS=y
CONFIG_HOTPLUG_PCI_PCIE=y
CONFIG_PCIEAER=y
CONFIG_PCIEAER_INJECT=m
CONFIG_PCIE_ECRC=y
CONFIG_PCIEASPM=y
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
CONFIG_PCIE_PME=y
CONFIG_PCIE_DPC=y
# CONFIG_PCIE_PTM is not set
# CONFIG_PCIE_EDR is not set
CONFIG_PCI_MSI=y
CONFIG_PCI_MSI_IRQ_DOMAIN=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
CONFIG_PCI_STUB=y
CONFIG_PCI_PF_STUB=m
CONFIG_PCI_ATS=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
CONFIG_PCI_PRI=y
CONFIG_PCI_PASID=y
# CONFIG_PCI_P2PDMA is not set
CONFIG_PCI_LABEL=y
# CONFIG_PCIE_BUS_TUNE_OFF is not set
CONFIG_PCIE_BUS_DEFAULT=y
# CONFIG_PCIE_BUS_SAFE is not set
# CONFIG_PCIE_BUS_PERFORMANCE is not set
# CONFIG_PCIE_BUS_PEER2PEER is not set
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=64
CONFIG_HOTPLUG_PCI=y
CONFIG_HOTPLUG_PCI_ACPI=y
CONFIG_HOTPLUG_PCI_ACPI_IBM=m
# CONFIG_HOTPLUG_PCI_CPCI is not set
CONFIG_HOTPLUG_PCI_SHPC=y

#
# PCI controller drivers
#
CONFIG_VMD=y

#
# DesignWare PCI Core Support
#
# CONFIG_PCIE_DW_PLAT_HOST is not set
# CONFIG_PCI_MESON is not set
# end of DesignWare PCI Core Support

#
# Mobiveil PCIe Core Support
#
# end of Mobiveil PCIe Core Support

#
# Cadence PCIe controllers support
#
# end of Cadence PCIe controllers support
# end of PCI controller drivers

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set
# end of PCI Endpoint

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
# end of PCI switch controller drivers

# CONFIG_CXL_BUS is not set
# CONFIG_PCCARD is not set
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
CONFIG_AUXILIARY_BUS=y
# CONFIG_UEVENT_HELPER is not set
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
# CONFIG_DEVTMPFS_SAFE is not set
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_FW_LOADER_SYSFS=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
# CONFIG_FW_LOADER_COMPRESS is not set
CONFIG_FW_CACHE=y
CONFIG_FW_UPLOAD=y
# end of Firmware loader

CONFIG_ALLOW_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=m
CONFIG_REGMAP_SPI=m
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# end of Generic Driver Options

#
# Bus devices
#
# CONFIG_MHI_BUS is not set
# CONFIG_MHI_BUS_EP is not set
# end of Bus devices

CONFIG_CONNECTOR=y
CONFIG_PROC_EVENTS=y

#
# Firmware Drivers
#

#
# ARM System Control and Management Interface Protocol
#
# end of ARM System Control and Management Interface Protocol

CONFIG_EDD=m
# CONFIG_EDD_OFF is not set
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DMIID=y
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
# CONFIG_ISCSI_IBFT is not set
CONFIG_FW_CFG_SYSFS=y
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
CONFIG_SYSFB=y
# CONFIG_SYSFB_SIMPLEFB is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# EFI (Extensible Firmware Interface) Support
#
CONFIG_EFI_VARS=y
CONFIG_EFI_ESRT=y
CONFIG_EFI_VARS_PSTORE=y
CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE=y
CONFIG_EFI_RUNTIME_MAP=y
# CONFIG_EFI_FAKE_MEMMAP is not set
CONFIG_EFI_DXE_MEM_ATTRIBUTES=y
CONFIG_EFI_RUNTIME_WRAPPERS=y
CONFIG_EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER=y
# CONFIG_EFI_BOOTLOADER_CONTROL is not set
# CONFIG_EFI_CAPSULE_LOADER is not set
# CONFIG_EFI_TEST is not set
# CONFIG_APPLE_PROPERTIES is not set
# CONFIG_RESET_ATTACK_MITIGATION is not set
# CONFIG_EFI_RCI2_TABLE is not set
# CONFIG_EFI_DISABLE_PCI_DMA is not set
CONFIG_EFI_EARLYCON=y
CONFIG_EFI_CUSTOM_SSDT_OVERLAYS=y
# CONFIG_EFI_DISABLE_RUNTIME is not set
# CONFIG_EFI_COCO_SECRET is not set
# end of EFI (Extensible Firmware Interface) Support

CONFIG_UEFI_CPER=y
CONFIG_UEFI_CPER_X86=y

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

# CONFIG_GNSS is not set
# CONFIG_MTD is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_SERIAL=m
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_AX88796 is not set
CONFIG_PARPORT_1284=y
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_NULL_BLK=m
# CONFIG_BLK_DEV_FD is not set
CONFIG_CDROM=m
# CONFIG_PARIDE is not set
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
CONFIG_ZRAM=m
CONFIG_ZRAM_DEF_COMP_LZORLE=y
# CONFIG_ZRAM_DEF_COMP_LZO is not set
CONFIG_ZRAM_DEF_COMP="lzo-rle"
CONFIG_ZRAM_WRITEBACK=y
# CONFIG_ZRAM_MEMORY_TRACKING is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_LOOP_MIN_COUNT=0
# CONFIG_BLK_DEV_DRBD is not set
CONFIG_BLK_DEV_NBD=m
# CONFIG_BLK_DEV_SX8 is not set
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=16384
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
# CONFIG_ATA_OVER_ETH is not set
CONFIG_VIRTIO_BLK=m
CONFIG_BLK_DEV_RBD=m

#
# NVME Support
#
CONFIG_NVME_CORE=m
CONFIG_BLK_DEV_NVME=m
CONFIG_NVME_MULTIPATH=y
# CONFIG_NVME_VERBOSE_ERRORS is not set
# CONFIG_NVME_HWMON is not set
CONFIG_NVME_FABRICS=m
# CONFIG_NVME_FC is not set
# CONFIG_NVME_TCP is not set
CONFIG_NVME_TARGET=m
# CONFIG_NVME_TARGET_PASSTHRU is not set
CONFIG_NVME_TARGET_LOOP=m
CONFIG_NVME_TARGET_FC=m
# CONFIG_NVME_TARGET_TCP is not set
# end of NVME Support

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=m
# CONFIG_AD525X_DPOT is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
CONFIG_TIFM_CORE=m
CONFIG_TIFM_7XX1=m
# CONFIG_ICS932S401 is not set
CONFIG_ENCLOSURE_SERVICES=m
CONFIG_SGI_XP=m
CONFIG_HP_ILO=m
CONFIG_SGI_GRU=m
# CONFIG_SGI_GRU_DEBUG is not set
CONFIG_APDS9802ALS=m
CONFIG_ISL29003=m
CONFIG_ISL29020=m
CONFIG_SENSORS_TSL2550=m
CONFIG_SENSORS_BH1770=m
CONFIG_SENSORS_APDS990X=m
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
CONFIG_VMWARE_BALLOON=m
# CONFIG_LATTICE_ECP3_CONFIG is not set
# CONFIG_SRAM is not set
# CONFIG_DW_XDATA_PCIE is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_XILINX_SDFEC is not set
CONFIG_MISC_RTSX=m
# CONFIG_C2PORT is not set

#
# EEPROM support
#
# CONFIG_EEPROM_AT24 is not set
# CONFIG_EEPROM_AT25 is not set
CONFIG_EEPROM_LEGACY=m
CONFIG_EEPROM_MAX6875=m
CONFIG_EEPROM_93CX6=m
# CONFIG_EEPROM_93XX46 is not set
# CONFIG_EEPROM_IDT_89HPESX is not set
# CONFIG_EEPROM_EE1004 is not set
# end of EEPROM support

CONFIG_CB710_CORE=m
# CONFIG_CB710_DEBUG is not set
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

CONFIG_SENSORS_LIS3_I2C=m
CONFIG_ALTERA_STAPL=m
CONFIG_INTEL_MEI=m
CONFIG_INTEL_MEI_ME=m
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_INTEL_MEI_GSC is not set
# CONFIG_INTEL_MEI_HDCP is not set
# CONFIG_INTEL_MEI_PXP is not set
CONFIG_VMWARE_VMCI=m
# CONFIG_GENWQE is not set
# CONFIG_ECHO is not set
# CONFIG_BCM_VK is not set
# CONFIG_MISC_ALCOR_PCI is not set
CONFIG_MISC_RTSX_PCI=m
# CONFIG_MISC_RTSX_USB is not set
# CONFIG_HABANA_AI is not set
# CONFIG_UACCE is not set
CONFIG_PVPANIC=y
# CONFIG_PVPANIC_MMIO is not set
# CONFIG_PVPANIC_PCI is not set
# end of Misc devices

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=m
CONFIG_SCSI_COMMON=y
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_NETLINK=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
CONFIG_CHR_DEV_ST=m
CONFIG_BLK_DEV_SR=m
CONFIG_CHR_DEV_SG=m
CONFIG_BLK_DEV_BSG=y
CONFIG_CHR_DEV_SCH=m
CONFIG_SCSI_ENCLOSURE=m
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=m
CONFIG_SCSI_FC_ATTRS=m
CONFIG_SCSI_ISCSI_ATTRS=m
CONFIG_SCSI_SAS_ATTRS=m
CONFIG_SCSI_SAS_LIBSAS=m
CONFIG_SCSI_SAS_ATA=y
CONFIG_SCSI_SAS_HOST_SMP=y
CONFIG_SCSI_SRP_ATTRS=m
# end of SCSI Transports

CONFIG_SCSI_LOWLEVEL=y
# CONFIG_ISCSI_TCP is not set
# CONFIG_ISCSI_BOOT_SYSFS is not set
# CONFIG_SCSI_CXGB3_ISCSI is not set
# CONFIG_SCSI_CXGB4_ISCSI is not set
# CONFIG_SCSI_BNX2_ISCSI is not set
# CONFIG_BE2ISCSI is not set
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_HPSA is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_3W_SAS is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_AIC94XX is not set
# CONFIG_SCSI_MVSAS is not set
# CONFIG_SCSI_MVUMI is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_ARCMSR is not set
# CONFIG_SCSI_ESAS2R is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_MEGARAID_SAS is not set
CONFIG_SCSI_MPT3SAS=m
CONFIG_SCSI_MPT2SAS_MAX_SGE=128
CONFIG_SCSI_MPT3SAS_MAX_SGE=128
# CONFIG_SCSI_MPT2SAS is not set
# CONFIG_SCSI_MPI3MR is not set
# CONFIG_SCSI_SMARTPQI is not set
# CONFIG_SCSI_HPTIOP is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_MYRB is not set
# CONFIG_SCSI_MYRS is not set
# CONFIG_VMWARE_PVSCSI is not set
# CONFIG_LIBFC is not set
# CONFIG_SCSI_SNIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_FDOMAIN_PCI is not set
CONFIG_SCSI_ISCI=m
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_STEX is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLA_FC is not set
# CONFIG_SCSI_QLA_ISCSI is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_EFCT is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_WD719X is not set
# CONFIG_SCSI_DEBUG is not set
# CONFIG_SCSI_PMCRAID is not set
# CONFIG_SCSI_PM8001 is not set
# CONFIG_SCSI_BFA_FC is not set
# CONFIG_SCSI_VIRTIO is not set
# CONFIG_SCSI_CHELSIO_FCOE is not set
CONFIG_SCSI_DH=y
CONFIG_SCSI_DH_RDAC=y
CONFIG_SCSI_DH_HP_SW=y
CONFIG_SCSI_DH_EMC=y
CONFIG_SCSI_DH_ALUA=y
# end of SCSI device support

CONFIG_ATA=m
CONFIG_SATA_HOST=y
CONFIG_PATA_TIMINGS=y
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_FORCE=y
CONFIG_ATA_ACPI=y
# CONFIG_SATA_ZPODD is not set
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI=m
CONFIG_SATA_MOBILE_LPM_POLICY=0
CONFIG_SATA_AHCI_PLATFORM=m
# CONFIG_SATA_INIC162X is not set
# CONFIG_SATA_ACARD_AHCI is not set
# CONFIG_SATA_SIL24 is not set
CONFIG_ATA_SFF=y

#
# SFF controllers with custom DMA interface
#
# CONFIG_PDC_ADMA is not set
# CONFIG_SATA_QSTOR is not set
# CONFIG_SATA_SX4 is not set
CONFIG_ATA_BMDMA=y

#
# SATA SFF controllers with BMDMA
#
CONFIG_ATA_PIIX=m
# CONFIG_SATA_DWC is not set
# CONFIG_SATA_MV is not set
# CONFIG_SATA_NV is not set
# CONFIG_SATA_PROMISE is not set
# CONFIG_SATA_SIL is not set
# CONFIG_SATA_SIS is not set
# CONFIG_SATA_SVW is not set
# CONFIG_SATA_ULI is not set
# CONFIG_SATA_VIA is not set
# CONFIG_SATA_VITESSE is not set

#
# PATA SFF controllers with BMDMA
#
# CONFIG_PATA_ALI is not set
# CONFIG_PATA_AMD is not set
# CONFIG_PATA_ARTOP is not set
# CONFIG_PATA_ATIIXP is not set
# CONFIG_PATA_ATP867X is not set
# CONFIG_PATA_CMD64X is not set
# CONFIG_PATA_CYPRESS is not set
# CONFIG_PATA_EFAR is not set
# CONFIG_PATA_HPT366 is not set
# CONFIG_PATA_HPT37X is not set
# CONFIG_PATA_HPT3X2N is not set
# CONFIG_PATA_HPT3X3 is not set
# CONFIG_PATA_IT8213 is not set
# CONFIG_PATA_IT821X is not set
# CONFIG_PATA_JMICRON is not set
# CONFIG_PATA_MARVELL is not set
# CONFIG_PATA_NETCELL is not set
# CONFIG_PATA_NINJA32 is not set
# CONFIG_PATA_NS87415 is not set
# CONFIG_PATA_OLDPIIX is not set
# CONFIG_PATA_OPTIDMA is not set
# CONFIG_PATA_PDC2027X is not set
# CONFIG_PATA_PDC_OLD is not set
# CONFIG_PATA_RADISYS is not set
# CONFIG_PATA_RDC is not set
# CONFIG_PATA_SCH is not set
# CONFIG_PATA_SERVERWORKS is not set
# CONFIG_PATA_SIL680 is not set
# CONFIG_PATA_SIS is not set
# CONFIG_PATA_TOSHIBA is not set
# CONFIG_PATA_TRIFLEX is not set
# CONFIG_PATA_VIA is not set
# CONFIG_PATA_WINBOND is not set

#
# PIO-only SFF controllers
#
# CONFIG_PATA_CMD640_PCI is not set
# CONFIG_PATA_MPIIX is not set
# CONFIG_PATA_NS87410 is not set
# CONFIG_PATA_OPTI is not set
# CONFIG_PATA_PLATFORM is not set
# CONFIG_PATA_RZ1000 is not set

#
# Generic fallback / legacy drivers
#
# CONFIG_PATA_ACPI is not set
CONFIG_ATA_GENERIC=m
# CONFIG_PATA_LEGACY is not set
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_AUTODETECT=y
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID10=m
CONFIG_MD_RAID456=m
# CONFIG_MD_MULTIPATH is not set
CONFIG_MD_FAULTY=m
CONFIG_MD_CLUSTER=m
# CONFIG_BCACHE is not set
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_BLK_DEV_DM=m
CONFIG_DM_DEBUG=y
CONFIG_DM_BUFIO=m
# CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
CONFIG_DM_BIO_PRISON=m
CONFIG_DM_PERSISTENT_DATA=m
# CONFIG_DM_UNSTRIPED is not set
CONFIG_DM_CRYPT=m
CONFIG_DM_SNAPSHOT=m
CONFIG_DM_THIN_PROVISIONING=m
CONFIG_DM_CACHE=m
CONFIG_DM_CACHE_SMQ=m
CONFIG_DM_WRITECACHE=m
# CONFIG_DM_EBS is not set
CONFIG_DM_ERA=m
# CONFIG_DM_CLONE is not set
CONFIG_DM_MIRROR=m
CONFIG_DM_LOG_USERSPACE=m
CONFIG_DM_RAID=m
CONFIG_DM_ZERO=m
CONFIG_DM_MULTIPATH=m
CONFIG_DM_MULTIPATH_QL=m
CONFIG_DM_MULTIPATH_ST=m
# CONFIG_DM_MULTIPATH_HST is not set
# CONFIG_DM_MULTIPATH_IOA is not set
CONFIG_DM_DELAY=m
# CONFIG_DM_DUST is not set
CONFIG_DM_UEVENT=y
CONFIG_DM_FLAKEY=m
CONFIG_DM_VERITY=m
# CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG is not set
# CONFIG_DM_VERITY_FEC is not set
CONFIG_DM_SWITCH=m
CONFIG_DM_LOG_WRITES=m
CONFIG_DM_INTEGRITY=m
CONFIG_DM_AUDIT=y
CONFIG_TARGET_CORE=m
CONFIG_TCM_IBLOCK=m
CONFIG_TCM_FILEIO=m
CONFIG_TCM_PSCSI=m
CONFIG_TCM_USER2=m
CONFIG_LOOPBACK_TARGET=m
CONFIG_ISCSI_TARGET=m
# CONFIG_SBP_TARGET is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=m
CONFIG_FIREWIRE_OHCI=m
CONFIG_FIREWIRE_SBP2=m
CONFIG_FIREWIRE_NET=m
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

CONFIG_MACINTOSH_DRIVERS=y
CONFIG_MAC_EMUMOUSEBTN=y
CONFIG_NETDEVICES=y
CONFIG_MII=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
CONFIG_DUMMY=y
# CONFIG_WIREGUARD is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_FC is not set
CONFIG_IFB=m
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
CONFIG_VXLAN=y
CONFIG_GENEVE=y
CONFIG_BAREUDP=m
# CONFIG_GTP is not set
CONFIG_AMT=m
CONFIG_MACSEC=y
CONFIG_NETCONSOLE=m
CONFIG_NETCONSOLE_DYNAMIC=y
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
CONFIG_TUN=m
# CONFIG_TUN_VNET_CROSS_LE is not set
CONFIG_VETH=y
CONFIG_VIRTIO_NET=m
# CONFIG_NLMON is not set
CONFIG_NET_VRF=y
# CONFIG_VSOCKMON is not set
# CONFIG_ARCNET is not set
CONFIG_ATM_DRIVERS=y
# CONFIG_ATM_DUMMY is not set
# CONFIG_ATM_TCP is not set
# CONFIG_ATM_LANAI is not set
# CONFIG_ATM_ENI is not set
# CONFIG_ATM_NICSTAR is not set
# CONFIG_ATM_IDT77252 is not set
# CONFIG_ATM_IA is not set
# CONFIG_ATM_FORE200E is not set
# CONFIG_ATM_HE is not set
# CONFIG_ATM_SOLOS is not set
CONFIG_ETHERNET=y
CONFIG_MDIO=y
# CONFIG_NET_VENDOR_3COM is not set
CONFIG_NET_VENDOR_ADAPTEC=y
# CONFIG_ADAPTEC_STARFIRE is not set
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
CONFIG_NET_VENDOR_ALACRITECH=y
# CONFIG_SLICOSS is not set
CONFIG_NET_VENDOR_ALTEON=y
# CONFIG_ACENIC is not set
# CONFIG_ALTERA_TSE is not set
CONFIG_NET_VENDOR_AMAZON=y
# CONFIG_ENA_ETHERNET is not set
# CONFIG_NET_VENDOR_AMD is not set
CONFIG_NET_VENDOR_AQUANTIA=y
# CONFIG_AQTION is not set
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ASIX=y
# CONFIG_SPI_AX88796C is not set
CONFIG_NET_VENDOR_ATHEROS=y
# CONFIG_ATL2 is not set
# CONFIG_ATL1 is not set
# CONFIG_ATL1E is not set
# CONFIG_ATL1C is not set
# CONFIG_ALX is not set
# CONFIG_CX_ECAT is not set
CONFIG_NET_VENDOR_BROADCOM=y
# CONFIG_B44 is not set
# CONFIG_BCMGENET is not set
# CONFIG_BNX2 is not set
# CONFIG_CNIC is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2X is not set
# CONFIG_SYSTEMPORT is not set
# CONFIG_BNXT is not set
CONFIG_NET_VENDOR_CADENCE=y
# CONFIG_MACB is not set
CONFIG_NET_VENDOR_CAVIUM=y
# CONFIG_THUNDER_NIC_PF is not set
# CONFIG_THUNDER_NIC_VF is not set
# CONFIG_THUNDER_NIC_BGX is not set
# CONFIG_THUNDER_NIC_RGX is not set
CONFIG_CAVIUM_PTP=y
# CONFIG_LIQUIDIO is not set
# CONFIG_LIQUIDIO_VF is not set
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_NET_VENDOR_CISCO=y
# CONFIG_ENIC is not set
CONFIG_NET_VENDOR_CORTINA=y
CONFIG_NET_VENDOR_DAVICOM=y
# CONFIG_DM9051 is not set
# CONFIG_DNET is not set
CONFIG_NET_VENDOR_DEC=y
# CONFIG_NET_TULIP is not set
CONFIG_NET_VENDOR_DLINK=y
# CONFIG_DL2K is not set
# CONFIG_SUNDANCE is not set
CONFIG_NET_VENDOR_EMULEX=y
# CONFIG_BE2NET is not set
CONFIG_NET_VENDOR_ENGLEDER=y
# CONFIG_TSNEP is not set
CONFIG_NET_VENDOR_EZCHIP=y
CONFIG_NET_VENDOR_FUNGIBLE=y
# CONFIG_FUN_ETH is not set
CONFIG_NET_VENDOR_GOOGLE=y
# CONFIG_GVE is not set
CONFIG_NET_VENDOR_HUAWEI=y
# CONFIG_HINIC is not set
CONFIG_NET_VENDOR_I825XX=y
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
CONFIG_E1000E=y
CONFIG_E1000E_HWTS=y
CONFIG_IGB=y
CONFIG_IGB_HWMON=y
# CONFIG_IGBVF is not set
# CONFIG_IXGB is not set
CONFIG_IXGBE=y
CONFIG_IXGBE_HWMON=y
# CONFIG_IXGBE_DCB is not set
CONFIG_IXGBE_IPSEC=y
# CONFIG_IXGBEVF is not set
CONFIG_I40E=y
# CONFIG_I40E_DCB is not set
# CONFIG_I40EVF is not set
# CONFIG_ICE is not set
# CONFIG_FM10K is not set
CONFIG_IGC=y
# CONFIG_JME is not set
CONFIG_NET_VENDOR_LITEX=y
CONFIG_NET_VENDOR_MARVELL=y
# CONFIG_MVMDIO is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
# CONFIG_OCTEON_EP is not set
# CONFIG_PRESTERA is not set
CONFIG_NET_VENDOR_MELLANOX=y
# CONFIG_MLX4_EN is not set
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
CONFIG_NET_VENDOR_MICREL=y
# CONFIG_KS8842 is not set
# CONFIG_KS8851 is not set
# CONFIG_KS8851_MLL is not set
# CONFIG_KSZ884X_PCI is not set
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_ENC28J60 is not set
# CONFIG_ENCX24J600 is not set
# CONFIG_LAN743X is not set
CONFIG_NET_VENDOR_MICROSEMI=y
CONFIG_NET_VENDOR_MICROSOFT=y
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
# CONFIG_FEALNX is not set
CONFIG_NET_VENDOR_NI=y
# CONFIG_NI_XGE_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_NATSEMI=y
# CONFIG_NATSEMI is not set
# CONFIG_NS83820 is not set
CONFIG_NET_VENDOR_NETERION=y
# CONFIG_S2IO is not set
# CONFIG_VXGE is not set
CONFIG_NET_VENDOR_NETRONOME=y
# CONFIG_NFP is not set
CONFIG_NET_VENDOR_8390=y
# CONFIG_NE2K_PCI is not set
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
CONFIG_NET_VENDOR_OKI=y
# CONFIG_ETHOC is not set
CONFIG_NET_VENDOR_PACKET_ENGINES=y
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
CONFIG_NET_VENDOR_PENSANDO=y
# CONFIG_IONIC is not set
CONFIG_NET_VENDOR_QLOGIC=y
# CONFIG_QLA3XXX is not set
# CONFIG_QLCNIC is not set
# CONFIG_NETXEN_NIC is not set
# CONFIG_QED is not set
CONFIG_NET_VENDOR_BROCADE=y
# CONFIG_BNA is not set
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_ATP is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
CONFIG_R8169=y
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
# CONFIG_ROCKER is not set
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
CONFIG_NET_VENDOR_SEEQ=y
CONFIG_NET_VENDOR_SILAN=y
# CONFIG_SC92031 is not set
CONFIG_NET_VENDOR_SIS=y
# CONFIG_SIS900 is not set
# CONFIG_SIS190 is not set
CONFIG_NET_VENDOR_SOLARFLARE=y
# CONFIG_SFC is not set
# CONFIG_SFC_FALCON is not set
# CONFIG_SFC_SIENA is not set
CONFIG_NET_VENDOR_SMSC=y
# CONFIG_EPIC100 is not set
# CONFIG_SMSC911X is not set
# CONFIG_SMSC9420 is not set
CONFIG_NET_VENDOR_SOCIONEXT=y
CONFIG_NET_VENDOR_STMICRO=y
# CONFIG_STMMAC_ETH is not set
CONFIG_NET_VENDOR_SUN=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NIU is not set
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
CONFIG_NET_VENDOR_TEHUTI=y
# CONFIG_TEHUTI is not set
CONFIG_NET_VENDOR_TI=y
# CONFIG_TI_CPSW_PHY_SEL is not set
# CONFIG_TLAN is not set
CONFIG_NET_VENDOR_VERTEXCOM=y
# CONFIG_MSE102X is not set
CONFIG_NET_VENDOR_VIA=y
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_VELOCITY is not set
CONFIG_NET_VENDOR_WIZNET=y
# CONFIG_WIZNET_W5100 is not set
# CONFIG_WIZNET_W5300 is not set
CONFIG_NET_VENDOR_XILINX=y
# CONFIG_XILINX_EMACLITE is not set
# CONFIG_XILINX_AXI_EMAC is not set
# CONFIG_XILINX_LL_TEMAC is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
CONFIG_PHYLIB=y
CONFIG_SWPHY=y
# CONFIG_LED_TRIGGER_PHY is not set
CONFIG_FIXED_PHY=y

#
# MII PHY device drivers
#
# CONFIG_AMD_PHY is not set
# CONFIG_ADIN_PHY is not set
# CONFIG_ADIN1100_PHY is not set
# CONFIG_AQUANTIA_PHY is not set
CONFIG_AX88796B_PHY=y
# CONFIG_BROADCOM_PHY is not set
# CONFIG_BCM54140_PHY is not set
# CONFIG_BCM7XXX_PHY is not set
# CONFIG_BCM84881_PHY is not set
# CONFIG_BCM87XX_PHY is not set
# CONFIG_CICADA_PHY is not set
# CONFIG_CORTINA_PHY is not set
# CONFIG_DAVICOM_PHY is not set
# CONFIG_ICPLUS_PHY is not set
# CONFIG_LXT_PHY is not set
# CONFIG_INTEL_XWAY_PHY is not set
# CONFIG_LSI_ET1011C_PHY is not set
# CONFIG_MARVELL_PHY is not set
# CONFIG_MARVELL_10G_PHY is not set
# CONFIG_MARVELL_88X2222_PHY is not set
# CONFIG_MAXLINEAR_GPHY is not set
# CONFIG_MEDIATEK_GE_PHY is not set
# CONFIG_MICREL_PHY is not set
# CONFIG_MICROCHIP_PHY is not set
# CONFIG_MICROCHIP_T1_PHY is not set
# CONFIG_MICROSEMI_PHY is not set
# CONFIG_MOTORCOMM_PHY is not set
# CONFIG_NATIONAL_PHY is not set
# CONFIG_NXP_C45_TJA11XX_PHY is not set
# CONFIG_NXP_TJA11XX_PHY is not set
# CONFIG_QSEMI_PHY is not set
CONFIG_REALTEK_PHY=y
# CONFIG_RENESAS_PHY is not set
# CONFIG_ROCKCHIP_PHY is not set
# CONFIG_SMSC_PHY is not set
# CONFIG_STE10XP is not set
# CONFIG_TERANETICS_PHY is not set
# CONFIG_DP83822_PHY is not set
# CONFIG_DP83TC811_PHY is not set
# CONFIG_DP83848_PHY is not set
# CONFIG_DP83867_PHY is not set
# CONFIG_DP83869_PHY is not set
# CONFIG_DP83TD510_PHY is not set
# CONFIG_VITESSE_PHY is not set
# CONFIG_XILINX_GMII2RGMII is not set
# CONFIG_MICREL_KS8995MA is not set
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
CONFIG_FWNODE_MDIO=y
CONFIG_ACPI_MDIO=y
CONFIG_MDIO_DEVRES=y
# CONFIG_MDIO_BITBANG is not set
# CONFIG_MDIO_BCM_UNIMAC is not set
# CONFIG_MDIO_MVUSB is not set
# CONFIG_MDIO_THUNDER is not set

#
# MDIO Multiplexers
#

#
# PCS device drivers
#
# CONFIG_PCS_XPCS is not set
# end of PCS device drivers

# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
CONFIG_USB_NET_DRIVERS=y
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
CONFIG_USB_RTL8152=y
# CONFIG_USB_LAN78XX is not set
CONFIG_USB_USBNET=y
CONFIG_USB_NET_AX8817X=y
CONFIG_USB_NET_AX88179_178A=y
# CONFIG_USB_NET_CDCETHER is not set
# CONFIG_USB_NET_CDC_EEM is not set
# CONFIG_USB_NET_CDC_NCM is not set
# CONFIG_USB_NET_HUAWEI_CDC_NCM is not set
# CONFIG_USB_NET_CDC_MBIM is not set
# CONFIG_USB_NET_DM9601 is not set
# CONFIG_USB_NET_SR9700 is not set
# CONFIG_USB_NET_SR9800 is not set
# CONFIG_USB_NET_SMSC75XX is not set
# CONFIG_USB_NET_SMSC95XX is not set
# CONFIG_USB_NET_GL620A is not set
# CONFIG_USB_NET_NET1080 is not set
# CONFIG_USB_NET_PLUSB is not set
# CONFIG_USB_NET_MCS7830 is not set
# CONFIG_USB_NET_RNDIS_HOST is not set
# CONFIG_USB_NET_CDC_SUBSET is not set
# CONFIG_USB_NET_ZAURUS is not set
# CONFIG_USB_NET_CX82310_ETH is not set
# CONFIG_USB_NET_KALMIA is not set
# CONFIG_USB_NET_QMI_WWAN is not set
# CONFIG_USB_HSO is not set
# CONFIG_USB_NET_INT51X1 is not set
# CONFIG_USB_IPHETH is not set
# CONFIG_USB_SIERRA_NET is not set
# CONFIG_USB_NET_CH9200 is not set
# CONFIG_USB_NET_AQC111 is not set
CONFIG_WLAN=y
CONFIG_WLAN_VENDOR_ADMTEK=y
# CONFIG_ADM8211 is not set
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K is not set
# CONFIG_ATH5K_PCI is not set
# CONFIG_ATH9K is not set
# CONFIG_ATH9K_HTC is not set
# CONFIG_CARL9170 is not set
# CONFIG_ATH6KL is not set
# CONFIG_AR5523 is not set
# CONFIG_WIL6210 is not set
# CONFIG_ATH10K is not set
# CONFIG_WCN36XX is not set
# CONFIG_ATH11K is not set
CONFIG_WLAN_VENDOR_ATMEL=y
# CONFIG_ATMEL is not set
# CONFIG_AT76C50X_USB is not set
CONFIG_WLAN_VENDOR_BROADCOM=y
# CONFIG_B43 is not set
# CONFIG_B43LEGACY is not set
# CONFIG_BRCMSMAC is not set
# CONFIG_BRCMFMAC is not set
CONFIG_WLAN_VENDOR_CISCO=y
# CONFIG_AIRO is not set
CONFIG_WLAN_VENDOR_INTEL=y
# CONFIG_IPW2100 is not set
# CONFIG_IPW2200 is not set
# CONFIG_IWL4965 is not set
# CONFIG_IWL3945 is not set
# CONFIG_IWLWIFI is not set
# CONFIG_IWLMEI is not set
CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
# CONFIG_HERMES is not set
# CONFIG_P54_COMMON is not set
CONFIG_WLAN_VENDOR_MARVELL=y
# CONFIG_LIBERTAS is not set
# CONFIG_LIBERTAS_THINFIRM is not set
# CONFIG_MWIFIEX is not set
# CONFIG_MWL8K is not set
# CONFIG_WLAN_VENDOR_MEDIATEK is not set
CONFIG_WLAN_VENDOR_MICROCHIP=y
# CONFIG_WILC1000_SDIO is not set
# CONFIG_WILC1000_SPI is not set
CONFIG_WLAN_VENDOR_PURELIFI=y
# CONFIG_PLFXLC is not set
CONFIG_WLAN_VENDOR_RALINK=y
# CONFIG_RT2X00 is not set
CONFIG_WLAN_VENDOR_REALTEK=y
# CONFIG_RTL8180 is not set
# CONFIG_RTL8187 is not set
CONFIG_RTL_CARDS=m
# CONFIG_RTL8192CE is not set
# CONFIG_RTL8192SE is not set
# CONFIG_RTL8192DE is not set
# CONFIG_RTL8723AE is not set
# CONFIG_RTL8723BE is not set
# CONFIG_RTL8188EE is not set
# CONFIG_RTL8192EE is not set
# CONFIG_RTL8821AE is not set
# CONFIG_RTL8192CU is not set
# CONFIG_RTL8XXXU is not set
# CONFIG_RTW88 is not set
# CONFIG_RTW89 is not set
CONFIG_WLAN_VENDOR_RSI=y
# CONFIG_RSI_91X is not set
CONFIG_WLAN_VENDOR_SILABS=y
# CONFIG_WFX is not set
CONFIG_WLAN_VENDOR_ST=y
# CONFIG_CW1200 is not set
CONFIG_WLAN_VENDOR_TI=y
# CONFIG_WL1251 is not set
# CONFIG_WL12XX is not set
# CONFIG_WL18XX is not set
# CONFIG_WLCORE is not set
CONFIG_WLAN_VENDOR_ZYDAS=y
# CONFIG_USB_ZD1201 is not set
# CONFIG_ZD1211RW is not set
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_QTNFMAC_PCIE is not set
# CONFIG_MAC80211_HWSIM is not set
# CONFIG_USB_NET_RNDIS_WLAN is not set
# CONFIG_VIRT_WIFI is not set
# CONFIG_WAN is not set
CONFIG_IEEE802154_DRIVERS=m
# CONFIG_IEEE802154_FAKELB is not set
# CONFIG_IEEE802154_AT86RF230 is not set
# CONFIG_IEEE802154_MRF24J40 is not set
# CONFIG_IEEE802154_CC2520 is not set
# CONFIG_IEEE802154_ATUSB is not set
# CONFIG_IEEE802154_ADF7242 is not set
# CONFIG_IEEE802154_CA8210 is not set
# CONFIG_IEEE802154_MCR20A is not set
# CONFIG_IEEE802154_HWSIM is not set

#
# Wireless WAN
#
# CONFIG_WWAN is not set
# end of Wireless WAN

# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
CONFIG_NETDEVSIM=m
CONFIG_NET_FAILOVER=m
# CONFIG_ISDN is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=m
CONFIG_INPUT_SPARSEKMAP=m
# CONFIG_INPUT_MATRIXKMAP is not set
CONFIG_INPUT_VIVALDIFMAP=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
# CONFIG_KEYBOARD_APPLESPI is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1050 is not set
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_GPIO is not set
# CONFIG_KEYBOARD_GPIO_POLLED is not set
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_CYPRESS_SF is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_PS2_ALPS=y
CONFIG_MOUSE_PS2_BYD=y
CONFIG_MOUSE_PS2_LOGIPS2PP=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
CONFIG_MOUSE_PS2_CYPRESS=y
CONFIG_MOUSE_PS2_LIFEBOOK=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
CONFIG_MOUSE_PS2_ELANTECH=y
CONFIG_MOUSE_PS2_ELANTECH_SMBUS=y
CONFIG_MOUSE_PS2_SENTELIC=y
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_PS2_FOCALTECH=y
CONFIG_MOUSE_PS2_VMMOUSE=y
CONFIG_MOUSE_PS2_SMBUS=y
CONFIG_MOUSE_SERIAL=m
# CONFIG_MOUSE_APPLETOUCH is not set
# CONFIG_MOUSE_BCM5974 is not set
CONFIG_MOUSE_CYAPA=m
CONFIG_MOUSE_ELAN_I2C=m
CONFIG_MOUSE_ELAN_I2C_I2C=y
CONFIG_MOUSE_ELAN_I2C_SMBUS=y
CONFIG_MOUSE_VSXXXAA=m
# CONFIG_MOUSE_GPIO is not set
CONFIG_MOUSE_SYNAPTICS_I2C=m
# CONFIG_MOUSE_SYNAPTICS_USB is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set
CONFIG_RMI4_CORE=m
CONFIG_RMI4_I2C=m
CONFIG_RMI4_SPI=m
CONFIG_RMI4_SMB=m
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=m
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
CONFIG_RMI4_F34=y
# CONFIG_RMI4_F3A is not set
CONFIG_RMI4_F55=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=m
CONFIG_SERIO_ALTERA_PS2=m
# CONFIG_SERIO_PS2MULT is not set
CONFIG_SERIO_ARC_PS2=m
# CONFIG_SERIO_GPIO_PS2 is not set
# CONFIG_USERIO is not set
# CONFIG_GAMEPORT is not set
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_VT_CONSOLE_SLEEP=y
CONFIG_HW_CONSOLE=y
CONFIG_VT_HW_CONSOLE_BINDING=y
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
CONFIG_LDISC_AUTOLOAD=y

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_16550A_VARIANTS is not set
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_NR_UARTS=64
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
CONFIG_SERIAL_8250_RSA=y
CONFIG_SERIAL_8250_DWLIB=y
CONFIG_SERIAL_8250_DW=y
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
CONFIG_SERIAL_8250_PERICOM=y

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MAX3100 is not set
# CONFIG_SERIAL_MAX310X is not set
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_SERIAL_JSM=m
# CONFIG_SERIAL_LANTIQ is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
CONFIG_SERIAL_ARC=m
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
# CONFIG_SERIAL_SPRD is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_MOXA_INTELLIO is not set
# CONFIG_MOXA_SMARTIO is not set
CONFIG_SYNCLINK_GT=m
CONFIG_N_HDLC=m
CONFIG_N_GSM=m
CONFIG_NOZOMI=m
# CONFIG_NULL_TTY is not set
CONFIG_HVC_DRIVER=y
# CONFIG_SERIAL_DEV_BUS is not set
# CONFIG_TTY_PRINTK is not set
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=m
CONFIG_VIRTIO_CONSOLE=m
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PLAT_DATA=y
CONFIG_IPMI_PANIC_EVENT=y
CONFIG_IPMI_PANIC_STRING=y
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_SI=m
CONFIG_IPMI_SSIF=m
CONFIG_IPMI_WATCHDOG=m
CONFIG_IPMI_POWEROFF=m
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=m
CONFIG_HW_RANDOM_INTEL=m
# CONFIG_HW_RANDOM_AMD is not set
# CONFIG_HW_RANDOM_BA431 is not set
CONFIG_HW_RANDOM_VIA=m
CONFIG_HW_RANDOM_VIRTIO=y
# CONFIG_HW_RANDOM_XIPHERA is not set
# CONFIG_APPLICOM is not set
# CONFIG_MWAVE is not set
CONFIG_DEVMEM=y
CONFIG_NVRAM=y
CONFIG_DEVPORT=y
CONFIG_HPET=y
CONFIG_HPET_MMAP=y
# CONFIG_HPET_MMAP_DEFAULT is not set
CONFIG_HANGCHECK_TIMER=m
CONFIG_UV_MMTIMER=m
CONFIG_TCG_TPM=y
CONFIG_HW_RANDOM_TPM=y
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
# CONFIG_TCG_TIS_SPI is not set
# CONFIG_TCG_TIS_I2C_CR50 is not set
CONFIG_TCG_TIS_I2C_ATMEL=m
CONFIG_TCG_TIS_I2C_INFINEON=m
CONFIG_TCG_TIS_I2C_NUVOTON=m
CONFIG_TCG_NSC=m
CONFIG_TCG_ATMEL=m
CONFIG_TCG_INFINEON=m
CONFIG_TCG_CRB=y
# CONFIG_TCG_VTPM_PROXY is not set
CONFIG_TCG_TIS_ST33ZP24=m
CONFIG_TCG_TIS_ST33ZP24_I2C=m
# CONFIG_TCG_TIS_ST33ZP24_SPI is not set
CONFIG_TELCLOCK=m
# CONFIG_XILLYBUS is not set
# CONFIG_XILLYUSB is not set
CONFIG_RANDOM_TRUST_CPU=y
CONFIG_RANDOM_TRUST_BOOTLOADER=y
# end of Character devices

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_MUX=m

#
# Multiplexer I2C Chip support
#
# CONFIG_I2C_MUX_GPIO is not set
# CONFIG_I2C_MUX_LTC4306 is not set
# CONFIG_I2C_MUX_PCA9541 is not set
# CONFIG_I2C_MUX_PCA954x is not set
# CONFIG_I2C_MUX_REG is not set
CONFIG_I2C_MUX_MLXCPLD=m
# end of Multiplexer I2C Chip support

CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=m
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCA=m

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_AMD_MP2 is not set
CONFIG_I2C_I801=m
CONFIG_I2C_ISCH=m
CONFIG_I2C_ISMT=m
CONFIG_I2C_PIIX4=m
CONFIG_I2C_NFORCE2=m
CONFIG_I2C_NFORCE2_S4985=m
# CONFIG_I2C_NVIDIA_GPU is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
CONFIG_I2C_SIS96X=m
CONFIG_I2C_VIA=m
CONFIG_I2C_VIAPRO=m

#
# ACPI drivers
#
CONFIG_I2C_SCMI=m

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_CBUS_GPIO is not set
CONFIG_I2C_DESIGNWARE_CORE=m
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
CONFIG_I2C_DESIGNWARE_PLATFORM=m
# CONFIG_I2C_DESIGNWARE_AMDPSP is not set
CONFIG_I2C_DESIGNWARE_BAYTRAIL=y
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_EMEV2 is not set
# CONFIG_I2C_GPIO is not set
# CONFIG_I2C_OCORES is not set
CONFIG_I2C_PCA_PLATFORM=m
CONFIG_I2C_SIMTEC=m
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_DIOLAN_U2C is not set
# CONFIG_I2C_CP2615 is not set
CONFIG_I2C_PARPORT=m
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
# CONFIG_I2C_TAOS_EVM is not set
# CONFIG_I2C_TINY_USB is not set

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_MLXCPLD=m
# CONFIG_I2C_VIRTIO is not set
# end of I2C Hardware Bus support

CONFIG_I2C_STUB=m
# CONFIG_I2C_SLAVE is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

# CONFIG_I3C is not set
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y
# CONFIG_SPI_MEM is not set

#
# SPI Master Controller Drivers
#
# CONFIG_SPI_ALTERA is not set
# CONFIG_SPI_AXI_SPI_ENGINE is not set
# CONFIG_SPI_BITBANG is not set
# CONFIG_SPI_BUTTERFLY is not set
# CONFIG_SPI_CADENCE is not set
# CONFIG_SPI_DESIGNWARE is not set
# CONFIG_SPI_NXP_FLEXSPI is not set
# CONFIG_SPI_GPIO is not set
# CONFIG_SPI_LM70_LLP is not set
# CONFIG_SPI_LANTIQ_SSC is not set
# CONFIG_SPI_OC_TINY is not set
# CONFIG_SPI_PXA2XX is not set
# CONFIG_SPI_ROCKCHIP is not set
# CONFIG_SPI_SC18IS602 is not set
# CONFIG_SPI_SIFIVE is not set
# CONFIG_SPI_MXIC is not set
# CONFIG_SPI_XCOMM is not set
# CONFIG_SPI_XILINX is not set
# CONFIG_SPI_ZYNQMP_GQSPI is not set
# CONFIG_SPI_AMD is not set

#
# SPI Multiplexer support
#
# CONFIG_SPI_MUX is not set

#
# SPI Protocol Masters
#
# CONFIG_SPI_SPIDEV is not set
# CONFIG_SPI_LOOPBACK_TEST is not set
# CONFIG_SPI_TLE62X0 is not set
# CONFIG_SPI_SLAVE is not set
CONFIG_SPI_DYNAMIC=y
# CONFIG_SPMI is not set
# CONFIG_HSI is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
CONFIG_PPS_CLIENT_LDISC=m
CONFIG_PPS_CLIENT_PARPORT=m
CONFIG_PPS_CLIENT_GPIO=m

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=y
CONFIG_PTP_1588_CLOCK_OPTIONAL=y
# CONFIG_DP83640_PHY is not set
# CONFIG_PTP_1588_CLOCK_INES is not set
CONFIG_PTP_1588_CLOCK_KVM=m
# CONFIG_PTP_1588_CLOCK_IDT82P33 is not set
# CONFIG_PTP_1588_CLOCK_IDTCM is not set
# CONFIG_PTP_1588_CLOCK_VMW is not set
# end of PTP clock support

CONFIG_PINCTRL=y
# CONFIG_DEBUG_PINCTRL is not set
# CONFIG_PINCTRL_AMD is not set
# CONFIG_PINCTRL_MCP23S08 is not set
# CONFIG_PINCTRL_SX150X is not set

#
# Intel pinctrl drivers
#
# CONFIG_PINCTRL_BAYTRAIL is not set
# CONFIG_PINCTRL_CHERRYVIEW is not set
# CONFIG_PINCTRL_LYNXPOINT is not set
# CONFIG_PINCTRL_ALDERLAKE is not set
# CONFIG_PINCTRL_BROXTON is not set
# CONFIG_PINCTRL_CANNONLAKE is not set
# CONFIG_PINCTRL_CEDARFORK is not set
# CONFIG_PINCTRL_DENVERTON is not set
# CONFIG_PINCTRL_ELKHARTLAKE is not set
# CONFIG_PINCTRL_EMMITSBURG is not set
# CONFIG_PINCTRL_GEMINILAKE is not set
# CONFIG_PINCTRL_ICELAKE is not set
# CONFIG_PINCTRL_JASPERLAKE is not set
# CONFIG_PINCTRL_LAKEFIELD is not set
# CONFIG_PINCTRL_LEWISBURG is not set
# CONFIG_PINCTRL_SUNRISEPOINT is not set
# CONFIG_PINCTRL_TIGERLAKE is not set
# end of Intel pinctrl drivers

#
# Renesas pinctrl drivers
#
# end of Renesas pinctrl drivers

CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_GPIO_ACPI=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_CDEV=y
CONFIG_GPIO_CDEV_V1=y

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_AMDPT is not set
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_EXAR is not set
# CONFIG_GPIO_GENERIC_PLATFORM is not set
CONFIG_GPIO_ICH=m
# CONFIG_GPIO_MB86S7X is not set
# CONFIG_GPIO_VX855 is not set
# CONFIG_GPIO_AMD_FCH is not set
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_F7188X is not set
# CONFIG_GPIO_IT87 is not set
# CONFIG_GPIO_SCH is not set
# CONFIG_GPIO_SCH311X is not set
# CONFIG_GPIO_WINBOND is not set
# CONFIG_GPIO_WS16C48 is not set
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
# CONFIG_GPIO_ADP5588 is not set
# CONFIG_GPIO_MAX7300 is not set
# CONFIG_GPIO_MAX732X is not set
# CONFIG_GPIO_PCA953X is not set
# CONFIG_GPIO_PCA9570 is not set
# CONFIG_GPIO_PCF857X is not set
# CONFIG_GPIO_TPIC2810 is not set
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_BT8XX is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set
# end of PCI GPIO expanders

#
# SPI GPIO expanders
#
# CONFIG_GPIO_MAX3191X is not set
# CONFIG_GPIO_MAX7301 is not set
# CONFIG_GPIO_MC33880 is not set
# CONFIG_GPIO_PISOSR is not set
# CONFIG_GPIO_XRA1403 is not set
# end of SPI GPIO expanders

#
# USB GPIO expanders
#
# end of USB GPIO expanders

#
# Virtual GPIO drivers
#
# CONFIG_GPIO_AGGREGATOR is not set
CONFIG_GPIO_MOCKUP=m
# CONFIG_GPIO_VIRTIO is not set
CONFIG_GPIO_SIM=m
# end of Virtual GPIO drivers

# CONFIG_W1 is not set
CONFIG_POWER_RESET=y
# CONFIG_POWER_RESET_RESTART is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_POWER_SUPPLY_HWMON=y
# CONFIG_PDA_POWER is not set
# CONFIG_IP5XXX_POWER is not set
# CONFIG_TEST_POWER is not set
# CONFIG_CHARGER_ADP5061 is not set
# CONFIG_BATTERY_CW2015 is not set
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2781 is not set
# CONFIG_BATTERY_DS2782 is not set
# CONFIG_BATTERY_SAMSUNG_SDI is not set
# CONFIG_BATTERY_SBS is not set
# CONFIG_CHARGER_SBS is not set
# CONFIG_MANAGER_SBS is not set
# CONFIG_BATTERY_BQ27XXX is not set
# CONFIG_BATTERY_MAX17040 is not set
# CONFIG_BATTERY_MAX17042 is not set
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_LP8727 is not set
# CONFIG_CHARGER_GPIO is not set
# CONFIG_CHARGER_LT3651 is not set
# CONFIG_CHARGER_LTC4162L is not set
# CONFIG_CHARGER_MAX77976 is not set
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_CHARGER_BQ24257 is not set
# CONFIG_CHARGER_BQ24735 is not set
# CONFIG_CHARGER_BQ2515X is not set
# CONFIG_CHARGER_BQ25890 is not set
# CONFIG_CHARGER_BQ25980 is not set
# CONFIG_CHARGER_BQ256XX is not set
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
# CONFIG_BATTERY_GOLDFISH is not set
# CONFIG_BATTERY_RT5033 is not set
# CONFIG_CHARGER_RT9455 is not set
# CONFIG_CHARGER_BD99954 is not set
# CONFIG_BATTERY_UG3105 is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=m
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=m
CONFIG_SENSORS_ABITUGURU3=m
# CONFIG_SENSORS_AD7314 is not set
CONFIG_SENSORS_AD7414=m
CONFIG_SENSORS_AD7418=m
CONFIG_SENSORS_ADM1021=m
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM1026=m
CONFIG_SENSORS_ADM1029=m
CONFIG_SENSORS_ADM1031=m
# CONFIG_SENSORS_ADM1177 is not set
CONFIG_SENSORS_ADM9240=m
CONFIG_SENSORS_ADT7X10=m
# CONFIG_SENSORS_ADT7310 is not set
CONFIG_SENSORS_ADT7410=m
CONFIG_SENSORS_ADT7411=m
CONFIG_SENSORS_ADT7462=m
CONFIG_SENSORS_ADT7470=m
CONFIG_SENSORS_ADT7475=m
# CONFIG_SENSORS_AHT10 is not set
# CONFIG_SENSORS_AQUACOMPUTER_D5NEXT is not set
# CONFIG_SENSORS_AS370 is not set
CONFIG_SENSORS_ASC7621=m
# CONFIG_SENSORS_AXI_FAN_CONTROL is not set
CONFIG_SENSORS_K8TEMP=m
CONFIG_SENSORS_K10TEMP=m
CONFIG_SENSORS_FAM15H_POWER=m
CONFIG_SENSORS_APPLESMC=m
CONFIG_SENSORS_ASB100=m
# CONFIG_SENSORS_ASPEED is not set
CONFIG_SENSORS_ATXP1=m
# CONFIG_SENSORS_CORSAIR_CPRO is not set
# CONFIG_SENSORS_CORSAIR_PSU is not set
# CONFIG_SENSORS_DRIVETEMP is not set
CONFIG_SENSORS_DS620=m
CONFIG_SENSORS_DS1621=m
# CONFIG_SENSORS_DELL_SMM is not set
CONFIG_SENSORS_I5K_AMB=m
CONFIG_SENSORS_F71805F=m
CONFIG_SENSORS_F71882FG=m
CONFIG_SENSORS_F75375S=m
CONFIG_SENSORS_FSCHMD=m
# CONFIG_SENSORS_FTSTEUTATES is not set
CONFIG_SENSORS_GL518SM=m
CONFIG_SENSORS_GL520SM=m
CONFIG_SENSORS_G760A=m
# CONFIG_SENSORS_G762 is not set
# CONFIG_SENSORS_HIH6130 is not set
CONFIG_SENSORS_IBMAEM=m
CONFIG_SENSORS_IBMPEX=m
CONFIG_SENSORS_I5500=m
CONFIG_SENSORS_CORETEMP=m
CONFIG_SENSORS_IT87=m
CONFIG_SENSORS_JC42=m
# CONFIG_SENSORS_POWR1220 is not set
CONFIG_SENSORS_LINEAGE=m
# CONFIG_SENSORS_LTC2945 is not set
# CONFIG_SENSORS_LTC2947_I2C is not set
# CONFIG_SENSORS_LTC2947_SPI is not set
# CONFIG_SENSORS_LTC2990 is not set
# CONFIG_SENSORS_LTC2992 is not set
CONFIG_SENSORS_LTC4151=m
CONFIG_SENSORS_LTC4215=m
# CONFIG_SENSORS_LTC4222 is not set
CONFIG_SENSORS_LTC4245=m
# CONFIG_SENSORS_LTC4260 is not set
CONFIG_SENSORS_LTC4261=m
# CONFIG_SENSORS_MAX1111 is not set
# CONFIG_SENSORS_MAX127 is not set
CONFIG_SENSORS_MAX16065=m
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_MAX1668=m
CONFIG_SENSORS_MAX197=m
# CONFIG_SENSORS_MAX31722 is not set
# CONFIG_SENSORS_MAX31730 is not set
# CONFIG_SENSORS_MAX6620 is not set
# CONFIG_SENSORS_MAX6621 is not set
CONFIG_SENSORS_MAX6639=m
CONFIG_SENSORS_MAX6642=m
CONFIG_SENSORS_MAX6650=m
CONFIG_SENSORS_MAX6697=m
# CONFIG_SENSORS_MAX31790 is not set
CONFIG_SENSORS_MCP3021=m
# CONFIG_SENSORS_MLXREG_FAN is not set
# CONFIG_SENSORS_TC654 is not set
# CONFIG_SENSORS_TPS23861 is not set
# CONFIG_SENSORS_MR75203 is not set
# CONFIG_SENSORS_ADCXX is not set
CONFIG_SENSORS_LM63=m
# CONFIG_SENSORS_LM70 is not set
CONFIG_SENSORS_LM73=m
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM77=m
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM87=m
CONFIG_SENSORS_LM90=m
CONFIG_SENSORS_LM92=m
CONFIG_SENSORS_LM93=m
CONFIG_SENSORS_LM95234=m
CONFIG_SENSORS_LM95241=m
CONFIG_SENSORS_LM95245=m
CONFIG_SENSORS_PC87360=m
CONFIG_SENSORS_PC87427=m
# CONFIG_SENSORS_NCT6683 is not set
CONFIG_SENSORS_NCT6775_CORE=m
CONFIG_SENSORS_NCT6775=m
# CONFIG_SENSORS_NCT6775_I2C is not set
# CONFIG_SENSORS_NCT7802 is not set
# CONFIG_SENSORS_NCT7904 is not set
# CONFIG_SENSORS_NPCM7XX is not set
# CONFIG_SENSORS_NZXT_KRAKEN2 is not set
# CONFIG_SENSORS_NZXT_SMART2 is not set
CONFIG_SENSORS_PCF8591=m
CONFIG_PMBUS=m
CONFIG_SENSORS_PMBUS=m
# CONFIG_SENSORS_ADM1266 is not set
CONFIG_SENSORS_ADM1275=m
# CONFIG_SENSORS_BEL_PFE is not set
# CONFIG_SENSORS_BPA_RS600 is not set
# CONFIG_SENSORS_DELTA_AHE50DC_FAN is not set
# CONFIG_SENSORS_FSP_3Y is not set
# CONFIG_SENSORS_IBM_CFFPS is not set
# CONFIG_SENSORS_DPS920AB is not set
# CONFIG_SENSORS_INSPUR_IPSPS is not set
# CONFIG_SENSORS_IR35221 is not set
# CONFIG_SENSORS_IR36021 is not set
# CONFIG_SENSORS_IR38064 is not set
# CONFIG_SENSORS_IRPS5401 is not set
# CONFIG_SENSORS_ISL68137 is not set
CONFIG_SENSORS_LM25066=m
CONFIG_SENSORS_LTC2978=m
# CONFIG_SENSORS_LTC3815 is not set
# CONFIG_SENSORS_MAX15301 is not set
CONFIG_SENSORS_MAX16064=m
# CONFIG_SENSORS_MAX16601 is not set
# CONFIG_SENSORS_MAX20730 is not set
# CONFIG_SENSORS_MAX20751 is not set
# CONFIG_SENSORS_MAX31785 is not set
CONFIG_SENSORS_MAX34440=m
CONFIG_SENSORS_MAX8688=m
# CONFIG_SENSORS_MP2888 is not set
# CONFIG_SENSORS_MP2975 is not set
# CONFIG_SENSORS_MP5023 is not set
# CONFIG_SENSORS_PIM4328 is not set
# CONFIG_SENSORS_PLI1209BC is not set
# CONFIG_SENSORS_PM6764TR is not set
# CONFIG_SENSORS_PXE1610 is not set
# CONFIG_SENSORS_Q54SJ108A2 is not set
# CONFIG_SENSORS_STPDDC60 is not set
# CONFIG_SENSORS_TPS40422 is not set
# CONFIG_SENSORS_TPS53679 is not set
CONFIG_SENSORS_UCD9000=m
CONFIG_SENSORS_UCD9200=m
# CONFIG_SENSORS_XDPE152 is not set
# CONFIG_SENSORS_XDPE122 is not set
CONFIG_SENSORS_ZL6100=m
# CONFIG_SENSORS_SBTSI is not set
# CONFIG_SENSORS_SBRMI is not set
CONFIG_SENSORS_SHT15=m
CONFIG_SENSORS_SHT21=m
# CONFIG_SENSORS_SHT3x is not set
# CONFIG_SENSORS_SHT4x is not set
# CONFIG_SENSORS_SHTC1 is not set
CONFIG_SENSORS_SIS5595=m
# CONFIG_SENSORS_SY7636A is not set
CONFIG_SENSORS_DME1737=m
CONFIG_SENSORS_EMC1403=m
# CONFIG_SENSORS_EMC2103 is not set
CONFIG_SENSORS_EMC6W201=m
CONFIG_SENSORS_SMSC47M1=m
CONFIG_SENSORS_SMSC47M192=m
CONFIG_SENSORS_SMSC47B397=m
CONFIG_SENSORS_SCH56XX_COMMON=m
CONFIG_SENSORS_SCH5627=m
CONFIG_SENSORS_SCH5636=m
# CONFIG_SENSORS_STTS751 is not set
# CONFIG_SENSORS_SMM665 is not set
# CONFIG_SENSORS_ADC128D818 is not set
CONFIG_SENSORS_ADS7828=m
# CONFIG_SENSORS_ADS7871 is not set
CONFIG_SENSORS_AMC6821=m
CONFIG_SENSORS_INA209=m
CONFIG_SENSORS_INA2XX=m
# CONFIG_SENSORS_INA238 is not set
# CONFIG_SENSORS_INA3221 is not set
# CONFIG_SENSORS_TC74 is not set
CONFIG_SENSORS_THMC50=m
CONFIG_SENSORS_TMP102=m
# CONFIG_SENSORS_TMP103 is not set
# CONFIG_SENSORS_TMP108 is not set
CONFIG_SENSORS_TMP401=m
CONFIG_SENSORS_TMP421=m
# CONFIG_SENSORS_TMP464 is not set
# CONFIG_SENSORS_TMP513 is not set
CONFIG_SENSORS_VIA_CPUTEMP=m
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_VT1211=m
CONFIG_SENSORS_VT8231=m
# CONFIG_SENSORS_W83773G is not set
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83791D=m
CONFIG_SENSORS_W83792D=m
CONFIG_SENSORS_W83793=m
CONFIG_SENSORS_W83795=m
# CONFIG_SENSORS_W83795_FANCTRL is not set
CONFIG_SENSORS_W83L785TS=m
CONFIG_SENSORS_W83L786NG=m
CONFIG_SENSORS_W83627HF=m
CONFIG_SENSORS_W83627EHF=m
# CONFIG_SENSORS_XGENE is not set

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=m
CONFIG_SENSORS_ATK0110=m
# CONFIG_SENSORS_ASUS_WMI is not set
# CONFIG_SENSORS_ASUS_WMI_EC is not set
# CONFIG_SENSORS_ASUS_EC is not set
CONFIG_THERMAL=y
# CONFIG_THERMAL_NETLINK is not set
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_THERMAL_EMULATION is not set

#
# Intel thermal drivers
#
CONFIG_INTEL_POWERCLAMP=m
CONFIG_X86_THERMAL_VECTOR=y
CONFIG_X86_PKG_TEMP_THERMAL=m
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
# end of ACPI INT340X thermal drivers

CONFIG_INTEL_PCH_THERMAL=m
# CONFIG_INTEL_TCC_COOLING is not set
# CONFIG_INTEL_MENLOW is not set
# CONFIG_INTEL_HFI_THERMAL is not set
# end of Intel thermal drivers

CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
CONFIG_WATCHDOG_OPEN_TIMEOUT=0
CONFIG_WATCHDOG_SYSFS=y
# CONFIG_WATCHDOG_HRTIMER_PRETIMEOUT is not set

#
# Watchdog Pretimeout Governors
#
# CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=m
CONFIG_WDAT_WDT=m
# CONFIG_XILINX_WATCHDOG is not set
# CONFIG_ZIIRAVE_WATCHDOG is not set
# CONFIG_MLX_WDT is not set
# CONFIG_CADENCE_WATCHDOG is not set
# CONFIG_DW_WATCHDOG is not set
# CONFIG_MAX63XX_WATCHDOG is not set
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
CONFIG_ALIM1535_WDT=m
CONFIG_ALIM7101_WDT=m
# CONFIG_EBC_C384_WDT is not set
CONFIG_F71808E_WDT=m
# CONFIG_SP5100_TCO is not set
CONFIG_SBC_FITPC2_WATCHDOG=m
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=m
CONFIG_IBMASR=m
# CONFIG_WAFER_WDT is not set
CONFIG_I6300ESB_WDT=y
CONFIG_IE6XX_WDT=m
CONFIG_ITCO_WDT=y
CONFIG_ITCO_VENDOR_SUPPORT=y
CONFIG_IT8712F_WDT=m
CONFIG_IT87_WDT=m
CONFIG_HP_WATCHDOG=m
CONFIG_HPWDT_NMI_DECODING=y
# CONFIG_SC1200_WDT is not set
# CONFIG_PC87413_WDT is not set
CONFIG_NV_TCO=m
# CONFIG_60XX_WDT is not set
# CONFIG_CPU5_WDT is not set
CONFIG_SMSC_SCH311X_WDT=m
# CONFIG_SMSC37B787_WDT is not set
# CONFIG_TQMX86_WDT is not set
CONFIG_VIA_WDT=m
CONFIG_W83627HF_WDT=m
CONFIG_W83877F_WDT=m
CONFIG_W83977F_WDT=m
CONFIG_MACHZ_WDT=m
# CONFIG_SBC_EPX_C3_WATCHDOG is not set
CONFIG_INTEL_MEI_WDT=m
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set
# CONFIG_MEN_A21_WDT is not set

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=m
CONFIG_WDTPCI=m

#
# USB-based Watchdog Cards
#
# CONFIG_USBPCWATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
# CONFIG_SSB is not set
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=m
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
# CONFIG_BCMA_HOST_SOC is not set
CONFIG_BCMA_DRIVER_PCI=y
CONFIG_BCMA_DRIVER_GMAC_CMN=y
CONFIG_BCMA_DRIVER_GPIO=y
# CONFIG_BCMA_DEBUG is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_AS3711 is not set
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
# CONFIG_MFD_BCM590XX is not set
# CONFIG_MFD_BD9571MWV is not set
# CONFIG_MFD_AXP20X_I2C is not set
# CONFIG_MFD_MADERA is not set
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_SPI is not set
# CONFIG_MFD_DA9052_I2C is not set
# CONFIG_MFD_DA9055 is not set
# CONFIG_MFD_DA9062 is not set
# CONFIG_MFD_DA9063 is not set
# CONFIG_MFD_DA9150 is not set
# CONFIG_MFD_DLN2 is not set
# CONFIG_MFD_MC13XXX_SPI is not set
# CONFIG_MFD_MC13XXX_I2C is not set
# CONFIG_MFD_MP2629 is not set
# CONFIG_HTC_PASIC3 is not set
# CONFIG_HTC_I2CPLD is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
CONFIG_LPC_ICH=m
CONFIG_LPC_SCH=m
CONFIG_MFD_INTEL_LPSS=y
CONFIG_MFD_INTEL_LPSS_ACPI=y
CONFIG_MFD_INTEL_LPSS_PCI=y
# CONFIG_MFD_INTEL_PMC_BXT is not set
# CONFIG_MFD_IQS62X is not set
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_KEMPLD is not set
# CONFIG_MFD_88PM800 is not set
# CONFIG_MFD_88PM805 is not set
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_MAX14577 is not set
# CONFIG_MFD_MAX77693 is not set
# CONFIG_MFD_MAX77843 is not set
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
# CONFIG_MFD_MT6360 is not set
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_MENF21BMC is not set
# CONFIG_EZX_PCAP is not set
# CONFIG_MFD_VIPERBOARD is not set
# CONFIG_MFD_RETU is not set
# CONFIG_MFD_PCF50633 is not set
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RT4831 is not set
# CONFIG_MFD_RT5033 is not set
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_SI476X_CORE is not set
# CONFIG_MFD_SIMPLE_MFD_I2C is not set
CONFIG_MFD_SM501=m
CONFIG_MFD_SM501_GPIO=y
# CONFIG_MFD_SKY81452 is not set
# CONFIG_MFD_SYSCON is not set
# CONFIG_MFD_TI_AM335X_TSCADC is not set
# CONFIG_MFD_LP3943 is not set
# CONFIG_MFD_LP8788 is not set
# CONFIG_MFD_TI_LMU is not set
# CONFIG_MFD_PALMAS is not set
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
# CONFIG_MFD_TPS65086 is not set
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_TI_LP873X is not set
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
# CONFIG_MFD_TPS65912_I2C is not set
# CONFIG_MFD_TPS65912_SPI is not set
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
# CONFIG_MFD_WL1273_CORE is not set
# CONFIG_MFD_LM3533 is not set
# CONFIG_MFD_TQMX86 is not set
CONFIG_MFD_VX855=m
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_ARIZONA_SPI is not set
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM831X_SPI is not set
# CONFIG_MFD_WM8350_I2C is not set
# CONFIG_MFD_WM8994 is not set
# CONFIG_MFD_ATC260X_I2C is not set
# CONFIG_MFD_INTEL_M10_BMC is not set
# end of Multifunction device drivers

# CONFIG_REGULATOR is not set
CONFIG_RC_CORE=m
CONFIG_LIRC=y
CONFIG_RC_MAP=m
CONFIG_RC_DECODERS=y
CONFIG_IR_IMON_DECODER=m
CONFIG_IR_JVC_DECODER=m
CONFIG_IR_MCE_KBD_DECODER=m
CONFIG_IR_NEC_DECODER=m
CONFIG_IR_RC5_DECODER=m
CONFIG_IR_RC6_DECODER=m
# CONFIG_IR_RCMM_DECODER is not set
CONFIG_IR_SANYO_DECODER=m
CONFIG_IR_SHARP_DECODER=m
CONFIG_IR_SONY_DECODER=m
# CONFIG_IR_XMP_DECODER is not set
CONFIG_RC_DEVICES=y
CONFIG_IR_ENE=m
CONFIG_IR_FINTEK=m
# CONFIG_IR_IGORPLUGUSB is not set
# CONFIG_IR_IGUANA is not set
# CONFIG_IR_IMON is not set
# CONFIG_IR_IMON_RAW is not set
CONFIG_IR_ITE_CIR=m
# CONFIG_IR_MCEUSB is not set
CONFIG_IR_NUVOTON=m
# CONFIG_IR_REDRAT3 is not set
CONFIG_IR_SERIAL=m
CONFIG_IR_SERIAL_TRANSMITTER=y
# CONFIG_IR_STREAMZAP is not set
# CONFIG_IR_TOY is not set
# CONFIG_IR_TTUSBIR is not set
CONFIG_IR_WINBOND_CIR=m
# CONFIG_RC_ATI_REMOTE is not set
CONFIG_RC_LOOPBACK=m
# CONFIG_RC_XBOX_DVD is not set

#
# CEC support
#
# CONFIG_MEDIA_CEC_SUPPORT is not set
# end of CEC support

CONFIG_MEDIA_SUPPORT=m
CONFIG_MEDIA_SUPPORT_FILTER=y
CONFIG_MEDIA_SUBDRV_AUTOSELECT=y

#
# Media device types
#
# CONFIG_MEDIA_CAMERA_SUPPORT is not set
# CONFIG_MEDIA_ANALOG_TV_SUPPORT is not set
# CONFIG_MEDIA_DIGITAL_TV_SUPPORT is not set
# CONFIG_MEDIA_RADIO_SUPPORT is not set
# CONFIG_MEDIA_SDR_SUPPORT is not set
# CONFIG_MEDIA_PLATFORM_SUPPORT is not set
# CONFIG_MEDIA_TEST_SUPPORT is not set
# end of Media device types

#
# Media drivers
#

#
# Drivers filtered as selected at 'Filter media drivers'
#

#
# Media drivers
#
# CONFIG_MEDIA_USB_SUPPORT is not set
# CONFIG_MEDIA_PCI_SUPPORT is not set
# end of Media drivers

#
# Media ancillary drivers
#
# end of Media ancillary drivers

#
# Graphics support
#
# CONFIG_AGP is not set
CONFIG_INTEL_GTT=m
CONFIG_VGA_SWITCHEROO=y
CONFIG_DRM=y
CONFIG_DRM_MIPI_DSI=y
# CONFIG_DRM_DEBUG_MM is not set
CONFIG_DRM_DEBUG_SELFTEST=m
CONFIG_DRM_KMS_HELPER=m
# CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS is not set
CONFIG_DRM_DEBUG_MODESET_LOCK=y
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
# CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM is not set
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
CONFIG_DRM_DISPLAY_HELPER=m
CONFIG_DRM_DISPLAY_DP_HELPER=y
CONFIG_DRM_DISPLAY_HDCP_HELPER=y
CONFIG_DRM_DISPLAY_HDMI_HELPER=y
CONFIG_DRM_DP_AUX_CHARDEV=y
# CONFIG_DRM_DP_CEC is not set
CONFIG_DRM_TTM=m
CONFIG_DRM_BUDDY=m
CONFIG_DRM_VRAM_HELPER=m
CONFIG_DRM_TTM_HELPER=m
CONFIG_DRM_GEM_SHMEM_HELPER=y

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=m
CONFIG_DRM_I2C_SIL164=m
# CONFIG_DRM_I2C_NXP_TDA998X is not set
# CONFIG_DRM_I2C_NXP_TDA9950 is not set
# end of I2C encoder or helper chips

#
# ARM devices
#
# end of ARM devices

# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set
# CONFIG_DRM_NOUVEAU is not set
CONFIG_DRM_I915=m
CONFIG_DRM_I915_FORCE_PROBE=""
CONFIG_DRM_I915_CAPTURE_ERROR=y
CONFIG_DRM_I915_COMPRESS_ERROR=y
CONFIG_DRM_I915_USERPTR=y
# CONFIG_DRM_I915_GVT_KVMGT is not set

#
# drm/i915 Debugging
#
# CONFIG_DRM_I915_WERROR is not set
# CONFIG_DRM_I915_DEBUG is not set
# CONFIG_DRM_I915_DEBUG_MMIO is not set
# CONFIG_DRM_I915_SW_FENCE_DEBUG_OBJECTS is not set
# CONFIG_DRM_I915_SW_FENCE_CHECK_DAG is not set
# CONFIG_DRM_I915_DEBUG_GUC is not set
# CONFIG_DRM_I915_SELFTEST is not set
# CONFIG_DRM_I915_LOW_LEVEL_TRACEPOINTS is not set
# CONFIG_DRM_I915_DEBUG_VBLANK_EVADE is not set
# CONFIG_DRM_I915_DEBUG_RUNTIME_PM is not set
# end of drm/i915 Debugging

#
# drm/i915 Profile Guided Optimisation
#
CONFIG_DRM_I915_REQUEST_TIMEOUT=20000
CONFIG_DRM_I915_FENCE_TIMEOUT=10000
CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND=250
CONFIG_DRM_I915_HEARTBEAT_INTERVAL=2500
CONFIG_DRM_I915_PREEMPT_TIMEOUT=640
CONFIG_DRM_I915_MAX_REQUEST_BUSYWAIT=8000
CONFIG_DRM_I915_STOP_TIMEOUT=100
CONFIG_DRM_I915_TIMESLICE_DURATION=1
# end of drm/i915 Profile Guided Optimisation

CONFIG_DRM_VGEM=y
# CONFIG_DRM_VKMS is not set
# CONFIG_DRM_VMWGFX is not set
CONFIG_DRM_GMA500=m
# CONFIG_DRM_UDL is not set
CONFIG_DRM_AST=m
# CONFIG_DRM_MGAG200 is not set
CONFIG_DRM_QXL=m
CONFIG_DRM_VIRTIO_GPU=m
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN is not set
# CONFIG_DRM_PANEL_WIDECHIPS_WS2401 is not set
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
# end of Display Interface Bridges

# CONFIG_DRM_ETNAVIV is not set
CONFIG_DRM_BOCHS=m
CONFIG_DRM_CIRRUS_QEMU=m
# CONFIG_DRM_GM12U320 is not set
# CONFIG_DRM_PANEL_MIPI_DBI is not set
# CONFIG_DRM_SIMPLEDRM is not set
# CONFIG_TINYDRM_HX8357D is not set
# CONFIG_TINYDRM_ILI9163 is not set
# CONFIG_TINYDRM_ILI9225 is not set
# CONFIG_TINYDRM_ILI9341 is not set
# CONFIG_TINYDRM_ILI9486 is not set
# CONFIG_TINYDRM_MI0283QT is not set
# CONFIG_TINYDRM_REPAPER is not set
# CONFIG_TINYDRM_ST7586 is not set
# CONFIG_TINYDRM_ST7735R is not set
# CONFIG_DRM_VBOXVIDEO is not set
# CONFIG_DRM_GUD is not set
# CONFIG_DRM_SSD130X is not set
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_EXPORT_FOR_TESTS=y
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
CONFIG_DRM_NOMODESET=y
CONFIG_DRM_LIB_RANDOM=y
CONFIG_DRM_PRIVACY_SCREEN=y

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=m
CONFIG_FB_SYS_COPYAREA=m
CONFIG_FB_SYS_IMAGEBLIT=m
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=m
CONFIG_FB_DEFERRED_IO=y
# CONFIG_FB_MODE_HELPERS is not set
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_UVESA is not set
CONFIG_FB_VESA=y
CONFIG_FB_EFI=y
# CONFIG_FB_N411 is not set
# CONFIG_FB_HGA is not set
# CONFIG_FB_OPENCORES is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I740 is not set
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_VIA is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
# CONFIG_FB_SM501 is not set
# CONFIG_FB_SMSCUFX is not set
# CONFIG_FB_UDL is not set
# CONFIG_FB_IBM_GXT4500 is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
# CONFIG_FB_SIMPLE is not set
# CONFIG_FB_SSD1307 is not set
# CONFIG_FB_SM712 is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=m
# CONFIG_LCD_L4F00242T03 is not set
# CONFIG_LCD_LMS283GF05 is not set
# CONFIG_LCD_LTV350QV is not set
# CONFIG_LCD_ILI922X is not set
# CONFIG_LCD_ILI9320 is not set
# CONFIG_LCD_TDO24M is not set
# CONFIG_LCD_VGG2432A4 is not set
CONFIG_LCD_PLATFORM=m
# CONFIG_LCD_AMS369FG06 is not set
# CONFIG_LCD_LMS501KF03 is not set
# CONFIG_LCD_HX8357 is not set
# CONFIG_LCD_OTM3225A is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_KTD253 is not set
# CONFIG_BACKLIGHT_PWM is not set
CONFIG_BACKLIGHT_APPLE=m
# CONFIG_BACKLIGHT_QCOM_WLED is not set
# CONFIG_BACKLIGHT_SAHARA is not set
# CONFIG_BACKLIGHT_ADP8860 is not set
# CONFIG_BACKLIGHT_ADP8870 is not set
# CONFIG_BACKLIGHT_LM3630A is not set
# CONFIG_BACKLIGHT_LM3639 is not set
CONFIG_BACKLIGHT_LP855X=m
# CONFIG_BACKLIGHT_GPIO is not set
# CONFIG_BACKLIGHT_LV5207LP is not set
# CONFIG_BACKLIGHT_BD6107 is not set
# CONFIG_BACKLIGHT_ARCXCNN is not set
# end of Backlight & LCD device support

CONFIG_HDMI=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
CONFIG_FRAMEBUFFER_CONSOLE=y
# CONFIG_FRAMEBUFFER_CONSOLE_LEGACY_ACCELERATION is not set
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
# CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER is not set
# end of Console display driver support

CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
CONFIG_LOGO_LINUX_CLUT224=y
# end of Graphics support

# CONFIG_SOUND is not set

#
# HID support
#
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
CONFIG_HIDRAW=y
CONFIG_UHID=m
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
CONFIG_HID_A4TECH=m
# CONFIG_HID_ACCUTOUCH is not set
CONFIG_HID_ACRUX=m
# CONFIG_HID_ACRUX_FF is not set
CONFIG_HID_APPLE=m
# CONFIG_HID_APPLEIR is not set
CONFIG_HID_ASUS=m
CONFIG_HID_AUREAL=m
CONFIG_HID_BELKIN=m
# CONFIG_HID_BETOP_FF is not set
# CONFIG_HID_BIGBEN_FF is not set
CONFIG_HID_CHERRY=m
# CONFIG_HID_CHICONY is not set
# CONFIG_HID_CORSAIR is not set
# CONFIG_HID_COUGAR is not set
# CONFIG_HID_MACALLY is not set
CONFIG_HID_CMEDIA=m
# CONFIG_HID_CP2112 is not set
# CONFIG_HID_CREATIVE_SB0540 is not set
CONFIG_HID_CYPRESS=m
CONFIG_HID_DRAGONRISE=m
# CONFIG_DRAGONRISE_FF is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELAN is not set
CONFIG_HID_ELECOM=m
# CONFIG_HID_ELO is not set
CONFIG_HID_EZKEY=m
# CONFIG_HID_FT260 is not set
CONFIG_HID_GEMBIRD=m
CONFIG_HID_GFRM=m
# CONFIG_HID_GLORIOUS is not set
# CONFIG_HID_HOLTEK is not set
# CONFIG_HID_VIVALDI is not set
# CONFIG_HID_GT683R is not set
CONFIG_HID_KEYTOUCH=m
CONFIG_HID_KYE=m
# CONFIG_HID_UCLOGIC is not set
CONFIG_HID_WALTOP=m
# CONFIG_HID_VIEWSONIC is not set
# CONFIG_HID_XIAOMI is not set
CONFIG_HID_GYRATION=m
CONFIG_HID_ICADE=m
CONFIG_HID_ITE=m
CONFIG_HID_JABRA=m
CONFIG_HID_TWINHAN=m
CONFIG_HID_KENSINGTON=m
CONFIG_HID_LCPOWER=m
CONFIG_HID_LED=m
CONFIG_HID_LENOVO=m
# CONFIG_HID_LETSKETCH is not set
CONFIG_HID_LOGITECH=m
CONFIG_HID_LOGITECH_DJ=m
CONFIG_HID_LOGITECH_HIDPP=m
# CONFIG_LOGITECH_FF is not set
# CONFIG_LOGIRUMBLEPAD2_FF is not set
# CONFIG_LOGIG940_FF is not set
# CONFIG_LOGIWHEELS_FF is not set
CONFIG_HID_MAGICMOUSE=y
# CONFIG_HID_MALTRON is not set
# CONFIG_HID_MAYFLASH is not set
# CONFIG_HID_MEGAWORLD_FF is not set
# CONFIG_HID_REDRAGON is not set
CONFIG_HID_MICROSOFT=m
CONFIG_HID_MONTEREY=m
CONFIG_HID_MULTITOUCH=m
# CONFIG_HID_NINTENDO is not set
CONFIG_HID_NTI=m
# CONFIG_HID_NTRIG is not set
CONFIG_HID_ORTEK=m
CONFIG_HID_PANTHERLORD=m
# CONFIG_PANTHERLORD_FF is not set
# CONFIG_HID_PENMOUNT is not set
CONFIG_HID_PETALYNX=m
CONFIG_HID_PICOLCD=m
CONFIG_HID_PICOLCD_FB=y
CONFIG_HID_PICOLCD_BACKLIGHT=y
CONFIG_HID_PICOLCD_LCD=y
CONFIG_HID_PICOLCD_LEDS=y
CONFIG_HID_PICOLCD_CIR=y
CONFIG_HID_PLANTRONICS=m
# CONFIG_HID_RAZER is not set
CONFIG_HID_PRIMAX=m
# CONFIG_HID_RETRODE is not set
# CONFIG_HID_ROCCAT is not set
CONFIG_HID_SAITEK=m
CONFIG_HID_SAMSUNG=m
# CONFIG_HID_SEMITEK is not set
# CONFIG_HID_SIGMAMICRO is not set
# CONFIG_HID_SONY is not set
CONFIG_HID_SPEEDLINK=m
# CONFIG_HID_STEAM is not set
CONFIG_HID_STEELSERIES=m
CONFIG_HID_SUNPLUS=m
CONFIG_HID_RMI=m
CONFIG_HID_GREENASIA=m
# CONFIG_GREENASIA_FF is not set
CONFIG_HID_SMARTJOYPLUS=m
# CONFIG_SMARTJOYPLUS_FF is not set
CONFIG_HID_TIVO=m
CONFIG_HID_TOPSEED=m
CONFIG_HID_THINGM=m
CONFIG_HID_THRUSTMASTER=m
# CONFIG_THRUSTMASTER_FF is not set
# CONFIG_HID_UDRAW_PS3 is not set
# CONFIG_HID_U2FZERO is not set
# CONFIG_HID_WACOM is not set
CONFIG_HID_WIIMOTE=m
CONFIG_HID_XINMO=m
CONFIG_HID_ZEROPLUS=m
# CONFIG_ZEROPLUS_FF is not set
CONFIG_HID_ZYDACRON=m
CONFIG_HID_SENSOR_HUB=y
CONFIG_HID_SENSOR_CUSTOM_SENSOR=m
CONFIG_HID_ALPS=m
# CONFIG_HID_MCP2221 is not set
# end of Special HID drivers

#
# USB HID support
#
CONFIG_USB_HID=y
# CONFIG_HID_PID is not set
# CONFIG_USB_HIDDEV is not set
# end of USB HID support

#
# I2C HID support
#
# CONFIG_I2C_HID_ACPI is not set
# end of I2C HID support

#
# Intel ISH HID support
#
CONFIG_INTEL_ISH_HID=m
# CONFIG_INTEL_ISH_FIRMWARE_DOWNLOADER is not set
# end of Intel ISH HID support

#
# AMD SFH HID Support
#
# CONFIG_AMD_SFH_HID is not set
# end of AMD SFH HID Support
# end of HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
# CONFIG_USB_LED_TRIG is not set
# CONFIG_USB_ULPI_BUS is not set
# CONFIG_USB_CONN_GPIO is not set
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_PCI=y
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=y
# CONFIG_USB_FEW_INIT_RETRIES is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_OTG is not set
# CONFIG_USB_OTG_PRODUCTLIST is not set
# CONFIG_USB_OTG_DISABLE_EXTERNAL_HUB is not set
CONFIG_USB_LEDS_TRIGGER_USBPORT=y
CONFIG_USB_AUTOSUSPEND_DELAY=2
CONFIG_USB_MON=y

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
CONFIG_USB_XHCI_HCD=y
# CONFIG_USB_XHCI_DBGCAP is not set
CONFIG_USB_XHCI_PCI=y
# CONFIG_USB_XHCI_PCI_RENESAS is not set
# CONFIG_USB_XHCI_PLATFORM is not set
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_EHCI_PCI=y
# CONFIG_USB_EHCI_FSL is not set
# CONFIG_USB_EHCI_HCD_PLATFORM is not set
# CONFIG_USB_OXU210HP_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_FOTG210_HCD is not set
# CONFIG_USB_MAX3421_HCD is not set
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_HCD_PCI=y
# CONFIG_USB_OHCI_HCD_PLATFORM is not set
CONFIG_USB_UHCI_HCD=y
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_HCD_BCMA is not set
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
# CONFIG_USB_WDM is not set
# CONFIG_USB_TMC is not set

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_REALTEK is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_USBAT is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
# CONFIG_USB_STORAGE_ALAUDA is not set
# CONFIG_USB_STORAGE_ONETOUCH is not set
# CONFIG_USB_STORAGE_KARMA is not set
# CONFIG_USB_STORAGE_CYPRESS_ATACB is not set
# CONFIG_USB_STORAGE_ENE_UB6250 is not set
# CONFIG_USB_UAS is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USBIP_CORE is not set
# CONFIG_USB_CDNS_SUPPORT is not set
# CONFIG_USB_MUSB_HDRC is not set
# CONFIG_USB_DWC3 is not set
# CONFIG_USB_DWC2 is not set
# CONFIG_USB_CHIPIDEA is not set
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set
CONFIG_USB_SERIAL=m
CONFIG_USB_SERIAL_GENERIC=y
# CONFIG_USB_SERIAL_SIMPLE is not set
# CONFIG_USB_SERIAL_AIRCABLE is not set
# CONFIG_USB_SERIAL_ARK3116 is not set
# CONFIG_USB_SERIAL_BELKIN is not set
# CONFIG_USB_SERIAL_CH341 is not set
# CONFIG_USB_SERIAL_WHITEHEAT is not set
# CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
# CONFIG_USB_SERIAL_CP210X is not set
# CONFIG_USB_SERIAL_CYPRESS_M8 is not set
# CONFIG_USB_SERIAL_EMPEG is not set
# CONFIG_USB_SERIAL_FTDI_SIO is not set
# CONFIG_USB_SERIAL_VISOR is not set
# CONFIG_USB_SERIAL_IPAQ is not set
# CONFIG_USB_SERIAL_IR is not set
# CONFIG_USB_SERIAL_EDGEPORT is not set
# CONFIG_USB_SERIAL_EDGEPORT_TI is not set
# CONFIG_USB_SERIAL_F81232 is not set
# CONFIG_USB_SERIAL_F8153X is not set
# CONFIG_USB_SERIAL_GARMIN is not set
# CONFIG_USB_SERIAL_IPW is not set
# CONFIG_USB_SERIAL_IUU is not set
# CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
# CONFIG_USB_SERIAL_KEYSPAN is not set
# CONFIG_USB_SERIAL_KLSI is not set
# CONFIG_USB_SERIAL_KOBIL_SCT is not set
# CONFIG_USB_SERIAL_MCT_U232 is not set
# CONFIG_USB_SERIAL_METRO is not set
# CONFIG_USB_SERIAL_MOS7720 is not set
# CONFIG_USB_SERIAL_MOS7840 is not set
# CONFIG_USB_SERIAL_MXUPORT is not set
# CONFIG_USB_SERIAL_NAVMAN is not set
# CONFIG_USB_SERIAL_PL2303 is not set
# CONFIG_USB_SERIAL_OTI6858 is not set
# CONFIG_USB_SERIAL_QCAUX is not set
# CONFIG_USB_SERIAL_QUALCOMM is not set
# CONFIG_USB_SERIAL_SPCP8X5 is not set
# CONFIG_USB_SERIAL_SAFE is not set
# CONFIG_USB_SERIAL_SIERRAWIRELESS is not set
# CONFIG_USB_SERIAL_SYMBOL is not set
# CONFIG_USB_SERIAL_TI is not set
# CONFIG_USB_SERIAL_CYBERJACK is not set
# CONFIG_USB_SERIAL_OPTION is not set
# CONFIG_USB_SERIAL_OMNINET is not set
# CONFIG_USB_SERIAL_OPTICON is not set
# CONFIG_USB_SERIAL_XSENS_MT is not set
# CONFIG_USB_SERIAL_WISHBONE is not set
# CONFIG_USB_SERIAL_SSU100 is not set
# CONFIG_USB_SERIAL_QT2 is not set
# CONFIG_USB_SERIAL_UPD78F0730 is not set
# CONFIG_USB_SERIAL_XR is not set
CONFIG_USB_SERIAL_DEBUG=m

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_ADUTUX is not set
# CONFIG_USB_SEVSEG is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_FTDI_ELAN is not set
# CONFIG_USB_APPLEDISPLAY is not set
# CONFIG_APPLE_MFI_FASTCHARGE is not set
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TRANCEVIBRATOR is not set
# CONFIG_USB_IOWARRIOR is not set
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
# CONFIG_USB_ISIGHTFW is not set
# CONFIG_USB_YUREX is not set
# CONFIG_USB_EZUSB_FX2 is not set
# CONFIG_USB_HUB_USB251XB is not set
# CONFIG_USB_HSIC_USB3503 is not set
# CONFIG_USB_HSIC_USB4604 is not set
# CONFIG_USB_LINK_LAYER_TEST is not set
# CONFIG_USB_CHAOSKEY is not set
# CONFIG_USB_ATM is not set

#
# USB Physical Layer drivers
#
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_USB_ISP1301 is not set
# end of USB Physical Layer drivers

# CONFIG_USB_GADGET is not set
CONFIG_TYPEC=y
# CONFIG_TYPEC_TCPM is not set
CONFIG_TYPEC_UCSI=y
# CONFIG_UCSI_CCG is not set
CONFIG_UCSI_ACPI=y
# CONFIG_TYPEC_TPS6598X is not set
# CONFIG_TYPEC_RT1719 is not set
# CONFIG_TYPEC_STUSB160X is not set
# CONFIG_TYPEC_WUSB3801 is not set

#
# USB Type-C Multiplexer/DeMultiplexer Switch support
#
# CONFIG_TYPEC_MUX_FSA4480 is not set
# CONFIG_TYPEC_MUX_PI3USB30532 is not set
# end of USB Type-C Multiplexer/DeMultiplexer Switch support

#
# USB Type-C Alternate Mode drivers
#
# CONFIG_TYPEC_DP_ALTMODE is not set
# end of USB Type-C Alternate Mode drivers

# CONFIG_USB_ROLE_SWITCH is not set
CONFIG_MMC=m
CONFIG_MMC_BLOCK=m
CONFIG_MMC_BLOCK_MINORS=8
CONFIG_SDIO_UART=m
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_SDHCI=m
CONFIG_MMC_SDHCI_IO_ACCESSORS=y
CONFIG_MMC_SDHCI_PCI=m
CONFIG_MMC_RICOH_MMC=y
CONFIG_MMC_SDHCI_ACPI=m
CONFIG_MMC_SDHCI_PLTFM=m
# CONFIG_MMC_SDHCI_F_SDH30 is not set
# CONFIG_MMC_WBSD is not set
# CONFIG_MMC_TIFM_SD is not set
# CONFIG_MMC_SPI is not set
# CONFIG_MMC_CB710 is not set
# CONFIG_MMC_VIA_SDMMC is not set
# CONFIG_MMC_VUB300 is not set
# CONFIG_MMC_USHC is not set
# CONFIG_MMC_USDHI6ROL0 is not set
# CONFIG_MMC_REALTEK_PCI is not set
CONFIG_MMC_CQHCI=m
# CONFIG_MMC_HSQ is not set
# CONFIG_MMC_TOSHIBA_PCI is not set
# CONFIG_MMC_MTK is not set
# CONFIG_MMC_SDHCI_XENON is not set
# CONFIG_SCSI_UFSHCD is not set
# CONFIG_MEMSTICK is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set
# CONFIG_LEDS_CLASS_MULTICOLOR is not set
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
# CONFIG_LEDS_APU is not set
CONFIG_LEDS_LM3530=m
# CONFIG_LEDS_LM3532 is not set
# CONFIG_LEDS_LM3642 is not set
# CONFIG_LEDS_PCA9532 is not set
# CONFIG_LEDS_GPIO is not set
CONFIG_LEDS_LP3944=m
# CONFIG_LEDS_LP3952 is not set
# CONFIG_LEDS_LP50XX is not set
CONFIG_LEDS_CLEVO_MAIL=m
# CONFIG_LEDS_PCA955X is not set
# CONFIG_LEDS_PCA963X is not set
# CONFIG_LEDS_DAC124S085 is not set
# CONFIG_LEDS_PWM is not set
# CONFIG_LEDS_BD2802 is not set
CONFIG_LEDS_INTEL_SS4200=m
CONFIG_LEDS_LT3593=m
# CONFIG_LEDS_TCA6507 is not set
# CONFIG_LEDS_TLC591XX is not set
# CONFIG_LEDS_LM355x is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=m
CONFIG_LEDS_MLXCPLD=m
# CONFIG_LEDS_MLXREG is not set
# CONFIG_LEDS_USER is not set
# CONFIG_LEDS_NIC78BX is not set
# CONFIG_LEDS_TI_LMU_COMMON is not set

#
# Flash and Torch LED drivers
#

#
# RGB LED drivers
#

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=m
CONFIG_LEDS_TRIGGER_ONESHOT=m
# CONFIG_LEDS_TRIGGER_DISK is not set
CONFIG_LEDS_TRIGGER_HEARTBEAT=m
CONFIG_LEDS_TRIGGER_BACKLIGHT=m
# CONFIG_LEDS_TRIGGER_CPU is not set
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
CONFIG_LEDS_TRIGGER_GPIO=m
CONFIG_LEDS_TRIGGER_DEFAULT_ON=m

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=m
CONFIG_LEDS_TRIGGER_CAMERA=m
# CONFIG_LEDS_TRIGGER_PANIC is not set
# CONFIG_LEDS_TRIGGER_NETDEV is not set
# CONFIG_LEDS_TRIGGER_PATTERN is not set
CONFIG_LEDS_TRIGGER_AUDIO=m
# CONFIG_LEDS_TRIGGER_TTY is not set

#
# Simple LED drivers
#
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
CONFIG_EDAC_LEGACY_SYSFS=y
# CONFIG_EDAC_DEBUG is not set
CONFIG_EDAC_GHES=y
CONFIG_EDAC_E752X=m
CONFIG_EDAC_I82975X=m
CONFIG_EDAC_I3000=m
CONFIG_EDAC_I3200=m
CONFIG_EDAC_IE31200=m
CONFIG_EDAC_X38=m
CONFIG_EDAC_I5400=m
CONFIG_EDAC_I7CORE=m
CONFIG_EDAC_I5000=m
CONFIG_EDAC_I5100=m
CONFIG_EDAC_I7300=m
CONFIG_EDAC_SBRIDGE=m
CONFIG_EDAC_SKX=m
# CONFIG_EDAC_I10NM is not set
CONFIG_EDAC_PND2=m
# CONFIG_EDAC_IGEN6 is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
# CONFIG_RTC_SYSTOHC is not set
# CONFIG_RTC_DEBUG is not set
CONFIG_RTC_NVMEM=y

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
# CONFIG_RTC_DRV_ABB5ZES3 is not set
# CONFIG_RTC_DRV_ABEOZ9 is not set
# CONFIG_RTC_DRV_ABX80X is not set
CONFIG_RTC_DRV_DS1307=m
# CONFIG_RTC_DRV_DS1307_CENTURY is not set
CONFIG_RTC_DRV_DS1374=m
# CONFIG_RTC_DRV_DS1374_WDT is not set
CONFIG_RTC_DRV_DS1672=m
CONFIG_RTC_DRV_MAX6900=m
CONFIG_RTC_DRV_RS5C372=m
CONFIG_RTC_DRV_ISL1208=m
CONFIG_RTC_DRV_ISL12022=m
CONFIG_RTC_DRV_X1205=m
CONFIG_RTC_DRV_PCF8523=m
# CONFIG_RTC_DRV_PCF85063 is not set
# CONFIG_RTC_DRV_PCF85363 is not set
CONFIG_RTC_DRV_PCF8563=m
CONFIG_RTC_DRV_PCF8583=m
CONFIG_RTC_DRV_M41T80=m
CONFIG_RTC_DRV_M41T80_WDT=y
CONFIG_RTC_DRV_BQ32K=m
# CONFIG_RTC_DRV_S35390A is not set
CONFIG_RTC_DRV_FM3130=m
# CONFIG_RTC_DRV_RX8010 is not set
CONFIG_RTC_DRV_RX8581=m
CONFIG_RTC_DRV_RX8025=m
CONFIG_RTC_DRV_EM3027=m
# CONFIG_RTC_DRV_RV3028 is not set
# CONFIG_RTC_DRV_RV3032 is not set
# CONFIG_RTC_DRV_RV8803 is not set
# CONFIG_RTC_DRV_SD3078 is not set

#
# SPI RTC drivers
#
# CONFIG_RTC_DRV_M41T93 is not set
# CONFIG_RTC_DRV_M41T94 is not set
# CONFIG_RTC_DRV_DS1302 is not set
# CONFIG_RTC_DRV_DS1305 is not set
# CONFIG_RTC_DRV_DS1343 is not set
# CONFIG_RTC_DRV_DS1347 is not set
# CONFIG_RTC_DRV_DS1390 is not set
# CONFIG_RTC_DRV_MAX6916 is not set
# CONFIG_RTC_DRV_R9701 is not set
CONFIG_RTC_DRV_RX4581=m
# CONFIG_RTC_DRV_RS5C348 is not set
# CONFIG_RTC_DRV_MAX6902 is not set
# CONFIG_RTC_DRV_PCF2123 is not set
# CONFIG_RTC_DRV_MCP795 is not set
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=m
CONFIG_RTC_DRV_DS3232_HWMON=y
# CONFIG_RTC_DRV_PCF2127 is not set
CONFIG_RTC_DRV_RV3029C2=m
# CONFIG_RTC_DRV_RV3029_HWMON is not set
# CONFIG_RTC_DRV_RX6110 is not set

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
CONFIG_RTC_DRV_DS1286=m
CONFIG_RTC_DRV_DS1511=m
CONFIG_RTC_DRV_DS1553=m
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
CONFIG_RTC_DRV_DS1742=m
CONFIG_RTC_DRV_DS2404=m
CONFIG_RTC_DRV_STK17TA8=m
# CONFIG_RTC_DRV_M48T86 is not set
CONFIG_RTC_DRV_M48T35=m
CONFIG_RTC_DRV_M48T59=m
CONFIG_RTC_DRV_MSM6242=m
CONFIG_RTC_DRV_BQ4802=m
CONFIG_RTC_DRV_RP5C01=m
CONFIG_RTC_DRV_V3020=m

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_FTRTC010 is not set

#
# HID Sensor RTC drivers
#
# CONFIG_RTC_DRV_GOLDFISH is not set
CONFIG_DMADEVICES=y
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
# CONFIG_ALTERA_MSGDMA is not set
CONFIG_INTEL_IDMA64=m
# CONFIG_INTEL_IDXD is not set
# CONFIG_INTEL_IDXD_COMPAT is not set
CONFIG_INTEL_IOATDMA=m
# CONFIG_PLX_DMA is not set
# CONFIG_AMD_PTDMA is not set
# CONFIG_QCOM_HIDMA_MGMT is not set
# CONFIG_QCOM_HIDMA is not set
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=m
CONFIG_DW_DMAC_PCI=y
# CONFIG_DW_EDMA is not set
# CONFIG_DW_EDMA_PCIE is not set
CONFIG_HSU_DMA=y
# CONFIG_SF_PDMA is not set
# CONFIG_INTEL_LDMA is not set

#
# DMA Clients
#
CONFIG_ASYNC_TX_DMA=y
CONFIG_DMATEST=m
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
CONFIG_SW_SYNC=y
CONFIG_UDMABUF=y
# CONFIG_DMABUF_MOVE_NOTIFY is not set
# CONFIG_DMABUF_DEBUG is not set
# CONFIG_DMABUF_SELFTESTS is not set
CONFIG_DMABUF_HEAPS=y
# CONFIG_DMABUF_SYSFS_STATS is not set
CONFIG_DMABUF_HEAPS_SYSTEM=y
# end of DMABUF options

CONFIG_DCA=m
# CONFIG_AUXDISPLAY is not set
# CONFIG_PANEL is not set
CONFIG_UIO=m
CONFIG_UIO_CIF=m
CONFIG_UIO_PDRV_GENIRQ=m
# CONFIG_UIO_DMEM_GENIRQ is not set
CONFIG_UIO_AEC=m
CONFIG_UIO_SERCOS3=m
CONFIG_UIO_PCI_GENERIC=m
# CONFIG_UIO_NETX is not set
# CONFIG_UIO_PRUSS is not set
# CONFIG_UIO_MF624 is not set
CONFIG_VFIO=m
CONFIG_VFIO_IOMMU_TYPE1=m
CONFIG_VFIO_VIRQFD=m
CONFIG_VFIO_NOIOMMU=y
CONFIG_VFIO_PCI_CORE=m
CONFIG_VFIO_PCI_MMAP=y
CONFIG_VFIO_PCI_INTX=y
CONFIG_VFIO_PCI=m
# CONFIG_VFIO_PCI_VGA is not set
# CONFIG_VFIO_PCI_IGD is not set
CONFIG_VFIO_MDEV=m
CONFIG_IRQ_BYPASS_MANAGER=y
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO=y
CONFIG_VIRTIO_PCI_LIB=y
CONFIG_VIRTIO_PCI_LIB_LEGACY=y
CONFIG_VIRTIO_MENU=y
# CONFIG_VIRTIO_HARDEN_NOTIFICATION is not set
CONFIG_VIRTIO_PCI=y
CONFIG_VIRTIO_PCI_LEGACY=y
# CONFIG_VIRTIO_PMEM is not set
CONFIG_VIRTIO_BALLOON=m
# CONFIG_VIRTIO_MEM is not set
CONFIG_VIRTIO_INPUT=m
# CONFIG_VIRTIO_MMIO is not set
CONFIG_VIRTIO_DMA_SHARED_BUFFER=m
# CONFIG_VDPA is not set
CONFIG_VHOST_IOTLB=m
CONFIG_VHOST=m
CONFIG_VHOST_MENU=y
CONFIG_VHOST_NET=m
# CONFIG_VHOST_SCSI is not set
CONFIG_VHOST_VSOCK=m
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV is not set
# end of Microsoft Hyper-V guest support

# CONFIG_GREYBUS is not set
# CONFIG_COMEDI is not set
CONFIG_STAGING=y
# CONFIG_PRISM2_USB is not set
# CONFIG_RTL8192U is not set
# CONFIG_RTLLIB is not set
# CONFIG_RTL8723BS is not set
# CONFIG_R8712U is not set
# CONFIG_R8188EU is not set
# CONFIG_RTS5208 is not set
# CONFIG_VT6655 is not set
# CONFIG_VT6656 is not set
# CONFIG_FB_SM750 is not set
# CONFIG_STAGING_MEDIA is not set
# CONFIG_LTE_GDM724X is not set
# CONFIG_FIREWIRE_SERIAL is not set
# CONFIG_FB_TFT is not set
# CONFIG_KS7010 is not set
# CONFIG_PI433 is not set
# CONFIG_FIELDBUS_DEV is not set
# CONFIG_QLGE is not set

#
# VME Device Drivers
#
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACPI_WMI=m
CONFIG_WMI_BMOF=m
# CONFIG_HUAWEI_WMI is not set
# CONFIG_UV_SYSFS is not set
CONFIG_MXM_WMI=m
# CONFIG_PEAQ_WMI is not set
# CONFIG_NVIDIA_WMI_EC_BACKLIGHT is not set
# CONFIG_XIAOMI_WMI is not set
# CONFIG_GIGABYTE_WMI is not set
# CONFIG_YOGABOOK_WMI is not set
CONFIG_ACERHDF=m
# CONFIG_ACER_WIRELESS is not set
CONFIG_ACER_WMI=m
# CONFIG_AMD_PMC is not set
# CONFIG_AMD_HSMP is not set
# CONFIG_ADV_SWBUTTON is not set
CONFIG_APPLE_GMUX=m
CONFIG_ASUS_LAPTOP=m
# CONFIG_ASUS_WIRELESS is not set
CONFIG_ASUS_WMI=m
CONFIG_ASUS_NB_WMI=m
# CONFIG_ASUS_TF103C_DOCK is not set
# CONFIG_MERAKI_MX100 is not set
CONFIG_EEEPC_LAPTOP=m
CONFIG_EEEPC_WMI=m
# CONFIG_X86_PLATFORM_DRIVERS_DELL is not set
CONFIG_AMILO_RFKILL=m
CONFIG_FUJITSU_LAPTOP=m
CONFIG_FUJITSU_TABLET=m
# CONFIG_GPD_POCKET_FAN is not set
CONFIG_HP_ACCEL=m
# CONFIG_WIRELESS_HOTKEY is not set
CONFIG_HP_WMI=m
# CONFIG_IBM_RTL is not set
CONFIG_IDEAPAD_LAPTOP=m
CONFIG_SENSORS_HDAPS=m
CONFIG_THINKPAD_ACPI=m
# CONFIG_THINKPAD_ACPI_DEBUGFACILITIES is not set
# CONFIG_THINKPAD_ACPI_DEBUG is not set
# CONFIG_THINKPAD_ACPI_UNSAFE_LEDS is not set
CONFIG_THINKPAD_ACPI_VIDEO=y
CONFIG_THINKPAD_ACPI_HOTKEY_POLL=y
# CONFIG_THINKPAD_LMI is not set
# CONFIG_INTEL_ATOMISP2_PM is not set
# CONFIG_INTEL_IFS is not set
# CONFIG_INTEL_SAR_INT1092 is not set
CONFIG_INTEL_PMC_CORE=m

#
# Intel Speed Select Technology interface support
#
# CONFIG_INTEL_SPEED_SELECT_INTERFACE is not set
# end of Intel Speed Select Technology interface support

CONFIG_INTEL_WMI=y
# CONFIG_INTEL_WMI_SBL_FW_UPDATE is not set
CONFIG_INTEL_WMI_THUNDERBOLT=m

#
# Intel Uncore Frequency Control
#
# CONFIG_INTEL_UNCORE_FREQ_CONTROL is not set
# end of Intel Uncore Frequency Control

CONFIG_INTEL_HID_EVENT=m
CONFIG_INTEL_VBTN=m
# CONFIG_INTEL_INT0002_VGPIO is not set
CONFIG_INTEL_OAKTRAIL=m
# CONFIG_INTEL_ISHTP_ECLITE is not set
# CONFIG_INTEL_PUNIT_IPC is not set
CONFIG_INTEL_RST=m
# CONFIG_INTEL_SMARTCONNECT is not set
CONFIG_INTEL_TURBO_MAX_3=y
# CONFIG_INTEL_VSEC is not set
CONFIG_MSI_LAPTOP=m
CONFIG_MSI_WMI=m
# CONFIG_PCENGINES_APU2 is not set
# CONFIG_BARCO_P50_GPIO is not set
CONFIG_SAMSUNG_LAPTOP=m
CONFIG_SAMSUNG_Q10=m
CONFIG_TOSHIBA_BT_RFKILL=m
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_TOSHIBA_WMI is not set
CONFIG_ACPI_CMPC=m
CONFIG_COMPAL_LAPTOP=m
# CONFIG_LG_LAPTOP is not set
CONFIG_PANASONIC_LAPTOP=m
CONFIG_SONY_LAPTOP=m
CONFIG_SONYPI_COMPAT=y
# CONFIG_SYSTEM76_ACPI is not set
CONFIG_TOPSTAR_LAPTOP=m
# CONFIG_SERIAL_MULTI_INSTANTIATE is not set
CONFIG_MLX_PLATFORM=m
CONFIG_INTEL_IPS=m
# CONFIG_INTEL_SCU_PCI is not set
# CONFIG_INTEL_SCU_PLATFORM is not set
# CONFIG_SIEMENS_SIMATIC_IPC is not set
# CONFIG_WINMATE_FM07_KEYS is not set
CONFIG_PMC_ATOM=y
# CONFIG_CHROME_PLATFORMS is not set
CONFIG_MELLANOX_PLATFORM=y
CONFIG_MLXREG_HOTPLUG=m
# CONFIG_MLXREG_IO is not set
# CONFIG_MLXREG_LC is not set
# CONFIG_NVSW_SN2201 is not set
CONFIG_SURFACE_PLATFORMS=y
# CONFIG_SURFACE3_WMI is not set
# CONFIG_SURFACE_3_POWER_OPREGION is not set
# CONFIG_SURFACE_GPE is not set
# CONFIG_SURFACE_HOTPLUG is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
CONFIG_HAVE_CLK=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
# CONFIG_LMK04832 is not set
# CONFIG_COMMON_CLK_MAX9485 is not set
# CONFIG_COMMON_CLK_SI5341 is not set
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI544 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_PWM is not set
# CONFIG_XILINX_VCU is not set
CONFIG_HWSPINLOCK=y

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
CONFIG_PCC=y
# CONFIG_ALTERA_MBOX is not set
CONFIG_IOMMU_IOVA=y
CONFIG_IOASID=y
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# end of Generic IOMMU Pagetable Support

# CONFIG_IOMMU_DEBUGFS is not set
# CONFIG_IOMMU_DEFAULT_DMA_STRICT is not set
CONFIG_IOMMU_DEFAULT_DMA_LAZY=y
# CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
CONFIG_IOMMU_DMA=y
# CONFIG_AMD_IOMMU is not set
CONFIG_DMAR_TABLE=y
CONFIG_INTEL_IOMMU=y
# CONFIG_INTEL_IOMMU_SVM is not set
# CONFIG_INTEL_IOMMU_DEFAULT_ON is not set
CONFIG_INTEL_IOMMU_FLOPPY_WA=y
CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON=y
CONFIG_IRQ_REMAP=y
# CONFIG_VIRTIO_IOMMU is not set

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
# CONFIG_RPMSG_QCOM_GLINK_RPM is not set
# CONFIG_RPMSG_VIRTIO is not set
# end of Rpmsg drivers

# CONFIG_SOUNDWIRE is not set

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#
# end of Amlogic SoC drivers

#
# Broadcom SoC drivers
#
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# end of NXP/Freescale QorIQ SoC drivers

#
# i.MX SoC drivers
#
# end of i.MX SoC drivers

#
# Enable LiteX SoC Builder specific drivers
#
# end of Enable LiteX SoC Builder specific drivers

#
# Qualcomm SoC drivers
#
# end of Qualcomm SoC drivers

# CONFIG_SOC_TI is not set

#
# Xilinx SoC drivers
#
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

# CONFIG_PM_DEVFREQ is not set
# CONFIG_EXTCON is not set
# CONFIG_MEMORY is not set
# CONFIG_IIO is not set
CONFIG_NTB=m
# CONFIG_NTB_MSI is not set
# CONFIG_NTB_AMD is not set
# CONFIG_NTB_IDT is not set
# CONFIG_NTB_INTEL is not set
# CONFIG_NTB_EPF is not set
# CONFIG_NTB_SWITCHTEC is not set
# CONFIG_NTB_PINGPONG is not set
# CONFIG_NTB_TOOL is not set
# CONFIG_NTB_PERF is not set
# CONFIG_NTB_TRANSPORT is not set
# CONFIG_VME_BUS is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_DEBUG is not set
# CONFIG_PWM_DWC is not set
CONFIG_PWM_LPSS=m
CONFIG_PWM_LPSS_PCI=m
CONFIG_PWM_LPSS_PLATFORM=m
# CONFIG_PWM_PCA9685 is not set

#
# IRQ chip support
#
# end of IRQ chip support

# CONFIG_IPACK_BUS is not set
# CONFIG_RESET_CONTROLLER is not set

#
# PHY Subsystem
#
# CONFIG_GENERIC_PHY is not set
# CONFIG_USB_LGM_PHY is not set
# CONFIG_PHY_CAN_TRANSCEIVER is not set

#
# PHY drivers for Broadcom platforms
#
# CONFIG_BCM_KONA_USB2_PHY is not set
# end of PHY drivers for Broadcom platforms

# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
# CONFIG_PHY_INTEL_LGM_EMMC is not set
# end of PHY Subsystem

CONFIG_POWERCAP=y
CONFIG_INTEL_RAPL_CORE=m
CONFIG_INTEL_RAPL=m
# CONFIG_IDLE_INJECT is not set
# CONFIG_MCB is not set

#
# Performance monitor support
#
# end of Performance monitor support

CONFIG_RAS=y
# CONFIG_RAS_CEC is not set
# CONFIG_USB4 is not set

#
# Android
#
CONFIG_ANDROID=y
# CONFIG_ANDROID_BINDER_IPC is not set
# end of Android

CONFIG_LIBNVDIMM=m
CONFIG_BLK_DEV_PMEM=m
CONFIG_ND_CLAIM=y
CONFIG_ND_BTT=m
CONFIG_BTT=y
CONFIG_ND_PFN=m
CONFIG_NVDIMM_PFN=y
CONFIG_NVDIMM_DAX=y
CONFIG_NVDIMM_KEYS=y
CONFIG_DAX=y
CONFIG_DEV_DAX=m
CONFIG_DEV_DAX_PMEM=m
CONFIG_DEV_DAX_KMEM=m
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y
# CONFIG_NVMEM_RMEM is not set

#
# HW tracing support
#
CONFIG_STM=m
# CONFIG_STM_PROTO_BASIC is not set
# CONFIG_STM_PROTO_SYS_T is not set
CONFIG_STM_DUMMY=m
CONFIG_STM_SOURCE_CONSOLE=m
CONFIG_STM_SOURCE_HEARTBEAT=m
CONFIG_STM_SOURCE_FTRACE=m
CONFIG_INTEL_TH=m
CONFIG_INTEL_TH_PCI=m
CONFIG_INTEL_TH_ACPI=m
CONFIG_INTEL_TH_GTH=m
CONFIG_INTEL_TH_STH=m
CONFIG_INTEL_TH_MSU=m
CONFIG_INTEL_TH_PTI=m
# CONFIG_INTEL_TH_DEBUG is not set
# end of HW tracing support

# CONFIG_FPGA is not set
# CONFIG_TEE is not set
# CONFIG_SIOX is not set
# CONFIG_SLIMBUS is not set
# CONFIG_INTERCONNECT is not set
# CONFIG_COUNTER is not set
# CONFIG_MOST is not set
# CONFIG_PECI is not set
# CONFIG_HTE is not set
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
# CONFIG_VALIDATE_FS_PARSER is not set
CONFIG_FS_IOMAP=y
# CONFIG_EXT2_FS is not set
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=y
CONFIG_EXT4_USE_FOR_EXT2=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=y
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=m
CONFIG_XFS_SUPPORT_V4=y
CONFIG_XFS_QUOTA=y
CONFIG_XFS_POSIX_ACL=y
CONFIG_XFS_RT=y
CONFIG_XFS_ONLINE_SCRUB=y
# CONFIG_XFS_ONLINE_REPAIR is not set
CONFIG_XFS_DEBUG=y
CONFIG_XFS_ASSERT_FATAL=y
CONFIG_GFS2_FS=m
CONFIG_GFS2_FS_LOCKING_DLM=y
CONFIG_OCFS2_FS=m
CONFIG_OCFS2_FS_O2CB=m
CONFIG_OCFS2_FS_USERSPACE_CLUSTER=m
CONFIG_OCFS2_FS_STATS=y
CONFIG_OCFS2_DEBUG_MASKLOG=y
# CONFIG_OCFS2_DEBUG_FS is not set
CONFIG_BTRFS_FS=m
CONFIG_BTRFS_FS_POSIX_ACL=y
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
# CONFIG_BTRFS_ASSERT is not set
# CONFIG_BTRFS_FS_REF_VERIFY is not set
# CONFIG_NILFS2_FS is not set
CONFIG_F2FS_FS=m
CONFIG_F2FS_STAT_FS=y
CONFIG_F2FS_FS_XATTR=y
CONFIG_F2FS_FS_POSIX_ACL=y
# CONFIG_F2FS_FS_SECURITY is not set
# CONFIG_F2FS_CHECK_FS is not set
# CONFIG_F2FS_FAULT_INJECTION is not set
# CONFIG_F2FS_FS_COMPRESSION is not set
CONFIG_F2FS_IOSTAT=y
# CONFIG_F2FS_UNFAIR_RWSEM is not set
CONFIG_FS_DAX=y
CONFIG_FS_DAX_PMD=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
CONFIG_FS_ENCRYPTION_ALGS=y
# CONFIG_FS_VERITY is not set
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
CONFIG_QUOTA=y
CONFIG_QUOTA_NETLINK_INTERFACE=y
CONFIG_PRINT_QUOTA_WARNING=y
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=y
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=m
CONFIG_CUSE=m
# CONFIG_VIRTIO_FS is not set
CONFIG_OVERLAY_FS=m
# CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
# CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
# CONFIG_OVERLAY_FS_INDEX is not set
# CONFIG_OVERLAY_FS_XINO_AUTO is not set
# CONFIG_OVERLAY_FS_METACOPY is not set

#
# Caches
#
CONFIG_NETFS_SUPPORT=m
CONFIG_NETFS_STATS=y
CONFIG_FSCACHE=m
CONFIG_FSCACHE_STATS=y
# CONFIG_FSCACHE_DEBUG is not set
CONFIG_CACHEFILES=m
# CONFIG_CACHEFILES_DEBUG is not set
# CONFIG_CACHEFILES_ERROR_INJECTION is not set
# CONFIG_CACHEFILES_ONDEMAND is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_UDF_FS=m
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/EXFAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="ascii"
# CONFIG_FAT_DEFAULT_UTF8 is not set
# CONFIG_EXFAT_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_NTFS3_FS is not set
# end of DOS/FAT/EXFAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_VMCORE=y
CONFIG_PROC_VMCORE_DEVICE_DUMP=y
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_PROC_CPU_RESCTRL=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
# CONFIG_TMPFS_INODE64 is not set
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP=y
CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP=y
# CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON is not set
CONFIG_MEMFD_CREATE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
CONFIG_EFIVAR_FS=y
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_ECRYPT_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
CONFIG_CRAMFS=m
CONFIG_CRAMFS_BLOCKDEV=y
CONFIG_SQUASHFS=m
# CONFIG_SQUASHFS_FILE_CACHE is not set
CONFIG_SQUASHFS_FILE_DIRECT=y
# CONFIG_SQUASHFS_DECOMP_SINGLE is not set
# CONFIG_SQUASHFS_DECOMP_MULTI is not set
CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU=y
CONFIG_SQUASHFS_XATTR=y
CONFIG_SQUASHFS_ZLIB=y
# CONFIG_SQUASHFS_LZ4 is not set
CONFIG_SQUASHFS_LZO=y
CONFIG_SQUASHFS_XZ=y
# CONFIG_SQUASHFS_ZSTD is not set
# CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
# CONFIG_SQUASHFS_EMBEDDED is not set
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
# CONFIG_VXFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_OMFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX6FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFAULT_KMSG_BYTES=10240
CONFIG_PSTORE_DEFLATE_COMPRESS=y
# CONFIG_PSTORE_LZO_COMPRESS is not set
# CONFIG_PSTORE_LZ4_COMPRESS is not set
# CONFIG_PSTORE_LZ4HC_COMPRESS is not set
# CONFIG_PSTORE_842_COMPRESS is not set
# CONFIG_PSTORE_ZSTD_COMPRESS is not set
CONFIG_PSTORE_COMPRESS=y
CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT=y
CONFIG_PSTORE_COMPRESS_DEFAULT="deflate"
CONFIG_PSTORE_CONSOLE=y
CONFIG_PSTORE_PMSG=y
# CONFIG_PSTORE_FTRACE is not set
CONFIG_PSTORE_RAM=m
# CONFIG_PSTORE_BLK is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
# CONFIG_EROFS_FS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
# CONFIG_NFS_V2 is not set
CONFIG_NFS_V3=y
CONFIG_NFS_V3_ACL=y
CONFIG_NFS_V4=m
# CONFIG_NFS_SWAP is not set
CONFIG_NFS_V4_1=y
CONFIG_NFS_V4_2=y
CONFIG_PNFS_FILE_LAYOUT=m
CONFIG_PNFS_BLOCK=m
CONFIG_PNFS_FLEXFILE_LAYOUT=m
CONFIG_NFS_V4_1_IMPLEMENTATION_ID_DOMAIN="kernel.org"
# CONFIG_NFS_V4_1_MIGRATION is not set
CONFIG_NFS_V4_SECURITY_LABEL=y
CONFIG_ROOT_NFS=y
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
CONFIG_NFS_DEBUG=y
CONFIG_NFS_DISABLE_UDP_SUPPORT=y
# CONFIG_NFS_V4_2_READ_PLUS is not set
CONFIG_NFSD=m
CONFIG_NFSD_V2_ACL=y
CONFIG_NFSD_V3_ACL=y
CONFIG_NFSD_V4=y
CONFIG_NFSD_PNFS=y
# CONFIG_NFSD_BLOCKLAYOUT is not set
CONFIG_NFSD_SCSILAYOUT=y
# CONFIG_NFSD_FLEXFILELAYOUT is not set
# CONFIG_NFSD_V4_2_INTER_SSC is not set
CONFIG_NFSD_V4_SECURITY_LABEL=y
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_ACL_SUPPORT=y
CONFIG_NFS_COMMON=y
CONFIG_NFS_V4_2_SSC_HELPER=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=m
CONFIG_SUNRPC_BACKCHANNEL=y
CONFIG_RPCSEC_GSS_KRB5=m
# CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES is not set
CONFIG_SUNRPC_DEBUG=y
CONFIG_CEPH_FS=m
# CONFIG_CEPH_FSCACHE is not set
CONFIG_CEPH_FS_POSIX_ACL=y
# CONFIG_CEPH_FS_SECURITY_LABEL is not set
CONFIG_CIFS=m
CONFIG_CIFS_STATS2=y
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
CONFIG_CIFS_UPCALL=y
CONFIG_CIFS_XATTR=y
CONFIG_CIFS_POSIX=y
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
CONFIG_CIFS_DFS_UPCALL=y
# CONFIG_CIFS_SWN_UPCALL is not set
# CONFIG_CIFS_FSCACHE is not set
# CONFIG_SMB_SERVER is not set
CONFIG_SMBFS_COMMON=m
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="utf8"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_MAC_ROMAN=m
CONFIG_NLS_MAC_CELTIC=m
CONFIG_NLS_MAC_CENTEURO=m
CONFIG_NLS_MAC_CROATIAN=m
CONFIG_NLS_MAC_CYRILLIC=m
CONFIG_NLS_MAC_GAELIC=m
CONFIG_NLS_MAC_GREEK=m
CONFIG_NLS_MAC_ICELAND=m
CONFIG_NLS_MAC_INUIT=m
CONFIG_NLS_MAC_ROMANIAN=m
CONFIG_NLS_MAC_TURKISH=m
CONFIG_NLS_UTF8=m
CONFIG_DLM=m
CONFIG_DLM_DEBUG=y
# CONFIG_UNICODE is not set
CONFIG_IO_WQ=y
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_KEYS_REQUEST_CACHE is not set
CONFIG_PERSISTENT_KEYRINGS=y
CONFIG_TRUSTED_KEYS=y
CONFIG_TRUSTED_KEYS_TPM=y
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_USER_DECRYPTED_DATA is not set
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
CONFIG_PAGE_TABLE_ISOLATION=y
CONFIG_SECURITY_NETWORK_XFRM=y
CONFIG_SECURITY_PATH=y
CONFIG_INTEL_TXT=y
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
CONFIG_FORTIFY_SOURCE=y
# CONFIG_STATIC_USERMODEHELPER is not set
# CONFIG_SECURITY_SELINUX is not set
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
# CONFIG_SECURITY_APPARMOR is not set
# CONFIG_SECURITY_LOADPIN is not set
CONFIG_SECURITY_YAMA=y
# CONFIG_SECURITY_SAFESETID is not set
# CONFIG_SECURITY_LOCKDOWN_LSM is not set
CONFIG_SECURITY_LANDLOCK=y
CONFIG_INTEGRITY=y
CONFIG_INTEGRITY_SIGNATURE=y
CONFIG_INTEGRITY_ASYMMETRIC_KEYS=y
CONFIG_INTEGRITY_TRUSTED_KEYRING=y
# CONFIG_INTEGRITY_PLATFORM_KEYRING is not set
CONFIG_INTEGRITY_AUDIT=y
CONFIG_IMA=y
CONFIG_IMA_MEASURE_PCR_IDX=10
CONFIG_IMA_NG_TEMPLATE=y
# CONFIG_IMA_SIG_TEMPLATE is not set
CONFIG_IMA_DEFAULT_TEMPLATE="ima-ng"
CONFIG_IMA_DEFAULT_HASH_SHA1=y
# CONFIG_IMA_DEFAULT_HASH_SHA256 is not set
# CONFIG_IMA_DEFAULT_HASH_SHA512 is not set
CONFIG_IMA_DEFAULT_HASH="sha1"
CONFIG_IMA_WRITE_POLICY=y
CONFIG_IMA_READ_POLICY=y
CONFIG_IMA_APPRAISE=y
CONFIG_IMA_ARCH_POLICY=y
# CONFIG_IMA_APPRAISE_BUILD_POLICY is not set
CONFIG_IMA_APPRAISE_BOOTPARAM=y
# CONFIG_IMA_APPRAISE_MODSIG is not set
CONFIG_IMA_TRUSTED_KEYRING=y
# CONFIG_IMA_BLACKLIST_KEYRING is not set
# CONFIG_IMA_LOAD_X509 is not set
CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS=y
CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS=y
CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT=y
# CONFIG_IMA_DISABLE_HTABLE is not set
# CONFIG_EVM is not set
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_LSM="landlock,lockdown,yama,loadpin,safesetid,integrity,bpf"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_INIT_STACK_NONE=y
# CONFIG_GCC_PLUGIN_STRUCTLEAK_USER is not set
# CONFIG_GCC_PLUGIN_STACKLEAK is not set
CONFIG_INIT_ON_ALLOC_DEFAULT_ON=y
# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
CONFIG_CC_HAS_ZERO_CALL_USED_REGS=y
# CONFIG_ZERO_CALL_USED_REGS is not set
# end of Memory initialization

CONFIG_RANDSTRUCT_NONE=y
# CONFIG_RANDSTRUCT_FULL is not set
# CONFIG_RANDSTRUCT_PERFORMANCE is not set
# end of Kernel hardening options
# end of Security options

CONFIG_XOR_BLOCKS=m
CONFIG_ASYNC_CORE=m
CONFIG_ASYNC_MEMCPY=m
CONFIG_ASYNC_XOR=m
CONFIG_ASYNC_PQ=m
CONFIG_ASYNC_RAID6_RECOV=m
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_SKCIPHER=y
CONFIG_CRYPTO_SKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=m
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_USER=m
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=m
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=m
# CONFIG_CRYPTO_TEST is not set
CONFIG_CRYPTO_SIMD=y

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=m
# CONFIG_CRYPTO_DH_RFC7919_GROUPS is not set
CONFIG_CRYPTO_ECC=m
CONFIG_CRYPTO_ECDH=m
# CONFIG_CRYPTO_ECDSA is not set
# CONFIG_CRYPTO_ECRDSA is not set
# CONFIG_CRYPTO_SM2 is not set
# CONFIG_CRYPTO_CURVE25519 is not set
# CONFIG_CRYPTO_CURVE25519_X86 is not set

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_CHACHA20POLY1305=m
# CONFIG_CRYPTO_AEGIS128 is not set
# CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=m

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CFB=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=m
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=m
# CONFIG_CRYPTO_OFB is not set
CONFIG_CRYPTO_PCBC=m
CONFIG_CRYPTO_XTS=m
# CONFIG_CRYPTO_KEYWRAP is not set
# CONFIG_CRYPTO_NHPOLY1305_SSE2 is not set
# CONFIG_CRYPTO_NHPOLY1305_AVX2 is not set
# CONFIG_CRYPTO_ADIANTUM is not set
CONFIG_CRYPTO_ESSIV=m

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=m
CONFIG_CRYPTO_VMAC=m

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=m
CONFIG_CRYPTO_CRC32=m
CONFIG_CRYPTO_CRC32_PCLMUL=m
CONFIG_CRYPTO_XXHASH=m
CONFIG_CRYPTO_BLAKE2B=m
# CONFIG_CRYPTO_BLAKE2S is not set
# CONFIG_CRYPTO_BLAKE2S_X86 is not set
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=m
CONFIG_CRYPTO_CRC64_ROCKSOFT=m
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_POLY1305=m
CONFIG_CRYPTO_POLY1305_X86_64=m
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_RMD160=m
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA1_SSSE3=y
CONFIG_CRYPTO_SHA256_SSSE3=y
CONFIG_CRYPTO_SHA512_SSSE3=m
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=m
# CONFIG_CRYPTO_SM3_GENERIC is not set
# CONFIG_CRYPTO_SM3_AVX_X86_64 is not set
# CONFIG_CRYPTO_STREEBOG is not set
CONFIG_CRYPTO_WP512=m
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=m

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_AES_NI_INTEL=y
CONFIG_CRYPTO_ANUBIS=m
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_BLOWFISH_COMMON=m
CONFIG_CRYPTO_BLOWFISH_X86_64=m
CONFIG_CRYPTO_CAMELLIA=m
CONFIG_CRYPTO_CAMELLIA_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=m
CONFIG_CRYPTO_CAST_COMMON=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST5_AVX_X86_64=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_CAST6_AVX_X86_64=m
CONFIG_CRYPTO_DES=m
# CONFIG_CRYPTO_DES3_EDE_X86_64 is not set
CONFIG_CRYPTO_FCRYPT=m
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_CHACHA20=m
CONFIG_CRYPTO_CHACHA20_X86_64=m
CONFIG_CRYPTO_SEED=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=m
CONFIG_CRYPTO_SM4=y
CONFIG_CRYPTO_SM4_GENERIC=y
# CONFIG_CRYPTO_SM4_AESNI_AVX_X86_64 is not set
# CONFIG_CRYPTO_SM4_AESNI_AVX2_X86_64 is not set
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_TWOFISH_COMMON=m
CONFIG_CRYPTO_TWOFISH_X86_64=m
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=m
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=m

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
# CONFIG_CRYPTO_842 is not set
# CONFIG_CRYPTO_LZ4 is not set
# CONFIG_CRYPTO_LZ4HC is not set
# CONFIG_CRYPTO_ZSTD is not set

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=m
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_USER_API=y
CONFIG_CRYPTO_USER_API_HASH=y
CONFIG_CRYPTO_USER_API_SKCIPHER=y
CONFIG_CRYPTO_USER_API_RNG=y
# CONFIG_CRYPTO_USER_API_RNG_CAVP is not set
CONFIG_CRYPTO_USER_API_AEAD=y
CONFIG_CRYPTO_USER_API_ENABLE_OBSOLETE=y
# CONFIG_CRYPTO_STATS is not set
CONFIG_CRYPTO_HASH_INFO=y
CONFIG_CRYPTO_HW=y
CONFIG_CRYPTO_DEV_PADLOCK=m
CONFIG_CRYPTO_DEV_PADLOCK_AES=m
CONFIG_CRYPTO_DEV_PADLOCK_SHA=m
# CONFIG_CRYPTO_DEV_ATMEL_ECC is not set
# CONFIG_CRYPTO_DEV_ATMEL_SHA204A is not set
CONFIG_CRYPTO_DEV_CCP=y
CONFIG_CRYPTO_DEV_CCP_DD=m
CONFIG_CRYPTO_DEV_SP_CCP=y
CONFIG_CRYPTO_DEV_CCP_CRYPTO=m
CONFIG_CRYPTO_DEV_SP_PSP=y
# CONFIG_CRYPTO_DEV_CCP_DEBUGFS is not set
CONFIG_CRYPTO_DEV_QAT=m
CONFIG_CRYPTO_DEV_QAT_DH895xCC=m
CONFIG_CRYPTO_DEV_QAT_C3XXX=m
CONFIG_CRYPTO_DEV_QAT_C62X=m
# CONFIG_CRYPTO_DEV_QAT_4XXX is not set
CONFIG_CRYPTO_DEV_QAT_DH895xCCVF=m
CONFIG_CRYPTO_DEV_QAT_C3XXXVF=m
CONFIG_CRYPTO_DEV_QAT_C62XVF=m
CONFIG_CRYPTO_DEV_NITROX=m
CONFIG_CRYPTO_DEV_NITROX_CNN55XX=m
# CONFIG_CRYPTO_DEV_VIRTIO is not set
# CONFIG_CRYPTO_DEV_SAFEXCEL is not set
# CONFIG_CRYPTO_DEV_AMLOGIC_GXL is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
# CONFIG_PKCS8_PRIVATE_KEY_PARSER is not set
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_PKCS7_TEST_KEY is not set
CONFIG_SIGNED_PE_FILE_VERIFICATION=y
# CONFIG_FIPS_SIGNATURE_SELFTEST is not set

#
# Certificates for signature checking
#
CONFIG_MODULE_SIG_KEY="certs/signing_key.pem"
CONFIG_MODULE_SIG_KEY_TYPE_RSA=y
# CONFIG_MODULE_SIG_KEY_TYPE_ECDSA is not set
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
# CONFIG_SECONDARY_TRUSTED_KEYRING is not set
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
# CONFIG_SYSTEM_REVOCATION_LIST is not set
# CONFIG_SYSTEM_BLACKLIST_AUTH_UPDATE is not set
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=m
CONFIG_RAID6_PQ_BENCHMARK=y
# CONFIG_PACKING is not set
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_CORDIC=m
CONFIG_PRIME_NUMBERS=m
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_ARCH_USE_SYM_ANNOTATIONS=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_ARC4=m
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
CONFIG_CRYPTO_ARCH_HAVE_LIB_CHACHA=m
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=m
# CONFIG_CRYPTO_LIB_CHACHA is not set
# CONFIG_CRYPTO_LIB_CURVE25519 is not set
CONFIG_CRYPTO_LIB_DES=m
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=11
CONFIG_CRYPTO_ARCH_HAVE_LIB_POLY1305=m
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=m
# CONFIG_CRYPTO_LIB_POLY1305 is not set
# CONFIG_CRYPTO_LIB_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_LIB_SHA256=y
# end of Crypto library routines

CONFIG_LIB_MEMNEQ=y
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC64_ROCKSOFT=m
CONFIG_CRC_ITU_T=m
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
CONFIG_CRC64=m
# CONFIG_CRC4 is not set
CONFIG_CRC7=m
CONFIG_LIBCRC32C=m
CONFIG_CRC8=m
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=m
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
# CONFIG_XZ_DEC_MICROLZMA is not set
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_DECOMPRESS_ZSTD=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_TEXTSEARCH=y
CONFIG_TEXTSEARCH_KMP=m
CONFIG_TEXTSEARCH_BM=m
CONFIG_TEXTSEARCH_FSM=m
CONFIG_INTERVAL_TREE=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_DMA_OPS=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_SWIOTLB=y
# CONFIG_DMA_API_DEBUG is not set
CONFIG_DMA_MAP_BENCHMARK=y
CONFIG_SGL_ALLOC=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_CPUMASK_OFFSTACK=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_SIGNATURE=y
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_FONT_SUPPORT=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_MEMREGION=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_ARCH_HAS_COPY_MC=y
CONFIG_ARCH_STACKWALK=y
CONFIG_STACKDEPOT=y
CONFIG_STACKDEPOT_ALWAYS_INIT=y
CONFIG_STACK_HASH_ORDER=20
CONFIG_SBITMAP=y
# end of Library routines

CONFIG_ASN1_ENCODER=y

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
CONFIG_PRINTK_CALLER=y
# CONFIG_STACKTRACE_BUILD_ID is not set
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
CONFIG_BOOT_PRINTK_DELAY=y
CONFIG_DYNAMIC_DEBUG=y
CONFIG_DYNAMIC_DEBUG_CORE=y
CONFIG_SYMBOLIC_ERRNAME=y
CONFIG_DEBUG_BUGVERBOSE=y
# end of printk and dmesg options

CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_MISC=y

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
# CONFIG_DEBUG_INFO_NONE is not set
# CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is not set
CONFIG_DEBUG_INFO_DWARF4=y
# CONFIG_DEBUG_INFO_DWARF5 is not set
# CONFIG_DEBUG_INFO_REDUCED is not set
# CONFIG_DEBUG_INFO_COMPRESSED is not set
# CONFIG_DEBUG_INFO_SPLIT is not set
CONFIG_DEBUG_INFO_BTF=y
CONFIG_PAHOLE_HAS_SPLIT_BTF=y
CONFIG_DEBUG_INFO_BTF_MODULES=y
# CONFIG_MODULE_ALLOW_BTF_MISMATCH is not set
# CONFIG_GDB_SCRIPTS is not set
CONFIG_FRAME_WARN=8192
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
# CONFIG_HEADERS_INSTALL is not set
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
# CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_64B is not set
CONFIG_OBJTOOL=y
# CONFIG_VMLINUX_MAP is not set
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# end of Compile-time checks and compiler options

#
# Generic Kernel Debugging Instruments
#
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE=""
CONFIG_DEBUG_FS=y
CONFIG_DEBUG_FS_ALLOW_ALL=y
# CONFIG_DEBUG_FS_DISALLOW_MOUNT is not set
# CONFIG_DEBUG_FS_ALLOW_NONE is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
CONFIG_UBSAN=y
# CONFIG_UBSAN_TRAP is not set
CONFIG_CC_HAS_UBSAN_BOUNDS=y
CONFIG_UBSAN_BOUNDS=y
CONFIG_UBSAN_ONLY_BOUNDS=y
CONFIG_UBSAN_SHIFT=y
# CONFIG_UBSAN_DIV_ZERO is not set
# CONFIG_UBSAN_BOOL is not set
# CONFIG_UBSAN_ENUM is not set
# CONFIG_UBSAN_ALIGNMENT is not set
CONFIG_UBSAN_SANITIZE_ALL=y
# CONFIG_TEST_UBSAN is not set
CONFIG_HAVE_ARCH_KCSAN=y
CONFIG_HAVE_KCSAN_COMPILER=y
# end of Generic Kernel Debugging Instruments

#
# Networking Debugging
#
# CONFIG_NET_DEV_REFCNT_TRACKER is not set
# CONFIG_NET_NS_REFCNT_TRACKER is not set
# CONFIG_DEBUG_NET is not set
# end of Networking Debugging

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
# CONFIG_DEBUG_PAGEALLOC is not set
CONFIG_SLUB_DEBUG=y
# CONFIG_SLUB_DEBUG_ON is not set
CONFIG_PAGE_OWNER=y
# CONFIG_PAGE_TABLE_CHECK is not set
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_PAGE_REF is not set
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_ARCH_HAS_DEBUG_WX=y
# CONFIG_DEBUG_WX is not set
CONFIG_GENERIC_PTDUMP=y
# CONFIG_PTDUMP_DEBUGFS is not set
# CONFIG_DEBUG_OBJECTS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_SCHED_STACK_END_CHECK is not set
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
# CONFIG_DEBUG_VM is not set
# CONFIG_DEBUG_VM_PGTABLE is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
CONFIG_MEMORY_NOTIFIER_ERROR_INJECT=m
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
CONFIG_KASAN=y
CONFIG_KASAN_GENERIC=y
# CONFIG_KASAN_OUTLINE is not set
CONFIG_KASAN_INLINE=y
CONFIG_KASAN_STACK=y
CONFIG_KASAN_VMALLOC=y
# CONFIG_KASAN_MODULE_TEST is not set
CONFIG_HAVE_ARCH_KFENCE=y
# CONFIG_KFENCE is not set
# end of Memory Debugging

CONFIG_DEBUG_SHIRQ=y

#
# Debug Oops, Lockups and Hangs
#
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
CONFIG_HARDLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=480
# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
CONFIG_WQ_WATCHDOG=y
# CONFIG_TEST_LOCKUP is not set
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# end of Scheduler Debugging

# CONFIG_DEBUG_TIMEKEEPING is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
CONFIG_PROVE_LOCKING=y
# CONFIG_PROVE_RAW_LOCK_NESTING is not set
# CONFIG_LOCK_STAT is not set
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
CONFIG_DEBUG_RWSEMS=y
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_LOCKDEP=y
CONFIG_LOCKDEP_BITS=15
CONFIG_LOCKDEP_CHAINS_BITS=16
CONFIG_LOCKDEP_STACK_TRACE_BITS=19
CONFIG_LOCKDEP_STACK_TRACE_HASH_BITS=14
CONFIG_LOCKDEP_CIRCULAR_QUEUE_BITS=12
# CONFIG_DEBUG_LOCKDEP is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_LOCK_TORTURE_TEST is not set
CONFIG_WW_MUTEX_SELFTEST=m
# CONFIG_SCF_TORTURE_TEST is not set
# CONFIG_CSD_LOCK_WAIT_DEBUG is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_TRACE_IRQFLAGS=y
CONFIG_TRACE_IRQFLAGS_NMI=y
# CONFIG_DEBUG_IRQFLAGS is not set
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set

#
# Debug kernel data structures
#
CONFIG_DEBUG_LIST=y
CONFIG_DEBUG_PLIST=y
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
CONFIG_BUG_ON_DATA_CORRUPTION=y
# end of Debug kernel data structures

# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_PROVE_RCU=y
# CONFIG_RCU_SCALE_TEST is not set
# CONFIG_RCU_TORTURE_TEST is not set
# CONFIG_RCU_REF_SCALE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=60
CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=20
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
CONFIG_LATENCYTOP=y
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_RETHOOK=y
CONFIG_RETHOOK=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_OBJTOOL_MCOUNT=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_HAVE_BUILDTIME_MCOUNT_SORT=y
CONFIG_BUILDTIME_MCOUNT_SORT=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_RING_BUFFER_ALLOW_SWAP=y
CONFIG_PREEMPTIRQ_TRACEPOINTS=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
# CONFIG_BOOTTIME_TRACING is not set
CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=y
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_DYNAMIC_FTRACE_WITH_ARGS=y
# CONFIG_FPROBE is not set
CONFIG_FUNCTION_PROFILER=y
CONFIG_STACK_TRACER=y
CONFIG_IRQSOFF_TRACER=y
CONFIG_SCHED_TRACER=y
CONFIG_HWLAT_TRACER=y
# CONFIG_OSNOISE_TRACER is not set
# CONFIG_TIMERLAT_TRACER is not set
# CONFIG_MMIOTRACE is not set
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP=y
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
# CONFIG_BLK_DEV_IO_TRACE is not set
CONFIG_KPROBE_EVENTS=y
# CONFIG_KPROBE_EVENTS_ON_NOTRACE is not set
CONFIG_UPROBE_EVENTS=y
CONFIG_BPF_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
# CONFIG_BPF_KPROBE_OVERRIDE is not set
CONFIG_FTRACE_MCOUNT_RECORD=y
CONFIG_FTRACE_MCOUNT_USE_CC=y
CONFIG_TRACING_MAP=y
CONFIG_SYNTH_EVENTS=y
CONFIG_HIST_TRIGGERS=y
# CONFIG_TRACE_EVENT_INJECT is not set
# CONFIG_TRACEPOINT_BENCHMARK is not set
CONFIG_RING_BUFFER_BENCHMARK=m
# CONFIG_TRACE_EVAL_MAP_FILE is not set
# CONFIG_FTRACE_RECORD_RECURSION is not set
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_FTRACE_SORT_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS is not set
CONFIG_PREEMPTIRQ_DELAY_TEST=m
# CONFIG_SYNTH_EVENT_GEN_TEST is not set
# CONFIG_KPROBE_EVENT_GEN_TEST is not set
# CONFIG_HIST_TRIGGERS_DEBUG is not set
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
CONFIG_SAMPLES=y
# CONFIG_SAMPLE_AUXDISPLAY is not set
# CONFIG_SAMPLE_TRACE_EVENTS is not set
# CONFIG_SAMPLE_TRACE_CUSTOM_EVENTS is not set
CONFIG_SAMPLE_TRACE_PRINTK=m
CONFIG_SAMPLE_FTRACE_DIRECT=m
# CONFIG_SAMPLE_FTRACE_DIRECT_MULTI is not set
# CONFIG_SAMPLE_TRACE_ARRAY is not set
# CONFIG_SAMPLE_KOBJECT is not set
# CONFIG_SAMPLE_KPROBES is not set
# CONFIG_SAMPLE_HW_BREAKPOINT is not set
# CONFIG_SAMPLE_KFIFO is not set
# CONFIG_SAMPLE_LIVEPATCH is not set
# CONFIG_SAMPLE_CONFIGFS is not set
# CONFIG_SAMPLE_VFIO_MDEV_MTTY is not set
# CONFIG_SAMPLE_VFIO_MDEV_MDPY is not set
# CONFIG_SAMPLE_VFIO_MDEV_MDPY_FB is not set
# CONFIG_SAMPLE_VFIO_MDEV_MBOCHS is not set
# CONFIG_SAMPLE_WATCHDOG is not set
CONFIG_HAVE_SAMPLE_FTRACE_DIRECT=y
CONFIG_HAVE_SAMPLE_FTRACE_DIRECT_MULTI=y
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_STRICT_DEVMEM=y
# CONFIG_IO_STRICT_DEVMEM is not set

#
# x86 Debugging
#
CONFIG_TRACE_IRQFLAGS_NMI_SUPPORT=y
CONFIG_EARLY_PRINTK_USB=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
CONFIG_EARLY_PRINTK_USB_XDBC=y
# CONFIG_EFI_PGT_DUMP is not set
# CONFIG_DEBUG_TLBFLUSH is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
# CONFIG_X86_DECODER_SELFTEST is not set
CONFIG_IO_DELAY_0X80=y
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEBUG_BOOT_PARAMS=y
# CONFIG_CPA_DEBUG is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
# CONFIG_X86_DEBUG_FPU is not set
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_ORC=y
# CONFIG_UNWINDER_FRAME_POINTER is not set
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
# CONFIG_KUNIT is not set
CONFIG_NOTIFIER_ERROR_INJECTION=y
CONFIG_PM_NOTIFIER_ERROR_INJECT=m
# CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
# CONFIG_FAULT_INJECTION is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_KCOV is not set
CONFIG_RUNTIME_TESTING_MENU=y
CONFIG_LKDTM=y
# CONFIG_TEST_MIN_HEAP is not set
# CONFIG_TEST_DIV64 is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_TEST_REF_TRACKER is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_REED_SOLOMON_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_PERCPU_TEST is not set
# CONFIG_ATOMIC64_SELFTEST is not set
# CONFIG_ASYNC_RAID6_TEST is not set
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_STRING_SELFTEST is not set
# CONFIG_TEST_STRING_HELPERS is not set
CONFIG_TEST_STRSCPY=m
# CONFIG_TEST_KSTRTOX is not set
CONFIG_TEST_PRINTF=m
CONFIG_TEST_SCANF=m
CONFIG_TEST_BITMAP=m
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_XARRAY is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_SIPHASH is not set
# CONFIG_TEST_IDA is not set
CONFIG_TEST_LKM=m
CONFIG_TEST_BITOPS=m
CONFIG_TEST_VMALLOC=m
CONFIG_TEST_USER_COPY=m
CONFIG_TEST_BPF=m
CONFIG_TEST_BLACKHOLE_DEV=m
# CONFIG_FIND_BIT_BENCHMARK is not set
CONFIG_TEST_FIRMWARE=y
CONFIG_TEST_SYSCTL=y
# CONFIG_TEST_UDELAY is not set
CONFIG_TEST_STATIC_KEYS=m
CONFIG_TEST_KMOD=m
# CONFIG_TEST_MEMCAT_P is not set
CONFIG_TEST_LIVEPATCH=m
# CONFIG_TEST_MEMINIT is not set
CONFIG_TEST_HMM=m
# CONFIG_TEST_FREE_PAGES is not set
CONFIG_TEST_FPU=m
# CONFIG_TEST_CLOCKSOURCE_WATCHDOG is not set
CONFIG_ARCH_USE_MEMTEST=y
# CONFIG_MEMTEST is not set
# end of Kernel Testing and Coverage
# end of Kernel hacking

--c7ijwEYYO4C8FEwX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=job-script

#!/bin/sh

export_top_env()
{
	export suite='kernel-selftests'
	export testcase='kernel-selftests'
	export category='functional'
	export need_memory='2G'
	export need_cpu=2
	export kernel_cmdline='erst_disable'
	export job_origin='kernel-selftests-x86.yaml'
	export queue_cmdline_keys='branch
commit'
	export queue='bisect'
	export testbox='vm-snb-46'
	export tbox_group='vm-snb'
	export branch='linux-devel/devel-hourly-20220705-140125'
	export commit='9724330ed6ddddf7aae3a57ab04292e4c138eb3a'
	export kconfig='x86_64-rhel-8.3-kselftests'
	export nr_vm=160
	export submit_id='62c73b5d964b8f5e759073d2'
	export job_file='/lkp/jobs/scheduled/vm-snb-46/kernel-selftests-x86-debian-11.1-x86_64-20220510.cgz-9724330ed6ddddf7aae3a57ab04292e4c138eb3a-20220708-89717-fhyvq5-1.yaml'
	export id='cbd7853cd7d3ec084d9a4931f3e6f92f73970b1f'
	export queuer_version='/zday/lkp'
	export model='qemu-system-x86_64 -enable-kvm -cpu SandyBridge'
	export nr_cpu=2
	export memory='16G'
	export need_kconfig=\{\"KVM_GUEST\"\=\>\"y\"\}'
'\{\"POSIX_TIMERS\"\=\>\"y,\ v4.10-rc1\"\}
	export ssh_base_port=23032
	export rootfs='debian-11.1-x86_64-20220510.cgz'
	export compiler='gcc-11'
	export initrds='linux_headers
linux_selftests'
	export enqueue_time='2022-07-08 04:00:29 +0800'
	export _id='62c73b5d964b8f5e759073d3'
	export _rt='/result/kernel-selftests/x86/vm-snb/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-kselftests/gcc-11/9724330ed6ddddf7aae3a57ab04292e4c138eb3a'
	export user='lkp'
	export LKP_SERVER='internal-lkp-server'
	export result_root='/result/kernel-selftests/x86/vm-snb/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-kselftests/gcc-11/9724330ed6ddddf7aae3a57ab04292e4c138eb3a/8'
	export scheduler_version='/lkp/lkp/.src-20220707-170918'
	export arch='x86_64'
	export max_uptime=2100
	export initrd='/osimage/debian/debian-11.1-x86_64-20220510.cgz'
	export bootloader_append='root=/dev/ram0
RESULT_ROOT=/result/kernel-selftests/x86/vm-snb/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-kselftests/gcc-11/9724330ed6ddddf7aae3a57ab04292e4c138eb3a/8
BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/9724330ed6ddddf7aae3a57ab04292e4c138eb3a/vmlinuz-5.19.0-rc5-00004-g9724330ed6dd
branch=linux-devel/devel-hourly-20220705-140125
job=/lkp/jobs/scheduled/vm-snb-46/kernel-selftests-x86-debian-11.1-x86_64-20220510.cgz-9724330ed6ddddf7aae3a57ab04292e4c138eb3a-20220708-89717-fhyvq5-1.yaml
user=lkp
ARCH=x86_64
kconfig=x86_64-rhel-8.3-kselftests
commit=9724330ed6ddddf7aae3a57ab04292e4c138eb3a
erst_disable
max_uptime=2100
LKP_SERVER=internal-lkp-server
selinux=0
debug
apic=debug
sysrq_always_enabled
rcupdate.rcu_cpu_stall_timeout=100
net.ifnames=0
printk.devkmsg=on
panic=-1
softlockup_panic=1
nmi_watchdog=panic
oops=panic
load_ramdisk=2
prompt_ramdisk=0
drbd.minor_count=8
systemd.log_level=err
ignore_loglevel
console=tty0
earlyprintk=ttyS0,115200
console=ttyS0,115200
vga=normal
rw'
	export modules_initrd='/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/9724330ed6ddddf7aae3a57ab04292e4c138eb3a/modules.cgz'
	export linux_headers_initrd='/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/9724330ed6ddddf7aae3a57ab04292e4c138eb3a/linux-headers.cgz'
	export linux_selftests_initrd='/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/9724330ed6ddddf7aae3a57ab04292e4c138eb3a/linux-selftests.cgz'
	export bm_initrd='/osimage/deps/debian-11.1-x86_64-20220510.cgz/run-ipconfig_20220515.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/lkp_20220513.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/rsync-rootfs_20220515.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/kernel-selftests_20220704.cgz,/osimage/pkg/debian-11.1-x86_64-20220510.cgz/kernel-selftests-x86_64-37f3cb9b-1_20220704.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export schedule_notify_address=
	export kernel='/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/9724330ed6ddddf7aae3a57ab04292e4c138eb3a/vmlinuz-5.19.0-rc5-00004-g9724330ed6dd'
	export dequeue_time='2022-07-08 04:11:40 +0800'
	export job_initrd='/lkp/jobs/scheduled/vm-snb-46/kernel-selftests-x86-debian-11.1-x86_64-20220510.cgz-9724330ed6ddddf7aae3a57ab04292e4c138eb3a-20220708-89717-fhyvq5-1.cgz'

	[ -n "$LKP_SRC" ] ||
	export LKP_SRC=/lkp/${user:-lkp}/src
}

run_job()
{
	echo $$ > $TMP/run-job.pid

	. $LKP_SRC/lib/http.sh
	. $LKP_SRC/lib/job.sh
	. $LKP_SRC/lib/env.sh

	export_top_env

	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/wrapper heartbeat
	run_monitor $LKP_SRC/monitors/wrapper meminfo
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test group='x86' $LKP_SRC/tests/wrapper kernel-selftests
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	env group='x86' $LKP_SRC/stats/wrapper kernel-selftests
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper meminfo

	$LKP_SRC/stats/wrapper time kernel-selftests.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--c7ijwEYYO4C8FEwX
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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
AuibD/1R1bSxxGf7AgAAAAAEWVo=

--c7ijwEYYO4C8FEwX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=kernel-selftests

KERNEL SELFTESTS: linux_headers_dir is /usr/src/linux-headers-x86_64-rhel-8.3-kselftests-9724330ed6ddddf7aae3a57ab04292e4c138eb3a
2022-07-08 04:15:31 ln -sf /usr/bin/clang
2022-07-08 04:15:31 ln -sf /usr/bin/llc
2022-07-08 04:15:31 sed -i s/default_timeout=45/default_timeout=300/ kselftest/runner.sh
LKP SKIP x86.mov_ss_trap
2022-07-08 04:15:31 make -C x86
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-9724330ed6ddddf7aae3a57ab04292e4c138eb3a/tools/testing/selftests/x86'
gcc -m32 -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-9724330ed6ddddf7aae3a57ab04292e4c138eb3a/tools/testing/selftests/x86/single_step_syscall_32 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 single_step_syscall.c helpers.h -lrt -ldl -lm
gcc -m32 -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-9724330ed6ddddf7aae3a57ab04292e4c138eb3a/tools/testing/selftests/x86/sysret_ss_attrs_32 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 sysret_ss_attrs.c helpers.h -lrt -ldl -lm
gcc -m32 -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-9724330ed6ddddf7aae3a57ab04292e4c138eb3a/tools/testing/selftests/x86/syscall_nt_32 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 syscall_nt.c helpers.h -lrt -ldl -lm
gcc -m32 -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-9724330ed6ddddf7aae3a57ab04292e4c138eb3a/tools/testing/selftests/x86/test_mremap_vdso_32 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 test_mremap_vdso.c helpers.h -lrt -ldl -lm
gcc -m32 -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-9724330ed6ddddf7aae3a57ab04292e4c138eb3a/tools/testing/selftests/x86/check_initial_reg_state_32 -O2 -g -std=gnu99 -pthread -Wall -no-pie -Wl,-ereal_start -static -DCAN_BUILD_32 -DCAN_BUILD_64 check_initial_reg_state.c helpers.h -lrt -ldl -lm
gcc -m32 -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-9724330ed6ddddf7aae3a57ab04292e4c138eb3a/tools/testing/selftests/x86/sigreturn_32 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 sigreturn.c helpers.h -lrt -ldl -lm
gcc -m32 -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-9724330ed6ddddf7aae3a57ab04292e4c138eb3a/tools/testing/selftests/x86/iopl_32 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 iopl.c helpers.h -lrt -ldl -lm
gcc -m32 -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-9724330ed6ddddf7aae3a57ab04292e4c138eb3a/tools/testing/selftests/x86/ioperm_32 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 ioperm.c helpers.h -lrt -ldl -lm
gcc -m32 -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-9724330ed6ddddf7aae3a57ab04292e4c138eb3a/tools/testing/selftests/x86/test_vsyscall_32 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 test_vsyscall.c helpers.h -lrt -ldl -lm
gcc -m32 -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-9724330ed6ddddf7aae3a57ab04292e4c138eb3a/tools/testing/selftests/x86/syscall_arg_fault_32 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 syscall_arg_fault.c helpers.h -lrt -ldl -lm
gcc -m32 -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-9724330ed6ddddf7aae3a57ab04292e4c138eb3a/tools/testing/selftests/x86/fsgsbase_restore_32 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 fsgsbase_restore.c helpers.h -lrt -ldl -lm
gcc -m32 -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-9724330ed6ddddf7aae3a57ab04292e4c138eb3a/tools/testing/selftests/x86/sigaltstack_32 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 sigaltstack.c helpers.h -lrt -ldl -lm
gcc -m32 -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-9724330ed6ddddf7aae3a57ab04292e4c138eb3a/tools/testing/selftests/x86/entry_from_vm86_32 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 entry_from_vm86.c helpers.h -lrt -ldl -lm
gcc -m32 -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-9724330ed6ddddf7aae3a57ab04292e4c138eb3a/tools/testing/selftests/x86/test_syscall_vdso_32 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 test_syscall_vdso.c helpers.h thunks_32.S -lrt -ldl -lm
gcc -m32 -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-9724330ed6ddddf7aae3a57ab04292e4c138eb3a/tools/testing/selftests/x86/unwind_vdso_32 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 unwind_vdso.c helpers.h -lrt -ldl -lm
gcc -m32 -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-9724330ed6ddddf7aae3a57ab04292e4c138eb3a/tools/testing/selftests/x86/test_FCMOV_32 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 test_FCMOV.c helpers.h -lrt -ldl -lm
gcc -m32 -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-9724330ed6ddddf7aae3a57ab04292e4c138eb3a/tools/testing/selftests/x86/test_FCOMI_32 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 test_FCOMI.c helpers.h -lrt -ldl -lm
gcc -m32 -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-9724330ed6ddddf7aae3a57ab04292e4c138eb3a/tools/testing/selftests/x86/test_FISTTP_32 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 test_FISTTP.c helpers.h -lrt -ldl -lm
test_FISTTP.c: Assembler messages:
test_FISTTP.c:28: Warning: no instruction mnemonic suffix given and no register operands; using default for `fisttp'
test_FISTTP.c:48: Warning: no instruction mnemonic suffix given and no register operands; using default for `fisttp'
test_FISTTP.c:69: Warning: no instruction mnemonic suffix given and no register operands; using default for `fisttp'
test_FISTTP.c:91: Warning: no instruction mnemonic suffix given and no register operands; using default for `fisttp'
gcc -m32 -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-9724330ed6ddddf7aae3a57ab04292e4c138eb3a/tools/testing/selftests/x86/vdso_restorer_32 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 vdso_restorer.c helpers.h -lrt -ldl -lm
gcc -m32 -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-9724330ed6ddddf7aae3a57ab04292e4c138eb3a/tools/testing/selftests/x86/ldt_gdt_32 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 ldt_gdt.c helpers.h -lrt -ldl -lm
gcc -m32 -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-9724330ed6ddddf7aae3a57ab04292e4c138eb3a/tools/testing/selftests/x86/ptrace_syscall_32 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 ptrace_syscall.c helpers.h raw_syscall_helper_32.S -lrt -ldl -lm
gcc -m64 -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-9724330ed6ddddf7aae3a57ab04292e4c138eb3a/tools/testing/selftests/x86/single_step_syscall_64 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 single_step_syscall.c helpers.h -lrt -ldl
gcc -m64 -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-9724330ed6ddddf7aae3a57ab04292e4c138eb3a/tools/testing/selftests/x86/sysret_ss_attrs_64 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 sysret_ss_attrs.c helpers.h thunks.S -lrt -ldl
gcc -m64 -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-9724330ed6ddddf7aae3a57ab04292e4c138eb3a/tools/testing/selftests/x86/syscall_nt_64 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 syscall_nt.c helpers.h -lrt -ldl
gcc -m64 -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-9724330ed6ddddf7aae3a57ab04292e4c138eb3a/tools/testing/selftests/x86/test_mremap_vdso_64 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 test_mremap_vdso.c helpers.h -lrt -ldl
gcc -m64 -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-9724330ed6ddddf7aae3a57ab04292e4c138eb3a/tools/testing/selftests/x86/check_initial_reg_state_64 -O2 -g -std=gnu99 -pthread -Wall -no-pie -Wl,-ereal_start -static -DCAN_BUILD_32 -DCAN_BUILD_64 check_initial_reg_state.c helpers.h -lrt -ldl
gcc -m64 -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-9724330ed6ddddf7aae3a57ab04292e4c138eb3a/tools/testing/selftests/x86/sigreturn_64 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 sigreturn.c helpers.h -lrt -ldl
gcc -m64 -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-9724330ed6ddddf7aae3a57ab04292e4c138eb3a/tools/testing/selftests/x86/iopl_64 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 iopl.c helpers.h -lrt -ldl
gcc -m64 -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-9724330ed6ddddf7aae3a57ab04292e4c138eb3a/tools/testing/selftests/x86/ioperm_64 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 ioperm.c helpers.h -lrt -ldl
gcc -m64 -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-9724330ed6ddddf7aae3a57ab04292e4c138eb3a/tools/testing/selftests/x86/test_vsyscall_64 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 test_vsyscall.c helpers.h -lrt -ldl
gcc -m64 -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-9724330ed6ddddf7aae3a57ab04292e4c138eb3a/tools/testing/selftests/x86/syscall_arg_fault_64 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 syscall_arg_fault.c helpers.h -lrt -ldl
gcc -m64 -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-9724330ed6ddddf7aae3a57ab04292e4c138eb3a/tools/testing/selftests/x86/fsgsbase_restore_64 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 fsgsbase_restore.c helpers.h -lrt -ldl
gcc -m64 -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-9724330ed6ddddf7aae3a57ab04292e4c138eb3a/tools/testing/selftests/x86/sigaltstack_64 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 sigaltstack.c helpers.h -lrt -ldl
gcc -m64 -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-9724330ed6ddddf7aae3a57ab04292e4c138eb3a/tools/testing/selftests/x86/fsgsbase_64 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 fsgsbase.c helpers.h -lrt -ldl
gcc -m64 -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-9724330ed6ddddf7aae3a57ab04292e4c138eb3a/tools/testing/selftests/x86/sysret_rip_64 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 sysret_rip.c helpers.h -lrt -ldl
gcc -m64 -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-9724330ed6ddddf7aae3a57ab04292e4c138eb3a/tools/testing/selftests/x86/syscall_numbering_64 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 syscall_numbering.c helpers.h -lrt -ldl
gcc -m64 -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-9724330ed6ddddf7aae3a57ab04292e4c138eb3a/tools/testing/selftests/x86/corrupt_xstate_header_64 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 corrupt_xstate_header.c helpers.h -lrt -ldl
gcc -m64 -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-9724330ed6ddddf7aae3a57ab04292e4c138eb3a/tools/testing/selftests/x86/amx_64 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 amx.c helpers.h -lrt -ldl
gcc -m64 -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-9724330ed6ddddf7aae3a57ab04292e4c138eb3a/tools/testing/selftests/x86/ldt_gdt_64 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 ldt_gdt.c helpers.h -lrt -ldl
gcc -m64 -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-9724330ed6ddddf7aae3a57ab04292e4c138eb3a/tools/testing/selftests/x86/ptrace_syscall_64 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 ptrace_syscall.c helpers.h -lrt -ldl
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-9724330ed6ddddf7aae3a57ab04292e4c138eb3a/tools/testing/selftests/x86'
2022-07-08 04:16:11 make run_tests -C x86
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-9724330ed6ddddf7aae3a57ab04292e4c138eb3a/tools/testing/selftests/x86'
TAP version 13
1..40
# selftests: x86: single_step_syscall_32
# [RUN]	Set TF and check nop
# [OK]	Survived with TF set and 15 traps
# [RUN]	Set TF and check int80
# [OK]	Survived with TF set and 14 traps
# [RUN]	Set TF and check a fast syscall
# [OK]	Survived with TF set and 45 traps
# [RUN]	Fast syscall with TF cleared
# [OK]	Nothing unexpected happened
# [RUN]	Set TF and check SYSENTER
# 	Got SIGSEGV with RIP=f7eda549, TF=256
# [RUN]	Fast syscall with TF cleared
# [OK]	Nothing unexpected happened
ok 1 selftests: x86: single_step_syscall_32
# selftests: x86: sysret_ss_attrs_32
# [WARN]	sched_setaffinity failed
# [RUN]	Syscalls followed by SS validation
# [OK]	We survived
ok 2 selftests: x86: sysret_ss_attrs_32
# selftests: x86: syscall_nt_32
# [RUN]	Set NT and issue a syscall
# [OK]	The syscall worked and flags are still set
# [RUN]	Set AC and issue a syscall
# [OK]	The syscall worked and flags are still set
# [RUN]	Set NT|AC and issue a syscall
# [OK]	The syscall worked and flags are still set
# [RUN]	Set TF and issue a syscall
# [OK]	The syscall worked and flags are still set
# [RUN]	Set NT|TF and issue a syscall
# [OK]	The syscall worked and flags are still set
# [RUN]	Set AC|TF and issue a syscall
# [OK]	The syscall worked and flags are still set
# [RUN]	Set NT|AC|TF and issue a syscall
# [OK]	The syscall worked and flags are still set
# [RUN]	Set DF and issue a syscall
# [OK]	The syscall worked and flags are still set
# [RUN]	Set TF|DF and issue a syscall
# [OK]	The syscall worked and flags are still set
ok 3 selftests: x86: syscall_nt_32
# selftests: x86: test_mremap_vdso_32
# 	AT_SYSINFO_EHDR is 0xf7f03000
# [NOTE]	Moving vDSO: [0xf7f03000, 0xf7f04000] -> [0xf7f2e000, 0xf7f2f000]
# [NOTE]	vDSO partial move failed, will try with bigger size
# [NOTE]	Moving vDSO: [0xf7f03000, 0xf7f05000] -> [0xf7efb000, 0xf7efd000]
# [OK]
ok 4 selftests: x86: test_mremap_vdso_32
# selftests: x86: check_initial_reg_state_32
# [OK]	All GPRs except SP are 0
# [OK]	FLAGS is 0x202
ok 5 selftests: x86: check_initial_reg_state_32
# selftests: x86: sigreturn_32
# [OK]	set_thread_area refused 16-bit data
# [OK]	set_thread_area refused 16-bit data
# [RUN]	Valid sigreturn: 64-bit CS (33), 32-bit SS (2b, GDT)
# [OK]	all registers okay
# [RUN]	Valid sigreturn: 32-bit CS (23), 32-bit SS (2b, GDT)
# [OK]	all registers okay
# [RUN]	Valid sigreturn: 16-bit CS (37), 32-bit SS (2b, GDT)
# [OK]	all registers okay
# [RUN]	Valid sigreturn: 64-bit CS (33), 16-bit SS (3f)
# [OK]	all registers okay
# [RUN]	Valid sigreturn: 32-bit CS (23), 16-bit SS (3f)
# [OK]	all registers okay
# [RUN]	Valid sigreturn: 16-bit CS (37), 16-bit SS (3f)
# [OK]	all registers okay
# [RUN]	64-bit CS (33), bogus SS (47)
# [OK]	Got #GP(0x0) (i.e. Segmentation fault)
# [RUN]	32-bit CS (23), bogus SS (47)
# [OK]	Got #GP(0x0) (i.e. Segmentation fault)
# [RUN]	16-bit CS (37), bogus SS (47)
# [OK]	Got #GP(0x0) (i.e. Segmentation fault)
# [RUN]	64-bit CS (33), bogus SS (23)
# [OK]	Got #GP(0x20) (i.e. GDT index 4, Segmentation fault)
# [RUN]	32-bit CS (23), bogus SS (23)
# [OK]	Got #GP(0x20) (i.e. GDT index 4, Segmentation fault)
# [RUN]	16-bit CS (37), bogus SS (23)
# [OK]	Got #GP(0x20) (i.e. GDT index 4, Segmentation fault)
# [RUN]	32-bit CS (4f), bogus SS (2b)
# [OK]	Got #NP(0x4c) (i.e. LDT index 9, Bus error)
# [RUN]	32-bit CS (23), bogus SS (57)
# [OK]	Got #GP(0x0) (i.e. Segmentation fault)
ok 6 selftests: x86: sigreturn_32
# selftests: x86: iopl_32
# iopl_32: sched_setaffinity to CPU 0: Invalid argument
not ok 7 selftests: x86: iopl_32 # exit=1
# selftests: x86: ioperm_32
# ioperm_32: sched_setaffinity to CPU 0: Invalid argument
not ok 8 selftests: x86: ioperm_32 # exit=1
# selftests: x86: test_vsyscall_32
# [NOTE]	failed to find getcpu in vDSO
# [RUN]	test gettimeofday()
# 	vDSO time offsets: 0.000036 0.000002
# [OK]	vDSO gettimeofday()'s timeval was okay
# [RUN]	test time()
# [OK]	vDSO time() is okay
# [RUN]	getcpu() on CPU 0
# [SKIP]	failed to force CPU 0
# [RUN]	getcpu() on CPU 1
# [SKIP]	failed to force CPU 1
ok 9 selftests: x86: test_vsyscall_32
# selftests: x86: syscall_arg_fault_32
# [RUN]	SYSENTER with invalid state
# [OK]	Seems okay
# [RUN]	SYSCALL with invalid state
# [SKIP]	Illegal instruction
# [RUN]	SYSENTER with TF and invalid state
# [OK]	Seems okay
# [RUN]	SYSCALL with TF and invalid state
# [SKIP]	Illegal instruction
ok 10 selftests: x86: syscall_arg_fault_32
# selftests: x86: fsgsbase_restore_32
# fsgsbase_restore_32: PTRACE_GETREGS: Input/output error
# 	Setting up a segment
# 	segment base address = 0xf7fb8000
# 	using LDT slot 0
# [OK]	The segment points to the right place.
# 	Child FS=0x7
# 	Tracer: redirecting tracee to tracee_zap_segment()
not ok 11 selftests: x86: fsgsbase_restore_32 # exit=1
# selftests: x86: sigaltstack_32
# [RUN]	Test an alternate signal stack of sufficient size.
# 	Raise SIGALRM. It is expected to be delivered.
# [OK]	SIGALRM signal delivered.
ok 12 selftests: x86: sigaltstack_32
# selftests: x86: entry_from_vm86_32
# [RUN]	#BR from vm86 mode
# [SKIP]	vm86 not supported
# [RUN]	SYSENTER from vm86 mode
# [SKIP]	vm86 not supported
# [RUN]	SYSCALL from vm86 mode
# [SKIP]	vm86 not supported
# [RUN]	STI with VIP set from vm86 mode
# [SKIP]	vm86 not supported
# [RUN]	POPF with VIP set and IF clear from vm86 mode
# [SKIP]	vm86 not supported
# [RUN]	POPF with VIP and IF set from vm86 mode
# [SKIP]	vm86 not supported
# [RUN]	POPF with VIP clear and IF set from vm86 mode
# [SKIP]	vm86 not supported
# [RUN]	INT3 from vm86 mode
# [SKIP]	vm86 not supported
# [RUN]	int80 from vm86 mode
# [SKIP]	vm86 not supported
# [RUN]	UMIP tests from vm86 mode
# [SKIP]	vm86 not supported
# [INFO]	Result from SMSW:[0x0000]
# [INFO]	Result from SIDT: limit[0x0000]base[0x00000000]
# [INFO]	Result from SGDT: limit[0x0000]base[0x00000000]
# [PASS]	All the results from SMSW are identical.
# [PASS]	All the results from SGDT are identical.
# [PASS]	All the results from SIDT are identical.
# [RUN]	STR instruction from vm86 mode
# [SKIP]	vm86 not supported
# [RUN]	SLDT instruction from vm86 mode
# [SKIP]	vm86 not supported
# [RUN]	Execute null pointer from vm86 mode
# [SKIP]	vm86 not supported
# [RUN]	#BR from vm86 mode
# [SKIP]	vm86 not supported
# [RUN]	SYSENTER from vm86 mode
# [SKIP]	vm86 not supported
# [RUN]	SYSCALL from vm86 mode
# [SKIP]	vm86 not supported
# [RUN]	STI with VIP set from vm86 mode
# [SKIP]	vm86 not supported
# [RUN]	POPF with VIP set and IF clear from vm86 mode
# [SKIP]	vm86 not supported
# [RUN]	POPF with VIP and IF set from vm86 mode
# [SKIP]	vm86 not supported
# [RUN]	POPF with VIP clear and IF set from vm86 mode
# [SKIP]	vm86 not supported
# [RUN]	INT3 from vm86 mode
# [SKIP]	vm86 not supported
# [RUN]	int80 from vm86 mode
# [SKIP]	vm86 not supported
# [RUN]	UMIP tests from vm86 mode
# [SKIP]	vm86 not supported
# [INFO]	Result from SMSW:[0x0000]
# [INFO]	Result from SIDT: limit[0x0000]base[0x00000000]
# [INFO]	Result from SGDT: limit[0x0000]base[0x00000000]
# [PASS]	All the results from SMSW are identical.
# [PASS]	All the results from SGDT are identical.
# [PASS]	All the results from SIDT are identical.
# [RUN]	STR instruction from vm86 mode
# [SKIP]	vm86 not supported
# [RUN]	SLDT instruction from vm86 mode
# [SKIP]	vm86 not supported
# [RUN]	Execute null pointer from vm86 mode
# [SKIP]	vm86 not supported
ok 13 selftests: x86: entry_from_vm86_32
# selftests: x86: test_syscall_vdso_32
# [RUN]	Executing 6-argument 32-bit syscall via VDSO
# [WARN]	Flags before=0000000000200ed7 id 0 00 o d i s z 0 a 0 p 1 c
# [WARN]	Flags  after=0000000000200606 id 0 00 d i 0 0 p 1 
# [WARN]	Flags change=00000000000008d1 0 00 o s z 0 a 0 0 c
# [OK]	Arguments are preserved across syscall
# [NOTE]	R11 has changed:0000000000200606 - assuming clobbered by SYSRET insn
# [OK]	R8..R15 did not leak kernel data
# [RUN]	Executing 6-argument 32-bit syscall via INT 80
# [OK]	Arguments are preserved across syscall
# [OK]	R8..R15 did not leak kernel data
# [RUN]	Executing 6-argument 32-bit syscall via VDSO
# [WARN]	Flags before=0000000000200ed7 id 0 00 o d i s z 0 a 0 p 1 c
# [WARN]	Flags  after=0000000000200606 id 0 00 d i 0 0 p 1 
# [WARN]	Flags change=00000000000008d1 0 00 o s z 0 a 0 0 c
# [OK]	Arguments are preserved across syscall
# [NOTE]	R11 has changed:0000000000200606 - assuming clobbered by SYSRET insn
# [OK]	R8..R15 did not leak kernel data
# [RUN]	Executing 6-argument 32-bit syscall via INT 80
# [OK]	Arguments are preserved across syscall
# [OK]	R8..R15 did not leak kernel data
# [RUN]	Running tests under ptrace
ok 14 selftests: x86: test_syscall_vdso_32
# selftests: x86: unwind_vdso_32
# 	AT_SYSINFO is 0xf7f4c540
# [OK]	AT_SYSINFO maps to linux-gate.so.1, loaded at 0x0xf7f4c000
# [RUN]	Set TF and check a fast syscall
# 	In vsyscall at 0xf7f4c540, returning to 0xf7e0a9c7
# 	SIGTRAP at 0xf7f4c540
# 	  0xf7f4c540
# 	  0xf7e0a9c7
# [OK]	  NR = 20, args = 1, 2, 3, 4, 5, 6
# 	SIGTRAP at 0xf7f4c541
# 	  0xf7f4c541
# 	  0xf7e0a9c7
# [OK]	  NR = 20, args = 1, 2, 3, 4, 5, 6
# 	SIGTRAP at 0xf7f4c542
# 	  0xf7f4c542
# 	  0xf7e0a9c7
# [OK]	  NR = 20, args = 1, 2, 3, 4, 5, 6
# 	SIGTRAP at 0xf7f4c543
# 	  0xf7f4c543
# 	  0xf7e0a9c7
# [OK]	  NR = 20, args = 1, 2, 3, 4, 5, 6
# 	SIGTRAP at 0xf7f4c545
# 	  0xf7f4c545
# 	  0xf7e0a9c7
# [OK]	  NR = 20, args = 1, 2, 3, 4, 5, 6
# 	SIGTRAP at 0xf7f4c54a
# 	  0xf7f4c54a
# 	  0xf7e0a9c7
# [OK]	  NR = 1932, args = 1, 2, 3, 4, 5, 6
# 	SIGTRAP at 0xf7f4c54b
# 	  0xf7f4c54b
# 	  0xf7e0a9c7
# [OK]	  NR = 1932, args = 1, 2, 3, 4, 5, 6
# 	SIGTRAP at 0xf7f4c54c
# 	  0xf7f4c54c
# 	  0xf7e0a9c7
# [OK]	  NR = 1932, args = 1, 2, 3, 4, 5, 6
# 	Vsyscall is done
# [OK]	All is well
ok 15 selftests: x86: unwind_vdso_32
# selftests: x86: test_FCMOV_32
# [RUN]	Testing fcmovCC instructions
# [OK]	fcmovCC
ok 16 selftests: x86: test_FCMOV_32
# selftests: x86: test_FCOMI_32
# [RUN]	Testing f[u]comi[p] instructions
# [OK]	f[u]comi[p]
ok 17 selftests: x86: test_FCOMI_32
# selftests: x86: test_FISTTP_32
# [RUN]	Testing fisttp instructions
# [OK]	fisttp
ok 18 selftests: x86: test_FISTTP_32
# selftests: x86: vdso_restorer_32
# [RUN]	Raise a signal, SA_SIGINFO, sa.restorer == NULL
# [OK]	SA_SIGINFO handler returned successfully
# [RUN]	Raise a signal, !SA_SIGINFO, sa.restorer == NULL
# [OK]	!SA_SIGINFO handler returned successfully
ok 19 selftests: x86: vdso_restorer_32
# selftests: x86: ldt_gdt_32
# [NOTE]	set_thread_area is available; will use GDT index 13
# [OK]	LDT entry 0 has AR 0x0040FB00 and limit 0x0000000A
# [OK]	LDT entry 0 has AR 0x00C0FB00 and limit 0x0000AFFF
# [OK]	LDT entry 1 is invalid
# [OK]	LDT entry 2 has AR 0x00C0FB00 and limit 0x0000AFFF
# [OK]	LDT entry 1 is invalid
# [OK]	LDT entry 2 has AR 0x00C0FB00 and limit 0x0000AFFF
# [OK]	LDT entry 2 has AR 0x00D0FB00 and limit 0x0000AFFF
# [OK]	LDT entry 2 has AR 0x00D07B00 and limit 0x0000AFFF
# [OK]	LDT entry 2 has AR 0x00907B00 and limit 0x0000AFFF
# [OK]	LDT entry 2 has AR 0x00D07300 and limit 0x0000AFFF
# [OK]	LDT entry 2 has AR 0x00D07100 and limit 0x0000AFFF
# [OK]	LDT entry 2 has AR 0x00D07500 and limit 0x0000AFFF
# [OK]	LDT entry 2 has AR 0x00507700 and limit 0x0000000A
# [OK]	LDT entry 2 has AR 0x00507F00 and limit 0x0000000A
# [OK]	LDT entry 2 has AR 0x00507D00 and limit 0x0000000A
# [OK]	LDT entry 2 has AR 0x00507B00 and limit 0x0000000A
# [OK]	LDT entry 2 has AR 0x00507900 and limit 0x0000000A
# [RUN]	Test fork
# [OK]	LDT entry 2 has AR 0x00507900 and limit 0x0000000A
# [OK]	LDT entry 1 is invalid
# [OK]	LDT entry 0 is invalid
# [NOTE]	set_thread_area is available; will use GDT index 13
# [OK]	LDT entry 0 has AR 0x0040FB00 and limit 0x0000000A
# [OK]	LDT entry 0 has AR 0x00C0FB00 and limit 0x0000AFFF
# [OK]	LDT entry 1 is invalid
# [OK]	LDT entry 2 has AR 0x00C0FB00 and limit 0x0000AFFF
# [OK]	LDT entry 1 is invalid
# [OK]	LDT entry 2 has AR 0x00C0FB00 and limit 0x0000AFFF
# [OK]	LDT entry 2 has AR 0x00D0FB00 and limit 0x0000AFFF
# [OK]	LDT entry 2 has AR 0x00D07B00 and limit 0x0000AFFF
# [OK]	LDT entry 2 has AR 0x00907B00 and limit 0x0000AFFF
# [OK]	LDT entry 2 has AR 0x00D07300 and limit 0x0000AFFF
# [OK]	LDT entry 2 has AR 0x00D07100 and limit 0x0000AFFF
# [OK]	LDT entry 2 has AR 0x00D07500 and limit 0x0000AFFF
# [OK]	LDT entry 2 has AR 0x00507700 and limit 0x0000000A
# [OK]	LDT entry 2 has AR 0x00507F00 and limit 0x0000000A
# [OK]	LDT entry 2 has AR 0x00507D00 and limit 0x0000000A
# [OK]	LDT entry 2 has AR 0x00507B00 and limit 0x0000000A
# [OK]	LDT entry 2 has AR 0x00507900 and limit 0x0000000A
# [RUN]	Test fork
# [OK]	Child succeeded
# [RUN]	Test size
# [DONE]	Size test
# [OK]	modify_ldt failure 22
# [OK]	LDT entry 0 has AR 0x0000F300 and limit 0x00000000
# [OK]	LDT entry 0 has AR 0x00007300 and limit 0x00000000
# [OK]	LDT entry 0 has AR 0x0000F100 and limit 0x00000000
# [OK]	LDT entry 0 has AR 0x00007300 and limit 0x00000000
# [OK]	LDT entry 0 has AR 0x00007100 and limit 0x00000001
# [OK]	LDT entry 0 has AR 0x00007100 and limit 0x00000000
# [OK]	LDT entry 0 is invalid
# [OK]	LDT entry 0 has AR 0x0040F300 and limit 0x000FFFFF
# [OK]	GDT entry 13 has AR 0x0040F300 and limit 0x000FFFFF
# [OK]	LDT entry 0 has AR 0x00C0F300 and limit 0xFFFFFFFF
# [OK]	GDT entry 13 has AR 0x00C0F300 and limit 0xFFFFFFFF
# [OK]	LDT entry 0 has AR 0x00C0F100 and limit 0xFFFFFFFF
# [OK]	GDT entry 13 has AR 0x00C0F100 and limit 0xFFFFFFFF
# [OK]	LDT entry 0 has AR 0x00C0F700 and limit 0xFFFFFFFF
# [OK]	GDT entry 13 has AR 0x00C0F700 and limit 0xFFFFFFFF
# [OK]	LDT entry 0 has AR 0x00C0F500 and limit 0xFFFFFFFF
# [OK]	GDT entry 13 has AR 0x00C0F500 and limit 0xFFFFFFFF
# [OK]	LDT entry 0 is invalid
# [SKIP]	Cannot set affinity to CPU 1
# [RUN]	Test exec
# [OK]	LDT entry 0 has AR 0x0040FB00 and limit 0x0000002A
# [OK]	Child succeeded
# [OK]	Invalidate DS with set_thread_area: new DS = 0x0
# [OK]	Invalidate ES with set_thread_area: new ES = 0x0
# [OK]	Invalidate FS with set_thread_area: new FS = 0x0
# [OK]	Invalidate GS with set_thread_area: new GS = 0x0
ok 20 selftests: x86: ldt_gdt_32
# selftests: x86: ptrace_syscall_32
# ptrace_syscall_32: PTRACE_SETREGS: Input/output error
# [RUN]	Check int80 return regs
# [OK]	getpid() preserves regs
# [OK]	kill(getpid(), SIGUSR1) preserves regs
# [RUN]	Check AT_SYSINFO return regs
# [OK]	getpid() preserves regs
# [OK]	kill(getpid(), SIGUSR1) preserves regs
# [RUN]	ptrace-induced syscall restart
# [RUN]	SYSEMU
# [OK]	Initial nr and args are correct
# [RUN]	Restart the syscall (ip = 0xf7f5c549)
not ok 21 selftests: x86: ptrace_syscall_32 # exit=1
# selftests: x86: single_step_syscall_64
# [RUN]	Set TF and check nop
# [OK]	Survived with TF set and 10 traps
# [RUN]	Set TF and check syscall-less opportunistic sysret
# [OK]	Survived with TF set and 12 traps
# [RUN]	Set TF and check int80
# [OK]	Survived with TF set and 9 traps
# [RUN]	Set TF and check a fast syscall
# [OK]	Survived with TF set and 22 traps
# [RUN]	Fast syscall with TF cleared
# [OK]	Nothing unexpected happened
# [RUN]	Set TF and check SYSENTER
# 	Got SIGSEGV with RIP=8f986549, TF=256
# [RUN]	Fast syscall with TF cleared
# [OK]	Nothing unexpected happened
ok 22 selftests: x86: single_step_syscall_64
# selftests: x86: sysret_ss_attrs_64
# [RUN]	Syscalls followed by SS validation
# [OK]	We survived
ok 23 selftests: x86: sysret_ss_attrs_64
# selftests: x86: syscall_nt_64
# [RUN]	Set NT and issue a syscall
# [OK]	The syscall worked and flags are still set
# [RUN]	Set AC and issue a syscall
# [OK]	The syscall worked and flags are still set
# [RUN]	Set NT|AC and issue a syscall
# [OK]	The syscall worked and flags are still set
# [RUN]	Set TF and issue a syscall
# [OK]	The syscall worked and flags are still set
# [RUN]	Set NT|TF and issue a syscall
# [OK]	The syscall worked and flags are still set
# [RUN]	Set AC|TF and issue a syscall
# [OK]	The syscall worked and flags are still set
# [RUN]	Set NT|AC|TF and issue a syscall
# [OK]	The syscall worked and flags are still set
# [RUN]	Set DF and issue a syscall
# [OK]	The syscall worked and flags are still set
# [RUN]	Set TF|DF and issue a syscall
# [OK]	The syscall worked and flags are still set
ok 24 selftests: x86: syscall_nt_64
# selftests: x86: test_mremap_vdso_64
# 	AT_SYSINFO_EHDR is 0x7ffe75c39000
# [NOTE]	Moving vDSO: [0x7ffe75c39000, 0x7ffe75c3a000] -> [0x7f809e827000, 0x7f809e828000]
# [NOTE]	vDSO partial move failed, will try with bigger size
# [NOTE]	Moving vDSO: [0x7ffe75c39000, 0x7ffe75c3b000] -> [0x7f809e7fc000, 0x7f809e7fe000]
# [OK]
ok 25 selftests: x86: test_mremap_vdso_64
# selftests: x86: check_initial_reg_state_64
# [OK]	All GPRs except SP are 0
# [OK]	FLAGS is 0x202
ok 26 selftests: x86: check_initial_reg_state_64
# selftests: x86: sigreturn_64
# [OK]	set_thread_area refused 16-bit data
# [OK]	set_thread_area refused 16-bit data
# [RUN]	Valid sigreturn: 64-bit CS (33), 32-bit SS (2b, GDT)
# [OK]	all registers okay
# [RUN]	Valid sigreturn: 32-bit CS (23), 32-bit SS (2b, GDT)
# [NOTE]	SP: 8badf00d5aadc0de -> 5aadc0de
# [OK]	all registers okay
# [RUN]	Valid sigreturn: 16-bit CS (37), 32-bit SS (2b, GDT)
# [NOTE]	SP: 8badf00d5aadc0de -> 5aadc0de
# [OK]	all registers okay
# [RUN]	Valid sigreturn: 64-bit CS (33), 16-bit SS (3f)
# [OK]	all registers okay
# [RUN]	Valid sigreturn: 32-bit CS (23), 16-bit SS (3f)
# [NOTE]	SP: 8badf00d5aadc0de -> 5aadc0de
# [OK]	all registers okay
# [RUN]	Valid sigreturn: 16-bit CS (37), 16-bit SS (3f)
# [NOTE]	SP: 8badf00d5aadc0de -> 5aadc0de
# [OK]	all registers okay
# [RUN]	Valid sigreturn: 32-bit CS (23), 32-bit SS (2b, GDT)
# 	Corrupting SS on return to 64-bit mode
# [NOTE]	SP: 8badf00d5aadc0de -> 5aadc0de
# [OK]	all registers okay
# [RUN]	Valid sigreturn: 32-bit CS (23), 16-bit SS (3f)
# 	Corrupting SS on return to 64-bit mode
# [NOTE]	SP: 8badf00d5aadc0de -> 5aadc0de
# [OK]	all registers okay
# [RUN]	64-bit CS (33), bogus SS (47)
# [OK]	Got #GP(0x0) (i.e. Segmentation fault)
# [RUN]	32-bit CS (23), bogus SS (47)
# [OK]	Got #GP(0x0) (i.e. Segmentation fault)
# [RUN]	16-bit CS (37), bogus SS (47)
# [OK]	Got #GP(0x0) (i.e. Segmentation fault)
# [RUN]	64-bit CS (33), bogus SS (33)
# [OK]	Got #GP(0x30) (i.e. GDT index 6, Segmentation fault)
# [RUN]	32-bit CS (23), bogus SS (33)
# [OK]	Got #GP(0x30) (i.e. GDT index 6, Segmentation fault)
# [RUN]	16-bit CS (37), bogus SS (33)
# [OK]	Got #GP(0x30) (i.e. GDT index 6, Segmentation fault)
# [RUN]	32-bit CS (4f), bogus SS (2b)
# [OK]	Got #NP(0x4c) (i.e. LDT index 9, Bus error)
# [RUN]	32-bit CS (23), bogus SS (57)
# [OK]	Got #GP(0x0) (i.e. Segmentation fault)
# [RUN]	Clear UC_STRICT_RESTORE_SS and corrupt SS
# [OK]	It worked
ok 27 selftests: x86: sigreturn_64
# selftests: x86: iopl_64
# [OK]	CLI NOPped
# [OK]	STI NOPped
# [OK]	outb to 0x80 worked
# [OK]	outb to 0x80 worked
# [OK]	outb to 0xed failed
# 	child: set IOPL to 3
# [RUN]	child: write to 0x80
# [OK]	CLI NOPped
# [OK]	STI NOPped
# [OK]	outb to 0x80 worked
# [OK]	outb to 0x80 worked
# [OK]	outb to 0xed failed
# [OK]	Child succeeded
# [RUN]	parent: write to 0x80 (should fail)
# [OK]	outb to 0x80 failed
# [OK]	CLI faulted
# [OK]	STI faulted
# 	iopl(3)
# 	Drop privileges
# [RUN]	iopl(3) unprivileged but with IOPL==3
# [RUN]	iopl(0) unprivileged
# [RUN]	iopl(3) unprivileged
# [OK]	Failed as expected
ok 28 selftests: x86: iopl_64
# selftests: x86: ioperm_64
# [OK]	outb to 0x80 failed
# [OK]	outb to 0xed failed
# [RUN]	enable 0x80
# [OK]	outb to 0x80 worked
# [OK]	outb to 0xed failed
# [RUN]	disable 0x80
# [OK]	outb to 0x80 failed
# [OK]	outb to 0xed failed
# [RUN]	child: check that we inherited permissions
# [OK]	outb to 0x80 worked
# [OK]	outb to 0xed failed
# [RUN]	child: Extend permissions to 0x81
# [RUN]	child: Drop permissions to 0x80
# [OK]	outb to 0x80 failed
# [OK]	outb to 0x80 failed
# [OK]	outb to 0xed failed
# [RUN]	enable 0x80
# [OK]	outb to 0x80 worked
# [OK]	outb to 0xed failed
# [RUN]	disable 0x80
# [OK]	outb to 0x80 failed
# [OK]	outb to 0xed failed
# [OK]	Child succeeded
# 	Verify that unsharing the bitmap worked
# [OK]	outb to 0x80 worked
# 	Drop privileges
# [RUN]	disable 0x80
# [OK]	it worked
# [RUN]	enable 0x80 again
# [OK]	it failed
ok 29 selftests: x86: ioperm_64
# selftests: x86: test_vsyscall_64
# 	vsyscall map: ffffffffff600000-ffffffffff601000 --xp 00000000 00:00 0                  [vsyscall]
# 	vsyscall permissions are --x
# [RUN]	test gettimeofday()
# 	vDSO time offsets: 0.000035 0.000010
# [OK]	vDSO gettimeofday()'s timeval was okay
# 	vsyscall time offsets: 0.000040 0.000005
# [OK]	vsyscall gettimeofday()'s timeval was okay
# [RUN]	test time()
# [OK]	vDSO time() is okay
# [OK]	vsyscall time() is okay
# [RUN]	getcpu() on CPU 0
# [OK]	vDSO reported correct CPU
# [OK]	vDSO reported correct node
# [OK]	vsyscall reported correct CPU
# [OK]	vsyscall reported correct node
# [RUN]	getcpu() on CPU 1
# [OK]	vDSO reported correct CPU
# [OK]	vDSO reported correct node
# [OK]	vsyscall reported correct CPU
# [OK]	vsyscall reported correct node
# [RUN]	Checking read access to the vsyscall page
# [OK]	We do not have read access: #PF(0x5)
# [RUN]	process_vm_readv() from vsyscall page
# [OK]	process_vm_readv() failed (ret = -1, errno = 14)
# [RUN]	checking that vsyscalls are emulated
# [OK]	vsyscalls are emulated (1 instructions in vsyscall page)
ok 30 selftests: x86: test_vsyscall_64
# selftests: x86: syscall_arg_fault_64
# [RUN]	SYSENTER with invalid state
# [OK]	Seems okay
# [RUN]	SYSCALL with invalid state
# [OK]	SYSCALL returned normally
# [RUN]	SYSENTER with TF and invalid state
# [OK]	Seems okay
# [RUN]	SYSCALL with TF and invalid state
# [OK]	SYSCALL returned normally
# [RUN]	SYSENTER with TF, invalid state, and GSBASE < 0
# [SKIP]	Illegal instruction
ok 31 selftests: x86: syscall_arg_fault_64
# selftests: x86: fsgsbase_restore_64
# fsgsbase_restore_64: PTRACE_GETREGS: Input/output error
# 	Setting up a segment
# 	segment base address = 0x40c52000
# 	using LDT slot 0
# [OK]	The segment points to the right place.
# 	Child GS=0x7, GSBASE=0x40c52000
# 	Tracer: redirecting tracee to tracee_zap_segment()
not ok 32 selftests: x86: fsgsbase_restore_64 # exit=1
# selftests: x86: sigaltstack_64
# [RUN]	Test an alternate signal stack of sufficient size.
# 	Raise SIGALRM. It is expected to be delivered.
# [OK]	SIGALRM signal delivered.
ok 33 selftests: x86: sigaltstack_64
# selftests: x86: fsgsbase_64
# [OK]	GSBASE started at 1
# [RUN]	Set GS = 0x7, read GSBASE
# [OK]	GSBASE reads as 0x0 with invalid GS
# 	FSGSBASE instructions are disabled
# [RUN]	ARCH_SET_GS to 0x0
# [OK]	GSBASE was set as expected (selector 0x0)
# [OK]	ARCH_GET_GS worked as expected (selector 0x0)
# [RUN]	ARCH_SET_GS to 0x1
# [OK]	GSBASE was set as expected (selector 0x0)
# [OK]	ARCH_GET_GS worked as expected (selector 0x0)
# [RUN]	ARCH_SET_GS to 0x200000000
# [OK]	GSBASE was set as expected (selector 0x0)
# [OK]	ARCH_GET_GS worked as expected (selector 0x0)
# [RUN]	ARCH_SET_GS to 0x0
# [OK]	GSBASE was set as expected (selector 0x0)
# [OK]	ARCH_GET_GS worked as expected (selector 0x0)
# [RUN]	ARCH_SET_GS to 0x200000000
# [OK]	GSBASE was set as expected (selector 0x0)
# [OK]	ARCH_GET_GS worked as expected (selector 0x0)
# [RUN]	ARCH_SET_GS to 0x1
# [OK]	GSBASE was set as expected (selector 0x0)
# [OK]	ARCH_GET_GS worked as expected (selector 0x0)
# [RUN]	ARCH_SET_GS to 0x0 then mov 0 to %gs
# [OK]	GSBASE is 0x0
# [RUN]	ARCH_SET_GS to 0x1 then mov 0 to %gs
# [OK]	GSBASE is 0x0
# [RUN]	ARCH_SET_GS to 0x200000000 then mov 0 to %gs
# [OK]	GSBASE is 0x0
# [RUN]	ARCH_SET_GS to 0x0 then mov 0 to %gs and schedule 
# [OK]	GSBASE is 0x0
# [RUN]	ARCH_SET_GS to 0x1 then mov 0 to %gs and schedule 
# [OK]	GSBASE is 0x0
# [RUN]	ARCH_SET_GS to 0x200000000 then mov 0 to %gs and schedule 
# [OK]	GSBASE is 0x0
# [RUN]	ARCH_SET_GS(0x0), then schedule to 0x0
# 	other thread: ARCH_SET_GS(0x0) -- sel is 0x0
# [OK]	GS/BASE remained 0x0/0x0
# [RUN]	ARCH_SET_GS(0x0), then schedule to 0x0
# 	Before schedule, set selector to 0x1
# 	other thread: ARCH_SET_GS(0x0) -- sel is 0x0
# [OK]	GS/BASE remained 0x1/0x0
# [RUN]	ARCH_SET_GS(0x0), then schedule to 0x0
# 	Before schedule, set selector to 0x2
# 	other thread: ARCH_SET_GS(0x0) -- sel is 0x0
# [OK]	GS/BASE remained 0x2/0x0
# [RUN]	ARCH_SET_GS(0x0), then schedule to 0x0
# 	Before schedule, set selector to 0x3
# 	other thread: ARCH_SET_GS(0x0) -- sel is 0x0
# [OK]	GS/BASE remained 0x3/0x0
# [RUN]	ARCH_SET_GS(0x0), then schedule to 0x0
# 	Before schedule, set selector to 0x2b
# 	other thread: ARCH_SET_GS(0x0) -- sel is 0x0
# [OK]	GS/BASE remained 0x2b/0x0
# [RUN]	ARCH_SET_GS(0x0), then schedule to 0xa1fa5f343cb85fa4
# 	other thread: ARCH_SET_GS(0x0) and clear gs -- sel is 0x0
# [OK]	GS/BASE remained 0x0/0x0
# [RUN]	ARCH_SET_GS(0x0), then schedule to 0xa1fa5f343cb85fa4
# 	Before schedule, set selector to 0x1
# 	other thread: ARCH_SET_GS(0x0) and clear gs -- sel is 0x0
# [OK]	GS/BASE remained 0x1/0x0
# [RUN]	ARCH_SET_GS(0x0), then schedule to 0xa1fa5f343cb85fa4
# 	Before schedule, set selector to 0x2
# 	other thread: ARCH_SET_GS(0x0) and clear gs -- sel is 0x0
# [OK]	GS/BASE remained 0x2/0x0
# [RUN]	ARCH_SET_GS(0x0), then schedule to 0xa1fa5f343cb85fa4
# 	Before schedule, set selector to 0x3
# 	other thread: ARCH_SET_GS(0x0) and clear gs -- sel is 0x0
# [OK]	GS/BASE remained 0x3/0x0
# [RUN]	ARCH_SET_GS(0x0), then schedule to 0xa1fa5f343cb85fa4
# 	Before schedule, set selector to 0x2b
# 	other thread: ARCH_SET_GS(0x0) and clear gs -- sel is 0x0
# [OK]	GS/BASE remained 0x2b/0x0
# [RUN]	ARCH_SET_GS(0x0), then schedule to 0x1
# 	other thread: ARCH_SET_GS(0x1) -- sel is 0x0
# [OK]	GS/BASE remained 0x0/0x0
# [RUN]	ARCH_SET_GS(0x0), then schedule to 0x1
# 	Before schedule, set selector to 0x1
# 	other thread: ARCH_SET_GS(0x1) -- sel is 0x0
# [OK]	GS/BASE remained 0x1/0x0
# [RUN]	ARCH_SET_GS(0x0), then schedule to 0x1
# 	Before schedule, set selector to 0x2
# 	other thread: ARCH_SET_GS(0x1) -- sel is 0x0
# [OK]	GS/BASE remained 0x2/0x0
# [RUN]	ARCH_SET_GS(0x0), then schedule to 0x1
# 	Before schedule, set selector to 0x3
# 	other thread: ARCH_SET_GS(0x1) -- sel is 0x0
# [OK]	GS/BASE remained 0x3/0x0
# [RUN]	ARCH_SET_GS(0x0), then schedule to 0x1
# 	Before schedule, set selector to 0x2b
# 	other thread: ARCH_SET_GS(0x1) -- sel is 0x0
# [OK]	GS/BASE remained 0x2b/0x0
# [RUN]	ARCH_SET_GS(0x0), then schedule to 0x200000000
# 	other thread: ARCH_SET_GS(0x200000000) -- sel is 0x0
# [OK]	GS/BASE remained 0x0/0x0
# [RUN]	ARCH_SET_GS(0x0), then schedule to 0x200000000
# 	Before schedule, set selector to 0x1
# 	other thread: ARCH_SET_GS(0x200000000) -- sel is 0x0
# [OK]	GS/BASE remained 0x1/0x0
# [RUN]	ARCH_SET_GS(0x0), then schedule to 0x200000000
# 	Before schedule, set selector to 0x2
# 	other thread: ARCH_SET_GS(0x200000000) -- sel is 0x0
# [OK]	GS/BASE remained 0x2/0x0
# [RUN]	ARCH_SET_GS(0x0), then schedule to 0x200000000
# 	Before schedule, set selector to 0x3
# 	other thread: ARCH_SET_GS(0x200000000) -- sel is 0x0
# [OK]	GS/BASE remained 0x3/0x0
# [RUN]	ARCH_SET_GS(0x0), then schedule to 0x200000000
# 	Before schedule, set selector to 0x2b
# 	other thread: ARCH_SET_GS(0x200000000) -- sel is 0x0
# [OK]	GS/BASE remained 0x2b/0x0
# [RUN]	ARCH_SET_GS(0x0) and clear gs, then schedule to 0x0
# 	other thread: ARCH_SET_GS(0x0) -- sel is 0x0
# [OK]	GS/BASE remained 0x0/0x0
# [RUN]	ARCH_SET_GS(0x0) and clear gs, then schedule to 0x0
# 	Before schedule, set selector to 0x1
# 	other thread: ARCH_SET_GS(0x0) -- sel is 0x0
# [OK]	GS/BASE remained 0x1/0x0
# [RUN]	ARCH_SET_GS(0x0) and clear gs, then schedule to 0x0
# 	Before schedule, set selector to 0x2
# 	other thread: ARCH_SET_GS(0x0) -- sel is 0x0
# [OK]	GS/BASE remained 0x2/0x0
# [RUN]	ARCH_SET_GS(0x0) and clear gs, then schedule to 0x0
# 	Before schedule, set selector to 0x3
# 	other thread: ARCH_SET_GS(0x0) -- sel is 0x0
# [OK]	GS/BASE remained 0x3/0x0
# [RUN]	ARCH_SET_GS(0x0) and clear gs, then schedule to 0x0
# 	Before schedule, set selector to 0x2b
# 	other thread: ARCH_SET_GS(0x0) -- sel is 0x0
# [OK]	GS/BASE remained 0x2b/0x0
# [RUN]	ARCH_SET_GS(0x0) and clear gs, then schedule to 0xa1fa5f343cb85fa4
# 	other thread: ARCH_SET_GS(0x0) and clear gs -- sel is 0x0
# [OK]	GS/BASE remained 0x0/0x0
# [RUN]	ARCH_SET_GS(0x0) and clear gs, then schedule to 0xa1fa5f343cb85fa4
# 	Before schedule, set selector to 0x1
# 	other thread: ARCH_SET_GS(0x0) and clear gs -- sel is 0x0
# [OK]	GS/BASE remained 0x1/0x0
# [RUN]	ARCH_SET_GS(0x0) and clear gs, then schedule to 0xa1fa5f343cb85fa4
# 	Before schedule, set selector to 0x2
# 	other thread: ARCH_SET_GS(0x0) and clear gs -- sel is 0x0
# [OK]	GS/BASE remained 0x2/0x0
# [RUN]	ARCH_SET_GS(0x0) and clear gs, then schedule to 0xa1fa5f343cb85fa4
# 	Before schedule, set selector to 0x3
# 	other thread: ARCH_SET_GS(0x0) and clear gs -- sel is 0x0
# [OK]	GS/BASE remained 0x3/0x0
# [RUN]	ARCH_SET_GS(0x0) and clear gs, then schedule to 0xa1fa5f343cb85fa4
# 	Before schedule, set selector to 0x2b
# 	other thread: ARCH_SET_GS(0x0) and clear gs -- sel is 0x0
# [OK]	GS/BASE remained 0x2b/0x0
# [RUN]	ARCH_SET_GS(0x0) and clear gs, then schedule to 0x1
# 	other thread: ARCH_SET_GS(0x1) -- sel is 0x0
# [OK]	GS/BASE remained 0x0/0x0
# [RUN]	ARCH_SET_GS(0x0) and clear gs, then schedule to 0x1
# 	Before schedule, set selector to 0x1
# 	other thread: ARCH_SET_GS(0x1) -- sel is 0x0
# [OK]	GS/BASE remained 0x1/0x0
# [RUN]	ARCH_SET_GS(0x0) and clear gs, then schedule to 0x1
# 	Before schedule, set selector to 0x2
# 	other thread: ARCH_SET_GS(0x1) -- sel is 0x0
# [OK]	GS/BASE remained 0x2/0x0
# [RUN]	ARCH_SET_GS(0x0) and clear gs, then schedule to 0x1
# 	Before schedule, set selector to 0x3
# 	other thread: ARCH_SET_GS(0x1) -- sel is 0x0
# [OK]	GS/BASE remained 0x3/0x0
# [RUN]	ARCH_SET_GS(0x0) and clear gs, then schedule to 0x1
# 	Before schedule, set selector to 0x2b
# 	other thread: ARCH_SET_GS(0x1) -- sel is 0x0
# [OK]	GS/BASE remained 0x2b/0x0
# [RUN]	ARCH_SET_GS(0x0) and clear gs, then schedule to 0x200000000
# 	other thread: ARCH_SET_GS(0x200000000) -- sel is 0x0
# [OK]	GS/BASE remained 0x0/0x0
# [RUN]	ARCH_SET_GS(0x0) and clear gs, then schedule to 0x200000000
# 	Before schedule, set selector to 0x1
# 	other thread: ARCH_SET_GS(0x200000000) -- sel is 0x0
# [OK]	GS/BASE remained 0x1/0x0
# [RUN]	ARCH_SET_GS(0x0) and clear gs, then schedule to 0x200000000
# 	Before schedule, set selector to 0x2
# 	other thread: ARCH_SET_GS(0x200000000) -- sel is 0x0
# [OK]	GS/BASE remained 0x2/0x0
# [RUN]	ARCH_SET_GS(0x0) and clear gs, then schedule to 0x200000000
# 	Before schedule, set selector to 0x3
# 	other thread: ARCH_SET_GS(0x200000000) -- sel is 0x0
# [OK]	GS/BASE remained 0x3/0x0
# [RUN]	ARCH_SET_GS(0x0) and clear gs, then schedule to 0x200000000
# 	Before schedule, set selector to 0x2b
# 	other thread: ARCH_SET_GS(0x200000000) -- sel is 0x0
# [OK]	GS/BASE remained 0x2b/0x0
# [RUN]	ARCH_SET_GS(0x1), then schedule to 0x0
# 	other thread: ARCH_SET_GS(0x0) -- sel is 0x0
# [OK]	GS/BASE remained 0x0/0x1
# [RUN]	ARCH_SET_GS(0x1), then schedule to 0x0
# 	Before schedule, set selector to 0x1
# 	other thread: ARCH_SET_GS(0x0) -- sel is 0x0
# [OK]	GS/BASE remained 0x1/0x0
# [RUN]	ARCH_SET_GS(0x1), then schedule to 0x0
# 	Before schedule, set selector to 0x2
# 	other thread: ARCH_SET_GS(0x0) -- sel is 0x0
# [OK]	GS/BASE remained 0x2/0x0
# [RUN]	ARCH_SET_GS(0x1), then schedule to 0x0
# 	Before schedule, set selector to 0x3
# 	other thread: ARCH_SET_GS(0x0) -- sel is 0x0
# [OK]	GS/BASE remained 0x3/0x0
# [RUN]	ARCH_SET_GS(0x1), then schedule to 0x0
# 	Before schedule, set selector to 0x2b
# 	other thread: ARCH_SET_GS(0x0) -- sel is 0x0
# [OK]	GS/BASE remained 0x2b/0x0
# [RUN]	ARCH_SET_GS(0x1), then schedule to 0xa1fa5f343cb85fa4
# 	other thread: ARCH_SET_GS(0x0) and clear gs -- sel is 0x0
# [OK]	GS/BASE remained 0x0/0x1
# [RUN]	ARCH_SET_GS(0x1), then schedule to 0xa1fa5f343cb85fa4
# 	Before schedule, set selector to 0x1
# 	other thread: ARCH_SET_GS(0x0) and clear gs -- sel is 0x0
# [OK]	GS/BASE remained 0x1/0x0
# [RUN]	ARCH_SET_GS(0x1), then schedule to 0xa1fa5f343cb85fa4
# 	Before schedule, set selector to 0x2
# 	other thread: ARCH_SET_GS(0x0) and clear gs -- sel is 0x0
# [OK]	GS/BASE remained 0x2/0x0
# [RUN]	ARCH_SET_GS(0x1), then schedule to 0xa1fa5f343cb85fa4
# 	Before schedule, set selector to 0x3
# 	other thread: ARCH_SET_GS(0x0) and clear gs -- sel is 0x0
# [OK]	GS/BASE remained 0x3/0x0
# [RUN]	ARCH_SET_GS(0x1), then schedule to 0xa1fa5f343cb85fa4
# 	Before schedule, set selector to 0x2b
# 	other thread: ARCH_SET_GS(0x0) and clear gs -- sel is 0x0
# [OK]	GS/BASE remained 0x2b/0x0
# [RUN]	ARCH_SET_GS(0x1), then schedule to 0x1
# 	other thread: ARCH_SET_GS(0x1) -- sel is 0x0
# [OK]	GS/BASE remained 0x0/0x1
# [RUN]	ARCH_SET_GS(0x1), then schedule to 0x1
# 	Before schedule, set selector to 0x1
# 	other thread: ARCH_SET_GS(0x1) -- sel is 0x0
# [OK]	GS/BASE remained 0x1/0x0
# [RUN]	ARCH_SET_GS(0x1), then schedule to 0x1
# 	Before schedule, set selector to 0x2
# 	other thread: ARCH_SET_GS(0x1) -- sel is 0x0
# [OK]	GS/BASE remained 0x2/0x0
# [RUN]	ARCH_SET_GS(0x1), then schedule to 0x1
# 	Before schedule, set selector to 0x3
# 	other thread: ARCH_SET_GS(0x1) -- sel is 0x0
# [OK]	GS/BASE remained 0x3/0x0
# [RUN]	ARCH_SET_GS(0x1), then schedule to 0x1
# 	Before schedule, set selector to 0x2b
# 	other thread: ARCH_SET_GS(0x1) -- sel is 0x0
# [OK]	GS/BASE remained 0x2b/0x0
# [RUN]	ARCH_SET_GS(0x1), then schedule to 0x200000000
# 	other thread: ARCH_SET_GS(0x200000000) -- sel is 0x0
# [OK]	GS/BASE remained 0x0/0x1
# [RUN]	ARCH_SET_GS(0x1), then schedule to 0x200000000
# 	Before schedule, set selector to 0x1
# 	other thread: ARCH_SET_GS(0x200000000) -- sel is 0x0
# [OK]	GS/BASE remained 0x1/0x0
# [RUN]	ARCH_SET_GS(0x1), then schedule to 0x200000000
# 	Before schedule, set selector to 0x2
# 	other thread: ARCH_SET_GS(0x200000000) -- sel is 0x0
# [OK]	GS/BASE remained 0x2/0x0
# [RUN]	ARCH_SET_GS(0x1), then schedule to 0x200000000
# 	Before schedule, set selector to 0x3
# 	other thread: ARCH_SET_GS(0x200000000) -- sel is 0x0
# [OK]	GS/BASE remained 0x3/0x0
# [RUN]	ARCH_SET_GS(0x1), then schedule to 0x200000000
# 	Before schedule, set selector to 0x2b
# 	other thread: ARCH_SET_GS(0x200000000) -- sel is 0x0
# [OK]	GS/BASE remained 0x2b/0x0
# [RUN]	ARCH_SET_GS(0x200000000), then schedule to 0x0
# 	other thread: ARCH_SET_GS(0x0) -- sel is 0x0
# [OK]	GS/BASE remained 0x0/0x200000000
# [RUN]	ARCH_SET_GS(0x200000000), then schedule to 0x0
# 	Before schedule, set selector to 0x1
# 	other thread: ARCH_SET_GS(0x0) -- sel is 0x0
# [OK]	GS/BASE remained 0x1/0x0
# [RUN]	ARCH_SET_GS(0x200000000), then schedule to 0x0
# 	Before schedule, set selector to 0x2
# 	other thread: ARCH_SET_GS(0x0) -- sel is 0x0
# [OK]	GS/BASE remained 0x2/0x0
# [RUN]	ARCH_SET_GS(0x200000000), then schedule to 0x0
# 	Before schedule, set selector to 0x3
# 	other thread: ARCH_SET_GS(0x0) -- sel is 0x0
# [OK]	GS/BASE remained 0x3/0x0
# [RUN]	ARCH_SET_GS(0x200000000), then schedule to 0x0
# 	Before schedule, set selector to 0x2b
# 	other thread: ARCH_SET_GS(0x0) -- sel is 0x0
# [OK]	GS/BASE remained 0x2b/0x0
# [RUN]	ARCH_SET_GS(0x200000000), then schedule to 0xa1fa5f343cb85fa4
# 	other thread: ARCH_SET_GS(0x0) and clear gs -- sel is 0x0
# [OK]	GS/BASE remained 0x0/0x200000000
# [RUN]	ARCH_SET_GS(0x200000000), then schedule to 0xa1fa5f343cb85fa4
# 	Before schedule, set selector to 0x1
# 	other thread: ARCH_SET_GS(0x0) and clear gs -- sel is 0x0
# [OK]	GS/BASE remained 0x1/0x0
# [RUN]	ARCH_SET_GS(0x200000000), then schedule to 0xa1fa5f343cb85fa4
# 	Before schedule, set selector to 0x2
# 	other thread: ARCH_SET_GS(0x0) and clear gs -- sel is 0x0
# [OK]	GS/BASE remained 0x2/0x0
# [RUN]	ARCH_SET_GS(0x200000000), then schedule to 0xa1fa5f343cb85fa4
# 	Before schedule, set selector to 0x3
# 	other thread: ARCH_SET_GS(0x0) and clear gs -- sel is 0x0
# [OK]	GS/BASE remained 0x3/0x0
# [RUN]	ARCH_SET_GS(0x200000000), then schedule to 0xa1fa5f343cb85fa4
# 	Before schedule, set selector to 0x2b
# 	other thread: ARCH_SET_GS(0x0) and clear gs -- sel is 0x0
# [OK]	GS/BASE remained 0x2b/0x0
# [RUN]	ARCH_SET_GS(0x200000000), then schedule to 0x1
# 	other thread: ARCH_SET_GS(0x1) -- sel is 0x0
# [OK]	GS/BASE remained 0x0/0x200000000
# [RUN]	ARCH_SET_GS(0x200000000), then schedule to 0x1
# 	Before schedule, set selector to 0x1
# 	other thread: ARCH_SET_GS(0x1) -- sel is 0x0
# [OK]	GS/BASE remained 0x1/0x0
# [RUN]	ARCH_SET_GS(0x200000000), then schedule to 0x1
# 	Before schedule, set selector to 0x2
# 	other thread: ARCH_SET_GS(0x1) -- sel is 0x0
# [OK]	GS/BASE remained 0x2/0x0
# [RUN]	ARCH_SET_GS(0x200000000), then schedule to 0x1
# 	Before schedule, set selector to 0x3
# 	other thread: ARCH_SET_GS(0x1) -- sel is 0x0
# [OK]	GS/BASE remained 0x3/0x0
# [RUN]	ARCH_SET_GS(0x200000000), then schedule to 0x1
# 	Before schedule, set selector to 0x2b
# 	other thread: ARCH_SET_GS(0x1) -- sel is 0x0
# [OK]	GS/BASE remained 0x2b/0x0
# [RUN]	ARCH_SET_GS(0x200000000), then schedule to 0x200000000
# 	other thread: ARCH_SET_GS(0x200000000) -- sel is 0x0
# [OK]	GS/BASE remained 0x0/0x200000000
# [RUN]	ARCH_SET_GS(0x200000000), then schedule to 0x200000000
# 	Before schedule, set selector to 0x1
# 	other thread: ARCH_SET_GS(0x200000000) -- sel is 0x0
# [OK]	GS/BASE remained 0x1/0x0
# [RUN]	ARCH_SET_GS(0x200000000), then schedule to 0x200000000
# 	Before schedule, set selector to 0x2
# 	other thread: ARCH_SET_GS(0x200000000) -- sel is 0x0
# [OK]	GS/BASE remained 0x2/0x0
# [RUN]	ARCH_SET_GS(0x200000000), then schedule to 0x200000000
# 	Before schedule, set selector to 0x3
# 	other thread: ARCH_SET_GS(0x200000000) -- sel is 0x0
# [OK]	GS/BASE remained 0x3/0x0
# [RUN]	ARCH_SET_GS(0x200000000), then schedule to 0x200000000
# 	Before schedule, set selector to 0x2b
# 	other thread: ARCH_SET_GS(0x200000000) -- sel is 0x0
# [OK]	GS/BASE remained 0x2b/0x0
# [RUN]	ARCH_SET_GS(0), clear gs, then manipulate GSBASE in a different thread
# 	using LDT slot 0
# [OK]	GSBASE remained 0
# [OK]	GS remained 0x7
ok 34 selftests: x86: fsgsbase_64
# selftests: x86: sysret_rip_64
# [RUN]	sigreturn to 0x800000000000
# [OK]	Got SIGSEGV at RIP=0x800000000000
# [RUN]	sigreturn to 0x1000000000000
# [OK]	Got SIGSEGV at RIP=0x1000000000000
# [RUN]	sigreturn to 0x2000000000000
# [OK]	Got SIGSEGV at RIP=0x2000000000000
# [RUN]	sigreturn to 0x4000000000000
# [OK]	Got SIGSEGV at RIP=0x4000000000000
# [RUN]	sigreturn to 0x8000000000000
# [OK]	Got SIGSEGV at RIP=0x8000000000000
# [RUN]	sigreturn to 0x10000000000000
# [OK]	Got SIGSEGV at RIP=0x10000000000000
# [RUN]	sigreturn to 0x20000000000000
# [OK]	Got SIGSEGV at RIP=0x20000000000000
# [RUN]	sigreturn to 0x40000000000000
# [OK]	Got SIGSEGV at RIP=0x40000000000000
# [RUN]	sigreturn to 0x80000000000000
# [OK]	Got SIGSEGV at RIP=0x80000000000000
# [RUN]	sigreturn to 0x100000000000000
# [OK]	Got SIGSEGV at RIP=0x100000000000000
# [RUN]	sigreturn to 0x200000000000000
# [OK]	Got SIGSEGV at RIP=0x200000000000000
# [RUN]	sigreturn to 0x400000000000000
# [OK]	Got SIGSEGV at RIP=0x400000000000000
# [RUN]	sigreturn to 0x800000000000000
# [OK]	Got SIGSEGV at RIP=0x800000000000000
# [RUN]	sigreturn to 0x1000000000000000
# [OK]	Got SIGSEGV at RIP=0x1000000000000000
# [RUN]	sigreturn to 0x2000000000000000
# [OK]	Got SIGSEGV at RIP=0x2000000000000000
# [RUN]	sigreturn to 0x4000000000000000
# [OK]	Got SIGSEGV at RIP=0x4000000000000000
# [RUN]	sigreturn to 0x8000000000000000
# [OK]	Got SIGSEGV at RIP=0x8000000000000000
# [RUN]	Trying a SYSCALL that falls through to 0x7fffffffe000
# [OK]	We survived
# [RUN]	Trying a SYSCALL that falls through to 0x7ffffffff000
# [OK]	We survived
# [RUN]	Trying a SYSCALL that falls through to 0x800000000000
# [OK]	mremap to 0x7ffffffff000 failed
# [RUN]	Trying a SYSCALL that falls through to 0xfffffffff000
# [OK]	mremap to 0xffffffffe000 failed
# [RUN]	Trying a SYSCALL that falls through to 0x1000000000000
# [OK]	mremap to 0xfffffffff000 failed
# [RUN]	Trying a SYSCALL that falls through to 0x1fffffffff000
# [OK]	mremap to 0x1ffffffffe000 failed
# [RUN]	Trying a SYSCALL that falls through to 0x2000000000000
# [OK]	mremap to 0x1fffffffff000 failed
# [RUN]	Trying a SYSCALL that falls through to 0x3fffffffff000
# [OK]	mremap to 0x3ffffffffe000 failed
# [RUN]	Trying a SYSCALL that falls through to 0x4000000000000
# [OK]	mremap to 0x3fffffffff000 failed
# [RUN]	Trying a SYSCALL that falls through to 0x7fffffffff000
# [OK]	mremap to 0x7ffffffffe000 failed
# [RUN]	Trying a SYSCALL that falls through to 0x8000000000000
# [OK]	mremap to 0x7fffffffff000 failed
# [RUN]	Trying a SYSCALL that falls through to 0xffffffffff000
# [OK]	mremap to 0xfffffffffe000 failed
# [RUN]	Trying a SYSCALL that falls through to 0x10000000000000
# [OK]	mremap to 0xffffffffff000 failed
# [RUN]	Trying a SYSCALL that falls through to 0x1ffffffffff000
# [OK]	mremap to 0x1fffffffffe000 failed
# [RUN]	Trying a SYSCALL that falls through to 0x20000000000000
# [OK]	mremap to 0x1ffffffffff000 failed
# [RUN]	Trying a SYSCALL that falls through to 0x3ffffffffff000
# [OK]	mremap to 0x3fffffffffe000 failed
# [RUN]	Trying a SYSCALL that falls through to 0x40000000000000
# [OK]	mremap to 0x3ffffffffff000 failed
# [RUN]	Trying a SYSCALL that falls through to 0x7ffffffffff000
# [OK]	mremap to 0x7fffffffffe000 failed
# [RUN]	Trying a SYSCALL that falls through to 0x80000000000000
# [OK]	mremap to 0x7ffffffffff000 failed
# [RUN]	Trying a SYSCALL that falls through to 0xfffffffffff000
# [OK]	mremap to 0xffffffffffe000 failed
# [RUN]	Trying a SYSCALL that falls through to 0x100000000000000
# [OK]	mremap to 0xfffffffffff000 failed
# [RUN]	Trying a SYSCALL that falls through to 0x1fffffffffff000
# [OK]	mremap to 0x1ffffffffffe000 failed
# [RUN]	Trying a SYSCALL that falls through to 0x200000000000000
# [OK]	mremap to 0x1fffffffffff000 failed
# [RUN]	Trying a SYSCALL that falls through to 0x3fffffffffff000
# [OK]	mremap to 0x3ffffffffffe000 failed
# [RUN]	Trying a SYSCALL that falls through to 0x400000000000000
# [OK]	mremap to 0x3fffffffffff000 failed
# [RUN]	Trying a SYSCALL that falls through to 0x7fffffffffff000
# [OK]	mremap to 0x7ffffffffffe000 failed
# [RUN]	Trying a SYSCALL that falls through to 0x800000000000000
# [OK]	mremap to 0x7fffffffffff000 failed
# [RUN]	Trying a SYSCALL that falls through to 0xffffffffffff000
# [OK]	mremap to 0xfffffffffffe000 failed
# [RUN]	Trying a SYSCALL that falls through to 0x1000000000000000
# [OK]	mremap to 0xffffffffffff000 failed
# [RUN]	Trying a SYSCALL that falls through to 0x1ffffffffffff000
# [OK]	mremap to 0x1fffffffffffe000 failed
# [RUN]	Trying a SYSCALL that falls through to 0x2000000000000000
# [OK]	mremap to 0x1ffffffffffff000 failed
# [RUN]	Trying a SYSCALL that falls through to 0x3ffffffffffff000
# [OK]	mremap to 0x3fffffffffffe000 failed
# [RUN]	Trying a SYSCALL that falls through to 0x4000000000000000
# [OK]	mremap to 0x3ffffffffffff000 failed
# [RUN]	Trying a SYSCALL that falls through to 0x7ffffffffffff000
# [OK]	mremap to 0x7fffffffffffe000 failed
# [RUN]	Trying a SYSCALL that falls through to 0x8000000000000000
# [OK]	mremap to 0x7ffffffffffff000 failed
ok 35 selftests: x86: sysret_rip_64
# selftests: x86: syscall_numbering_64
# [RUN]   Checking for x32 by calling x32 getpid()
# [INFO]      x32 is not supported
# [RUN]   Running tests without ptrace...
# [RUN]       Checking system calls with msb = 0 (0x0)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall 0:0 returned 0 as expected
# [OK]                x64 syscall 0:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall 0:19 returned 0 as expected
# [OK]                x64 syscall 0:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls 0:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall 0:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls 0:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls 0:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls 0:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls 0:0..999 returned -ENOSYS as expected
# [RUN]       Checking system calls with msb = 1 (0x1)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall 1:0 returned 0 as expected
# [OK]                x64 syscall 1:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall 1:19 returned 0 as expected
# [OK]                x64 syscall 1:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls 1:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall 1:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls 1:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls 1:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls 1:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls 1:0..999 returned -ENOSYS as expected
# [RUN]       Checking system calls with msb = -1 (0xffffffff)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall -1:0 returned 0 as expected
# [OK]                x64 syscall -1:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall -1:19 returned 0 as expected
# [OK]                x64 syscall -1:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls -1:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall -1:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls -1:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls -1:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls -1:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls -1:0..999 returned -ENOSYS as expected
# [RUN]       Checking system calls with msb = 1073741823 (0x3fffffff)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall 1073741823:0 returned 0 as expected
# [OK]                x64 syscall 1073741823:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall 1073741823:19 returned 0 as expected
# [OK]                x64 syscall 1073741823:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls 1073741823:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall 1073741823:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls 1073741823:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls 1073741823:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls 1073741823:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls 1073741823:0..999 returned -ENOSYS as expected
# [RUN]       Checking system calls with msb = 1073741824 (0x40000000)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall 1073741824:0 returned 0 as expected
# [OK]                x64 syscall 1073741824:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall 1073741824:19 returned 0 as expected
# [OK]                x64 syscall 1073741824:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls 1073741824:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall 1073741824:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls 1073741824:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls 1073741824:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls 1073741824:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls 1073741824:0..999 returned -ENOSYS as expected
# [RUN]       Checking system calls with msb = 1073741823 (0x3fffffff)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall 1073741823:0 returned 0 as expected
# [OK]                x64 syscall 1073741823:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall 1073741823:19 returned 0 as expected
# [OK]                x64 syscall 1073741823:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls 1073741823:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall 1073741823:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls 1073741823:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls 1073741823:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls 1073741823:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls 1073741823:0..999 returned -ENOSYS as expected
# [RUN]       Checking system calls with msb = -1073741824 (0xc0000000)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall -1073741824:0 returned 0 as expected
# [OK]                x64 syscall -1073741824:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall -1073741824:19 returned 0 as expected
# [OK]                x64 syscall -1073741824:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls -1073741824:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall -1073741824:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls -1073741824:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls -1073741824:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls -1073741824:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls -1073741824:0..999 returned -ENOSYS as expected
# [RUN]       Checking system calls with msb = 2147483647 (0x7fffffff)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall 2147483647:0 returned 0 as expected
# [OK]                x64 syscall 2147483647:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall 2147483647:19 returned 0 as expected
# [OK]                x64 syscall 2147483647:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls 2147483647:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall 2147483647:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls 2147483647:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls 2147483647:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls 2147483647:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls 2147483647:0..999 returned -ENOSYS as expected
# [RUN]       Checking system calls with msb = -2147483648 (0x80000000)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall -2147483648:0 returned 0 as expected
# [OK]                x64 syscall -2147483648:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall -2147483648:19 returned 0 as expected
# [OK]                x64 syscall -2147483648:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls -2147483648:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall -2147483648:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls -2147483648:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls -2147483648:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls -2147483648:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls -2147483648:0..999 returned -ENOSYS as expected
# [RUN]       Checking system calls with msb = -2147483647 (0x80000001)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall -2147483647:0 returned 0 as expected
# [OK]                x64 syscall -2147483647:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall -2147483647:19 returned 0 as expected
# [OK]                x64 syscall -2147483647:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls -2147483647:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall -2147483647:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls -2147483647:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls -2147483647:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls -2147483647:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls -2147483647:0..999 returned -ENOSYS as expected
# [RUN]   Running tests under ptrace: just stop, no data read
# [RUN]       Checking system calls with msb = 0 (0x0)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall 0:0 returned 0 as expected
# [OK]                x64 syscall 0:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall 0:19 returned 0 as expected
# [OK]                x64 syscall 0:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls 0:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall 0:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls 0:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls 0:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls 0:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls 0:0..999 returned -ENOSYS as expected
# [RUN]       Checking system calls with msb = 1 (0x1)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall 1:0 returned 0 as expected
# [OK]                x64 syscall 1:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall 1:19 returned 0 as expected
# [OK]                x64 syscall 1:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls 1:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall 1:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls 1:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls 1:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls 1:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls 1:0..999 returned -ENOSYS as expected
# [RUN]       Checking system calls with msb = -1 (0xffffffff)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall -1:0 returned 0 as expected
# [OK]                x64 syscall -1:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall -1:19 returned 0 as expected
# [OK]                x64 syscall -1:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls -1:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall -1:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls -1:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls -1:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls -1:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls -1:0..999 returned -ENOSYS as expected
# [RUN]       Checking system calls with msb = 1073741823 (0x3fffffff)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall 1073741823:0 returned 0 as expected
# [OK]                x64 syscall 1073741823:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall 1073741823:19 returned 0 as expected
# [OK]                x64 syscall 1073741823:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls 1073741823:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall 1073741823:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls 1073741823:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls 1073741823:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls 1073741823:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls 1073741823:0..999 returned -ENOSYS as expected
# [RUN]       Checking system calls with msb = 1073741824 (0x40000000)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall 1073741824:0 returned 0 as expected
# [OK]                x64 syscall 1073741824:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall 1073741824:19 returned 0 as expected
# [OK]                x64 syscall 1073741824:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls 1073741824:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall 1073741824:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls 1073741824:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls 1073741824:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls 1073741824:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls 1073741824:0..999 returned -ENOSYS as expected
# [RUN]       Checking system calls with msb = 1073741823 (0x3fffffff)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall 1073741823:0 returned 0 as expected
# [OK]                x64 syscall 1073741823:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall 1073741823:19 returned 0 as expected
# [OK]                x64 syscall 1073741823:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls 1073741823:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall 1073741823:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls 1073741823:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls 1073741823:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls 1073741823:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls 1073741823:0..999 returned -ENOSYS as expected
# [RUN]       Checking system calls with msb = -1073741824 (0xc0000000)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall -1073741824:0 returned 0 as expected
# [OK]                x64 syscall -1073741824:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall -1073741824:19 returned 0 as expected
# [OK]                x64 syscall -1073741824:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls -1073741824:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall -1073741824:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls -1073741824:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls -1073741824:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls -1073741824:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls -1073741824:0..999 returned -ENOSYS as expected
# [RUN]       Checking system calls with msb = 2147483647 (0x7fffffff)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall 2147483647:0 returned 0 as expected
# [OK]                x64 syscall 2147483647:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall 2147483647:19 returned 0 as expected
# [OK]                x64 syscall 2147483647:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls 2147483647:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall 2147483647:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls 2147483647:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls 2147483647:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls 2147483647:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls 2147483647:0..999 returned -ENOSYS as expected
# [RUN]       Checking system calls with msb = -2147483648 (0x80000000)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall -2147483648:0 returned 0 as expected
# [OK]                x64 syscall -2147483648:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall -2147483648:19 returned 0 as expected
# [OK]                x64 syscall -2147483648:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls -2147483648:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall -2147483648:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls -2147483648:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls -2147483648:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls -2147483648:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls -2147483648:0..999 returned -ENOSYS as expected
# [RUN]       Checking system calls with msb = -2147483647 (0x80000001)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall -2147483647:0 returned 0 as expected
# [OK]                x64 syscall -2147483647:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall -2147483647:19 returned 0 as expected
# [OK]                x64 syscall -2147483647:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls -2147483647:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall -2147483647:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls -2147483647:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls -2147483647:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls -2147483647:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls -2147483647:0..999 returned -ENOSYS as expected
# [RUN]   Running tests under ptrace: only getregs
# [RUN]       Checking system calls with msb = 0 (0x0)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall 0:0 returned 0 as expected
# [OK]                x64 syscall 0:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall 0:19 returned 0 as expected
# [OK]                x64 syscall 0:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls 0:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall 0:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls 0:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls 0:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls 0:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls 0:0..999 returned -ENOSYS as expected
# [RUN]       Checking system calls with msb = 1 (0x1)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall 1:0 returned 0 as expected
# [OK]                x64 syscall 1:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall 1:19 returned 0 as expected
# [OK]                x64 syscall 1:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls 1:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall 1:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls 1:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls 1:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls 1:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls 1:0..999 returned -ENOSYS as expected
# [RUN]       Checking system calls with msb = -1 (0xffffffff)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall -1:0 returned 0 as expected
# [OK]                x64 syscall -1:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall -1:19 returned 0 as expected
# [OK]                x64 syscall -1:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls -1:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall -1:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls -1:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls -1:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls -1:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls -1:0..999 returned -ENOSYS as expected
# [RUN]       Checking system calls with msb = 1073741823 (0x3fffffff)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall 1073741823:0 returned 0 as expected
# [OK]                x64 syscall 1073741823:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall 1073741823:19 returned 0 as expected
# [OK]                x64 syscall 1073741823:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls 1073741823:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall 1073741823:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls 1073741823:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls 1073741823:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls 1073741823:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls 1073741823:0..999 returned -ENOSYS as expected
# [RUN]       Checking system calls with msb = 1073741824 (0x40000000)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall 1073741824:0 returned 0 as expected
# [OK]                x64 syscall 1073741824:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall 1073741824:19 returned 0 as expected
# [OK]                x64 syscall 1073741824:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls 1073741824:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall 1073741824:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls 1073741824:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls 1073741824:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls 1073741824:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls 1073741824:0..999 returned -ENOSYS as expected
# [RUN]       Checking system calls with msb = 1073741823 (0x3fffffff)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall 1073741823:0 returned 0 as expected
# [OK]                x64 syscall 1073741823:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall 1073741823:19 returned 0 as expected
# [OK]                x64 syscall 1073741823:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls 1073741823:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall 1073741823:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls 1073741823:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls 1073741823:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls 1073741823:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls 1073741823:0..999 returned -ENOSYS as expected
# [RUN]       Checking system calls with msb = -1073741824 (0xc0000000)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall -1073741824:0 returned 0 as expected
# [OK]                x64 syscall -1073741824:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall -1073741824:19 returned 0 as expected
# [OK]                x64 syscall -1073741824:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls -1073741824:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall -1073741824:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls -1073741824:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls -1073741824:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls -1073741824:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls -1073741824:0..999 returned -ENOSYS as expected
# [RUN]       Checking system calls with msb = 2147483647 (0x7fffffff)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall 2147483647:0 returned 0 as expected
# [OK]                x64 syscall 2147483647:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall 2147483647:19 returned 0 as expected
# [OK]                x64 syscall 2147483647:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls 2147483647:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall 2147483647:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls 2147483647:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls 2147483647:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls 2147483647:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls 2147483647:0..999 returned -ENOSYS as expected
# [RUN]       Checking system calls with msb = -2147483648 (0x80000000)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall -2147483648:0 returned 0 as expected
# [OK]                x64 syscall -2147483648:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall -2147483648:19 returned 0 as expected
# [OK]                x64 syscall -2147483648:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls -2147483648:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall -2147483648:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls -2147483648:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls -2147483648:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls -2147483648:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls -2147483648:0..999 returned -ENOSYS as expected
# [RUN]       Checking system calls with msb = -2147483647 (0x80000001)
# [RUN]           Checking some common syscalls as 64 bit
# [OK]                x64 syscall -2147483647:0 returned 0 as expected
# [OK]                x64 syscall -2147483647:1 returned 0 as expected
# [RUN]           Checking some 64-bit only syscalls as 64 bit
# [OK]                x64 syscall -2147483647:19 returned 0 as expected
# [OK]                x64 syscall -2147483647:20 returned 0 as expected
# [RUN]           Checking out of range system calls
# [OK]                x32 syscalls -2147483647:-64..-2 returned -ENOSYS as expected
# [OK]                x32 syscall -2147483647:-1 returned -ENOSYS as expected
# [OK]                x64 syscalls -2147483647:1073741760..1073741823 returned -ENOSYS as expected
# [OK]                x64 syscalls -2147483647:-64..-1 returned -ENOSYS as expected
# [OK]                x32 syscalls -2147483647:1073741759..1073741822 returned -ENOSYS as expected
# [RUN]           Checking for absence of x32 system calls
# [OK]                x32 syscalls -2147483647:0..999 returned -ENOSYS as expected
# [RUN]   Running tests under ptrace: getregs, unmodified setregs
# [RUN]       Checking system calls with msb = 0 (0x0)
# [RUN]           Checking some common syscalls as 64 bit
#
not ok 36 selftests: x86: syscall_numbering_64 # TIMEOUT 300 seconds
# selftests: x86: corrupt_xstate_header_64
# [RUN]	Send ourselves a signal
# 	Wreck XSTATE header
# 	Got SIGSEGV
# [OK]	Back from the signal.  Now schedule.
# [RUN]	Send ourselves a signal
# 	Wreck XSTATE header
# 	Got SIGSEGV
# [OK]	Back from the signal.  Now schedule.
# [OK]	Back in the main thread.
ok 37 selftests: x86: corrupt_xstate_header_64
# selftests: x86: amx_64
# amx_64: [FAIL]	xstate cpuid: invalid tile data size/offset: 0/0: Success
not ok 38 selftests: x86: amx_64 # exit=1
# selftests: x86: ldt_gdt_64
# [NOTE]	set_thread_area is available; will use GDT index 12
# [OK]	LDT entry 0 has AR 0x0040FB00 and limit 0x0000000A
# [OK]	LDT entry 0 has AR 0x00C0FB00 and limit 0x0000AFFF
# [OK]	LDT entry 1 is invalid
# [OK]	LDT entry 2 has AR 0x00C0FB00 and limit 0x0000AFFF
# [OK]	LDT entry 1 is invalid
# [OK]	LDT entry 2 has AR 0x00C0FB00 and limit 0x0000AFFF
# [OK]	LDT entry 2 has AR 0x00D0FB00 and limit 0x0000AFFF
# [OK]	LDT entry 2 has AR 0x00D07B00 and limit 0x0000AFFF
# [OK]	LDT entry 2 has AR 0x00907B00 and limit 0x0000AFFF
# [OK]	LDT entry 2 has AR 0x00D07300 and limit 0x0000AFFF
# [OK]	LDT entry 2 has AR 0x00D07100 and limit 0x0000AFFF
# [OK]	LDT entry 2 has AR 0x00D07500 and limit 0x0000AFFF
# [OK]	LDT entry 2 has AR 0x00507700 and limit 0x0000000A
# [OK]	LDT entry 2 has AR 0x00507F00 and limit 0x0000000A
# [OK]	LDT entry 2 has AR 0x00507D00 and limit 0x0000000A
# [OK]	LDT entry 2 has AR 0x00507B00 and limit 0x0000000A
# [OK]	LDT entry 2 has AR 0x00507900 and limit 0x0000000A
# [OK]	LDT entry 2 has AR 0x00507900 and limit 0x0000000A
# [RUN]	Test fork
# [OK]	LDT entry 2 has AR 0x00507900 and limit 0x0000000A
# [OK]	LDT entry 1 is invalid
# [OK]	LDT entry 0 is invalid
# [NOTE]	set_thread_area is available; will use GDT index 12
# [OK]	LDT entry 0 has AR 0x0040FB00 and limit 0x0000000A
# [OK]	LDT entry 0 has AR 0x00C0FB00 and limit 0x0000AFFF
# [OK]	LDT entry 1 is invalid
# [OK]	LDT entry 2 has AR 0x00C0FB00 and limit 0x0000AFFF
# [OK]	LDT entry 1 is invalid
# [OK]	LDT entry 2 has AR 0x00C0FB00 and limit 0x0000AFFF
# [OK]	LDT entry 2 has AR 0x00D0FB00 and limit 0x0000AFFF
# [OK]	LDT entry 2 has AR 0x00D07B00 and limit 0x0000AFFF
# [OK]	LDT entry 2 has AR 0x00907B00 and limit 0x0000AFFF
# [OK]	LDT entry 2 has AR 0x00D07300 and limit 0x0000AFFF
# [OK]	LDT entry 2 has AR 0x00D07100 and limit 0x0000AFFF
# [OK]	LDT entry 2 has AR 0x00D07500 and limit 0x0000AFFF
# [OK]	LDT entry 2 has AR 0x00507700 and limit 0x0000000A
# [OK]	LDT entry 2 has AR 0x00507F00 and limit 0x0000000A
# [OK]	LDT entry 2 has AR 0x00507D00 and limit 0x0000000A
# [OK]	LDT entry 2 has AR 0x00507B00 and limit 0x0000000A
# [OK]	LDT entry 2 has AR 0x00507900 and limit 0x0000000A
# [OK]	LDT entry 2 has AR 0x00507900 and limit 0x0000000A
# [RUN]	Test fork
# [OK]	Child succeeded
# [RUN]	Test size
# [DONE]	Size test
# [OK]	modify_ldt failure 22
# [OK]	LDT entry 0 has AR 0x0000F300 and limit 0x00000000
# [OK]	LDT entry 0 has AR 0x00007300 and limit 0x00000000
# [OK]	LDT entry 0 has AR 0x0000F100 and limit 0x00000000
# [OK]	LDT entry 0 has AR 0x00007300 and limit 0x00000000
# [OK]	LDT entry 0 has AR 0x00007100 and limit 0x00000001
# [OK]	LDT entry 0 has AR 0x00007100 and limit 0x00000000
# [OK]	LDT entry 0 is invalid
# [OK]	LDT entry 0 has AR 0x0040F300 and limit 0x000FFFFF
# [OK]	LDT entry 0 has AR 0x00C0F300 and limit 0xFFFFFFFF
# [OK]	LDT entry 0 has AR 0x00C0F100 and limit 0xFFFFFFFF
# [OK]	LDT entry 0 has AR 0x00C0F700 and limit 0xFFFFFFFF
# [OK]	LDT entry 0 has AR 0x00C0F500 and limit 0xFFFFFFFF
# [OK]	LDT entry 0 is invalid
# [RUN]	Cross-CPU LDT invalidation
# [OK]	All 5 iterations succeeded
# [RUN]	Test exec
# [OK]	LDT entry 0 has AR 0x0040FB00 and limit 0x0000002A
# [OK]	Child succeeded
# [OK]	Invalidate DS with set_thread_area: new DS = 0x0
# [OK]	Invalidate ES with set_thread_area: new ES = 0x0
# [OK]	Invalidate FS with set_thread_area: new FS = 0x0
# [OK]	New FSBASE was zero
# [OK]	Invalidate GS with set_thread_area: new GS = 0x0
# [OK]	New GSBASE was zero
ok 39 selftests: x86: ldt_gdt_64
# selftests: x86: ptrace_syscall_64
# ptrace_syscall_64: PTRACE_SETREGS: Input/output error
# [RUN]	Check int80 return regs
# [OK]	getpid() preserves regs
# [OK]	kill(getpid(), SIGUSR1) preserves regs
# [RUN]	ptrace-induced syscall restart
# [RUN]	SYSEMU
# [OK]	Initial nr and args are correct
# [RUN]	Restart the syscall (ip = 0x7f4fa21289b9)
not ok 40 selftests: x86: ptrace_syscall_64 # exit=1
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-9724330ed6ddddf7aae3a57ab04292e4c138eb3a/tools/testing/selftests/x86'

--c7ijwEYYO4C8FEwX--
