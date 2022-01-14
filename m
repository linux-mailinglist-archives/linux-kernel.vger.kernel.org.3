Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14E3848EC4F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 16:09:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242516AbiANPJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 10:09:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242324AbiANPIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 10:08:55 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55955C061746
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 07:08:51 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id m1so31238369lfq.4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 07:08:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jG7fiUopbaHgZ4zj3qqzJPw9k1rMqqi/8umZ0a4bcus=;
        b=Bx/dXl81N+nUo+4hKLcHeqRngJUkB4fbLg3IsDpv8Ejnz7N51sfmwNw9exuiBbujxg
         YeKjzVx1u5szAXKTRBla385ndiqGBMJQoNxXb2DBpDbKwE996tf68MevqujOfyXBPN0i
         AJpyLZkUHX7k2FRURoJ1X08CCZdiegZ6diTHWLtyvzF9g99Xw/uD/Ks1BA1JQ5Fl0Sf+
         NJ1A4YSpekrTPuk2v+WEblQocc/2mNckPP7SmegMK0MX8rRdxgEv4H//EOHw7zUHS3+8
         8mhTZFSywtnGrF7IVu9BW3h5Nntsvd/A8045o+EoS2x9b22+/N6e6dN7ryzHlxRnOu47
         qlpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jG7fiUopbaHgZ4zj3qqzJPw9k1rMqqi/8umZ0a4bcus=;
        b=hK2kNMEee0jKrGGQAfo+NVt9lfGcBWj384Q1hHM9OW7PJQ6DX3KuC2OAojXkCgN5hV
         91VUPNJZV/P1SZYzoEAkiLDofXDnLfz8ZZhrG2bC/dRyiwYiJ8sl9Fx5BsnsRKIBKTpf
         Ka/kLgAstEOL6hVIG5zTuRIzE90AkvbKOxcfzi0N6/wU/ApxA6fp902Tyd7Wv3oPGl5b
         jGq/JlCqcluNGV4DYpZlPdzo+eg/qBA4lCJWJGQ6F84+2EyOe6cEYAawdeij9efXK61Y
         jBBgFNxtH/K87H+EsQPDPP0+344SvP4WLFXoYLqayLo01sOJWdLSZQtbFmLg5P2+oQaD
         ipWQ==
X-Gm-Message-State: AOAM533D2g+iQQvIBlksAzp9aiNvfkY/xtgpUWFdT9RXaNt5RsCtoRYm
        Idsi/7quFr7yml57Hx5WiWM1+1lVhdbIRQ==
X-Google-Smtp-Source: ABdhPJwfecM8rUPFbZSZvfIz1Ske84Jrf1qOUStfkI1v1rmSNKgiij5SkbAy7cbpKbfAU+r3WU36NQ==
X-Received: by 2002:a05:6512:b15:: with SMTP id w21mr7180451lfu.11.1642172929432;
        Fri, 14 Jan 2022 07:08:49 -0800 (PST)
Received: from jade.urgonet (h-94-254-48-165.A175.priv.bahnhof.se. [94.254.48.165])
        by smtp.gmail.com with ESMTPSA id i31sm40517lfv.67.2022.01.14.07.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 07:08:49 -0800 (PST)
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        Rijo Thomas <Rijo-john.Thomas@amd.com>,
        David Howells <dhowells@redhat.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v2 12/12] tee: refactor TEE_SHM_* flags
Date:   Fri, 14 Jan 2022 16:08:24 +0100
Message-Id: <20220114150824.3578829-13-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220114150824.3578829-1-jens.wiklander@linaro.org>
References: <20220114150824.3578829-1-jens.wiklander@linaro.org>
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
 drivers/tee/tee_shm.c   | 21 ++++++++++-----------
 include/linux/tee_drv.h | 12 ++++--------
 2 files changed, 14 insertions(+), 19 deletions(-)

diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
index fe3e5977dd7c..9945bdec086b 100644
--- a/drivers/tee/tee_shm.c
+++ b/drivers/tee/tee_shm.c
@@ -139,8 +139,7 @@ static struct tee_shm *shm_alloc_helper(struct tee_context *ctx, size_t size,
  */
 struct tee_shm *tee_shm_alloc_user_buf(struct tee_context *ctx, size_t size)
 {
-	u32 flags = TEE_SHM_MAPPED | TEE_SHM_DMA_BUF | TEE_SHM_REGISTER |
-		    TEE_SHM_POOL;
+	u32 flags = TEE_SHM_REGISTER | TEE_SHM_POOL;
 	struct tee_device *teedev = ctx->teedev;
 	struct tee_shm *shm;
 	void *ret;
@@ -186,7 +185,7 @@ EXPORT_SYMBOL_GPL(tee_shm_alloc_user_buf);
  */
 struct tee_shm *tee_shm_alloc_kernel_buf(struct tee_context *ctx, size_t size)
 {
-	u32 flags = TEE_SHM_MAPPED | TEE_SHM_REGISTER | TEE_SHM_POOL;
+	u32 flags = TEE_SHM_REGISTER | TEE_SHM_POOL;
 
 	return shm_alloc_helper(ctx, size, PAGE_SIZE, flags, -1);
 }
@@ -211,7 +210,7 @@ EXPORT_SYMBOL_GPL(tee_shm_alloc_kernel_buf);
 struct tee_shm *tee_shm_alloc_priv_kernel_buf(struct tee_context *ctx,
 					      size_t size)
 {
-	u32 flags = TEE_SHM_MAPPED | TEE_SHM_PRIV | TEE_SHM_POOL;
+	u32 flags = TEE_SHM_PRIV | TEE_SHM_POOL;
 
 	return shm_alloc_helper(ctx, size, sizeof(long) * 2, flags, -1);
 }
@@ -308,7 +307,7 @@ register_shm_helper(struct tee_context *ctx, unsigned long addr,
 struct tee_shm *tee_shm_register_user_buf(struct tee_context *ctx,
 					  unsigned long addr, size_t length)
 {
-	u32 f = TEE_SHM_DMA_BUF | TEE_SHM_USER_MAPPED | TEE_SHM_REGISTER;
+	u32 f = TEE_SHM_USER_MAPPED | TEE_SHM_REGISTER;
 	struct tee_device *teedev = ctx->teedev;
 	struct tee_shm *shm;
 	void *ret;
@@ -354,7 +353,7 @@ EXPORT_SYMBOL_GPL(tee_shm_register_user_buf);
 struct tee_shm *tee_shm_register_kernel_buf(struct tee_context *ctx,
 					    void *addr, size_t length)
 {
-	u32 f = TEE_SHM_REGISTER | TEE_SHM_KERNEL_MAPPED;
+	u32 f = TEE_SHM_REGISTER;
 
 	return register_shm_helper(ctx, (unsigned long)addr, length, f, -1);
 }
@@ -398,7 +397,7 @@ int tee_shm_get_fd(struct tee_shm *shm)
 {
 	int fd;
 
-	if (!(shm->flags & TEE_SHM_DMA_BUF))
+	if (shm->id < 0)
 		return -EINVAL;
 
 	/* matched by tee_shm_put() in tee_shm_op_release() */
@@ -428,7 +427,7 @@ EXPORT_SYMBOL_GPL(tee_shm_free);
  */
 int tee_shm_va2pa(struct tee_shm *shm, void *va, phys_addr_t *pa)
 {
-	if (!(shm->flags & TEE_SHM_MAPPED))
+	if (!shm->kaddr)
 		return -EINVAL;
 	/* Check that we're in the range of the shm */
 	if ((char *)va < (char *)shm->kaddr)
@@ -450,7 +449,7 @@ EXPORT_SYMBOL_GPL(tee_shm_va2pa);
  */
 int tee_shm_pa2va(struct tee_shm *shm, phys_addr_t pa, void **va)
 {
-	if (!(shm->flags & TEE_SHM_MAPPED))
+	if (!shm->kaddr)
 		return -EINVAL;
 	/* Check that we're in the range of the shm */
 	if (pa < shm->paddr)
@@ -478,7 +477,7 @@ EXPORT_SYMBOL_GPL(tee_shm_pa2va);
  */
 void *tee_shm_get_va(struct tee_shm *shm, size_t offs)
 {
-	if (!(shm->flags & TEE_SHM_MAPPED))
+	if (!shm->kaddr)
 		return ERR_PTR(-EINVAL);
 	if (offs >= shm->size)
 		return ERR_PTR(-EINVAL);
@@ -553,7 +552,7 @@ void tee_shm_put(struct tee_shm *shm)
 		 * the refcount_inc() in tee_shm_get_from_id() never starts
 		 * from 0.
 		 */
-		if (shm->flags & TEE_SHM_DMA_BUF)
+		if (shm->id >= 0)
 			idr_remove(&teedev->idr, shm->id);
 		do_release = true;
 	}
diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
index e4f32885e273..dcc7a55e1128 100644
--- a/include/linux/tee_drv.h
+++ b/include/linux/tee_drv.h
@@ -20,14 +20,10 @@
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
+#define TEE_SHM_REGISTER	BIT(0)  /* Memory registered in secure world */
+#define TEE_SHM_USER_MAPPED	BIT(1)  /* Memory mapped in user space */
+#define TEE_SHM_POOL		BIT(2)  /* Memory allocated from pool */
+#define TEE_SHM_PRIV		BIT(3)  /* Memory private to TEE driver */
 
 struct device;
 struct tee_device;
-- 
2.31.1

