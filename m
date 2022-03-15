Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F01E4DA388
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 20:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351570AbiCOT5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 15:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351519AbiCOT4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 15:56:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0A44956204
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 12:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647374132;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=11ZGvbRdMwAjmMereTZNiKvEQrbqafG5t7TQxoW1W8Q=;
        b=Xh/FWeQExkUaKqy4GzAOPkvYstXkPSgwTDeffELLqvHyN8/I/dLA4G4YDfN6n1RVVn3WFo
        zSG++AC842fsh7plYblni+hESg+WTGLD49KSKTkn9ZQxh9k0lyMb5TG2H9thTkav2Xv54h
        eLhphki8s5aL/1Nk8TeoeL3jOxNb/SM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-6--AdV4uw1MyykfUnEWz_GLw-1; Tue, 15 Mar 2022 15:55:28 -0400
X-MC-Unique: -AdV4uw1MyykfUnEWz_GLw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 51EE93C19843;
        Tue, 15 Mar 2022 19:55:28 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-3.gru2.redhat.com [10.97.112.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1CF9AC4C7A0;
        Tue, 15 Mar 2022 19:55:28 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id C77DB4169512; Tue, 15 Mar 2022 12:33:58 -0300 (-03)
Message-ID: <20220315153314.333646565@fedora.localdomain>
User-Agent: quilt/0.66
Date:   Tue, 15 Mar 2022 12:31:45 -0300
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
Subject: [patch v12 13/13] task isolation: only TIF_TASK_ISOL if task isolation is enabled
References: <20220315153132.717153751@fedora.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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


