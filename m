Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1FE48EC45
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 16:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242301AbiANPIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 10:08:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242247AbiANPIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 10:08:43 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A69DC061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 07:08:43 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id o12so14499678lfu.12
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 07:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kkaQ+ilU28pNJN/7SN9SP94ch7HastDd6BRVCG2d0i4=;
        b=t4Qxcaw29ddTpIY1GIQo/VNupFBYlv49gkZXf5Z+dchvERgY8PNd135R8OriOBLprv
         rGc0sZOW8unQcFW6eUw2vgcMsoAVXmHKJibRhubP9ZGRteTP6kMH3DLocCh8WyN7H37R
         t5uEQ+L/61IRXqV7hbRlTMUBV0mB8mQYHRXEcC2aEUdsS1J7wTjPqAnUzJqsTfnIvtUm
         L8AKMqGX32sGfvQmxZkKYhwxt8MAKN5MMYYMrrSIQEvR9fiQBa5r5a/bjOZPgh7ZKQEh
         0OuPjpEdzJI/U69mBnYnD71ypu47cTqKv07t6UjAj5VF/hO3Tw8cXiVB2OSpqxCB4+qp
         PuaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kkaQ+ilU28pNJN/7SN9SP94ch7HastDd6BRVCG2d0i4=;
        b=xn9gNywmdihZIupja+bTlZVMv68eGHO39OzXCkFW7279McxM+CPRE/4AboRXs3zpIi
         ImmxibJltOVEhstWJyJWVF659UIanf8ExoxUqHyyvXyoGX3QkQwT+Mgz8I7EkJFHOCOZ
         uS4zB7hdibPJQR8GHb45UKz0EqO0HA7YYUOJG9ZQXusW8XcoQfTepGhrblL/qUAIQ2kx
         HJ3ITWtMZMw+GUKxu5nTq12QGcpm1vP73aMDlwknnKAroYd0CPDK/G9ZjdVaeE69VXla
         Envj+ljxkHkznfrPuS6Idf52LWKClY05rRuJt99A3Fkdcs6r7TDBLKHfehUnedqwSsD2
         ajSA==
X-Gm-Message-State: AOAM533KFJHr/EY8kfF3tlKLlQSdWIVQXekBx9hc5Pq9/8LVHCU0vhDp
        1gAbEA6iyhmjSMzJWKr4H/dF4WIVMX+c5w==
X-Google-Smtp-Source: ABdhPJxPOJWCHT1fugAixWFFYnPcwdNVZyAgtU5RcZTq8Jve1Q46caSwMBvHnm02PH0pxdrq/0iRqw==
X-Received: by 2002:a2e:86c7:: with SMTP id n7mr3943474ljj.102.1642172921646;
        Fri, 14 Jan 2022 07:08:41 -0800 (PST)
Received: from jade.urgonet (h-94-254-48-165.A175.priv.bahnhof.se. [94.254.48.165])
        by smtp.gmail.com with ESMTPSA id i31sm40517lfv.67.2022.01.14.07.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 07:08:41 -0800 (PST)
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        Rijo Thomas <Rijo-john.Thomas@amd.com>,
        David Howells <dhowells@redhat.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v2 03/12] tee: add tee_shm_alloc_user_buf()
Date:   Fri, 14 Jan 2022 16:08:15 +0100
Message-Id: <20220114150824.3578829-4-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220114150824.3578829-1-jens.wiklander@linaro.org>
References: <20220114150824.3578829-1-jens.wiklander@linaro.org>
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
 drivers/tee/tee_shm.c      | 18 ++++++++++++++++++
 drivers/tee/tee_shm_pool.c |  2 +-
 include/linux/tee_drv.h    |  3 ++-
 4 files changed, 22 insertions(+), 3 deletions(-)

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
 
diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
index 499fccba3d74..b43178986985 100644
--- a/drivers/tee/tee_shm.c
+++ b/drivers/tee/tee_shm.c
@@ -127,6 +127,24 @@ struct tee_shm *tee_shm_alloc(struct tee_context *ctx, size_t size, u32 flags)
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
+EXPORT_SYMBOL_GPL(tee_shm_alloc_user_buf);
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
index 6b0f0d01ebdf..26b450484ac1 100644
--- a/include/linux/tee_drv.h
+++ b/include/linux/tee_drv.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- * Copyright (c) 2015-2016, Linaro Limited
+ * Copyright (c) 2015-2022 Linaro Limited
  */
 
 #ifndef __TEE_DRV_H
@@ -308,6 +308,7 @@ void *tee_get_drvdata(struct tee_device *teedev);
  * @returns a pointer to 'struct tee_shm'
  */
 struct tee_shm *tee_shm_alloc(struct tee_context *ctx, size_t size, u32 flags);
+struct tee_shm *tee_shm_alloc_user_buf(struct tee_context *ctx, size_t size);
 struct tee_shm *tee_shm_alloc_kernel_buf(struct tee_context *ctx, size_t size);
 
 /**
-- 
2.31.1

