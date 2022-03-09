Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C49B4D3738
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 18:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237491AbiCIQtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 11:49:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238749AbiCIQbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 11:31:47 -0500
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAABE19F45C
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 08:26:19 -0800 (PST)
Received: from in02.mta.xmission.com ([166.70.13.52]:35978)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nRz8M-00CNCD-CD; Wed, 09 Mar 2022 09:25:54 -0700
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:34572 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nRz8K-005hAS-3I; Wed, 09 Mar 2022 09:25:53 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Gladkov <legion@kernel.org>,
        Kyle Huey <me@kylehuey.com>, Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Wed,  9 Mar 2022 10:24:53 -0600
Message-Id: <20220309162454.123006-12-ebiederm@xmission.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87o82gdlu9.fsf_-_@email.froward.int.ebiederm.org>
References: <87o82gdlu9.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1nRz8K-005hAS-3I;;;mid=<20220309162454.123006-12-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/DZBmZlHPYvEcDn+sLQh6UGakVTCDOGiQ=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Virus: No
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 1443 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 3.7 (0.3%), b_tie_ro: 2.6 (0.2%), parse: 1.70
        (0.1%), extract_message_metadata: 17 (1.2%), get_uri_detail_list: 9
        (0.6%), tests_pri_-1000: 10 (0.7%), tests_pri_-950: 1.15 (0.1%),
        tests_pri_-900: 0.85 (0.1%), tests_pri_-90: 168 (11.6%), check_bayes:
        166 (11.5%), b_tokenize: 38 (2.6%), b_tok_get_all: 14 (0.9%),
        b_comp_prob: 3.2 (0.2%), b_tok_touch_all: 107 (7.4%), b_finish: 0.85
        (0.1%), tests_pri_0: 1228 (85.1%), check_dkim_signature: 0.74 (0.1%),
        check_dkim_adsp: 3.2 (0.2%), poll_dns_idle: 1.83 (0.1%), tests_pri_10:
        1.81 (0.1%), tests_pri_500: 7 (0.5%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 12/13] resume_user_mode: Move to resume_user_mode.h
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move set_notify_resume and tracehook_notify_resume into resume_user_mode.h.
While doing that rename tracehook_notify_resume to resume_user_mode_work.

Update all of the places that included tracehook.h for these functions to
include resume_user_mode.h instead.

Update all of the callers of tracehook_notify_resume to call
resume_user_mode_work.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/Kconfig                     |  2 +-
 arch/alpha/kernel/signal.c       |  4 +-
 arch/arc/kernel/signal.c         |  4 +-
 arch/arm/kernel/signal.c         |  4 +-
 arch/arm64/kernel/signal.c       |  4 +-
 arch/csky/kernel/signal.c        |  4 +-
 arch/h8300/kernel/signal.c       |  4 +-
 arch/hexagon/kernel/process.c    |  4 +-
 arch/hexagon/kernel/signal.c     |  1 -
 arch/ia64/kernel/process.c       |  4 +-
 arch/ia64/kernel/ptrace.c        |  2 +-
 arch/ia64/kernel/signal.c        |  1 -
 arch/m68k/kernel/signal.c        |  4 +-
 arch/microblaze/kernel/signal.c  |  4 +-
 arch/mips/kernel/signal.c        |  4 +-
 arch/nds32/kernel/signal.c       |  4 +-
 arch/nios2/kernel/signal.c       |  4 +-
 arch/openrisc/kernel/signal.c    |  4 +-
 arch/parisc/kernel/signal.c      |  4 +-
 arch/powerpc/kernel/signal.c     |  4 +-
 arch/riscv/kernel/signal.c       |  4 +-
 arch/sh/kernel/signal_32.c       |  4 +-
 arch/sparc/kernel/signal32.c     |  1 -
 arch/sparc/kernel/signal_32.c    |  4 +-
 arch/sparc/kernel/signal_64.c    |  4 +-
 arch/um/kernel/process.c         |  4 +-
 arch/xtensa/kernel/signal.c      |  4 +-
 block/blk-cgroup.c               |  2 +-
 include/linux/entry-kvm.h        |  2 +-
 include/linux/resume_user_mode.h | 64 ++++++++++++++++++++++++++++++++
 include/linux/tracehook.h        | 51 -------------------------
 kernel/entry/common.c            |  4 +-
 kernel/entry/kvm.c               |  2 +-
 kernel/task_work.c               |  2 +-
 mm/memcontrol.c                  |  2 +-
 35 files changed, 117 insertions(+), 107 deletions(-)
 create mode 100644 include/linux/resume_user_mode.h

