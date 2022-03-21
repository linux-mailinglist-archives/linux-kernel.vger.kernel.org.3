Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC20C4E33DA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 00:11:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbiCUXBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 19:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233516AbiCUW7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 18:59:14 -0400
X-Greylist: delayed 5588 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 21 Mar 2022 15:47:01 PDT
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A2432F2D1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 15:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=UxVnGroyv95bnhNLjHCmBweTO25U8rXxdLTQZ0CUFxg=; b=ChedVT+7B/T39CHBClrpYs3jZj
        N02A9+7/GjMG75Zejvyrnmt+eh8ZUAnETnSQyVcHFpJR0Zl9YcstIV8KbZW3SKXYQxDV1bLEBGnWk
        Kqe/YzykXnN3qAxcw/omDYjLyz2nK9wkeywm5weibie9iekj8UAYuRjtz4dGWLBhIdPmvWcBXpvFq
        Lw3CYuojEmkXWxqw3/OZ9fd7xLzZvGMv1eZgUcFyhkgM1YsUbUQnYyKeXfQUCwCXvx99BYnOQpDhH
        t8jWasPtSTgxEy+vI+HD73N/mmyDT/UHDDFcb/gVPU3fhiT8ArrsI8v7IuwA+iep+3+QM0bd+Fvks
        hKJKoLCQ==;
Received: from [165.90.126.25] (helo=killbill.home)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1nWPLi-0000ww-Co; Mon, 21 Mar 2022 22:13:58 +0100
From:   Melissa Wen <mwen@igalia.com>
To:     emma@anholt.net, airlied@linux.ie, daniel@ffwll.ch
Cc:     Rob Herring <robh@kernel.org>, Melissa Wen <mwen@igalia.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] drm/v3d: replace obj lookup steps with drm_gem_objects_lookup
Date:   Mon, 21 Mar 2022 20:13:16 -0100
Message-Id: <20220321211316.1423294-3-mwen@igalia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220321211316.1423294-1-mwen@igalia.com>
References: <20220321211316.1423294-1-mwen@igalia.com>
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

As v3d_lookup_bos() performs the same steps as drm_gem_objects_lookup(),
replace the explicit code in v3d to simply use the DRM function.

Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 drivers/gpu/drm/v3d/v3d_gem.c | 49 +++--------------------------------
 1 file changed, 3 insertions(+), 46 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_gem.c b/drivers/gpu/drm/v3d/v3d_gem.c
index 926bfc7e07fb..738b1080143d 100644
--- a/drivers/gpu/drm/v3d/v3d_gem.c
+++ b/drivers/gpu/drm/v3d/v3d_gem.c
@@ -294,10 +294,6 @@ v3d_lookup_bos(struct drm_device *dev,
 	       u64 bo_handles,
 	       u32 bo_count)
 {
-	u32 *handles;
-	int ret = 0;
-	int i;
-
 	job->bo_count = bo_count;
 
 	if (!job->bo_count) {
@@ -308,48 +304,9 @@ v3d_lookup_bos(struct drm_device *dev,
 		return -EINVAL;
 	}
 
-	job->bo = kvmalloc_array(job->bo_count,
-				 sizeof(struct drm_gem_cma_object *),
-				 GFP_KERNEL | __GFP_ZERO);
-	if (!job->bo) {
-		DRM_DEBUG("Failed to allocate validated BO pointers\n");
-		return -ENOMEM;
-	}
-
-	handles = kvmalloc_array(job->bo_count, sizeof(u32), GFP_KERNEL);
-	if (!handles) {
-		ret = -ENOMEM;
-		DRM_DEBUG("Failed to allocate incoming GEM handles\n");
-		goto fail;
-	}
-
-	if (copy_from_user(handles,
-			   (void __user *)(uintptr_t)bo_handles,
-			   job->bo_count * sizeof(u32))) {
-		ret = -EFAULT;
-		DRM_DEBUG("Failed to copy in GEM handles\n");
-		goto fail;
-	}
-
-	spin_lock(&file_priv->table_lock);
-	for (i = 0; i < job->bo_count; i++) {
-		struct drm_gem_object *bo = idr_find(&file_priv->object_idr,
-						     handles[i]);
-		if (!bo) {
-			DRM_DEBUG("Failed to look up GEM BO %d: %d\n",
-				  i, handles[i]);
-			ret = -ENOENT;
-			spin_unlock(&file_priv->table_lock);
-			goto fail;
-		}
-		drm_gem_object_get(bo);
-		job->bo[i] = bo;
-	}
-	spin_unlock(&file_priv->table_lock);
-
-fail:
-	kvfree(handles);
-	return ret;
+	return drm_gem_objects_lookup(file_priv,
+				      (void __user *)(uintptr_t)bo_handles,
+				      job->bo_count, &job->bo);
 }
 
 static void
-- 
2.35.1

