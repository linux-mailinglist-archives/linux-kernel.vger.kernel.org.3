Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45E464A96E3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 10:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354797AbiBDJe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 04:34:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345520AbiBDJeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 04:34:17 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08189C061401
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 01:34:17 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id u14so11394643lfo.11
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 01:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9bbBa8iaPsUWfadVcmuE6wOiniwihoElxDdQPBTkB5c=;
        b=SUNasxzjit459LHMbN7jyQO946qOJG/PYtlEzNO11M0cbGtPC7up6xhDWbmrA3JgVt
         UAMPmXjZ1wqNIoZbVpAgwCD8adzaboECDHrKAQPLCCsRyacodgCRXFN1B0LomUNitKUz
         aakDMa1Ip9DiXg+BlCS9zA6SjqPYmgX0tr7qqsI9bDl0HQpw6iFt+XrckzNSDR4FhU4l
         GQnTfrHEH21qwqdaqHY9M0WPUsNMXuDpj5QqN3q7HOaHkd81tMwLqXTt1AvJKwFvyqJS
         Pswkb9zfcQG4z/pyjAxJKgEQs20jF6VK3Nm/bxpU5krAUlvKa5/XAL7El7tjR5C77cH0
         wqKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9bbBa8iaPsUWfadVcmuE6wOiniwihoElxDdQPBTkB5c=;
        b=wKaVABmfiHG5QXR+SnGgAqUGtkEkwprn1ZCicOCbXX3uJ1V0HpoIZRZf2u4rQVChbi
         60isPXp8ec8IaZ3CDKYm7Hg9k1ZrHRpRADQSDXosscPlFklcAhcQ+2ZQjCT5fxXWEiX6
         R6dF5A7w9dUSNECqazd14J6XKOCKbrcEjZqntQaN/i7pJyF+hiulQnomelbIVFwmgf7e
         NXLOwz11yMw1e959IG1eeM9u4NZkrx1f2cIKasZxZYUHvhIqruZdZdVVYPs2P5JQiV55
         Zw/UvhXPH34ALQgARMell8Nbus35OaYp5UCBwhlH04l/RUOpLsFjhFQG9hGZ1Em82UKJ
         x+MA==
X-Gm-Message-State: AOAM531Nc9AGpJJQB41gEaAbmKjiGdUMB+dwhrgs5uHoMAMnLk8ceBdM
        leR6vaDnPHQNZk6kIVc2CuLzNC5TBlNgfA==
X-Google-Smtp-Source: ABdhPJwvvTc81qluJq7fa6yC9XS8zeU4+2MpI17UGSdZQanAD0bYPK5uT3L3aqY5mmvt4HAePmZxNA==
X-Received: by 2002:a05:6512:3184:: with SMTP id i4mr1703201lfe.293.1643967255000;
        Fri, 04 Feb 2022 01:34:15 -0800 (PST)
Received: from jade.urgonet (h-94-254-48-165.A175.priv.bahnhof.se. [94.254.48.165])
        by smtp.gmail.com with ESMTPSA id u28sm230550lfl.160.2022.02.04.01.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 01:34:14 -0800 (PST)
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        Rijo Thomas <Rijo-john.Thomas@amd.com>,
        David Howells <dhowells@redhat.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v4 05/10] tee: replace tee_shm_alloc()
Date:   Fri,  4 Feb 2022 10:33:54 +0100
Message-Id: <20220204093359.359059-6-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220204093359.359059-1-jens.wiklander@linaro.org>
References: <20220204093359.359059-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tee_shm_alloc() is replaced by three new functions,

tee_shm_alloc_user_buf() - for user mode allocations, replacing passing
the flags TEE_SHM_MAPPED | TEE_SHM_DMA_BUF

tee_shm_alloc_kernel_buf() - for kernel mode allocations, slightly
optimized compared to using the flags TEE_SHM_MAPPED | TEE_SHM_DMA_BUF.

tee_shm_alloc_priv_buf() - primarily for TEE driver internal use.