diff --git a/arch/Kconfig b/arch/Kconfig
index 6382520ef0a5..2e3979c3d66d 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -218,7 +218,7 @@ config TRACE_IRQFLAGS_SUPPORT
 #	linux/regset.h		user_regset interfaces
 #	CORE_DUMP_USE_REGSET	#define'd in linux/elf.h
 #	TIF_SYSCALL_TRACE	calls ptrace_report_syscall_{entry,exit}
-#	TIF_NOTIFY_RESUME	calls tracehook_notify_resume()
+#	TIF_NOTIFY_RESUME	calls resume_user_mode_work()
 #
 config HAVE_ARCH_TRACEHOOK
 	bool
diff --git a/arch/alpha/kernel/signal.c b/arch/alpha/kernel/signal.c
index d8ed71d5bed3..6f47f256fe80 100644
--- a/arch/alpha/kernel/signal.c
+++ b/arch/alpha/kernel/signal.c
@@ -22,7 +22,7 @@
 #include <linux/binfmts.h>
 #include <linux/bitops.h>
 #include <linux/syscalls.h>
-#include <linux/tracehook.h>
+#include <linux/resume_user_mode.h>
 
 #include <linux/uaccess.h>
 #include <asm/sigcontext.h>
@@ -531,7 +531,7 @@ do_work_pending(struct pt_regs *regs, unsigned long thread_flags,
 				do_signal(regs, r0, r19);
 				r0 = 0;
 			} else {
-				tracehook_notify_resume(regs);
+				resume_user_mode_work(regs);
 			}
 		}
 		local_irq_disable();
diff --git a/arch/arc/kernel/signal.c b/arch/arc/kernel/signal.c
index cb2f88502baf..f748483628f2 100644
--- a/arch/arc/kernel/signal.c
+++ b/arch/arc/kernel/signal.c
@@ -49,7 +49,7 @@
 #include <linux/personality.h>
 #include <linux/uaccess.h>
 #include <linux/syscalls.h>
-#include <linux/tracehook.h>
+#include <linux/resume_user_mode.h>
 #include <linux/sched/task_stack.h>
 
 #include <asm/ucontext.h>
@@ -438,5 +438,5 @@ void do_notify_resume(struct pt_regs *regs)
 	 * user mode
 	 */
 	if (test_thread_flag(TIF_NOTIFY_RESUME))
-		tracehook_notify_resume(regs);
+		resume_user_mode_work(regs);
 }
diff --git a/arch/arm/kernel/signal.c b/arch/arm/kernel/signal.c
index c532a6041066..459abc5d1819 100644
--- a/arch/arm/kernel/signal.c
+++ b/arch/arm/kernel/signal.c
@@ -9,7 +9,7 @@
 #include <linux/signal.h>
 #include <linux/personality.h>
 #include <linux/uaccess.h>
-#include <linux/tracehook.h>
+#include <linux/resume_user_mode.h>
 #include <linux/uprobes.h>
 #include <linux/syscalls.h>
 
@@ -627,7 +627,7 @@ do_work_pending(struct pt_regs *regs, unsigned int thread_flags, int syscall)
 			} else if (thread_flags & _TIF_UPROBE) {
 				uprobe_notify_resume(regs);
 			} else {
-				tracehook_notify_resume(regs);
+				resume_user_mode_work(regs);
 			}
 		}
 		local_irq_disable();
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index d8aaf4b6f432..413c51de9d10 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -17,7 +17,7 @@
 #include <linux/uaccess.h>
 #include <linux/sizes.h>
 #include <linux/string.h>
-#include <linux/tracehook.h>
+#include <linux/resume_user_mode.h>
 #include <linux/ratelimit.h>
 #include <linux/syscalls.h>
 
@@ -941,7 +941,7 @@ void do_notify_resume(struct pt_regs *regs, unsigned long thread_flags)
 				do_signal(regs);
 
 			if (thread_flags & _TIF_NOTIFY_RESUME)
-				tracehook_notify_resume(regs);
+				resume_user_mode_work(regs);
 
 			if (thread_flags & _TIF_FOREIGN_FPSTATE)
 				fpsimd_restore_current_state();
