Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 904BC46C6F0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 22:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237418AbhLGVwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 16:52:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22794 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233143AbhLGVwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 16:52:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638913762;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=CX58STuwWUvztel/WIu3ObHN0spPnA8pV3NfShj5KKc=;
        b=FSIi644MmbMNIRMj+AwxADxvt3iWkc5e9itGDTgpDaMxkp8GFghnGhdFmv4wKTtFSa3uUx
        giJlCZiEU3IOU9s+ZLOmJdCyT0RjwbtFKl68U28qrWNel3970VPmRy9j5fKA9gG9CuVjeU
        AJRgeHeiUL4pDamPzyeJ8cGY8PfaeS8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-190-vUWu7b_yPruu1wGPRYkJKg-1; Tue, 07 Dec 2021 16:49:19 -0500
X-MC-Unique: vUWu7b_yPruu1wGPRYkJKg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 599EB81CCB6;
        Tue,  7 Dec 2021 21:49:18 +0000 (UTC)
Received: from jsavitz-csb.redhat.com (unknown [10.22.35.120])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D0E7D71C84;
        Tue,  7 Dec 2021 21:49:12 +0000 (UTC)
From:   Joel Savitz <jsavitz@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Joel Savitz <jsavitz@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Waiman Long <longman@redhat.com>, linux-mm@kvack.org,
        Nico Pache <npache@redhat.com>
Subject: [PATCH] mm/oom_kill: wake futex waiters before annihilating victim shared mutex
Date:   Tue,  7 Dec 2021 16:49:02 -0500
Message-Id: <20211207214902.772614-1-jsavitz@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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

Co-developed-by: Nico Pache <npache@redhat.com>
Signed-off-by: Nico Pache <npache@redhat.com>
Signed-off-by: Joel Savitz <jsavitz@redhat.com>
---
 mm/oom_kill.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 1ddabefcfb5a..fa58bd10a0df 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -44,6 +44,7 @@
 #include <linux/kthread.h>
 #include <linux/init.h>
 #include <linux/mmu_notifier.h>
+#include <linux/futex.h>
 
 #include <asm/tlb.h>
 #include "internal.h"
@@ -890,6 +891,7 @@ static void __oom_kill_process(struct task_struct *victim, const char *message)
 	 * in order to prevent the OOM victim from depleting the memory
 	 * reserves from the user space under its control.
 	 */
+	futex_exit_release(victim);
 	do_send_sig_info(SIGKILL, SEND_SIG_PRIV, victim, PIDTYPE_TGID);
 	mark_oom_victim(victim);
 	pr_err("%s: Killed process %d (%s) total-vm:%lukB, anon-rss:%lukB, file-rss:%lukB, shmem-rss:%lukB, UID:%u pgtables:%lukB oom_score_adj:%hd\n",
@@ -930,6 +932,7 @@ static void __oom_kill_process(struct task_struct *victim, const char *message)
 		 */
 		if (unlikely(p->flags & PF_KTHREAD))
 			continue;
+		futex_exit_release(p);
 		do_send_sig_info(SIGKILL, SEND_SIG_PRIV, p, PIDTYPE_TGID);
 	}
 	rcu_read_unlock();
-- 
2.33.1

