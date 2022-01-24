Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07BA8497700
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 02:54:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240777AbiAXByV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 20:54:21 -0500
Received: from mga06.intel.com ([134.134.136.31]:20501 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240743AbiAXByO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 20:54:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642989254; x=1674525254;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+LXecIMRVcm+6l6u17VPJeZsX7SGcDdtoraU1ufkp0U=;
  b=R5xyLskPBTZNg58Kl/RPA5/3s7uSoIYM/XXZGmgN7bKkeqjdO44ODBUc
   JzQ8UMsLgq4YyfHs63pUMNoV40cVaW7bZdgAo/SAcbOESCEGvfnTo3JOj
   oZjIixLOl6XBjVpTE09R5jbkmqbYFCwlYKSrfy4pMWXZVWPBuoub++QpC
   dtW3UNaQutkloRSpQnfbTPjEXQiJ+8Cq+yxvzTOwpqJq+5Rlf76SrX+bK
   qGJ3Nf7TRkreXbMjo5gqaGsK9eGGuE3/dVzLcdZspcJREWftHDWXqbYzM
   493fJ7c0KTr/vTx65y8RB0JFBfpO6CS66mqyVCSwAE+IxmuQywMOLC0vY
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="306658411"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="306658411"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 17:54:13 -0800
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="627320393"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 17:54:13 -0800
From:   ira.weiny@intel.com
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>
Cc:     Ira Weiny <ira.weiny@intel.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH V2 3/7] drm/gma: Remove calls to kmap()
Date:   Sun, 23 Jan 2022 17:54:05 -0800
Message-Id: <20220124015409.807587-4-ira.weiny@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220124015409.807587-1-ira.weiny@intel.com>
References: <20220124015409.807587-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

kmap() is being deprecated and these instances are easy to convert to
kmap_local_page().

Furthermore, in gma_crtc_cursor_set() use the memcpy_from_page() helper
instead of an open coded use of kmap_local_page().

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/gpu/drm/gma500/gma_display.c | 6 ++----
 drivers/gpu/drm/gma500/mmu.c         | 8 ++++----
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/gma500/gma_display.c b/drivers/gpu/drm/gma500/gma_display.c
index 99da3118131a..60ba7de59139 100644
--- a/drivers/gpu/drm/gma500/gma_display.c
+++ b/drivers/gpu/drm/gma500/gma_display.c
@@ -335,7 +335,7 @@ int gma_crtc_cursor_set(struct drm_crtc *crtc,
 	struct psb_gem_object *pobj;
 	struct psb_gem_object *cursor_pobj = gma_crtc->cursor_pobj;
 	struct drm_gem_object *obj;
-	void *tmp_dst, *tmp_src;
+	void *tmp_dst;
 	int ret = 0, i, cursor_pages;
 
 	/* If we didn't get a handle then turn the cursor off */
@@ -400,9 +400,7 @@ int gma_crtc_cursor_set(struct drm_crtc *crtc,
 		/* Copy the cursor to cursor mem */
 		tmp_dst = dev_priv->vram_addr + cursor_pobj->offset;
 		for (i = 0; i < cursor_pages; i++) {
-			tmp_src = kmap(pobj->pages[i]);
-			memcpy(tmp_dst, tmp_src, PAGE_SIZE);
-			kunmap(pobj->pages[i]);
+			memcpy_from_page(tmp_dst, pobj->pages[i], 0, PAGE_SIZE);
 			tmp_dst += PAGE_SIZE;
 		}
 
diff --git a/drivers/gpu/drm/gma500/mmu.c b/drivers/gpu/drm/gma500/mmu.c
index fe9ace2a7967..a70b01ccdf70 100644
--- a/drivers/gpu/drm/gma500/mmu.c
+++ b/drivers/gpu/drm/gma500/mmu.c
@@ -184,17 +184,17 @@ struct psb_mmu_pd *psb_mmu_alloc_pd(struct psb_mmu_driver *driver,
 		pd->invalid_pte = 0;
 	}
 
-	v = kmap(pd->dummy_pt);
+	v = kmap_local_page(pd->dummy_pt);
 	for (i = 0; i < (PAGE_SIZE / sizeof(uint32_t)); ++i)
 		v[i] = pd->invalid_pte;
 
-	kunmap(pd->dummy_pt);
+	kunmap_local(v);
 
-	v = kmap(pd->p);
+	v = kmap_local_page(pd->p);
 	for (i = 0; i < (PAGE_SIZE / sizeof(uint32_t)); ++i)
 		v[i] = pd->invalid_pde;
 
-	kunmap(pd->p);
+	kunmap_local(v);
 
 	clear_page(kmap(pd->dummy_page));
 	kunmap(pd->dummy_page);
-- 
2.31.1

