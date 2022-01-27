Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1410F49E932
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 18:38:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244716AbiA0Riy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 12:38:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60979 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244719AbiA0Rit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 12:38:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643305128;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=yyiImUTBA6C7IpyRzvCAexbsTFF5x6J/eJdnX++S/H8=;
        b=HbW+jQ2hvgm44ErVWjgRc7POgw7FgBHu4NhTxbydDWScCq1IKWk1MJ0tDlslsH+zf4jsBQ
        GGNFgyKuRusGIpTtq6kuFP7xCZI94OhKpnnMCsfDXnshyKpcjMn8s1hclmylPfBTQfvVRR
        vwM2xkR0Q9LB8re5Gd1F9lQtE9xEPX4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-52-mLfD9zO5OjeLVFvjAOkxDg-1; Thu, 27 Jan 2022 12:38:45 -0500
X-MC-Unique: mLfD9zO5OjeLVFvjAOkxDg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 06B2484DA4F;
        Thu, 27 Jan 2022 17:38:44 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-4.gru2.redhat.com [10.97.112.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 03F1874E9E;
        Thu, 27 Jan 2022 17:38:41 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 2F4BD416D8BE; Thu, 27 Jan 2022 14:38:05 -0300 (-03)
Message-ID: <20220127173206.645742130@fedora.localdomain>
User-Agent: quilt/0.66
Date:   Thu, 27 Jan 2022 14:30:42 -0300
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
Subject: [patch v10 05/10] task isolation: add hook to task exit
References: <20220127173037.318440631@fedora.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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
@@ -759,6 +760,7 @@ void __noreturn do_exit(long code)
 	validate_creds_for_do_exit(tsk);
 
 	io_uring_files_cancel();
+	task_isol_exit(tsk);
 	exit_signals(tsk);  /* sets PF_EXITING */
 
 	/* sync mm's RSS info before statistics gathering */
Index: linux-2.6/kernel/fork.c
===================================================================
--- linux-2.6.orig/kernel/fork.c
+++ linux-2.6/kernel/fork.c
@@ -2417,6 +2417,7 @@ bad_fork_free_pid:
 	if (pid != &init_struct_pid)
 		free_pid(pid);
 bad_fork_cleanup_task_isol:
+	task_isol_exit(p);
 	task_isol_free(p);
 bad_fork_cleanup_thread:
 	exit_thread(p);
Index: linux-2.6/kernel/task_isolation.c
===================================================================
--- linux-2.6.orig/kernel/task_isolation.c
+++ linux-2.6/kernel/task_isolation.c
@@ -21,6 +21,10 @@
 #include <linux/mm.h>
 #include <linux/vmstat.h>
 
+void __task_isol_exit(struct task_struct *tsk)
+{
+}
+
 void __task_isol_free(struct task_struct *tsk)
 {
 	if (!tsk->task_isol_info)
Index: linux-2.6/include/linux/task_isolation.h
===================================================================
--- linux-2.6.orig/include/linux/task_isolation.h
+++ linux-2.6/include/linux/task_isolation.h
@@ -27,6 +27,13 @@ static inline void task_isol_free(struct
 		__task_isol_free(tsk);
 }
 
+void __task_isol_exit(struct task_struct *tsk);
+static inline void task_isol_exit(struct task_struct *tsk)
+{
+       if (tsk->task_isol_info)
+               __task_isol_exit(tsk);
+}
+
 int prctl_task_isol_feat_get(unsigned long arg2, unsigned long arg3,
 			     unsigned long arg4, unsigned long arg5);
 int prctl_task_isol_cfg_get(unsigned long arg2, unsigned long arg3,
@@ -57,6 +64,10 @@ static inline void task_isol_free(struct
 {
 }
 
+static inline void task_isol_exit(struct task_struct *tsk)
+{
+}
+
 static inline int prctl_task_isol_feat_get(unsigned long arg2,
 					   unsigned long arg3,
 					   unsigned long arg4,


