Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62C7959CD68
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 02:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237759AbiHWAtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 20:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239189AbiHWAss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 20:48:48 -0400
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B573B49B74
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 17:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1661215723; x=1692751723;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=s3kBGZYJKBSjf+d5HPTRJJuTKSq36UjTQpNEdBAnad8=;
  b=p0iJdjMQsfSx5WZ9R9PGLtMYgkM9AZPj7cCugQeo+i7arnGmWDSfm5+G
   XKGBijbRLe7zLcMgY2cv6R1Tk0RgNbz0DVXr8TPn3msHkuW4z8aB2L6YL
   vJ79BqDsHhnHo/dPhghw1Fja7qpLIdk7ORZfSQd+lKD8mtm2CxVTWYvFI
   U=;
X-IronPort-AV: E=Sophos;i="5.93,256,1654560000"; 
   d="scan'208";a="122262419"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1d-f20e0c8b.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 00:48:26 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1d-f20e0c8b.us-east-1.amazon.com (Postfix) with ESMTPS id 4E28D81875;
        Tue, 23 Aug 2022 00:48:24 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Tue, 23 Aug 2022 00:48:22 +0000
Received: from 88665a182662.ant.amazon.com (10.43.160.191) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.12;
 Tue, 23 Aug 2022 00:48:20 +0000
From:   Kuniyuki Iwashima <kuniyu@amazon.com>
To:     Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>
CC:     Christian Brauner <brauner@kernel.org>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Kuniyuki Iwashima <kuni1840@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        <syzbot+ab17848fe269b573eb71@syzkaller.appspotmail.com>,
        Ayushman Dutta <ayudutta@amazon.com>
Subject: [PATCH v2] seccomp: Move copy_seccomp() to no failure path.
Date:   Mon, 22 Aug 2022 17:48:06 -0700
Message-ID: <20220823004806.38681-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.43.160.191]
X-ClientProxiedBy: EX13D34UWA004.ant.amazon.com (10.43.160.177) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Our syzbot instance reported memory leaks in do_seccomp() [0], similar
to the report [1].  It shows that we miss freeing struct seccomp_filter
and some objects included in it.

We can reproduce the issue with the program below [2] which calls one
seccomp() and two clone() syscalls.

The first clone()d child exits earlier than its parent and sends a
signal to kill it during the second clone(), more precisely before the
fatal_signal_pending() test in copy_process().  When the parent receives
the signal, it has to destroy the embryonic process and return -EINTR to
user space.  In the failure path, we have to call seccomp_filter_release()
to decrement the filter's refcount.

Initially, we called it in free_task() called from the failure path, but
the commit 3a15fb6ed92c ("seccomp: release filter after task is fully
dead") moved it to release_task() to notify user space as early as possible
that the filter is no longer used.

To keep the change and current seccomp refcount semantics, let's move
copy_seccomp() just after the signal check and add a WARN_ON_ONCE() in
free_task() for future debugging.

[0]:
unreferenced object 0xffff8880063add00 (size 256):
  comm "repro_seccomp", pid 230, jiffies 4294687090 (age 9.914s)
  hex dump (first 32 bytes):
    01 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00  ................
    ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
  backtrace:
    do_seccomp (./include/linux/slab.h:600 ./include/linux/slab.h:733 kernel/seccomp.c:666 kernel/seccomp.c:708 kernel/seccomp.c:1871 kernel/seccomp.c:1991)
    do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80)
    entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120)
unreferenced object 0xffffc90000035000 (size 4096):
  comm "repro_seccomp", pid 230, jiffies 4294687090 (age 9.915s)
  hex dump (first 32 bytes):
    01 00 00 00 00 00 00 00 00 00 00 00 05 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    __vmalloc_node_range (mm/vmalloc.c:3226)
    __vmalloc_node (mm/vmalloc.c:3261 (discriminator 4))
    bpf_prog_alloc_no_stats (kernel/bpf/core.c:91)
    bpf_prog_alloc (kernel/bpf/core.c:129)
    bpf_prog_create_from_user (net/core/filter.c:1414)
    do_seccomp (kernel/seccomp.c:671 kernel/seccomp.c:708 kernel/seccomp.c:1871 kernel/seccomp.c:1991)
    do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80)
    entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120)
