Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0AD4A96E9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 10:34:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240075AbiBDJen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 04:34:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357273AbiBDJeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 04:34:22 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61AFEC061744
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 01:34:21 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id z19so11392446lfq.13
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 01:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zw4+qaaeyE/aWXMXtlVwIinAenGGPkkzb74yx3Vt6tc=;
        b=i6GPnvu2iaZlXdEVJFZqG0Y384fIX2eykdqvYElw2MNIj1ud9S/XRwlTZyeihI0cDn
         +V4SOaPIHbjEiitkdPvGqq5PkM8h+brsDurk4oi2bohpRwnb54zvyK8ZVaicnmy3+vgZ
         AOPxx8M7/XhKLCtkHUZ9ZnwC1y3yyvXr1e22leM00GzFM5Fpa2L8vIfxKdVMccku8KLp
         uyCprk07RM89yhuI1NWwWlji09Vro/ZYj/vHL2olCooad0AepVzJ9Vy7mjdSjKmoP0T4
         LWRPO6Adh7kvIEhinserVpfh/tH8ztAIKISSTWtvLj6hl0OmZxacywNMlmBMDgKLHzUf
         lOmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zw4+qaaeyE/aWXMXtlVwIinAenGGPkkzb74yx3Vt6tc=;
        b=kveF/4Y/umxrG3sD/3WLtfgdSZOXoGP/DxTCJzdKgDul9iZov1go/uS2/2+KpCp+A2
         YrM4fppFqJEK4X7BVUIkHEbdeO9OOYAXoBJqTrHsLU7AT7P2/NusH9p729ucx2llxF2q
         abWpegRDbcJhOa4Y6Fe3Y8bbQIzMhb2OAojpVUO/qq/6mf0WRQzTba3VhfYZt6/bfnSL
         +amzlSZAGvu3ijdrNR8UN7iToiktUcHhbBuJ/jirjd8uVjR3kmNF+u8zNz2vnYmqlvrB
         hVJmMg5GERRerB1+4d/+plIVjkNw0pko9GqrLwN6tuSfKStpTSG5lefNI6/JVGlR/rV9
         AKwg==
X-Gm-Message-State: AOAM5314R1M+MCzctlo8bUFK1Kf0rMDzm97NfduxyakdduLhtlSqjEEV
        cdCl+75AcKyAF4R46Q4R/u53FRcAi+uMmQ==
X-Google-Smtp-Source: ABdhPJxdKNvOzkwoCUaInqlGAuq8UlfyL1XDiisFZh0juQ76heOgAcvtm/6OqQDrEjDz+U32dCFAew==
X-Received: by 2002:a05:6512:ea1:: with SMTP id bi33mr1782955lfb.571.1643967259396;
        Fri, 04 Feb 2022 01:34:19 -0800 (PST)
Received: from jade.urgonet (h-94-254-48-165.A175.priv.bahnhof.se. [94.254.48.165])
        by smtp.gmail.com with ESMTPSA id u28sm230550lfl.160.2022.02.04.01.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 01:34:18 -0800 (PST)
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        Rijo Thomas <Rijo-john.Thomas@amd.com>,
        David Howells <dhowells@redhat.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v4 09/10] tee: replace tee_shm_register()
Date:   Fri,  4 Feb 2022 10:33:58 +0100
Message-Id: <20220204093359.359059-10-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220204093359.359059-1-jens.wiklander@linaro.org>
References: <20220204093359.359059-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tee_shm_register() is replaced by the previously introduced functions
tee_shm_register_user_buf() and tee_shm_register_kernel_buf().

Since there are not external callers left we can remove tee_shm_register()
and refactor the remains.

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/tee/tee_shm.c   | 156 +++++++++++++++++++++++-----------------
 include/linux/tee_drv.h |  11 ---
 2 files changed, 90 insertions(+), 77 deletions(-)

diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
index 359bab36e163..9db571253802 100644
--- a/drivers/tee/tee_shm.c
+++ b/drivers/tee/tee_shm.c
@@ -12,17 +12,43 @@
 #include <linux/uio.h>
 #include "tee_private.h"
 
