Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB78D4D356E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 18:42:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236039AbiCIQqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 11:46:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238826AbiCIQbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 11:31:51 -0500
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE0C919E73C
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 08:26:30 -0800 (PST)
Received: from in02.mta.xmission.com ([166.70.13.52]:33728)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nRz8P-0032B6-0L; Wed, 09 Mar 2022 09:25:57 -0700
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:34572 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nRz8N-005hAS-Hw; Wed, 09 Mar 2022 09:25:56 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Gladkov <legion@kernel.org>,
        Kyle Huey <me@kylehuey.com>, Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Wed,  9 Mar 2022 10:24:54 -0600
Message-Id: <20220309162454.123006-13-ebiederm@xmission.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87o82gdlu9.fsf_-_@email.froward.int.ebiederm.org>
References: <87o82gdlu9.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1nRz8N-005hAS-Hw;;;mid=<20220309162454.123006-13-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19+FQM3D1XdYWJS36eLYbGAtR0Ijwl/ij4=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Virus: No
X-Spam-DCC: XMission; sa03 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 796 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 4.4 (0.5%), b_tie_ro: 2.9 (0.4%), parse: 1.67
        (0.2%), extract_message_metadata: 15 (1.8%), get_uri_detail_list: 7
        (0.8%), tests_pri_-1000: 10 (1.3%), tests_pri_-950: 1.01 (0.1%),
        tests_pri_-900: 0.79 (0.1%), tests_pri_-90: 124 (15.6%), check_bayes:
        123 (15.4%), b_tokenize: 19 (2.3%), b_tok_get_all: 14 (1.8%),
        b_comp_prob: 3.1 (0.4%), b_tok_touch_all: 83 (10.5%), b_finish: 0.74
        (0.1%), tests_pri_0: 625 (78.5%), check_dkim_signature: 0.51 (0.1%),
        check_dkim_adsp: 1.87 (0.2%), poll_dns_idle: 0.54 (0.1%),
        tests_pri_10: 2.7 (0.3%), tests_pri_500: 8 (1.0%), rewrite_mail: 0.00
        (0.0%)
Subject: [PATCH 13/13] tracehook: Remove tracehook.h
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that all of the definitions have moved out of tracehook.h into
ptrace.h, sched/signal.h, resume_user_mode.h there is nothing left in
tracehook.h so remove it.

Update the few files that were depending upon tracehook.h to bring in
definitions to use the headers they need directly.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 MAINTAINERS                          |  1 -
 arch/s390/include/asm/entry-common.h |  1 -
 arch/s390/kernel/ptrace.c            |  1 -
 arch/s390/kernel/signal.c            |  1 -
 arch/x86/kernel/ptrace.c             |  1 -
 arch/x86/kernel/signal.c             |  1 -
 fs/coredump.c                        |  1 -
 fs/exec.c                            |  1 -
 fs/io-wq.c                           |  2 +-
 fs/io_uring.c                        |  1 -
 fs/proc/array.c                      |  1 -
 fs/proc/base.c                       |  1 -
 include/linux/tracehook.h            | 56 ----------------------------
 kernel/exit.c                        |  3 +-
 kernel/livepatch/transition.c        |  1 -
 kernel/seccomp.c                     |  1 -
 kernel/signal.c                      |  2 +-
 security/apparmor/domain.c           |  1 -
 security/selinux/hooks.c             |  1 -
 19 files changed, 4 insertions(+), 74 deletions(-)
 delete mode 100644 include/linux/tracehook.h

