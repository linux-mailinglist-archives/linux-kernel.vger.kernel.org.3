Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FAB449F54F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 09:37:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347385AbiA1IgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 03:36:15 -0500
Received: from mga17.intel.com ([192.55.52.151]:52647 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233933AbiA1IgM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 03:36:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643358971; x=1674894971;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qr1T3A46Uta94iq9GjYl5aaKNMU44ddJbA/HXt29zgg=;
  b=hWVVwlJQCLCv1lu8Bi3WRqP8K9YelSfP2f5dCy8JbAHhidcimPqIV+uG
   MvvFOLOozT44rTyeat/04m5rS6anLsWlAMoeO11kcsn+HIq4fxNGrNJY6
   0JKHejhnu7VbklZ0t04hY3gZ0MF8G2r8QHw6wm/2+c3m5bNFcyzH14AhC
   x3roc/yhBJSSWpiNnGV8E89T5DtNRoAjwipDh1mENv81eF1icpoSoo7Fy
   /uVyskW+KN5/3xKc67Kq01X8dovjaWCOphhNTrHmKCDJ8bcuyYu9TAsE9
   Jahufn1Ou2HRRqizroAHbVYne599WKFmvcdoSS+8RQFx0ZkFT4ni0O5nZ
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10240"; a="227749349"
X-IronPort-AV: E=Sophos;i="5.88,323,1635231600"; 
   d="scan'208";a="227749349"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 00:36:11 -0800
X-IronPort-AV: E=Sophos;i="5.88,323,1635231600"; 
   d="scan'208";a="581788716"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.202])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 00:36:10 -0800
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     srinivas.kandagatla@linaro.org, gregkh@linuxfoundation.org,
        sumit.semwal@linaro.org, christian.koenig@amd.com,
        daniel.vetter@ffwll.ch, airlied@linux.ie, lyude@redhat.com,
        tzimmermann@suse.de, linux-media@vger.kernel.org,
        nouveau@lists.freedesktop.org
Subject: [PATCH 01/14] iosys-map: Introduce renamed dma-buf-map
Date:   Fri, 28 Jan 2022 00:36:13 -0800
Message-Id: <20220128083626.3012259-2-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20220128083626.3012259-1-lucas.demarchi@intel.com>
References: <20220128083626.3012259-1-lucas.demarchi@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new type, struct iosys_map, to eventually replace
struct dma_buf_map and its helpers defiend in
include/linux/dma-buf-map.h.

This is mostly a copy of dma-buf-map with the renames in place and
slightly different wording to avoid tying iosys_map to dma-buf: in fact
it's just a shim layer to abstract system memory, that can be accessed
via regular load and store, from IO memory that needs to be acessed via
arch helpers. Over time the dma-buf-map proved useful outside of buffer
sharing among drivers and started to be used in helper functions for
allocation and generic use. See e.g.

	drivers/gpu/drm/drm_gem_shmem_helper.c
	drivers/gpu/drm/drm_gem_framebuffer_helper.c
	drivers/gpu/drm/drm_fb_helper.c

In the i915 driver it's also desired to share the implementation for
integrated graphics, which uses mostly system memory, with discrete
graphics, which may need to access IO memory.

Once all the drivers using dma_buf_map are converted, the dma_buf_map
can be retired and iosys_map extended to cover new use cases.

Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 MAINTAINERS                 |   1 +
 include/linux/dma-buf-map.h |   3 +
 include/linux/iosys-map.h   | 254 ++++++++++++++++++++++++++++++++++++
 3 files changed, 258 insertions(+)
 create mode 100644 include/linux/iosys-map.h

diff --git a/MAINTAINERS b/MAINTAINERS
index ea3e6c914384..27ebaded85f8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5734,6 +5734,7 @@ F:	Documentation/driver-api/dma-buf.rst
 F:	drivers/dma-buf/
 F:	include/linux/*fence.h
 F:	include/linux/dma-buf*
+F:	include/linux/iosys-map.h
 F:	include/linux/dma-resv.h
 K:	\bdma_(?:buf|fence|resv)\b
 
diff --git a/include/linux/dma-buf-map.h b/include/linux/dma-buf-map.h
index 19fa0b5ae5ec..4b4b2930660b 100644
--- a/include/linux/dma-buf-map.h
+++ b/include/linux/dma-buf-map.h
@@ -263,4 +263,7 @@ static inline void dma_buf_map_incr(struct dma_buf_map *map, size_t incr)
 		map->vaddr += incr;
 }
 
+/* Temporary include for API migration */
+#include <linux/iosys-map.h>
+
 #endif /* __DMA_BUF_MAP_H__ */
