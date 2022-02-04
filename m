Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E13454A96E8
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 10:34:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358026AbiBDJes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 04:34:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347693AbiBDJeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 04:34:22 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1BAAC061749
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 01:34:22 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id bu18so11484509lfb.5
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 01:34:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5yxwOzLChV0nlm4fspnb3kRsF537bDz0hCyoL1WhejM=;
        b=LLeppM51aXShBamlgRBIU6V6i4xBhv8p9AW/Axk2xpKaEoBZYXg97YkqTx0juvDiGD
         gP7j0iJ6h16gGVuLXhYQPfC1fTPObxfYliebQUG+uxqqsJ+rhCMGRMBK29o5wOhZZqxS
         sZoO0XJ3p40X/9anCo564C90es/nwYO32c9RfvPE3nCvqI+4h3bF9sgITN06Nb7X4Z0+
         XMoTNd9Ld085luzbMYtkGD2UAUeun9DVcxHgMTSZV36pGxaQiIwhWRduhFu7Sxe92YCe
         nm8BkGI7WlRYLwL5Efh35x2b74Ie0K9Tmprq+OE5GLOAZXiQQCTkdVGjm55picphqQCB
         tvMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5yxwOzLChV0nlm4fspnb3kRsF537bDz0hCyoL1WhejM=;
        b=FpimL5xaun+MOVLhFMO01s0C3tuuYHTfWtN4Twu3FA7Oett1Rt7BdCE50vcFL8hlYm
         mBGWMQ11MAPy3GD3Y1r58KyjAhNWQE6GQNtChNOj2//LVny1yBT3ekkytbNEFv7V7DZW
         +xUxhAKhSO4B35L5nYKugyxXdeNkYlKg8OEZkk5x7XRtvqO8tA19Xr+g6lJVNKiJzwKf
         JnCmjanCyZHW60I5OvqoorZvvfHy6/Cc7HYkgONlbBrwOVSoreTcYe68OQU1+/8gzANe
         nViwaeYt2yd/gcUxIJf8E+Fi4QbjfrJHGmtVSi9ovYhvwtKuFFoRsKT1VJ7w8KuCwfJx
         X3Jw==
X-Gm-Message-State: AOAM530kgS0IvabrN54fXqS7lUm4dCxgcMeJzg+JXk6u34hj1UnERzAx
        OQNE3Yum+MQ22MRI7U9YrZnZpNp0evC9xw==
X-Google-Smtp-Source: ABdhPJxbYt/ERKyQoTGpi/Y14rpMGaMhONsrRNgYsiPd5ZAK9vMo1582tbugBYGfIWGrD9nU0ZTirQ==
X-Received: by 2002:a05:6512:68e:: with SMTP id t14mr1784843lfe.366.1643967260703;
        Fri, 04 Feb 2022 01:34:20 -0800 (PST)
Received: from jade.urgonet (h-94-254-48-165.A175.priv.bahnhof.se. [94.254.48.165])
        by smtp.gmail.com with ESMTPSA id u28sm230550lfl.160.2022.02.04.01.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 01:34:20 -0800 (PST)
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        Rijo Thomas <Rijo-john.Thomas@amd.com>,
        David Howells <dhowells@redhat.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v4 10/10] tee: refactor TEE_SHM_* flags
Date:   Fri,  4 Feb 2022 10:33:59 +0100
Message-Id: <20220204093359.359059-11-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220204093359.359059-1-jens.wiklander@linaro.org>
References: <20220204093359.359059-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removes the redundant TEE_SHM_DMA_BUF, TEE_SHM_EXT_DMA_BUF,
TEE_SHM_MAPPED and TEE_SHM_KERNEL_MAPPED flags.

TEE_SHM_REGISTER is renamed to TEE_SHM_DYNAMIC in order to better
match its usage.

Assigns new values to the remaining flags to void gaps.

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/tee/optee/smc_abi.c |  4 ++--
 drivers/tee/tee_shm.c       | 23 +++++++++++------------
 drivers/tee/tee_shm_pool.c  |  2 +-
 include/linux/tee_drv.h     | 21 +++++++++------------
 4 files changed, 23 insertions(+), 27 deletions(-)

diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
index 0b68127a8afa..375a40eef36c 100644
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
index 9db571253802..f31e29e8f1ca 100644
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

