Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FBD04D67F9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 18:46:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241269AbiCKRr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 12:47:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242962AbiCKRrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 12:47:09 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CAC813C27B
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 09:46:05 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id p15so20669850ejc.7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 09:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0lq4ouGfnimqyWNmVOB40NOttTua5Z3ILiH3wkeBRpo=;
        b=QnqdrUzB4vfjCnIzoOfEpuPmFEt4g9jkQcTZFN44Pc20qzILMoaIngY4z3nAZQHLdP
         bHULc4fwCM+FmxZ15Ytz64Apd/uLaFUR2LiYth7iKww5zbl1cSw5i6KhiwBrkRPrde5K
         J0vQS3q7PwLlLjANJyDnm298DU/3V8MC5oMo/3aDpYMjOpCUqZkdC92JQlE/m5OgszZa
         OFmG5glJIoAEMOW/FpHLOIYs4Si+Fn5/henMZHrXHH365zzYeecfkdtbHPv52tEP/E7J
         Y1IBP2oQQtljVYN26XK4pMGMnA7vnCVwekXvd+/Xs4cGBrGJkYOb8tCUV8kLKbSX+l9b
         +MGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0lq4ouGfnimqyWNmVOB40NOttTua5Z3ILiH3wkeBRpo=;
        b=q2buUmy/6sIzrW2hzjIxEKeInX0LuPF6gty2fc78dBrrjbNMCmEdNYKaQ0dXv9qTpp
         4+IrpCnw1a2KDEWe/Ms7RHRnKYfUTCq6cw5W1oezQQ+PFBsmY1PtbjTlcYKIB9/6BTfa
         kXjwqg1cRA/iR00ZGptnXYJyvJuDvatfpcZE5ItZ1jz/5U966BkRbjI8MNabe3WPMsAA
         lFTl5y1ubId0CtfAFvxPdoQBYzLMp/+NUCW+D7iU5LIMBY2xeCPPIJdaWjEhJECjBdTs
         nIktuwkNkVGDdMNdFPUg1VoeNyyQQRdSRpmPO1k+OJFujNiWkN3h0SjdqY8puaowsw73
         Tl/Q==
X-Gm-Message-State: AOAM532/wFfPSjhwgTRA9RoUzQV7VUw/adNeCR9eyhuGXtQmaCJ/HnlJ
        DmjfXFm63I2Xw3FJU4pwdpA=
X-Google-Smtp-Source: ABdhPJyM8VtM3eyZK31TyYDcdc2wS0xsQUrceRwXb8S6txY7mKuo4AJdTWKm7HoKnRMb7p62AGiJeQ==
X-Received: by 2002:a17:906:52c7:b0:6ce:a880:50a3 with SMTP id w7-20020a17090652c700b006cea88050a3mr9345194ejn.437.1647020763935;
        Fri, 11 Mar 2022 09:46:03 -0800 (PST)
Received: from orion.localdomain ([93.99.228.15])
        by smtp.gmail.com with ESMTPSA id cf17-20020a170906b2d100b006daa59af421sm3232771ejb.149.2022.03.11.09.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 09:46:01 -0800 (PST)
Received: by orion.localdomain (Postfix, from userid 1003)
        id 855A9A00C0; Fri, 11 Mar 2022 18:46:03 +0100 (CET)
From:   =?UTF-8?q?Jakub=20Mat=C4=9Bna?= <matenajakub@gmail.com>
To:     linux-mm@kvack.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        vbabka@suse.cz, mhocko@kernel.org, mgorman@techsingularity.net,
        willy@infradead.org, liam.howlett@oracle.com, hughd@google.com,
        kirill@shutemov.name, riel@surriel.com, rostedt@goodmis.org,
        peterz@infradead.org,
        =?UTF-8?q?Jakub=20Mat=C4=9Bna?= <matenajakub@gmail.com>
Subject: [RFC PATCH v2 2/4] [PATCH 2/4] mm: adjust page offset in mremap
Date:   Fri, 11 Mar 2022 18:46:00 +0100
Message-Id: <20220311174602.288010-3-matenajakub@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220311174602.288010-1-matenajakub@gmail.com>
References: <20220311174602.288010-1-matenajakub@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust page offset of a VMA when it's moved to a new location by mremap.
This is made possible for all VMAs that do not share their anonymous
pages with other processes. Previously this was possible only for not
yet faulted VMAs.
When the page offset does not correspond to the virtual address
of the anonymous VMA any merge attempt with another VMA will fail.

Signed-off-by: Jakub Matěna <matenajakub@gmail.com>
---
 mm/mmap.c | 69 ++++++++++++++++++++++++++++++++++++++++++++++++++-----
 mm/rmap.c | 37 +++++++++++++++++++++++++++++
 2 files changed, 100 insertions(+), 6 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 8d817b11c656..4f9c6ca7ff4e 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3218,6 +3218,59 @@ int insert_vm_struct(struct mm_struct *mm, struct vm_area_struct *vma)
 	return 0;
 }
 
