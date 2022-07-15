Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB9E1576094
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 13:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232755AbiGOLeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 07:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232344AbiGOLdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 07:33:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E977D14D0B
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 04:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657884832;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mSVbgxFJfTBqx19mVcvhDywOdKVcI2pzv3Tboo7rs1U=;
        b=SZA3FGRlIawvYnIje0VCSMUcvBFT5517ojN/MUQDaLQ6zNd7ccC7SQJyOvTPw00Aiw3+4d
        RhtuZK+7xJ1gz6EYSnriOA64nd5Vo5Loy9bOMTrm1g+X4wmjFIBZTmIQw6UmcA5pBbzsXy
        YSRcyZswf6+kHjvuKhw4qOnrcqGoJPQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-164-_WO-K6-_MVqM4nZ-NYdFkw-1; Fri, 15 Jul 2022 07:33:50 -0400
X-MC-Unique: _WO-K6-_MVqM4nZ-NYdFkw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5856A3833288;
        Fri, 15 Jul 2022 11:33:50 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.32.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1D9232026D07;
        Fri, 15 Jul 2022 11:33:50 +0000 (UTC)
From:   Brian Foster <bfoster@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Matthew Wilcox <willy@infradead.org>, ikent@redhat.com,
        oleg@redhat.com
Subject: [PATCH 2/3] pid: split cyclic id allocation cursor from idr
Date:   Fri, 15 Jul 2022 07:33:48 -0400
Message-Id: <20220715113349.831370-3-bfoster@redhat.com>
In-Reply-To: <20220715113349.831370-1-bfoster@redhat.com>
References: <20220715113349.831370-1-bfoster@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As a next step in separating pid allocation from the idr, split off
the cyclic pid allocation cursor from the idr. Lift the cursor value
into the sturct pid_namespace. Note that this involves temporarily
open-coding the cursor increment on allocation, but this is cleaned
up in the subsequent patch.

Signed-off-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Brian Foster <bfoster@redhat.com>
---
 arch/powerpc/platforms/cell/spufs/sched.c | 2 +-
 fs/proc/loadavg.c                         | 2 +-
 include/linux/pid_namespace.h             | 1 +
 kernel/pid.c                              | 6 ++++--
 kernel/pid_namespace.c                    | 4 ++--
 5 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/cell/spufs/sched.c b/arch/powerpc/platforms/cell/spufs/sched.c
index 99bd027a7f7c..a2ed928d7658 100644
--- a/arch/powerpc/platforms/cell/spufs/sched.c
+++ b/arch/powerpc/platforms/cell/spufs/sched.c
@@ -1072,7 +1072,7 @@ static int show_spu_loadavg(struct seq_file *s, void *private)
 		LOAD_INT(c), LOAD_FRAC(c),
 		count_active_contexts(),
 		atomic_read(&nr_spu_contexts),
-		idr_get_cursor(&task_active_pid_ns(current)->idr) - 1);
+		READ_ONCE(task_active_pid_ns(current)->pid_next) - 1);
 	return 0;
 }
 #endif
diff --git a/fs/proc/loadavg.c b/fs/proc/loadavg.c
index f32878d9a39f..62f89d549582 100644
--- a/fs/proc/loadavg.c
+++ b/fs/proc/loadavg.c
@@ -21,7 +21,7 @@ static int loadavg_proc_show(struct seq_file *m, void *v)
 		LOAD_INT(avnrun[1]), LOAD_FRAC(avnrun[1]),
 		LOAD_INT(avnrun[2]), LOAD_FRAC(avnrun[2]),
 		nr_running(), nr_threads,
-		idr_get_cursor(&task_active_pid_ns(current)->idr) - 1);
+		READ_ONCE(task_active_pid_ns(current)->pid_next) - 1);
 	return 0;
 }
 
diff --git a/include/linux/pid_namespace.h b/include/linux/pid_namespace.h
index 07481bb87d4e..82c72482019d 100644
--- a/include/linux/pid_namespace.h
+++ b/include/linux/pid_namespace.h
@@ -18,6 +18,7 @@ struct fs_pin;
 
 struct pid_namespace {
 	struct idr idr;
+	unsigned int pid_next;
 	struct rcu_head rcu;
 	unsigned int pid_allocated;
 	struct task_struct *child_reaper;
diff --git a/kernel/pid.c b/kernel/pid.c
index 72a6e9d0db81..409303ada383 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -75,6 +75,7 @@ int pid_max_max = PID_MAX_LIMIT;
 struct pid_namespace init_pid_ns = {
 	.ns.count = REFCOUNT_INIT(2),
 	.idr = IDR_INIT(init_pid_ns.idr),
+	.pid_next = 0,
 	.pid_allocated = PIDNS_ADDING,
 	.level = 0,
 	.child_reaper = &init_task,
@@ -208,7 +209,7 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t *set_tid,
 			 * init really needs pid 1, but after reaching the
 			 * maximum wrap back to RESERVED_PIDS
 			 */
-			if (idr_get_cursor(&tmp->idr) > RESERVED_PIDS)
+			if (tmp->pid_next > RESERVED_PIDS)
 				pid_min = RESERVED_PIDS;
 
 			/*
@@ -217,6 +218,7 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t *set_tid,
 			 */
 			nr = idr_alloc_cyclic(&tmp->idr, NULL, pid_min,
 					      pid_max, GFP_ATOMIC);
+			tmp->pid_next = nr + 1;
 		}
 		xa_unlock_irq(&tmp->idr.idr_rt);
 		idr_preload_end();
@@ -278,7 +280,7 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t *set_tid,
 
 		/* On failure to allocate the first pid, reset the state */
 		if (tmp == ns && tmp->pid_allocated == PIDNS_ADDING)
-			idr_set_cursor(&ns->idr, 0);
+			ns->pid_next = 0;
 
 		idr_remove(&tmp->idr, upid->nr);
 		xa_unlock_irq(&tmp->idr.idr_rt);
diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
index f4f8cb0435b4..a53d20c5c85e 100644
--- a/kernel/pid_namespace.c
+++ b/kernel/pid_namespace.c
@@ -272,12 +272,12 @@ static int pid_ns_ctl_handler(struct ctl_table *table, int write,
 	 * it should synchronize its usage with external means.
 	 */
 
-	next = idr_get_cursor(&pid_ns->idr) - 1;
+	next = READ_ONCE(pid_ns->pid_next) - 1;
 
 	tmp.data = &next;
 	ret = proc_dointvec_minmax(&tmp, write, buffer, lenp, ppos);
 	if (!ret && write)
-		idr_set_cursor(&pid_ns->idr, next + 1);
+		WRITE_ONCE(pid_ns->pid_next, next + 1);
 
 	return ret;
 }
-- 
2.35.3

