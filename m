Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C402B4D67F6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 18:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243506AbiCKRrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 12:47:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346629AbiCKRrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 12:47:07 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4E8814A6DF
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 09:46:03 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id qt6so20619822ejb.11
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 09:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=46hR8qn+FvV21nPx7MnpWlG2AiI7do5YUIgYG1Cv7cg=;
        b=ccCwwfBqjf2cVwLVdbFKTirEaQR5eqblzaW5tzpXkhLDCeMz14RXQg3cgWpYmopJuC
         UayK8wqQCxTeafeMNClzwFdgnNC6gFoZnpmxSIpsX8NOTF42N9Kwa/ccyN9Q8KieESwo
         0DSRUaZkiZor8fAoqjJ09A1UuoRIbbUHaoOcwPEnOWblwGh4dApEJfT2y8PxAEv5KU0m
         CHsrvO3pm8mtxWqeKXbgIECQwf+2C8cQ/ORW/Omn0etA8qsmKu7cU3Tsuj4C5ZqscAwb
         OgdxwRzYJWKmoi40IMCcmUzO0NdX6D2WfkvKvVf8vTkjqBDIwhMsfo6NEsJbli2mAF9f
         j7kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=46hR8qn+FvV21nPx7MnpWlG2AiI7do5YUIgYG1Cv7cg=;
        b=hl6oXEZUvpj8MnhZkYEEg5vyK755Fxkz0RYvPRqvcCsfZ5FJozwHCYN6+xqm4KNIBe
         r25ICz6KfOHJGKL/NMOy4FdLpP//ly0/sIP3eUfyWTQeetpny8Kw6ydS0/hNs1BObkya
         n1/LubN1E7Yhqvgzvgbo6wxjOOYnBVDEw3Er+A+mLothwquZz/RmzRDaIgI6MYkpo0By
         HQzg73HZjQ4ckDN1QTRw+cw+9grV7CcqyrBVDLXUJa45Aa+mnsRa7ScwwBVX30xjdOUX
         tQVkCLeAMAnCLv8NNUX+Ah0pNV3b/E/nmoYI0z/MiciF4m7V1OYCyPZnoxma6JFa0c1P
         3sQg==
X-Gm-Message-State: AOAM531CPmyQ+h2sdC1Fyee5FndEaresgAmEzuSItKSnalWlCjDx907Z
        fztnskUz5IqEQ3xAe8/dbxc=
X-Google-Smtp-Source: ABdhPJzr5vVq5kXp5nER8koKW+0CLiQKDEP5mHuCuUineelZnECEWO40tLksEo7SeQ+Tfn2AjOxVrw==
X-Received: by 2002:a17:906:3ad1:b0:6ce:a880:7745 with SMTP id z17-20020a1709063ad100b006cea8807745mr9552418ejd.46.1647020762124;
        Fri, 11 Mar 2022 09:46:02 -0800 (PST)
Received: from orion.localdomain ([93.99.228.15])
        by smtp.gmail.com with ESMTPSA id fs6-20020a170907600600b006da8ec6e4a6sm3185068ejc.26.2022.03.11.09.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 09:46:01 -0800 (PST)
Received: by orion.localdomain (Postfix, from userid 1003)
        id 88CDAA00C3; Fri, 11 Mar 2022 18:46:03 +0100 (CET)
From:   =?UTF-8?q?Jakub=20Mat=C4=9Bna?= <matenajakub@gmail.com>
To:     linux-mm@kvack.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        vbabka@suse.cz, mhocko@kernel.org, mgorman@techsingularity.net,
        willy@infradead.org, liam.howlett@oracle.com, hughd@google.com,
        kirill@shutemov.name, riel@surriel.com, rostedt@goodmis.org,
        peterz@infradead.org,
        =?UTF-8?q?Jakub=20Mat=C4=9Bna?= <matenajakub@gmail.com>
Subject: [RFC PATCH v2 3/4] [PATCH 3/4] mm: enable merging of VMAs with different anon_vmas
Date:   Fri, 11 Mar 2022 18:46:01 +0100
Message-Id: <20220311174602.288010-4-matenajakub@gmail.com>
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

Enable merging of a VMA even when it is linked to different
anon_vma than the one it is being merged to, but only if the VMA
in question does not share any page with a parent or child process.
Every anonymous page stores a pointer to its anon_vma in the parameter
mapping, which is now updated as part of the merge process.

Signed-off-by: Jakub Matěna <matenajakub@gmail.com>
---
 include/linux/rmap.h | 17 ++++++++++++++++-
 mm/mmap.c            | 15 ++++++++++++++-
 mm/rmap.c            | 40 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 70 insertions(+), 2 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index e704b1a4c06c..c8508a4ebc46 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -137,10 +137,13 @@ static inline void anon_vma_unlock_read(struct anon_vma *anon_vma)
  */
 void anon_vma_init(void);	/* create anon_vma_cachep */
 int  __anon_vma_prepare(struct vm_area_struct *);
