Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8CC5471B1
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 05:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349367AbiFKD6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 23:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349040AbiFKD5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 23:57:53 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C84B1DA
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 20:57:52 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id y196so1082044pfb.6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 20:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aAKZps72PMMzoHcO+HkFjM55OhZNaxgE/SU4USJkil8=;
        b=PnUoFhqnRmYUsadvL00HsRESRoOzWZo2LXZ+DmTIxZVF3xYrhCvipnNBPkxycY0//h
         0nBmRrT/VATjJDXBTrMntOD8PMRrWaHPhPoVl49LhmXhFyv7O8eAorMM9wiE3rDL1m98
         i+Denny9OqXJcSM19Gkal2Yk/UfoLH9o4ZUrA5Rfh/JoCpdEWyL15yUOxPDhJ3vDEGpo
         IaHPwUVLqmCU249QeD/qGZ61iEiV/Iah/4kl3me5hyMyXSZjfSuiUOEJX3J5EYSaevge
         d+OLtj813UGsRvXKQcOEAPZ4ZCb2lJLCkUW81Ixxvx1VsRx1xcj2bZXI0D0m5f9VDvG8
         oKIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aAKZps72PMMzoHcO+HkFjM55OhZNaxgE/SU4USJkil8=;
        b=fCVsLYoNga8XtixvstpOnho2g6PHztPqfhfOZLxnIkFZhgwvGLl+C0RLFPBsTR2buF
         7+Y2FY1ouopfTS6CjStmWbbz2PW4ujIqjnH8Ood3UMKasJJlawL6teFWusoohyuBNiAT
         cqdO/ZlESN4kuzJIlaerKm/v4Vafz7U+LgE7w8PjNC3GsyljyTIpo88f7zwtH06/vYS/
         h9/CK1x5urPYTXyV5boYSuzSJHDtCdyNJw7PK6EK78GE4FLeqytsjpqd1icnOl2lCXcw
         hWYs20wqrjGNHWfXzMsF8iD3YJvlJe0LtvYMIerQgYeLxCsWHw51zqsIGnf9rBs1e4GS
         dJxw==
X-Gm-Message-State: AOAM533vmxBbXY4BKLyR0Zs+W7L2Aol5bsrDvS7isHZje7g+QmI1+gFG
        oHn3hpwpGqZ861tBFSawCGzuihl/JhwBGQ==
X-Google-Smtp-Source: ABdhPJy4p+QtcgzeQNeAiLnmtk2zrkY6GToee55wx7X2yzN+844cprFJBj11wSVsyS1OaWyapN7+PA==
X-Received: by 2002:a05:6a00:168a:b0:4f7:e161:83cd with SMTP id k10-20020a056a00168a00b004f7e16183cdmr49433188pfc.56.1654919872496;
        Fri, 10 Jun 2022 20:57:52 -0700 (PDT)
Received: from localhost ([101.86.206.203])
        by smtp.gmail.com with ESMTPSA id 2-20020a620602000000b0051844f3f637sm383080pfg.40.2022.06.10.20.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 20:57:51 -0700 (PDT)
From:   Patrick Wang <patrick.wang.shcn@gmail.com>
To:     catalin.marinas@arm.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        yee.lee@mediatek.com, patrick.wang.shcn@gmail.com
Subject: [PATCH v4 2/4] mm: kmemleak: add OBJECT_PHYS flag for objects allocated with physical address
Date:   Sat, 11 Jun 2022 11:55:49 +0800
Message-Id: <20220611035551.1823303-3-patrick.wang.shcn@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220611035551.1823303-1-patrick.wang.shcn@gmail.com>
References: <20220611035551.1823303-1-patrick.wang.shcn@gmail.com>
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