+static void shm_put_kernel_pages(struct page **pages, size_t page_count)
+{
+	size_t n;
+
+	for (n = 0; n < page_count; n++)
+		put_page(pages[n]);
+}
+
+static int shm_get_kernel_pages(unsigned long start, size_t page_count,
+				struct page **pages)
+{
+	struct kvec *kiov;
+	size_t n;
+	int rc;
+
+	kiov = kcalloc(page_count, sizeof(*kiov), GFP_KERNEL);
+	if (!kiov)
+		return -ENOMEM;
+
+	for (n = 0; n < page_count; n++) {
+		kiov[n].iov_base = (void *)(start + n * PAGE_SIZE);
+		kiov[n].iov_len = PAGE_SIZE;
+	}
+
+	rc = get_kernel_pages(kiov, page_count, 0, pages);
+	kfree(kiov);
+
+	return rc;
+}
+
 static void release_registered_pages(struct tee_shm *shm)
 {
 	if (shm->pages) {
-		if (shm->flags & TEE_SHM_USER_MAPPED) {
+		if (shm->flags & TEE_SHM_USER_MAPPED)
 			unpin_user_pages(shm->pages, shm->num_pages);
-		} else {
-			size_t n;
-
-			for (n = 0; n < shm->num_pages; n++)
-				put_page(shm->pages[n]);
-		}
+		else
+			shm_put_kernel_pages(shm->pages, shm->num_pages);
 
 		kfree(shm->pages);
 	}
@@ -189,28 +215,24 @@ struct tee_shm *tee_shm_alloc_priv_buf(struct tee_context *ctx, size_t size)
 }
 EXPORT_SYMBOL_GPL(tee_shm_alloc_priv_buf);
 
