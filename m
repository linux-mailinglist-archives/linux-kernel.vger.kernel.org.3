Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 538FC46D7D4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 17:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236594AbhLHQSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 11:18:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:43621 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236592AbhLHQSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 11:18:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638980080;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=gG+Qgmj41QKbfu4/ncmy3COcngGAOz1poOt1zBFgMzo=;
        b=TzPSjme/SpZ8s0l9LoKxu4XHy35AVfgI0gElpgQKz4SZAyfaYWYLI4y0Ulpm0P/rQetcVy
        fiEO1y/h/9DHryJi17WQTEluO9EvGUBrAO9QMyhhL7WgJr0lOr3twPZpdUxhM9kKwyTaCE
        ppK/uRDhcatSzx+hEg3lvemmbVFSde8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-515-11Bck1CNPo6G82p2v1GT6g-1; Wed, 08 Dec 2021 11:14:37 -0500
X-MC-Unique: 11Bck1CNPo6G82p2v1GT6g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 88DE3101F7A4;
        Wed,  8 Dec 2021 16:14:36 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-3.gru2.redhat.com [10.97.112.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B069D4ABB5;
        Wed,  8 Dec 2021 16:14:10 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 45B8B415EE6C; Wed,  8 Dec 2021 13:13:05 -0300 (-03)
Message-ID: <20211208161000.835187228@fuller.cnet>
User-Agent: quilt/0.66
Date:   Wed, 08 Dec 2021 13:09:13 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Nitesh Lal <nilal@redhat.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Belits <abelits@belits.com>, Peter Xu <peterx@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [patch v8 07/10] task isolation: enable return to userspace processing
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable processing of pending task isolation work if per-CPU vmstats
are out of sync with global vmstats.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

---
 include/linux/task_isolation.h |   22 +++++++++++++++++++++-
 kernel/task_isolation.c        |   13 +++++++++++++
 2 files changed, 34 insertions(+), 1 deletion(-)

Index: linux-2.6/include/linux/task_isolation.h
===================================================================
--- linux-2.6.orig/include/linux/task_isolation.h
+++ linux-2.6/include/linux/task_isolation.h
@@ -5,6 +5,9 @@
 
 #ifdef CONFIG_CPU_ISOLATION
 
+#include <linux/vmstat.h>
+#include <uapi/linux/prctl.h>
+
 struct isol_info {
 	/* Which features have been configured */
 	u64 conf_mask;
@@ -51,7 +54,24 @@ void isolation_exit_to_user_mode(void);
 
 static inline int task_isol_has_work(void)
 {
-	return 0;
+	int cpu, ret;
+	struct isol_info *i;
+
+	if (likely(current->isol_info == NULL))
+		return 0;
+
+	i = current->isol_info;
+	if (i->active_mask != ISOL_F_QUIESCE)
+		return 0;
+
+	if (!(i->quiesce_mask & ISOL_F_QUIESCE_VMSTATS))
+		return 0;
+
+	cpu = get_cpu();
+	ret = per_cpu(vmstat_dirty, cpu);
+	put_cpu();
+
+	return ret;
 }
 
 #else
Index: linux-2.6/kernel/task_isolation.c
===================================================================
--- linux-2.6.orig/kernel/task_isolation.c
+++ linux-2.6/kernel/task_isolation.c
@@ -10,7 +10,6 @@
  */
 
 #include <linux/sched.h>
-#include <linux/task_isolation.h>
 #include <linux/prctl.h>
 #include <linux/slab.h>
 #include <linux/kobject.h>
@@ -20,9 +19,17 @@
 #include <linux/sched/task.h>
 #include <linux/mm.h>
 #include <linux/vmstat.h>
+#include <linux/task_isolation.h>
 
 void __tsk_isol_exit(struct task_struct *tsk)
 {
+	struct isol_info *i;
+
+	i = tsk->isol_info;
+	if (!i)
+		return;
+
+	static_key_slow_dec(&vmstat_sync_enabled);
 }
 
 void __tsk_isol_free(struct task_struct *tsk)
@@ -41,6 +48,12 @@ static struct isol_info *tsk_isol_alloc_
 	if (unlikely(!info))
 		return ERR_PTR(-ENOMEM);
 
+	preempt_disable();
+	init_sync_vmstat();
+	preempt_enable();
+
+	static_key_slow_inc(&vmstat_sync_enabled);
+
 	return info;
 }
 


