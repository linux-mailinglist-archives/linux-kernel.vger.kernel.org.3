Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BABC249B8C6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 17:35:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1583733AbiAYQdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 11:33:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379839AbiAYQ3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 11:29:49 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A55C06173B
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 08:29:48 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id j14so15992050lja.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 08:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yn8zIxo8jyjO0ELBYvTuGmQzkeFiyQ40SLBI74VyhvY=;
        b=U6/8Cu8EEapXKBRoXxg85Avz9U7XFIDJQViGrn5MQCdkZ1CwYUNnJUqBTdOH14w6LP
         sajAXN85TP4haUIQvP+z8bg/5u9nnQFMqzlRsnoNdX78u613weSxNAZPanujtXZn69hl
         ESLSKo8+3WI8hsU0HisbY0r5nbSSVfCj6HkLNO0ochr4gv5vbUOGIJaoBDN7USHSyxXH
         pRwiyuff8brNpaTXwM3xLAhn4yEp9nJxaco++7aAHWn/uwhswiIRS3IzNUlLFlxCwqt7
         U0/rx8TV/Aa5i7sVh+TGPt7YuPa41G/JMuLm4v1G59Q361KYodZB5LyqaP7WBde5jwi/
         usHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yn8zIxo8jyjO0ELBYvTuGmQzkeFiyQ40SLBI74VyhvY=;
        b=01PYt6BwymaxastuKI9ObBgyl9XcvEcVndJFVwZAGliPxgf1fj5sAQjDS6VP7JmbSx
         LwUhgAKr6JD0opLOd4ecYOXy7Dr0q476czJHwWxhUlbHrIJENzFG0y9NCCP3I4KHe9pV
         55MZidpVRa46AGCPRLVOm6cnlzOM7KgCzHlp1xCAQ+H+M4C/nrq/fI6zCLAxQoav40cD
         s24j1UwV2uSi0qcGT1X17AvSfQdwcbcF3ER06gVVK2b865/g8xrltkEs+jjvJeSXGphh
         YXPcM4L7W7FkCjCU3tboT2QR3FhUmmDKGxAzMSFrCAdadMAdelTkfWyuxPzoMvMqYwM9
         RDVQ==
X-Gm-Message-State: AOAM533d4BkcbLp3CJfZFelsXnC0npbA4m3uF8XB/MK9zqmW+NzOTfik
        BXvQmN08Ivum5i0y1cd3ouFdTfoPr/sg7A==
X-Google-Smtp-Source: ABdhPJymult2DexRFamwZgT8ITwinSya1EcZVtgiH9wRs5XpBJW4oHP8wAEyTm+DEErtHTEYy7JquQ==
X-Received: by 2002:a05:651c:b2a:: with SMTP id b42mr14571869ljr.168.1643128186988;
        Tue, 25 Jan 2022 08:29:46 -0800 (PST)
Received: from jade.urgonet (h-94-254-48-165.A175.priv.bahnhof.se. [94.254.48.165])
        by smtp.gmail.com with ESMTPSA id d13sm536240lfq.75.2022.01.25.08.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 08:29:46 -0800 (PST)
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        Rijo Thomas <Rijo-john.Thomas@amd.com>,
        David Howells <dhowells@redhat.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v3 02/12] tee: remove unused tee_shm_pool_alloc_res_mem()
Date:   Tue, 25 Jan 2022 17:29:28 +0100
Message-Id: <20220125162938.838382-3-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220125162938.838382-1-jens.wiklander@linaro.org>
References: <20220125162938.838382-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

None of the drivers in the TEE subsystem uses
tee_shm_pool_alloc_res_mem() so remove the function.

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
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