Add OBJECT_PHYS flag for object. This flag is used
to identify the objects allocated with physical address.
The create_object_phys() function is added as well to
set that flag and is used by kmemleak_alloc_phys().

Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Patrick Wang <patrick.wang.shcn@gmail.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
---
 mm/kmemleak.c | 40 +++++++++++++++++++++++++++++++---------
 1 file changed, 31 insertions(+), 9 deletions(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 156eafafa182..d82d8db0e8df 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -172,6 +172,8 @@ struct kmemleak_object {
 #define OBJECT_NO_SCAN		(1 << 2)
 /* flag set to fully scan the object when scan_area allocation failed */
 #define OBJECT_FULL_SCAN	(1 << 3)
+/* flag set for object allocated with physical address */
+#define OBJECT_PHYS		(1 << 4)
 
 #define HEX_PREFIX		"    "
 /* number of bytes to print per line; must be 16 or 32 */
@@ -574,8 +576,9 @@ static int __save_stack_trace(unsigned long *trace)
  * Create the metadata (struct kmemleak_object) corresponding to an allocated
  * memory block and add it to the object_list and object_tree_root.
  */
-static struct kmemleak_object *create_object(unsigned long ptr, size_t size,
-					     int min_count, gfp_t gfp)
+static struct kmemleak_object *__create_object(unsigned long ptr, size_t size,
+					     int min_count, gfp_t gfp,
+					     bool is_phys)
 {
 	unsigned long flags;
 	struct kmemleak_object *object, *parent;
@@ -595,7 +598,7 @@ static struct kmemleak_object *create_object(unsigned long ptr, size_t size,
 	INIT_HLIST_HEAD(&object->area_list);
 	raw_spin_lock_init(&object->lock);
 	atomic_set(&object->use_count, 1);
-	object->flags = OBJECT_ALLOCATED;
+	object->flags = OBJECT_ALLOCATED | (is_phys ? OBJECT_PHYS : 0);
 	object->pointer = ptr;
 	object->size = kfence_ksize((void *)ptr) ?: size;
 	object->excess_ref = 0;
@@ -662,6 +665,20 @@ static struct kmemleak_object *create_object(unsigned long ptr, size_t size,
 	return object;
 }
 
+/* Create kmemleak object which allocated with virtual address. */
+static struct kmemleak_object *create_object(unsigned long ptr, size_t size,
+					     int min_count, gfp_t gfp)
+{
+	return __create_object(ptr, size, min_count, gfp, false);
+}
+
+/* Create kmemleak object which allocated with physical address. */
+static struct kmemleak_object *create_object_phys(unsigned long ptr, size_t size,
+					     int min_count, gfp_t gfp)
+{
+	return __create_object(ptr, size, min_count, gfp, true);
+}
+
 /*
  * Mark the object as not allocated and schedule RCU freeing via put_object().
  */
@@ -728,11 +745,11 @@ static void delete_object_part(unsigned long ptr, size_t size)
 	start = object->pointer;
 	end = object->pointer + object->size;
 	if (ptr > start)
-		create_object(start, ptr - start, object->min_count,
-			      GFP_KERNEL);
+		__create_object(start, ptr - start, object->min_count,
+			      GFP_KERNEL, object->flags & OBJECT_PHYS);
 	if (ptr + size < end)
-		create_object(ptr + size, end - ptr - size, object->min_count,
-			      GFP_KERNEL);
+		__create_object(ptr + size, end - ptr - size, object->min_count,
+			      GFP_KERNEL, object->flags & OBJECT_PHYS);
 
 	__delete_object(object);
 }
@@ -1129,9 +1146,14 @@ EXPORT_SYMBOL(kmemleak_no_scan);
  */
 void __ref kmemleak_alloc_phys(phys_addr_t phys, size_t size, gfp_t gfp)
 {
+	pr_debug("%s(0x%pa, %zu)\n", __func__, &phys, size);
+
 	if (PHYS_PFN(phys) >= min_low_pfn && PHYS_PFN(phys) < max_low_pfn)
-		/* assume min_count 0 */
-		kmemleak_alloc(__va(phys), size, 0, gfp);
+		/*
+		 * Create object with OBJECT_PHYS flag and
+		 * assume min_count 0.
+		 */
+		create_object_phys((unsigned long)__va(phys), size, 0, gfp);
 }
 EXPORT_SYMBOL(kmemleak_alloc_phys);
 
-- 
2.25.1