diff --git a/arch/csky/kernel/signal.c b/arch/csky/kernel/signal.c
index c7b763d2f526..7a3149a27e4d 100644
--- a/arch/csky/kernel/signal.c
+++ b/arch/csky/kernel/signal.c
@@ -3,7 +3,7 @@
 #include <linux/signal.h>
 #include <linux/uaccess.h>
 #include <linux/syscalls.h>
-#include <linux/tracehook.h>
+#include <linux/resume_user_mode.h>
 
 #include <asm/traps.h>
 #include <asm/ucontext.h>
@@ -265,5 +265,5 @@ asmlinkage void do_notify_resume(struct pt_regs *regs,
 		do_signal(regs);
 
 	if (thread_info_flags & _TIF_NOTIFY_RESUME)
-		tracehook_notify_resume(regs);
+		resume_user_mode_work(regs);
 }
diff --git a/arch/h8300/kernel/signal.c b/arch/h8300/kernel/signal.c
index 75a1c36b105a..0716fc8a8ce2 100644
--- a/arch/h8300/kernel/signal.c
+++ b/arch/h8300/kernel/signal.c
@@ -39,7 +39,7 @@
 #include <linux/personality.h>
 #include <linux/tty.h>
 #include <linux/binfmts.h>
-#include <linux/tracehook.h>
+#include <linux/resume_user_mode.h>
 
 #include <asm/setup.h>
 #include <linux/uaccess.h>
@@ -283,5 +283,5 @@ asmlinkage void do_notify_resume(struct pt_regs *regs, u32 thread_info_flags)
 		do_signal(regs);
 
 	if (thread_info_flags & _TIF_NOTIFY_RESUME)
-		tracehook_notify_resume(regs);
+		resume_user_mode_work(regs);
 }
diff --git a/arch/hexagon/kernel/process.c b/arch/hexagon/kernel/process.c
index 232dfd8956aa..ae3f728eeca0 100644
--- a/arch/hexagon/kernel/process.c
+++ b/arch/hexagon/kernel/process.c
@@ -14,7 +14,7 @@
 #include <linux/tick.h>
 #include <linux/uaccess.h>
 #include <linux/slab.h>
-#include <linux/tracehook.h>
+#include <linux/resume_user_mode.h>
 
 /*
  * Program thread launch.  Often defined as a macro in processor.h,
@@ -178,7 +178,7 @@ int do_work_pending(struct pt_regs *regs, u32 thread_info_flags)
 	}
 
 	if (thread_info_flags & _TIF_NOTIFY_RESUME) {
-		tracehook_notify_resume(regs);
+		resume_user_mode_work(regs);
 		return 1;
 	}
 
diff --git a/arch/hexagon/kernel/signal.c b/arch/hexagon/kernel/signal.c
index 94cc7ff52dce..bcba31e9e0ae 100644
--- a/arch/hexagon/kernel/signal.c
+++ b/arch/hexagon/kernel/signal.c
@@ -7,7 +7,6 @@
 
 #include <linux/linkage.h>
 #include <linux/syscalls.h>
-#include <linux/tracehook.h>
 #include <linux/sched/task_stack.h>
 
 #include <asm/registers.h>
diff --git a/arch/ia64/kernel/process.c b/arch/ia64/kernel/process.c
index 834df24a88f1..d7a256bd9d6b 100644
--- a/arch/ia64/kernel/process.c
+++ b/arch/ia64/kernel/process.c
@@ -32,7 +32,7 @@
 #include <linux/delay.h>
 #include <linux/kdebug.h>
 #include <linux/utsname.h>
-#include <linux/tracehook.h>
+#include <linux/resume_user_mode.h>
 #include <linux/rcupdate.h>
 
 #include <asm/cpu.h>
@@ -179,7 +179,7 @@ do_notify_resume_user(sigset_t *unused, struct sigscratch *scr, long in_syscall)
 
 	if (test_thread_flag(TIF_NOTIFY_RESUME)) {
 		local_irq_enable();	/* force interrupt enable */
-		tracehook_notify_resume(&scr->pt);
+		resume_user_mode_work(&scr->pt);
 	}
 
 	/* copy user rbs to kernel rbs */
diff --git a/arch/ia64/kernel/ptrace.c b/arch/ia64/kernel/ptrace.c
index 6af64aae087d..a19acd9f5e1f 100644
--- a/arch/ia64/kernel/ptrace.c
+++ b/arch/ia64/kernel/ptrace.c
@@ -23,7 +23,7 @@
 #include <linux/signal.h>
 #include <linux/regset.h>
 #include <linux/elf.h>
