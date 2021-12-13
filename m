Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49452472C68
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 13:40:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236821AbhLMMkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 07:40:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:45978 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231831AbhLMMkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 07:40:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639399204;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lQVfgXvUEecz1ew4Duj5H2gRLrd/qk8IbwHLmWuD9+M=;
        b=YcYMb3Ooq5ul+xqjDjnfPVo0Xo8nhSp0Tu6HomjAtRKBb6cpIvFIMsjFTLGlgMPwjyT0sw
        R0d41OjBI5mTQRZHmUvocLRKVNt7cTyrdOv1dw9nmlhlKF4Lj3ce8hJn18gwarwZqvX1qZ
        hRGce/yvQbN+9VEtCJpKj0SnCaHMIZQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-573-Z9Exka3VP_ezK-DSLUs5Dw-1; Mon, 13 Dec 2021 07:40:03 -0500
X-MC-Unique: Z9Exka3VP_ezK-DSLUs5Dw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C32461926DA3;
        Mon, 13 Dec 2021 12:40:01 +0000 (UTC)
Received: from wcosta.com (ovpn-116-142.gru2.redhat.com [10.97.116.142])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 11895694D8;
        Mon, 13 Dec 2021 12:39:53 +0000 (UTC)
From:   Wander Lairson Costa <wander@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users@vger.kernel.org,
        Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH v2 1/2] block: Avoid sleeping function called from invalid context bug
Date:   Mon, 13 Dec 2021 09:37:36 -0300
Message-Id: <20211213123737.9147-2-wander@redhat.com>
In-Reply-To: <20211213123737.9147-1-wander@redhat.com>
References: <20211213123737.9147-1-wander@redhat.com>
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

