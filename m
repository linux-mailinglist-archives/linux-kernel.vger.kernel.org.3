Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48C7A49F557
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 09:37:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347444AbiA1IgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 03:36:24 -0500
Received: from mga17.intel.com ([192.55.52.151]:52647 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347369AbiA1IgN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 03:36:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643358973; x=1674894973;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=X27Sz+PViqiUT7iiX5tqDW1OHIPfZBd3nD2SbADZXa4=;
  b=Ct82F9HU55A2JYfP/MIEp6wvOuB2dfUHYfQr2UNUgbpcEgSOtxS+gFyX
   zzGWu6SoTnxP7wYRhHjVP0/w/otomXDn3s4lWKHg/ueNtiojZgPbB8aZD
   ziHKj6dix6BmvhgemtE0Uc3oPTwmarzsL/0aQ+Jgio4tIcebz1PN0fC+G
   enGnXN466SmL4zhre41efTpLtK+SBa4h2NzgGPb74CtbN6lCbLsoEwODo
   R4PGBK/QJlTH4BmVgn4t2hqW6rVEhfTJ9YcPoXhQYeoIhk3uzIw4QaT2/
   xzRyvd/IAjGO41H0ZA5039uUfNc7HwpQreRAUFovToAQ9YqUXXeKijLrk
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10240"; a="227749354"
X-IronPort-AV: E=Sophos;i="5.88,323,1635231600"; 
   d="scan'208";a="227749354"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 00:36:13 -0800
X-IronPort-AV: E=Sophos;i="5.88,323,1635231600"; 
   d="scan'208";a="581788734"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.202])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 00:36:12 -0800
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     srinivas.kandagatla@linaro.org, gregkh@linuxfoundation.org,
        sumit.semwal@linaro.org, christian.koenig@amd.com,
        daniel.vetter@ffwll.ch, airlied@linux.ie, lyude@redhat.com,
        tzimmermann@suse.de, linux-media@vger.kernel.org,
        nouveau@lists.freedesktop.org
Subject: [PATCH 04/14] media: Replace dma-buf-map with iosys-map
Date:   Fri, 28 Jan 2022 00:36:16 -0800
Message-Id: <20220128083626.3012259-5-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20220128083626.3012259-1-lucas.demarchi@intel.com>
References: <20220128083626.3012259-1-lucas.demarchi@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

iosys-map is the new name for dma-buf-map and will gain new
capabitilities. Replace with the new API.

Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 drivers/media/common/videobuf2/videobuf2-dma-contig.c |  8 ++++----
 drivers/media/common/videobuf2/videobuf2-dma-sg.c     |  9 +++++----
 drivers/media/common/videobuf2/videobuf2-vmalloc.c    | 11 ++++++-----
 3 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/media/common/videobuf2/videobuf2-dma-contig.c b/drivers/media/common/videobuf2/videobuf2-dma-contig.c
