Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD4FA55A07F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 20:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232287AbiFXRi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 13:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231851AbiFXRha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 13:37:30 -0400
Received: from mail-ua1-x949.google.com (mail-ua1-x949.google.com [IPv6:2607:f8b0:4864:20::949])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2234162C13
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 10:37:29 -0700 (PDT)
Received: by mail-ua1-x949.google.com with SMTP id j14-20020ab01d0e000000b0037f3ad22193so1059489uak.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 10:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=fLhWVrtL3jCVQZTI/SpR/dF9bcFaOpNW6kUek+4VMrQ=;
        b=h/ysFkhblpzJ+iMXOAuoAW1RCDzHD/+S02IOwgDp+W1ftcj/5GpmKopNXVJGmI11dt
         mAS2/ecnjScCvn9y+SSrPgkps+68W5ymor9ZeqP24UdBQp7MkKwq9sGbZh9bcS3Kot12
         BGqJ5gfYWmse/+yrqaROihgM78qPJlOL2tffwnW0DZUm7UP9c6M6BVGl7wnznm72cE8e
         Gmgcs44D/bkYNixg8jOWwZMa5AJhJKIcbwa6ooNOCsk7KyEQSYEcelE/7NURJzuTXfld
         QKmlDWTSdSuaR2EkI87u4H/5x0GVEh50Cju+5MyrG72wa/G6IgHcBFf2GIqziepRDeTo
         ynXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=fLhWVrtL3jCVQZTI/SpR/dF9bcFaOpNW6kUek+4VMrQ=;
        b=HTZlH8smlUzrKWjBJfkuXoGi6myGN96LENsE/GGbMTbNpOl67OZ4hdkdyNQGESX7/U
         lLoKjGadfStgy/uhR7z9+lIZC4zieMWHRS2MaKm8h4JhzthzFXcMrlNTgtem1kD7s1MH
         3Qu3vaWsFPInwfTXPI+TobMEanNxfxJRSONVdisEdGaNuBIQJFB77kocw1nuomo4UfHo
         k0aaRp3uRWMzY6wOkEw2c2aTVzrP58inFMpP1GUefxZmkAoGdehT/l1TnWXoJKLtFRQe
         QSqHiKbrhOo1eLcAbbW/+uIG5EMM5ENYAtxARHDbg/RxNFNAgi+6I6+hSMg9xX6PkBiX
         JOyA==
X-Gm-Message-State: AJIora/OB0iYlODwmQ3XsPMTYPdWcknlG5GfZN/iXZX4UaHISG+JgxqF
        Qw7ENSb69PLJafsrXO8CInTUmCJagC2ThSN9
X-Google-Smtp-Source: AGRyM1uRSxwvI1ZalFt+ckvzYpzesshV4sVRNlb4t9wpXcehiUcvJo2Hg3rBOz88Imnv+bFCKqP3jsH6tlItOe1M
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a67:c30f:0:b0:354:45bf:748c with SMTP
 id r15-20020a67c30f000000b0035445bf748cmr351vsj.13.1656092248216; Fri, 24 Jun
 2022 10:37:28 -0700 (PDT)
Date:   Fri, 24 Jun 2022 17:36:43 +0000
In-Reply-To: <20220624173656.2033256-1-jthoughton@google.com>
Message-Id: <20220624173656.2033256-14-jthoughton@google.com>
Mime-Version: 1.0
References: <20220624173656.2033256-1-jthoughton@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [RFC PATCH 13/26] hugetlb: add huge_pte_alloc_high_granularity
From:   James Houghton <jthoughton@google.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Jue Wang <juew@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        James Houghton <jthoughton@google.com>
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

This function is to be used to do a HugeTLB page table walk where we may
need to split a leaf-level huge PTE into a new page table level.

Consider the case where we want to install 4K inside an empty 1G page:
1. We walk to the PUD and notice that it is pte_none.
2. We split the PUD by calling `hugetlb_split_to_shift`, creating a
   standard PUD that points to PMDs that are all pte_none.
3. We continue the PT walk to find the PMD. We split it just like we
   split the PUD.
4. We find the PTE and give it back to the caller.

To avoid concurrent splitting operations on the same page table entry,
we require that the mapping rwsem is held for writing while collapsing
and for reading when doing a high-granularity PT walk.

Signed-off-by: James Houghton <jthoughton@google.com>
---
 include/linux/hugetlb.h | 23 ++++++++++++++
 mm/hugetlb.c            | 67 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 90 insertions(+)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 605aa19d8572..321f5745d87f 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -1176,14 +1176,37 @@ static inline void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 }
 #endif	/* CONFIG_HUGETLB_PAGE */
 
