Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 124C949E341
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 14:22:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241720AbiA0NWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 08:22:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241717AbiA0NWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 08:22:36 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C8CC061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 05:22:36 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id y15so5265444lfa.9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 05:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FWO9YIEbl2WruOoU06oIsmAAcZW9kF52DRpY/EbaFsA=;
        b=O2Zbvkv9Qo3ikXFhJqnd1ezNZDO17wGjQRqAXzhVozz0qRI/n+bM+RFStWuqC51Fp3
         L/QMuVP4sF4599qYyXAI53RB9inYqg0Eit18lqpeDQ/XuzWNSzOewA+MuX0SYhZkhdM2
         UGSn+HQOxTEbon0NY/WcVG2d5HcB70yxD4K3NVW5AYHm7UJZWZ0UwJJTmRsou2i3o8GU
         ewBuMNLyXJ+MFCTPyWe9mIGmrXsDrzuR2n/JHlGKXyhourqIp1EcELodWwcMFmsqX8Rq
         ucnJZSB+aHqRHj1DzY/l89WnwdxnYtSjqcDYRLkNgGH9z198TbzKpH5I4m0MyckBlwu4
         BC+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FWO9YIEbl2WruOoU06oIsmAAcZW9kF52DRpY/EbaFsA=;
        b=IHuLgNUEYGl9gtzoXqVH2tOwUuV7f4XffXZzpemFHgh+lxR8w91aUBTgjii+UMwtVw
         9ZLPxmL02jRQLpSmUN9wNSgx/qbYrEmLLUyLQI+7qXgBFD5EvgM+gGmhIovpszDP6dMz
         yPIjGwqi9Erundv8EyCVeLdZw9TaRUAG8bk/sM+tnKl9j7eMBujO6U0Xjddx797CTZAL
         OhiJ7UiHACs4z8t6WKrmvF+wOJYHmBqPiw4mXsX8FZRo6eARSy7ZWtsrwKo0UICz49aA
         /nfxyji7KZM9Rmrte+5yT160P3xbGenzTmQbJ77LxwMX4lvPC6ttktpP/ZqwfsPaUFli
         y9WQ==
X-Gm-Message-State: AOAM532j6Ob1yq/y5RmdhYJP1wJ1XSMi53v/QsCAvCV+XTkBQ+iULCBM
        GlSnq2vDV70MdpaCORiIgvI=
X-Google-Smtp-Source: ABdhPJwMjP9wKO8E6h1MFu/ndgKiDvcZg5RIQP5a7Qt7P6fabYmuMKOssUiblVY1O2jqwDj+i8h5pA==
X-Received: by 2002:a05:6512:228f:: with SMTP id f15mr2957438lfu.115.1643289754311;
        Thu, 27 Jan 2022 05:22:34 -0800 (PST)
Received: from elysium.toya.net.pl (staticline-31-183-166-172.toya.net.pl. [31.183.166.172])
        by smtp.gmail.com with ESMTPSA id s16sm1306918lfp.197.2022.01.27.05.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 05:22:33 -0800 (PST)
From:   Karolina Drobnik <karolinadrobnik@gmail.com>
To:     linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, mike.rapoport@gmail.com,
        linux-kernel@vger.kernel.org,
        Karolina Drobnik <karolinadrobnik@gmail.com>
Subject: [PATCH 01/16] tools: Move gfp.h and slab.h from radix-tree to lib
Date:   Thu, 27 Jan 2022 14:21:19 +0100
Message-Id: <777d0cfcf531357cfe39d53987aa964a3a42ce8b.1643206612.git.karolinadrobnik@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1643206612.git.karolinadrobnik@gmail.com>
References: <cover.1643206612.git.karolinadrobnik@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Merge radix-tree definitions from gfp.h and slab.h with these
in tools/lib, so they can be used in other test suites.
Fix style issues in slab.h. Update radix-tree test files.

Signed-off-by: Karolina Drobnik <karolinadrobnik@gmail.com>
---
 tools/include/linux/gfp.h                     | 28 ++++++++++++++
 .../radix-tree => include}/linux/slab.h       | 15 ++++----
 tools/lib/slab.c                              | 38 +++++++++++++++++++
 tools/testing/radix-tree/Makefile             |  3 +-
 tools/testing/radix-tree/linux.c              | 27 -------------
 tools/testing/radix-tree/linux/gfp.h          | 33 ----------------
 6 files changed, 76 insertions(+), 68 deletions(-)
 rename tools/{testing/radix-tree => include}/linux/slab.h (68%)
 create mode 100644 tools/lib/slab.c
 delete mode 100644 tools/testing/radix-tree/linux/gfp.h

