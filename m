Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA0724DA1FF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 19:05:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350930AbiCOSGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 14:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350905AbiCOSGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 14:06:24 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 056FD3668D
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 11:05:11 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: bbeckett)
        with ESMTPSA id AFB961F430BF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647367509;
        bh=sv/7BhTnXU6OwO9t2oOn1ya2zRweojAD5yK19Y9oJaU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KWQuk6MPHbAKO5FzGNeyNlRjlMXMJx9ygW1wM4ODTJQnqvFAtUVmAA77md3vmPiAZ
         4Jz9gf2jApf32RWcb+GXbHeDnWrWc40dQOoh95XPSJYoollakbeM/cZ68+iboqTOWA
         Jq95cjGryzWLuSO7ry1sP+CIDurxFOIQ4V4HA7xqdgN3eCL3992dgdQ2a+hIJaW5/X
         GEFfzReBsMP4DwwgJYTVtBTfdkDSGVuuWKTMkCUE8lOl+s7tDCjbM604pjE3GvfauU
         JKwc+O/shZgc0xZJSdu644hZgIk1KJBR/wWkOv01KLptaAkFPysfHyPBuMWqpEEOgI
         979RtP1a6pU1Q==
From:   Robert Beckett <bob.beckett@collabora.com>
To:     intel-gfx@lists.freedesktop.org,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Robert Beckett <bob.beckett@collabora.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 5/7] drm/ttm: add range busy check for range manager
Date:   Tue, 15 Mar 2022 18:04:42 +0000
Message-Id: <20220315180444.3327283-6-bob.beckett@collabora.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220315180444.3327283-1-bob.beckett@collabora.com>
References: <20220315180444.3327283-1-bob.beckett@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RFC: do we want this to become a generic interface in
ttm_resource_manager_func?

RFC: would we prefer a different interface? e.g.
for_each_resource_in_range or for_each_bo_in_range

Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
---
 drivers/gpu/drm/ttm/ttm_range_manager.c | 21 +++++++++++++++++++++
 include/drm/ttm/ttm_range_manager.h     |  3 +++
 2 files changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/ttm/ttm_range_manager.c b/drivers/gpu/drm/ttm/ttm_range_manager.c
index 8cd4f3fb9f79..5662627bb933 100644
--- a/drivers/gpu/drm/ttm/ttm_range_manager.c
+++ b/drivers/gpu/drm/ttm/ttm_range_manager.c
@@ -206,3 +206,24 @@ int ttm_range_man_fini_nocheck(struct ttm_device *bdev,
 	return 0;
 }
 EXPORT_SYMBOL(ttm_range_man_fini_nocheck);
+
+/**
+ * ttm_range_man_range_busy - Check whether anything is allocated with a range
+ *
+ * @man: memory manager to check
+ * @fpfn: first page number to check
+ * @lpfn: last page number to check
+ *
+ * Return: true if anything allocated within the range, false otherwise.
+ */
+bool ttm_range_man_range_busy(struct ttm_resource_manager *man,
+			      unsigned fpfn, unsigned lpfn)
+{
+	struct ttm_range_manager *rman = to_range_manager(man);
+	struct drm_mm *mm = &rman->mm;
+
+	if (__drm_mm_interval_first(mm, PFN_PHYS(fpfn), PFN_PHYS(lpfn + 1) - 1))
+		return true;
+	return false;
+}
+EXPORT_SYMBOL(ttm_range_man_range_busy);
diff --git a/include/drm/ttm/ttm_range_manager.h b/include/drm/ttm/ttm_range_manager.h
index 7963b957e9ef..86794a3f9101 100644
--- a/include/drm/ttm/ttm_range_manager.h
+++ b/include/drm/ttm/ttm_range_manager.h
@@ -53,4 +53,7 @@ static __always_inline int ttm_range_man_fini(struct ttm_device *bdev,
 	BUILD_BUG_ON(__builtin_constant_p(type) && type >= TTM_NUM_MEM_TYPES);
 	return ttm_range_man_fini_nocheck(bdev, type);
 }
+
+bool ttm_range_man_range_busy(struct ttm_resource_manager *man,
+			      unsigned fpfn, unsigned lpfn);
 #endif
-- 
2.25.1

