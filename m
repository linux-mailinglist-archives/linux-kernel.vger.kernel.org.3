Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19C914C9503
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 20:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237536AbiCATuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 14:50:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237518AbiCATuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 14:50:19 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B89566E35E
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 11:49:03 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id v22so23315160ljh.7
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 11:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5ZTkOyMLms/ROPTGu0QbSrq/G06AbPJv9b21W4WeRMA=;
        b=Nh+ns6ib95fG1u417E/6LmWMzhoKvCNdeQLzHprOIIKGCy7bCfiTrUj0MXzMJ/rRHB
         z23qUYxM+kNZjdL+31s8JOYJHRFtQYTK0WbUzEZD9DG+Dj+6E8joCMssNpoSBwjP1Jk8
         CfAXqnlKEDu1NYtYWP3ZrYDV87BLUE1lxlMdc7g9ZJgWunfeVlVE5Nb2Vsxncvy6l2xM
         Wb+MB3AdcfaE/mWSWHVu2og1YIHgd7gDo1sIMCvLvaUIKXaR0/Ms3aEgcX7a+SEwtY0x
         EVRjPp27tynyQeWennnl1pcEdCj4cmVlrm9bUJLggs6Th5qCWR+7KrUQRQJ9ydNbSUkQ
         Lf/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5ZTkOyMLms/ROPTGu0QbSrq/G06AbPJv9b21W4WeRMA=;
        b=Fj/X5/YxHLeHcRop/9eNIA2meO+ret5SY67na88JkeAR7jLJM1syRhm72FWJQoh1GN
         WHcwlygcXnCt04z5ZYYu/A40PV14T8Le/sNN6+vmaxf8+H80M4HLjPl9lp8+Ms5b1yw6
         TirhkSmv6o1Wj4M5f4fBWWp1cQWs0YLpFdHr1HcJ6JSnfUXw5PvSzccHTdFQeNlaWFFo
         +mq2Alzv7jUcgef0a20lg8p389zMpHd6TN7jDzIx4c/l4kb2SKgsjObqh7Rfms9L8CfS
         s1NSCLXZ5R6rh6S7KACrpHv1G6A8tZ7qpBdec+PWEhA8+gUH9bdk9pBW1AhkYHdD9/52
         bYRw==
X-Gm-Message-State: AOAM532R5Ctiqk+Ve2ExlZ4sKIjGIsQCzlthmwEs9dC2WPtTbqeptM4n
        NqRWX4/UVSdMxRwEs+U39HcJpD9o0kEHQQ==
X-Google-Smtp-Source: ABdhPJzkdEfll6gDIGq/PGQMes+rLmk8ic4dNzEErBCobIdRdMBzrFZbWIRJnkDQ371Kq88XCPMJTQ==
X-Received: by 2002:a2e:8e6f:0:b0:246:4306:e412 with SMTP id t15-20020a2e8e6f000000b002464306e412mr18292977ljk.8.1646164114668;
        Tue, 01 Mar 2022 11:48:34 -0800 (PST)
Received: from jade.urgonet (h-176-10-238-36.A175.priv.bahnhof.se. [176.10.238.36])
        by smtp.gmail.com with ESMTPSA id m2-20020a196142000000b00443d65ea163sm1635891lfk.248.2022.03.01.11.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 11:48:34 -0800 (PST)
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH 1/3] optee: add OPTEE_SMC_CALL_WITH_RPC_ARG
Date:   Tue,  1 Mar 2022 20:48:28 +0100
Message-Id: <20220301194830.3557578-2-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220301194830.3557578-1-jens.wiklander@linaro.org>
References: <20220301194830.3557578-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds OPTEE_SMC_CALL_WITH_RPC_ARG where the struct optee_msg_arg to be
used for RPC is appended in the memory following the normal argument
struct optee_msg_arg. This is an optimization to avoid caching the RPC
argument struct while still maintaining similar performance as if it
was cached.

The presence OPTEE_SMC_CALL_WITH_RPC_ARG is indicated by the new
OPTEE_SMC_SEC_CAP_RPC_ARG bit returned by
OPTEE_SMC_EXCHANGE_CAPABILITIES. OPTEE_SMC_EXCHANGE_CAPABILITIES also
reports the number of arguments that the RPC argument struct must have
room for.

OPTEE_SMC_CALL_WITH_RPC_ARG and OPTEE_SMC_CALL_WITH_ARG can be used
interleaved with difference that when OPTEE_SMC_CALL_WITH_RPC_ARG is
used the RPC argument struct to be used is the one appended to the
normal argument struct.

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/tee/optee/call.c          |  6 +--
 drivers/tee/optee/ffa_abi.c       | 10 ++--
 drivers/tee/optee/optee_private.h |  4 +-
 drivers/tee/optee/optee_smc.h     | 47 ++++++++++++++---
 drivers/tee/optee/smc_abi.c       | 88 +++++++++++++++++++++++--------
 5 files changed, 117 insertions(+), 38 deletions(-)

diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
index bd49ec934060..82d836df6922 100644
--- a/drivers/tee/optee/call.c
+++ b/drivers/tee/optee/call.c
@@ -117,8 +117,8 @@ struct tee_shm *optee_get_msg_arg(struct tee_context *ctx, size_t num_params,
 	 * the RPC argument struct if a second MSG arg struct is expected.
 	 * The second arg struct will then be used for RPC.
 	 */
-	if (optee->rpc_arg_count)
-		sz += OPTEE_MSG_GET_ARG_SIZE(optee->rpc_arg_count);
+	if (optee->rpc_param_count)
+		sz += OPTEE_MSG_GET_ARG_SIZE(optee->rpc_param_count);
 
 	shm = tee_shm_alloc_priv_buf(ctx, sz);
 	if (IS_ERR(shm))
@@ -130,7 +130,7 @@ struct tee_shm *optee_get_msg_arg(struct tee_context *ctx, size_t num_params,
 		return (void *)ma;
 	}
 
-	memset(ma, 0, OPTEE_MSG_GET_ARG_SIZE(num_params));
+	memset(ma, 0, sz);
 	ma->num_params = num_params;
 	*msg_arg = ma;
 
diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
index a5eb4ef46971..7686f7020616 100644
--- a/drivers/tee/optee/ffa_abi.c
+++ b/drivers/tee/optee/ffa_abi.c
@@ -678,7 +678,7 @@ static bool optee_ffa_api_is_compatbile(struct ffa_device *ffa_dev,
 
 static bool optee_ffa_exchange_caps(struct ffa_device *ffa_dev,
 				    const struct ffa_dev_ops *ops,
-				    unsigned int *rpc_arg_count)
+				    unsigned int *rpc_param_count)
 {
 	struct ffa_send_direct_data data = { OPTEE_FFA_EXCHANGE_CAPABILITIES };
 	int rc;
@@ -693,7 +693,7 @@ static bool optee_ffa_exchange_caps(struct ffa_device *ffa_dev,
 		return false;
 	}
 
-	*rpc_arg_count = (u8)data.data1;
+	*rpc_param_count = (u8)data.data1;
 
 	return true;
 }
@@ -772,7 +772,7 @@ static void optee_ffa_remove(struct ffa_device *ffa_dev)
 static int optee_ffa_probe(struct ffa_device *ffa_dev)
 {
 	const struct ffa_dev_ops *ffa_ops;
-	unsigned int rpc_arg_count;
+	unsigned int rpc_param_count;
 	struct tee_shm_pool *pool;
 	struct tee_device *teedev;
 	struct tee_context *ctx;
@@ -788,7 +788,7 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
 	if (!optee_ffa_api_is_compatbile(ffa_dev, ffa_ops))
 		return -EINVAL;
 
-	if (!optee_ffa_exchange_caps(ffa_dev, ffa_ops, &rpc_arg_count))
+	if (!optee_ffa_exchange_caps(ffa_dev, ffa_ops, &rpc_param_count))
 		return -EINVAL;
 
 	optee = kzalloc(sizeof(*optee), GFP_KERNEL);
@@ -805,7 +805,7 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
 	optee->ops = &optee_ffa_ops;
 	optee->ffa.ffa_dev = ffa_dev;
 	optee->ffa.ffa_ops = ffa_ops;
-	optee->rpc_arg_count = rpc_arg_count;
+	optee->rpc_param_count = rpc_param_count;
 
 	teedev = tee_device_alloc(&optee_ffa_clnt_desc, NULL, optee->pool,
 				  optee);
diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
index e77765c78878..e80c5d9b62ec 100644
--- a/drivers/tee/optee/optee_private.h
+++ b/drivers/tee/optee/optee_private.h
@@ -143,7 +143,7 @@ struct optee_ops {
  * @notif:		notification synchronization struct
  * @supp:		supplicant synchronization struct for RPC to supplicant
  * @pool:		shared memory pool
- * @rpc_arg_count:	If > 0 number of RPC parameters to make room for
+ * @rpc_param_count:	If > 0 number of RPC parameters to make room for
  * @scan_bus_done	flag if device registation was already done.
  * @scan_bus_wq		workqueue to scan optee bus and register optee drivers
  * @scan_bus_work	workq to scan optee bus and register optee drivers
@@ -161,7 +161,7 @@ struct optee {
 	struct optee_notif notif;
 	struct optee_supp supp;
 	struct tee_shm_pool *pool;
-	unsigned int rpc_arg_count;
+	unsigned int rpc_param_count;
 	bool   scan_bus_done;
 	struct workqueue_struct *scan_bus_wq;
 	struct work_struct scan_bus_work;
diff --git a/drivers/tee/optee/optee_smc.h b/drivers/tee/optee/optee_smc.h
index d44a6ae994f8..378741a459b6 100644
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
+ * When calling these functions normal world has a few responsibilities:
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
@@ -202,6 +223,10 @@ struct optee_smc_get_shm_config_result {
  * a0	OPTEE_SMC_RETURN_OK
  * a1	bitfield of secure world capabilities OPTEE_SMC_SEC_CAP_*
  * a2	The maximum secure world notification number
+ * a3	Bit[7:0]: Number of parameters needed for RPC to be supplied
+ *		  as the second MSG arg struct for
+ *		  OPTEE_SMC_CALL_WITH_ARG
+ *	Bit[31:8]: Reserved (MBZ)
  * a3-7	Preserved
  *
  * Error return register usage:
@@ -215,7 +240,6 @@ struct optee_smc_get_shm_config_result {
 #define OPTEE_SMC_SEC_CAP_HAVE_RESERVED_SHM	BIT(0)
 /* Secure world can communicate via previously unregistered shared memory */
 #define OPTEE_SMC_SEC_CAP_UNREGISTERED_SHM	BIT(1)
-
 /*
  * Secure world supports commands "register/unregister shared memory",
  * secure world accepts command buffers located in any parts of non-secure RAM
@@ -227,6 +251,8 @@ struct optee_smc_get_shm_config_result {
 #define OPTEE_SMC_SEC_CAP_MEMREF_NULL		BIT(4)
 /* Secure world supports asynchronous notification of normal world */
 #define OPTEE_SMC_SEC_CAP_ASYNC_NOTIF		BIT(5)
+/* Secure world supports pre-allocating RPC arg struct */
+#define OPTEE_SMC_SEC_CAP_RPC_ARG		BIT(6)
 
 #define OPTEE_SMC_FUNCID_EXCHANGE_CAPABILITIES	9
 #define OPTEE_SMC_EXCHANGE_CAPABILITIES \
@@ -236,7 +262,7 @@ struct optee_smc_exchange_capabilities_result {
 	unsigned long status;
 	unsigned long capabilities;
 	unsigned long max_notif_value;
-	unsigned long reserved0;
+	unsigned long data;
 };
 
 /*
@@ -358,6 +384,9 @@ struct optee_smc_disable_shm_cache_result {
  * should be called until all pended values have been retrieved. When a
  * value is retrieved, it's cleared from the record in secure world.
  *
+ * It is expected that this function is called from an interrupt handler
+ * in normal world.
+ *
  * Call requests usage:
  * a0	SMC Function ID, OPTEE_SMC_GET_ASYNC_NOTIF_VALUE
  * a1-6	Not used
@@ -390,6 +419,12 @@ struct optee_smc_disable_shm_cache_result {
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
index 67b7f7d2ff27..c45cc9b7e5a7 100644
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
 
-	param.a0 = OPTEE_SMC_CALL_WITH_ARG;
-	reg_pair_from_64(&param.a1, &param.a2, parg);
+		arg = tee_shm_get_va(shm, 0);
+		if (IS_ERR(arg))
+			return PTR_ERR(arg);
+
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
@@ -1283,6 +1319,7 @@ static int optee_probe(struct platform_device *pdev)
 	struct tee_shm_pool *pool = ERR_PTR(-EINVAL);
 	struct optee *optee = NULL;
 	void *memremaped_shm = NULL;
+	unsigned int rpc_param_count;
 	struct tee_device *teedev;
 	struct tee_context *ctx;
 	u32 max_notif_value;
@@ -1306,7 +1343,8 @@ static int optee_probe(struct platform_device *pdev)
 	}
 
 	if (!optee_msg_exchange_capabilities(invoke_fn, &sec_caps,
-					     &max_notif_value)) {
+					     &max_notif_value,
+					     &rpc_param_count)) {
 		pr_warn("capabilities mismatch\n");
 		return -EINVAL;
 	}
@@ -1335,6 +1373,7 @@ static int optee_probe(struct platform_device *pdev)
 	optee->ops = &optee_ops;
 	optee->smc.invoke_fn = invoke_fn;
 	optee->smc.sec_caps = sec_caps;
+	optee->rpc_param_count = rpc_param_count;
 
 	teedev = tee_device_alloc(&optee_clnt_desc, NULL, pool, optee);
 	if (IS_ERR(teedev)) {
@@ -1403,7 +1442,12 @@ static int optee_probe(struct platform_device *pdev)
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
-- 
2.31.1

