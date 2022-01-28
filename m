Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E82FF49F563
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 09:37:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347540AbiA1Igk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 03:36:40 -0500
Received: from mga17.intel.com ([192.55.52.151]:52647 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347426AbiA1IgW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 03:36:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643358982; x=1674894982;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1U7pwJGMWLiJdfXnMg2A6L06pGkJX6HEaTyDzBjv1+4=;
  b=V2Qx6kuXySn+w52yUQTXtfkaePwYZD7xVzeZQrAt7KgKJMtY0l38vToi
   FrS2qlV4ZQVVnp4COhcnVO8zLvQfVua5dtKd1hog7j96hI5N80hIyLrup
   t8DUmxIkLB6+4pEQeVzbkQ4ONujrE2UEEpaEzzdfa4KYN1JvSbQNNvT40
   nO1E60ia8GEaKk/pYFS4WEpga6XWU5KVnfuGVP1V2Gky+WRpr7c3okF4R
   xnZpXJQuXlqTJpNwE7tRwhoEgt1uHvfXjLb0lqrSPhhKhr2HLgF+az+7I
   KpO54bQ93YOXU4/TKe8k6jxZBclp3zUhrr0cgC+sp54v/dLvQ+ZFfI61A
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10240"; a="227749371"
X-IronPort-AV: E=Sophos;i="5.88,323,1635231600"; 
   d="scan'208";a="227749371"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 00:36:16 -0800
X-IronPort-AV: E=Sophos;i="5.88,323,1635231600"; 
   d="scan'208";a="581788757"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.202])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 00:36:16 -0800
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     srinivas.kandagatla@linaro.org, gregkh@linuxfoundation.org,
        sumit.semwal@linaro.org, christian.koenig@amd.com,
        daniel.vetter@ffwll.ch, airlied@linux.ie, lyude@redhat.com,
        tzimmermann@suse.de, linux-media@vger.kernel.org,
        nouveau@lists.freedesktop.org
Subject: [PATCH 10/14] drm/tegra: Replace dma-buf-map with iosys-map
Date:   Fri, 28 Jan 2022 00:36:22 -0800
Message-Id: <20220128083626.3012259-11-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20220128083626.3012259-1-lucas.demarchi@intel.com>
References: <20220128083626.3012259-1-lucas.demarchi@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

iosys-map is the new name for dma-buf-map and will gain new
capabitilities. Replace with the new API in tegra.

Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 drivers/gpu/drm/tegra/gem.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/tegra/gem.c b/drivers/gpu/drm/tegra/gem.c
index fce0e52973c2..0063403ab5e1 100644
--- a/drivers/gpu/drm/tegra/gem.c
+++ b/drivers/gpu/drm/tegra/gem.c
@@ -174,7 +174,7 @@ static void tegra_bo_unpin(struct host1x_bo_mapping *map)
 static void *tegra_bo_mmap(struct host1x_bo *bo)
 {
 	struct tegra_bo *obj = host1x_to_tegra_bo(bo);
-	struct dma_buf_map map;
+	struct iosys_map map;
 	int ret;
 
 	if (obj->vaddr) {
@@ -191,7 +191,7 @@ static void *tegra_bo_mmap(struct host1x_bo *bo)
 static void tegra_bo_munmap(struct host1x_bo *bo, void *addr)
 {
 	struct tegra_bo *obj = host1x_to_tegra_bo(bo);
-	struct dma_buf_map map = DMA_BUF_MAP_INIT_VADDR(addr);
+	struct iosys_map map = IOSYS_MAP_INIT_VADDR(addr);
 
 	if (obj->vaddr)
 		return;
@@ -699,17 +699,17 @@ static int tegra_gem_prime_mmap(struct dma_buf *buf, struct vm_area_struct *vma)
 	return __tegra_gem_mmap(gem, vma);
 }
 
-static int tegra_gem_prime_vmap(struct dma_buf *buf, struct dma_buf_map *map)
+static int tegra_gem_prime_vmap(struct dma_buf *buf, struct iosys_map *map)
 {
 	struct drm_gem_object *gem = buf->priv;
 	struct tegra_bo *bo = to_tegra_bo(gem);
 
-	dma_buf_map_set_vaddr(map, bo->vaddr);
+	iosys_map_set_vaddr(map, bo->vaddr);
 
 	return 0;
 }
 
-static void tegra_gem_prime_vunmap(struct dma_buf *buf, struct dma_buf_map *map)
+static void tegra_gem_prime_vunmap(struct dma_buf *buf, struct iosys_map *map)
 {
 }
 
-- 
2.35.0

