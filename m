Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9987F5A9E3D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 19:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234495AbiIARjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 13:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235137AbiIARh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 13:37:56 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 614A19CCC3
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 10:36:36 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id s4-20020a17090aa10400b001fe1cfc50f7so1728249pjp.9
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 10:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=UrxjF4stvOlBFlzO5LCraBZUw6+ypd0ZdM4ea92X40o=;
        b=bRQh8Am0cRUFMzevPI1RLDrAVB56xe5Pyl618ML1xG5UbYShnlVJ+JUC6EbLQY52Qs
         CIQg2N84xHgD40zt1+Fs+lh7e1EeSPRAe2LH3ariXyDtYJfOUFwmaa2nyKSPAMv4C2LL
         ixfdMT3qEKwsQzU0zWx46k2Kgwbo6qL2ZMjk9kwAzxSkMtv3E+2VRRPySs58VX6WIHgc
         UmMCPxZ+/fBN36M7ZZRa1nwJWHDtOFVZGjkXHsv+iTsKxj9Rn4GNhqh8P+D/9RlG7Da5
         L4TwcjQTaJ8DlcHg4rJEt6EYpCMy8N2APz0jZiSGuITg1YyaGh6hU+QCGH5FDg92dBPv
         Wubw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=UrxjF4stvOlBFlzO5LCraBZUw6+ypd0ZdM4ea92X40o=;
        b=F4V4AtTGvIyTmEcCFsziFNEFzwdXZ087u38L2VAHUngKq9ChavPOlYNSuDT2FUXU2f
         UcRAF4b6JXL9bJZfMq2O88+AqmoIyXcL07MnPu+NYl76hiImftkE4VNlFJ7YDZYVMj02
         S++GWh36GJBn/87Ht1XwG7QqAhfK9Mux9YB/icWFDNn2TesauE+efm7awfXGB1faUVQc
         6apnRwRebIJJ0Xvcpws/iz1SFypAysmBHZe64c+yrKqeqPKT5rhzrHnmiLEamhwaHUf+
         B1qa43DPDkdzYnwq7SIWrBZu+F4BulUGsnumrsRkY2L3JbEjNRYyYIDIq18w73ZL/pH0
         IC8A==
X-Gm-Message-State: ACgBeo1EvTvQG/nchCG01gb8He99YfPL3Fq8NesazkphOR0S+RxQ/TGC
        xm8rlYAVrqQjeIBxDHgv7uXMmj0Zluw=
X-Google-Smtp-Source: AA6agR7mDmCeuzlvD1IqXjWBDc5GDtYGg6tZms9fC4JNMJ+6ZNkDA7fZXZfEW+TFSrB8Qt+rbpDI3NajKAM=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:1bfc:e7ee:6530:4449])
 (user=surenb job=sendgmr) by 2002:aa7:804c:0:b0:536:80bb:8270 with SMTP id
 y12-20020aa7804c000000b0053680bb8270mr31869167pfm.13.1662053794990; Thu, 01
 Sep 2022 10:36:34 -0700 (PDT)
Date:   Thu,  1 Sep 2022 10:35:16 -0700
In-Reply-To: <20220901173516.702122-1-surenb@google.com>
Mime-Version: 1.0
References: <20220901173516.702122-1-surenb@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220901173516.702122-29-surenb@google.com>
Subject: [RFC PATCH RESEND 28/28] kernel/fork: throttle call_rcu() calls in vm_area_free
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        vbabka@suse.cz, hannes@cmpxchg.org, mgorman@suse.de,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        peterz@infradead.org, ldufour@linux.ibm.com,
        laurent.dufour@fr.ibm.com, paulmck@kernel.org, luto@kernel.org,
        songliubraving@fb.com, peterx@redhat.com, david@redhat.com,
        dhowells@redhat.com, hughd@google.com, bigeasy@linutronix.de,
        kent.overstreet@linux.dev, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        surenb@google.com, kernel-team@android.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

call_rcu() can take a long time when callback offloading is enabled.
Its use in the vm_area_free can cause regressions in the exit path when
multiple VMAs are being freed. To minimize that impact, place VMAs into
a list and free them in groups using one call_rcu() call per group.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/mm.h       |  1 +
 include/linux/mm_types.h | 11 ++++++-
 kernel/fork.c            | 68 +++++++++++++++++++++++++++++++++++-----
 mm/init-mm.c             |  3 ++
 mm/mmap.c                |  1 +
 5 files changed, 75 insertions(+), 9 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index a3cbaa7b9119..81dff694ac14 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -249,6 +249,7 @@ void setup_initial_init_mm(void *start_code, void *end_code,
 struct vm_area_struct *vm_area_alloc(struct mm_struct *);
 struct vm_area_struct *vm_area_dup(struct vm_area_struct *);
 void vm_area_free(struct vm_area_struct *);
+void drain_free_vmas(struct mm_struct *mm);
 
 #ifndef CONFIG_MMU
 extern struct rb_root nommu_region_tree;
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 36562e702baf..6f3effc493b1 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -412,7 +412,11 @@ struct vm_area_struct {
 			struct vm_area_struct *vm_next, *vm_prev;
 		};
 #ifdef CONFIG_PER_VMA_LOCK
-		struct rcu_head vm_rcu;	/* Used for deferred freeing. */
+		struct {
+			struct list_head vm_free_list;
+			/* Used for deferred freeing. */
+			struct rcu_head vm_rcu;
+		};
 #endif
 	};
 
