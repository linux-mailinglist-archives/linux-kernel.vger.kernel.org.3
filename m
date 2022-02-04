Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B269E4A9DB8
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 18:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376932AbiBDRhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 12:37:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:41383 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1376916AbiBDRhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 12:37:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643996234;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=f37sp8k67ioGIXum6fUOSGh1d8pTCM6ppCENr8K01/s=;
        b=Cz7iHoMAylUAMKgDhi1oFSeS43kdBAoZsi0Nl/8uQ1g0e3XptYEI52aLR/FEy8q3Eld+5n
        lZ4htM+zeb/WN6WkV+7SbTVAZp/Jiu5xK+bccidgIsYYUJh7ZsGkNDmwxz9A9gtrG2VE5B
        wQrIHi6l4qMdTXDUMwsHNxHsieRQuvY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-287-_I94Z6IgOp6ipptPnyGMYg-1; Fri, 04 Feb 2022 12:37:10 -0500
X-MC-Unique: _I94Z6IgOp6ipptPnyGMYg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 71EF9835BC3;
        Fri,  4 Feb 2022 17:37:09 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-3.gru2.redhat.com [10.97.112.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9D7087DE5C;
        Fri,  4 Feb 2022 17:37:08 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 9747B41692C7; Fri,  4 Feb 2022 14:36:46 -0300 (-03)
Message-ID: <20220204173554.854482726@fedora.localdomain>
User-Agent: quilt/0.66
Date:   Fri, 04 Feb 2022 14:35:46 -0300
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
Subject: [patch v11 09/13] task isolation: add preempt notifier to sync per-CPU vmstat dirty info to thread info
References: <20220204173537.429902988@fedora.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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
+	if (raw_cpu_read(vmstat_dirty) == true)
+		set_thread_flag(TIF_TASK_ISOL);
+}
+EXPORT_SYMBOL_GPL(vmstat_dirty_to_thread_flag);
 #else
 static inline void mark_vmstat_dirty(void)
 {


