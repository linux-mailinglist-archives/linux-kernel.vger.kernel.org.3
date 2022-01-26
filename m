Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5B6649D397
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 21:36:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbiAZUgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 15:36:42 -0500
Received: from mga01.intel.com ([192.55.52.88]:9982 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230527AbiAZUge (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 15:36:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643229394; x=1674765394;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IrlXjlrSWxXOy2UwGYcFGyJqa/q0NhSjnDXBLVc54aM=;
  b=FqpofSRbgvaR6lMfozaw2Cl3YmTpyQoogo2Tjh4B2IIk0Q7jiUQS7CgT
   BTiUBCIDogOC9z2N0VmjOwM/GzDRrpilbyVdV0orqlUrKZ8782oJE179V
   uu1IovWSYNWYcMClPD7LEuHZWeRTWDwzkYO4FcPNq9vTPEqkAzAOG9P9H
   1faxjSWQgiVk6wCWUAUQtoljkp/gvVlRDwuCVZ/StkMGvFh7oYCRvYJgp
   3c9mb/rm3FdLGTAEzhyKveBPz8TMiUFeePuMRl4jtEtgS8Og78pgJXTWS
   E2u8uDoIDprkByqGv/jTdS6Uamz9XG6kA7oIcT5kgXtIPGODgULJpr9NU
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="271098470"
X-IronPort-AV: E=Sophos;i="5.88,319,1635231600"; 
   d="scan'208";a="271098470"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 12:36:26 -0800
X-IronPort-AV: E=Sophos;i="5.88,319,1635231600"; 
   d="scan'208";a="581221519"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.202])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 12:36:23 -0800
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     intel-gfx@lists.freedesktop.org
Cc:     dri-devel@lists.freedesktop.org,
        Matt Roper <matthew.d.roper@intel.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/19] dma-buf-map: Add wrapper over memset
Date:   Wed, 26 Jan 2022 12:36:52 -0800
Message-Id: <20220126203702.1784589-10-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20220126203702.1784589-1-lucas.demarchi@intel.com>
References: <20220126203702.1784589-1-lucas.demarchi@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just like memcpy_toio(), there is also need to write a direct value to a
memory block. Add dma_buf_map_memset() to abstract memset() vs memset_io()

Cc: Matt Roper <matthew.d.roper@intel.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: Christian König <christian.koenig@amd.com>
Cc: linux-media@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: linaro-mm-sig@lists.linaro.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 include/linux/dma-buf-map.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/linux/dma-buf-map.h b/include/linux/dma-buf-map.h
index 3514a859f628..c9fb04264cd0 100644
--- a/include/linux/dma-buf-map.h
+++ b/include/linux/dma-buf-map.h
@@ -317,6 +317,23 @@ static inline void dma_buf_map_memcpy_to(struct dma_buf_map *dst, const void *sr
 		memcpy(dst->vaddr, src, len);
 }
 
+/**
+ * dma_buf_map_memset - Memset into dma-buf mapping
+ * @dst:	The dma-buf mapping structure
+ * @value:	The value to set
+ * @len:	The number of bytes to set in dst
+ *
+ * Set value in dma-buf mapping. Depending on the buffer's location, the helper
+ * picks the correct method of accessing the memory.
+ */
+static inline void dma_buf_map_memset(struct dma_buf_map *dst, int value, size_t len)
+{
+	if (dst->is_iomem)
+		memset_io(dst->vaddr_iomem, value, len);
+	else
+		memset(dst->vaddr, value, len);
+}
+
 /**
  * dma_buf_map_incr - Increments the address stored in a dma-buf mapping
  * @map:	The dma-buf mapping structure
-- 
2.35.0

