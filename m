Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 552E049F561
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 09:37:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347501AbiA1Ige (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 03:36:34 -0500
Received: from mga17.intel.com ([192.55.52.151]:52654 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347388AbiA1IgQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 03:36:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643358976; x=1674894976;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bdEBKEgCbzDLgcRVHEuyBIgwVSj/xSLV6fZSXsJ5tNA=;
  b=W5K8IZnP+taw9f3ijhWsPPMjIzYFSgdlbYl6wFDy/iT1pUffPprdE59i
   ZMsOg/JOXkx8YIac8aulXJadFMWNL/XL6v1/K55ZTnl2Q0gN+Evgc8ssP
   LIs0sRDtEGocLg0GfpkusYnPhLdLxIvyBx0WHx4fUfJw/WSXxvSu7TB6c
   R1VenW4prjp8dyLIk49QuQcHlZkaXFYRmYe5ebXKibWoRQX4l60+++DQ2
   bJPeIiJmRtELKl98KVLYcVVK8JxECoIQqPUsT16ungotbZWRfAT5mL52X
   PlQ77LZqeuZs3rxkUYnD/aQv6Q7bQs7xutAAVhzsKdDq/ue/hZjTBSNJu
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10240"; a="227749368"
X-IronPort-AV: E=Sophos;i="5.88,323,1635231600"; 
   d="scan'208";a="227749368"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 00:36:16 -0800
X-IronPort-AV: E=Sophos;i="5.88,323,1635231600"; 
   d="scan'208";a="581788750"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.202])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 00:36:14 -0800
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     srinivas.kandagatla@linaro.org, gregkh@linuxfoundation.org,
        sumit.semwal@linaro.org, christian.koenig@amd.com,
        daniel.vetter@ffwll.ch, airlied@linux.ie, lyude@redhat.com,
        tzimmermann@suse.de, linux-media@vger.kernel.org,
        nouveau@lists.freedesktop.org
Subject: [PATCH 08/14] drm/msm: Replace dma-buf-map with iosys-map
Date:   Fri, 28 Jan 2022 00:36:20 -0800
Message-Id: <20220128083626.3012259-9-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20220128083626.3012259-1-lucas.demarchi@intel.com>
References: <20220128083626.3012259-1-lucas.demarchi@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

iosys-map is the new name for dma-buf-map and will gain new
capabitilities. Replace with the new API in msm.

Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 drivers/gpu/drm/msm/msm_drv.h       | 4 ++--
 drivers/gpu/drm/msm/msm_gem_prime.c | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
index d7574e6bd4e4..ae52412d529a 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -309,8 +309,8 @@ void msm_gem_shrinker_init(struct drm_device *dev);
 void msm_gem_shrinker_cleanup(struct drm_device *dev);
 
 struct sg_table *msm_gem_prime_get_sg_table(struct drm_gem_object *obj);
-int msm_gem_prime_vmap(struct drm_gem_object *obj, struct dma_buf_map *map);
-void msm_gem_prime_vunmap(struct drm_gem_object *obj, struct dma_buf_map *map);
+int msm_gem_prime_vmap(struct drm_gem_object *obj, struct iosys_map *map);
+void msm_gem_prime_vunmap(struct drm_gem_object *obj, struct iosys_map *map);
 struct drm_gem_object *msm_gem_prime_import_sg_table(struct drm_device *dev,
 		struct dma_buf_attachment *attach, struct sg_table *sg);
 int msm_gem_prime_pin(struct drm_gem_object *obj);
diff --git a/drivers/gpu/drm/msm/msm_gem_prime.c b/drivers/gpu/drm/msm/msm_gem_prime.c
index fc94e061d6a7..e8f1b7a2ca9c 100644
--- a/drivers/gpu/drm/msm/msm_gem_prime.c
+++ b/drivers/gpu/drm/msm/msm_gem_prime.c
@@ -22,19 +22,19 @@ struct sg_table *msm_gem_prime_get_sg_table(struct drm_gem_object *obj)
 	return drm_prime_pages_to_sg(obj->dev, msm_obj->pages, npages);
 }
 
-int msm_gem_prime_vmap(struct drm_gem_object *obj, struct dma_buf_map *map)
+int msm_gem_prime_vmap(struct drm_gem_object *obj, struct iosys_map *map)
 {
 	void *vaddr;
 
 	vaddr = msm_gem_get_vaddr(obj);
 	if (IS_ERR(vaddr))
 		return PTR_ERR(vaddr);
-	dma_buf_map_set_vaddr(map, vaddr);
+	iosys_map_set_vaddr(map, vaddr);
 
 	return 0;
 }
 
-void msm_gem_prime_vunmap(struct drm_gem_object *obj, struct dma_buf_map *map)
+void msm_gem_prime_vunmap(struct drm_gem_object *obj, struct iosys_map *map)
 {
 	msm_gem_put_vaddr(obj);
 }
-- 
2.35.0

