Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 799CE511A97
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237265AbiD0OMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 10:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237151AbiD0OMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 10:12:35 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE1E4EDFF
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 07:09:23 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id v12so2656463wrv.10
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 07:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w6MIU62TYksZWfBnvqlAQQAOrtOE9xpl7EDu9WVwdGc=;
        b=DYYHPev7usMe37yDVn5rCV6Kxws3GlY7tSGUDtnzkUrf5nsvozh9CqCWA6fWWX2zM9
         pcLAZSxt5+XSccxZx4IjnUX9MbluDu5oA6HwMzvWm+P9IC1fbSuRrWF7I+HgV9WEkM4r
         mOjnzk+j5ymUmOcaKxCXMnM+uCCCK5AQgE1fEoomXLaklNIYvbQWFS1JW8Fy4oaeb2RD
         odZRk8INXz+Cd1vwGhba3F2tnNErpLnM7ERbGIX/NZiHCvOWQCXy7P9Z0E1WgC0vf4fJ
         M9xtHXq5r9N4orwL1WnCdSwZEbgxerg9sLRxHOP6m0yJ3RAxTvjDR3ylRZLSI/gOFmgp
         pkfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w6MIU62TYksZWfBnvqlAQQAOrtOE9xpl7EDu9WVwdGc=;
        b=aOxw+VN5jmN3KG9oku93QxYSQcJ+Yxp39QErgylsugVzD1G7J3x72soTpBr4SsW+IA
         He8L0kKn8YUw+/HDWMh6F23n2l5MP+2e8O+eS8mp57dfjzS934N92MG3thGRUJL00jeo
         /svZK3uDDOXJZ+d1ym4f6V66j2Dzhn/MomXrabv9+StgpsfVwmLWNpEF/ckgZFJo7pIC
         3fReiJ2tmj7VRuyd3mAY0nezWfR5NlfQtPhCda/9lae1iUQVegAg9JIU9XLosHdYpvG2
         pUiwls0jHa7Q9XvGTxQPi9A7drYb0el3Guv1AyuV4pfX4SV9+Q0HtlgLo7D8U/IrkTNx
         u1/Q==
X-Gm-Message-State: AOAM533cLtne7NI/u/shbenW9JEcj10ndmGaxM+QprMdiQOSzwpt6gK3
        XZ6Q6Rd2w2gV1XjPe1lOWP5UHw==
X-Google-Smtp-Source: ABdhPJx/N+hPRow/KIghfV1v359Zgeg0Nq19B5KVFxgMbSb7LhSDyBq95ktk1O7bDXKfdtLnWqMSUA==
X-Received: by 2002:a5d:54c4:0:b0:20a:d2ea:1f7f with SMTP id x4-20020a5d54c4000000b0020ad2ea1f7fmr17036040wrv.306.1651068561724;
        Wed, 27 Apr 2022 07:09:21 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id e30-20020adf9bde000000b0020ad8ffb0f9sm8723818wrc.69.2022.04.27.07.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 07:09:21 -0700 (PDT)
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v3] drm/cma-helper: Describe what a "contiguous chunk" actually means
Date:   Wed, 27 Apr 2022 15:09:10 +0100
Message-Id: <20220427140910.1735188-1-daniel.thompson@linaro.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
    RESEND is unaltered but rebased on v5.18-rc3.
    
    Changes in v3:
    - Rebased on v5.17-rc2
    - Minor improvements to wording.
    
    Changes in v2:
    - Oops. I did a final proof read and accidentally committed these
      changes as a seperate patch. This means that v1 contains only
      one tenth of the actual patch. This is fixed in v2. Many apologies
      for the noise!

 drivers/gpu/drm/drm_gem_cma_helper.c | 39 +++++++++++++++++++++-------
 1 file changed, 29 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_cma_helper.c b/drivers/gpu/drm/drm_gem_cma_helper.c
index f36734c2c9e1..42abee9a0f4f 100644
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

base-commit: b2d229d4ddb17db541098b83524d901257e93845
--
2.35.1

