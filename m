Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E01146D7D5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 17:14:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236574AbhLHQSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 11:18:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54516 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236601AbhLHQSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 11:18:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638980082;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=3GwlbjlGkJHY9HG6AySVymplN56TpweIfVsKJFq53nU=;
        b=YJue4fw2Cvm2i5vN+xB2FyuEUe+PKkCx4mIZK6O1tm95Ta+06IpNkfbNgBnNMY+zpnIbB4
        86CVLWAQ2upWrXNOOSFnRS8Ucb06HNaGWtoj+If7jEflzejuOk6XEAYQQ75USmdjbixg27
        RfZp8E7OMVP0mSimnd7sk9Pt9aTGtbY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-182-AUyfdeSfOxe5Z0NKD8XMXw-1; Wed, 08 Dec 2021 11:14:39 -0500
X-MC-Unique: AUyfdeSfOxe5Z0NKD8XMXw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 46489101F7A1;
        Wed,  8 Dec 2021 16:14:38 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-3.gru2.redhat.com [10.97.112.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B055D1002390;
        Wed,  8 Dec 2021 16:14:10 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 42E36415EE6A; Wed,  8 Dec 2021 13:13:05 -0300 (-03)
Message-ID: <20211208161000.774386991@fuller.cnet>
User-Agent: quilt/0.66
Date:   Wed, 08 Dec 2021 13:09:11 -0300
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
Subject: [patch v8 05/10] task isolation: add hook to task exit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add task isolation specific hook to task exit routines.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

---
 include/linux/task_isolation.h |   11 +++++++++++
 kernel/exit.c                  |    2 ++
 kernel/fork.c                  |    1 +
 kernel/task_isolation.c        |    4 ++++
 4 files changed, 18 insertions(+)

Index: linux-2.6/kernel/exit.c
===================================================================
--- linux-2.6.orig/kernel/exit.c
+++ linux-2.6/kernel/exit.c
@@ -64,6 +64,7 @@
 #include <linux/compat.h>
 #include <linux/io_uring.h>
 #include <linux/kprobes.h>
+#include <linux/task_isolation.h>
 
 #include <linux/uaccess.h>
 #include <asm/unistd.h>
@@ -785,6 +786,7 @@ void __noreturn do_exit(long code)
 	}
 
 	io_uring_files_cancel();
+	tsk_isol_exit(tsk);
 	exit_signals(tsk);  /* sets PF_EXITING */
 
 	/* sync mm's RSS info before statistics gathering */
Index: linux-2.6/kernel/fork.c
===================================================================
--- linux-2.6.orig/kernel/fork.c
+++ linux-2.6/kernel/fork.c
@@ -2444,6 +2444,7 @@ bad_fork_free_pid:
 	if (pid != &init_struct_pid)
 		free_pid(pid);
 bad_fork_cleanup_task_isolation:
+	tsk_isol_exit(p);
 	tsk_isol_free(p);
 bad_fork_cleanup_thread:
 	exit_thread(p);
Index: linux-2.6/kernel/task_isolation.c
===================================================================
--- linux-2.6.orig/kernel/task_isolation.c
+++ linux-2.6/kernel/task_isolation.c
@@ -21,6 +21,10 @@
 #include <linux/mm.h>
 #include <linux/vmstat.h>
 
+void __tsk_isol_exit(struct task_struct *tsk)
+{
+}
+
 void __tsk_isol_free(struct task_struct *tsk)
 {
 	if (!tsk->isol_info)
Index: linux-2.6/include/linux/task_isolation.h
===================================================================
--- linux-2.6.orig/include/linux/task_isolation.h
+++ linux-2.6/include/linux/task_isolation.h
@@ -27,6 +27,13 @@ static inline void tsk_isol_free(struct
 		__tsk_isol_free(tsk);
 }
 
+void __tsk_isol_exit(struct task_struct *tsk);
+static inline void tsk_isol_exit(struct task_struct *tsk)
+{
+	if (tsk->isol_info)
+		__tsk_isol_exit(tsk);
+}
+
 int prctl_task_isolation_feat_get(unsigned long arg2, unsigned long arg3,
 				  unsigned long arg4, unsigned long arg5);
 int prctl_task_isolation_cfg_get(unsigned long arg2, unsigned long arg3,
@@ -57,6 +64,10 @@ static inline void tsk_isol_free(struct
 {
 }
 
+static inline void tsk_isol_exit(struct task_struct *tsk)
+{
+}
+
 static inline int prctl_task_isolation_feat_get(unsigned long arg2,
 						unsigned long arg3,
 						unsigned long arg4,


