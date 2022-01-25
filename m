Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 538AF49B8D4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 17:36:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1583998AbiAYQfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 11:35:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385381AbiAYQaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 11:30:00 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65168C06173B
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 08:30:00 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id c15so11853082ljf.11
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 08:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R21QXj/bbTzapZcjCBdr87sf0YL59jDu7ua5W1yxSjY=;
        b=yW6in9A43ni7mBKos1HDPn6wKZPDEVGrPgxu02cQJB8l/e29GLF94mbjEfvClBBLf/
         OFb9VtKAHzqdIzO+0DU3qi+QFAHbm78KucAKyKIhpnRUYouqPQftifucTlBH3Rf5sztD
         4JWhdA/XwTH4qIP0ItlvHEuEVzNXJgdmGcF2Qw2igkbVK+EfDgmKeMVm0VFzPsoRqN+C
         fkyHjuze/uhhOt9u4z47fY9M3YZnW099lQ4+q8vB33119unuQ8/H/cCl96Sw7p8nCVTT
         19xoxHZ5yoEMaWUWNIXw31mKUKq8h29fUmhiXQVo2XmS/kB6iR8W1sgfD+S71AlsAUIt
         2cZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R21QXj/bbTzapZcjCBdr87sf0YL59jDu7ua5W1yxSjY=;
        b=RtyR4pWmoX3vKixOG8sD9ESGhcnWFp1VkVQfYVmuetSx9ppOioJZ3RGaH2KKP6udmR
         ayxFFhCHkTCZ1lDIrIyuK8xDj/pMP2um9fwCtaPra1Fx/IRmpIfK5y/RRSQDKl0+uNUk
         GuB5xWV2ZFj+OjTnYE4Oe4NztV0nI/eE5ikLXgdLsNuut3Ag21kAr5v3ZduS6wxn3mrs
         d7U6Sf+1y80XuhVeFJlwuBD4fp3O9kMTi7VnBYHkgs0RzWrYnxqWe4cA/bdp18Xl66A0
         F7FI+3vPZRT+BDXcpSv1s5sMne1GtZydtC4N+RikIfA+ln1OJSdT7xIW0wHevjkqHY7G
         20UA==
X-Gm-Message-State: AOAM530PE7TX9mQHWrnAJxLPR6rZ1wp0FuQuzgVJnCBEE2OS1HS99IMa
        nzr3uzdUFmnIRlUuJ616N7ZEPts8AoVteg==
X-Google-Smtp-Source: ABdhPJyooFTLCV3wLGc1thxTqWPp3B5tQV9G3Av0fe+H6DrG8YxKD+3D1ABv0IyrPYHnAdhXKPyLwA==
X-Received: by 2002:a2e:6e0b:: with SMTP id j11mr14423689ljc.3.1643128198444;
        Tue, 25 Jan 2022 08:29:58 -0800 (PST)
Received: from jade.urgonet (h-94-254-48-165.A175.priv.bahnhof.se. [94.254.48.165])
        by smtp.gmail.com with ESMTPSA id d13sm536240lfq.75.2022.01.25.08.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 08:29:58 -0800 (PST)
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        Rijo Thomas <Rijo-john.Thomas@amd.com>,
        David Howells <dhowells@redhat.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v3 12/12] tee: refactor TEE_SHM_* flags
Date:   Tue, 25 Jan 2022 17:29:38 +0100
Message-Id: <20220125162938.838382-13-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220125162938.838382-1-jens.wiklander@linaro.org>
References: <20220125162938.838382-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removes the redundant TEE_SHM_DMA_BUF, TEE_SHM_EXT_DMA_BUF,
TEE_SHM_MAPPED and TEE_SHM_KERNEL_MAPPED flags.

Assigns new values to the remaining flags to void gaps.

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/tee/optee/smc_abi.c |  4 ++--
 drivers/tee/tee_shm.c       | 23 +++++++++++------------
 drivers/tee/tee_shm_pool.c  |  2 +-
 include/linux/tee_drv.h     | 21 +++++++++------------
 4 files changed, 23 insertions(+), 27 deletions(-)

diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
index 9c1c9cfb7488..0895c5146dfa 100644
--- a/drivers/tee/optee/smc_abi.c
+++ b/drivers/tee/optee/smc_abi.c
@@ -228,7 +228,7 @@ static int optee_to_msg_param(struct optee *optee,
 		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT:
 		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT:
 		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT:
-			if (tee_shm_is_registered(p->u.memref.shm))
+			if (tee_shm_is_dynamic(p->u.memref.shm))
 				rc = to_msg_param_reg_mem(mp, p);
 			else
 				rc = to_msg_param_tmp_mem(mp, p);
@@ -669,7 +669,7 @@ static void handle_rpc_func_cmd_shm_alloc(struct tee_context *ctx,
 
 	sz = tee_shm_get_size(shm);
 
-	if (tee_shm_is_registered(shm)) {
+	if (tee_shm_is_dynamic(shm)) {
 		struct page **pages;
 		u64 *pages_list;
 		size_t page_num;
diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
index c3a29022ec72..d9deb1f50022 100644
--- a/drivers/tee/tee_shm.c
+++ b/drivers/tee/tee_shm.c
@@ -58,7 +58,7 @@ static void tee_shm_release(struct tee_device *teedev, struct tee_shm *shm)
 {
 	if (shm->flags & TEE_SHM_POOL) {
 		teedev->pool->ops->free(teedev->pool, shm);
-	} else if (shm->flags & TEE_SHM_REGISTER) {
+	} else if (shm->flags & TEE_SHM_DYNAMIC) {
 		int rc = teedev->desc->ops->shm_unregister(shm->ctx, shm);
 
 		if (rc)
@@ -139,8 +139,7 @@ static struct tee_shm *shm_alloc_helper(struct tee_context *ctx, size_t size,
  */
 struct tee_shm *tee_shm_alloc_user_buf(struct tee_context *ctx, size_t size)
 {
-	u32 flags = TEE_SHM_MAPPED | TEE_SHM_DMA_BUF | TEE_SHM_REGISTER |
-		    TEE_SHM_POOL;
+	u32 flags = TEE_SHM_DYNAMIC | TEE_SHM_POOL;
 	struct tee_device *teedev = ctx->teedev;
 	struct tee_shm *shm;
 	void *ret;
@@ -185,7 +184,7 @@ struct tee_shm *tee_shm_alloc_user_buf(struct tee_context *ctx, size_t size)
  */
 struct tee_shm *tee_shm_alloc_kernel_buf(struct tee_context *ctx, size_t size)
 {
-	u32 flags = TEE_SHM_MAPPED | TEE_SHM_REGISTER | TEE_SHM_POOL;
+	u32 flags = TEE_SHM_DYNAMIC | TEE_SHM_POOL;
 
 	return shm_alloc_helper(ctx, size, PAGE_SIZE, flags, -1);
 }
@@ -209,7 +208,7 @@ EXPORT_SYMBOL_GPL(tee_shm_alloc_kernel_buf);
  */
 struct tee_shm *tee_shm_alloc_priv_buf(struct tee_context *ctx, size_t size)
 {
-	u32 flags = TEE_SHM_MAPPED | TEE_SHM_PRIV | TEE_SHM_POOL;
+	u32 flags = TEE_SHM_PRIV | TEE_SHM_POOL;
 
 	return shm_alloc_helper(ctx, size, sizeof(long) * 2, flags, -1);
 }
@@ -306,7 +305,7 @@ register_shm_helper(struct tee_context *ctx, unsigned long addr,
 struct tee_shm *tee_shm_register_user_buf(struct tee_context *ctx,
 					  unsigned long addr, size_t length)
 {
-	u32 flags = TEE_SHM_DMA_BUF | TEE_SHM_USER_MAPPED | TEE_SHM_REGISTER;
+	u32 flags = TEE_SHM_USER_MAPPED | TEE_SHM_DYNAMIC;
 	struct tee_device *teedev = ctx->teedev;
 	struct tee_shm *shm;
 	void *ret;
@@ -350,7 +349,7 @@ struct tee_shm *tee_shm_register_user_buf(struct tee_context *ctx,
 struct tee_shm *tee_shm_register_kernel_buf(struct tee_context *ctx,
 					    void *addr, size_t length)
 {
-	u32 flags = TEE_SHM_REGISTER | TEE_SHM_KERNEL_MAPPED;
+	u32 flags = TEE_SHM_DYNAMIC;
 
 	return register_shm_helper(ctx, (unsigned long)addr, length, flags, -1);
 }
@@ -394,7 +393,7 @@ int tee_shm_get_fd(struct tee_shm *shm)
 {
 	int fd;
 
-	if (!(shm->flags & TEE_SHM_DMA_BUF))
+	if (shm->id < 0)
 		return -EINVAL;
 
 	/* matched by tee_shm_put() in tee_shm_op_release() */
@@ -424,7 +423,7 @@ EXPORT_SYMBOL_GPL(tee_shm_free);
  */
 int tee_shm_va2pa(struct tee_shm *shm, void *va, phys_addr_t *pa)
 {
-	if (!(shm->flags & TEE_SHM_MAPPED))
+	if (!shm->kaddr)
 		return -EINVAL;
 	/* Check that we're in the range of the shm */
 	if ((char *)va < (char *)shm->kaddr)
@@ -446,7 +445,7 @@ EXPORT_SYMBOL_GPL(tee_shm_va2pa);
  */
 int tee_shm_pa2va(struct tee_shm *shm, phys_addr_t pa, void **va)
 {
-	if (!(shm->flags & TEE_SHM_MAPPED))
+	if (!shm->kaddr)
 		return -EINVAL;
 	/* Check that we're in the range of the shm */
 	if (pa < shm->paddr)
@@ -474,7 +473,7 @@ EXPORT_SYMBOL_GPL(tee_shm_pa2va);
  */
 void *tee_shm_get_va(struct tee_shm *shm, size_t offs)
 {
-	if (!(shm->flags & TEE_SHM_MAPPED))
+	if (!shm->kaddr)
 		return ERR_PTR(-EINVAL);
 	if (offs >= shm->size)
 		return ERR_PTR(-EINVAL);
@@ -549,7 +548,7 @@ void tee_shm_put(struct tee_shm *shm)
 		 * the refcount_inc() in tee_shm_get_from_id() never starts
 		 * from 0.
 		 */
-		if (shm->flags & TEE_SHM_DMA_BUF)
+		if (shm->id >= 0)
 			idr_remove(&teedev->idr, shm->id);
 		do_release = true;
 	}
diff --git a/drivers/tee/tee_shm_pool.c b/drivers/tee/tee_shm_pool.c
index 71e0f8ae69aa..058bfbac657a 100644
--- a/drivers/tee/tee_shm_pool.c
+++ b/drivers/tee/tee_shm_pool.c
@@ -30,7 +30,7 @@ static int pool_op_gen_alloc(struct tee_shm_pool *pool, struct tee_shm *shm,
 	 * This is from a static shared memory pool so no need to register
 	 * each chunk, and no need to unregister later either.
 	 */
-	shm->flags &= ~TEE_SHM_REGISTER;
+	shm->flags &= ~TEE_SHM_DYNAMIC;
 	return 0;
 }
 
diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
index a3b663ef0694..911cad324acc 100644
--- a/include/linux/tee_drv.h
+++ b/include/linux/tee_drv.h
@@ -20,14 +20,11 @@
  * specific TEE driver.
  */
 
-#define TEE_SHM_MAPPED		BIT(0)	/* Memory mapped by the kernel */
-#define TEE_SHM_DMA_BUF		BIT(1)	/* Memory with dma-buf handle */
-#define TEE_SHM_EXT_DMA_BUF	BIT(2)	/* Memory with dma-buf handle */
-#define TEE_SHM_REGISTER	BIT(3)  /* Memory registered in secure world */
-#define TEE_SHM_USER_MAPPED	BIT(4)  /* Memory mapped in user space */
-#define TEE_SHM_POOL		BIT(5)  /* Memory allocated from pool */
-#define TEE_SHM_KERNEL_MAPPED	BIT(6)  /* Memory mapped in kernel space */
-#define TEE_SHM_PRIV		BIT(7)  /* Memory private to TEE driver */
+#define TEE_SHM_DYNAMIC		BIT(0)  /* Dynamic shared memory registered */
+					/* in secure world */
+#define TEE_SHM_USER_MAPPED	BIT(1)  /* Memory mapped in user space */
+#define TEE_SHM_POOL		BIT(2)  /* Memory allocated from pool */
+#define TEE_SHM_PRIV		BIT(3)  /* Memory private to TEE driver */
 
 struct device;
 struct tee_device;
@@ -280,13 +277,13 @@ struct tee_shm *tee_shm_register_kernel_buf(struct tee_context *ctx,
 					    void *addr, size_t length);
 
 /**
- * tee_shm_is_registered() - Check if shared memory object in registered in TEE
+ * tee_shm_is_dynamic() - Check if shared memory object is of the dynamic kind
  * @shm:	Shared memory handle
- * @returns true if object is registered in TEE
+ * @returns true if object is dynamic shared memory
  */
-static inline bool tee_shm_is_registered(struct tee_shm *shm)
+static inline bool tee_shm_is_dynamic(struct tee_shm *shm)
 {
-	return shm && (shm->flags & TEE_SHM_REGISTER);
+	return shm && (shm->flags & TEE_SHM_DYNAMIC);
 }
 
 /**
-- 
2.31.1