-#include <linux/tracehook.h>
+#include <linux/resume_user_mode.h>
 
 #include <asm/processor.h>
 #include <asm/ptrace_offsets.h>
diff --git a/arch/ia64/kernel/signal.c b/arch/ia64/kernel/signal.c
index c1b299760bf7..51cf6a7ec158 100644
--- a/arch/ia64/kernel/signal.c
+++ b/arch/ia64/kernel/signal.c
@@ -12,7 +12,6 @@
 #include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/ptrace.h>
-#include <linux/tracehook.h>
 #include <linux/sched.h>
 #include <linux/signal.h>
 #include <linux/smp.h>
diff --git a/arch/m68k/kernel/signal.c b/arch/m68k/kernel/signal.c
index 338817d0cb3f..49533f65958a 100644
--- a/arch/m68k/kernel/signal.c
+++ b/arch/m68k/kernel/signal.c
@@ -43,7 +43,7 @@
 #include <linux/tty.h>
 #include <linux/binfmts.h>
 #include <linux/extable.h>
-#include <linux/tracehook.h>
+#include <linux/resume_user_mode.h>
 
 #include <asm/setup.h>
 #include <linux/uaccess.h>
@@ -1109,5 +1109,5 @@ void do_notify_resume(struct pt_regs *regs)
 		do_signal(regs);
 
 	if (test_thread_flag(TIF_NOTIFY_RESUME))
-		tracehook_notify_resume(regs);
+		resume_user_mode_work(regs);
 }
diff --git a/arch/microblaze/kernel/signal.c b/arch/microblaze/kernel/signal.c
index 23e8a9336a29..561eb82d7af6 100644
--- a/arch/microblaze/kernel/signal.c
+++ b/arch/microblaze/kernel/signal.c
@@ -31,7 +31,7 @@
 #include <linux/personality.h>
 #include <linux/percpu.h>
 #include <linux/linkage.h>
-#include <linux/tracehook.h>
+#include <linux/resume_user_mode.h>
 #include <asm/entry.h>
 #include <asm/ucontext.h>
 #include <linux/uaccess.h>
@@ -311,5 +311,5 @@ asmlinkage void do_notify_resume(struct pt_regs *regs, int in_syscall)
 		do_signal(regs, in_syscall);
 
 	if (test_thread_flag(TIF_NOTIFY_RESUME))
-		tracehook_notify_resume(regs);
+		resume_user_mode_work(regs);
 }
diff --git a/arch/mips/kernel/signal.c b/arch/mips/kernel/signal.c
index 5bce782e694c..1a99f26bf99f 100644
--- a/arch/mips/kernel/signal.c
+++ b/arch/mips/kernel/signal.c
@@ -25,7 +25,7 @@
 #include <linux/compiler.h>
 #include <linux/syscalls.h>
 #include <linux/uaccess.h>
-#include <linux/tracehook.h>
+#include <linux/resume_user_mode.h>
 
 #include <asm/abi.h>
 #include <asm/asm.h>
@@ -916,7 +916,7 @@ asmlinkage void do_notify_resume(struct pt_regs *regs, void *unused,
 		do_signal(regs);
 
 	if (thread_info_flags & _TIF_NOTIFY_RESUME)
-		tracehook_notify_resume(regs);
+		resume_user_mode_work(regs);
 
 	user_enter();
 }
diff --git a/arch/nds32/kernel/signal.c b/arch/nds32/kernel/signal.c
index 7e3ca430a223..551caef595cb 100644
--- a/arch/nds32/kernel/signal.c
+++ b/arch/nds32/kernel/signal.c
@@ -6,7 +6,7 @@
 #include <linux/ptrace.h>
 #include <linux/personality.h>
 #include <linux/freezer.h>
-#include <linux/tracehook.h>
+#include <linux/resume_user_mode.h>
 #include <linux/uaccess.h>
 
 #include <asm/cacheflush.h>
@@ -380,5 +380,5 @@ do_notify_resume(struct pt_regs *regs, unsigned int thread_flags)
 		do_signal(regs);
 
 	if (thread_flags & _TIF_NOTIFY_RESUME)
-		tracehook_notify_resume(regs);
+		resume_user_mode_work(regs);
 }
