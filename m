Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C79A4A9DBD
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 18:37:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377025AbiBDRhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 12:37:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31082 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1376955AbiBDRhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 12:37:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643996239;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=11ZGvbRdMwAjmMereTZNiKvEQrbqafG5t7TQxoW1W8Q=;
        b=i+P3ggJASmLKIF+bs624s1+ExQmoZAsQK9wTNo0yErUB8kRjExc9praPKWskCa6qMdBrO9
        BcBtK4Fod1WhUOIh5IGUq09I+ComBNkiV/hEw8oia1fvQQFmB1MveIGOjLuYnb9R3Vx8Ej
        FyS+CEVbcDkw5YvlDrTOkRm1hD5Eq7k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-182-Pli_7vnqOv20C22K6TYZLQ-1; Fri, 04 Feb 2022 12:37:16 -0500
X-MC-Unique: Pli_7vnqOv20C22K6TYZLQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A5C3B8710FC;
        Fri,  4 Feb 2022 17:37:14 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-3.gru2.redhat.com [10.97.112.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EF53782766;
        Fri,  4 Feb 2022 17:37:13 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id AA0864171304; Fri,  4 Feb 2022 14:36:46 -0300 (-03)
Message-ID: <20220204173555.047244789@fedora.localdomain>
User-Agent: quilt/0.66
Date:   Fri, 04 Feb 2022 14:35:50 -0300
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
Subject: [patch v11 13/13] task isolation: only TIF_TASK_ISOL if task isolation is enabled
References: <20220204173537.429902988@fedora.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This avoids processing of TIF_TASK_ISOL, when returning to userspace,
for tasks which do not have task isolation configured.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

Index: linux-2.6/include/linux/task_isolation.h
===================================================================
--- linux-2.6.orig/include/linux/task_isolation.h
+++ linux-2.6/include/linux/task_isolation.h
@@ -5,6 +5,8 @@
 
 #ifdef CONFIG_TASK_ISOLATION
 
+#include <uapi/linux/prctl.h>
+
 struct task_isol_info {
 	/* Which features have been configured */
 	u64 conf_mask;
@@ -51,6 +53,24 @@ int __copy_task_isol(struct task_struct
 
 void task_isol_exit_to_user_mode(void);
 
+static inline bool task_isol_quiesce_activated(struct task_struct *tsk,
+					       u64 quiesce_mask)
+{
+	struct task_isol_info *i;
+
+	i = tsk->task_isol_info;
+	if (!i)
+		return false;
+
+	if (i->active_mask != ISOL_F_QUIESCE)
+		return false;
+
+	if ((i->quiesce_mask & quiesce_mask) == quiesce_mask)
+		return true;
+
+	return false;
+}
+
 #else
 
 static inline void task_isol_exit_to_user_mode(void)
@@ -105,6 +125,12 @@ static inline int prctl_task_isol_activa
 	return -EOPNOTSUPP;
 }
 
+static inline bool task_isol_quiesce_activated(struct task_struct *tsk,
+					       u64 quiesce_mask)
+{
+	return false;
+}
+
 #endif /* CONFIG_TASK_ISOLATION */
 
 #endif /* __LINUX_TASK_ISOL_H */
Index: linux-2.6/mm/vmstat.c
===================================================================
--- linux-2.6.orig/mm/vmstat.c
+++ linux-2.6/mm/vmstat.c
@@ -28,6 +28,7 @@
 #include <linux/mm_inline.h>
 #include <linux/page_ext.h>
 #include <linux/page_owner.h>
+#include <linux/task_isolation.h>
 
 #include "internal.h"
 
@@ -344,7 +345,8 @@ static inline void mark_vmstat_dirty(voi
 		return;
 
 	raw_cpu_write(vmstat_dirty, true);
-	set_thread_flag(TIF_TASK_ISOL);
+	if (task_isol_quiesce_activated(current, ISOL_F_QUIESCE_VMSTATS))
+		set_thread_flag(TIF_TASK_ISOL);
 }
 
 void init_sync_vmstat(void)


