Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9E24A96E2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 10:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356427AbiBDJeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 04:34:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240258AbiBDJeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 04:34:14 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DCD7C061744
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 01:34:14 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id e17so7666958ljk.5
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 01:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RJsD6xXO+PD8CsfT04affYv2wFE+MUYIEsBwIBL+qZs=;
        b=uS6Q6kvYh6eo56AILGB/zlaWJMz4UVzmSwmpN5n9ARa5o9bl/0pmeLCu47bX/gq0xI
         5V/7PCfrRfmVPl4Xq3tn6fZtbfnMTEGo8l0ZpteSQPi/KNeUO9muKzzQORgSc1JOsDJ0
         wjfK0z58z0NfGYUsold9uKXY3DvyAOiPwc/XEV4TsqlxIB97xUZlz6lbm8OVRNRmkgu5
         aYKVtYxEii7xWYMD+GakzSsgMcN93SdKJeGNqnlbEIIPRF29jOmncOmwYPZ9bUfPTXnV
         O8pckVsNa9ScTopRjsFuDI0CIJP1K1pF8H0PDIXJGqe/Yr+T35dLn6DeCklGrIFSCsV5
         aJaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RJsD6xXO+PD8CsfT04affYv2wFE+MUYIEsBwIBL+qZs=;
        b=fl8ExBRP8egJXFOsZKy69aYY2UD/c7JkYm/N0mshg+o8H2ceZVUW6aCU5V9PbSl58F
         i65HAIr+lj9eHhcPdlQewF9YEi/RjZ/bIe6rkUFC+k43qW697gVj4Va7hFz0Zo8jcJBr
         LSUbHBkJqG2SssEgMVbvI/I4yYhD2OL6oBt2EWN66/nFLQdtcD6a+lqzrMjCxHf3NRvM
         pQsSHHiETjWpz/2bj1MIGGxtOu3nDgwcto7Ya5qyb8y7xbzxuIlPUxLqJW/9qnMVUHw7
         XrniMuwbhBfvMjlnYwb82Tlks1xAKU6JEWDx+C40kVSQocppoVBtzupP7bRJcRlErt5o
         BTWw==
X-Gm-Message-State: AOAM533TVJzgJymboo7HELlzXUw+wG+0rFsL104EJkWBq9nniAUvvs1V
        599zM7x0nlh3HlOGoixqgmq4gVPAl0FGgA==
X-Google-Smtp-Source: ABdhPJwmi128R/blOX9fRTJYrg5u0YYPW66NQdgr+od2VQVLltUMJMRLX6Bs2g3riaQmEEGjakO6Lg==
X-Received: by 2002:a2e:bd82:: with SMTP id o2mr1324075ljq.454.1643967252595;
        Fri, 04 Feb 2022 01:34:12 -0800 (PST)
Received: from jade.urgonet (h-94-254-48-165.A175.priv.bahnhof.se. [94.254.48.165])
        by smtp.gmail.com with ESMTPSA id u28sm230550lfl.160.2022.02.04.01.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 01:34:12 -0800 (PST)
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        Rijo Thomas <Rijo-john.Thomas@amd.com>,
        David Howells <dhowells@redhat.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v4 03/10] tee: add tee_shm_alloc_user_buf()
Date:   Fri,  4 Feb 2022 10:33:52 +0100
Message-Id: <20220204093359.359059-4-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220204093359.359059-1-jens.wiklander@linaro.org>
References: <20220204093359.359059-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds a new function tee_shm_alloc_user_buf() for user mode allocations,
replacing passing the flags TEE_SHM_MAPPED | TEE_SHM_DMA_BUF to
tee_shm_alloc().

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
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
index a9f9d50fd181..54c11aa374a8 100644
--- a/drivers/tee/tee_shm_pool.c
+++ b/drivers/tee/tee_shm_pool.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (c) 2015, Linaro Limited
+ * Copyright (c) 2015 Linaro Limited
  */
 #include <linux/device.h>
 #include <linux/dma-buf.h>
diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
index 6b0f0d01ebdf..a4393c8c38f3 100644
--- a/include/linux/tee_drv.h
+++ b/include/linux/tee_drv.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- * Copyright (c) 2015-2016, Linaro Limited
+ * Copyright (c) 2015-2016 Linaro Limited
  */
 
 #ifndef __TEE_DRV_H
-- 
2.31.1

