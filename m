Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0C974A96E6
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 10:34:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357770AbiBDJef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 04:34:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348314AbiBDJeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 04:34:19 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3612CC06173D
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 01:34:19 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id u14so11394814lfo.11
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 01:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=36Y39osWe7JWSD8/KyXS1kUOA5/n40+4mVVaerM2S7E=;
        b=zaLs+VFNkxv6Cdm2xEHZ9Aw5ajUqgSuHN2zAqjDi7hNA1y+dcn16jqP6ScynJb9XO2
         LwP256THC5lB30rzbNcUYC9ho2hIkJby2D7n3hc26FVxDsYw9SuyK6TdIZLznuTC+rkQ
         juWFQ/GLquvKtJ0XwY9fLGqRBkrgjCb0jKpShFLVgEcz+EoZSdChAUqs8d9kBF+emNUN
         B2FjkHrxsuGzVlsD8EEShzRPqTTf8x8+IS9eZMzVaRpKL1EA3xqg1cwlF7dsy1B0a62A
         4LzYkK2qdzQUUGXrB3rGBYXEwW6m9ODhwGHoC2jrHQw/U9qa5emvbZ4h6tglyGtjWtoV
         WQiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=36Y39osWe7JWSD8/KyXS1kUOA5/n40+4mVVaerM2S7E=;
        b=iLAQ/OjN5nxfPsD6IF8Pts0wQ4uRW2c6jgjz9JVs3lXptk+hcgJI8iAhiLTgeev0jD
         C+nwk7AWlvw0h5rsKh3ckmwseZT7B8+Yas+iiPxJJj215Q0qPgc9Zez4Nlg28okLlb+x
         XDHXc8WlpELtIh2sOjpg2hqkBI43GM+Y0WdnYvRHpPtkEIZq7Y7Reka1DmtNm0UcPvdE
         3GblaUWyz7q4N/k6JFmvwKwyPNwdN9v1otLdK2fXW8p/Yt4lM0i9Br8uIWc0u6z9T5a5
         H01xwl2/FcK7V7lOvTdj/JvltyQV/llWaBLkHMeeoV9NHxHkiec8T9Opu/fHUgCwJqQw
         kVug==
X-Gm-Message-State: AOAM533vAtL+jjNPKMSJhiSTzuWfSaeatqmDwHHxiJ68ex0jX5cg7AwY
        xmPSfYB4GyRDX6oHvJmZj286AWDIKkDFFA==
X-Google-Smtp-Source: ABdhPJyRMh0f+axqd/dZcvXOUop7vE5imy5AwTrFnL4fT4zqGChYfpSUPbGClesEtIdTK3eYS4+16A==
X-Received: by 2002:ac2:454d:: with SMTP id j13mr1800189lfm.248.1643967257258;
        Fri, 04 Feb 2022 01:34:17 -0800 (PST)
Received: from jade.urgonet (h-94-254-48-165.A175.priv.bahnhof.se. [94.254.48.165])
        by smtp.gmail.com with ESMTPSA id u28sm230550lfl.160.2022.02.04.01.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 01:34:16 -0800 (PST)
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        Rijo Thomas <Rijo-john.Thomas@amd.com>,
        David Howells <dhowells@redhat.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v4 07/10] tee: add tee_shm_register_{user,kernel}_buf()
Date:   Fri,  4 Feb 2022 10:33:56 +0100
Message-Id: <20220204093359.359059-8-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220204093359.359059-1-jens.wiklander@linaro.org>
References: <20220204093359.359059-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds the two new functions tee_shm_register_user_buf() and
tee_shm_register_kernel_buf() which should be used instead of the old
tee_shm_register().

