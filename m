Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 334694BB906
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 13:22:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234926AbiBRMWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 07:22:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232902AbiBRMVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 07:21:55 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DAE613EB9
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 04:21:38 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id bg10so14652324ejb.4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 04:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+FOZfGmK9Ee9HWyxoro93sTh2E++DXV5pvaMxG0mrBk=;
        b=S9daUL4DkyciT4OMAz6v9FmM+BjXNqe6WzHHFwVFSUo7kCrSp5MVb1P+B8l0XItu/X
         SybDR9ohCIDd49fCz9uTgoVdZezshyUCpvEFEHnLskNUfgus/zPK0aYbftWi3AnBPVAc
         1k3Jk0uH+ATalwUnoRGFMM9y3K0qxlHchvZv/YCdanCmJfUil1zl0nP/AQoTObBhwEs8
         QG/EZwVFd36fd5fzYkCBDis5gVDT/8UNgP2VnFU1i4daSgZtp8qwCj/nGRSk183SIdEl
         c8DdJG3DOwXGDuTUTQNO0UF/oNamOrN5bn5Oct7cJUZdzsy/S4yx+SoxKA9zzMDceAxF
         LRAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+FOZfGmK9Ee9HWyxoro93sTh2E++DXV5pvaMxG0mrBk=;
        b=NN9gvnSD5IzHMqpID8zXPER/wCUA6Qo8rsuvnFDEz77D2UnwQySLSQcy+Me/lVG1Tm
         siIp+hnv3httqlQ3KFafEOV26hCIY7hoNBRzNwDolwyV6rV7AsOWes8ZTKipMIWs+JfI
         vl6lHMf45oB6SGzlPn2wKBjpoTC9aE9xC730Uw/YSom2Wuv5Lvarx2jSYwtjxz8h7au6
         AvgyWriq0V/NESFCA9TM7uBogLd8Ajs19+aJOy16LSssuxiChGPghl4eJeBeO4z6Ox33
         KfeeXoIJpEDBNI0DN+LKCn+1kfCdAlnGcmcLrbz0b2CcTU+N8dZlV+7pipxOE0diVYE3
         rT7g==
X-Gm-Message-State: AOAM533tAead0Lu5znwe8ZaDctoFGnXKgefiArVT8u4woZcTbJztvyVD
        aXb59yTHlFJ0yb0XIXWWDI0=
X-Google-Smtp-Source: ABdhPJxLg4gyvuJjYcnBgsWo5jR7IyKPfX4GM9CvXIhx+VV6WyxqXMoi3zzVm+rcduHStchWBqty3Q==
X-Received: by 2002:a17:906:1b13:b0:6ce:58d:4b78 with SMTP id o19-20020a1709061b1300b006ce058d4b78mr6324703ejg.515.1645186896729;
        Fri, 18 Feb 2022 04:21:36 -0800 (PST)
Received: from orion.localdomain ([93.99.228.15])
        by smtp.gmail.com with ESMTPSA id l8sm2141008ejp.198.2022.02.18.04.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 04:21:35 -0800 (PST)
Received: by orion.localdomain (Postfix, from userid 1003)
        id 46728A7FF7; Fri, 18 Feb 2022 13:20:44 +0100 (CET)
From:   =?UTF-8?q?Jakub=20Mat=C4=9Bna?= <matenajakub@gmail.com>
To:     linux-mm@kvack.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        vbabka@suse.cz, mhocko@kernel.org, mgorman@techsingularity.net,
        willy@infradead.org, liam.howlett@oracle.com, hughd@google.com,
        kirill@shutemov.name, riel@surriel.com, rostedt@goodmis.org,
        peterz@infradead.org,
        =?UTF-8?q?Jakub=20Mat=C4=9Bna?= <matenajakub@gmail.com>
Subject: [RFC PATCH 2/4] [PATCH 2/4] mm: adjust page offset in mremap
Date:   Fri, 18 Feb 2022 13:20:17 +0100
Message-Id: <20220218122019.130274-3-matenajakub@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220218122019.130274-1-matenajakub@gmail.com>
References: <20220218122019.130274-1-matenajakub@gmail.com>
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
 mm/mmap.c | 101 ++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 95 insertions(+), 6 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index b55e11f20571..8d253b46b349 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3224,6 +3224,91 @@ int insert_vm_struct(struct mm_struct *mm, struct vm_area_struct *vma)
 	return 0;
 }
 
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
+	/* 1.] Check vma is not shared with other processes */
+	if (vma->anon_vma->root != vma->anon_vma || !rbt_no_children(vma->anon_vma))
+		return false;
+
+	/* 2.] Check all pages are not shared */
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
+	/* 3.] Update index in all pages to this new pgoff */
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
@@ -3237,15 +3322,19 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
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
@@ -3271,7 +3360,7 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 			 * safe. It is only safe to keep the vm_pgoff
 			 * linear if there are no pages mapped yet.
 			 */
-			VM_BUG_ON_VMA(faulted_in_anon_vma, new_vma);
+			VM_BUG_ON_VMA(!anon_pgoff_updated, new_vma);
 			*vmap = vma = new_vma;
 		}
 		*need_rmap_locks = (new_vma->vm_pgoff <= vma->vm_pgoff);
-- 
2.34.1

