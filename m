Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 300C64AD6B5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 12:29:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346218AbiBHL3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 06:29:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239869AbiBHKpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 05:45:12 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF8EFC03FEC0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 02:45:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644317111; x=1675853111;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mN9K51vTDl0W52W7ywGb05QpC05SBH0LiTQxmYECtEA=;
  b=nvVQpxODBIPorvhWQVGC1QDjJygFK5Qocn3bYPvSctMPdTtUwI53Jh1O
   rUzzddEhjfFrH7hSbhsC93sSyCCk6HpJrIB2VnoMVxX01x7YEhX9fTxVN
   n41Bcf7EfvWmcmusTr4spi5zispno4CTQC6b/Ud9leOdAxiT+6Z57eJ/h
   NMpQrKearOlGMGBhFw6qs/Wtu++y5YF+extc/FG/oYr/Il2jFpGbOwELm
   1c1HjbctWDEkTPLXmdl1wwxkNv0a3dBBP98S+4jtbl14gDw+nzeWRmaSQ
   2v9X5CbpNguRJ65+dJlK8J8TN/JjxOc7ouvziBu9F8P+etcTIvbWUTyDM
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10251"; a="228890724"
X-IronPort-AV: E=Sophos;i="5.88,352,1635231600"; 
   d="scan'208";a="228890724"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 02:45:10 -0800
X-IronPort-AV: E=Sophos;i="5.88,352,1635231600"; 
   d="scan'208";a="700804108"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.202])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 02:45:09 -0800
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     John Harrison <John.C.Harrison@Intel.com>,
        Matthew Brost <matthew.brost@intel.com>,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
        Matt Roper <matthew.d.roper@intel.com>,
        =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= 
        <thomas.hellstrom@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/18] iosys-map: Add offset to iosys_map_memcpy_to()
Date:   Tue,  8 Feb 2022 02:45:07 -0800
Message-Id: <20220208104524.2516209-2-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220208104524.2516209-1-lucas.demarchi@intel.com>
References: <20220208104524.2516209-1-lucas.demarchi@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In certain situations it's useful to be able to write to an
offset of the mapping. Add a dst_offset to iosys_map_memcpy_to().

Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: Christian König <christian.koenig@amd.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/drm_cache.c     |  2 +-
 drivers/gpu/drm/drm_fb_helper.c |  2 +-
 include/linux/iosys-map.h       | 17 +++++++++--------
 3 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/drm_cache.c b/drivers/gpu/drm/drm_cache.c
index 66597e411764..c3e6e615bf09 100644
--- a/drivers/gpu/drm/drm_cache.c
+++ b/drivers/gpu/drm/drm_cache.c
@@ -218,7 +218,7 @@ static void memcpy_fallback(struct iosys_map *dst,
 	if (!dst->is_iomem && !src->is_iomem) {
 		memcpy(dst->vaddr, src->vaddr, len);
 	} else if (!src->is_iomem) {
-		iosys_map_memcpy_to(dst, src->vaddr, len);
+		iosys_map_memcpy_to(dst, 0, src->vaddr, len);
 	} else if (!dst->is_iomem) {
 		memcpy_fromio(dst->vaddr, src->vaddr_iomem, len);
 	} else {
diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index 238f815cb2a0..bf5cc9a42e5a 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -385,7 +385,7 @@ static void drm_fb_helper_damage_blit_real(struct drm_fb_helper *fb_helper,
 	iosys_map_incr(dst, offset); /* go to first pixel within clip rect */
 
 	for (y = clip->y1; y < clip->y2; y++) {
-		iosys_map_memcpy_to(dst, src, len);
+		iosys_map_memcpy_to(dst, 0, src, len);
 		iosys_map_incr(dst, fb->pitches[0]);
 		src += fb->pitches[0];
 	}
diff --git a/include/linux/iosys-map.h b/include/linux/iosys-map.h
index f4186f91caa6..edd730b1e899 100644
--- a/include/linux/iosys-map.h
+++ b/include/linux/iosys-map.h
@@ -220,22 +220,23 @@ static inline void iosys_map_clear(struct iosys_map *map)
 }
 
 /**
- * iosys_map_memcpy_to - Memcpy into iosys mapping
+ * iosys_map_memcpy_to - Memcpy into offset of iosys_map
  * @dst:	The iosys_map structure
+ * @dst_offset:	The offset from which to copy
  * @src:	The source buffer
  * @len:	The number of byte in src
  *
- * Copies data into a iosys mapping. The source buffer is in system
- * memory. Depending on the buffer's location, the helper picks the correct
- * method of accessing the memory.
+ * Copies data into a iosys_map with an offset. The source buffer is in
+ * system memory. Depending on the buffer's location, the helper picks the
+ * correct method of accessing the memory.
  */
-static inline void iosys_map_memcpy_to(struct iosys_map *dst, const void *src,
-				       size_t len)
+static inline void iosys_map_memcpy_to(struct iosys_map *dst, size_t dst_offset,
+				       const void *src, size_t len)
 {
 	if (dst->is_iomem)
-		memcpy_toio(dst->vaddr_iomem, src, len);
+		memcpy_toio(dst->vaddr_iomem + dst_offset, src, len);
 	else
-		memcpy(dst->vaddr, src, len);
+		memcpy(dst->vaddr + dst_offset, src, len);
 }
 
 /**
-- 
2.35.1