index 7c4096e62173..ecf065cd4a67 100644
--- a/drivers/media/common/videobuf2/videobuf2-dma-contig.c
+++ b/drivers/media/common/videobuf2/videobuf2-dma-contig.c
@@ -99,7 +99,7 @@ static void *vb2_dc_vaddr(struct vb2_buffer *vb, void *buf_priv)
 		return buf->vaddr;
 
 	if (buf->db_attach) {
-		struct dma_buf_map map;
+		struct iosys_map map;
 
 		if (!dma_buf_vmap(buf->db_attach->dmabuf, &map))
 			buf->vaddr = map.vaddr;
@@ -446,7 +446,7 @@ vb2_dc_dmabuf_ops_end_cpu_access(struct dma_buf *dbuf,
 	return 0;
 }
 
-static int vb2_dc_dmabuf_ops_vmap(struct dma_buf *dbuf, struct dma_buf_map *map)
+static int vb2_dc_dmabuf_ops_vmap(struct dma_buf *dbuf, struct iosys_map *map)
 {
 	struct vb2_dc_buf *buf;
 	void *vaddr;
@@ -456,7 +456,7 @@ static int vb2_dc_dmabuf_ops_vmap(struct dma_buf *dbuf, struct dma_buf_map *map)
 	if (!vaddr)
 		return -EINVAL;
 
-	dma_buf_map_set_vaddr(map, vaddr);
+	iosys_map_set_vaddr(map, vaddr);
 
 	return 0;
 }
@@ -737,7 +737,7 @@ static void vb2_dc_unmap_dmabuf(void *mem_priv)
 {
 	struct vb2_dc_buf *buf = mem_priv;
 	struct sg_table *sgt = buf->dma_sgt;
-	struct dma_buf_map map = DMA_BUF_MAP_INIT_VADDR(buf->vaddr);
+	struct iosys_map map = IOSYS_MAP_INIT_VADDR(buf->vaddr);
 
 	if (WARN_ON(!buf->db_attach)) {
 		pr_err("trying to unpin a not attached buffer\n");
diff --git a/drivers/media/common/videobuf2/videobuf2-dma-sg.c b/drivers/media/common/videobuf2/videobuf2-dma-sg.c
index 90acafd9a290..f8a21c560ad2 100644
--- a/drivers/media/common/videobuf2/videobuf2-dma-sg.c
+++ b/drivers/media/common/videobuf2/videobuf2-dma-sg.c
@@ -303,7 +303,7 @@ static void vb2_dma_sg_put_userptr(void *buf_priv)
 static void *vb2_dma_sg_vaddr(struct vb2_buffer *vb, void *buf_priv)
 {
 	struct vb2_dma_sg_buf *buf = buf_priv;
-	struct dma_buf_map map;
+	struct iosys_map map;
 	int ret;
 
 	BUG_ON(!buf);
@@ -492,11 +492,12 @@ vb2_dma_sg_dmabuf_ops_end_cpu_access(struct dma_buf *dbuf,
 	return 0;
 }
 
-static int vb2_dma_sg_dmabuf_ops_vmap(struct dma_buf *dbuf, struct dma_buf_map *map)
+static int vb2_dma_sg_dmabuf_ops_vmap(struct dma_buf *dbuf,
+				      struct iosys_map *map)
 {
 	struct vb2_dma_sg_buf *buf = dbuf->priv;
 
-	dma_buf_map_set_vaddr(map, buf->vaddr);
+	iosys_map_set_vaddr(map, buf->vaddr);
 
 	return 0;
 }
@@ -581,7 +582,7 @@ static void vb2_dma_sg_unmap_dmabuf(void *mem_priv)
 {
 	struct vb2_dma_sg_buf *buf = mem_priv;
 	struct sg_table *sgt = buf->dma_sgt;
-	struct dma_buf_map map = DMA_BUF_MAP_INIT_VADDR(buf->vaddr);
+	struct iosys_map map = IOSYS_MAP_INIT_VADDR(buf->vaddr);
 
 	if (WARN_ON(!buf->db_attach)) {
 		pr_err("trying to unpin a not attached buffer\n");
diff --git a/drivers/media/common/videobuf2/videobuf2-vmalloc.c b/drivers/media/common/videobuf2/videobuf2-vmalloc.c
index 0bbfea66554f..948152f1596b 100644
--- a/drivers/media/common/videobuf2/videobuf2-vmalloc.c
+++ b/drivers/media/common/videobuf2/videobuf2-vmalloc.c
@@ -312,11 +312,12 @@ static void vb2_vmalloc_dmabuf_ops_release(struct dma_buf *dbuf)
 	vb2_vmalloc_put(dbuf->priv);
 }
 
-static int vb2_vmalloc_dmabuf_ops_vmap(struct dma_buf *dbuf, struct dma_buf_map *map)
+static int vb2_vmalloc_dmabuf_ops_vmap(struct dma_buf *dbuf,
+				       struct iosys_map *map)
 {
 	struct vb2_vmalloc_buf *buf = dbuf->priv;
 
-	dma_buf_map_set_vaddr(map, buf->vaddr);
+	iosys_map_set_vaddr(map, buf->vaddr);
 
 	return 0;
 }
@@ -372,7 +373,7 @@ static struct dma_buf *vb2_vmalloc_get_dmabuf(struct vb2_buffer *vb,
 static int vb2_vmalloc_map_dmabuf(void *mem_priv)
 {
 	struct vb2_vmalloc_buf *buf = mem_priv;
-	struct dma_buf_map map;
+	struct iosys_map map;
 	int ret;
 
 	ret = dma_buf_vmap(buf->dbuf, &map);
@@ -386,7 +387,7 @@ static int vb2_vmalloc_map_dmabuf(void *mem_priv)
 static void vb2_vmalloc_unmap_dmabuf(void *mem_priv)
 {
 	struct vb2_vmalloc_buf *buf = mem_priv;
-	struct dma_buf_map map = DMA_BUF_MAP_INIT_VADDR(buf->vaddr);
+	struct iosys_map map = IOSYS_MAP_INIT_VADDR(buf->vaddr);
 
 	dma_buf_vunmap(buf->dbuf, &map);
 	buf->vaddr = NULL;
@@ -395,7 +396,7 @@ static void vb2_vmalloc_unmap_dmabuf(void *mem_priv)
 static void vb2_vmalloc_detach_dmabuf(void *mem_priv)
 {
 	struct vb2_vmalloc_buf *buf = mem_priv;
-	struct dma_buf_map map = DMA_BUF_MAP_INIT_VADDR(buf->vaddr);
+	struct iosys_map map = IOSYS_MAP_INIT_VADDR(buf->vaddr);
 
 	if (buf->vaddr)
 		dma_buf_vunmap(buf->dbuf, &map);
-- 
2.35.0

