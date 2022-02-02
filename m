Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE314A6F77
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 12:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343705AbiBBLDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 06:03:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343679AbiBBLDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 06:03:47 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A406C061714
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 03:03:47 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id f10so13330541lfu.8
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 03:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E0Y7uqcHEMtC/3cR+10U0WbGQ+c4SstF679jAzBhdPg=;
        b=X9MdoDs/kLV4cb9pPZDNqnpAmGEmumpyN5907blV0bYbQvCp+SGTVjPhk7PXrhca2k
         8lYfOiwsdmwGpIRoJOYflFeS8DKeSbyNpcKczBRvrdUyu40X0r9iQK8zls9DHNVbXFXt
         OTYpQU07c6zKax8dgMTnbGA23kzCjCaCFyLUKWTMw9Ik3dmqC6eMG/tc704VcnFiMHkC
         2dxOABajO/ksmz4T9xaR1TciEm4mSVlKIJTt0RfvAXhK5fhzt/O2nYVJJCQ7nNfB2eBi
         fyog0vNLxe3EbJtQC/ToQyWO0igb4+YeUmgMHGNFls+ob1lI3gQek/SpaFDeSkWKkN3E
         U9Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E0Y7uqcHEMtC/3cR+10U0WbGQ+c4SstF679jAzBhdPg=;
        b=mKjTUUGnelaQIo7yNIZ03QzROitnHoPfsp8LV0yaMKN1ZkuiU5wItBbFQUey7DFHG9
         /dRguEYhHfxB+bHleQmxn8QZxtfbav96cN7c03pYEvZzqUl5qZj6lQHcvlg2W6vXf9Xh
         zhTdD+nP331e9jZEMecLQ9hJc0nnCYtNRv1v5GgA6J5hRQf1n9EZcZbJQPjsrATtFmdK
         XfxkiROBDwZPMksyeb++P4THN0Y7NuYjo6Rl25g698K6vVuaX0+GQ0KGIMXNuV0oqpFv
         oJBOMqAPDMlm+O/88QmXMxWCyGZ2OyirxkeZRvqZhoU/v358iIqCEUS99ewIKcJ9m5N2
         A8zQ==
X-Gm-Message-State: AOAM531hz1QzwAO5RsFoXFpyOBl/b1C0mlAlYCF9tmCz+pS6Hb4ResGX
        BzluzU1bE/q2Vaovr0FDc7A=
X-Google-Smtp-Source: ABdhPJzJZ1GEdA2aoR6Ez0SI6XBSLsCqPP7a8YloGUvcGjD8Zvb768Sd3DNkYtqcuwmPPVNNBwislw==
X-Received: by 2002:a05:6512:228a:: with SMTP id f10mr13803059lfu.22.1643799825825;
        Wed, 02 Feb 2022 03:03:45 -0800 (PST)
Received: from localhost.localdomain (staticline-31-183-164-222.toya.net.pl. [31.183.164.222])
        by smtp.gmail.com with ESMTPSA id r14sm4503937lfr.129.2022.02.02.03.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 03:03:45 -0800 (PST)
From:   Karolina Drobnik <karolinadrobnik@gmail.com>
To:     linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, rppt@kernel.org,
        linux-kernel@vger.kernel.org,
        Karolina Drobnik <karolinadrobnik@gmail.com>
Subject: [PATCH v2 01/16] tools: Move gfp.h and slab.h from radix-tree to lib
Date:   Wed,  2 Feb 2022 12:03:00 +0100
Message-Id: <b76ddb8a12fdf9870b55c1401213e44f5e0d0da3.1643796665.git.karolinadrobnik@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1643796665.git.karolinadrobnik@gmail.com>
References: <cover.1643796665.git.karolinadrobnik@gmail.com>
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
index 22030756fbc0..b238dbc9eb85 100644
--- a/tools/include/linux/gfp.h
+++ b/tools/include/linux/gfp.h
@@ -1,4 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 #ifndef _TOOLS_INCLUDE_LINUX_GFP_H
 #define _TOOLS_INCLUDE_LINUX_GFP_H
 
+#include <linux/types.h>
+
+#define __GFP_BITS_SHIFT 26
+#define __GFP_BITS_MASK ((gfp_t)((1 << __GFP_BITS_SHIFT) - 1))
+
+#define __GFP_HIGH		0x20u
+#define __GFP_IO		0x40u
+#define __GFP_FS		0x80u
+#define __GFP_NOWARN		0x200u
+#define __GFP_ZERO		0x8000u
+#define __GFP_ATOMIC		0x80000u
+#define __GFP_ACCOUNT		0x100000u
+#define __GFP_DIRECT_RECLAIM	0x400000u
+#define __GFP_KSWAPD_RECLAIM	0x2000000u
+
+#define __GFP_RECLAIM	(__GFP_DIRECT_RECLAIM | __GFP_KSWAPD_RECLAIM)
+
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

