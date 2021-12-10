Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1581E470BFF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 21:43:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344256AbhLJUq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 15:46:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55245 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344228AbhLJUq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 15:46:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639168972;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lQVfgXvUEecz1ew4Duj5H2gRLrd/qk8IbwHLmWuD9+M=;
        b=b/NXgJUaCRJ3KvN5EAzwXBcD79p1Vwo+edjkWKVDkSiUwLqaYNtKA0PwC4Php/RHr+Ps7+
        qE2v79HQQ1CRiX1/Zin/qvC2KaUBVm89z3ZPDGpVI+TJEpgjESRCMwMiDUy8C90wucS2bb
        6FkBN8b69//MULdbIyx3Wmz9JcHf/s0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-108-eZtuOUN6MsON-0NKnFnQWQ-1; Fri, 10 Dec 2021 15:42:51 -0500
X-MC-Unique: eZtuOUN6MsON-0NKnFnQWQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9F2D01023F4E;
        Fri, 10 Dec 2021 20:42:49 +0000 (UTC)
Received: from wcosta.com (ovpn-116-199.gru2.redhat.com [10.97.116.199])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 58E6C781EF;
        Fri, 10 Dec 2021 20:42:45 +0000 (UTC)
From:   Wander Lairson Costa <wander@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users@vger.kernel.org,
        Wander Lairson Costa <wander@redhat.com>
Subject: [PREEMPT_RT PATCH 1/2] block: Avoid sleeping function called from invalid context bug
Date:   Fri, 10 Dec 2021 17:41:55 -0300
Message-Id: <20211210204156.96336-2-wander@redhat.com>
In-Reply-To: <20211210204156.96336-1-wander@redhat.com>
References: <20211210204156.96336-1-wander@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This was caught during QA test:

 BUG: sleeping function called from invalid context at kernel/locking/rtmutex.c:942
 in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 243401, name: sed
 INFO: lockdep is turned off.
 Preemption disabled at:
 [<ffffffff89b26268>] blk_cgroup_bio_start+0x28/0xd0

 CPU: 2 PID: 243401 Comm: sed Kdump: loaded Not tainted 4.18.0-353.rt7.138.el8.x86_64+debug #1
 Hardware name: HP ProLiant DL380 Gen9, BIOS P89 05/06/2015
 Call Trace:
  dump_stack+0x5c/0x80
  ___might_sleep.cold.89+0xf5/0x109
  rt_spin_lock+0x3e/0xd0
  ? __blk_add_trace+0x428/0x4b0
  __blk_add_trace+0x428/0x4b0
  blk_add_trace_bio+0x16e/0x1c0
  generic_make_request_checks+0x7e8/0x8c0
  generic_make_request+0x3c/0x420
  ? membarrier_private_expedited+0xd0/0x2b0
  ? lock_release+0x1ca/0x450
  ? submit_bio+0x3c/0x160
  ? _raw_spin_unlock_irqrestore+0x3c/0x80
  submit_bio+0x3c/0x160
  ? rt_mutex_futex_unlock+0x66/0xa0
  iomap_submit_ioend.isra.36+0x4a/0x70
  xfs_vm_writepages+0x65/0x90 [xfs]
  do_writepages+0x41/0xe0
  ? rt_mutex_futex_unlock+0x66/0xa0
  __filemap_fdatawrite_range+0xce/0x110
  xfs_release+0x11c/0x160 [xfs]
  __fput+0xd5/0x270
  task_work_run+0xa1/0xd0
  exit_to_usermode_loop+0x14d/0x160
  do_syscall_64+0x23b/0x240
  entry_SYSCALL_64_after_hwframe+0x6a/0xdf

We replace the get/put_cpu() call by get/put_cpu_light to avoid this bug.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 block/blk-cgroup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 663aabfeba18..0a532bb3003c 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1911,7 +1911,7 @@ void blk_cgroup_bio_start(struct bio *bio)
 	struct blkg_iostat_set *bis;
 	unsigned long flags;
 
-	cpu = get_cpu();
+	cpu = get_cpu_light();
 	bis = per_cpu_ptr(bio->bi_blkg->iostat_cpu, cpu);
 	flags = u64_stats_update_begin_irqsave(&bis->sync);
 
@@ -1928,7 +1928,7 @@ void blk_cgroup_bio_start(struct bio *bio)
 	u64_stats_update_end_irqrestore(&bis->sync, flags);
 	if (cgroup_subsys_on_dfl(io_cgrp_subsys))
 		cgroup_rstat_updated(bio->bi_blkg->blkcg->css.cgroup, cpu);
-	put_cpu();
+	put_cpu_light();
 }
 
 static int __init blkcg_init(void)
-- 
2.27.0

