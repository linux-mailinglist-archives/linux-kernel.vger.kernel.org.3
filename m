Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A73648EC49
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 16:09:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242278AbiANPJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 10:09:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242265AbiANPIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 10:08:46 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2701CC06161C
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 07:08:46 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id e3so28422212lfc.9
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 07:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KN7qXjKhA52PIsKQ0A6z33AObhJCPkdVrcqrafr2Wr0=;
        b=SRUR5l9oQUHXTx4GzCwMVHbPbkCx8hx1KmKGImVsAB/PfTe0VT+LoFNce/Gkmo1td8
         a/PRus3yLDmqRywIhIv8eLkHvQGzW27Ti8iw43NW3V2yQKOgPmUDYSWqKUrQEqSsmLk/
         gLPXX8luSqbbh0/QvgF9LovDXwAJqNBTYkFFK7GroTuZemjh5qnyTCq6j7jWteHaFxto
         +0vpffuuAUPEra6WSqOEPPTaYEXxN7UkKAixGQa8EZQmeqWVdkwrd8mZ7SMeJEEqO5B6
         Ol3Ax4tEgNZfmBjccp9H3kGVA2icnXbEK1dDTbY4Sr1nmhQCBXE/08Dw0IdbNh6AlnHo
         YyEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KN7qXjKhA52PIsKQ0A6z33AObhJCPkdVrcqrafr2Wr0=;
        b=YmJKXeV7xN0qYbs9x5V5Uh6lg7SGmoxJWCyfjbUkzcUIDSVHn8qBAofMn+FJ/8p8M0
         BAG9DX99OgiNR2onqRuxtD8Xt7Dfn1x3O47m/o10kFDxwMY15YwCLq0CRkT7fqt/vvZJ
         iiWyB5TDli4jNV8FQJU91/pdoh4WyOh2ALYJXl9EL8mKKFYmeX6u3gh/VzSbk23GG9xB
         5ia45GhmfCLe71f/CRP1hxu1sdAth1wPtSqv8peH/M92WlJ6lbz+ES0noyf4OkFEHqB2
         zv9Se2ENZ8OiQ2Z0eCBoA/6MQ9NFRa+WkqmwGzz4ESX6efToz4/xq3R/45AgVvAf8L3T
         06tg==
X-Gm-Message-State: AOAM532F5/Dd1KtLNJQ0UFO86eKFzYVuToA0pglKlI9yokQPPuurUKfL
        sRvSUtWbIRLnenorezNtfYDUWMcNOa1mZQ==
X-Google-Smtp-Source: ABdhPJyEJLX6Fs8y/sCIDdrHydKHyVBQpCDNNHwHIJyELjZicEOLVxpqAWF8cyPi5xdk4tZ0UkGaxA==
X-Received: by 2002:a2e:9093:: with SMTP id l19mr6278461ljg.231.1642172924324;
        Fri, 14 Jan 2022 07:08:44 -0800 (PST)
Received: from jade.urgonet (h-94-254-48-165.A175.priv.bahnhof.se. [94.254.48.165])
        by smtp.gmail.com with ESMTPSA id i31sm40517lfv.67.2022.01.14.07.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 07:08:43 -0800 (PST)
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        Rijo Thomas <Rijo-john.Thomas@amd.com>,
        David Howells <dhowells@redhat.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v2 06/12] optee: add driver private tee_context
Date:   Fri, 14 Jan 2022 16:08:18 +0100
Message-Id: <20220114150824.3578829-7-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220114150824.3578829-1-jens.wiklander@linaro.org>
References: <20220114150824.3578829-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds a driver private tee_context by moving the tee_context in struct
optee_notif to struct optee. This tee_context is used when doing
internal calls to secure world to deliver notification and later also
when sharing driver private memory with secure world.

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/tee/optee/core.c          |  1 +
 drivers/tee/optee/ffa_abi.c       | 61 ++++++++++++++++++-------------
 drivers/tee/optee/optee_private.h |  5 ++-
 drivers/tee/optee/smc_abi.c       | 40 ++++++--------------
 4 files changed, 51 insertions(+), 56 deletions(-)

diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index 2a369e346b85..f4bccb5f0e93 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -161,6 +161,7 @@ void optee_remove_common(struct optee *optee)
 	optee_unregister_devices();
 
 	optee_notif_uninit(optee);
