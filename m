Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9185A5619
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 23:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbiH2V0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 17:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbiH2V0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 17:26:04 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD77857884
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 14:25:45 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id p8-20020a170902e74800b0017307429ca3so6839759plf.17
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 14:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc;
        bh=N9bIms4Zgtt1w5mfZvOohRmDSgEYydYD4bEwHw/V5ow=;
        b=CDYqj2724k+j3UZuEqBII6d0mYlErNKF+DONYkTH+E04Ngvdyx6CFcIzGI3JpE+Ocv
         IfFz52ELd/oHC5JbA4KJiqR41o93UU1oNs91Ejb3C2WUYMd8rJbvn4wGpH2TVPFpMmJT
         SgaAVJGTguR7jHY2klbLNlMZG17tv+P143dcZzCLTWGQf5RYnpB7E01bhfNNtgZSKJd4
         8iRdR4KuZii8bgu+gGfhXIXfMfDbZfPU8zkTguml14FGrqbs//qWRwWzX5xJRRQfxW3M
         XOIZ22KxRY8zlSKN1mF3msZnGKAdWpIuRmlb/EMY5nhFhrrOHs7u2uNNMJtGec19XB/4
         ScVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=N9bIms4Zgtt1w5mfZvOohRmDSgEYydYD4bEwHw/V5ow=;
        b=yco3RAXEBf0k8WkDJ3iuJyBlDhkokQJoBW8rheLvyqDRcgVSNOrrG3A69kvPsHlpf2
         rWoNfaeIrw7H0m24xWuo19vtNKUsb9hALeylcXGG9OnJ7jtOLLiTE5iuTo6+zEu4no2b
         J4Dt7yQsbRd8gneTnybvLHUGypxdCRybiNGhJX+bKsyMVWTTvbd9W+Wr3g84Z9FBt1Ty
         N/1lkz7JINOKu4E64EC7oQSRmjF+EB0axQnCUg2GDWXO0ndhrDwt+t3FGi7DkiVeYEEU
         YIvFibP6zb79mv3UAd7gFM3EIVvcSicXL7z7D9UvNPwd+JA5lD9yZK0KQiw5W3cLcZSn
         9EUw==
X-Gm-Message-State: ACgBeo3KMhRyBVPc32WWPZhbTSIkmLAa8z5EY51lK+ZFxb3na+BKe7tj
        tNv7yofd+zdjsFliwxfdyVduBQHHob2Mer74DWQRG1CWysKPaYyUr5lQ4oX+09VagwT0gYvgUiy
        5l77Q6TWbUMceNp4Nuf/L
X-Google-Smtp-Source: AA6agR7o7Ix1gbIIukXoy+30trWr4dJQ0Q9jpP73SljSWj/tMusjSLFwSN2Bk21+x1fzs5P+BkoH3vuJaG0=
X-Received: from surenb-spec.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e30])
 (user=surenb job=sendgmr) by 2002:aa7:8a0b:0:b0:537:f5f1:fd91 with SMTP id
 m11-20020aa78a0b000000b00537f5f1fd91mr12449109pfa.41.1661808344609; Mon, 29
 Aug 2022 14:25:44 -0700 (PDT)
Date:   Mon, 29 Aug 2022 21:25:08 +0000
In-Reply-To: <20220829212531.3184856-1-surenb@google.com>
Mime-Version: 1.0
References: <20220829212531.3184856-1-surenb@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220829212531.3184856-6-surenb@google.com>
Subject: [RFC PATCH 05/28] mm: add per-VMA lock and helper functions to
 control it
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        vbabka@suse.cz, hannes@cmpxchg.org, mgorman@techsingularity.net,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        peterz@infradead.org, ldufour@linux.ibm.com,
        laurent.dufour@fr.ibm.com, paulmck@kernel.org, riel@surriel.com,
        luto@kernel.org, songliubraving@fb.com, peterx@redhat.com,
        david@redhat.com, dhowells@redhat.com, hughd@google.com,
        bigeasy@linutronix.de, kent.overstreet@linux.dev,
        rientjes@google.com, axelrasmussen@google.com, joelaf@google.com,
        minchan@google.com, surenb@google.com, kernel-team@android.com,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-ccpol: medium
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a per-VMA rw_semaphore to be used during page fault handling
instead of mmap_lock. Because there are cases when multiple VMAs need
to be exclusively locked during VMA tree modifications, instead of the
usual lock/unlock patter we mark a VMA as locked by taking per-VMA lock
exclusively and setting vma->lock_seq to the current mm->lock_seq. When
mmap_write_lock holder is done with all modifications and drops mmap_lock,
it will increment mm->lock_seq, effectively unlocking all VMAs marked as
locked.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/mm.h        | 78 +++++++++++++++++++++++++++++++++++++++
 include/linux/mm_types.h  |  7 ++++
 include/linux/mmap_lock.h | 13 +++++++
 kernel/fork.c             |  4 ++
 mm/init-mm.c              |  3 ++
 5 files changed, 105 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7d322a979455..476bf936c5f0 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -611,6 +611,83 @@ struct vm_operations_struct {
 					  unsigned long addr);
 };
 
