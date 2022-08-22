Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00CDD59CA4E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 22:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237888AbiHVUpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 16:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232558AbiHVUpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 16:45:23 -0400
Received: from smtp-fw-9103.amazon.com (smtp-fw-9103.amazon.com [207.171.188.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC8613C8D8
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 13:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1661201122; x=1692737122;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pfyRXyWluCnhnjEdRDPQUR/DaGzLwt6O14t/hdBKsfc=;
  b=pVKKavWP/EGzWRbir7ZMeX9jDFADhoRYcCPyCG7ZkczZ+QLRVwmsKWyX
   13JruAhGQGT7nwMi3dLGSN/RXdkH0k36LO85pFC6vTzUvoR50VsnV14m0
   awupKybYtMEs1HvP/WtuovczDDC+NY+qDlmgO1ywoCHbRKnykHO3wR0p2
   o=;
X-IronPort-AV: E=Sophos;i="5.93,255,1654560000"; 
   d="scan'208";a="1047060497"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1d-7a21ed79.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9103.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 20:45:03 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1d-7a21ed79.us-east-1.amazon.com (Postfix) with ESMTPS id 767BA22033C;
        Mon, 22 Aug 2022 20:45:01 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Mon, 22 Aug 2022 20:45:00 +0000
Received: from 88665a182662.ant.amazon.com (10.43.161.228) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.12;
 Mon, 22 Aug 2022 20:44:58 +0000
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
Subject: [PATCH v1] seccomp: Release filter when copy_process() fails.
Date:   Mon, 22 Aug 2022 13:44:36 -0700
Message-ID: <20220822204436.26631-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.43.161.228]
X-ClientProxiedBy: EX13D15UWB004.ant.amazon.com (10.43.161.61) To
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
to decrement the filter's ref count.

Initially, we called it in free_task() called from the failure path, but
the commit 3a15fb6ed92c ("seccomp: release filter after task is fully
dead") moved it to release_task() to notify user space as early as possible
that the filter is no longer used.

To keep the change, let's call seccomp_filter_release() in copy_process()
and add a WARN_ON_ONCE() in free_task() for future debugging.

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
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 kernel/fork.c    | 2 ++
 kernel/seccomp.c | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 90c85b17bf69..031290fc527c 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -537,6 +537,7 @@ void put_task_stack(struct task_struct *tsk)
 
 void free_task(struct task_struct *tsk)
 {
+	WARN_ON_ONCE(tsk->seccomp.filter);
 	release_user_cpus_ptr(tsk);
 	scs_release(tsk);
 
@@ -2498,6 +2499,7 @@ static __latent_entropy struct task_struct *copy_process(
 	sched_core_free(p);
 	spin_unlock(&current->sighand->siglock);
 	write_unlock_irq(&tasklist_lock);
+	seccomp_filter_release(p);
 	cgroup_cancel_fork(p, args);
 bad_fork_put_pidfd:
 	if (clone_flags & CLONE_PIDFD) {
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index e9852d1b4a5e..017c1dd5b0d4 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -563,8 +563,6 @@ void seccomp_filter_release(struct task_struct *tsk)
 {
 	struct seccomp_filter *orig = tsk->seccomp.filter;
 
-	/* We are effectively holding the siglock by not having any sighand. */
-	WARN_ON(tsk->sighand != NULL);
 
 	/* Detach task from its filter tree. */
 	tsk->seccomp.filter = NULL;
-- 
2.30.2

