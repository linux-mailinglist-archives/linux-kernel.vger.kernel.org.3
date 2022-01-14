Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA8D48EC44
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 16:08:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242263AbiANPIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 10:08:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235794AbiANPIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 10:08:43 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E7D2C061746
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 07:08:42 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id x11so5463252lfa.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 07:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4dui9+NpX4w52rrVA0g43taTTsULBafA6eRdbjyTa0s=;
        b=rD4w4QP10UDyrS9EQ5coM1KCAFC9PxRPJ9d9lH+BANBIoZQkYN1mZUCY/MUm5E9Qry
         1wLzrMKT0O+F524Qx07gOZCBpDVamGz+r/VWiGT81TyQhXzxeNHVajeaW0jeDtXtbbtY
         TwrLh0yEEdk1qCV9CVetAJqHRE+rVcDBu5j+YkQhlvqBaXRarqeu/0bhT+oGWsZ9c8xm
         8ZoF3e/vx7WE2RM/C0pJac76Qk8t7FVqhQD8MhoniX8t+60HKHL9S5t8SJHqlva2NnDS
         VXlnotD/BRXqyI4dXsTqLT27BUVFPhMifVhqPTTf9LDyMWnJbFO2P+DQBDZU/FfRTgDb
         VrMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4dui9+NpX4w52rrVA0g43taTTsULBafA6eRdbjyTa0s=;
        b=UjX3EOVWKIGWVifq+mBNyQqd0DUXt36rYTQq44aMKfvtQmoEioKgh04wzyaRhTGuTW
         65vpYAw5JEb0YKiJbxc7WCegqo8lp4f3h4QdSwmI+RZBhD+3FPS2Ymy6FfnMGq+uTG5V
         te+fUt5G5kIH0Hb3lBAoOdN6wX5eEbfK7xyWP8vQ5QOa4U6NuawlYZtn6t+1SBfePrA1
         Q8h2bUmXqZFckB5W1rIrfmn7jJISRZQhxTCawTVYeKeEUjbWLoRH0CGjt3rW/rsLz6wb
         EJ/VPNOZlvf48MsR60tidYx7EZGMGZ+IyKnL2irNFGVG3zJyZS1PQFu6G9koG4itevT5
         hVZA==
X-Gm-Message-State: AOAM530vrdfoOru095cznIWOjMMofXj3Qka4vjmLCNUihdKHkT4BXz6+
        7Mh1rtD2CQW0/HehhWQbNdxM+kBIO7UtLA==
X-Google-Smtp-Source: ABdhPJx+G+1RC9jl681kZrchzosFEWuHX+TYTIeHYMiaCzuOta6YAeCce9VzoM9rOK9s44WwJYo+qg==
X-Received: by 2002:a2e:9609:: with SMTP id v9mr5847790ljh.45.1642172920876;
        Fri, 14 Jan 2022 07:08:40 -0800 (PST)
Received: from jade.urgonet (h-94-254-48-165.A175.priv.bahnhof.se. [94.254.48.165])
        by smtp.gmail.com with ESMTPSA id i31sm40517lfv.67.2022.01.14.07.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 07:08:40 -0800 (PST)
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        Rijo Thomas <Rijo-john.Thomas@amd.com>,
        David Howells <dhowells@redhat.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v2 02/12] tee: remove unused tee_shm_pool_alloc_res_mem()
Date:   Fri, 14 Jan 2022 16:08:14 +0100
Message-Id: <20220114150824.3578829-3-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220114150824.3578829-1-jens.wiklander@linaro.org>
References: <20220114150824.3578829-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

None of the drivers in the TEE subsystem uses
tee_shm_pool_alloc_res_mem() so remove the function.

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/tee/tee_shm_pool.c | 56 --------------------------------------
 include/linux/tee_drv.h    | 30 --------------------
 2 files changed, 86 deletions(-)

diff --git a/drivers/tee/tee_shm_pool.c b/drivers/tee/tee_shm_pool.c
index fcbb461fc59c..a9f9d50fd181 100644
--- a/drivers/tee/tee_shm_pool.c
+++ b/drivers/tee/tee_shm_pool.c
@@ -47,62 +47,6 @@ static const struct tee_shm_pool_mgr_ops pool_ops_generic = {
 	.destroy_poolmgr = pool_op_gen_destroy_poolmgr,
 };
 