diff --git a/MAINTAINERS b/MAINTAINERS
index ea3e6c914384..2f16a23a26a2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15623,7 +15623,6 @@ F:	arch/*/ptrace*.c
 F:	include/asm-generic/syscall.h
 F:	include/linux/ptrace.h
 F:	include/linux/regset.h
-F:	include/linux/tracehook.h
 F:	include/uapi/linux/ptrace.h
 F:	include/uapi/linux/ptrace.h
 F:	kernel/ptrace.c
diff --git a/arch/s390/include/asm/entry-common.h b/arch/s390/include/asm/entry-common.h
index 17aead80aadb..eabab24b71dd 100644
--- a/arch/s390/include/asm/entry-common.h
+++ b/arch/s390/include/asm/entry-common.h
@@ -5,7 +5,6 @@
 #include <linux/sched.h>
 #include <linux/audit.h>
 #include <linux/randomize_kstack.h>
-#include <linux/tracehook.h>
 #include <linux/processor.h>
 #include <linux/uaccess.h>
 #include <asm/timex.h>
diff --git a/arch/s390/kernel/ptrace.c b/arch/s390/kernel/ptrace.c
index 0ea3d02b378d..641fa36f6101 100644
--- a/arch/s390/kernel/ptrace.c
+++ b/arch/s390/kernel/ptrace.c
@@ -21,7 +21,6 @@
 #include <linux/signal.h>
 #include <linux/elf.h>
 #include <linux/regset.h>
-#include <linux/tracehook.h>
 #include <linux/seccomp.h>
 #include <linux/compat.h>
 #include <trace/syscall.h>
diff --git a/arch/s390/kernel/signal.c b/arch/s390/kernel/signal.c
index ea9e5e8182cd..8b7b5f80f722 100644
--- a/arch/s390/kernel/signal.c
+++ b/arch/s390/kernel/signal.c
@@ -25,7 +25,6 @@
 #include <linux/tty.h>
 #include <linux/personality.h>
 #include <linux/binfmts.h>
-#include <linux/tracehook.h>
 #include <linux/syscalls.h>
 #include <linux/compat.h>
 #include <asm/ucontext.h>
diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
index 6d2244c94799..419768d7605e 100644
--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -13,7 +13,6 @@
 #include <linux/errno.h>
 #include <linux/slab.h>
 #include <linux/ptrace.h>
-#include <linux/tracehook.h>
 #include <linux/user.h>
 #include <linux/elf.h>
 #include <linux/security.h>
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index de3d5b5724d8..e439eb14325f 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -18,7 +18,6 @@
 #include <linux/kstrtox.h>
 #include <linux/errno.h>
 #include <linux/wait.h>
-#include <linux/tracehook.h>
 #include <linux/unistd.h>
 #include <linux/stddef.h>
 #include <linux/personality.h>
diff --git a/fs/coredump.c b/fs/coredump.c
index 1c060c0a2d72..f54c5e316df3 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -31,7 +31,6 @@
 #include <linux/tsacct_kern.h>
 #include <linux/cn_proc.h>
 #include <linux/audit.h>
-#include <linux/tracehook.h>
 #include <linux/kmod.h>
 #include <linux/fsnotify.h>
 #include <linux/fs_struct.h>
diff --git a/fs/exec.c b/fs/exec.c
index 79f2c9483302..e23e2d430485 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -56,7 +56,6 @@
 #include <linux/tsacct_kern.h>
 #include <linux/cn_proc.h>
 #include <linux/audit.h>
-#include <linux/tracehook.h>
 #include <linux/kmod.h>
 #include <linux/fsnotify.h>
 #include <linux/fs_struct.h>
diff --git a/fs/io-wq.c b/fs/io-wq.c
index 8b9147873c2c..cb3cb1833ef6 100644
--- a/fs/io-wq.c
+++ b/fs/io-wq.c
@@ -13,7 +13,7 @@
 #include <linux/slab.h>
 #include <linux/rculist_nulls.h>
 #include <linux/cpu.h>
-#include <linux/tracehook.h>
+#include <linux/task_work.h>
 #include <linux/audit.h>
 #include <uapi/linux/io_uring.h>
 
diff --git a/fs/io_uring.c b/fs/io_uring.c
index d5fbae1030f9..6c7eacc0ebd6 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -78,7 +78,6 @@
 #include <linux/task_work.h>
 #include <linux/pagemap.h>
 #include <linux/io_uring.h>
-#include <linux/tracehook.h>
 #include <linux/audit.h>
 #include <linux/security.h>
 
diff --git a/fs/proc/array.c b/fs/proc/array.c
index fd8b0c12b2cb..eb815759842c 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -88,7 +88,6 @@
 #include <linux/pid_namespace.h>
 #include <linux/prctl.h>
 #include <linux/ptrace.h>
-#include <linux/tracehook.h>
 #include <linux/string_helpers.h>
 #include <linux/user_namespace.h>
 #include <linux/fs_struct.h>
diff --git a/fs/proc/base.c b/fs/proc/base.c
index d654ce7150fd..01fb37ecc89f 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -74,7 +74,6 @@
 #include <linux/mount.h>
 #include <linux/security.h>
 #include <linux/ptrace.h>
-#include <linux/tracehook.h>
 #include <linux/printk.h>
 #include <linux/cache.h>
 #include <linux/cgroup.h>
diff --git a/include/linux/tracehook.h b/include/linux/tracehook.h
deleted file mode 100644
index 9f6b3fd1880a..000000000000
--- a/include/linux/tracehook.h
+++ /dev/null
@@ -1,56 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Tracing hooks
- *
- * Copyright (C) 2008-2009 Red Hat, Inc.  All rights reserved.
- *
- * This file defines hook entry points called by core code where
- * user tracing/debugging support might need to do something.  These
- * entry points are called tracehook_*().  Each hook declared below
- * has a detailed kerneldoc comment giving the context (locking et
- * al) from which it is called, and the meaning of its return value.
- *
- * Each function here typically has only one call site, so it is ok
- * to have some nontrivial tracehook_*() inlines.  In all cases, the
- * fast path when no tracing is enabled should be very short.
- *
- * The purpose of this file and the tracehook_* layer is to consolidate
- * the interface that the kernel core and arch code uses to enable any
- * user debugging or tracing facility (such as ptrace).  The interfaces
- * here are carefully documented so that maintainers of core and arch
- * code do not need to think about the implementation details of the
- * tracing facilities.  Likewise, maintainers of the tracing code do not
- * need to understand all the calling core or arch code in detail, just
- * documented circumstances of each call, such as locking conditions.
- *
- * If the calling core code changes so that locking is different, then
- * it is ok to change the interface documented here.  The maintainer of
- * core code changing should notify the maintainers of the tracing code
- * that they need to work out the change.
- *
- * Some tracehook_*() inlines take arguments that the current tracing
- * implementations might not necessarily use.  These function signatures
- * are chosen to pass in all the information that is on hand in the
- * caller and might conceivably be relevant to a tracer, so that the
- * core code won't have to be updated when tracing adds more features.
- * If a call site changes so that some of those parameters are no longer
- * already on hand without extra work, then the tracehook_* interface
- * can change so there is no make-work burden on the core code.  The
- * maintainer of core code changing should notify the maintainers of the
- * tracing code that they need to work out the change.
- */
-
-#ifndef _LINUX_TRACEHOOK_H
-#define _LINUX_TRACEHOOK_H	1
-
-#include <linux/sched.h>
-#include <linux/ptrace.h>
-#include <linux/security.h>
-#include <linux/task_work.h>
-#include <linux/memcontrol.h>
-#include <linux/blk-cgroup.h>
-struct linux_binprm;
-
-
-
-#endif	/* <linux/tracehook.h> */
diff --git a/kernel/exit.c b/kernel/exit.c
index b00a25bb4ab9..9326d1f97fc7 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -49,7 +49,8 @@
 #include <linux/audit.h> /* for audit_free() */
 #include <linux/resource.h>
 #include <linux/task_io_accounting_ops.h>