diff --git a/arch/nios2/kernel/signal.c b/arch/nios2/kernel/signal.c
index 2009ae2d3c3b..530b60c99545 100644
--- a/arch/nios2/kernel/signal.c
+++ b/arch/nios2/kernel/signal.c
@@ -15,7 +15,7 @@
 #include <linux/uaccess.h>
 #include <linux/unistd.h>
 #include <linux/personality.h>
-#include <linux/tracehook.h>
+#include <linux/resume_user_mode.h>
 
 #include <asm/ucontext.h>
 #include <asm/cacheflush.h>
@@ -319,7 +319,7 @@ asmlinkage int do_notify_resume(struct pt_regs *regs)
 			return restart;
 		}
 	} else if (test_thread_flag(TIF_NOTIFY_RESUME))
-		tracehook_notify_resume(regs);
+		resume_user_mode_work(regs);
 
 	return 0;
 }
diff --git a/arch/openrisc/kernel/signal.c b/arch/openrisc/kernel/signal.c
index 92c5b70740f5..80f69740c731 100644
--- a/arch/openrisc/kernel/signal.c
+++ b/arch/openrisc/kernel/signal.c
@@ -21,7 +21,7 @@
 #include <linux/ptrace.h>
 #include <linux/unistd.h>
 #include <linux/stddef.h>
-#include <linux/tracehook.h>
+#include <linux/resume_user_mode.h>
 
 #include <asm/processor.h>
 #include <asm/syscall.h>
@@ -309,7 +309,7 @@ do_work_pending(struct pt_regs *regs, unsigned int thread_flags, int syscall)
 				}
 				syscall = 0;
 			} else {
-				tracehook_notify_resume(regs);
+				resume_user_mode_work(regs);
 			}
 		}
 		local_irq_disable();
diff --git a/arch/parisc/kernel/signal.c b/arch/parisc/kernel/signal.c
index 46b1050640b8..2f7ebe9add20 100644
--- a/arch/parisc/kernel/signal.c
+++ b/arch/parisc/kernel/signal.c
@@ -22,7 +22,7 @@
 #include <linux/errno.h>
 #include <linux/wait.h>
 #include <linux/ptrace.h>
-#include <linux/tracehook.h>
+#include <linux/resume_user_mode.h>
 #include <linux/unistd.h>
 #include <linux/stddef.h>
 #include <linux/compat.h>
@@ -602,5 +602,5 @@ void do_notify_resume(struct pt_regs *regs, long in_syscall)
 		do_signal(regs, in_syscall);
 
 	if (test_thread_flag(TIF_NOTIFY_RESUME))
-		tracehook_notify_resume(regs);
+		resume_user_mode_work(regs);
 }
diff --git a/arch/powerpc/kernel/signal.c b/arch/powerpc/kernel/signal.c
index b93b87df499d..f7f8620663c7 100644
--- a/arch/powerpc/kernel/signal.c
+++ b/arch/powerpc/kernel/signal.c
@@ -9,7 +9,7 @@
  * this archive for more details.
  */
 
-#include <linux/tracehook.h>
+#include <linux/resume_user_mode.h>
 #include <linux/signal.h>
 #include <linux/uprobes.h>
 #include <linux/key.h>
@@ -294,7 +294,7 @@ void do_notify_resume(struct pt_regs *regs, unsigned long thread_info_flags)
 	}
 
 	if (thread_info_flags & _TIF_NOTIFY_RESUME)
-		tracehook_notify_resume(regs);
+		resume_user_mode_work(regs);
 }
 
 static unsigned long get_tm_stackpointer(struct task_struct *tsk)
diff --git a/arch/riscv/kernel/signal.c b/arch/riscv/kernel/signal.c
index c2d5ecbe5526..d80bf5896c6f 100644
--- a/arch/riscv/kernel/signal.c
+++ b/arch/riscv/kernel/signal.c
@@ -9,7 +9,7 @@
 #include <linux/signal.h>
 #include <linux/uaccess.h>
 #include <linux/syscalls.h>
-#include <linux/tracehook.h>
+#include <linux/resume_user_mode.h>
 #include <linux/linkage.h>
 
 #include <asm/ucontext.h>
@@ -317,5 +317,5 @@ asmlinkage __visible void do_notify_resume(struct pt_regs *regs,
 		do_signal(regs);
 
 	if (thread_info_flags & _TIF_NOTIFY_RESUME)
-		tracehook_notify_resume(regs);
+		resume_user_mode_work(regs);
 }