+void reconnect_pages(struct vm_area_struct *vma, struct vm_area_struct *next);
 void unlink_anon_vmas(struct vm_area_struct *);
 int anon_vma_clone(struct vm_area_struct *, struct vm_area_struct *);
 int anon_vma_fork(struct vm_area_struct *, struct vm_area_struct *);
 
+bool rbt_no_children(struct anon_vma *av);
+
 static inline int anon_vma_prepare(struct vm_area_struct *vma)
 {
 	if (likely(vma->anon_vma))
@@ -149,10 +152,22 @@ static inline int anon_vma_prepare(struct vm_area_struct *vma)
 	return __anon_vma_prepare(vma);
 }
 
+/**
+ * anon_vma_merge() - Merge anon_vmas of the given VMAs
+ * @vma: VMA being merged to
+ * @next: VMA being merged
+ */
 static inline void anon_vma_merge(struct vm_area_struct *vma,
 				  struct vm_area_struct *next)
 {
-	VM_BUG_ON_VMA(vma->anon_vma != next->anon_vma, vma);
+	struct anon_vma *anon_vma1 = vma->anon_vma;
+	struct anon_vma *anon_vma2 = next->anon_vma;
+
+	VM_BUG_ON_VMA(anon_vma1 && anon_vma2 && anon_vma1 != anon_vma2 &&
+			((anon_vma2 != anon_vma2->root)
+			|| !rbt_no_children(anon_vma2)), vma);
+
+	reconnect_pages(vma, next);
 	unlink_anon_vmas(next);
 }
 
diff --git a/mm/mmap.c b/mm/mmap.c
index 4f9c6ca7ff4e..ccb24862e670 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1065,7 +1065,20 @@ static inline int is_mergeable_anon_vma(struct anon_vma *anon_vma1,
 	if ((!anon_vma1 || !anon_vma2) && (!vma ||
 		list_is_singular(&vma->anon_vma_chain)))
 		return 1;
-	return anon_vma1 == anon_vma2;
+	if (anon_vma1 == anon_vma2)
+		return 1;
+	/*
+	 * Different anon_vma but not shared by several processes
+	 */
+	else if ((anon_vma1 && anon_vma2) &&
+			(anon_vma1 == anon_vma1->root)
+			&& (rbt_no_children(anon_vma1)))
+		return 1;
+	/*
+	 * Different anon_vma and shared -> unmergeable
+	 */
+	else
+		return 0;
 }
 
 /*
diff --git a/mm/rmap.c b/mm/rmap.c
index 96273d6a9796..b296e1e1aec3 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -387,6 +387,46 @@ int anon_vma_fork(struct vm_area_struct *vma, struct vm_area_struct *pvma)
 	return -ENOMEM;
 }
 
+/**
+ * reconnect_pages() - Reconnect physical pages from old to vma
+ * @vma: VMA to newly contain all physical pages of old
+ * @old: old VMA being merged to vma
+ */
+void reconnect_pages(struct vm_area_struct *vma, struct vm_area_struct *old)
+{
+	struct anon_vma *anon_vma1 = vma->anon_vma;
+	struct anon_vma *anon_vma2 = old->anon_vma;
+	unsigned long pg_iter;
+	int pg_iters;
+
+	if (anon_vma1 == anon_vma2 || anon_vma1 == NULL || anon_vma2 == NULL)
+		return; /* Nothing to do */
+
+	/* Modify page->mapping for all pages in old */
+	pg_iter = 0;
+	pg_iters = (old->vm_end - old->vm_start) >> PAGE_SHIFT;
+
+	for (; pg_iter < pg_iters; ++pg_iter) {
+		/* Get the physical page */
+		unsigned long shift = pg_iter << PAGE_SHIFT;
+		struct page *phys_page = follow_page(old, old->vm_start + shift, FOLL_GET);
+		struct anon_vma *page_anon_vma;
+
+		/* Do some checks and lock the page */
+		if (phys_page == NULL)
+			continue; /* Virtual memory page is not mapped */
+		lock_page(phys_page);
+		page_anon_vma = page_get_anon_vma(phys_page);
+		if (page_anon_vma != NULL) { /* NULL in case of ZERO_PAGE */
+			VM_BUG_ON_VMA(page_anon_vma != old->anon_vma, old);
+			/* Update physical page's mapping */
+			page_move_anon_rmap(phys_page, vma);
+		}
+		unlock_page(phys_page);
+		put_page(phys_page);
+	}
+}
+
 /*
  * Used by rbt_no_children to check node subtree.
  * Check if none of the VMAs connected to the node subtree via
-- 
2.34.1

