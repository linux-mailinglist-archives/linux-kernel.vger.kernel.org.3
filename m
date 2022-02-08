Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14C124ADE78
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 17:41:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383398AbiBHQj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 11:39:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232725AbiBHQj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 11:39:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C5010C061576
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 08:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644338394;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ResiOMSkqLaFwecOSm6Y41C9FDzk+Q7FwcTKW53EBiY=;
        b=YWLicH1npxuQ3j3nI3QYmk1ganMa/7eL/GI8wG0qMApjMEOSzm/P6HIq2kV1F+eB6gBOuS
        aJvX6lz+rTqIRCy2IhqqeuPuJ6ZaHWHDXOCqrzj0Jl8L3qNOLOV4L/JTxJkOmfPkZKNL4N
        C2bCXxQRZkAdjyw+KIYVfknizG0/Osk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-649-5Oas98BiM-KtHahzRmNmEw-1; Tue, 08 Feb 2022 11:39:51 -0500
X-MC-Unique: 5Oas98BiM-KtHahzRmNmEw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B3AD21006AB3;
        Tue,  8 Feb 2022 16:39:49 +0000 (UTC)
Received: from llong.com (unknown [10.22.35.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 094E2879D3;
        Tue,  8 Feb 2022 16:39:21 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Christian Brauner <brauner@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        Alexey Gladkov <legion@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jann Horn <jannh@google.com>, Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, Waiman Long <longman@redhat.com>
Subject: [PATCH] copy_process(): Move fd_install() out of sighand->siglock critical section
Date:   Tue,  8 Feb 2022 11:39:12 -0500
Message-Id: <20220208163912.1084752-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I was made aware of the following lockdep splat:

[ 2516.308763] =====================================================
[ 2516.309085] WARNING: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected
[ 2516.309433] 5.14.0-51.el9.aarch64+debug #1 Not tainted
[ 2516.309703] -----------------------------------------------------
[ 2516.310149] stress-ng/153663 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
[ 2516.310512] ffff0000e422b198 (&newf->file_lock){+.+.}-{2:2}, at: fd_install+0x368/0x4f0
[ 2516.310944]
               and this task is already holding:
[ 2516.311248] ffff0000c08140d8 (&sighand->siglock){-.-.}-{2:2}, at: copy_process+0x1e2c/0x3e80
[ 2516.311804] which would create a new lock dependency:
[ 2516.312066]  (&sighand->siglock){-.-.}-{2:2} -> (&newf->file_lock){+.+.}-{2:2}
[ 2516.312446]
               but this new dependency connects a HARDIRQ-irq-safe lock:
[ 2516.312983]  (&sighand->siglock){-.-.}-{2:2}
   :
[ 2516.330700]  Possible interrupt unsafe locking scenario:

[ 2516.331075]        CPU0                    CPU1
[ 2516.331328]        ----                    ----
[ 2516.331580]   lock(&newf->file_lock);
[ 2516.331790]                                local_irq_disable();
[ 2516.332231]                                lock(&sighand->siglock);
[ 2516.332579]                                lock(&newf->file_lock);
[ 2516.332922]   <Interrupt>
[ 2516.333069]     lock(&sighand->siglock);
[ 2516.333291]
                *** DEADLOCK ***
[ 2516.389845]
               stack backtrace:
[ 2516.390101] CPU: 3 PID: 153663 Comm: stress-ng Kdump: loaded Not tainted 5.14.0-51.el9.aarch64+debug #1
[ 2516.390756] Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/2015
[ 2516.391155] Call trace:
[ 2516.391302]  dump_backtrace+0x0/0x3e0
[ 2516.391518]  show_stack+0x24/0x30
[ 2516.391717]  dump_stack_lvl+0x9c/0xd8
[ 2516.391938]  dump_stack+0x1c/0x38
[ 2516.392247]  print_bad_irq_dependency+0x620/0x710
[ 2516.392525]  check_irq_usage+0x4fc/0x86c
[ 2516.392756]  check_prev_add+0x180/0x1d90
[ 2516.392988]  validate_chain+0x8e0/0xee0
[ 2516.393215]  __lock_acquire+0x97c/0x1e40
[ 2516.393449]  lock_acquire.part.0+0x240/0x570
[ 2516.393814]  lock_acquire+0x90/0xb4
[ 2516.394021]  _raw_spin_lock+0xe8/0x154
[ 2516.394244]  fd_install+0x368/0x4f0
[ 2516.394451]  copy_process+0x1f5c/0x3e80
[ 2516.394678]  kernel_clone+0x134/0x660
[ 2516.394895]  __do_sys_clone3+0x130/0x1f4
[ 2516.395128]  __arm64_sys_clone3+0x5c/0x7c
[ 2516.395478]  invoke_syscall.constprop.0+0x78/0x1f0
[ 2516.395762]  el0_svc_common.constprop.0+0x22c/0x2c4
[ 2516.396050]  do_el0_svc+0xb0/0x10c
[ 2516.396252]  el0_svc+0x24/0x34
[ 2516.396436]  el0t_64_sync_handler+0xa4/0x12c
[ 2516.396688]  el0t_64_sync+0x198/0x19c
[ 2517.491197] NET: Registered PF_ATMPVC protocol family
[ 2517.491524] NET: Registered PF_ATMSVC protocol family
[ 2591.991877] sched: RT throttling activated

One way to solve this problem is to move the fd_install() call out of
the sighand->siglock critical section.

Before commit 6fd2fe494b17 ("copy_process(): don't use ksys_close()
on cleanups"), the pidfd installation was done without holding both
the task_list lock and the sighand->siglock. Obviously, holding these
two locks are not really needed to protect the fd_install() call.
So move the fd_install() call down to after the releases of both locks.

Fixes: 6fd2fe494b17 ("copy_process(): don't use ksys_close() on cleanups")
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/fork.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index d75a528f7b21..007af7fb47c7 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2323,10 +2323,6 @@ static __latent_entropy struct task_struct *copy_process(
 		goto bad_fork_cancel_cgroup;
 	}
 
-	/* past the last point of failure */
-	if (pidfile)
-		fd_install(pidfd, pidfile);
-
 	init_task_pid_links(p);
 	if (likely(p->pid)) {
 		ptrace_init_task(p, (clone_flags & CLONE_PTRACE) || trace);
@@ -2375,6 +2371,9 @@ static __latent_entropy struct task_struct *copy_process(
 	syscall_tracepoint_update(p);
 	write_unlock_irq(&tasklist_lock);
 
+	if (pidfile)
+		fd_install(pidfd, pidfile);
+
 	proc_fork_connector(p);
 	sched_post_fork(p, args);
 	cgroup_post_fork(p, args);
-- 
2.27.0