+#ifdef CONFIG_PER_VMA_LOCK
+static inline void vma_init_lock(struct vm_area_struct *vma)
+{
+	init_rwsem(&vma->lock);
+	vma->vm_lock_seq = -1;
+}
+
+static inline void vma_mark_locked(struct vm_area_struct *vma)
+{
+	int mm_lock_seq;
+
+	mmap_assert_write_locked(vma->vm_mm);
+
+	/*
+	 * current task is holding mmap_write_lock, both vma->vm_lock_seq and
+	 * mm->mm_lock_seq can't be concurrently modified.
+	 */
+	mm_lock_seq = READ_ONCE(vma->vm_mm->mm_lock_seq);
+	if (vma->vm_lock_seq == mm_lock_seq)
+		return;
+
+	down_write(&vma->lock);
+	vma->vm_lock_seq = mm_lock_seq;
+	up_write(&vma->lock);
+}
+
+static inline bool vma_read_trylock(struct vm_area_struct *vma)
+{
+	if (unlikely(down_read_trylock(&vma->lock) == 0))
+		return false;
+
+	/*
+	 * Overflow might produce false locked result but it's not critical.
+	 * False unlocked result is critical but is impossible because we
+	 * modify and check vma->vm_lock_seq under vma->lock protection and
+	 * mm->mm_lock_seq modification invalidates all existing locks.
+	 */
+	if (vma->vm_lock_seq == READ_ONCE(vma->vm_mm->mm_lock_seq)) {
+		up_read(&vma->lock);
+		return false;
+	}
+	return true;
+}
+
+static inline void vma_read_unlock(struct vm_area_struct *vma)
+{
+	up_read(&vma->lock);
+}
+
+static inline void vma_assert_locked(struct vm_area_struct *vma)
+{
+	lockdep_assert_held(&vma->lock);
+	VM_BUG_ON_VMA(!rwsem_is_locked(&vma->lock), vma);
+}
+
+static inline void vma_assert_write_locked(struct vm_area_struct *vma, int pos)
+{
+	mmap_assert_write_locked(vma->vm_mm);
+	/*
+	 * current task is holding mmap_write_lock, both vma->vm_lock_seq and
+	 * mm->mm_lock_seq can't be concurrently modified.
+	 */
+	VM_BUG_ON_VMA(vma->vm_lock_seq != READ_ONCE(vma->vm_mm->mm_lock_seq), vma);
+}
+
+#else /* CONFIG_PER_VMA_LOCK */
+
+static inline void vma_init_lock(struct vm_area_struct *vma) {}
+static inline void vma_mark_locked(struct vm_area_struct *vma) {}
+static inline bool vma_read_trylock(struct vm_area_struct *vma)
+		{ return false; }
+static inline void vma_read_unlock(struct vm_area_struct *vma) {}
+static inline void vma_assert_locked(struct vm_area_struct *vma) {}
+static inline void vma_assert_write_locked(struct vm_area_struct *vma, int pos) {}
+
+#endif /* CONFIG_PER_VMA_LOCK */
+
 static inline void vma_init(struct vm_area_struct *vma, struct mm_struct *mm)
 {
 	static const struct vm_operations_struct dummy_vm_ops = {};
@@ -619,6 +696,7 @@ static inline void vma_init(struct vm_area_struct *vma, struct mm_struct *mm)
 	vma->vm_mm = mm;
 	vma->vm_ops = &dummy_vm_ops;
 	INIT_LIST_HEAD(&vma->anon_vma_chain);
+	vma_init_lock(vma);
 }
 
 static inline void vma_set_anonymous(struct vm_area_struct *vma)
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index bed25ef7c994..6a03f59c1e78 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -486,6 +486,10 @@ struct vm_area_struct {
 	struct mempolicy *vm_policy;	/* NUMA policy for the VMA */
 #endif
 	struct vm_userfaultfd_ctx vm_userfaultfd_ctx;
+#ifdef CONFIG_PER_VMA_LOCK
+	struct rw_semaphore lock;
+	int vm_lock_seq;
+#endif
 } __randomize_layout;
 
 struct kioctx_table;
