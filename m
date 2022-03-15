Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 895CD4DA393
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 20:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351629AbiCOT5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 15:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351595AbiCOT5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 15:57:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1C9CE56436
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 12:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647374144;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=SFA0aX9cGD48CfHcuic+RMDAM3RDbSgOQBi5s+CdCbk=;
        b=Lp1vPZYloig28gsZLXs2gkerMDAO3+8wAe8JYTkYUX1FIGJruXlYhHa4bU7h3wkjp0iLft
        pqwoVHy+p6P/7FClAdQTtyEkChtvPr7w1y1BQbJCIZPfQ3PK6b4XJtb9XHmLr51suyhtH9
        PAdkeI5X2H9GsruJSK2L5i4CsP0C7wM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-136-tuKAgMfgNmWVLTp1B5Q9AA-1; Tue, 15 Mar 2022 15:55:41 -0400
X-MC-Unique: tuKAgMfgNmWVLTp1B5Q9AA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 992B282A6C2;
        Tue, 15 Mar 2022 19:55:40 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-3.gru2.redhat.com [10.97.112.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EB08B30BA2;
        Tue, 15 Mar 2022 19:55:27 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id BF66E416EECB; Tue, 15 Mar 2022 12:33:58 -0300 (-03)
Message-ID: <20220315153314.130167792@fedora.localdomain>
User-Agent: quilt/0.66
Date:   Tue, 15 Mar 2022 12:31:41 -0300
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
        Oscar Shiang <oscar0225@livemail.tw>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [patch v12 09/13] task isolation: add preempt notifier to sync per-CPU vmstat dirty info to thread info
References: <20220315153132.717153751@fedora.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a thread has task isolation activated, is preempted by thread B,
which marks vmstat information dirty, and is preempted back in,
one might return to userspace with vmstat dirty information on the 
CPU in question.

To address this problem, add a preempt notifier that transfers vmstat dirty
information to TIF_TASK_ISOL thread flag.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

---

v12: 
 - switch from raw_cpu_read to __this_cpu_read (Frederic)

---
 include/linux/task_isolation.h |    2 ++
 include/linux/vmstat.h         |    6 ++++++
 kernel/task_isolation.c        |   23 +++++++++++++++++++++++
 mm/vmstat.c                    |    7 +++++++
 4 files changed, 38 insertions(+)

Index: linux-2.6/kernel/task_isolation.c
===================================================================
--- linux-2.6.orig/kernel/task_isolation.c
+++ linux-2.6/kernel/task_isolation.c
@@ -19,6 +19,7 @@
 #include <linux/sched/task.h>
 #include <linux/mm.h>
 #include <linux/vmstat.h>
+#include <linux/preempt.h>
 #include <linux/task_isolation.h>
 
 void __task_isol_exit(struct task_struct *tsk)
@@ -30,6 +31,9 @@ void __task_isol_exit(struct task_struct
 		return;
 
 	static_key_slow_dec(&vmstat_sync_enabled);
+
+	preempt_notifier_unregister(&i->preempt_notifier);
+	preempt_notifier_dec();
 }
 
 void __task_isol_free(struct task_struct *tsk)
@@ -40,6 +44,21 @@ void __task_isol_free(struct task_struct
 	tsk->task_isol_info = NULL;
 }
 
+static void task_isol_sched_in(struct preempt_notifier *pn, int cpu)
+{
+	vmstat_dirty_to_thread_flag();
+}
+
+static void task_isol_sched_out(struct preempt_notifier *pn,
+				struct task_struct *next)
+{
+}
+
+static __read_mostly struct preempt_ops task_isol_preempt_ops = {
+	.sched_in	= task_isol_sched_in,
+	.sched_out	= task_isol_sched_out,
+};
+
 static struct task_isol_info *task_isol_alloc_context(void)
 {
 	struct task_isol_info *info;
@@ -48,6 +67,10 @@ static struct task_isol_info *task_isol_
 	if (unlikely(!info))
 		return ERR_PTR(-ENOMEM);
 
+	preempt_notifier_inc();
+	preempt_notifier_init(&info->preempt_notifier, &task_isol_preempt_ops);
+	preempt_notifier_register(&info->preempt_notifier);
+
 	preempt_disable();
 	init_sync_vmstat();
 	preempt_enable();
Index: linux-2.6/include/linux/task_isolation.h
===================================================================
--- linux-2.6.orig/include/linux/task_isolation.h
+++ linux-2.6/include/linux/task_isolation.h
@@ -17,6 +17,8 @@ struct task_isol_info {
 	u64 oneshot_mask;
 
 	u8 inherit_mask;
+
+	struct preempt_notifier preempt_notifier;
 };
 
 extern void __task_isol_free(struct task_struct *tsk);
Index: linux-2.6/include/linux/vmstat.h
===================================================================
--- linux-2.6.orig/include/linux/vmstat.h
+++ linux-2.6/include/linux/vmstat.h
@@ -34,10 +34,16 @@ static inline void sync_vmstat(void)
 }
 
 void init_sync_vmstat(void);
+
+void vmstat_dirty_to_thread_flag(void);
 #else
 static inline void sync_vmstat(void)
 {
 }
+
+static inline void vmstat_dirty_to_thread_flag(void)
+{
+}
 #endif
 
 struct reclaim_stat {
Index: linux-2.6/mm/vmstat.c
===================================================================
--- linux-2.6.orig/mm/vmstat.c
+++ linux-2.6/mm/vmstat.c
@@ -353,6 +353,13 @@ void init_sync_vmstat(void)
 	set_thread_flag(TIF_TASK_ISOL);
 }
 EXPORT_SYMBOL_GPL(vmstat_dirty);
+
+void vmstat_dirty_to_thread_flag(void)
+{
+	if (__this_cpu_read(vmstat_dirty) == true)
+		set_thread_flag(TIF_TASK_ISOL);
+}
+EXPORT_SYMBOL_GPL(vmstat_dirty_to_thread_flag);
 #else
 static inline void mark_vmstat_dirty(void)
 {