diff --git a/arch/sh/kernel/signal_32.c b/arch/sh/kernel/signal_32.c
index dd3092911efa..90f495d35db2 100644
--- a/arch/sh/kernel/signal_32.c
+++ b/arch/sh/kernel/signal_32.c
@@ -25,7 +25,7 @@
 #include <linux/personality.h>
 #include <linux/binfmts.h>
 #include <linux/io.h>
-#include <linux/tracehook.h>
+#include <linux/resume_user_mode.h>
 #include <asm/ucontext.h>
 #include <linux/uaccess.h>
 #include <asm/cacheflush.h>
@@ -503,5 +503,5 @@ asmlinkage void do_notify_resume(struct pt_regs *regs, unsigned int save_r0,
 		do_signal(regs, save_r0);
 
 	if (thread_info_flags & _TIF_NOTIFY_RESUME)
-		tracehook_notify_resume(regs);
+		resume_user_mode_work(regs);
 }
diff --git a/arch/sparc/kernel/signal32.c b/arch/sparc/kernel/signal32.c
index 6cc124a3bb98..f9fe502b81c6 100644
--- a/arch/sparc/kernel/signal32.c
+++ b/arch/sparc/kernel/signal32.c
@@ -20,7 +20,6 @@
 #include <linux/binfmts.h>
 #include <linux/compat.h>
 #include <linux/bitops.h>
-#include <linux/tracehook.h>
 
 #include <linux/uaccess.h>
 #include <asm/ptrace.h>
diff --git a/arch/sparc/kernel/signal_32.c b/arch/sparc/kernel/signal_32.c
index ffab16369bea..80c89b362d8b 100644
--- a/arch/sparc/kernel/signal_32.c
+++ b/arch/sparc/kernel/signal_32.c
@@ -19,7 +19,7 @@
 #include <linux/smp.h>
 #include <linux/binfmts.h>	/* do_coredum */
 #include <linux/bitops.h>
-#include <linux/tracehook.h>
+#include <linux/resume_user_mode.h>
 
 #include <linux/uaccess.h>
 #include <asm/ptrace.h>
@@ -524,7 +524,7 @@ void do_notify_resume(struct pt_regs *regs, unsigned long orig_i0,
 	if (thread_info_flags & (_TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL))
 		do_signal(regs, orig_i0);
 	if (thread_info_flags & _TIF_NOTIFY_RESUME)
-		tracehook_notify_resume(regs);
+		resume_user_mode_work(regs);
 }
 
 asmlinkage int do_sys_sigstack(struct sigstack __user *ssptr,
diff --git a/arch/sparc/kernel/signal_64.c b/arch/sparc/kernel/signal_64.c
index 2a78d2af1265..8b9fc76cd3e0 100644
--- a/arch/sparc/kernel/signal_64.c
+++ b/arch/sparc/kernel/signal_64.c
@@ -15,7 +15,7 @@
 #include <linux/errno.h>
 #include <linux/wait.h>
 #include <linux/ptrace.h>
-#include <linux/tracehook.h>
+#include <linux/resume_user_mode.h>
 #include <linux/unistd.h>
 #include <linux/mm.h>
 #include <linux/tty.h>
@@ -552,7 +552,7 @@ void do_notify_resume(struct pt_regs *regs, unsigned long orig_i0, unsigned long
 	if (thread_info_flags & (_TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL))
 		do_signal(regs, orig_i0);
 	if (thread_info_flags & _TIF_NOTIFY_RESUME)
-		tracehook_notify_resume(regs);
+		resume_user_mode_work(regs);
 	user_enter();
 }
 
diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index 4a420778ed87..80504680be08 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -23,7 +23,7 @@
 #include <linux/seq_file.h>
 #include <linux/tick.h>
 #include <linux/threads.h>
-#include <linux/tracehook.h>
+#include <linux/resume_user_mode.h>
 #include <asm/current.h>
 #include <asm/mmu_context.h>
 #include <linux/uaccess.h>
@@ -104,7 +104,7 @@ void interrupt_end(void)
 	    test_thread_flag(TIF_NOTIFY_SIGNAL))
 		do_signal(regs);
 	if (test_thread_flag(TIF_NOTIFY_RESUME))
-		tracehook_notify_resume(regs);
+		resume_user_mode_work(regs);
 }
 
 int get_current_pid(void)