+enum split_mode {
+	HUGETLB_SPLIT_NEVER   = 0,
+	HUGETLB_SPLIT_NONE    = 1 << 0,
+	HUGETLB_SPLIT_PRESENT = 1 << 1,
+	HUGETLB_SPLIT_ALWAYS  = HUGETLB_SPLIT_NONE | HUGETLB_SPLIT_PRESENT,
+};
 #ifdef CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING
 /* If HugeTLB high-granularity mappings are enabled for this VMA. */
 bool hugetlb_hgm_enabled(struct vm_area_struct *vma);
+int huge_pte_alloc_high_granularity(struct hugetlb_pte *hpte,
+				    struct mm_struct *mm,
+				    struct vm_area_struct *vma,
+				    unsigned long addr,
+				    unsigned int desired_sz,
+				    enum split_mode mode,
+				    bool write_locked);
 #else
 static inline bool hugetlb_hgm_enabled(struct vm_area_struct *vma)
 {
 	return false;
 }
+static inline int huge_pte_alloc_high_granularity(struct hugetlb_pte *hpte,
+					   struct mm_struct *mm,
+					   struct vm_area_struct *vma,
+					   unsigned long addr,
+					   unsigned int desired_sz,
+					   enum split_mode mode,
+					   bool write_locked)
+{
+	return -EINVAL;
+}
 #endif
 
 static inline spinlock_t *huge_pte_lock(struct hstate *h,
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index eaffe7b4f67c..6e0c5fbfe32c 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -7166,6 +7166,73 @@ static int hugetlb_split_to_shift(struct mm_struct *mm, struct vm_area_struct *v
 	tlb_finish_mmu(&tlb);
 	return ret;
 }
+
+/*
+ * Similar to huge_pte_alloc except that this can be used to create or walk
+ * high-granularity mappings. It will automatically split existing HugeTLB PTEs
+ * if required by @mode. The resulting HugeTLB PTE will be returned in @hpte.
+ *
+ * There are three options for @mode:
+ *  - HUGETLB_SPLIT_NEVER   - Never split.
+ *  - HUGETLB_SPLIT_NONE    - Split empty PTEs.
+ *  - HUGETLB_SPLIT_PRESENT - Split present PTEs.
+ *  - HUGETLB_SPLIT_ALWAYS  - Split both empty and present PTEs.
+ */
+int huge_pte_alloc_high_granularity(struct hugetlb_pte *hpte,
+				    struct mm_struct *mm,
+				    struct vm_area_struct *vma,
+				    unsigned long addr,
+				    unsigned int desired_shift,
+				    enum split_mode mode,
+				    bool write_locked)
+{
+	struct address_space *mapping = vma->vm_file->f_mapping;
+	bool has_write_lock = write_locked;
+	unsigned long desired_sz = 1UL << desired_shift;
+	int ret;
+
+	BUG_ON(!hpte);
+
+	if (has_write_lock)
+		i_mmap_assert_write_locked(mapping);
+	else
+		i_mmap_assert_locked(mapping);
+
+retry:
+	ret = 0;
+	hugetlb_pte_init(hpte);
+
+	ret = hugetlb_walk_to(mm, hpte, addr, desired_sz,
+			      !(mode & HUGETLB_SPLIT_NONE));
+	if (ret || hugetlb_pte_size(hpte) == desired_sz)
+		goto out;
+
+	if (
+		((mode & HUGETLB_SPLIT_NONE) && hugetlb_pte_none(hpte)) ||
+		((mode & HUGETLB_SPLIT_PRESENT) &&
+		  hugetlb_pte_present_leaf(hpte))
+	   ) {
+		if (!has_write_lock) {
+			i_mmap_unlock_read(mapping);
+			i_mmap_lock_write(mapping);
+			has_write_lock = true;
+			goto retry;
+		}
+		ret = hugetlb_split_to_shift(mm, vma, hpte, addr,
+					     desired_shift);
+	}
+
+out:
+	if (has_write_lock && !write_locked) {
+		/* Drop the write lock. */
+		i_mmap_unlock_write(mapping);
+		i_mmap_lock_read(mapping);
+		has_write_lock = false;
+		goto retry;
+	}
+
+	return ret;
+}
 #endif /* CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING */
 
 /*
-- 
2.37.0.rc0.161.g10f37bed90-goog

