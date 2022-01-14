Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEDCB48EC4E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 16:09:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242388AbiANPJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 10:09:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242283AbiANPIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 10:08:51 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E7B6C061401
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 07:08:50 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id x7so31181523lfu.8
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 07:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lelFyeI0Hlo2H4BqExX4eucwovYbO0If2EaOhEho04Y=;
        b=KGJXd2rTnJV9pwu3LFrpOS8NehmSMDqgdieojdBxRQe1mr9Kb2SNGvNERwWj1eeqQZ
         aC25AU45U9r0+Ro46J2veHfDGglcQFUI9WpvhTJDLhoYJpeDcaxXeOyyPyk4oqHGo8Gp
         dcHadoTBMugq989z5vxos579grbLWRQX698NjZhi3kGnSN6AITs+GTjFl5gzVMuh4UCp
         TaVOgpIqYbeNZz7WYsxH68Ms0vw35AM1LLGKa8FPbNI6pYdwmktALbogU3iQ8Fdm3k7f
         t7SPhR+0JSfE4PjpoBmJIHkzlgRgyHNI3FBzI04YoY+f5fjz7IhGPBAb6H4CYyJpCNIg
         FfVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lelFyeI0Hlo2H4BqExX4eucwovYbO0If2EaOhEho04Y=;
        b=nyYdVZcvpiTJnkPDmXsBdg3kxQ0C2kdABCrnhtyBIG3p7xvUTzOfMqnaLtoygUYzZZ
         XKgUrrcB6HcdDelkEMr8+2/1sBjMVddzXnT8TJ8d6Nh5y8h+a+URSWRPnPd631LRZGPw
         hvhU01oWv8N7QALkFVO0oRytOebR7rZA8TfRNwFaTqMmPSQ8qkU5Ns8dTz6EcNv/i5cf
         oZGlASJINh4LRlyPBYMgflTBWW4ZVDQDyBCBlh8YzoYMYemFenS/xp+Qiwd9x4xkwXlZ
         ADsqLCj3vE/gqxNPLXdtEoeK5dwdXQvlzKZDZMe6oBCIo3ifsS4m5YtvdBLRU3dLsSUZ
         90Jg==
X-Gm-Message-State: AOAM531QL8l73YdWADV6d+NePEKbk/f7UgDfnCOTFqcS3zRtgC+L4ict
        GVo3jlNKQmD7p5BzcZHxOV75SPGFq3bAAQ==
X-Google-Smtp-Source: ABdhPJzI4YZc6yhE2VX4MiClgbiV8kuPD9/cbVO4HOElnZODOR2c3SEtrDHnVcegJ1R/0vzftrHsXw==
X-Received: by 2002:a2e:a7c7:: with SMTP id x7mr2350905ljp.226.1642172928579;
        Fri, 14 Jan 2022 07:08:48 -0800 (PST)
Received: from jade.urgonet (h-94-254-48-165.A175.priv.bahnhof.se. [94.254.48.165])
        by smtp.gmail.com with ESMTPSA id i31sm40517lfv.67.2022.01.14.07.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 07:08:48 -0800 (PST)
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        Rijo Thomas <Rijo-john.Thomas@amd.com>,
        David Howells <dhowells@redhat.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v2 11/12] tee: replace tee_shm_register()
Date:   Fri, 14 Jan 2022 16:08:23 +0100
Message-Id: <20220114150824.3578829-12-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220114150824.3578829-1-jens.wiklander@linaro.org>
References: <20220114150824.3578829-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tee_shm_register() is replaced by the previously introduced functions
tee_shm_register_user_buf() and tee_shm_register_kernel_buf().

Since there are not external callers left we can remove tee_shm_register()
and refactor the remains.

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/tee/tee_shm.c   | 157 +++++++++++++++++++++++-----------------
 include/linux/tee_drv.h |  11 ---
 2 files changed, 91 insertions(+), 77 deletions(-)

diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
index 6a1dbce75616..fe3e5977dd7c 100644
--- a/drivers/tee/tee_shm.c
+++ b/drivers/tee/tee_shm.c
@@ -12,17 +12,43 @@
 #include <linux/uio.h>
 #include "tee_private.h"
 
+static void shm_put_kernel_pages(struct page **pages, unsigned long npages)
+{
+	unsigned long n;
+
+	for (n = 0; n < npages; n++)
+		put_page(pages[n]);
+}
+
+static int shm_get_kernel_pages(unsigned long start, int page_count,
+				struct page **pages)
+{
+	struct kvec *kiov;
+	unsigned int n;
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
@@ -191,28 +217,24 @@ struct tee_shm *tee_shm_alloc_priv_kernel_buf(struct tee_context *ctx,
 }
 EXPORT_SYMBOL_GPL(tee_shm_alloc_priv_kernel_buf);
 
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
+	int num_pages;
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
@@ -220,13 +242,13 @@ struct tee_shm *tee_shm_register(struct tee_context *ctx, unsigned long addr,
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
@@ -235,71 +257,45 @@ struct tee_shm *tee_shm_register(struct tee_context *ctx, unsigned long addr,
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
@@ -312,8 +308,36 @@ EXPORT_SYMBOL_GPL(tee_shm_register);
 struct tee_shm *tee_shm_register_user_buf(struct tee_context *ctx,
 					  unsigned long addr, size_t length)
 {
-	return tee_shm_register(ctx, addr, length,
-				TEE_SHM_DMA_BUF | TEE_SHM_USER_MAPPED);
+	u32 f = TEE_SHM_DMA_BUF | TEE_SHM_USER_MAPPED | TEE_SHM_REGISTER;
+	struct tee_device *teedev = ctx->teedev;
+	struct tee_shm *shm;
+	void *ret;
+	int id;
+
+	mutex_lock(&teedev->mutex);
+	id = idr_alloc(&teedev->idr, NULL, 1, 0, GFP_KERNEL);
+	mutex_unlock(&teedev->mutex);
+
+	if (id < 0)
+		return ERR_PTR(id);
+
+	shm = register_shm_helper(ctx, addr, length, f, id);
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
 EXPORT_SYMBOL_GPL(tee_shm_register_user_buf);
 
@@ -330,8 +354,9 @@ EXPORT_SYMBOL_GPL(tee_shm_register_user_buf);
 struct tee_shm *tee_shm_register_kernel_buf(struct tee_context *ctx,
 					    void *addr, size_t length)
 {
-	return tee_shm_register(ctx, (unsigned long)addr, length,
-				TEE_SHM_DMA_BUF | TEE_SHM_KERNEL_MAPPED);
+	u32 f = TEE_SHM_REGISTER | TEE_SHM_KERNEL_MAPPED;
+
+	return register_shm_helper(ctx, (unsigned long)addr, length, f, -1);
 }
 EXPORT_SYMBOL_GPL(tee_shm_register_kernel_buf);
 
diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
index 029c9a0590cc..e4f32885e273 100644
--- a/include/linux/tee_drv.h
+++ b/include/linux/tee_drv.h
@@ -278,17 +278,6 @@ struct tee_shm *tee_shm_alloc_priv_kernel_buf(struct tee_context *ctx,
 					      size_t size);
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
 struct tee_shm *tee_shm_register_user_buf(struct tee_context *ctx,
 					  unsigned long addr, size_t length);
 struct tee_shm *tee_shm_register_kernel_buf(struct tee_context *ctx,
-- 
2.31.1

