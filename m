Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5660D4A9DB7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 18:37:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376929AbiBDRhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 12:37:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23092 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346481AbiBDRhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 12:37:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643996232;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=bPxELY9f1rlMmVJpyx0EHBimwlSNOJPDDdWa4BckiXk=;
        b=JZvwgrWvaf29Jinw+FM6vMS77QXVqEytIrXekdqfkWCVyWXjJgb0TThWM5zMoAy8oykOXX
        SURMmpPkpsn+baufls6nnRQJKLaLDFxS4fzIaHdfyAxPz6t7kR63nB24m72EGNo1Fji1cq
        XTEoHdxsJhFVhPwnpCAVOvo4sOVZDgA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-74-EWM31LrlOjWtUTdJDCjynA-1; Fri, 04 Feb 2022 12:37:11 -0500
X-MC-Unique: EWM31LrlOjWtUTdJDCjynA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7649A64145;
        Fri,  4 Feb 2022 17:37:09 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-3.gru2.redhat.com [10.97.112.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8F7B810A48C1;
        Fri,  4 Feb 2022 17:37:08 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 9168A4169537; Fri,  4 Feb 2022 14:36:46 -0300 (-03)
Message-ID: <20220204173554.809274542@fedora.localdomain>
User-Agent: quilt/0.66
Date:   Fri, 04 Feb 2022 14:35:45 -0300
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
Subject: [patch v11 08/13] task isolation: enable return to userspace processing
References: <20220204173537.429902988@fedora.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable processing of pending task isolation work if per-CPU vmstats
are out of sync with global vmstats.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

---

v11:
   Fold patch to add task_isol_exit hooks into
  "sync vmstats on return to userspace" patch.          (Frederic W. Weisbecker)

 include/linux/task_isolation.h |   22 +++++++++++++++++++++-
 kernel/task_isolation.c        |   13 +++++++++++++
 2 files changed, 34 insertions(+), 1 deletion(-)

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
 


