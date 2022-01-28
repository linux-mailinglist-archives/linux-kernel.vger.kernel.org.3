Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1244049FA7E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 14:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348819AbiA1NTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 08:19:18 -0500
Received: from server.lespinasse.org ([63.205.204.226]:40973 "EHLO
        server.lespinasse.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244456AbiA1NTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 08:19:08 -0500
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-52-ed;
 t=1643375407; h=from : to : cc : subject : date : message-id :
 in-reply-to : references : mime-version : content-transfer-encoding :
 from; bh=IpgfV+Eq7IPQY0KnkKUe0KkKJvFgOUOWn3NBKGqibKI=;
 b=IctmLJgF3nwhCdB6/nN2BKCbg/+ri5TtsREb7+zxwUF2hZZ/LIaVfPhxghmetQ7a/3M3q
 Q9VY54et8G/l7GVBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-52-rsa; t=1643375407; h=from : to
 : cc : subject : date : message-id : in-reply-to : references :
 mime-version : content-transfer-encoding : from;
 bh=IpgfV+Eq7IPQY0KnkKUe0KkKJvFgOUOWn3NBKGqibKI=;
 b=FUNzHOA9sCQEnD5fVX1ed8sbazmtJonEYYM3h4apZTLILl70sj90JbvB3WRW8tXEGINiv
 IzWe9oPGLIvbeoIBpr9CdyIGkNvw0FYKFNdqK61xuYDoKOkBCEVO0ytOejTTj5Eu2J2FeQV
 SzNS0w/kdVod39/vbZHvGCL1X6e9d3nbT8J96MVYI96Lr29e+Mg2IDmWtjnSTVWX883uarj
 n5hllQbi6wTh0FF/uhaA2q+Ct6pIwn/7yizD86pU4Px2VTdvxBK3QaA4JKP5yjI3PylzCqJ
 gMcCeqKorC8BG/Wp7pQbWsbL/vTP+8SdVKrYWbX00ASCHnKCyqKiI+vLP7XA==
Received: from zeus.lespinasse.org (zeus.lespinasse.org [IPv6:fd00::150:0])
        by server.lespinasse.org (Postfix) with ESMTPS id 02248160967;
        Fri, 28 Jan 2022 05:10:07 -0800 (PST)
Received: by zeus.lespinasse.org (Postfix, from userid 1000)
        id DF25420473; Fri, 28 Jan 2022 05:10:06 -0800 (PST)
From:   Michel Lespinasse <michel@lespinasse.org>
To:     Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel-team@fb.com, Laurent Dufour <ldufour@linux.ibm.com>,
        Jerome Glisse <jglisse@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Matthew Wilcox <willy@infradead.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        Rik van Riel <riel@surriel.com>,
        Paul McKenney <paulmck@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Minchan Kim <minchan@google.com>,
        Joel Fernandes <joelaf@google.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Michel Lespinasse <michel@lespinasse.org>
Subject: [PATCH v2 11/35] mm: rcu safe vma freeing
Date:   Fri, 28 Jan 2022 05:09:42 -0800
Message-Id: <20220128131006.67712-12-michel@lespinasse.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220128131006.67712-1-michel@lespinasse.org>
References: <20220128131006.67712-1-michel@lespinasse.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This prepares for speculative page faults looking up and copying vmas
under protection of an rcu read lock, instead of the usual mmap read lock.

Note - it might also be feasible to just use SLAB_TYPESAFE_BY_RCU when
creating the vm_area_cachep, but that's probably too subtle to consider here.

Signed-off-by: Michel Lespinasse <michel@lespinasse.org>
---
 include/linux/mm_types.h | 16 +++++++++++-----
 kernel/fork.c            | 13 +++++++++++++
 2 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index e4965a6f34f2..b6678578a729 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -374,12 +374,18 @@ struct anon_vma_name {
 struct vm_area_struct {
 	/* The first cache line has the info for VMA tree walking. */
 
-	unsigned long vm_start;		/* Our start address within vm_mm. */
-	unsigned long vm_end;		/* The first byte after our end address
-					   within vm_mm. */
+	union {
+		struct {
+			/* VMA covers [vm_start; vm_end) addresses within mm */
+			unsigned long vm_start, vm_end;
 
-	/* linked list of VM areas per task, sorted by address */
-	struct vm_area_struct *vm_next, *vm_prev;
+			/* linked list of VMAs per task, sorted by address */
+			struct vm_area_struct *vm_next, *vm_prev;
+		};
+#ifdef CONFIG_SPECULATIVE_PAGE_FAULT
+		struct rcu_head vm_rcu;	/* Used for deferred freeing. */
+#endif
+	};
 
 	struct rb_node vm_rb;
 
diff --git a/kernel/fork.c b/kernel/fork.c
index d75a528f7b21..2e5f2e8de31a 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -371,10 +371,23 @@ struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
 	return new;
 }
 
+#ifdef CONFIG_SPECULATIVE_PAGE_FAULT
+static void __vm_area_free(struct rcu_head *head)
+{
+	struct vm_area_struct *vma = container_of(head, struct vm_area_struct,
+						  vm_rcu);
+	kmem_cache_free(vm_area_cachep, vma);
+}
+#endif
+
 void vm_area_free(struct vm_area_struct *vma)
 {
 	free_vma_anon_name(vma);
+#ifdef CONFIG_SPECULATIVE_PAGE_FAULT
+	call_rcu(&vma->vm_rcu, __vm_area_free);
+#else
 	kmem_cache_free(vm_area_cachep, vma);
+#endif
 }
 
 static void account_kernel_stack(struct task_struct *tsk, int account)
-- 
2.20.1