-/**
- * tee_shm_pool_alloc_res_mem() - Create a shared memory pool from reserved
- * memory range
- * @priv_info:	Information for driver private shared memory pool
- * @dmabuf_info: Information for dma-buf shared memory pool
- *
- * Start and end of pools will must be page aligned.
- *
- * Allocation with the flag TEE_SHM_DMA_BUF set will use the range supplied
- * in @dmabuf, others will use the range provided by @priv.
- *
- * @returns pointer to a 'struct tee_shm_pool' or an ERR_PTR on failure.
- */
-struct tee_shm_pool *
-tee_shm_pool_alloc_res_mem(struct tee_shm_pool_mem_info *priv_info,
-			   struct tee_shm_pool_mem_info *dmabuf_info)
-{
-	struct tee_shm_pool_mgr *priv_mgr;
-	struct tee_shm_pool_mgr *dmabuf_mgr;
-	void *rc;
-
-	/*
-	 * Create the pool for driver private shared memory
-	 */
-	rc = tee_shm_pool_mgr_alloc_res_mem(priv_info->vaddr, priv_info->paddr,
-					    priv_info->size,
-					    3 /* 8 byte aligned */);
-	if (IS_ERR(rc))
-		return rc;
-	priv_mgr = rc;
-
-	/*
-	 * Create the pool for dma_buf shared memory
-	 */
-	rc = tee_shm_pool_mgr_alloc_res_mem(dmabuf_info->vaddr,
-					    dmabuf_info->paddr,
-					    dmabuf_info->size, PAGE_SHIFT);
-	if (IS_ERR(rc))
-		goto err_free_priv_mgr;
-	dmabuf_mgr = rc;
-
-	rc = tee_shm_pool_alloc(priv_mgr, dmabuf_mgr);
-	if (IS_ERR(rc))
-		goto err_free_dmabuf_mgr;
-
-	return rc;
-
-err_free_dmabuf_mgr:
-	tee_shm_pool_mgr_destroy(dmabuf_mgr);
-err_free_priv_mgr:
-	tee_shm_pool_mgr_destroy(priv_mgr);
-
-	return rc;
-}
-EXPORT_SYMBOL_GPL(tee_shm_pool_alloc_res_mem);
-
 struct tee_shm_pool_mgr *tee_shm_pool_mgr_alloc_res_mem(unsigned long vaddr,
 							phys_addr_t paddr,
 							size_t size,
diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
index 5e1533ee3785..6b0f0d01ebdf 100644
--- a/include/linux/tee_drv.h
+++ b/include/linux/tee_drv.h
@@ -278,36 +278,6 @@ static inline void tee_shm_pool_mgr_destroy(struct tee_shm_pool_mgr *poolm)
 	poolm->ops->destroy_poolmgr(poolm);
 }
 
-/**
- * struct tee_shm_pool_mem_info - holds information needed to create a shared
- * memory pool
- * @vaddr:	Virtual address of start of pool
- * @paddr:	Physical address of start of pool
- * @size:	Size in bytes of the pool
- */
-struct tee_shm_pool_mem_info {
-	unsigned long vaddr;
-	phys_addr_t paddr;
-	size_t size;
-};
-
-/**
- * tee_shm_pool_alloc_res_mem() - Create a shared memory pool from reserved
- * memory range
- * @priv_info:	 Information for driver private shared memory pool
- * @dmabuf_info: Information for dma-buf shared memory pool
- *
- * Start and end of pools will must be page aligned.
- *
- * Allocation with the flag TEE_SHM_DMA_BUF set will use the range supplied
- * in @dmabuf, others will use the range provided by @priv.
- *
- * @returns pointer to a 'struct tee_shm_pool' or an ERR_PTR on failure.
- */
-struct tee_shm_pool *
-tee_shm_pool_alloc_res_mem(struct tee_shm_pool_mem_info *priv_info,
-			   struct tee_shm_pool_mem_info *dmabuf_info);
-
 /**
  * tee_shm_pool_free() - Free a shared memory pool
  * @pool:	The shared memory pool to free
-- 
2.31.1