diff --git a/include/linux/iosys-map.h b/include/linux/iosys-map.h
new file mode 100644
index 000000000000..ad1f08f8f97f
--- /dev/null
+++ b/include/linux/iosys-map.h
@@ -0,0 +1,254 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Pointer abstraction for IO/system memory
+ */
+
+#ifndef __IOSYS_MAP_H__
+#define __IOSYS_MAP_H__
+
+#include <linux/io.h>
+#include <linux/string.h>
+
+/* Temporary include while user of dma-buf-map are converted to iosys-map */
+#include <linux/dma-buf-map.h>
+
+/**
+ * DOC: overview
+ *
+ * When accessing a memory region, depending on the its location, users may have
+ * to access it with I/O operations or memory load/store operations. For
+ * example, copying to system memory could be done with memcpy(), copying to I/O
+ * memory would be done with memcpy_toio().
+ *
+ * .. code-block:: c
+ *
+ *	void *vaddr = ...; // pointer to system memory
+ *	memcpy(vaddr, src, len);
+ *
+ *	void *vaddr_iomem = ...; // pointer to I/O memory
+ *	memcpy_toio(vaddr, _iomem, src, len);
+ *
+ * The user of such pointer may not have information about the mapping of that
+ * region or may want to have a single code path to handle operations on that
+ * buffer, regardless if it's located in system or IO memory. The type
+ * :c:type:`struct iosys_map <iosys_map>` and its helpers abstract that so the
+ * buffer can be passed around to other drivers or have separate duties inside
+ * the same driver for allocation, read and write operations.
+ *
+ * Open-coding access to :c:type:`struct iosys_map <iosys_map>` is considered
+ * bad style. Rather then accessing its fields directly, use one of the provided
+ * helper functions, or implement your own. For example, instances of
+ * :c:type:`struct iosys_map <iosys_map>` can be initialized statically with
+ * IOSYS_MAP_INIT_VADDR(), or at runtime with iosys_map_set_vaddr(). These
+ * helpers will set an address in system memory.
+ *
+ * .. code-block:: c
+ *
+ *	struct iosys_map map = IOSYS_MAP_INIT_VADDR(0xdeadbeaf);
+ *
+ *	iosys_map_set_vaddr(&map, 0xdeadbeaf);
+ *
+ * To set an address in I/O memory, use iosys_map_set_vaddr_iomem().
+ *
+ * .. code-block:: c
+ *
+ *	iosys_map_set_vaddr_iomem(&map, 0xdeadbeaf);
+ *
+ * Instances of struct iosys_map do not have to be cleaned up, but
+ * can be cleared to NULL with iosys_map_clear(). Cleared mappings
+ * always refer to system memory.
+ *
+ * .. code-block:: c
+ *
+ *	iosys_map_clear(&map);
+ *
+ * Test if a mapping is valid with either iosys_map_is_set() or
+ * iosys_map_is_null().
+ *
+ * .. code-block:: c
+ *
+ *	if (iosys_map_is_set(&map) != iosys_map_is_null(&map))
+ *		// always true
+ *
+ * Instances of :c:type:`struct iosys_map <iosys_map>` can be compared for
+ * equality with iosys_map_is_equal(). Mappings that point to different memory
+ * spaces, system or I/O, are never equal. That's even true if both spaces are
+ * located in the same address space, both mappings contain the same address
+ * value, or both mappings refer to NULL.
+ *
+ * .. code-block:: c
+ *
+ *	struct iosys_map sys_map; // refers to system memory
+ *	struct iosys_map io_map; // refers to I/O memory
+ *
+ *	if (iosys_map_is_equal(&sys_map, &io_map))
+ *		// always false
+ *
+ * A set up instance of struct iosys_map can be used to access or manipulate the
+ * buffer memory. Depending on the location of the memory, the provided helpers
+ * will pick the correct operations. Data can be copied into the memory with
+ * iosys_map_memcpy_to(). The address can be manipulated with iosys_map_incr().
+ *
+ * .. code-block:: c
+ *
+ *	const void *src = ...; // source buffer
+ *	size_t len = ...; // length of src
+ *
+ *	iosys_map_memcpy_to(&map, src, len);
+ *	iosys_map_incr(&map, len); // go to first byte after the memcpy
+ */
+
+/**
+ * struct iosys_map - Pointer to IO/system memory
+ * @vaddr_iomem:	The buffer's address if in I/O memory
+ * @vaddr:		The buffer's address if in system memory
+ * @is_iomem:		True if the buffer is located in I/O memory, or false
+ *			otherwise.
+ */
+#define iosys_map dma_buf_map
+
+/**
+ * IOSYS_MAP_INIT_VADDR - Initializes struct iosys_map to an address in system memory
+ * @vaddr_:	A system-memory address
+ */
+#define IOSYS_MAP_INIT_VADDR(vaddr_)	\
+	{				\
+		.vaddr = (vaddr_),	\
+		.is_iomem = false,	\
+	}
+
+/**
+ * iosys_map_set_vaddr - Sets a iosys mapping structure to an address in system memory
+ * @map:	The iosys_map structure
+ * @vaddr:	A system-memory address
+ *
+ * Sets the address and clears the I/O-memory flag.
+ */
+static inline void iosys_map_set_vaddr(struct iosys_map *map, void *vaddr)
+{
+	map->vaddr = vaddr;
+	map->is_iomem = false;
+}
+
+/**
+ * iosys_map_set_vaddr_iomem - Sets a iosys mapping structure to an address in I/O memory
+ * @map:		The iosys_map structure
+ * @vaddr_iomem:	An I/O-memory address
+ *
+ * Sets the address and the I/O-memory flag.
+ */
+static inline void iosys_map_set_vaddr_iomem(struct iosys_map *map,
+					     void __iomem *vaddr_iomem)
+{
+	map->vaddr_iomem = vaddr_iomem;
+	map->is_iomem = true;
+}
+
+/**
+ * iosys_map_is_equal - Compares two iosys mapping structures for equality
+ * @lhs:	The iosys_map structure
+ * @rhs:	A iosys_map structure to compare with
+ *
+ * Two iosys mapping structures are equal if they both refer to the same type of memory
+ * and to the same address within that memory.
+ *
+ * Returns:
+ * True is both structures are equal, or false otherwise.
+ */
+static inline bool iosys_map_is_equal(const struct iosys_map *lhs,
+				      const struct iosys_map *rhs)
+{
+	if (lhs->is_iomem != rhs->is_iomem)
+		return false;
+	else if (lhs->is_iomem)
+		return lhs->vaddr_iomem == rhs->vaddr_iomem;
+	else
+		return lhs->vaddr == rhs->vaddr;
+}
+
+/**
+ * iosys_map_is_null - Tests for a iosys mapping to be NULL
+ * @map:	The iosys_map structure
+ *
+ * Depending on the state of struct iosys_map.is_iomem, tests if the
+ * mapping is NULL.
+ *
+ * Returns:
+ * True if the mapping is NULL, or false otherwise.
+ */
+static inline bool iosys_map_is_null(const struct iosys_map *map)
+{
+	if (map->is_iomem)
+		return !map->vaddr_iomem;
+	return !map->vaddr;
+}
+
+/**
+ * iosys_map_is_set - Tests if the iosys mapping has been set
+ * @map:	The iosys_map structure
+ *
+ * Depending on the state of struct iosys_map.is_iomem, tests if the
+ * mapping has been set.
+ *
+ * Returns:
+ * True if the mapping is been set, or false otherwise.
+ */
+static inline bool iosys_map_is_set(const struct iosys_map *map)
+{
+	return !iosys_map_is_null(map);
+}
+
+/**
+ * iosys_map_clear - Clears a iosys mapping structure
+ * @map:	The iosys_map structure
+ *
+ * Clears all fields to zero, including struct iosys_map.is_iomem, so
+ * mapping structures that were set to point to I/O memory are reset for
+ * system memory. Pointers are cleared to NULL. This is the default.
+ */
+static inline void iosys_map_clear(struct iosys_map *map)
+{
+	if (map->is_iomem) {
+		map->vaddr_iomem = NULL;
+		map->is_iomem = false;
+	} else {
+		map->vaddr = NULL;
+	}
+}
+
+/**
+ * iosys_map_memcpy_to - Memcpy into iosys mapping
+ * @dst:	The iosys_map structure
+ * @src:	The source buffer
+ * @len:	The number of byte in src
+ *
+ * Copies data into a iosys mapping. The source buffer is in system
+ * memory. Depending on the buffer's location, the helper picks the correct
+ * method of accessing the memory.
+ */
+static inline void iosys_map_memcpy_to(struct iosys_map *dst, const void *src,
+				       size_t len)
+{
+	if (dst->is_iomem)
+		memcpy_toio(dst->vaddr_iomem, src, len);
+	else
+		memcpy(dst->vaddr, src, len);
+}
+
+/**
+ * iosys_map_incr - Increments the address stored in a iosys mapping
+ * @map:	The iosys_map structure
+ * @incr:	The number of bytes to increment
+ *
+ * Increments the address stored in a iosys mapping. Depending on the
+ * buffer's location, the correct value will be updated.
+ */
+static inline void iosys_map_incr(struct iosys_map *map, size_t incr)
+{
+	if (map->is_iomem)
+		map->vaddr_iomem += incr;
+	else
+		map->vaddr += incr;
+}
+
+#endif /* __IOSYS_MAP_H__ */
-- 
2.35.0

