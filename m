Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5ACA4A637A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 19:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241859AbiBASRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 13:17:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241848AbiBASRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 13:17:18 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E1DC06173E
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 10:17:18 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id u15so33692870wrt.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 10:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rJMqXPaVL95oHWo02aWXgQXHFtdA4jRaSIHaF0ly6XU=;
        b=b+1KBNp5Lw9AD8Qnazv2vW8RzF6NmPGFa0WKMrf+rFINVItMfyYLnVtgJ+RfFQp8nj
         KpVcIOY0uKE7gdMZ6ETcdqSg2pjdV+AD+OTVOZLO2Bbhtsw/zuzJqxulVH3UqeAjobb3
         9KS6UeWcfYC13BC8Y2sD5cGieepcq3chmbpDVZ+kkbKFI9aSBVAtXBvUWIxwWQbTvigy
         SsXoHmgi8obf3S8y9//vvkaLI+i08jGKzSqsVKbGO62MnbkECn5B911bSWqBPdTvf6WO
         QLl591I6BOpdB7QLyrNz63Ev96faPzXRdBzq1/8tPRInkS4+yd8m5/p8a8N1lMn0XW48
         lrHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rJMqXPaVL95oHWo02aWXgQXHFtdA4jRaSIHaF0ly6XU=;
        b=xF4Fm3mMpds9yo/JBbpAXKLkXlU9q0wjsTeOxs75FUVCrpaV1IXfFn8zVHuoYpAoPx
         lGrHDCybKJPXbO6Wf6gmDtyUaorZWUN13dSitSrU39K2yd9gmE7RSpphO935g/G/Loxh
         m+NuKGGOIPozH8nb5jjVT5AiSrUCseD4kfcY57gMzQukdQ+MGoxrziqb9Qe/I27VCQsH
         fQ9Vh9Y/M6hoU8xkLZSsJKV499r7e5PfjFx+7H4V323ysSh5By+VpSM6PEDEvIe9jyjE
         WSMISw/sUOf/7HDetbYtvahdxthkhH8NWIe9zVM/yJs+MNickaz39zzMnQo143/w6/Tj
         i3qw==
X-Gm-Message-State: AOAM532lOhBSIEvJHiWzTb5cM/AXBihEO2xxXDcjn0XoU84fpPe67ZLC
        u7kz6EM3CDFlAKBhLkyVOw9Ftw==
X-Google-Smtp-Source: ABdhPJyisbO2n8MvBSUDTLTcPtXZSt3lzj3iXiDCZkIsdtLuFkmC1jOySJN+bs4gDXGNY3Eny1RTGw==
X-Received: by 2002:a05:6000:1081:: with SMTP id y1mr22581838wrw.660.1643739437084;
        Tue, 01 Feb 2022 10:17:17 -0800 (PST)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id b2sm17585900wri.88.2022.02.01.10.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 10:17:16 -0800 (PST)
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] drm/cma-helper: Describe what a "contiguous chunk" actually means
Date:   Tue,  1 Feb 2022 18:17:07 +0000
Message-Id: <20220201181707.204693-1-daniel.thompson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since it's inception in 2012 it has been understood that the DRM GEM CMA
helpers do not depend on CMA as the backend allocator. In fact the first
bug fix to ensure the cma-helpers work correctly with an IOMMU backend
appeared in 2014. However currently the documentation for
drm_gem_cma_create() talks about "a contiguous chunk of memory" without
making clear which address space it will be a contiguous part of.
Additionally the CMA introduction is actively misleading because it only
contemplates the CMA backend.

This matters because when the device accesses the bus through an IOMMU
(and don't use the CMA backend) then the allocated memory is contiguous
only in the IOVA space. This is a significant difference compared to the
CMA backend and the behaviour can be a surprise even to someone who does
a reasonable level of code browsing (but doesn't find all the relevant
function pointers ;-) ).

Improve the kernel doc comments accordingly.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---