-#include <linux/tracehook.h>
+#include <linux/blkdev.h>
+#include <linux/task_work.h>
 #include <linux/fs_struct.h>
 #include <linux/init_task.h>
 #include <linux/perf_event.h>
diff --git a/kernel/livepatch/transition.c b/kernel/livepatch/transition.c
index 5683ac0d2566..df808d97d84f 100644
--- a/kernel/livepatch/transition.c
+++ b/kernel/livepatch/transition.c
@@ -9,7 +9,6 @@
 
 #include <linux/cpu.h>
 #include <linux/stacktrace.h>
-#include <linux/tracehook.h>
 #include "core.h"
 #include "patch.h"
 #include "transition.h"
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 4d8f44a17727..63198086ee83 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -39,7 +39,6 @@
 #include <linux/pid.h>
 #include <linux/ptrace.h>
 #include <linux/capability.h>
-#include <linux/tracehook.h>
 #include <linux/uaccess.h>
 #include <linux/anon_inodes.h>
 #include <linux/lockdep.h>
diff --git a/kernel/signal.c b/kernel/signal.c
index 8632b88982c9..c2dee5420567 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -32,7 +32,7 @@
 #include <linux/signal.h>
 #include <linux/signalfd.h>
 #include <linux/ratelimit.h>
-#include <linux/tracehook.h>
+#include <linux/task_work.h>
 #include <linux/capability.h>
 #include <linux/freezer.h>
 #include <linux/pid_namespace.h>
diff --git a/security/apparmor/domain.c b/security/apparmor/domain.c
index 583680f6cd81..a29e69d2c300 100644
--- a/security/apparmor/domain.c
+++ b/security/apparmor/domain.c
@@ -14,7 +14,6 @@
 #include <linux/file.h>
 #include <linux/mount.h>
 #include <linux/syscalls.h>
-#include <linux/tracehook.h>
 #include <linux/personality.h>
 #include <linux/xattr.h>
 #include <linux/user_namespace.h>
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 5b6895e4fc29..4d2cd6b9f6fc 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -25,7 +25,6 @@
 #include <linux/kd.h>
 #include <linux/kernel.h>
 #include <linux/kernel_read_file.h>
-#include <linux/tracehook.h>
 #include <linux/errno.h>
 #include <linux/sched/signal.h>
 #include <linux/sched/task.h>
-- 
2.29.2