diff --git a/tools/include/linux/gfp.h b/tools/include/linux/gfp.h
index 22030756fbc0..4dce3cddd134 100644
--- a/tools/include/linux/gfp.h
+++ b/tools/include/linux/gfp.h
@@ -1,4 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 #ifndef _TOOLS_INCLUDE_LINUX_GFP_H
 #define _TOOLS_INCLUDE_LINUX_GFP_H
 
+#include <linux/types.h>
+
+#define __GFP_ZERO		0x8000u
+#define __GFP_DIRECT_RECLAIM	0x400000u
+
+#define __GFP_BITS_SHIFT 26
+#define __GFP_BITS_MASK ((gfp_t)((1 << __GFP_BITS_SHIFT) - 1))
+
+#define __GFP_HIGH		0x20u
+#define __GFP_IO		0x40u
+#define __GFP_FS		0x80u
+#define __GFP_NOWARN		0x200u
+#define __GFP_ATOMIC		0x80000u
+#define __GFP_ACCOUNT		0x100000u
+#define __GFP_KSWAPD_RECLAIM	0x2000000u
+
+#define __GFP_RECLAIM	(__GFP_DIRECT_RECLAIM | __GFP_KSWAPD_RECLAIM)
+#define GFP_ZONEMASK	0x0fu
+#define GFP_ATOMIC	(__GFP_HIGH | __GFP_ATOMIC | __GFP_KSWAPD_RECLAIM)
+#define GFP_KERNEL	(__GFP_RECLAIM | __GFP_IO | __GFP_FS)
+#define GFP_NOWAIT	(__GFP_KSWAPD_RECLAIM)
+
+static inline bool gfpflags_allow_blocking(const gfp_t gfp_flags)
+{
+	return !!(gfp_flags & __GFP_DIRECT_RECLAIM);
+}
+
 #endif /* _TOOLS_INCLUDE_LINUX_GFP_H */
diff --git a/tools/testing/radix-tree/linux/slab.h b/tools/include/linux/slab.h
similarity index 68%
rename from tools/testing/radix-tree/linux/slab.h
rename to tools/include/linux/slab.h
index 2958830ce4d7..07d7930d4003 100644
--- a/tools/testing/radix-tree/linux/slab.h
+++ b/tools/include/linux/slab.h
@@ -1,20 +1,21 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#ifndef SLAB_H
-#define SLAB_H
+#ifndef _TOOLS_SLAB_H
+#define _TOOLS_SLAB_H
 
 #include <linux/types.h>
 #include <linux/gfp.h>
 
-#define SLAB_HWCACHE_ALIGN 1
 #define SLAB_PANIC 2
 #define SLAB_RECLAIM_ACCOUNT    0x00020000UL            /* Objects are reclaimable */
 
-void *kmalloc(size_t size, gfp_t);
-void kfree(void *);
+#define kzalloc_node(size, flags, node) kmalloc(size, flags)
+
+void *kmalloc(size_t size, gfp_t gfp);
+void kfree(void *p);
 
 static inline void *kzalloc(size_t size, gfp_t gfp)
 {
-        return kmalloc(size, gfp | __GFP_ZERO);
+	return kmalloc(size, gfp | __GFP_ZERO);
 }
 
 void *kmem_cache_alloc(struct kmem_cache *cachep, int flags);
@@ -24,4 +25,4 @@ struct kmem_cache *kmem_cache_create(const char *name, unsigned int size,
 			unsigned int align, unsigned int flags,
 			void (*ctor)(void *));
 
-#endif		/* SLAB_H */
+#endif		/* _TOOLS_SLAB_H */
diff --git a/tools/lib/slab.c b/tools/lib/slab.c
new file mode 100644
index 000000000000..959997fb0652
--- /dev/null
+++ b/tools/lib/slab.c
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <stdio.h>
+#include <string.h>
+
+#include <urcu/uatomic.h>
+#include <linux/slab.h>
+#include <malloc.h>
+#include <linux/gfp.h>
+
+int kmalloc_nr_allocated;
+int kmalloc_verbose;
+
+void *kmalloc(size_t size, gfp_t gfp)
+{
+	void *ret;
+
+	if (!(gfp & __GFP_DIRECT_RECLAIM))
+		return NULL;
+
+	ret = malloc(size);
+	uatomic_inc(&kmalloc_nr_allocated);
+	if (kmalloc_verbose)
+		printf("Allocating %p from malloc\n", ret);
+	if (gfp & __GFP_ZERO)
+		memset(ret, 0, size);
+	return ret;
+}
+
+void kfree(void *p)
+{
+	if (!p)
+		return;
+	uatomic_dec(&kmalloc_nr_allocated);
+	if (kmalloc_verbose)
+		printf("Freeing %p to malloc\n", p);
+	free(p);
+}
diff --git a/tools/testing/radix-tree/Makefile b/tools/testing/radix-tree/Makefile
index aa6abfe0749c..c4ea4fbb0bfc 100644
--- a/tools/testing/radix-tree/Makefile
+++ b/tools/testing/radix-tree/Makefile
@@ -5,7 +5,8 @@ CFLAGS += -I. -I../../include -g -Og -Wall -D_LGPL_SOURCE -fsanitize=address \
 LDFLAGS += -fsanitize=address -fsanitize=undefined
 LDLIBS+= -lpthread -lurcu
 TARGETS = main idr-test multiorder xarray
