Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 117CD46DAE4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 19:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238761AbhLHSV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 13:21:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27232 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238782AbhLHSVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 13:21:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638987472;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=eh7hIXvlLrVY9VyTate/zWqD+zx7eGtk6Mm28VxINmo=;
        b=g85CZF5LGqoCcFzDNsAFkpVWz9c6JeosEPuk+VyE0PyaVvwMhpsfqNXEpGZcUG4UP25wE2
        IcPabIqsH9cgAqRQ8Tmt6iICqQhEJBPuwSOUg1V+9skqrAvNBg5R5GKB0mN2PP64rQ2YAL
        /Y/XUsjwNTJLNYMLdmszXRq8FAojroQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-44-Lb7kjGJWNUGoPSky2PSe0A-1; Wed, 08 Dec 2021 13:17:49 -0500
X-MC-Unique: Lb7kjGJWNUGoPSky2PSe0A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3C65310247A7;
        Wed,  8 Dec 2021 18:17:48 +0000 (UTC)
Received: from jsavitz-csb.redhat.com (unknown [10.22.35.120])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BB0F71F30E;
        Wed,  8 Dec 2021 18:17:18 +0000 (UTC)
From:   Joel Savitz <jsavitz@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Joel Savitz <jsavitz@redhat.com>, Waiman Long <longman@redhat.com>,
        linux-mm@kvack.org, Nico Pache <npache@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>
Subject: [PATCH v2] mm/oom_kill: wake futex waiters before annihilating victim shared mutex
Date:   Wed,  8 Dec 2021 13:17:14 -0500
Message-Id: <20211208181714.880312-1-jsavitz@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the case that two or more processes share a futex located within
a shared mmaped region, such as a process that shares a lock between
itself and a number of child processes, we have observed that when
a process holding the lock is oom killed, at least one waiter is never
alerted to this new development and simply continues to wait.

This is visible via pthreads by checking the __owner field of the
pthread_mutex_t structure within a waiting process, perhaps with gdb.

We identify reproduction of this issue by checking a waiting process of
a test program and viewing the contents of the pthread_mutex_t, taking note
of the value in the owner field, and then checking dmesg to see if the
owner has already been killed.

This issue can be tricky to reproduce, but with the modifications of
this small patch, I have found it to be impossible to reproduce. There
may be additional considerations that I have not taken into account in
this patch and I welcome any comments and criticism.

Changes from v1:
- add comments before calls to futex_exit_release()

Co-developed-by: Nico Pache <npache@redhat.com>
Signed-off-by: Nico Pache <npache@redhat.com>
Signed-off-by: Joel Savitz <jsavitz@redhat.com>
---
 mm/oom_kill.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 1ddabefcfb5a..884a5f15fd06 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -44,6 +44,7 @@
 #include <linux/kthread.h>
 #include <linux/init.h>
 #include <linux/mmu_notifier.h>
+#include <linux/futex.h>
 
 #include <asm/tlb.h>
 #include "internal.h"
@@ -885,6 +886,11 @@ static void __oom_kill_process(struct task_struct *victim, const char *message)
 	count_vm_event(OOM_KILL);
 	memcg_memory_event_mm(mm, MEMCG_OOM_KILL);
 
+	/*
+	 * We call futex_exit_release() on the victim task to ensure any waiters on any
+	 * process-shared futexes held by the victim task are woken up.
+	 */
+	futex_exit_release(victim);
 	/*
 	 * We should send SIGKILL before granting access to memory reserves
 	 * in order to prevent the OOM victim from depleting the memory
@@ -930,6 +936,12 @@ static void __oom_kill_process(struct task_struct *victim, const char *message)
 		 */
 		if (unlikely(p->flags & PF_KTHREAD))
 			continue;
+		/*
+		 * We call futex_exit_release() on any task p sharing the
+		 * victim->mm to ensure any waiters on any
+		 * process-shared futexes held by task p are woken up.
+		 */
+		futex_exit_release(p);
 		do_send_sig_info(SIGKILL, SEND_SIG_PRIV, p, PIDTYPE_TGID);
 	}
 	rcu_read_unlock();
-- 
2.27.0