unreferenced object 0xffff888003fa1000 (size 1024):
  comm "repro_seccomp", pid 230, jiffies 4294687090 (age 9.915s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    bpf_prog_alloc_no_stats (./include/linux/slab.h:600 ./include/linux/slab.h:733 kernel/bpf/core.c:95)
    bpf_prog_alloc (kernel/bpf/core.c:129)
    bpf_prog_create_from_user (net/core/filter.c:1414)
    do_seccomp (kernel/seccomp.c:671 kernel/seccomp.c:708 kernel/seccomp.c:1871 kernel/seccomp.c:1991)
    do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80)
    entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120)
unreferenced object 0xffff888006360240 (size 16):
  comm "repro_seccomp", pid 230, jiffies 4294687090 (age 9.915s)
  hex dump (first 16 bytes):
    01 00 37 00 76 65 72 6c e0 83 01 06 80 88 ff ff  ..7.verl........
  backtrace:
    bpf_prog_store_orig_filter (net/core/filter.c:1137)
    bpf_prog_create_from_user (net/core/filter.c:1428)
    do_seccomp (kernel/seccomp.c:671 kernel/seccomp.c:708 kernel/seccomp.c:1871 kernel/seccomp.c:1991)
    do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80)
    entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120)
unreferenced object 0xffff8880060183e0 (size 8):
  comm "repro_seccomp", pid 230, jiffies 4294687090 (age 9.915s)
  hex dump (first 8 bytes):
    06 00 00 00 00 00 ff 7f                          ........
  backtrace:
    kmemdup (mm/util.c:129)
    bpf_prog_store_orig_filter (net/core/filter.c:1144)
    bpf_prog_create_from_user (net/core/filter.c:1428)
    do_seccomp (kernel/seccomp.c:671 kernel/seccomp.c:708 kernel/seccomp.c:1871 kernel/seccomp.c:1991)
    do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80)
    entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120)

[1]: https://syzkaller.appspot.com/bug?id=2809bb0ac77ad9aa3f4afe42d6a610aba594a987

[2]:
#define _GNU_SOURCE
#include <sched.h>
#include <signal.h>
#include <unistd.h>
#include <sys/syscall.h>
#include <linux/filter.h>
#include <linux/seccomp.h>

void main(void)
{
	struct sock_filter filter[] = {
		BPF_STMT(BPF_RET | BPF_K, SECCOMP_RET_ALLOW),
	};
	struct sock_fprog fprog = {
		.len = sizeof(filter) / sizeof(filter[0]),
		.filter = filter,
	};
	long i, pid;

	syscall(__NR_seccomp, SECCOMP_SET_MODE_FILTER, 0, &fprog);

	for (i = 0; i < 2; i++) {
		pid = syscall(__NR_clone, CLONE_NEWNET | SIGKILL, NULL, NULL, 0);
		if (pid == 0)
			return;
	}
}

Fixes: 3a15fb6ed92c ("seccomp: release filter after task is fully dead")
Reported-by: syzbot+ab17848fe269b573eb71@syzkaller.appspotmail.com
Reported-by: Ayushman Dutta <ayudutta@amazon.com>
Suggested-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
v2:
  * Move copy_seccomp() after no failure path instead of adding
    seccomp_filter_release() in the failure path.

v1: https://lore.kernel.org/lkml/20220822204436.26631-1-kuniyu@amazon.com/
---
 kernel/fork.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 90c85b17bf69..21c7365c8322 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -537,6 +537,7 @@ void put_task_stack(struct task_struct *tsk)
 
 void free_task(struct task_struct *tsk)
 {
+	WARN_ON_ONCE(tsk->seccomp.filter);
 	release_user_cpus_ptr(tsk);
 	scs_release(tsk);
 
@@ -2409,12 +2410,6 @@ static __latent_entropy struct task_struct *copy_process(
 
 	spin_lock(&current->sighand->siglock);
 
-	/*
-	 * Copy seccomp details explicitly here, in case they were changed
-	 * before holding sighand lock.
-	 */
-	copy_seccomp(p);
-
 	rv_task_fork(p);
 
 	rseq_fork(p, clone_flags);
@@ -2431,6 +2426,14 @@ static __latent_entropy struct task_struct *copy_process(
 		goto bad_fork_cancel_cgroup;
 	}
 
+	/* No more failure paths after this point. */
+
+	/*
+	 * Copy seccomp details explicitly here, in case they were changed
+	 * before holding sighand lock.
+	 */
+	copy_seccomp(p);
+
 	init_task_pid_links(p);
 	if (likely(p->pid)) {
 		ptrace_init_task(p, (clone_flags & CLONE_PTRACE) || trace);
-- 
2.30.2

