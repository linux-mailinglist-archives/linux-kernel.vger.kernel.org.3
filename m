Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57C3F50F291
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 09:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344043AbiDZHg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 03:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241886AbiDZHgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 03:36:54 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D171331AE
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 00:33:46 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id p12so24829170lfs.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 00:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+fCZQDuoSrbrLFYuyEb7lQepn72Qtjbl9h9EqBbJS6Y=;
        b=jEKNHR7vmiFBmVYSwNBsirQuJDGj7/RNVVXjEtRPHRkL0OJJZdNrDnyh6vYKO3II7/
         ru2WdFscL/dR/zFUVzPrRMRM2ZdYKLYECBbr9fGDNnQ3NtklHsXcpfpeKwIQJy0BJQ3I
         G2U4NUGi1vQKUPnT+W+sw9tL0KfHX03HAGSNqUw0Lrpjxx/q9nsxS88Hmem3wYirJNSD
         gbY3YzlxHgn5+FLyS/ox1fGNbA2KbCFk1JgG2+6Nqp/FJ9yopH2Suq1ISV9m0BNZaJd8
         uhAxFjKf0EpNyALCcSzzg4VA69M5m7OlPTPIlacNt6ehFeODvMA78h3UgjKt+91M5m5T
         Uwwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+fCZQDuoSrbrLFYuyEb7lQepn72Qtjbl9h9EqBbJS6Y=;
        b=NkGqgdGqxELUku+9bOmdIdtZE+P8M6S5Bcmd1Inm6HD8+WWQojxzqBz/61/yWHQ+/2
         jCOMThMLSxP9QbMMBlZ3RL88IqU03FBIfYrFQL/JKWN9quOQ/fjJBNMho5bM4OS/P+du
         YJBIDHaFVOXaUtSnEzR3Y24Deow1X2spzCXrvoVz9Gz45aWS25KU3E+/zdc/f1U6Yzem
         lXh+zT0UlmVXyC2L16i50GI4m9S1E25Un4He8IrBn/HfgWCrO86rNUixvJ8ZnXFd/7zO
         L59nxmh3r7oVxbrb0uwNwkpR4S4mVDEfCtdRfBPvUJvusOFbcvkjgkOz2SG+CXTNPdE3
         L1mw==
X-Gm-Message-State: AOAM5302Eql31hReE4nekewLMdCRa1GZuahqWRjvlGLb6/twhwuyUPdn
        M+l7aMBSlisnWz98Y9pm5ExyVOyiTrckVQ==
X-Google-Smtp-Source: ABdhPJxKHYUhFVS4pT6TZXWousRtuRBSuvWzOv87TGIRMJdL9tYWakpiRulfCjILQjVzZ78saSsb7A==
X-Received: by 2002:a05:6512:2009:b0:471:ffee:6ee1 with SMTP id a9-20020a056512200900b00471ffee6ee1mr8371713lfb.268.1650958424182;
        Tue, 26 Apr 2022 00:33:44 -0700 (PDT)
Received: from jade.urgonet (h-79-136-84-253.A175.priv.bahnhof.se. [79.136.84.253])
        by smtp.gmail.com with ESMTPSA id s11-20020a2e9c0b000000b0024ace83744asm1430491lji.116.2022.04.26.00.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 00:33:43 -0700 (PDT)
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v4 2/4] optee: add OPTEE_SMC_CALL_WITH_RPC_ARG and OPTEE_SMC_CALL_WITH_REGD_ARG
Date:   Tue, 26 Apr 2022 09:33:36 +0200
Message-Id: <20220426073338.3048192-3-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220426073338.3048192-1-jens.wiklander@linaro.org>
References: <20220426073338.3048192-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds OPTEE_SMC_CALL_WITH_RPC_ARG and OPTEE_SMC_CALL_WITH_REGD_ARG where
the struct optee_msg_arg to be used for RPC is appended in the memory
following the normal argument struct optee_msg_arg. This is an
optimization to avoid caching the RPC argument struct while still
maintaining similar performance as if it was cached.

OPTEE_SMC_CALL_WITH_REGD_ARG optimized one step further by using a
registered shared memory object instead. It's in other aspects identical
to OPTEE_SMC_CALL_WITH_RPC_ARG.

The presence of OPTEE_SMC_CALL_WITH_RPC_ARG and
OPTEE_SMC_CALL_WITH_REGD_ARG is indicated by the new
OPTEE_SMC_SEC_CAP_RPC_ARG bit returned by
OPTEE_SMC_EXCHANGE_CAPABILITIES. OPTEE_SMC_EXCHANGE_CAPABILITIES also
reports the number of arguments that the RPC argument struct must have
room for.

