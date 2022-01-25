Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00FE449B8FE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 17:50:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1583958AbiAYQfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 11:35:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384569AbiAYQ37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 11:29:59 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A06CC06173B
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 08:29:59 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id o12so14391146lfg.12
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 08:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r+/DJdCtq5HkZ1TSBJ7/l42hzle6ImDYuz3Z1vtHeBo=;
        b=K34Ctnvzpq6EEO5cL0iCMiBIscPMBi2F8QSycPvefvciNQq8UMh7MOgpg4hYGP3ik+
         PGOCXMUY3PxnwfwVO9cSgejMTHC1wTmZsDJyM9d9dUX908fAAvHv046topN8RDWw8Evo
         Rd9385pUnLIzrMHdwBTQLJyLelrnorR4L/a4IL3k1w4V5Rwv6/DKSoEBGWEZA0G0ewDD
         4p6LTNJwOfjbKRc85fBjtk9IwKPObDNStfuZO5nrlu4kDWt7miqv9raNMJ/2NBlJ0zu3
         ai4zSWdAiDwauVei46EN6Om/Yiqfhm18D/wDgJOaw8RE6A5pF5njOjzR4hGSe5DXa3F4
         yMCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r+/DJdCtq5HkZ1TSBJ7/l42hzle6ImDYuz3Z1vtHeBo=;
        b=fj9+k/uu5Q+WtLZC6EnEYKUCfu4vvPfRBGbqAAkOYaXUB50LKQyVnYLAVb1Bq7q0sW
         XvG0tX00RRvjxUHXa2jQHWhpp/dznJ7FiK4SqIGgeSwFd/KMD0YfOhUkkkTtJeHUDNjI
         /6AmdLcdhEwoy7cEG/x9FDax3OtzWYRXDmxuqrnHX/puko7S3uDSSREoV/nAJzcvrdLX
         LWEOmDwocDYh20C5p/KVVJZgjZChjHUNPuq77zgEgKuxEEbWtzu6SY1VNCFvgIbMSutH
         aTpdxddGwEhnvFmc/Zd+AmtONJuAlDuJ2hWPJvybtVJbw991bl62iVju+gzcZu0keab5
         mKFw==
X-Gm-Message-State: AOAM5328ldeOrpjboiC4Jg/HwHLsl+UyMoKQAFhRxX+4I8OvxRwWASwW
        fqXN41QH+L8sWM591v7nb1i2Akyqf9R3qw==
X-Google-Smtp-Source: ABdhPJyWvoZJkKZv2HkhUkqz9ADES6xlMLR5mNV/TcbvCsnUuCQqejopnEuecGcopr2kkDNqCXEYbw==
X-Received: by 2002:a05:6512:398c:: with SMTP id j12mr13460111lfu.578.1643128197408;
        Tue, 25 Jan 2022 08:29:57 -0800 (PST)
Received: from jade.urgonet (h-94-254-48-165.A175.priv.bahnhof.se. [94.254.48.165])
        by smtp.gmail.com with ESMTPSA id d13sm536240lfq.75.2022.01.25.08.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 08:29:56 -0800 (PST)
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        Rijo Thomas <Rijo-john.Thomas@amd.com>,
        David Howells <dhowells@redhat.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v3 11/12] tee: replace tee_shm_register()
Date:   Tue, 25 Jan 2022 17:29:37 +0100
Message-Id: <20220125162938.838382-12-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220125162938.838382-1-jens.wiklander@linaro.org>
References: <20220125162938.838382-1-jens.wiklander@linaro.org>
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
 drivers/tee/tee_shm.c   | 156 +++++++++++++++++++++++-----------------
 include/linux/tee_drv.h |  11 ---
 2 files changed, 90 insertions(+), 77 deletions(-)

diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
index 0b6f7aabbf88..c3a29022ec72 100644
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