This avoids having the caller supplying the flags parameter which
exposes a bit more than desired of the internals of the TEE subsystem.

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/tee/tee_core.c    |  3 +--
 drivers/tee/tee_private.h |  2 ++
 drivers/tee/tee_shm.c     | 33 +++++++++++++++++++++++++++++++++
 include/linux/tee_drv.h   |  2 ++
 4 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index a15812baaeb1..8aa1a4836b92 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -334,8 +334,7 @@ tee_ioctl_shm_register(struct tee_context *ctx,
 	if (data.flags)
 		return -EINVAL;
 
-	shm = tee_shm_register(ctx, data.addr, data.length,
-			       TEE_SHM_DMA_BUF | TEE_SHM_USER_MAPPED);
+	shm = tee_shm_register_user_buf(ctx, data.addr, data.length);
 	if (IS_ERR(shm))
 		return PTR_ERR(shm);
 
diff --git a/drivers/tee/tee_private.h b/drivers/tee/tee_private.h
index 7265f47c6d8e..409cadcc1cff 100644
--- a/drivers/tee/tee_private.h
+++ b/drivers/tee/tee_private.h
@@ -58,5 +58,7 @@ void teedev_ctx_get(struct tee_context *ctx);
 void teedev_ctx_put(struct tee_context *ctx);
 
 struct tee_shm *tee_shm_alloc_user_buf(struct tee_context *ctx, size_t size);
+struct tee_shm *tee_shm_register_user_buf(struct tee_context *ctx,
+					  unsigned long addr, size_t length);
 
 #endif /*TEE_PRIVATE_H*/
diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
index dd748d572691..359bab36e163 100644
--- a/drivers/tee/tee_shm.c
+++ b/drivers/tee/tee_shm.c
@@ -299,6 +299,39 @@ struct tee_shm *tee_shm_register(struct tee_context *ctx, unsigned long addr,
 }
 EXPORT_SYMBOL_GPL(tee_shm_register);
 
+/**
+ * tee_shm_register_user_buf() - Register a userspace shared memory buffer
+ * @ctx:	Context that registers the shared memory
+ * @addr:	The userspace address of the shared buffer
+ * @length:	Length of the shared buffer
+ *
+ * @returns a pointer to 'struct tee_shm'
+ */
+struct tee_shm *tee_shm_register_user_buf(struct tee_context *ctx,
+					  unsigned long addr, size_t length)
+{
+	return tee_shm_register(ctx, addr, length,
+				TEE_SHM_DMA_BUF | TEE_SHM_USER_MAPPED);
+}
+
+/**
+ * tee_shm_register_kernel_buf() - Register kernel memory to be shared with
+ *				   secure world
+ * @ctx:	Context that registers the shared memory
+ * @addr:	The buffer
+ * @length:	Length of the buffer
+ *
+ * @returns a pointer to 'struct tee_shm'
+ */
+
+struct tee_shm *tee_shm_register_kernel_buf(struct tee_context *ctx,
+					    void *addr, size_t length)
+{
+	return tee_shm_register(ctx, (unsigned long)addr, length,
+				TEE_SHM_DMA_BUF | TEE_SHM_KERNEL_MAPPED);
+}
+EXPORT_SYMBOL_GPL(tee_shm_register_kernel_buf);
+
 static int tee_shm_fop_release(struct inode *inode, struct file *filp)
 {
 	tee_shm_put(filp->private_data);
diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
index 7f038f8787c7..c9d2cc32a5ed 100644
--- a/include/linux/tee_drv.h
+++ b/include/linux/tee_drv.h
@@ -287,6 +287,8 @@ struct tee_shm *tee_shm_alloc_kernel_buf(struct tee_context *ctx, size_t size);
  */
 struct tee_shm *tee_shm_register(struct tee_context *ctx, unsigned long addr,
 				 size_t length, u32 flags);
+struct tee_shm *tee_shm_register_kernel_buf(struct tee_context *ctx,
+					    void *addr, size_t length);
 
 /**
  * tee_shm_is_registered() - Check if shared memory object in registered in TEE
-- 
2.31.1

