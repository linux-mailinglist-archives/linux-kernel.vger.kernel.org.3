Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 856915471B2
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 05:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350209AbiFKD56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 23:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347341AbiFKD5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 23:57:50 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ACB5B1DA
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 20:57:49 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id o17so803501pla.6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 20:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o8/TqUYnqNg8t/CvW6LMFVObKWE28UfvOsyQO7sI0J4=;
        b=p0tg6a/DgSUkvvHvfQo80tdneeHe9jNuP4jrsIHdzIxYIp++31whZIQa4/6FV4nsui
         LqZVM73UOCXFXTZteprQJFsihWDM8uG2wbVdm8hYuxs8d7VxtKWVozOnFqAV46vaety3
         3Vza9j1yhc1pnsMXaZ60aJGDI7eEKZmsKA70/e33o+uk0BtEwT/aMnIlDGS5eaq/cUZG
         Fb2RwHFMZw0pRe+nGqP6mvOJt7cugOIddlaeiiS756I8oj+t9W31T4F0ISGmRLkNQg/g
         4mw5F9plzlAROpfnhrlwkcgIoGGqoAdqbpDXvJjvfQ9dMwkzOqIBcvejv0XZmdShjMDZ
         hv0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o8/TqUYnqNg8t/CvW6LMFVObKWE28UfvOsyQO7sI0J4=;
        b=QkSn+jc1OowWpf0Hb8osNqVxe3v0YoWdN+H5JaWpnMj/UO1gZNjl5dkQtfZ9LNwY8Y
         dqT147R8YX4PUSw7lLoT5fnERo9F8n7SHSxLcuOKdfNhsfKJBRRoY11Qg2teR7B9Gjz4
         k4dbWLqzqA3Io8eKv8a7PDKgRBVYg4t3JKVch3WTQqmm8RoL+L/MF9Gw10KY/xqBxb8/
         R/aZ0mds0Sx9CHTSyLwAN8d7gPt8wnluC2Im+lp6NkLHrSzluSed3FXmpZCOqExATyKI
         E4LRQs2jT5N8Uov9SWSjfrU+IUThKYC3NuKzJ6eeuk2YFHwxD6AIryYIwH7sGKUbq6Vy
         Y9cA==
X-Gm-Message-State: AOAM531Ih/LajDjlWAmZGbQZyK1leSY7GMuPrM4U0+hmNM70uwZ/CGz7
        W6NYY4UF1yCNeICVL5JJHZY=
X-Google-Smtp-Source: ABdhPJynE51UJe048V/xez49gTko/wcGxVofrqoECSyy2R6y0qqcQiW6nvrNhizLnUez7lPRSlQSsQ==
X-Received: by 2002:a17:902:d652:b0:168:bffe:e5fe with SMTP id y18-20020a170902d65200b00168bffee5femr5081930plh.81.1654919868565;
        Fri, 10 Jun 2022 20:57:48 -0700 (PDT)
Received: from localhost ([101.86.206.203])
        by smtp.gmail.com with ESMTPSA id jg19-20020a17090326d300b00167729dfe0bsm491809plb.168.2022.06.10.20.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 20:57:47 -0700 (PDT)
From:   Patrick Wang <patrick.wang.shcn@gmail.com>
To:     catalin.marinas@arm.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        yee.lee@mediatek.com, patrick.wang.shcn@gmail.com
Subject: [PATCH v4 1/4] mm: kmemleak: remove kmemleak_not_leak_phys() and the min_count argument to kmemleak_alloc_phys()
Date:   Sat, 11 Jun 2022 11:55:48 +0800
Message-Id: <20220611035551.1823303-2-patrick.wang.shcn@gmail.com>
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

Remove the unused kmemleak_not_leak_phys() function.
And remove the min_count argument to kmemleak_alloc_phys()
function, assume it's 0.

Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Patrick Wang <patrick.wang.shcn@gmail.com>
---
 Documentation/dev-tools/kmemleak.rst    |  1 -
 drivers/of/fdt.c                        |  2 +-
 include/linux/kmemleak.h                |  8 ++------
 mm/kmemleak.c                           | 20 +++-----------------
 mm/memblock.c                           | 14 +++++++-------
 tools/testing/memblock/linux/kmemleak.h |  2 +-
 6 files changed, 14 insertions(+), 33 deletions(-)

diff --git a/Documentation/dev-tools/kmemleak.rst b/Documentation/dev-tools/kmemleak.rst
index 1c935f41cd3a..5483fd39ef29 100644
--- a/Documentation/dev-tools/kmemleak.rst
+++ b/Documentation/dev-tools/kmemleak.rst
@@ -174,7 +174,6 @@ mapping:
 
 - ``kmemleak_alloc_phys``
 - ``kmemleak_free_part_phys``
-- ``kmemleak_not_leak_phys``
 - ``kmemleak_ignore_phys``
 
 Dealing with false positives/negatives
diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index a8f5b6532165..2c677e84c3f5 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -529,7 +529,7 @@ static int __init __reserved_mem_reserve_reg(unsigned long node,
 			pr_debug("Reserved memory: reserved region for node '%s': base %pa, size %lu MiB\n",
 				uname, &base, (unsigned long)(size / SZ_1M));
 			if (!nomap)
-				kmemleak_alloc_phys(base, size, 0, 0);
+				kmemleak_alloc_phys(base, size, 0);
 		}
 		else
 			pr_info("Reserved memory: failed to reserve memory for node '%s': base %pa, size %lu MiB\n",
diff --git a/include/linux/kmemleak.h b/include/linux/kmemleak.h
index 34684b2026ab..6a3cd1bf4680 100644
--- a/include/linux/kmemleak.h
+++ b/include/linux/kmemleak.h
@@ -29,10 +29,9 @@ extern void kmemleak_not_leak(const void *ptr) __ref;
 extern void kmemleak_ignore(const void *ptr) __ref;
 extern void kmemleak_scan_area(const void *ptr, size_t size, gfp_t gfp) __ref;
 extern void kmemleak_no_scan(const void *ptr) __ref;
-extern void kmemleak_alloc_phys(phys_addr_t phys, size_t size, int min_count,
+extern void kmemleak_alloc_phys(phys_addr_t phys, size_t size,
 				gfp_t gfp) __ref;
 extern void kmemleak_free_part_phys(phys_addr_t phys, size_t size) __ref;
-extern void kmemleak_not_leak_phys(phys_addr_t phys) __ref;
 extern void kmemleak_ignore_phys(phys_addr_t phys) __ref;
 
 static inline void kmemleak_alloc_recursive(const void *ptr, size_t size,
@@ -107,15 +106,12 @@ static inline void kmemleak_no_scan(const void *ptr)
 {
 }
 static inline void kmemleak_alloc_phys(phys_addr_t phys, size_t size,
-				       int min_count, gfp_t gfp)
+				       gfp_t gfp)
 {
 }
 static inline void kmemleak_free_part_phys(phys_addr_t phys, size_t size)
 {
 }
-static inline void kmemleak_not_leak_phys(phys_addr_t phys)
-{
-}
 static inline void kmemleak_ignore_phys(phys_addr_t phys)
 {
 }
diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index a182f5ddaf68..156eafafa182 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -1125,15 +1125,13 @@ EXPORT_SYMBOL(kmemleak_no_scan);
  *			 address argument
  * @phys:	physical address of the object
  * @size:	size of the object
- * @min_count:	minimum number of references to this object.
- *              See kmemleak_alloc()
  * @gfp:	kmalloc() flags used for kmemleak internal memory allocations
  */
-void __ref kmemleak_alloc_phys(phys_addr_t phys, size_t size, int min_count,
-			       gfp_t gfp)
+void __ref kmemleak_alloc_phys(phys_addr_t phys, size_t size, gfp_t gfp)
 {
 	if (PHYS_PFN(phys) >= min_low_pfn && PHYS_PFN(phys) < max_low_pfn)
-		kmemleak_alloc(__va(phys), size, min_count, gfp);
+		/* assume min_count 0 */
+		kmemleak_alloc(__va(phys), size, 0, gfp);
 }
 EXPORT_SYMBOL(kmemleak_alloc_phys);
 
@@ -1151,18 +1149,6 @@ void __ref kmemleak_free_part_phys(phys_addr_t phys, size_t size)
 }
 EXPORT_SYMBOL(kmemleak_free_part_phys);
 
-/**
- * kmemleak_not_leak_phys - similar to kmemleak_not_leak but taking a physical
- *			    address argument
- * @phys:	physical address of the object
- */
-void __ref kmemleak_not_leak_phys(phys_addr_t phys)
-{
-	if (PHYS_PFN(phys) >= min_low_pfn && PHYS_PFN(phys) < max_low_pfn)
-		kmemleak_not_leak(__va(phys));
-}
-EXPORT_SYMBOL(kmemleak_not_leak_phys);
-
 /**
  * kmemleak_ignore_phys - similar to kmemleak_ignore but taking a physical
  *			  address argument
diff --git a/mm/memblock.c b/mm/memblock.c
index e4f03a6e8e56..749abd2685c4 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1345,8 +1345,8 @@ __next_mem_pfn_range_in_zone(u64 *idx, struct zone *zone,
  * from the regions with mirroring enabled and then retried from any
  * memory region.
  *
- * In addition, function sets the min_count to 0 using kmemleak_alloc_phys for
- * allocated boot memory block, so that it is never reported as leaks.
+ * In addition, function using kmemleak_alloc_phys for allocated boot
+ * memory block, it is never reported as leaks.
  *
  * Return:
  * Physical address of allocated memory block on success, %0 on failure.
@@ -1398,12 +1398,12 @@ phys_addr_t __init memblock_alloc_range_nid(phys_addr_t size,
 	 */
 	if (end != MEMBLOCK_ALLOC_NOLEAKTRACE)
 		/*
-		 * The min_count is set to 0 so that memblock allocated
-		 * blocks are never reported as leaks. This is because many
-		 * of these blocks are only referred via the physical
-		 * address which is not looked up by kmemleak.
+		 * Memblock allocated blocks are never reported as
+		 * leaks. This is because many of these blocks are
+		 * only referred via the physical address which is
+		 * not looked up by kmemleak.
 		 */
-		kmemleak_alloc_phys(found, size, 0, 0);
+		kmemleak_alloc_phys(found, size, 0);
 
 	return found;
 }
diff --git a/tools/testing/memblock/linux/kmemleak.h b/tools/testing/memblock/linux/kmemleak.h
index 462f8c5e8aa0..5fed13bb9ec4 100644
--- a/tools/testing/memblock/linux/kmemleak.h
+++ b/tools/testing/memblock/linux/kmemleak.h
@@ -7,7 +7,7 @@ static inline void kmemleak_free_part_phys(phys_addr_t phys, size_t size)
 }
 
 static inline void kmemleak_alloc_phys(phys_addr_t phys, size_t size,
-				       int min_count, gfp_t gfp)
+				       gfp_t gfp)
 {
 }
 
-- 
2.25.1