@@ -573,6 +577,11 @@ struct mm_struct {
 					  */
 #ifdef CONFIG_PER_VMA_LOCK
 		int mm_lock_seq;
+		struct {
+			struct list_head head;
+			spinlock_t lock;
+			int size;
+		} vma_free_list;
 #endif
 
 
diff --git a/kernel/fork.c b/kernel/fork.c
index b443ba3a247a..7c88710aed72 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -483,26 +483,75 @@ struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
 }
 
 #ifdef CONFIG_PER_VMA_LOCK
-static void __vm_area_free(struct rcu_head *head)
+static inline void __vm_area_free(struct vm_area_struct *vma)
 {
-	struct vm_area_struct *vma = container_of(head, struct vm_area_struct,
-						  vm_rcu);
 	/* The vma should either have no lock holders or be write-locked. */
 	vma_assert_no_reader(vma);
 	kmem_cache_free(vm_area_cachep, vma);
 }
-#endif
+
+static void vma_free_rcu_callback(struct rcu_head *head)
+{
+	struct vm_area_struct *first_vma;
+	struct vm_area_struct *vma, *vma2;
+
+	first_vma = container_of(head, struct vm_area_struct, vm_rcu);
+	list_for_each_entry_safe(vma, vma2, &first_vma->vm_free_list, vm_free_list)
+		__vm_area_free(vma);
+	__vm_area_free(first_vma);
+}
+
+void drain_free_vmas(struct mm_struct *mm)
+{
+	struct vm_area_struct *first_vma;
+	LIST_HEAD(to_destroy);
+
+	spin_lock(&mm->vma_free_list.lock);
+	list_splice_init(&mm->vma_free_list.head, &to_destroy);
+	mm->vma_free_list.size = 0;
+	spin_unlock(&mm->vma_free_list.lock);
+
+	if (list_empty(&to_destroy))
+		return;
+
+	first_vma = list_first_entry(&to_destroy, struct vm_area_struct, vm_free_list);
+	/* Remove the head which is allocated on the stack */
+	list_del(&to_destroy);
+
+	call_rcu(&first_vma->vm_rcu, vma_free_rcu_callback);
+}
+
+#define VM_AREA_FREE_LIST_MAX	32
+
+void vm_area_free(struct vm_area_struct *vma)
+{
+	struct mm_struct *mm = vma->vm_mm;
+	bool drain;
+
+	free_anon_vma_name(vma);
+
+	spin_lock(&mm->vma_free_list.lock);
+	list_add(&vma->vm_free_list, &mm->vma_free_list.head);
+	mm->vma_free_list.size++;
+	drain = mm->vma_free_list.size > VM_AREA_FREE_LIST_MAX;
+	spin_unlock(&mm->vma_free_list.lock);
+
+	if (drain)
+		drain_free_vmas(mm);
+}
+
+#else /* CONFIG_PER_VMA_LOCK */
+
+void drain_free_vmas(struct mm_struct *mm) {}
 
 void vm_area_free(struct vm_area_struct *vma)
 {
 	free_anon_vma_name(vma);
-#ifdef CONFIG_PER_VMA_LOCK
-	call_rcu(&vma->vm_rcu, __vm_area_free);
-#else
 	kmem_cache_free(vm_area_cachep, vma);
-#endif
 }
 
+#endif /* CONFIG_PER_VMA_LOCK */
+
 static void account_kernel_stack(struct task_struct *tsk, int account)
 {
 	if (IS_ENABLED(CONFIG_VMAP_STACK)) {
@@ -1137,6 +1186,9 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 	INIT_LIST_HEAD(&mm->mmlist);
 #ifdef CONFIG_PER_VMA_LOCK
 	WRITE_ONCE(mm->mm_lock_seq, 0);
+	INIT_LIST_HEAD(&mm->vma_free_list.head);
+	spin_lock_init(&mm->vma_free_list.lock);
+	mm->vma_free_list.size = 0;
 #endif
 	mm_pgtables_bytes_init(mm);
 	mm->map_count = 0;
diff --git a/mm/init-mm.c b/mm/init-mm.c
index 8399f90d631c..7b6d2460545f 100644
--- a/mm/init-mm.c
+++ b/mm/init-mm.c
@@ -39,6 +39,9 @@ struct mm_struct init_mm = {
 	.mmlist		= LIST_HEAD_INIT(init_mm.mmlist),
 #ifdef CONFIG_PER_VMA_LOCK
 	.mm_lock_seq	= 0,
+	.vma_free_list.head = LIST_HEAD_INIT(init_mm.vma_free_list.head),
+	.vma_free_list.lock =  __SPIN_LOCK_UNLOCKED(init_mm.vma_free_list.lock),
+	.vma_free_list.size = 0,
 #endif
 	.user_ns	= &init_user_ns,
 	.cpu_bitmap	= CPU_BITS_NONE,
diff --git a/mm/mmap.c b/mm/mmap.c
index 1edfcd384f5e..d61b7ef84ba6 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3149,6 +3149,7 @@ void exit_mmap(struct mm_struct *mm)
 	}
 	mm->mmap = NULL;
 	mmap_write_unlock(mm);
+	drain_free_vmas(mm);
 	vm_unacct_memory(nr_accounted);
 }
 
-- 
2.37.2.789.g6183377224-goog