OPTEE_SMC_CALL_WITH_RPC_ARG and OPTEE_SMC_CALL_WITH_ARG can be used
interleaved with difference that when OPTEE_SMC_CALL_WITH_RPC_ARG is
used the RPC argument struct to be used is the one appended to the
normal argument struct. The same is true for
OPTEE_SMC_CALL_WITH_REGD_ARG.

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/tee/optee/call.c      |  2 +-
 drivers/tee/optee/optee_smc.h | 48 ++++++++++++++---
 drivers/tee/optee/smc_abi.c   | 99 ++++++++++++++++++++++++++---------
 3 files changed, 117 insertions(+), 32 deletions(-)

diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
index a9a237d20c61..58ac15c02818 100644
--- a/drivers/tee/optee/call.c
+++ b/drivers/tee/optee/call.c
@@ -130,7 +130,7 @@ struct tee_shm *optee_get_msg_arg(struct tee_context *ctx, size_t num_params,
 		return (void *)ma;
 	}
 
-	memset(ma, 0, OPTEE_MSG_GET_ARG_SIZE(num_params));
+	memset(ma, 0, sz);
 	ma->num_params = num_params;
 	*msg_arg = ma;
 
diff --git a/drivers/tee/optee/optee_smc.h b/drivers/tee/optee/optee_smc.h
index d44a6ae994f8..c60896cf71cb 100644
--- a/drivers/tee/optee/optee_smc.h
+++ b/drivers/tee/optee/optee_smc.h
@@ -107,14 +107,22 @@ struct optee_smc_call_get_os_revision_result {
 /*
  * Call with struct optee_msg_arg as argument
  *
- * When calling this function normal world has a few responsibilities:
+ * When called with OPTEE_SMC_CALL_WITH_RPC_ARG or
+ * OPTEE_SMC_CALL_WITH_REGD_ARG in a0 there is one RPC struct optee_msg_arg
+ * following after the first struct optee_msg_arg. The RPC struct
+ * optee_msg_arg has reserved space for the number of RPC parameters as
+ * returned by OPTEE_SMC_EXCHANGE_CAPABILITIES.
+ *
+ * When calling these functions, normal world has a few responsibilities:
  * 1. It must be able to handle eventual RPCs
  * 2. Non-secure interrupts should not be masked
  * 3. If asynchronous notifications has been negotiated successfully, then
- *    asynchronous notifications should be unmasked during this call.
+ *    the interrupt for asynchronous notifications should be unmasked
+ *    during this call.
  *
- * Call register usage:
- * a0	SMC Function ID, OPTEE_SMC*CALL_WITH_ARG
+ * Call register usage, OPTEE_SMC_CALL_WITH_ARG and
+ * OPTEE_SMC_CALL_WITH_RPC_ARG:
+ * a0	SMC Function ID, OPTEE_SMC_CALL_WITH_ARG or OPTEE_SMC_CALL_WITH_RPC_ARG
  * a1	Upper 32 bits of a 64-bit physical pointer to a struct optee_msg_arg
  * a2	Lower 32 bits of a 64-bit physical pointer to a struct optee_msg_arg
  * a3	Cache settings, not used if physical pointer is in a predefined shared
@@ -122,6 +130,15 @@ struct optee_smc_call_get_os_revision_result {
  * a4-6	Not used
  * a7	Hypervisor Client ID register
  *
+ * Call register usage, OPTEE_SMC_CALL_WITH_REGD_ARG:
+ * a0	SMC Function ID, OPTEE_SMC_CALL_WITH_REGD_ARG
+ * a1	Upper 32 bits of a 64-bit shared memory cookie
+ * a2	Lower 32 bits of a 64-bit shared memory cookie
+ * a3	Offset of the struct optee_msg_arg in the shared memory with the
+ *	supplied cookie
+ * a4-6	Not used
+ * a7	Hypervisor Client ID register
+ *
  * Normal return register usage:
  * a0	Return value, OPTEE_SMC_RETURN_*
  * a1-3	Not used
@@ -154,6 +171,10 @@ struct optee_smc_call_get_os_revision_result {
 #define OPTEE_SMC_FUNCID_CALL_WITH_ARG OPTEE_MSG_FUNCID_CALL_WITH_ARG
 #define OPTEE_SMC_CALL_WITH_ARG \
 	OPTEE_SMC_STD_CALL_VAL(OPTEE_SMC_FUNCID_CALL_WITH_ARG)
+#define OPTEE_SMC_CALL_WITH_RPC_ARG \
+	OPTEE_SMC_STD_CALL_VAL(OPTEE_SMC_FUNCID_CALL_WITH_RPC_ARG)
+#define OPTEE_SMC_CALL_WITH_REGD_ARG \
+	OPTEE_SMC_STD_CALL_VAL(OPTEE_SMC_FUNCID_CALL_WITH_REGD_ARG)
 
 /*
  * Get Shared Memory Config
@@ -202,7 +223,11 @@ struct optee_smc_get_shm_config_result {
  * a0	OPTEE_SMC_RETURN_OK
  * a1	bitfield of secure world capabilities OPTEE_SMC_SEC_CAP_*
  * a2	The maximum secure world notification number
- * a3-7	Preserved
+ * a3	Bit[7:0]: Number of parameters needed for RPC to be supplied
+ *		  as the second MSG arg struct for
+ *		  OPTEE_SMC_CALL_WITH_ARG
+ *	Bit[31:8]: Reserved (MBZ)
+ * a4-7	Preserved
  *
  * Error return register usage:
  * a0	OPTEE_SMC_RETURN_ENOTAVAIL, can't use the capabilities from normal world
@@ -227,6 +252,8 @@ struct optee_smc_get_shm_config_result {
 #define OPTEE_SMC_SEC_CAP_MEMREF_NULL		BIT(4)
 /* Secure world supports asynchronous notification of normal world */
 #define OPTEE_SMC_SEC_CAP_ASYNC_NOTIF		BIT(5)
+/* Secure world supports pre-allocating RPC arg struct */
+#define OPTEE_SMC_SEC_CAP_RPC_ARG		BIT(6)
 
 #define OPTEE_SMC_FUNCID_EXCHANGE_CAPABILITIES	9
 #define OPTEE_SMC_EXCHANGE_CAPABILITIES \
@@ -236,7 +263,7 @@ struct optee_smc_exchange_capabilities_result {
 	unsigned long status;
 	unsigned long capabilities;
 	unsigned long max_notif_value;
-	unsigned long reserved0;
+	unsigned long data;
 };
 
 /*
@@ -358,6 +385,9 @@ struct optee_smc_disable_shm_cache_result {
  * should be called until all pended values have been retrieved. When a
  * value is retrieved, it's cleared from the record in secure world.
  *
+ * It is expected that this function is called from an interrupt handler
+ * in normal world.
+ *
  * Call requests usage:
  * a0	SMC Function ID, OPTEE_SMC_GET_ASYNC_NOTIF_VALUE
  * a1-6	Not used
@@ -390,6 +420,12 @@ struct optee_smc_disable_shm_cache_result {
 #define OPTEE_SMC_GET_ASYNC_NOTIF_VALUE \
 	OPTEE_SMC_FAST_CALL_VAL(OPTEE_SMC_FUNCID_GET_ASYNC_NOTIF_VALUE)
 
+/* See OPTEE_SMC_CALL_WITH_RPC_ARG above */
+#define OPTEE_SMC_FUNCID_CALL_WITH_RPC_ARG	18
+
+/* See OPTEE_SMC_CALL_WITH_REGD_ARG above */
+#define OPTEE_SMC_FUNCID_CALL_WITH_REGD_ARG	19
+
 /*
  * Resume from RPC (for example after processing a foreign interrupt)
  *
diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
index 67b7f7d2ff27..b258d7306042 100644
--- a/drivers/tee/optee/smc_abi.c
+++ b/drivers/tee/optee/smc_abi.c
@@ -732,16 +732,9 @@ static void optee_rpc_finalize_call(struct optee_call_ctx *call_ctx)
 }
 
 static void handle_rpc_func_cmd(struct tee_context *ctx, struct optee *optee,
-				struct tee_shm *shm,
+				struct optee_msg_arg *arg,
 				struct optee_call_ctx *call_ctx)
 {
-	struct optee_msg_arg *arg;
-
-	arg = tee_shm_get_va(shm, 0);
-	if (IS_ERR(arg)) {
-		pr_err("%s: tee_shm_get_va %p failed\n", __func__, shm);
-		return;
-	}
 
 	switch (arg->cmd) {
 	case OPTEE_RPC_CMD_SHM_ALLOC:
@@ -765,11 +758,13 @@ static void handle_rpc_func_cmd(struct tee_context *ctx, struct optee *optee,
  * Result of RPC is written back into @param.
  */
 static void optee_handle_rpc(struct tee_context *ctx,
+			     struct optee_msg_arg *rpc_arg,
 			     struct optee_rpc_param *param,
 			     struct optee_call_ctx *call_ctx)
 {
 	struct tee_device *teedev = ctx->teedev;
 	struct optee *optee = tee_get_drvdata(teedev);
+	struct optee_msg_arg *arg;
 	struct tee_shm *shm;
 	phys_addr_t pa;
 
@@ -801,8 +796,19 @@ static void optee_handle_rpc(struct tee_context *ctx,
 		 */
 		break;
 	case OPTEE_SMC_RPC_FUNC_CMD:
-		shm = reg_pair_to_ptr(param->a1, param->a2);
-		handle_rpc_func_cmd(ctx, optee, shm, call_ctx);
+		if (rpc_arg) {
+			arg = rpc_arg;
+		} else {
+			shm = reg_pair_to_ptr(param->a1, param->a2);
+			arg = tee_shm_get_va(shm, 0);
+			if (IS_ERR(arg)) {
+				pr_err("%s: tee_shm_get_va %p failed\n",
+				       __func__, shm);
+				break;
+			}
+		}
+
+		handle_rpc_func_cmd(ctx, optee, arg, call_ctx);
 		break;
 	default:
 		pr_warn("Unknown RPC func 0x%x\n",
@@ -816,7 +822,7 @@ static void optee_handle_rpc(struct tee_context *ctx,
 /**
  * optee_smc_do_call_with_arg() - Do an SMC to OP-TEE in secure world
  * @ctx:	calling context
- * @arg:	shared memory holding the message to pass to secure world
+ * @shm:	shared memory holding the message to pass to secure world
  *
  * Does and SMC to OP-TEE in secure world and handles eventual resulting
  * Remote Procedure Calls (RPC) from OP-TEE.
@@ -824,21 +830,46 @@ static void optee_handle_rpc(struct tee_context *ctx,
  * Returns return code from secure world, 0 is OK
  */
 static int optee_smc_do_call_with_arg(struct tee_context *ctx,
-				      struct tee_shm *arg)
+				      struct tee_shm *shm)
 {
 	struct optee *optee = tee_get_drvdata(ctx->teedev);
 	struct optee_call_waiter w;
 	struct optee_rpc_param param = { };
 	struct optee_call_ctx call_ctx = { };
-	phys_addr_t parg;
+	struct optee_msg_arg *rpc_arg = NULL;
 	int rc;
 
-	rc = tee_shm_get_pa(arg, 0, &parg);
-	if (rc)
-		return rc;
+	if (optee->rpc_param_count) {
+		struct optee_msg_arg *arg;
+		unsigned int rpc_arg_offs;
+
+		arg = tee_shm_get_va(shm, 0);
+		if (IS_ERR(arg))
+			return PTR_ERR(arg);
 
-	param.a0 = OPTEE_SMC_CALL_WITH_ARG;
-	reg_pair_from_64(&param.a1, &param.a2, parg);
+		rpc_arg_offs = OPTEE_MSG_GET_ARG_SIZE(arg->num_params);
+		rpc_arg = tee_shm_get_va(shm, rpc_arg_offs);
+		if (IS_ERR(arg))
+			return PTR_ERR(arg);
+	}
+
+	if  (rpc_arg && tee_shm_is_dynamic(shm)) {
+		param.a0 = OPTEE_SMC_CALL_WITH_REGD_ARG;
+		reg_pair_from_64(&param.a1, &param.a2, (u_long)shm);
+		param.a3 = 0;
+	} else {
+		phys_addr_t parg;
+
+		rc = tee_shm_get_pa(shm, 0, &parg);
+		if (rc)
+			return rc;
+
+		if (rpc_arg)
+			param.a0 = OPTEE_SMC_CALL_WITH_RPC_ARG;
+		else
+			param.a0 = OPTEE_SMC_CALL_WITH_ARG;
+		reg_pair_from_64(&param.a1, &param.a2, parg);
+	}
 	/* Initialize waiter */
 	optee_cq_wait_init(&optee->call_queue, &w);
 	while (true) {
@@ -862,7 +893,7 @@ static int optee_smc_do_call_with_arg(struct tee_context *ctx,
 			param.a1 = res.a1;
 			param.a2 = res.a2;
 			param.a3 = res.a3;
-			optee_handle_rpc(ctx, &param, &call_ctx);
+			optee_handle_rpc(ctx, rpc_arg, &param, &call_ctx);
 		} else {
 			rc = res.a0;
 			break;
@@ -1118,7 +1149,8 @@ static bool optee_msg_api_revision_is_compatible(optee_invoke_fn *invoke_fn)
 }
 
 static bool optee_msg_exchange_capabilities(optee_invoke_fn *invoke_fn,
-					    u32 *sec_caps, u32 *max_notif_value)
+					    u32 *sec_caps, u32 *max_notif_value,
+					    unsigned int *rpc_param_count)
 {
 	union {
 		struct arm_smccc_res smccc;
@@ -1145,6 +1177,10 @@ static bool optee_msg_exchange_capabilities(optee_invoke_fn *invoke_fn,
 		*max_notif_value = res.result.max_notif_value;
 	else
 		*max_notif_value = OPTEE_DEFAULT_MAX_NOTIF_VALUE;
+	if (*sec_caps & OPTEE_SMC_SEC_CAP_RPC_ARG)
+		*rpc_param_count = (u8)res.result.data;
+	else
+		*rpc_param_count = 0;
 
 	return true;
 }
@@ -1251,7 +1287,8 @@ static int optee_smc_remove(struct platform_device *pdev)
 	 * reference counters and also avoid wild pointers in secure world
 	 * into the old shared memory range.
 	 */
-	optee_disable_shm_cache(optee);
+	if (!optee->rpc_param_count)
+		optee_disable_shm_cache(optee);
 
 	optee_smc_notif_uninit_irq(optee);
 
@@ -1274,7 +1311,10 @@ static int optee_smc_remove(struct platform_device *pdev)
  */
 static void optee_shutdown(struct platform_device *pdev)
 {
-	optee_disable_shm_cache(platform_get_drvdata(pdev));
+	struct optee *optee = platform_get_drvdata(pdev);
+
+	if (!optee->rpc_param_count)
+		optee_disable_shm_cache(optee);
 }
 
 static int optee_probe(struct platform_device *pdev)
@@ -1283,6 +1323,7 @@ static int optee_probe(struct platform_device *pdev)
 	struct tee_shm_pool *pool = ERR_PTR(-EINVAL);
 	struct optee *optee = NULL;
 	void *memremaped_shm = NULL;
+	unsigned int rpc_param_count;
 	struct tee_device *teedev;
 	struct tee_context *ctx;
 	u32 max_notif_value;
@@ -1306,7 +1347,8 @@ static int optee_probe(struct platform_device *pdev)
 	}
 
 	if (!optee_msg_exchange_capabilities(invoke_fn, &sec_caps,
-					     &max_notif_value)) {
+					     &max_notif_value,
+					     &rpc_param_count)) {
 		pr_warn("capabilities mismatch\n");
 		return -EINVAL;
 	}
@@ -1335,6 +1377,7 @@ static int optee_probe(struct platform_device *pdev)
 	optee->ops = &optee_ops;
 	optee->smc.invoke_fn = invoke_fn;
 	optee->smc.sec_caps = sec_caps;
+	optee->rpc_param_count = rpc_param_count;
 
 	teedev = tee_device_alloc(&optee_clnt_desc, NULL, pool, optee);
 	if (IS_ERR(teedev)) {
@@ -1403,7 +1446,12 @@ static int optee_probe(struct platform_device *pdev)
 	 */
 	optee_disable_unmapped_shm_cache(optee);
 
-	optee_enable_shm_cache(optee);
+	/*
+	 * Only enable the shm cache in case we're not able to pass the RPC
+	 * arg struct right after the normal arg struct.
+	 */
+	if (!optee->rpc_param_count)
+		optee_enable_shm_cache(optee);
 
 	if (optee->smc.sec_caps & OPTEE_SMC_SEC_CAP_DYNAMIC_SHM)
 		pr_info("dynamic shared memory is enabled\n");
@@ -1416,7 +1464,8 @@ static int optee_probe(struct platform_device *pdev)
 	return 0;
 
 err_disable_shm_cache:
-	optee_disable_shm_cache(optee);
+	if (!optee->rpc_param_count)
+		optee_disable_shm_cache(optee);
 	optee_smc_notif_uninit_irq(optee);
 	optee_unregister_devices();
 err_notif_uninit:
-- 
2.31.1