Notes:
    Changes in v3:
    - Rebased on v5.17-rc2
    - Minor improvements to wording.
    
    Changes in v2:
    - Oops. I did a final proof read and acidentally committed these
      changes as a seperate patch. This means that v1 contains only
      one tenth of the actual patch. This is fixed in v2. Many apologies
      for the noise!

 drivers/gpu/drm/drm_gem_cma_helper.c | 39 +++++++++++++++++++++-------
 1 file changed, 29 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_cma_helper.c b/drivers/gpu/drm/drm_gem_cma_helper.c
index cefd0cbf9debb..ee003af40ffe6 100644
--- a/drivers/gpu/drm/drm_gem_cma_helper.c
+++ b/drivers/gpu/drm/drm_gem_cma_helper.c
@@ -26,12 +26,22 @@
 /**
  * DOC: cma helpers
  *
- * The Contiguous Memory Allocator reserves a pool of memory at early boot
- * that is used to service requests for large blocks of contiguous memory.
+ * The DRM GEM/CMA helpers are a means to provide buffer objects that are
+ * presented to the device as a contiguous chunk of memory. This is useful
+ * for devices that do not support scatter-gather DMA (either directly or
+ * by using an intimately attached IOMMU).
  *
- * The DRM GEM/CMA helpers use this allocator as a means to provide buffer
- * objects that are physically contiguous in memory. This is useful for
- * display drivers that are unable to map scattered buffers via an IOMMU.
+ * Despite the name, the DRM GEM/CMA helpers are not hardwired to use the
+ * Contiguous Memory Allocator (CMA).
+ *
+ * For devices that access the memory bus through an (external) IOMMU then
+ * the buffer objects are allocated using a traditional page-based
+ * allocator and may be scattered through physical memory. However they
+ * are contiguous in the IOVA space so appear contiguous to devices using
+ * them.
+ *
+ * For other devices then the helpers rely on CMA to provide buffer
+ * objects that are physically contiguous in memory.
  *
  * For GEM callback helpers in struct &drm_gem_object functions, see likewise
  * named functions with an _object_ infix (e.g., drm_gem_cma_object_vmap() wraps
@@ -111,8 +121,14 @@ __drm_gem_cma_create(struct drm_device *drm, size_t size, bool private)
  * @drm: DRM device
  * @size: size of the object to allocate
  *
- * This function creates a CMA GEM object and allocates a contiguous chunk of
- * memory as backing store.
+ * This function creates a CMA GEM object and allocates memory as backing store.
+ * The allocated memory will occupy a contiguous chunk of bus address space.
+ *
+ * For devices that are directly connected to the memory bus then the allocated
+ * memory will be physically contiguous. For devices that access through an
+ * IOMMU, then the allocated memory is not expected to be physically contiguous
+ * because having contiguous IOVAs is sufficient to meet a devices DMA
+ * requirements.
  *
  * Returns:
  * A struct drm_gem_cma_object * on success or an ERR_PTR()-encoded negative
@@ -162,9 +178,12 @@ EXPORT_SYMBOL_GPL(drm_gem_cma_create);
  * @size: size of the object to allocate
  * @handle: return location for the GEM handle
  *
- * This function creates a CMA GEM object, allocating a physically contiguous
- * chunk of memory as backing store. The GEM object is then added to the list
- * of object associated with the given file and a handle to it is returned.
+ * This function creates a CMA GEM object, allocating a chunk of memory as
+ * backing store. The GEM object is then added to the list of object associated
+ * with the given file and a handle to it is returned.
+ *
+ * The allocated memory will occupy a contiguous chunk of bus address space.
+ * See drm_gem_cma_create() for more details.
  *
  * Returns:
  * A struct drm_gem_cma_object * on success or an ERR_PTR()-encoded negative

base-commit: 26291c54e111ff6ba87a164d85d4a4e134b7315c
--
2.34.1

