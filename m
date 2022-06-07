Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4E853F9E8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 11:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239712AbiFGJfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 05:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239644AbiFGJfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 05:35:06 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C766E64D9
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 02:35:03 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id a2so21258126lfg.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 02:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/m93af/b5jfm9tZCfE4d8bYwXKExf/KtRK6sqDTZnX8=;
        b=d1Bn/bBj18RiG2Wo96aBwJlqBTl0eZb5+qmlzXXE6bQ+j8QfHZ6T7KzicQVAnczhwv
         gZu8VrkgcEUhaK5xIMDA4Y//j1RTSK5dRGhgw1DiaCnbgUkqsN6OdWJ+OxA2b0xx+utk
         dBgTvwQWP9erRmmJFn2tug3I6XFqkTKy03Wa/lXo402QokGda0DaI/w+4lEn57lgfj1G
         3mD8WFfvQXHZuH5WTBMGd+HiF60kOnZYpeXyvu7m0eMycc142U4fus5IJyzevNlp/0yH
         D0jC/jxOGhyI8IGiBhw27bMaA5LtqMANjtCDqnUsi5G3MXWrWEItVhFN+qfpoSvw1UtE
         ZY2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/m93af/b5jfm9tZCfE4d8bYwXKExf/KtRK6sqDTZnX8=;
        b=Zm1wdefOcoxjpBV2vasXoOnB9YvUajMgaIjKHrY2DCpb8av9i03E9YUymqSjogw6PA
         rPL+ZlCpoUHu18LzXrhKqnvVWMBYqKctepaMoNtXggAw+bK56rBW5ZOUBkMHrBdEF4nq
         fVGo9Z35PszgNy3m9FVgSE7klhxfgoTkXKS0uZH/Y4a4FKJ54JMcj4GkcxAnS455qbVR
         L25EwCcnVV140zzp99wpF/OI8C2YrOyATf5xpTA3fIBwEaVw080c0/sppIekaBgl+97z
         cmFLnxfe/YkBB6DJQoV/0J7qvmPo/myp3dLn7xaH3yQMlfZm558JgJKd5QJaAh8fxc5B
         89hg==
X-Gm-Message-State: AOAM533tOC3VieMnRQIbtAi3c6GTFXxzM5JEhAZ2FyysF8F4CknW0oMd
        LyUXy6ZtUXyEzlp48LP4qRY=
X-Google-Smtp-Source: ABdhPJyVkUcTCv4+l8aPtPwj+grbnTiZq6vPqAsaIkKbrR3qe7PRUtUNv/A07lVdkcB0uZl4/17oLA==
X-Received: by 2002:a05:6512:2622:b0:478:f29d:8197 with SMTP id bt34-20020a056512262200b00478f29d8197mr23728997lfb.513.1654594500741;
        Tue, 07 Jun 2022 02:35:00 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id r27-20020a2e575b000000b002554a4ebf5fsm2748043ljd.74.2022.06.07.02.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 02:35:00 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: [PATCH 1/5] mm/vmalloc: Make link_va()/unlink_va() common to different rb_root
Date:   Tue,  7 Jun 2022 11:34:45 +0200
Message-Id: <20220607093449.3100-2-urezki@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220607093449.3100-1-urezki@gmail.com>
References: <20220607093449.3100-1-urezki@gmail.com>
MIME-Version: 1.0
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

Currently link_va() and unlik_va(), in order to figure out a tree
type, compares a passed root value with a global free_vmap_area_root
variable to distinguish the augmented rb-tree from a regular one. It
is hard coded since such functions can manipulate only with specific
"free_vmap_area_root" tree that represents a global free vmap space.

Make it common by introducing "_augment" versions of both internal
functions, so it is possible to deal with different trees.

There is no functional change as a result of this patch.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 60 +++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 48 insertions(+), 12 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index be8ed06804a5..0102d6d5fcdf 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -911,8 +911,9 @@ get_va_next_sibling(struct rb_node *parent, struct rb_node **link)
 }
 
 static __always_inline void
