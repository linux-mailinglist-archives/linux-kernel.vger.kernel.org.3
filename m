Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD0F949E938
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 18:40:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232243AbiA0Rj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 12:39:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:59989 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238830AbiA0RjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 12:39:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643305159;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=uqLSaV3CsB09wRgNJfX+VAHmFMOGF+YL37fc8a7NW3Y=;
        b=WlJ1e7pk2uavm0kFExHRZ0iU6bqMnEruwJ2moB0Z5JO4Fq7sQP58zov9Z3kaXivvUo7puq
        bkcjJT3lrp9V3NfvLkEy+WJ5G8Wf8o6fQdDA9MCBRlBwUkStldPGPzx+g64J9zuPfk9mN+
        QO8CWPg0WzdhDfQcGhPDbF8Q+86Kk5s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-389-XyRGIXddNvWWMHBS88zNTw-1; Thu, 27 Jan 2022 12:39:18 -0500
X-MC-Unique: XyRGIXddNvWWMHBS88zNTw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A013918C8C03;
        Thu, 27 Jan 2022 17:39:16 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-4.gru2.redhat.com [10.97.112.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 477E3838DE;
        Thu, 27 Jan 2022 17:38:44 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 3968E4168B9E; Thu, 27 Jan 2022 14:38:05 -0300 (-03)
Message-ID: <20220127173206.785498087@fedora.localdomain>
User-Agent: quilt/0.66
Date:   Thu, 27 Jan 2022 14:30:44 -0300
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
Subject: [patch v10 07/10] task isolation: enable return to userspace processing
References: <20220127173037.318440631@fedora.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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
 struct task_isol_info {
 	/* Which features have been configured */
 	u64 conf_mask;
@@ -110,7 +113,24 @@ static inline int prctl_task_isol_activa
 
 static inline int task_isol_has_work(void)
 {
-	return 0;
+	int cpu, ret;
+	struct isol_info *i;
+
+	if (likely(current->task_isol_info == NULL))
+		return 0;
+
+	i = current->task_isol_info;
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
 
 #endif /* CONFIG_CPU_ISOLATION */
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
 
 void __task_isol_exit(struct task_struct *tsk)
 {
+	struct task_isol_info *i;
+
+	i = tsk->task_isol_info;
+	if (!i)
+		return;
+
+	static_key_slow_dec(&vmstat_sync_enabled);
 }
 
 void __task_isol_free(struct task_struct *tsk)
@@ -41,6 +48,12 @@ static struct task_isol_info *task_isol_
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
 


