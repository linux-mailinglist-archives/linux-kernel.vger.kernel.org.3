Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31BC949D395
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 21:36:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbiAZUgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 15:36:37 -0500
Received: from mga01.intel.com ([192.55.52.88]:9978 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230445AbiAZUgd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 15:36:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643229393; x=1674765393;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SxwOX/KvCGehbJ+xk/iHXJSG5hnovWhcQo3g+1qN37Y=;
  b=WC7NUtdnxNVdLcWb1f7x4KJF5Y0NqAjWMrRM/QGSDI7LUN40RJh0CQmg
   Ep4wi2/ELFEQM45qAjSirGuDqoz101FIAE8DfANgXvJbZaeHsf/zVxRqV
   wRpjlz6VccdreEAVMGctYQBTLOlzO1o8N2prclFxUH9UH9Xaa5i0Qd1i6
   WIsuEXlzcQ+M4fMCtusCyDS4k7YyUjdOB/0OLP+tywQVk16eM7nfE0qAx
   DqoEtffsKrFYtcAQQzb1y01RKMgo2oiMW8JmnFRW4k07/LHC3N4r45MaX
   pEahCObxn2IJxhSZZ/qMIyoG225iZsUxYlaGZEgX8fUeDfGDkKRxuWdbn
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="271098466"
X-IronPort-AV: E=Sophos;i="5.88,319,1635231600"; 
   d="scan'208";a="271098466"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 12:36:22 -0800
X-IronPort-AV: E=Sophos;i="5.88,319,1635231600"; 
   d="scan'208";a="581221493"
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
Subject: [PATCH 02/19] dma-buf-map: Add helper to initialize second map
Date:   Wed, 26 Jan 2022 12:36:45 -0800
Message-Id: <20220126203702.1784589-3-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20220126203702.1784589-1-lucas.demarchi@intel.com>
References: <20220126203702.1784589-1-lucas.demarchi@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When dma_buf_map struct is passed around, it's useful to be able to
initialize a second map that takes care of reading/writing to an offset
of the original map.

Add a helper that copies the struct and add the offset to the proper
address.

Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: Christian König <christian.koenig@amd.com>
Cc: linux-media@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: linaro-mm-sig@lists.linaro.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 include/linux/dma-buf-map.h | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/include/linux/dma-buf-map.h b/include/linux/dma-buf-map.h
index 65e927d9ce33..3514a859f628 100644
--- a/include/linux/dma-buf-map.h
+++ b/include/linux/dma-buf-map.h
@@ -131,6 +131,35 @@ struct dma_buf_map {
 		.is_iomem = false, \
 	}
 
+/**
+ * DMA_BUF_MAP_INIT_OFFSET - Initializes struct dma_buf_map from another dma_buf_map
+ * @map_:	The dma-buf mapping structure to copy from
+ * @offset:	Offset to add to the other mapping
+ *
+ * Initializes a new dma_buf_struct based on another. This is the equivalent of doing:
+ *
+ * .. code-block: c
+ *
+ *	dma_buf_map map = other_map;
+ *	dma_buf_map_incr(&map, &offset);
+ *
+ * Example usage:
+ *
+ * .. code-block: c
+ *
+ *	void foo(struct device *dev, struct dma_buf_map *base_map)
+ *	{
+ *		...
+ *		struct dma_buf_map = DMA_BUF_MAP_INIT_OFFSET(base_map, FIELD_OFFSET);
+ *		...
+ *	}
+ */
+#define DMA_BUF_MAP_INIT_OFFSET(map_, offset_)	(struct dma_buf_map)	\
+	{								\
+		.vaddr = (map_)->vaddr + (offset_),			\
+		.is_iomem = (map_)->is_iomem,				\
+	}
+
 /**
  * dma_buf_map_set_vaddr - Sets a dma-buf mapping structure to an address in system memory
  * @map:	The dma-buf mapping structure
-- 
2.35.0

