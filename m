Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5861349B8CE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 17:35:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1583834AbiAYQed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 11:34:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381252AbiAYQ36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 11:29:58 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2393BC06173D
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 08:29:57 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id a28so27704022lfl.7
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 08:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DUf2IpmTkIYobRbe8lkHT4fFtqU+2fZBqENflNdIXV0=;
        b=q3dCQjJA3SRbqyvHCl0hOJ8dIF5iZ7sfdpA2NboC+O34lRz+eweMQBBgv/aTZDrkWW
         IKbDKwx6LuE8lf3qjXa059gegqgavzhtRy67CeNOxJq63IRKuBqMVZskDNgUJVgxlteE
         CKLkH6Uoyt4LinAYcmDIJVgbsWZ7iLoQfH3ws00vYnatoqPvV5kPp5x4dDTw0xJR/FHV
         HHzvKvUE6+Onmyhm68dCCSFox75w9tEy/UqkNSSvrQnKCRFiwa6lhyN+f0DIzQ2Wau89
         cXPZ/cPwTa2eHOrLzt+9XUr4nRXLZQFb1xXX04i9wWz4z4Xm1VZV+Aqi2hjMmExtdgT0
         /gwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DUf2IpmTkIYobRbe8lkHT4fFtqU+2fZBqENflNdIXV0=;
        b=IvVp7rRgivrTRP8bd5x0QKZfKpcK9bbse7K/roVbwbzfAyht/5SrQem8NRn9koIfhl
         6b2TpWVk9mgXpKOtG0KDMP/htmARHPQ5mBGtvrsvY+/C0CDaGrpu0g4z61voUJwGSHwx
         kMsdVgIjjcxhlBjPG9DFID1Ps8+Fzfnh5Ypmiu+s3+hfjDzfXmPCQXgwxMxmkyAFGl0d
         GV0tExk575ygtrBYdUd6Bn51kfMRfLPL4sMUxxreH0KXtCSfvL+uJ1YXcT12dqGrCrIA
         sfFKemTeA72X95sNHY5oT5ckZ8dTI6aOnxVU+TqF1uTE4hpOK0PaC62UrQ6sj8EEX9s5
         j22g==
X-Gm-Message-State: AOAM5317lc+BqkLaIA+GqEPuZKBSDOXDVXLjIDjnyYo7UchBj6K9oVZG
        1flWhulYs+xZgPyXOVWFqvVoGiEjDy+A4g==
X-Google-Smtp-Source: ABdhPJz35bNItxbTfmE9wTvr/YBESFvDxWlOmcSF4xWJqkDfHvuVt8RUehvchZsp0XK67PKKZLGsBA==
X-Received: by 2002:a05:6512:3d21:: with SMTP id d33mr4917580lfv.125.1643128195232;
        Tue, 25 Jan 2022 08:29:55 -0800 (PST)
Received: from jade.urgonet (h-94-254-48-165.A175.priv.bahnhof.se. [94.254.48.165])
        by smtp.gmail.com with ESMTPSA id d13sm536240lfq.75.2022.01.25.08.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 08:29:54 -0800 (PST)
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        Rijo Thomas <Rijo-john.Thomas@amd.com>,
        David Howells <dhowells@redhat.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v3 09/12] tee: add tee_shm_register_{user,kernel}_buf()
Date:   Tue, 25 Jan 2022 17:29:35 +0100
Message-Id: <20220125162938.838382-10-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220125162938.838382-1-jens.wiklander@linaro.org>
References: <20220125162938.838382-1-jens.wiklander@linaro.org>
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
index dc02afd7b5c9..0b6f7aabbf88 100644
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

