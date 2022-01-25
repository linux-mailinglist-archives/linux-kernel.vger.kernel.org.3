Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A77B49B8D1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 17:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1583874AbiAYQeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 11:34:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380642AbiAYQ34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 11:29:56 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A57C06173B
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 08:29:55 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id x23so10844288lfc.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 08:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wM1CGdwosWr/o/zdNTKI7CddYVnDP6JJ4xL8rpa+Aas=;
        b=czVsqeDAcTn5kRJ27t75r4cQgrJ0ojxkSDuTanEeKiRZ1UYWagh7myXcwNZtEEplV1
         rTXiNc5wgrEdembulrWLk9Wdyfts3k8asT3bzaG0yRvOUBtl5tx1wwLyKo8cgRk2o6rS
         rbw15vDLHlO/ZD9rBE8B7AhLGKEaBuyuPSMBJq+76yTnEeXbpo+e9d3Qam6UhfathHzO
         BPmO5Q1BiPC37Y8kSnuTkvYuDurAcRYPCYr77bm4FjUdh6rlrXOx+ix4QD6YWuRncbHx
         esbChIXhWpkDPjMZRZtuHSgHYDb8cHwZ3+VMvV+LS9VG/8lOzCqFZsouCS3DhpZ7NIow
         Spzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wM1CGdwosWr/o/zdNTKI7CddYVnDP6JJ4xL8rpa+Aas=;
        b=hebWEzZQJn8RuZWINx0POBd4842qENw2lGd/20zEkafQ8nY4kL9lxM6SZQoHUihBl5
         c0D1yRXrcKTxdWA2QYhKDJiowYypbAtSEny6rzwu6wL8u9PJW8WlYQtkBEC+0Y19drx7
         9bqY9VWkbv7ykFl0l+ILEhZHvmqNVFPUPj1nIIVo9orbslEcXeB3I9bB5LuXJU7t6pJf
         ZBtFAFtUQi7B2EW/9i7MmE0LltfGLgRbGNrOBvFu2MM2+74M6OOOBVgamc5G8cpNbuoE
         aUSphiDtxs08emojwvvrpxPuEyQtSlO74s9hjxDqg+/LQMjfk1/uMm1TRrvP1QlmbmPb
         aWeQ==
X-Gm-Message-State: AOAM530visMherKtdQo9MGhnWGfb8aMdSLo4rxBCjnQAOz/AGKCLImTW
        A6sl17luA2XoeWvJF2ClDroksi9gi1S1nQ==
X-Google-Smtp-Source: ABdhPJwQC8ZpuWD/gnJYu1zep0OIKJMceUdl1vKx0nHl35vObk1PDkyOhBH2dXNB94I2vxEAeZSFCw==
X-Received: by 2002:a05:6512:11d0:: with SMTP id h16mr16878548lfr.307.1643128194030;
        Tue, 25 Jan 2022 08:29:54 -0800 (PST)
Received: from jade.urgonet (h-94-254-48-165.A175.priv.bahnhof.se. [94.254.48.165])
        by smtp.gmail.com with ESMTPSA id d13sm536240lfq.75.2022.01.25.08.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 08:29:53 -0800 (PST)
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        Rijo Thomas <Rijo-john.Thomas@amd.com>,
        David Howells <dhowells@redhat.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v3 08/12] optee: add optee_pool_op_free_helper()
Date:   Tue, 25 Jan 2022 17:29:34 +0100
Message-Id: <20220125162938.838382-9-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220125162938.838382-1-jens.wiklander@linaro.org>
References: <20220125162938.838382-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds a common helper function to free a tee_shm allocated using the
helper function optee_pool_op_alloc_helper().

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/tee/optee/core.c          | 10 ++++++++++
 drivers/tee/optee/ffa_abi.c       |  4 +---
 drivers/tee/optee/optee_private.h |  3 +++
 drivers/tee/optee/smc_abi.c       |  7 +++----
 4 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index f4bccb5f0e93..daf947e98d14 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -69,6 +69,16 @@ int optee_pool_op_alloc_helper(struct tee_shm_pool *pool, struct tee_shm *shm,
 	return rc;
 }
 
+void optee_pool_op_free_helper(struct tee_shm_pool *pool, struct tee_shm *shm,
+			       int (*shm_unregister)(struct tee_context *ctx,
+						     struct tee_shm *shm))
+{
+	if (shm_unregister)
+		shm_unregister(shm->ctx, shm);
+	free_pages((unsigned long)shm->kaddr, get_order(shm->size));
+	shm->kaddr = NULL;
+}
+
 static void optee_bus_scan(struct work_struct *work)
 {
 	WARN_ON(optee_enumerate_devices(PTA_CMD_GET_DEVICES_SUPP));
diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
index fb7345941024..8cd9c70a9268 100644
--- a/drivers/tee/optee/ffa_abi.c
+++ b/drivers/tee/optee/ffa_abi.c
@@ -379,9 +379,7 @@ static int pool_ffa_op_alloc(struct tee_shm_pool *pool,
 static void pool_ffa_op_free(struct tee_shm_pool *pool,
 			     struct tee_shm *shm)
 {
-	optee_ffa_shm_unregister(shm->ctx, shm);
-	free_pages((unsigned long)shm->kaddr, get_order(shm->size));
-	shm->kaddr = NULL;
+	optee_pool_op_free_helper(pool, shm, optee_ffa_shm_unregister);
 }
 
 static void pool_ffa_op_destroy_pool(struct tee_shm_pool *pool)
diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
index df3a483bbf46..e77765c78878 100644
--- a/drivers/tee/optee/optee_private.h
+++ b/drivers/tee/optee/optee_private.h
@@ -236,6 +236,9 @@ int optee_pool_op_alloc_helper(struct tee_shm_pool *pool, struct tee_shm *shm,
 						   struct page **pages,
 						   size_t num_pages,
 						   unsigned long start));
+void optee_pool_op_free_helper(struct tee_shm_pool *pool, struct tee_shm *shm,
+			       int (*shm_unregister)(struct tee_context *ctx,
+						     struct tee_shm *shm));
 
 
 void optee_remove_common(struct optee *optee);
diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
index 0dc383c974a3..9c1c9cfb7488 100644
--- a/drivers/tee/optee/smc_abi.c
+++ b/drivers/tee/optee/smc_abi.c
@@ -548,10 +548,9 @@ static void pool_op_free(struct tee_shm_pool *pool,
 			 struct tee_shm *shm)
 {
 	if (!(shm->flags & TEE_SHM_PRIV))
-		optee_shm_unregister(shm->ctx, shm);
-
-	free_pages((unsigned long)shm->kaddr, get_order(shm->size));
-	shm->kaddr = NULL;
+		optee_pool_op_free_helper(pool, shm, optee_shm_unregister);
+	else
+		optee_pool_op_free_helper(pool, shm, NULL);
 }
 
 static void pool_op_destroy_pool(struct tee_shm_pool *pool)
-- 
2.31.1

