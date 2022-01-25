Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1E349B8C7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 17:35:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1583761AbiAYQdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 11:33:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380219AbiAYQ3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 11:29:50 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A4AFC06173B
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 08:29:50 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id bu18so57823376lfb.5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 08:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZLkFwdHW7tpL1lpDBNXdPL4T4si80CJ3ca8C0Rhph3U=;
        b=oRgAlIHm6wWyN2asjrWvedJdamiN7DJRaW2stasAGmr7toukW9AkjcwSqned/kk5/z
         c5YF6RrmHglNSxAP7jvWkfUV3iEeNpE3FiJ8my2VCmPcpVsW3yJ3IiAnYONRmUZM6qRp
         Lanc8yOL1WZdpqQU1OnpnsLwdsBr19IS7cIxpcTPlEO/8Mp7XJIRwHXif9cR4hHVDQdO
         aHin8GuDKIeDbQqZBVwmnE5lNEhSkhyEwgmVMJhKf+2vNX5YPRhqrDiYvRcXWaLftLYp
         VJgPOr2rROiaLLtyxGByft74FWkxGhl6ZvIq82vqeb6ZWpI5op8/+WuIaQljBymKS2zv
         0+kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZLkFwdHW7tpL1lpDBNXdPL4T4si80CJ3ca8C0Rhph3U=;
        b=69THxqUB+B18N7I7b2idl00//SiuZj9ZLlidil7YaeGecUAX0Bzt+nCyejQv9Jxi7g
         ew1A+51sluNCDZRAhTdXJG7f27l47k3Ha7o5J/Mcn/DmHaz2plVzKz5YZbw/GeEuWNH/
         7lfrUP8U9QfF9tjjix2b2SuK5IZqM9OagA03vFfKhEVccDGdmjZKsGGLkwDD0eAiHE0b
         0KWptPwIZldQFAHdrlYlFIAE03Mo2cagvfE4yyWSkihcz1KNS00eCyNu7uePhiBgUNiM
         DySKzV/8PqMqFu9WRnq6mm2G+SVIboqIcGqE+gTOFhWiSuPgamwt7wBEugsKrjFVgQg2
         /1bw==
X-Gm-Message-State: AOAM532WZ/oQfVnjwhbaX6lcSnzl2l2CjEuGByP+KGOzOjwrw/udewAA
        U7MHjG+H3iYSW12D7u1nhuedpv5vxTwISQ==
X-Google-Smtp-Source: ABdhPJwZDajta8Ijmm/lCslZedmoETXeqeRTluImdhNWoeT2xtNAspYcLlrdJB6w+XBoRR3kiVe3QA==
X-Received: by 2002:a05:6512:1086:: with SMTP id j6mr17394682lfg.375.1643128188139;
        Tue, 25 Jan 2022 08:29:48 -0800 (PST)
Received: from jade.urgonet (h-94-254-48-165.A175.priv.bahnhof.se. [94.254.48.165])
        by smtp.gmail.com with ESMTPSA id d13sm536240lfq.75.2022.01.25.08.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 08:29:47 -0800 (PST)
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        Rijo Thomas <Rijo-john.Thomas@amd.com>,
        David Howells <dhowells@redhat.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v3 03/12] tee: add tee_shm_alloc_user_buf()
Date:   Tue, 25 Jan 2022 17:29:29 +0100
Message-Id: <20220125162938.838382-4-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220125162938.838382-1-jens.wiklander@linaro.org>
References: <20220125162938.838382-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds a new function tee_shm_alloc_user_buf() or user mode allocations,
replacing passing the flags TEE_SHM_MAPPED | TEE_SHM_DMA_BUF to
tee_shm_alloc().

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/tee/tee_core.c     |  2 +-
 drivers/tee/tee_private.h  |  2 ++
 drivers/tee/tee_shm.c      | 17 +++++++++++++++++
 drivers/tee/tee_shm_pool.c |  2 +-
 include/linux/tee_drv.h    |  2 +-
 5 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index 3fc426dad2df..a15812baaeb1 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -297,7 +297,7 @@ static int tee_ioctl_shm_alloc(struct tee_context *ctx,
 	if (data.flags)
 		return -EINVAL;
 
-	shm = tee_shm_alloc(ctx, data.size, TEE_SHM_MAPPED | TEE_SHM_DMA_BUF);
+	shm = tee_shm_alloc_user_buf(ctx, data.size);
 	if (IS_ERR(shm))
 		return PTR_ERR(shm);
 
diff --git a/drivers/tee/tee_private.h b/drivers/tee/tee_private.h
index e55204df31ce..e09c8aa5d967 100644
--- a/drivers/tee/tee_private.h
+++ b/drivers/tee/tee_private.h
@@ -68,4 +68,6 @@ void tee_device_put(struct tee_device *teedev);
 void teedev_ctx_get(struct tee_context *ctx);
 void teedev_ctx_put(struct tee_context *ctx);
 
+struct tee_shm *tee_shm_alloc_user_buf(struct tee_context *ctx, size_t size);
+
 #endif /*TEE_PRIVATE_H*/
diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
index 499fccba3d74..7e7e762fc1de 100644
--- a/drivers/tee/tee_shm.c
+++ b/drivers/tee/tee_shm.c
@@ -127,6 +127,23 @@ struct tee_shm *tee_shm_alloc(struct tee_context *ctx, size_t size, u32 flags)
 }
 EXPORT_SYMBOL_GPL(tee_shm_alloc);
 
+/**
+ * tee_shm_alloc_user_buf() - Allocate shared memory for user space
+ * @ctx:	Context that allocates the shared memory
+ * @size:	Requested size of shared memory
+ *
+ * Memory allocated as user space shared memory is automatically freed when
+ * the TEE file pointer is closed. The primary usage of this function is
+ * when the TEE driver doesn't support registering ordinary user space
+ * memory.
+ *
+ * @returns a pointer to 'struct tee_shm'
+ */
+struct tee_shm *tee_shm_alloc_user_buf(struct tee_context *ctx, size_t size)
+{
+	return tee_shm_alloc(ctx, size, TEE_SHM_MAPPED | TEE_SHM_DMA_BUF);
+}
+
 /**
  * tee_shm_alloc_kernel_buf() - Allocate shared memory for kernel buffer
  * @ctx:	Context that allocates the shared memory
diff --git a/drivers/tee/tee_shm_pool.c b/drivers/tee/tee_shm_pool.c
index a9f9d50fd181..0e460347138a 100644
--- a/drivers/tee/tee_shm_pool.c
+++ b/drivers/tee/tee_shm_pool.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (c) 2015, Linaro Limited
+ * Copyright (c) 2015, 2017, 2022 Linaro Limited
  */
 #include <linux/device.h>
 #include <linux/dma-buf.h>
diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
index 6b0f0d01ebdf..975500b2553e 100644
--- a/include/linux/tee_drv.h
+++ b/include/linux/tee_drv.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- * Copyright (c) 2015-2016, Linaro Limited
+ * Copyright (c) 2015-2022 Linaro Limited
  */
 
 #ifndef __TEE_DRV_H
-- 
2.31.1

