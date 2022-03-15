Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B64CB4DA38F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 20:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351584AbiCOT5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 15:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351597AbiCOT5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 15:57:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 613D356438
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 12:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647374144;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=bPxELY9f1rlMmVJpyx0EHBimwlSNOJPDDdWa4BckiXk=;
        b=V6J0r4KrbE2W58Aa7U4QHIaQmNQipNPzeEFHQ8M9/NLmlubApu5ZBfV5LV82GhRnLhbqmb
        4z/oqOMQtOvBZWRT6z5OSPQXYM5BPz1w2/sZr63N+gm/+ATX1XIvb+zSgJSrlua4GHlhFu
        Wtvlwl8wXpblfZkd5a+k9QcE0ZtmC6s=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-160-6q6eCT3bOg6UZy9u8UNH_A-1; Tue, 15 Mar 2022 15:55:41 -0400
X-MC-Unique: 6q6eCT3bOg6UZy9u8UNH_A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9747138035AF;
        Tue, 15 Mar 2022 19:55:40 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-3.gru2.redhat.com [10.97.112.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B9B7630B9D;
        Tue, 15 Mar 2022 19:55:27 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id BD07B416EEC5; Tue, 15 Mar 2022 12:33:58 -0300 (-03)
Message-ID: <20220315153314.088347398@fedora.localdomain>
User-Agent: quilt/0.66
Date:   Tue, 15 Mar 2022 12:31:40 -0300
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
Subject: [patch v12 08/13] task isolation: enable return to userspace processing
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
 


