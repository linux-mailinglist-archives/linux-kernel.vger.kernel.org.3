Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 376EC4A96E0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 10:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240371AbiBDJeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 04:34:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239763AbiBDJeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 04:34:14 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A06FC061401
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 01:34:13 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id z4so11508441lft.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 01:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yn8zIxo8jyjO0ELBYvTuGmQzkeFiyQ40SLBI74VyhvY=;
        b=s8mMzmsSA1dE4oUddbq1qzNko2vK6jKtLdXrTc1toAkzT32q1UgpuZJv2X8EwvoO4w
         dBsTSDQBnPTt8XL5ySsufegkKwWtIwvMEmAlF7abJdOnfGVxb3sBkdaS4z+Za07vYJ/Z
         5eCKgE6NqAk+UqYhX/2rOOeeIuSK63PFJRwHrKV5WGqu8biGmSlhGSwugJ+vq1nG1gy1
         GpVGbRsX8+h8F0w5hsHD6NNUP97omkr4blgPyaR2xAMmKv67blb0dkMOj8Ikap4Gbtm8
         FZ+krYmAxA/DlGSxWraANCrQpgSFpmZXtqCRqNIfJjaOIxYbLD/KvpyeyfSiCQvMlOso
         +ZDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yn8zIxo8jyjO0ELBYvTuGmQzkeFiyQ40SLBI74VyhvY=;
        b=JQj5OwxLVumLqEjpueKGHguqtseDlE6pY/Cs2LbgpEA/BWmnKPA4t/24TfMUvQG1+C
         SpQ0roJwfHdtb+gxFCccUeBEduK1vmqQQWFEL6opaNNDq8fz+mTqbszombldbxZYOH6Z
         0l6zUE04KixAdh7OpbAh2BiSPlgNL/KIr9GkMZEypYQarkpclVMgpAcES+R22qS6Ch9Q
         YnaDGpRttim2W4noBbE6ol7orZ0sIHlS1K4fpWMJBkY1Ev1e6tn7l8lVJg0zBAy/odn9
         iQYBIiYnr6AShCVnoS/eSNcvuiXN9Ujdu9oFwdSVZYOPV+057lnIF1mz2CynGBkKTopV
         u7xg==
X-Gm-Message-State: AOAM531sOyn9xmAvwnzVz+g75cK5Gokp4gK2iJinrLdeOtG5Sr6nEvoH
        btG81H1QsE6rvi+qWBHgzlMYdv7Z/I5qJg==
X-Google-Smtp-Source: ABdhPJwyoBH4bVmPRNuT8CDlgrmG2GDxZvniiD/FmgYX+eO2syxc7iCFkAGrQUt4L0Qdit9nEF5PBg==
X-Received: by 2002:a05:6512:234f:: with SMTP id p15mr1775788lfu.606.1643967251531;
        Fri, 04 Feb 2022 01:34:11 -0800 (PST)
Received: from jade.urgonet (h-94-254-48-165.A175.priv.bahnhof.se. [94.254.48.165])
        by smtp.gmail.com with ESMTPSA id u28sm230550lfl.160.2022.02.04.01.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 01:34:11 -0800 (PST)
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        Rijo Thomas <Rijo-john.Thomas@amd.com>,
        David Howells <dhowells@redhat.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v4 02/10] tee: remove unused tee_shm_pool_alloc_res_mem()
Date:   Fri,  4 Feb 2022 10:33:51 +0100
Message-Id: <20220204093359.359059-3-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220204093359.359059-1-jens.wiklander@linaro.org>
References: <20220204093359.359059-1-jens.wiklander@linaro.org>
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