-link_va(struct vmap_area *va, struct rb_root *root,
-	struct rb_node *parent, struct rb_node **link, struct list_head *head)
+__link_va(struct vmap_area *va, struct rb_root *root,
+	struct rb_node *parent, struct rb_node **link,
+	struct list_head *head, bool augment)
 {
 	/*
 	 * VA is still not in the list, but we can
@@ -926,7 +927,7 @@ link_va(struct vmap_area *va, struct rb_root *root,
 
 	/* Insert to the rb-tree */
 	rb_link_node(&va->rb_node, parent, link);
-	if (root == &free_vmap_area_root) {
+	if (augment) {
 		/*
 		 * Some explanation here. Just perform simple insertion
 		 * to the tree. We do not set va->subtree_max_size to
@@ -950,12 +951,28 @@ link_va(struct vmap_area *va, struct rb_root *root,
 }
 
 static __always_inline void
-unlink_va(struct vmap_area *va, struct rb_root *root)
+link_va(struct vmap_area *va, struct rb_root *root,
+	struct rb_node *parent, struct rb_node **link,
+	struct list_head *head)
+{
+	__link_va(va, root, parent, link, head, false);
+}
+
+static __always_inline void
+link_va_augment(struct vmap_area *va, struct rb_root *root,
+	struct rb_node *parent, struct rb_node **link,
+	struct list_head *head)
+{
+	__link_va(va, root, parent, link, head, true);
+}
+
+static __always_inline void
+__unlink_va(struct vmap_area *va, struct rb_root *root, bool augment)
 {
 	if (WARN_ON(RB_EMPTY_NODE(&va->rb_node)))
 		return;
 
-	if (root == &free_vmap_area_root)
+	if (augment)
 		rb_erase_augmented(&va->rb_node,
 			root, &free_vmap_area_rb_augment_cb);
 	else
@@ -965,6 +982,18 @@ unlink_va(struct vmap_area *va, struct rb_root *root)
 	RB_CLEAR_NODE(&va->rb_node);
 }
 
+static __always_inline void
+unlink_va(struct vmap_area *va, struct rb_root *root)
+{
+	__unlink_va(va, root, false);
+}
+
+static __always_inline void
+unlink_va_augment(struct vmap_area *va, struct rb_root *root)
+{
+	__unlink_va(va, root, true);
+}
+
 #if DEBUG_AUGMENT_PROPAGATE_CHECK
 /*
  * Gets called when remove the node and rotate.
@@ -1060,7 +1089,7 @@ insert_vmap_area_augment(struct vmap_area *va,
 		link = find_va_links(va, root, NULL, &parent);
 
 	if (link) {
-		link_va(va, root, parent, link, head);
+		link_va_augment(va, root, parent, link, head);
 		augment_tree_propagate_from(va);
 	}
 }
@@ -1077,8 +1106,8 @@ insert_vmap_area_augment(struct vmap_area *va,
  * ongoing.
  */
 static __always_inline struct vmap_area *
-merge_or_add_vmap_area(struct vmap_area *va,
-	struct rb_root *root, struct list_head *head)
+__merge_or_add_vmap_area(struct vmap_area *va,
+	struct rb_root *root, struct list_head *head, bool augment)
 {
 	struct vmap_area *sibling;
 	struct list_head *next;
@@ -1140,7 +1169,7 @@ merge_or_add_vmap_area(struct vmap_area *va,
 			 * "normalized" because of rotation operations.
 			 */
 			if (merged)
-				unlink_va(va, root);
+				__unlink_va(va, root, augment);
 
 			sibling->va_end = va->va_end;
 
@@ -1155,16 +1184,23 @@ merge_or_add_vmap_area(struct vmap_area *va,
 
 insert:
 	if (!merged)
-		link_va(va, root, parent, link, head);
+		__link_va(va, root, parent, link, head, augment);
 
 	return va;
 }
 
+static __always_inline struct vmap_area *
+merge_or_add_vmap_area(struct vmap_area *va,
+	struct rb_root *root, struct list_head *head)
+{
+	return __merge_or_add_vmap_area(va, root, head, false);
+}
+
 static __always_inline struct vmap_area *
 merge_or_add_vmap_area_augment(struct vmap_area *va,
 	struct rb_root *root, struct list_head *head)
 {
-	va = merge_or_add_vmap_area(va, root, head);
+	va = __merge_or_add_vmap_area(va, root, head, true);
 	if (va)
 		augment_tree_propagate_from(va);
 
@@ -1348,7 +1384,7 @@ adjust_va_to_fit_type(struct vmap_area *va,
 		 * V      NVA      V
 		 * |---------------|
 		 */
-		unlink_va(va, &free_vmap_area_root);
+		unlink_va_augment(va, &free_vmap_area_root);
 		kmem_cache_free(vmap_area_cachep, va);
 	} else if (type == LE_FIT_TYPE) {
 		/*
-- 
2.30.2

