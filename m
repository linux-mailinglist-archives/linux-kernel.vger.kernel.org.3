Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3291149E8F3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 18:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244524AbiA0R0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 12:26:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:42310 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241133AbiA0R0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 12:26:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643304392;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=dgsWaQr/NkQLog8W7vYgkQvbcOPNol03vC+ciwqcHqQ=;
        b=dE9sXd1Bzv3X+i2XFdouxuPRcdZuakw0PL+Cpbp9SHCWF821hKXQVbqtKW6s5ceUBYEiH1
        t//qA/aMkhi0SnDuUIiWowBhQaZ8vRgO6w5jxuv4xQN+YXM/8YEbjIxyrYxP3++s3fkiwa
        kNuRWz1cEE3G58IttdiWRQ0aBWZZPHY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-433-5jb40vi4NOSDivTScWW_Ew-1; Thu, 27 Jan 2022 12:26:29 -0500
X-MC-Unique: 5jb40vi4NOSDivTScWW_Ew-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 778821083F71;
        Thu, 27 Jan 2022 17:26:27 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-4.gru2.redhat.com [10.97.112.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 31EED84D2F;
        Thu, 27 Jan 2022 17:26:27 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 9E8B94168B9E; Thu, 27 Jan 2022 14:26:05 -0300 (-03)
Message-ID: <20220127172552.512231879@fuller.cnet>
User-Agent: quilt/0.66
Date:   Thu, 27 Jan 2022 14:23:26 -0300
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
Subject: [patch v9 07/10] task isolation: enable return to userspace processing
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The logic to disable vmstat worker thread, when entering
nohz full, does not cover all scenarios. For example, it is possible
for the following to happen:
References: <20220127172319.428529308@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

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
 