+/**
+ * update_faulted_pgoff() - Update faulted pages of a vma
+ * @vma: VMA being moved
+ * @addr: new virtual address
+ * @pgoff: pointer to pgoff which is updated
+ * If the vma and its pages are not shared with another process, update
+ * the new pgoff and also update index parameter (copy of the pgoff) in
+ * all faulted pages.
+ */
+bool update_faulted_pgoff(struct vm_area_struct *vma, unsigned long addr, pgoff_t *pgoff)
+{
+	unsigned long pg_iter = 0;
+	unsigned long pg_iters = (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
+
+	/* Check vma is not shared with other processes */
+	if (vma->anon_vma->root != vma->anon_vma || !rbt_no_children(vma->anon_vma))
+		return false;
+
+	/* Check all pages are not shared */
+	for (; pg_iter < pg_iters; ++pg_iter) {
+		bool pages_not_shared = true;
+		unsigned long shift = pg_iter << PAGE_SHIFT;
+		struct page *phys_page = follow_page(vma, vma->vm_start + shift, FOLL_GET);
+
+		if (phys_page == NULL)
+			continue;
+
+		/* Check page is not shared with other processes */
+		if (page_mapcount(phys_page) > 1)
+			pages_not_shared = false;
+		put_page(phys_page);
+		if (!pages_not_shared)
+			return false;
+	}
+
+	/* Update index in all pages to this new pgoff */
+	pg_iter = 0;
+	*pgoff = addr >> PAGE_SHIFT;
+
+	for (; pg_iter < pg_iters; ++pg_iter) {
+		unsigned long shift = pg_iter << PAGE_SHIFT;
+		struct page *phys_page = follow_page(vma, vma->vm_start + shift, FOLL_GET);
+
+		if (phys_page == NULL)
+			continue;
+		lock_page(phys_page);
+		phys_page->index = *pgoff + pg_iter;
+		unlock_page(phys_page);
+		put_page(phys_page);
+	}
+	return true;
+}
+
 /*
  * Copy the vma structure to a new location in the same mm,
  * prior to moving page table entries, to effect an mremap move.
@@ -3231,15 +3284,19 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 	struct mm_struct *mm = vma->vm_mm;
 	struct vm_area_struct *new_vma, *prev;
 	struct rb_node **rb_link, *rb_parent;
-	bool faulted_in_anon_vma = true;
+	bool anon_pgoff_updated = false;
 
 	/*
-	 * If anonymous vma has not yet been faulted, update new pgoff
+	 * Try to update new pgoff for anonymous vma
 	 * to match new location, to increase its chance of merging.
 	 */
-	if (unlikely(vma_is_anonymous(vma) && !vma->anon_vma)) {
-		pgoff = addr >> PAGE_SHIFT;
-		faulted_in_anon_vma = false;
+	if (unlikely(vma_is_anonymous(vma))) {
+		if (!vma->anon_vma) {
+			pgoff = addr >> PAGE_SHIFT;
+			anon_pgoff_updated = true;
+		} else {
+			anon_pgoff_updated = update_faulted_pgoff(vma, addr, &pgoff);
+		}
 	}
 
 	if (find_vma_links(mm, addr, addr + len, &prev, &rb_link, &rb_parent))
@@ -3265,7 +3322,7 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 			 * safe. It is only safe to keep the vm_pgoff
 			 * linear if there are no pages mapped yet.
 			 */
-			VM_BUG_ON_VMA(faulted_in_anon_vma, new_vma);
+			VM_BUG_ON_VMA(!anon_pgoff_updated, new_vma);
 			*vmap = vma = new_vma;
 		}
 		*need_rmap_locks = (new_vma->vm_pgoff <= vma->vm_pgoff);
diff --git a/mm/rmap.c b/mm/rmap.c
index 6a1e8c7f6213..96273d6a9796 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -387,6 +387,43 @@ int anon_vma_fork(struct vm_area_struct *vma, struct vm_area_struct *pvma)
 	return -ENOMEM;
 }
 
+/*
+ * Used by rbt_no_children to check node subtree.
+ * Check if none of the VMAs connected to the node subtree via
+ * anon_vma_chain are in child relationship to the given anon_vma.
+ */
+bool rbst_no_children(struct anon_vma *av, struct rb_node *node)
+{
+	struct anon_vma_chain *model;
+	struct anon_vma_chain *avc;
+
+	if (node == NULL) /* leaf node */
+		return true;
+	avc = container_of(node, typeof(*(model)), rb);
+	if (avc->vma->anon_vma != av)
+		/*
+		 * Inequality implies avc belongs
+		 * to a VMA of a child process
+		 */
+		return false;
+	return (rbst_no_children(av, node->rb_left) &&
+	rbst_no_children(av, node->rb_right));
+}
+
+/*
+ * Check if none of the VMAs connected to the given
+ * anon_vma via anon_vma_chain are in child relationship
+ */
+bool rbt_no_children(struct anon_vma *av)
+{
+	struct rb_node *root_node;
+
+	if (av == NULL || av->degree <= 1) /* Higher degree might not necessarily imply children */
+		return true;
+	root_node = av->rb_root.rb_root.rb_node;
+	return rbst_no_children(av, root_node);
+}
+
 void unlink_anon_vmas(struct vm_area_struct *vma)
 {
 	struct anon_vma_chain *avc, *next;
-- 
2.34.1