This also makes the interface easier to use as we can get rid of the
somewhat hard to use flags parameter.

The TEE subsystem and the TEE drivers are updated to use the new
functions instead.

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/tee/optee/call.c    |   2 +-
 drivers/tee/optee/device.c  |   5 +-
 drivers/tee/optee/ffa_abi.c |   4 +-
 drivers/tee/optee/smc_abi.c |   6 +-
 drivers/tee/tee_shm.c       | 108 +++++++++++++++++++++++-------------
 include/linux/tee_drv.h     |  16 +-----
 6 files changed, 76 insertions(+), 65 deletions(-)

diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
index b25cc1fac945..bd49ec934060 100644
--- a/drivers/tee/optee/call.c
+++ b/drivers/tee/optee/call.c
@@ -120,7 +120,7 @@ struct tee_shm *optee_get_msg_arg(struct tee_context *ctx, size_t num_params,
 	if (optee->rpc_arg_count)
 		sz += OPTEE_MSG_GET_ARG_SIZE(optee->rpc_arg_count);
 
-	shm = tee_shm_alloc(ctx, sz, TEE_SHM_MAPPED | TEE_SHM_PRIV);
+	shm = tee_shm_alloc_priv_buf(ctx, sz);
 	if (IS_ERR(shm))
 		return shm;
 
diff --git a/drivers/tee/optee/device.c b/drivers/tee/optee/device.c
index 128a2d2a50a1..f3947be13e2e 100644
--- a/drivers/tee/optee/device.c
+++ b/drivers/tee/optee/device.c
@@ -121,10 +121,9 @@ static int __optee_enumerate_devices(u32 func)
 	if (rc < 0 || !shm_size)
 		goto out_sess;
 
-	device_shm = tee_shm_alloc(ctx, shm_size,
-				   TEE_SHM_MAPPED | TEE_SHM_DMA_BUF);
+	device_shm = tee_shm_alloc_kernel_buf(ctx, shm_size);
 	if (IS_ERR(device_shm)) {
-		pr_err("tee_shm_alloc failed\n");
+		pr_err("tee_shm_alloc_kernel_buf failed\n");
 		rc = PTR_ERR(device_shm);
 		goto out_sess;
 	}
diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
index b9b898b124d3..bf85975c6e95 100644
--- a/drivers/tee/optee/ffa_abi.c
+++ b/drivers/tee/optee/ffa_abi.c
@@ -440,8 +440,8 @@ static void handle_ffa_rpc_func_cmd_shm_alloc(struct tee_context *ctx,
 		shm = optee_rpc_cmd_alloc_suppl(ctx, arg->params[0].u.value.b);
 		break;
 	case OPTEE_RPC_SHM_TYPE_KERNEL:
-		shm = tee_shm_alloc(optee->ctx, arg->params[0].u.value.b,
-				    TEE_SHM_MAPPED | TEE_SHM_PRIV);
+		shm = tee_shm_alloc_priv_buf(optee->ctx,
+					     arg->params[0].u.value.b);
 		break;
 	default:
 		arg->ret = TEEC_ERROR_BAD_PARAMETERS;
diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
index abb360fd5a5c..8198479d330e 100644
--- a/drivers/tee/optee/smc_abi.c
+++ b/drivers/tee/optee/smc_abi.c
@@ -651,8 +651,7 @@ static void handle_rpc_func_cmd_shm_alloc(struct tee_context *ctx,
 		shm = optee_rpc_cmd_alloc_suppl(ctx, sz);
 		break;
 	case OPTEE_RPC_SHM_TYPE_KERNEL:
-		shm = tee_shm_alloc(optee->ctx, sz,
-				    TEE_SHM_MAPPED | TEE_SHM_PRIV);
+		shm = tee_shm_alloc_priv_buf(optee->ctx, sz);
 		break;
 	default:
 		arg->ret = TEEC_ERROR_BAD_PARAMETERS;
@@ -777,8 +776,7 @@ static void optee_handle_rpc(struct tee_context *ctx,
 
 	switch (OPTEE_SMC_RETURN_GET_RPC_FUNC(param->a0)) {
 	case OPTEE_SMC_RPC_FUNC_ALLOC:
-		shm = tee_shm_alloc(optee->ctx, param->a1,
-				    TEE_SHM_MAPPED | TEE_SHM_PRIV);
+		shm = tee_shm_alloc_priv_buf(optee->ctx, param->a1);
 		if (!IS_ERR(shm) && !tee_shm_get_pa(shm, 0, &pa)) {
 			reg_pair_from_64(&param->a1, &param->a2, pa);
 			reg_pair_from_64(&param->a4, &param->a5,
diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
index f0a9cccd2f2c..dd748d572691 100644
--- a/drivers/tee/tee_shm.c
+++ b/drivers/tee/tee_shm.c
@@ -49,25 +49,14 @@ static void tee_shm_release(struct tee_device *teedev, struct tee_shm *shm)
 	tee_device_put(teedev);
 }
 
-struct tee_shm *tee_shm_alloc(struct tee_context *ctx, size_t size, u32 flags)
+static struct tee_shm *shm_alloc_helper(struct tee_context *ctx, size_t size,
+					size_t align, u32 flags, int id)
 {
 	struct tee_device *teedev = ctx->teedev;
 	struct tee_shm *shm;
-	size_t align;
 	void *ret;
 	int rc;
 
-	if (!(flags & TEE_SHM_MAPPED)) {
-		dev_err(teedev->dev.parent,
-			"only mapped allocations supported\n");
-		return ERR_PTR(-EINVAL);
-	}
-
-	if ((flags & ~(TEE_SHM_MAPPED | TEE_SHM_DMA_BUF | TEE_SHM_PRIV))) {
-		dev_err(teedev->dev.parent, "invalid shm flags 0x%x", flags);
-		return ERR_PTR(-EINVAL);
-	}
-
 	if (!tee_device_get(teedev))
 		return ERR_PTR(-EINVAL);
 
@@ -84,18 +73,16 @@ struct tee_shm *tee_shm_alloc(struct tee_context *ctx, size_t size, u32 flags)
 	}
 
 	refcount_set(&shm->refcount, 1);
-	shm->flags = flags | TEE_SHM_POOL;
+	shm->flags = flags;
+	shm->id = id;
+
+	/*
+	 * We're assigning this as it is needed if the shm is to be
+	 * registered. If this function returns OK then the caller expected
+	 * to call teedev_ctx_get() or clear shm->ctx in case it's not
+	 * needed any longer.
+	 */
 	shm->ctx = ctx;
-	if (flags & TEE_SHM_DMA_BUF) {
-		align = PAGE_SIZE;
-		/*
-		 * Request to register the shm in the pool allocator below
-		 * if supported.
-		 */
-		shm->flags |= TEE_SHM_REGISTER;
-	} else {
-		align = 2 * sizeof(long);
-	}
 
 	rc = teedev->pool->ops->alloc(teedev->pool, shm, size, align);
 	if (rc) {
@@ -103,28 +90,14 @@ struct tee_shm *tee_shm_alloc(struct tee_context *ctx, size_t size, u32 flags)
 		goto err_kfree;
 	}
 
-	if (flags & TEE_SHM_DMA_BUF) {
-		mutex_lock(&teedev->mutex);
-		shm->id = idr_alloc(&teedev->idr, shm, 1, 0, GFP_KERNEL);
-		mutex_unlock(&teedev->mutex);
-		if (shm->id < 0) {
-			ret = ERR_PTR(shm->id);
-			goto err_pool_free;
-		}
-	}
-
 	teedev_ctx_get(ctx);
-
 	return shm;
-err_pool_free:
-	teedev->pool->ops->free(teedev->pool, shm);
 err_kfree:
 	kfree(shm);
 err_dev_put:
 	tee_device_put(teedev);
 	return ret;
 }
-EXPORT_SYMBOL_GPL(tee_shm_alloc);
 
 /**
  * tee_shm_alloc_user_buf() - Allocate shared memory for user space
@@ -140,7 +113,36 @@ EXPORT_SYMBOL_GPL(tee_shm_alloc);
  */
 struct tee_shm *tee_shm_alloc_user_buf(struct tee_context *ctx, size_t size)
 {
-	return tee_shm_alloc(ctx, size, TEE_SHM_MAPPED | TEE_SHM_DMA_BUF);
+	u32 flags = TEE_SHM_MAPPED | TEE_SHM_DMA_BUF | TEE_SHM_REGISTER |
+		    TEE_SHM_POOL;
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
+	shm = shm_alloc_helper(ctx, size, PAGE_SIZE, flags, id);
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
@@ -157,10 +159,36 @@ struct tee_shm *tee_shm_alloc_user_buf(struct tee_context *ctx, size_t size)
  */
 struct tee_shm *tee_shm_alloc_kernel_buf(struct tee_context *ctx, size_t size)
 {
-	return tee_shm_alloc(ctx, size, TEE_SHM_MAPPED);
+	u32 flags = TEE_SHM_MAPPED | TEE_SHM_REGISTER | TEE_SHM_POOL;
+
+	return shm_alloc_helper(ctx, size, PAGE_SIZE, flags, -1);
 }
 EXPORT_SYMBOL_GPL(tee_shm_alloc_kernel_buf);
 
+/**
+ * tee_shm_alloc_priv_buf() - Allocate shared memory for a privately shared
+ *			      kernel buffer
+ * @ctx:	Context that allocates the shared memory
+ * @size:	Requested size of shared memory
+ *
+ * This function returns similar shared memory as
+ * tee_shm_alloc_kernel_buf(), but with the difference that the memory
+ * might not be registered in secure world in case the driver supports
+ * passing memory not registered in advance.
+ *
+ * This function should normally only be used internally in the TEE
+ * drivers.
+ *
+ * @returns a pointer to 'struct tee_shm'
+ */
+struct tee_shm *tee_shm_alloc_priv_buf(struct tee_context *ctx, size_t size)
+{
+	u32 flags = TEE_SHM_MAPPED | TEE_SHM_PRIV | TEE_SHM_POOL;
+
+	return shm_alloc_helper(ctx, size, sizeof(long) * 2, flags, -1);
+}
+EXPORT_SYMBOL_GPL(tee_shm_alloc_priv_buf);
+
 struct tee_shm *tee_shm_register(struct tee_context *ctx, unsigned long addr,
 				 size_t length, u32 flags)
 {
diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
index ed641dc314bd..7f038f8787c7 100644
--- a/include/linux/tee_drv.h
+++ b/include/linux/tee_drv.h
@@ -273,21 +273,7 @@ static inline void tee_shm_pool_free(struct tee_shm_pool *pool)
  */
 void *tee_get_drvdata(struct tee_device *teedev);
 
-/**
- * tee_shm_alloc() - Allocate shared memory
- * @ctx:	Context that allocates the shared memory
- * @size:	Requested size of shared memory
- * @flags:	Flags setting properties for the requested shared memory.
- *
- * Memory allocated as global shared memory is automatically freed when the
- * TEE file pointer is closed. The @flags field uses the bits defined by
- * TEE_SHM_* above. TEE_SHM_MAPPED must currently always be set. If
- * TEE_SHM_DMA_BUF global shared memory will be allocated and associated
- * with a dma-buf handle, else driver private memory.
- *
- * @returns a pointer to 'struct tee_shm'
- */
-struct tee_shm *tee_shm_alloc(struct tee_context *ctx, size_t size, u32 flags);
+struct tee_shm *tee_shm_alloc_priv_buf(struct tee_context *ctx, size_t size);
 struct tee_shm *tee_shm_alloc_kernel_buf(struct tee_context *ctx, size_t size);
 
 /**
-- 
2.31.1

