Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB1D48EC4C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 16:09:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242322AbiANPJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 10:09:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242257AbiANPIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 10:08:49 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7834C06173E
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 07:08:48 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id m3so17174810lfu.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 07:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BMWnTZVzVzGElJzU5xNhyaOzPG95n804pR9dUD0UpSM=;
        b=sVLNnZCk9v2uts1VfyjtyPuUOiD7rH1nXPNLXPa5/tQOdmj2DQU3+bQTWb+BAuFGlr
         VVC6BJP2Fe/uhcwCMCh0y4NxqXHs9uApS0Fqe/SeCl7wh9bF4COVPu9vsN55gSGCUEmF
         jIovWSaoItjipFLRJP1fzQ8HKS4f6ywI1oGO/0/9KtM5ZBlultFFJ5nUC73TIxulCUS1
         OPiAuFGLlaNavNsZViuRDNwnczbRedoFobsOCqa4LQ68XqoHrxVU1EjWAHZD7owNUuzR
         1qJmpt+/qV+BRfZ+GTN74Q3xhXBoqvL7NE+uvptIhOZrGQxckaaGegsGQAOSkHR3jIZs
         Hogg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BMWnTZVzVzGElJzU5xNhyaOzPG95n804pR9dUD0UpSM=;
        b=rTa516sGAAyDV/cbOuhuamUL41JJyT5XtJXwIikR7TT8HYGkjGTqx9KXcp2JnbZJhM
         ROkstZagy55YUVyqhIrZPUCXEoifU5x1aJFisnRgtGbjScr6/pvk1jaePAO+RbJ0mk7I
         qIMhs64r232GD1ayuHyVrdWEhMf2J3KCKNScCH+JJhavCO/Rt4cPKZeY5Xpw9i45S9wn
         4jux96ZtZA0ovyloKN1zMoN45kBbAAI+Bnj9OoNaXsMj0eI1LwpmwsM2zQvtbueMnaJi
         G3quqjsfDRgXWZJUOQcMpC3xAf5p8i5gJkQ9YXPTXRkfS2m5RLbvveAnrMWPg3IY38wJ
         gK6Q==
X-Gm-Message-State: AOAM533rZQggGWwtbbEEBmTgMMcT+sbVtMgFyCWmmUPqQPxU//eHKXo9
        nS1hv3uSw7lj6xRWRvv8xrodHBmaONNAwQ==
X-Google-Smtp-Source: ABdhPJzNNelaOvKCjbTz781HW+mCw6BOTdGWUPuqwyazCvQa+Y9odiI9bj86aLnmytCbAevWYtcKXg==
X-Received: by 2002:a05:651c:508:: with SMTP id o8mr6440057ljp.99.1642172926707;
        Fri, 14 Jan 2022 07:08:46 -0800 (PST)
Received: from jade.urgonet (h-94-254-48-165.A175.priv.bahnhof.se. [94.254.48.165])
        by smtp.gmail.com with ESMTPSA id i31sm40517lfv.67.2022.01.14.07.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 07:08:46 -0800 (PST)
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        Rijo Thomas <Rijo-john.Thomas@amd.com>,
        David Howells <dhowells@redhat.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v2 09/12] tee: add tee_shm_register_{user,kernel}_buf()
Date:   Fri, 14 Jan 2022 16:08:21 +0100
Message-Id: <20220114150824.3578829-10-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220114150824.3578829-1-jens.wiklander@linaro.org>
References: <20220114150824.3578829-1-jens.wiklander@linaro.org>
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

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/tee/tee_core.c  |  3 +--
 drivers/tee/tee_shm.c   | 34 ++++++++++++++++++++++++++++++++++
 include/linux/tee_drv.h |  4 ++++
 3 files changed, 39 insertions(+), 2 deletions(-)

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
 
diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
index d51bf97ce7e5..6a1dbce75616 100644
--- a/drivers/tee/tee_shm.c
+++ b/drivers/tee/tee_shm.c
@@ -301,6 +301,40 @@ struct tee_shm *tee_shm_register(struct tee_context *ctx, unsigned long addr,
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
+EXPORT_SYMBOL_GPL(tee_shm_register_user_buf);
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
index e71cb0411e9c..029c9a0590cc 100644
--- a/include/linux/tee_drv.h
+++ b/include/linux/tee_drv.h
@@ -289,6 +289,10 @@ struct tee_shm *tee_shm_alloc_kernel_buf(struct tee_context *ctx, size_t size);
  */
 struct tee_shm *tee_shm_register(struct tee_context *ctx, unsigned long addr,
 				 size_t length, u32 flags);
+struct tee_shm *tee_shm_register_user_buf(struct tee_context *ctx,
+					  unsigned long addr, size_t length);
+struct tee_shm *tee_shm_register_kernel_buf(struct tee_context *ctx,
+					    void *addr, size_t length);
 
 /**
  * tee_shm_is_registered() - Check if shared memory object in registered in TEE
-- 
2.31.1

