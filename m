Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E44CB46DAB1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 19:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238577AbhLHSJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 13:09:48 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:48320 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238568AbhLHSJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 13:09:47 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5066F212C9;
        Wed,  8 Dec 2021 18:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1638986774; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=46kEqMGJEUsi3iPqe72zqA+9aAjNxWoGQty2b7bsly8=;
        b=nP2/sKMLGQk2D44Eb14oCjEQnywch1drJEXkSY7KtgljTIXuCzBSbOGHjd5lkEkU3xglYd
        3OAOpPS1+2QFXFtsRxlXDZx7tWJYLLIT7GgOkQLiDqerLPwpRVzW1eqNsG6iB9x3cAIrN2
        5b/fZ46ZSZWjsU9Hkr4Cfy/RF2OZWXg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1B28C13B6B;
        Wed,  8 Dec 2021 18:06:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id lA2lBRb0sGFQIAAAMHmgww
        (envelope-from <mkoutny@suse.com>); Wed, 08 Dec 2021 18:06:14 +0000
From:   =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Eric W . Biederman" <ebiederm@xmission.com>,
        Jens Axboe <axboe@kernel.dk>,
        Kees Cook <keescook@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jim Newsome <jnewsome@torproject.org>,
        Alexey Gladkov <legion@kernel.org>, Tejun Heo <tj@kernel.org>
Subject: [PATCH] exit: Retain nsproxy for exit_task_work() work entries
Date:   Wed,  8 Dec 2021 19:05:01 +0100
Message-Id: <20211208180501.11969-1-mkoutny@suse.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reported issue is an attempted write in a cgroup file, by a zombie
who has/had acct(2) enabled. Such a write needs cgroup_ns for access
checking. Ordinary acct_process() would not be affected by this as it is
called well before exit_task_namespaces(). However, the reported NULL
dereference is a different acct data writer:

	Call Trace:
	 <TASK>
	 kernfs_fop_write_iter+0x3b6/0x510 fs/kernfs/file.c:296
	 __kernel_write+0x5d1/0xaf0 fs/read_write.c:535
	 do_acct_process+0x112a/0x17b0 kernel/acct.c:518
	 acct_pin_kill+0x27/0x130 kernel/acct.c:173
	 pin_kill+0x2a6/0x940 fs/fs_pin.c:44
	 mnt_pin_kill+0xc1/0x170 fs/fs_pin.c:81
	 cleanup_mnt+0x4bc/0x510 fs/namespace.c:1130
	 task_work_run+0x146/0x1c0 kernel/task_work.c:164
	 exit_task_work include/linux/task_work.h:32 [inline]
	 do_exit+0x705/0x24f0 kernel/exit.c:832
	 do_group_exit+0x168/0x2d0 kernel/exit.c:929
	 get_signal+0x16b0/0x2090 kernel/signal.c:2820
	 arch_do_signal_or_restart+0x9c/0x730 arch/x86/kernel/signal.c:868
	 handle_signal_work kernel/entry/common.c:148 [inline]
	 exit_to_user_mode_loop kernel/entry/common.c:172 [inline]
	 exit_to_user_mode_prepare+0x191/0x220 kernel/entry/common.c:207
	 __syscall_exit_to_user_mode_work kernel/entry/common.c:289 [inline]
	 syscall_exit_to_user_mode+0x2e/0x70 kernel/entry/common.c:300
	 do_syscall_64+0x53/0xd0 arch/x86/entry/common.c:86
	 entry_SYSCALL_64_after_hwframe+0x44/0xae

i.e. called as one of task_work_run() entries.

The historical commit 8aac62706ada ("move exit_task_namespaces() outside
of exit_notify()") argues that exit_task_namespaces() must come before
exit_task_work() because ipc_ns cleanup calls fput/task_work_add.

There is accompanying commit e7b2c4069252 ("fput: task_work_add() can
fail if the caller has passed exit_task_work()") in the original series
that makes fput() robust in situations when task_work_add() cannot be
used anymore.

So in order to ensure that task_work_run() entries of the exiting task
have the nsproxy still available, swap the order of
exit_task_namespaces() and exit_task_work().

This change may appear like a partial revert of 8aac62706ada but this
particular ordering change shouldn't matter with the fix from
e7b2c4069252 and the other reason for 8aac62706ada (keeping exit_notify
simpler) still holds.

Reported-by: syzbot+50f5cf33a284ce738b62@syzkaller.appspotmail.com
Link: https://lore.kernel.org/r/00000000000048c15c05d0083397@google.com
Cc: Oleg Nesterov <oleg@redhat.com>
Fixes: 5136f6365ce3 ("cgroup: implement "nsdelegate" mount option")
Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 kernel/exit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

I wasn't able to reproduce the syzbot's crash manually so the effectiveness of
the fix is only based on the reasoning.

diff --git a/kernel/exit.c b/kernel/exit.c
index f702a6a63686..0c2abdebb87c 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -828,8 +828,8 @@ void __noreturn do_exit(long code)
 	exit_fs(tsk);
 	if (group_dead)
 		disassociate_ctty(1);
-	exit_task_namespaces(tsk);
 	exit_task_work(tsk);
+	exit_task_namespaces(tsk);
 	exit_thread(tsk);
 
 	/*
-- 
2.33.1