-struct tee_shm *tee_shm_register(struct tee_context *ctx, unsigned long addr,
-				 size_t length, u32 flags)
+static struct tee_shm *
+register_shm_helper(struct tee_context *ctx, unsigned long addr,
+		    size_t length, u32 flags, int id)
 {
 	struct tee_device *teedev = ctx->teedev;
-	const u32 req_user_flags = TEE_SHM_DMA_BUF | TEE_SHM_USER_MAPPED;
-	const u32 req_kernel_flags = TEE_SHM_DMA_BUF | TEE_SHM_KERNEL_MAPPED;
 	struct tee_shm *shm;
+	unsigned long start;
+	size_t num_pages;
 	void *ret;
 	int rc;
-	int num_pages;
-	unsigned long start;
-
-	if (flags != req_user_flags && flags != req_kernel_flags)
-		return ERR_PTR(-ENOTSUPP);
 
 	if (!tee_device_get(teedev))
 		return ERR_PTR(-EINVAL);
 
 	if (!teedev->desc->ops->shm_register ||
 	    !teedev->desc->ops->shm_unregister) {
-		tee_device_put(teedev);
-		return ERR_PTR(-ENOTSUPP);
+		ret = ERR_PTR(-ENOTSUPP);
+		goto err_dev_put;
 	}
 
 	teedev_ctx_get(ctx);
@@ -218,13 +240,13 @@ struct tee_shm *tee_shm_register(struct tee_context *ctx, unsigned long addr,
 	shm = kzalloc(sizeof(*shm), GFP_KERNEL);
 	if (!shm) {
 		ret = ERR_PTR(-ENOMEM);
-		goto err;
+		goto err_ctx_put;
 	}
 
 	refcount_set(&shm->refcount, 1);
-	shm->flags = flags | TEE_SHM_REGISTER;
+	shm->flags = flags;
 	shm->ctx = ctx;
-	shm->id = -1;
+	shm->id = id;
 	addr = untagged_addr(addr);
 	start = rounddown(addr, PAGE_SIZE);
 	shm->offset = addr - start;
@@ -233,71 +255,45 @@ struct tee_shm *tee_shm_register(struct tee_context *ctx, unsigned long addr,
 	shm->pages = kcalloc(num_pages, sizeof(*shm->pages), GFP_KERNEL);
 	if (!shm->pages) {
 		ret = ERR_PTR(-ENOMEM);
-		goto err;
+		goto err_free_shm;
 	}
 
-	if (flags & TEE_SHM_USER_MAPPED) {
+	if (flags & TEE_SHM_USER_MAPPED)
 		rc = pin_user_pages_fast(start, num_pages, FOLL_WRITE,
 					 shm->pages);
-	} else {
-		struct kvec *kiov;
-		int i;
-
-		kiov = kcalloc(num_pages, sizeof(*kiov), GFP_KERNEL);
-		if (!kiov) {
-			ret = ERR_PTR(-ENOMEM);
-			goto err;
-		}
-
-		for (i = 0; i < num_pages; i++) {
-			kiov[i].iov_base = (void *)(start + i * PAGE_SIZE);
-			kiov[i].iov_len = PAGE_SIZE;
-		}
-
-		rc = get_kernel_pages(kiov, num_pages, 0, shm->pages);
-		kfree(kiov);
-	}
+	else
+		rc = shm_get_kernel_pages(start, num_pages, shm->pages);
 	if (rc > 0)
 		shm->num_pages = rc;
 	if (rc != num_pages) {
 		if (rc >= 0)
 			rc = -ENOMEM;
 		ret = ERR_PTR(rc);
-		goto err;
-	}
-
-	mutex_lock(&teedev->mutex);
-	shm->id = idr_alloc(&teedev->idr, shm, 1, 0, GFP_KERNEL);
-	mutex_unlock(&teedev->mutex);
-
-	if (shm->id < 0) {
-		ret = ERR_PTR(shm->id);
-		goto err;
+		goto err_put_shm_pages;
 	}
 
 	rc = teedev->desc->ops->shm_register(ctx, shm, shm->pages,
 					     shm->num_pages, start);
 	if (rc) {
 		ret = ERR_PTR(rc);
-		goto err;
+		goto err_put_shm_pages;
 	}
 
 	return shm;
-err:
-	if (shm) {
-		if (shm->id >= 0) {
-			mutex_lock(&teedev->mutex);
-			idr_remove(&teedev->idr, shm->id);
-			mutex_unlock(&teedev->mutex);
-		}
-		release_registered_pages(shm);
-	}
+err_put_shm_pages:
+	if (flags & TEE_SHM_USER_MAPPED)
+		unpin_user_pages(shm->pages, shm->num_pages);
+	else
+		shm_put_kernel_pages(shm->pages, shm->num_pages);
+	kfree(shm->pages);
+err_free_shm:
 	kfree(shm);
+err_ctx_put:
 	teedev_ctx_put(ctx);
+err_dev_put:
 	tee_device_put(teedev);
 	return ret;
 }
-EXPORT_SYMBOL_GPL(tee_shm_register);
 
 /**
  * tee_shm_register_user_buf() - Register a userspace shared memory buffer
@@ -310,8 +306,35 @@ EXPORT_SYMBOL_GPL(tee_shm_register);
 struct tee_shm *tee_shm_register_user_buf(struct tee_context *ctx,
 					  unsigned long addr, size_t length)
 {
-	return tee_shm_register(ctx, addr, length,
-				TEE_SHM_DMA_BUF | TEE_SHM_USER_MAPPED);
+	u32 flags = TEE_SHM_DMA_BUF | TEE_SHM_USER_MAPPED | TEE_SHM_REGISTER;
+	struct tee_device *teedev = ctx->teedev;
+	struct tee_shm *shm;
+	void *ret;
+	int id;
+
+	mutex_lock(&teedev->mutex);
+	id = idr_alloc(&teedev->idr, NULL, 1, 0, GFP_KERNEL);
+	mutex_unlock(&teedev->mutex);
+	if (id < 0)
+		return ERR_PTR(id);
+
+	shm = register_shm_helper(ctx, addr, length, flags, id);
+	if (IS_ERR(shm)) {
+		mutex_lock(&teedev->mutex);
+		idr_remove(&teedev->idr, id);
+		mutex_unlock(&teedev->mutex);
+		return shm;
+	}
+
+	mutex_lock(&teedev->mutex);
+	ret = idr_replace(&teedev->idr, shm, id);
+	mutex_unlock(&teedev->mutex);
+	if (IS_ERR(ret)) {
+		tee_shm_free(shm);
+		return ret;
+	}
+
+	return shm;
 }
 
 /**
@@ -327,8 +350,9 @@ struct tee_shm *tee_shm_register_user_buf(struct tee_context *ctx,
 struct tee_shm *tee_shm_register_kernel_buf(struct tee_context *ctx,
 					    void *addr, size_t length)
 {
-	return tee_shm_register(ctx, (unsigned long)addr, length,
-				TEE_SHM_DMA_BUF | TEE_SHM_KERNEL_MAPPED);
+	u32 flags = TEE_SHM_REGISTER | TEE_SHM_KERNEL_MAPPED;
+
+	return register_shm_helper(ctx, (unsigned long)addr, length, flags, -1);
 }
 EXPORT_SYMBOL_GPL(tee_shm_register_kernel_buf);
 
diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
index c9d2cc32a5ed..a3b663ef0694 100644
--- a/include/linux/tee_drv.h
+++ b/include/linux/tee_drv.h
@@ -276,17 +276,6 @@ void *tee_get_drvdata(struct tee_device *teedev);
 struct tee_shm *tee_shm_alloc_priv_buf(struct tee_context *ctx, size_t size);
 struct tee_shm *tee_shm_alloc_kernel_buf(struct tee_context *ctx, size_t size);
 
-/**
- * tee_shm_register() - Register shared memory buffer
- * @ctx:	Context that registers the shared memory
- * @addr:	Address is userspace of the shared buffer
- * @length:	Length of the shared buffer
- * @flags:	Flags setting properties for the requested shared memory.
- *
- * @returns a pointer to 'struct tee_shm'
- */
-struct tee_shm *tee_shm_register(struct tee_context *ctx, unsigned long addr,
-				 size_t length, u32 flags);
 struct tee_shm *tee_shm_register_kernel_buf(struct tee_context *ctx,
 					    void *addr, size_t length);
 
-- 
2.31.1