@@ -567,6 +571,9 @@ struct mm_struct {
 					  * init_mm.mmlist, and are protected
 					  * by mmlist_lock
 					  */
+#ifdef CONFIG_PER_VMA_LOCK
+		int mm_lock_seq;
+#endif
 
 
 		unsigned long hiwater_rss; /* High-watermark of RSS usage */
diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
index e49ba91bb1f0..a391ae226564 100644
--- a/include/linux/mmap_lock.h
+++ b/include/linux/mmap_lock.h
@@ -72,6 +72,17 @@ static inline void mmap_assert_write_locked(struct mm_struct *mm)
 	VM_BUG_ON_MM(!rwsem_is_locked(&mm->mmap_lock), mm);
 }
 
+#ifdef CONFIG_PER_VMA_LOCK
+static inline void vma_mark_unlocked_all(struct mm_struct *mm)
+{
+	mmap_assert_write_locked(mm);
+	/* No races during update due to exclusive mmap_lock being held */
+	WRITE_ONCE(mm->mm_lock_seq, mm->mm_lock_seq + 1);
+}
+#else
+static inline void vma_mark_unlocked_all(struct mm_struct *mm) {}
+#endif
+
 static inline void mmap_init_lock(struct mm_struct *mm)
 {
 	init_rwsem(&mm->mmap_lock);
@@ -114,12 +125,14 @@ static inline bool mmap_write_trylock(struct mm_struct *mm)
 static inline void mmap_write_unlock(struct mm_struct *mm)
 {
 	__mmap_lock_trace_released(mm, true);
+	vma_mark_unlocked_all(mm);
 	up_write(&mm->mmap_lock);
 }
 
 static inline void mmap_write_downgrade(struct mm_struct *mm)
 {
 	__mmap_lock_trace_acquire_returned(mm, false, true);
+	vma_mark_unlocked_all(mm);
 	downgrade_write(&mm->mmap_lock);
 }
 
diff --git a/kernel/fork.c b/kernel/fork.c
index 614872438393..bfab31ecd11e 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -475,6 +475,7 @@ struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
 		 */
 		*new = data_race(*orig);
 		INIT_LIST_HEAD(&new->anon_vma_chain);
+		vma_init_lock(new);
 		new->vm_next = new->vm_prev = NULL;
 		dup_anon_vma_name(orig, new);
 	}
@@ -1130,6 +1131,9 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 	seqcount_init(&mm->write_protect_seq);
 	mmap_init_lock(mm);
 	INIT_LIST_HEAD(&mm->mmlist);
+#ifdef CONFIG_PER_VMA_LOCK
+	WRITE_ONCE(mm->mm_lock_seq, 0);
+#endif
 	mm_pgtables_bytes_init(mm);
 	mm->map_count = 0;
 	mm->locked_vm = 0;
diff --git a/mm/init-mm.c b/mm/init-mm.c
index fbe7844d0912..8399f90d631c 100644
--- a/mm/init-mm.c
+++ b/mm/init-mm.c
@@ -37,6 +37,9 @@ struct mm_struct init_mm = {
 	.page_table_lock =  __SPIN_LOCK_UNLOCKED(init_mm.page_table_lock),
 	.arg_lock	=  __SPIN_LOCK_UNLOCKED(init_mm.arg_lock),
 	.mmlist		= LIST_HEAD_INIT(init_mm.mmlist),
+#ifdef CONFIG_PER_VMA_LOCK
+	.mm_lock_seq	= 0,
+#endif
 	.user_ns	= &init_user_ns,
 	.cpu_bitmap	= CPU_BITS_NONE,
 #ifdef CONFIG_IOMMU_SVA
-- 
2.37.2.672.g94769d06f0-goog