+	teedev_close_context(optee->ctx);
 	/*
 	 * The two devices have to be unregistered before we can free the
 	 * other resources.
diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
index 18963f7e4d48..88a028d4fb7b 100644
--- a/drivers/tee/optee/ffa_abi.c
+++ b/drivers/tee/optee/ffa_abi.c
@@ -766,7 +766,9 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
 {
 	const struct ffa_dev_ops *ffa_ops;
 	unsigned int rpc_arg_count;
+	struct tee_shm_pool *pool;
 	struct tee_device *teedev;
+	struct tee_context *ctx;
 	struct optee *optee;
 	int rc;
 
@@ -786,12 +788,12 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
 	if (!optee)
 		return -ENOMEM;
 
-	optee->pool = optee_ffa_shm_pool_alloc_pages();
-	if (IS_ERR(optee->pool)) {
-		rc = PTR_ERR(optee->pool);
-		optee->pool = NULL;
-		goto err;
+	pool = optee_ffa_shm_pool_alloc_pages();
+	if (IS_ERR(pool)) {
+		rc = PTR_ERR(pool);
+		goto err_free_optee;
 	}
+	optee->pool = pool;
 
 	optee->ops = &optee_ffa_ops;
 	optee->ffa.ffa_dev = ffa_dev;
@@ -802,7 +804,7 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
 				  optee);
 	if (IS_ERR(teedev)) {
 		rc = PTR_ERR(teedev);
-		goto err;
+		goto err_free_pool;
 	}
 	optee->teedev = teedev;
 
@@ -810,50 +812,57 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
 				  optee);
 	if (IS_ERR(teedev)) {
 		rc = PTR_ERR(teedev);
-		goto err;
+		goto err_unreg_teedev;
 	}
 	optee->supp_teedev = teedev;
 
 	rc = tee_device_register(optee->teedev);
 	if (rc)
-		goto err;
+		goto err_unreg_supp_teedev;
 
 	rc = tee_device_register(optee->supp_teedev);
 	if (rc)
-		goto err;
+		goto err_unreg_supp_teedev;
 
 	rc = rhashtable_init(&optee->ffa.global_ids, &shm_rhash_params);
 	if (rc)
-		goto err;
+		goto err_unreg_supp_teedev;
 	mutex_init(&optee->ffa.mutex);
 	mutex_init(&optee->call_queue.mutex);
 	INIT_LIST_HEAD(&optee->call_queue.waiters);
 	optee_supp_init(&optee->supp);
 	ffa_dev_set_drvdata(ffa_dev, optee);
+	ctx = teedev_open(optee->teedev);
+	if (IS_ERR(ctx))
+		goto err_rhashtable_free;
+	optee->ctx = ctx;
 	rc = optee_notif_init(optee, OPTEE_DEFAULT_MAX_NOTIF_VALUE);
-	if (rc) {
-		optee_ffa_remove(ffa_dev);
-		return rc;
-	}
+	if (rc)
+		goto err_close_ctx;
 
 	rc = optee_enumerate_devices(PTA_CMD_GET_DEVICES);
-	if (rc) {
-		optee_ffa_remove(ffa_dev);
-		return rc;
-	}
+	if (rc)
+		goto err_unregister_devices;
 
 	pr_info("initialized driver\n");
 	return 0;
-err:
-	/*
-	 * tee_device_unregister() is safe to call even if the
-	 * devices hasn't been registered with
-	 * tee_device_register() yet.
-	 */
+
+err_unregister_devices:
+	optee_unregister_devices();
+	optee_notif_uninit(optee);
+err_close_ctx:
+	teedev_close_context(ctx);
+err_rhashtable_free:
+	rhashtable_free_and_destroy(&optee->ffa.global_ids, rh_free_fn, NULL);
+	optee_supp_uninit(&optee->supp);
+	mutex_destroy(&optee->call_queue.mutex);
+err_unreg_supp_teedev:
 	tee_device_unregister(optee->supp_teedev);
+err_unreg_teedev:
 	tee_device_unregister(optee->teedev);
-	if (optee->pool)
-		tee_shm_pool_free(optee->pool);
+err_free_pool:
+	tee_shm_pool_free(pool);
+err_free_optee:
 	kfree(optee);
 	return rc;
 }
diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
index df2450921464..df3a483bbf46 100644
--- a/drivers/tee/optee/optee_private.h
+++ b/drivers/tee/optee/optee_private.h
@@ -53,7 +53,6 @@ struct optee_call_queue {
 
 struct optee_notif {
 	u_int max_key;
-	struct tee_context *ctx;
 	/* Serializes access to the elements below in this struct */
 	spinlock_t lock;
 	struct list_head db;
@@ -134,9 +133,10 @@ struct optee_ops {
 /**
  * struct optee - main service struct
  * @supp_teedev:	supplicant device
+ * @teedev:		client device
  * @ops:		internal callbacks for different ways to reach secure
  *			world
- * @teedev:		client device
+ * @ctx:		driver internal TEE context
  * @smc:		specific to SMC ABI
  * @ffa:		specific to FF-A ABI
  * @call_queue:		queue of threads waiting to call @invoke_fn
@@ -152,6 +152,7 @@ struct optee {
 	struct tee_device *supp_teedev;
 	struct tee_device *teedev;
 	const struct optee_ops *ops;
+	struct tee_context *ctx;
 	union {
 		struct optee_smc smc;
 		struct optee_ffa ffa;
diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
index 196cd4316d7d..1dbb13b08381 100644
--- a/drivers/tee/optee/smc_abi.c
+++ b/drivers/tee/optee/smc_abi.c
@@ -952,57 +952,34 @@ static irqreturn_t notif_irq_thread_fn(int irq, void *dev_id)
 {
 	struct optee *optee = dev_id;
 
-	optee_smc_do_bottom_half(optee->notif.ctx);
+	optee_smc_do_bottom_half(optee->ctx);
 
 	return IRQ_HANDLED;
 }
 
 static int optee_smc_notif_init_irq(struct optee *optee, u_int irq)
 {
-	struct tee_context *ctx;
 	int rc;
 
-	ctx = teedev_open(optee->teedev);
-	if (IS_ERR(ctx))
-		return PTR_ERR(ctx);
-
-	optee->notif.ctx = ctx;
 	rc = request_threaded_irq(irq, notif_irq_handler,
 				  notif_irq_thread_fn,
 				  0, "optee_notification", optee);
 	if (rc)
-		goto err_close_ctx;
+		return rc;
 
 	optee->smc.notif_irq = irq;
 
 	return 0;
-
-err_close_ctx:
-	teedev_close_context(optee->notif.ctx);
-	optee->notif.ctx = NULL;
-
-	return rc;
 }
 
 static void optee_smc_notif_uninit_irq(struct optee *optee)
 {
-	if (optee->notif.ctx) {
-		optee_smc_stop_async_notif(optee->notif.ctx);
+	if (optee->smc.sec_caps & OPTEE_SMC_SEC_CAP_ASYNC_NOTIF) {
+		optee_smc_stop_async_notif(optee->ctx);
 		if (optee->smc.notif_irq) {
 			free_irq(optee->smc.notif_irq, optee);
 			irq_dispose_mapping(optee->smc.notif_irq);
 		}
-
-		/*
-		 * The thread normally working with optee->notif.ctx was
-		 * stopped with free_irq() above.
-		 *
-		 * Note we're not using teedev_close_context() or
-		 * tee_client_close_context() since we have already called
-		 * tee_device_put() while initializing to avoid a circular
-		 * reference counting.
-		 */
-		teedev_close_context(optee->notif.ctx);
 	}
 }
 
@@ -1307,6 +1284,7 @@ static int optee_probe(struct platform_device *pdev)
 	struct optee *optee = NULL;
 	void *memremaped_shm = NULL;
 	struct tee_device *teedev;
+	struct tee_context *ctx;
 	u32 max_notif_value;
 	u32 sec_caps;
 	int rc;
@@ -1387,9 +1365,13 @@ static int optee_probe(struct platform_device *pdev)
 	optee->pool = pool;
 
 	platform_set_drvdata(pdev, optee);
+	ctx = teedev_open(optee->teedev);
+	if (IS_ERR(ctx))
+		goto err_supp_uninit;
+	optee->ctx = ctx;
 	rc = optee_notif_init(optee, max_notif_value);
 	if (rc)
-		goto err_supp_uninit;
+		goto err_close_ctx;
 
 	if (sec_caps & OPTEE_SMC_SEC_CAP_ASYNC_NOTIF) {
 		unsigned int irq;
@@ -1437,6 +1419,8 @@ static int optee_probe(struct platform_device *pdev)
 	optee_unregister_devices();
 err_notif_uninit:
 	optee_notif_uninit(optee);
+err_close_ctx:
+	teedev_close_context(ctx);
 err_supp_uninit:
 	optee_supp_uninit(&optee->supp);
 	mutex_destroy(&optee->call_queue.mutex);
-- 
2.31.1