-CORE_OFILES := xarray.o radix-tree.o idr.o linux.o test.o find_bit.o bitmap.o
+CORE_OFILES := xarray.o radix-tree.o idr.o linux.o test.o find_bit.o bitmap.o \
+			 slab.o
 OFILES = main.o $(CORE_OFILES) regression1.o regression2.o regression3.o \
 	 regression4.o tag_check.o multiorder.o idr-test.o iteration_check.o \
 	 iteration_check_2.o benchmark.o
diff --git a/tools/testing/radix-tree/linux.c b/tools/testing/radix-tree/linux.c
index 2d9c59df60de..81539f543954 100644
--- a/tools/testing/radix-tree/linux.c
+++ b/tools/testing/radix-tree/linux.c
@@ -14,7 +14,6 @@
 
 int nr_allocated;
 int preempt_count;
-int kmalloc_verbose;
 int test_verbose;
 
 struct kmem_cache {
@@ -78,32 +77,6 @@ void kmem_cache_free(struct kmem_cache *cachep, void *objp)
 	pthread_mutex_unlock(&cachep->lock);
 }
 
-void *kmalloc(size_t size, gfp_t gfp)
-{
-	void *ret;
-
-	if (!(gfp & __GFP_DIRECT_RECLAIM))
-		return NULL;
-
-	ret = malloc(size);
-	uatomic_inc(&nr_allocated);
-	if (kmalloc_verbose)
-		printf("Allocating %p from malloc\n", ret);
-	if (gfp & __GFP_ZERO)
-		memset(ret, 0, size);
-	return ret;
-}
-
-void kfree(void *p)
-{
-	if (!p)
-		return;
-	uatomic_dec(&nr_allocated);
-	if (kmalloc_verbose)
-		printf("Freeing %p to malloc\n", p);
-	free(p);
-}
-
 struct kmem_cache *
 kmem_cache_create(const char *name, unsigned int size, unsigned int align,
 		unsigned int flags, void (*ctor)(void *))
diff --git a/tools/testing/radix-tree/linux/gfp.h b/tools/testing/radix-tree/linux/gfp.h
deleted file mode 100644
index 32159c08a52e..000000000000
--- a/tools/testing/radix-tree/linux/gfp.h
+++ /dev/null
@@ -1,33 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _GFP_H
-#define _GFP_H
-
-#include <linux/types.h>
-
-#define __GFP_BITS_SHIFT 26
-#define __GFP_BITS_MASK ((gfp_t)((1 << __GFP_BITS_SHIFT) - 1))
-
-#define __GFP_HIGH		0x20u
-#define __GFP_IO		0x40u
-#define __GFP_FS		0x80u
-#define __GFP_NOWARN		0x200u
-#define __GFP_ZERO		0x8000u
-#define __GFP_ATOMIC		0x80000u
-#define __GFP_ACCOUNT		0x100000u
-#define __GFP_DIRECT_RECLAIM	0x400000u
-#define __GFP_KSWAPD_RECLAIM	0x2000000u
-
-#define __GFP_RECLAIM	(__GFP_DIRECT_RECLAIM|__GFP_KSWAPD_RECLAIM)
-
-#define GFP_ZONEMASK	0x0fu
-#define GFP_ATOMIC	(__GFP_HIGH|__GFP_ATOMIC|__GFP_KSWAPD_RECLAIM)
-#define GFP_KERNEL	(__GFP_RECLAIM | __GFP_IO | __GFP_FS)
-#define GFP_NOWAIT	(__GFP_KSWAPD_RECLAIM)
-
-
-static inline bool gfpflags_allow_blocking(const gfp_t gfp_flags)
-{
-	return !!(gfp_flags & __GFP_DIRECT_RECLAIM);
-}
-
-#endif
-- 
2.30.2

