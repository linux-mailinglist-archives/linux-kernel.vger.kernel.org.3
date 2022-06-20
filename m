Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7E3C55268C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 23:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245418AbiFTVeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 17:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243530AbiFTVeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 17:34:18 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414F0140B5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 14:34:16 -0700 (PDT)
Received: from hermes-devbox.fritz.box (82-71-8-225.dsl.in-addr.zen.co.uk [82.71.8.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbeckett)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8FB176601884;
        Mon, 20 Jun 2022 22:34:15 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655760855;
        bh=xMYv7v3aHxlEQIE2QtkE00E2gW9W0dS8yiKhilZWusw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iOs3K8NXIE5PaCPiFQ4sk9y3jL0Adk7wUf2ychc77x3HArHotdXZpwRfIMaBGVLx2
         hs0O9aRf2jccF5RVKykVGulMWE+igwlsM+2xr2L85eCCpfQCR2kQS9f6yvHwcO/pkB
         MUVrdEPPqHtMJEoJOdmuDxjMkQyddcCuPlBz9XWTX8IGcbfgzlx5iSInhBu/Q+lIcm
         dHe6o0YspZfXz5dcFrV7HNKkI7hSqKfJitiP7aWEmmqvGyVyLjXTOMZeOklMEiBPWm
         3FV/b9c1KwHBb6BsoB8ypcnA8hM9j7dMQF/Y1XMjEiwk7WTWGPp5dVmlBXWqr474WK
         c9vwBQBO2gM8g==
From:   Robert Beckett <bob.beckett@collabora.com>
To:     dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     kernel@collabora.com, Robert Beckett <bob.beckett@collabora.com>,
        Matthew Auld <matthew.auld@intel.com>,
        =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= 
        <thomas.hellstrom@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v7 08/10] drm/i915: allow memory region creators to alloc and free the region
Date:   Mon, 20 Jun 2022 21:33:38 +0000
Message-Id: <20220620213340.3199605-9-bob.beckett@collabora.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220620213340.3199605-1-bob.beckett@collabora.com>
References: <20220620213340.3199605-1-bob.beckett@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add callbacks for alloc and free.
this allows region creators to allocate any extra storage they may
require.

Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
---
 drivers/gpu/drm/i915/intel_memory_region.c | 16 +++++++++++++---
 drivers/gpu/drm/i915/intel_memory_region.h |  2 ++
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/intel_memory_region.c b/drivers/gpu/drm/i915/intel_memory_region.c
index e38d2db1c3e3..3da07a712f90 100644
--- a/drivers/gpu/drm/i915/intel_memory_region.c
+++ b/drivers/gpu/drm/i915/intel_memory_region.c
@@ -231,7 +231,10 @@ intel_memory_region_create(struct drm_i915_private *i915,
 	struct intel_memory_region *mem;
 	int err;
 
-	mem = kzalloc(sizeof(*mem), GFP_KERNEL);
+	if (ops->alloc)
+		mem = ops->alloc();
+	else
+		mem = kzalloc(sizeof(*mem), GFP_KERNEL);
 	if (!mem)
 		return ERR_PTR(-ENOMEM);
 
@@ -265,7 +268,10 @@ intel_memory_region_create(struct drm_i915_private *i915,
 	if (mem->ops->release)
 		mem->ops->release(mem);
 err_free:
-	kfree(mem);
+	if (mem->ops->free)
+		mem->ops->free(mem);
+	else
+		kfree(mem);
 	return ERR_PTR(err);
 }
 
@@ -288,7 +294,11 @@ void intel_memory_region_destroy(struct intel_memory_region *mem)
 
 	GEM_WARN_ON(!list_empty_careful(&mem->objects.list));
 	mutex_destroy(&mem->objects.lock);
-	if (!ret)
+	if (ret)
+		return;
+	if (mem->ops->free)
+		mem->ops->free(mem);
+	else
 		kfree(mem);
 }
 
diff --git a/drivers/gpu/drm/i915/intel_memory_region.h b/drivers/gpu/drm/i915/intel_memory_region.h
index 3d8378c1b447..048955b5429f 100644
--- a/drivers/gpu/drm/i915/intel_memory_region.h
+++ b/drivers/gpu/drm/i915/intel_memory_region.h
@@ -61,6 +61,8 @@ struct intel_memory_region_ops {
 			   resource_size_t size,
 			   resource_size_t page_size,
 			   unsigned int flags);
+	struct intel_memory_region *(*alloc)(void);
+	void (*free)(struct intel_memory_region *mem);
 };
 
 struct intel_memory_region {
-- 
2.25.1

