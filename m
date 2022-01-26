Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F389C49D38E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 21:36:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbiAZUgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 15:36:35 -0500
Received: from mga01.intel.com ([192.55.52.88]:9978 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230222AbiAZUgc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 15:36:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643229392; x=1674765392;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fT5raPuy4gQlCWtdlnkOy0l3+TfxT0XyYHiwiGiH8uo=;
  b=ER21pQAQNixZZr51HDoE8m6yU0dITAoM0LXdE6OFvk7mrPzN7W2ZYZpl
   BnuVHyoIa3f6DgiI3lddIyGRYCXFGAptWFXuxqs3IxBvNSq/n/eaVeAP0
   4oupsKQgfyDQNqVGGWJ4h0b/7M4bVd4H210/l5M8B3sRgrIs1fZb6rIci
   qs1x+unukHL4aS7fIML0kFOAaHPUXxzG3yaX3ddcpjlVOmReE+sJDnERf
   URgNdjVlJe57hzRdTJuujSn8vS8L/jmaeELNFLzsyeKS/6rQd7jDanoGf
   EUoNC8vGGXILqp8+h7EqkQqDMZ+IFPZ4n8ZkNSf5FpEQB5m+luHdU5qvE
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="271098463"
X-IronPort-AV: E=Sophos;i="5.88,319,1635231600"; 
   d="scan'208";a="271098463"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 12:36:22 -0800
X-IronPort-AV: E=Sophos;i="5.88,319,1635231600"; 
   d="scan'208";a="581221490"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.202])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 12:36:22 -0800
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     intel-gfx@lists.freedesktop.org
Cc:     dri-devel@lists.freedesktop.org,
        Matt Roper <matthew.d.roper@intel.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 01/19] dma-buf-map: Add read/write helpers
Date:   Wed, 26 Jan 2022 12:36:44 -0800
Message-Id: <20220126203702.1784589-2-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20220126203702.1784589-1-lucas.demarchi@intel.com>
References: <20220126203702.1784589-1-lucas.demarchi@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In certain situations it's useful to be able to read or write to an
offset that is calculated by having the memory layout given by a struct
declaration. Usually we are going to read/write a u8, u16, u32 or u64.

Add a pair of macros dma_buf_map_read_field()/dma_buf_map_write_field()
to calculate the offset of a struct member and memcpy the data from/to
the dma_buf_map. We could use readb, readw, readl, readq and the write*
counterparts, however due to alignment issues this may not work on all
architectures. If alignment needs to be checked to call the right
function, it's not possible to decide at compile-time which function to
call: so just leave the decision to the memcpy function that will do
exactly that on IO memory or dereference the pointer.

Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: Christian König <christian.koenig@amd.com>
Cc: linux-media@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: linaro-mm-sig@lists.linaro.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 include/linux/dma-buf-map.h | 81 +++++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/include/linux/dma-buf-map.h b/include/linux/dma-buf-map.h
index 19fa0b5ae5ec..65e927d9ce33 100644
--- a/include/linux/dma-buf-map.h
+++ b/include/linux/dma-buf-map.h
@@ -6,6 +6,7 @@
 #ifndef __DMA_BUF_MAP_H__
 #define __DMA_BUF_MAP_H__
 
+#include <linux/kernel.h>
 #include <linux/io.h>
 #include <linux/string.h>
 
@@ -229,6 +230,46 @@ static inline void dma_buf_map_clear(struct dma_buf_map *map)
 	}
 }
 
+/**
+ * dma_buf_map_memcpy_to_offset - Memcpy into offset of dma-buf mapping
+ * @dst:	The dma-buf mapping structure
+ * @offset:	The offset from which to copy
+ * @src:	The source buffer
+ * @len:	The number of byte in src
+ *
+ * Copies data into a dma-buf mapping with an offset. The source buffer is in
+ * system memory. Depending on the buffer's location, the helper picks the
+ * correct method of accessing the memory.
+ */
+static inline void dma_buf_map_memcpy_to_offset(struct dma_buf_map *dst, size_t offset,
+						const void *src, size_t len)
+{
+	if (dst->is_iomem)
+		memcpy_toio(dst->vaddr_iomem + offset, src, len);
+	else
+		memcpy(dst->vaddr + offset, src, len);
+}
+
+/**
+ * dma_buf_map_memcpy_from_offset - Memcpy from offset of dma-buf mapping into system memory
+ * @dst:	Destination in system memory
+ * @src:	The dma-buf mapping structure
+ * @src:	The offset from which to copy
+ * @len:	The number of byte in src
+ *
+ * Copies data from a dma-buf mapping with an offset. The dest buffer is in
+ * system memory. Depending on the mapping location, the helper picks the
+ * correct method of accessing the memory.
+ */
+static inline void dma_buf_map_memcpy_from_offset(void *dst, const struct dma_buf_map *src,
+						  size_t offset, size_t len)
+{
+	if (src->is_iomem)
+		memcpy_fromio(dst, src->vaddr_iomem + offset, len);
+	else
+		memcpy(dst, src->vaddr + offset, len);
+}
+
 /**
  * dma_buf_map_memcpy_to - Memcpy into dma-buf mapping
  * @dst:	The dma-buf mapping structure
@@ -263,4 +304,44 @@ static inline void dma_buf_map_incr(struct dma_buf_map *map, size_t incr)
 		map->vaddr += incr;
 }
 
+/**
+ * dma_buf_map_read_field - Read struct member from dma-buf mapping with
+ * arbitrary size and handling un-aligned accesses
+ *
+ * @map__:	The dma-buf mapping structure
+ * @type__:	The struct to be used containing the field to read
+ * @field__:	Member from struct we want to read
+ *
+ * Read a value from dma-buf mapping calculating the offset and size: this assumes
+ * the dma-buf mapping is aligned with a a struct type__. A single u8, u16, u32
+ * or u64 can be read, based on the offset and size of type__.field__.
+ */
+#define dma_buf_map_read_field(map__, type__, field__) ({				\
+	type__ *t__;									\
+	typeof(t__->field__) val__;							\
+	dma_buf_map_memcpy_from_offset(&val__, map__, offsetof(type__, field__),	\
+				       sizeof(t__->field__));				\
+	val__;										\
+})
+
+/**
+ * dma_buf_map_write_field - Write struct member to the dma-buf mapping with
+ * arbitrary size and handling un-aligned accesses
+ *
+ * @map__:	The dma-buf mapping structure
+ * @type__:	The struct to be used containing the field to write
+ * @field__:	Member from struct we want to write
+ * @val__:	Value to be written
+ *
+ * Write a value to the dma-buf mapping calculating the offset and size.
+ * A single u8, u16, u32 or u64 can be written based on the offset and size of
+ * type__.field__.
+ */
+#define dma_buf_map_write_field(map__, type__, field__, val__) ({			\
+	type__ *t__;									\
+	typeof(t__->field__) val____ = val__;						\
+	dma_buf_map_memcpy_to_offset(map__, offsetof(type__, field__),			\
+				     &val____, sizeof(t__->field__));			\
+})
+
 #endif /* __DMA_BUF_MAP_H__ */
-- 
2.35.0