diff --git a/arch/xtensa/kernel/signal.c b/arch/xtensa/kernel/signal.c
index f6c949895b3e..6f68649e86ba 100644
--- a/arch/xtensa/kernel/signal.c
+++ b/arch/xtensa/kernel/signal.c
@@ -19,7 +19,7 @@
 #include <linux/errno.h>
 #include <linux/ptrace.h>
 #include <linux/personality.h>
-#include <linux/tracehook.h>
+#include <linux/resume_user_mode.h>
 #include <linux/sched/task_stack.h>
 
 #include <asm/ucontext.h>
@@ -511,5 +511,5 @@ void do_notify_resume(struct pt_regs *regs)
 		do_signal(regs);
 
 	if (test_thread_flag(TIF_NOTIFY_RESUME))
-		tracehook_notify_resume(regs);
+		resume_user_mode_work(regs);
 }
diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 650f7e27989f..4d8be1634bc6 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -28,7 +28,7 @@
 #include <linux/atomic.h>
 #include <linux/ctype.h>
 #include <linux/blk-cgroup.h>
-#include <linux/tracehook.h>
+#include <linux/resume_user_mode.h>
 #include <linux/psi.h>
 #include <linux/part_stat.h>
 #include "blk.h"
diff --git a/include/linux/entry-kvm.h b/include/linux/entry-kvm.h
index 07c878d6e323..6813171afccb 100644
--- a/include/linux/entry-kvm.h
+++ b/include/linux/entry-kvm.h
@@ -3,7 +3,7 @@
 #define __LINUX_ENTRYKVM_H
 
 #include <linux/static_call_types.h>
-#include <linux/tracehook.h>
+#include <linux/resume_user_mode.h>
 #include <linux/syscalls.h>
 #include <linux/seccomp.h>
 #include <linux/sched.h>
diff --git a/include/linux/resume_user_mode.h b/include/linux/resume_user_mode.h
new file mode 100644
index 000000000000..285189454449
--- /dev/null
+++ b/include/linux/resume_user_mode.h
@@ -0,0 +1,64 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef LINUX_RESUME_USER_MODE_H
+#define LINUX_RESUME_USER_MODE_H
+
+#include <linux/sched.h>
+#include <linux/task_work.h>
+#include <linux/memcontrol.h>
+#include <linux/blk-cgroup.h>
+
+/**
+ * set_notify_resume - cause resume_user_mode_work() to be called
+ * @task:		task that will call resume_user_mode_work()
+ *
+ * Calling this arranges that @task will call resume_user_mode_work()
+ * before returning to user mode.  If it's already running in user mode,
+ * it will enter the kernel and call resume_user_mode_work() soon.
+ * If it's blocked, it will not be woken.
+ */
+static inline void set_notify_resume(struct task_struct *task)
+{
+	if (!test_and_set_tsk_thread_flag(task, TIF_NOTIFY_RESUME))
+		kick_process(task);
+}
+
+
+/**
+ * resume_user_mode_work - Perform work before returning to user mode
+ * @regs:		user-mode registers of @current task
+ *
+ * This is called when %TIF_NOTIFY_RESUME has been set.  Now we are
+ * about to return to user mode, and the user state in @regs can be
+ * inspected or adjusted.  The caller in arch code has cleared
+ * %TIF_NOTIFY_RESUME before the call.  If the flag gets set again
+ * asynchronously, this will be called again before we return to
+ * user mode.
+ *
+ * Called without locks.
+ */
+static inline void resume_user_mode_work(struct pt_regs *regs)
+{
+	clear_thread_flag(TIF_NOTIFY_RESUME);
+	/*
+	 * This barrier pairs with task_work_add()->set_notify_resume() after
+	 * hlist_add_head(task->task_works);
+	 */
+	smp_mb__after_atomic();
+	if (unlikely(task_work_pending(current)))
+		task_work_run();
+
+#ifdef CONFIG_KEYS_REQUEST_CACHE
+	if (unlikely(current->cached_requested_key)) {
+		key_put(current->cached_requested_key);
+		current->cached_requested_key = NULL;
+	}
+#endif
+
+	mem_cgroup_handle_over_high();
+	blkcg_maybe_throttle_current();
+
+	rseq_handle_notify_resume(NULL, regs);
+}
+
+#endif /* LINUX_RESUME_USER_MODE_H */
diff --git a/include/linux/tracehook.h b/include/linux/tracehook.h
index 946404ebe10b..9f6b3fd1880a 100644
--- a/include/linux/tracehook.h
+++ b/include/linux/tracehook.h
@@ -52,56 +52,5 @@
 struct linux_binprm;
 
 
-/**
- * set_notify_resume - cause tracehook_notify_resume() to be called
- * @task:		task that will call tracehook_notify_resume()
- *
- * Calling this arranges that @task will call tracehook_notify_resume()
- * before returning to user mode.  If it's already running in user mode,
- * it will enter the kernel and call tracehook_notify_resume() soon.
- * If it's blocked, it will not be woken.
- */
-static inline void set_notify_resume(struct task_struct *task)
-{
-	if (!test_and_set_tsk_thread_flag(task, TIF_NOTIFY_RESUME))
-		kick_process(task);
-}
-
-/**
- * tracehook_notify_resume - report when about to return to user mode
- * @regs:		user-mode registers of @current task
- *
- * This is called when %TIF_NOTIFY_RESUME has been set.  Now we are
- * about to return to user mode, and the user state in @regs can be
- * inspected or adjusted.  The caller in arch code has cleared
- * %TIF_NOTIFY_RESUME before the call.  If the flag gets set again
- * asynchronously, this will be called again before we return to
- * user mode.
- *
- * Called without locks.
- */
-static inline void tracehook_notify_resume(struct pt_regs *regs)
-{
-	clear_thread_flag(TIF_NOTIFY_RESUME);
-	/*
-	 * This barrier pairs with task_work_add()->set_notify_resume() after
-	 * hlist_add_head(task->task_works);
-	 */
-	smp_mb__after_atomic();
-	if (unlikely(task_work_pending(current)))
-		task_work_run();
-
-#ifdef CONFIG_KEYS_REQUEST_CACHE
-	if (unlikely(current->cached_requested_key)) {
-		key_put(current->cached_requested_key);
-		current->cached_requested_key = NULL;
-	}
-#endif
-
-	mem_cgroup_handle_over_high();
-	blkcg_maybe_throttle_current();
-
-	rseq_handle_notify_resume(NULL, regs);
-}
 
 #endif	/* <linux/tracehook.h> */
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 79eaf9b4b10d..a86823cad853 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -2,7 +2,7 @@
 
 #include <linux/context_tracking.h>
 #include <linux/entry-common.h>
-#include <linux/tracehook.h>
+#include <linux/resume_user_mode.h>
 #include <linux/highmem.h>
 #include <linux/livepatch.h>
 #include <linux/audit.h>
@@ -165,7 +165,7 @@ static unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
 			arch_do_signal_or_restart(regs);
 
 		if (ti_work & _TIF_NOTIFY_RESUME)
-			tracehook_notify_resume(regs);
+			resume_user_mode_work(regs);
 
 		/* Architecture specific TIF work */
 		arch_exit_to_user_mode_work(regs, ti_work);
diff --git a/kernel/entry/kvm.c b/kernel/entry/kvm.c
index 3ab5f98988c3..9d09f489b60e 100644
--- a/kernel/entry/kvm.c
+++ b/kernel/entry/kvm.c
@@ -23,7 +23,7 @@ static int xfer_to_guest_mode_work(struct kvm_vcpu *vcpu, unsigned long ti_work)
 			schedule();
 
 		if (ti_work & _TIF_NOTIFY_RESUME)
-			tracehook_notify_resume(NULL);
+			resume_user_mode_work(NULL);
 
 		ret = arch_xfer_to_guest_mode_handle_work(vcpu, ti_work);
 		if (ret)
diff --git a/kernel/task_work.c b/kernel/task_work.c
index cc6fccb0e24d..c59e1a49bc40 100644
--- a/kernel/task_work.c
+++ b/kernel/task_work.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/spinlock.h>
 #include <linux/task_work.h>
-#include <linux/tracehook.h>
+#include <linux/resume_user_mode.h>
 
 static struct callback_head work_exited; /* all we need is ->next == NULL */
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 09d342c7cbd0..2aaa400f34d6 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -59,7 +59,7 @@
 #include <linux/oom.h>
 #include <linux/lockdep.h>
 #include <linux/file.h>
-#include <linux/tracehook.h>
+#include <linux/resume_user_mode.h>
 #include <linux/psi.h>
 #include <linux/seq_buf.h>
 #include "internal.h"
-- 
2.29.2

