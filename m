Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C36C04E272D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 14:04:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347727AbiCUNFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 09:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347707AbiCUNFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 09:05:24 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAFC4369D6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 06:03:57 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id p15so13747443lfk.8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 06:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7ft3nnxTLFrRTX3OTENxGqi4vuQTbBxIi+yunJ7SLO0=;
        b=Tq+aKNZNH58QJASyIjywktiZZjFpy/zh5P4Jm0KstLiMt3a9JMV5H0IF1qcZg1ohbR
         YrK4tObO7n7bgaU81od/CumtNKyWy4JbryydXCN/O2h+cddHQv0MrN7gPanL70prsq2W
         rtmsDppcwbYGfWBFvV1XVr3cdw54OdhkmKZk/q4OL4ZoBMIaCUpeTK6PUxayYmpP+9P0
         QA1p+2MUqlTc0RR8qv/QOWWxCGOhVVF/RSgkfBNJf8m7m1V/Z70/yQiv8JamCTRSVQUR
         zuwNOjy4Cu078XF0RygxgMv8Gw1yrH4NdGVJi6ZQAm/iMxXd8RIKGjSqcGHnL+F40obV
         oBhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7ft3nnxTLFrRTX3OTENxGqi4vuQTbBxIi+yunJ7SLO0=;
        b=dscvRoztuirwN9wSNduSRw9OGkTve7sQH6EU7v9XbfpnkhQoG43gp1E65RjbqQ8XE0
         L+3Ri6bpsYitRKpLjQKCfFh3pJAjWmkoYqXQvMtTatx8qUNFSoHtmh6my5AafVvztM6Y
         /cq0aJsbFgp6y7+ums38Emx5Nh1QkoWf9WA+IYKVEERTQvCzSmefdHjHHs4ONNnEAqOa
         WfvolIV9GQB6bMo/2lTrxpfpqfBsZ4iqc3iLH5gb2tZD0nCwPDVDuM8gz0GYKk7+y1rF
         mLPUVzsSdCR6DpJKBxhqu995K0VW3s4Zs/WNSu6cPdUkptGasggbH5ttTVN3qkJqleVL
         OzlA==
X-Gm-Message-State: AOAM530dErSyhp51G7aDlhCBoD7UVNLbaAVYiN4z29BaZObzfvaDQDP+
        ueXt0GL5RtCXGJ5Ge0rL+r14bdQgAL5MCA==
X-Google-Smtp-Source: ABdhPJyEguiEnrgxET5JS76FAIy7r6hbhJohoJWosQSzm/kVoWfuoSlqrtzYNsHXch0+BSWO90m4iA==
X-Received: by 2002:a05:6512:10c1:b0:448:3070:7071 with SMTP id k1-20020a05651210c100b0044830707071mr14947486lfg.264.1647867835404;
        Mon, 21 Mar 2022 06:03:55 -0700 (PDT)
Received: from jade.urgonet (h-79-136-84-253.A175.priv.bahnhof.se. [79.136.84.253])
        by smtp.gmail.com with ESMTPSA id t27-20020a2e8e7b000000b00247f32b572asm2067738ljk.19.2022.03.21.06.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 06:03:54 -0700 (PDT)
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v2 4/4] optee: cache argument shared memory structs
Date:   Mon, 21 Mar 2022 14:03:41 +0100
Message-Id: <20220321130341.935535-5-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220321130341.935535-1-jens.wiklander@linaro.org>
References: <20220321130341.935535-1-jens.wiklander@linaro.org>
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

Implements a cache to handle shared memory used to pass the argument
struct needed when doing a normal yielding call into secure world.

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/tee/optee/call.c          | 236 ++++++++++++++++++++++++------
 drivers/tee/optee/core.c          |   1 +
 drivers/tee/optee/ffa_abi.c       |  13 +-
 drivers/tee/optee/optee_private.h |  27 +++-
 drivers/tee/optee/smc_abi.c       |  73 +++++++--
 5 files changed, 285 insertions(+), 65 deletions(-)

diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
index 58ac15c02818..608d5f4241de 100644
--- a/drivers/tee/optee/call.c
+++ b/drivers/tee/optee/call.c
@@ -11,6 +11,34 @@
 #include <linux/types.h>
 #include "optee_private.h"
 
+#define MAX_ARG_PARAM_COUNT	6
+
+/*
+ * How much memory we allocate for each entry. This doesn't have to be a
+ * single page, but it makes sense to keep at least keep it as multiples of
+ * the page size.
+ */
+#define SHM_ENTRY_SIZE		PAGE_SIZE
+
+/*
+ * We need to have a compile time constant to be able to determine the
+ * maximum needed size of the bit field.
+ */
+#define MIN_ARG_SIZE		OPTEE_MSG_GET_ARG_SIZE(MAX_ARG_PARAM_COUNT)
+#define MAX_ARG_COUNT_PER_ENTRY	(SHM_ENTRY_SIZE / MIN_ARG_SIZE)
+
+/*
+ * Shared memory for argument structs are cached here. The number of
+ * arguments structs that can fit is determined at runtime depending on the
+ * needed RPC parameter count reported by secure world
+ * (optee->rpc_param_count).
+ */
+struct optee_shm_arg_entry {
+	struct list_head list_node;
+	struct tee_shm *shm;
+	DECLARE_BITMAP(map, MAX_ARG_COUNT_PER_ENTRY);
+};
+
 void optee_cq_wait_init(struct optee_call_queue *cq,
 			struct optee_call_waiter *w)
 {
@@ -104,37 +132,149 @@ static struct optee_session *find_session(struct optee_context_data *ctxdata,
 	return NULL;
 }
 
-struct tee_shm *optee_get_msg_arg(struct tee_context *ctx, size_t num_params,
-				  struct optee_msg_arg **msg_arg)
+void optee_shm_arg_cache_init(struct optee *optee, u32 flags)
+{
+	INIT_LIST_HEAD(&optee->shm_arg_cache.shm_args);
+	mutex_init(&optee->shm_arg_cache.mutex);
+	optee->shm_arg_cache.flags = flags;
+}
+
+void optee_shm_arg_cache_uninit(struct optee *optee)
+{
+	struct list_head *head = &optee->shm_arg_cache.shm_args;
+	struct optee_shm_arg_entry *entry;
+
+	mutex_destroy(&optee->shm_arg_cache.mutex);
+	while (!list_empty(head)) {
+		entry = list_first_entry(head, struct optee_shm_arg_entry,
+					 list_node);
+		list_del(&entry->list_node);
+		if (find_first_bit(entry->map, MAX_ARG_COUNT_PER_ENTRY) !=
+		     MAX_ARG_COUNT_PER_ENTRY) {
+			pr_err("Freeing non-free entry\n");
+		}
+		tee_shm_free(entry->shm);
+		kfree(entry);
+	}
+}
+
+size_t optee_msg_arg_size(size_t rpc_param_count)
+{
+	size_t sz = OPTEE_MSG_GET_ARG_SIZE(MAX_ARG_PARAM_COUNT);
+
+	if (rpc_param_count)
+		sz += OPTEE_MSG_GET_ARG_SIZE(rpc_param_count);
+
+	return sz;
+}
+
+/**
+ * optee_get_msg_arg() - Provide shared memory for argument struct
+ * @ctx:	Caller TEE context
+ * @num_params:	Number of parameter to store
+ * @entry_ret:	Entry pointer, needed when freeing the buffer
+ * @shm_ret:	Shared memory buffer
+ * @offs_ret:	Offset of argument strut in shared memory buffer
+ *
+ * @returns a pointer to the argument struct in memory, else an ERR_PTR
+ */
+struct optee_msg_arg *optee_get_msg_arg(struct tee_context *ctx,
+					size_t num_params,
+					struct optee_shm_arg_entry **entry_ret,
+					struct tee_shm **shm_ret,
+					u_int *offs_ret)
 {
 	struct optee *optee = tee_get_drvdata(ctx->teedev);
-	size_t sz = OPTEE_MSG_GET_ARG_SIZE(num_params);
-	struct tee_shm *shm;
+	size_t sz = optee_msg_arg_size(optee->rpc_param_count);
+	struct optee_shm_arg_entry *entry;
 	struct optee_msg_arg *ma;
+	size_t args_per_entry;
+	u_long bit;
+	u_int offs;
+	void *res;
+
+	if (num_params > MAX_ARG_PARAM_COUNT)
+		return ERR_PTR(-EINVAL);
+
+	if (optee->shm_arg_cache.flags & OPTEE_SHM_ARG_SHARED)
+		args_per_entry = SHM_ENTRY_SIZE / sz;
+	else
+		args_per_entry = 1;
+
+	mutex_lock(&optee->shm_arg_cache.mutex);
+	list_for_each_entry(entry, &optee->shm_arg_cache.shm_args, list_node) {
+		bit = find_first_zero_bit(entry->map, MAX_ARG_COUNT_PER_ENTRY);
+		if (bit < args_per_entry)
+			goto have_entry;
+	}
 
 	/*
-	 * rpc_param_count is set to the number of allocated parameters in
-	 * the RPC argument struct if a second MSG arg struct is expected.
-	 * The second arg struct will then be used for RPC.
+	 * No entry was found, let's allocate a new.
 	 */
-	if (optee->rpc_param_count)
-		sz += OPTEE_MSG_GET_ARG_SIZE(optee->rpc_param_count);
+	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
+	if (!entry) {
+		res = ERR_PTR(-ENOMEM);
+		goto out;
+	}
 
-	shm = tee_shm_alloc_priv_buf(ctx, sz);
-	if (IS_ERR(shm))
-		return shm;
+	if (optee->shm_arg_cache.flags & OPTEE_SHM_ARG_ALLOC_PRIV)
+		res = tee_shm_alloc_priv_buf(ctx, SHM_ENTRY_SIZE);
+	else
+		res = tee_shm_alloc_kernel_buf(ctx, SHM_ENTRY_SIZE);
 
-	ma = tee_shm_get_va(shm, 0);
-	if (IS_ERR(ma)) {
-		tee_shm_free(shm);
-		return (void *)ma;
+	if (IS_ERR(res)) {
+		kfree(entry);
+		goto out;
 	}
-
+	entry->shm = res;
+	list_add(&entry->list_node, &optee->shm_arg_cache.shm_args);
+	bit = 0;
+
+have_entry:
+	offs = bit * sz;
+	res = tee_shm_get_va(entry->shm, offs);
+	if (IS_ERR(res))
+		goto out;
+	ma = res;
+	set_bit(bit, entry->map);
 	memset(ma, 0, sz);
 	ma->num_params = num_params;
-	*msg_arg = ma;
+	*entry_ret = entry;
+	*shm_ret = entry->shm;
+	*offs_ret = offs;
+out:
+	mutex_unlock(&optee->shm_arg_cache.mutex);
+	return res;
+}
+
+/**
+ * optee_free_msg_arg() - Free previsouly obtained shared memory
+ * @ctx:	Caller TEE context
+ * @entry:	Pointer returned when the shared memory was obtained
+ * @offs:	Offset of shared memory buffer to free
+ *
+ * This function frees the shared memory obtained with optee_get_msg_arg().
+ */
+void optee_free_msg_arg(struct tee_context *ctx,
+			struct optee_shm_arg_entry *entry, u_int offs)
+{
+	struct optee *optee = tee_get_drvdata(ctx->teedev);
+	size_t sz = optee_msg_arg_size(optee->rpc_param_count);
+	u_long bit;
 
-	return shm;
+	if (offs > SHM_ENTRY_SIZE || offs % sz) {
+		pr_err("Invalid offs %u\n", offs);
+		return;
+	}
+	bit = offs / sz;
+
+	mutex_lock(&optee->shm_arg_cache.mutex);
+
+	if (!test_bit(bit, entry->map))
+		pr_err("Bit pos %lu is already free\n", bit);
+	clear_bit(bit, entry->map);
+
+	mutex_unlock(&optee->shm_arg_cache.mutex);
 }
 
 int optee_open_session(struct tee_context *ctx,
@@ -143,16 +283,19 @@ int optee_open_session(struct tee_context *ctx,
 {
 	struct optee *optee = tee_get_drvdata(ctx->teedev);
 	struct optee_context_data *ctxdata = ctx->data;
-	int rc;
+	struct optee_shm_arg_entry *entry;
 	struct tee_shm *shm;
 	struct optee_msg_arg *msg_arg;
 	struct optee_session *sess = NULL;
 	uuid_t client_uuid;
+	u_int offs;
+	int rc;
 
 	/* +2 for the meta parameters added below */
-	shm = optee_get_msg_arg(ctx, arg->num_params + 2, &msg_arg);
-	if (IS_ERR(shm))
-		return PTR_ERR(shm);
+	msg_arg = optee_get_msg_arg(ctx, arg->num_params + 2,
+				    &entry, &shm, &offs);
+	if (IS_ERR(msg_arg))
+		return PTR_ERR(msg_arg);
 
 	msg_arg->cmd = OPTEE_MSG_CMD_OPEN_SESSION;
 	msg_arg->cancel_id = arg->cancel_id;
@@ -185,7 +328,7 @@ int optee_open_session(struct tee_context *ctx,
 		goto out;
 	}
 
-	if (optee->ops->do_call_with_arg(ctx, shm)) {
+	if (optee->ops->do_call_with_arg(ctx, shm, offs)) {
 		msg_arg->ret = TEEC_ERROR_COMMUNICATION;
 		msg_arg->ret_origin = TEEC_ORIGIN_COMMS;
 	}
@@ -212,26 +355,28 @@ int optee_open_session(struct tee_context *ctx,
 		arg->ret_origin = msg_arg->ret_origin;
 	}
 out:
-	tee_shm_free(shm);
+	optee_free_msg_arg(ctx, entry, offs);
 
 	return rc;
 }
 
 int optee_close_session_helper(struct tee_context *ctx, u32 session)
 {
-	struct tee_shm *shm;
 	struct optee *optee = tee_get_drvdata(ctx->teedev);
+	struct optee_shm_arg_entry *entry;
 	struct optee_msg_arg *msg_arg;
+	struct tee_shm *shm;
+	u_int offs;
 
-	shm = optee_get_msg_arg(ctx, 0, &msg_arg);
-	if (IS_ERR(shm))
-		return PTR_ERR(shm);
+	msg_arg = optee_get_msg_arg(ctx, 0, &entry, &shm, &offs);
+	if (IS_ERR(msg_arg))
+		return PTR_ERR(msg_arg);
 
 	msg_arg->cmd = OPTEE_MSG_CMD_CLOSE_SESSION;
 	msg_arg->session = session;
-	optee->ops->do_call_with_arg(ctx, shm);
+	optee->ops->do_call_with_arg(ctx, shm, offs);
 
-	tee_shm_free(shm);
+	optee_free_msg_arg(ctx, entry, offs);
 
 	return 0;
 }
@@ -259,9 +404,11 @@ int optee_invoke_func(struct tee_context *ctx, struct tee_ioctl_invoke_arg *arg,
 {
 	struct optee *optee = tee_get_drvdata(ctx->teedev);
 	struct optee_context_data *ctxdata = ctx->data;
-	struct tee_shm *shm;
+	struct optee_shm_arg_entry *entry;
 	struct optee_msg_arg *msg_arg;
 	struct optee_session *sess;
+	struct tee_shm *shm;
+	u_int offs;
 	int rc;
 
 	/* Check that the session is valid */
@@ -271,9 +418,10 @@ int optee_invoke_func(struct tee_context *ctx, struct tee_ioctl_invoke_arg *arg,
 	if (!sess)
 		return -EINVAL;
 
-	shm = optee_get_msg_arg(ctx, arg->num_params, &msg_arg);
-	if (IS_ERR(shm))
-		return PTR_ERR(shm);
+	msg_arg = optee_get_msg_arg(ctx, arg->num_params,
+				    &entry, &shm, &offs);
+	if (IS_ERR(msg_arg))
+		return PTR_ERR(msg_arg);
 	msg_arg->cmd = OPTEE_MSG_CMD_INVOKE_COMMAND;
 	msg_arg->func = arg->func;
 	msg_arg->session = arg->session;
@@ -284,7 +432,7 @@ int optee_invoke_func(struct tee_context *ctx, struct tee_ioctl_invoke_arg *arg,
 	if (rc)
 		goto out;
 
-	if (optee->ops->do_call_with_arg(ctx, shm)) {
+	if (optee->ops->do_call_with_arg(ctx, shm, offs)) {
 		msg_arg->ret = TEEC_ERROR_COMMUNICATION;
 		msg_arg->ret_origin = TEEC_ORIGIN_COMMS;
 	}
@@ -298,7 +446,7 @@ int optee_invoke_func(struct tee_context *ctx, struct tee_ioctl_invoke_arg *arg,
 	arg->ret = msg_arg->ret;
 	arg->ret_origin = msg_arg->ret_origin;
 out:
-	tee_shm_free(shm);
+	optee_free_msg_arg(ctx, entry, offs);
 	return rc;
 }
 
@@ -306,9 +454,11 @@ int optee_cancel_req(struct tee_context *ctx, u32 cancel_id, u32 session)
 {
 	struct optee *optee = tee_get_drvdata(ctx->teedev);
 	struct optee_context_data *ctxdata = ctx->data;
-	struct tee_shm *shm;
+	struct optee_shm_arg_entry *entry;
 	struct optee_msg_arg *msg_arg;
 	struct optee_session *sess;
+	struct tee_shm *shm;
+	u_int offs;
 
 	/* Check that the session is valid */
 	mutex_lock(&ctxdata->mutex);
@@ -317,16 +467,16 @@ int optee_cancel_req(struct tee_context *ctx, u32 cancel_id, u32 session)
 	if (!sess)
 		return -EINVAL;
 
-	shm = optee_get_msg_arg(ctx, 0, &msg_arg);
-	if (IS_ERR(shm))
-		return PTR_ERR(shm);
+	msg_arg = optee_get_msg_arg(ctx, 0, &entry, &shm, &offs);
+	if (IS_ERR(msg_arg))
+		return PTR_ERR(msg_arg);
 
 	msg_arg->cmd = OPTEE_MSG_CMD_CANCEL;
 	msg_arg->session = session;
 	msg_arg->cancel_id = cancel_id;
-	optee->ops->do_call_with_arg(ctx, shm);
+	optee->ops->do_call_with_arg(ctx, shm, offs);
 
-	tee_shm_free(shm);
+	optee_free_msg_arg(ctx, entry, offs);
 	return 0;
 }
 
diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index daf947e98d14..daf07737c4fd 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -171,6 +171,7 @@ void optee_remove_common(struct optee *optee)
 	optee_unregister_devices();
 
 	optee_notif_uninit(optee);
+	optee_shm_arg_cache_uninit(optee);
 	teedev_close_context(optee->ctx);
 	/*
 	 * The two devices have to be unregistered before we can free the
diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
index cc863aaefcd9..1552cd3f9d4e 100644
--- a/drivers/tee/optee/ffa_abi.c
+++ b/drivers/tee/optee/ffa_abi.c
@@ -601,6 +601,7 @@ static int optee_ffa_yielding_call(struct tee_context *ctx,
  * optee_ffa_do_call_with_arg() - Do a FF-A call to enter OP-TEE in secure world
  * @ctx:	calling context
  * @shm:	shared memory holding the message to pass to secure world
+ * @offs:	offset of the message in @shm
  *
  * Does a FF-A call to OP-TEE in secure world and handles eventual resulting
  * Remote Procedure Calls (RPC) from OP-TEE.
@@ -609,13 +610,13 @@ static int optee_ffa_yielding_call(struct tee_context *ctx,
  */
 
 static int optee_ffa_do_call_with_arg(struct tee_context *ctx,
-				      struct tee_shm *shm)
+				      struct tee_shm *shm, u_int offs)
 {
 	struct ffa_send_direct_data data = {
 		.data0 = OPTEE_FFA_YIELDING_CALL_WITH_ARG,
 		.data1 = (u32)shm->sec_world_id,
 		.data2 = (u32)(shm->sec_world_id >> 32),
-		.data3 = 0,
+		.data3 = offs,
 	};
 	struct optee_msg_arg *arg;
 	unsigned int rpc_arg_offs;
@@ -630,12 +631,12 @@ static int optee_ffa_do_call_with_arg(struct tee_context *ctx,
 	if (shm->offset)
 		return -EINVAL;
 
-	arg = tee_shm_get_va(shm, 0);
+	arg = tee_shm_get_va(shm, offs);
 	if (IS_ERR(arg))
 		return PTR_ERR(arg);
 
 	rpc_arg_offs = OPTEE_MSG_GET_ARG_SIZE(arg->num_params);
-	rpc_arg = tee_shm_get_va(shm, rpc_arg_offs);
+	rpc_arg = tee_shm_get_va(shm, offs + rpc_arg_offs);
 	if (IS_ERR(rpc_arg))
 		return PTR_ERR(rpc_arg);
 
@@ -787,6 +788,7 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
 	struct tee_shm_pool *pool;
 	struct tee_device *teedev;
 	struct tee_context *ctx;
+	u32 arg_cache_flags = 0;
 	struct optee *optee;
 	u32 sec_caps;
 	int rc;
@@ -803,6 +805,8 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
 	if (!optee_ffa_exchange_caps(ffa_dev, ffa_ops, &sec_caps,
 				     &rpc_param_count))
 		return -EINVAL;
+	if (sec_caps & OPTEE_FFA_SEC_CAP_ARG_OFFSET)
+		arg_cache_flags |= OPTEE_SHM_ARG_SHARED;
 
 	optee = kzalloc(sizeof(*optee), GFP_KERNEL);
 	if (!optee)
@@ -851,6 +855,7 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
 	mutex_init(&optee->call_queue.mutex);
 	INIT_LIST_HEAD(&optee->call_queue.waiters);
 	optee_supp_init(&optee->supp);
+	optee_shm_arg_cache_init(optee, arg_cache_flags);
 	ffa_dev_set_drvdata(ffa_dev, optee);
 	ctx = teedev_open(optee->teedev);
 	if (IS_ERR(ctx)) {
diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
index e80c5d9b62ec..a33d98d17cfd 100644
--- a/drivers/tee/optee/optee_private.h
+++ b/drivers/tee/optee/optee_private.h
@@ -59,6 +59,16 @@ struct optee_notif {
 	u_long *bitmap;
 };
 
+#define OPTEE_SHM_ARG_ALLOC_PRIV	BIT(0)
+#define OPTEE_SHM_ARG_SHARED		BIT(1)
+struct optee_shm_arg_entry;
+struct optee_shm_arg_cache {
+	u32 flags;
+	/* Serializes access to this struct */
+	struct mutex mutex;
+	struct list_head shm_args;
+};
+
 /**
  * struct optee_supp - supplicant synchronization struct
  * @ctx			the context of current connected supplicant.
@@ -121,7 +131,7 @@ struct optee;
  */
 struct optee_ops {
 	int (*do_call_with_arg)(struct tee_context *ctx,
-				struct tee_shm *shm_arg);
+				struct tee_shm *shm_arg, u_int offs);
 	int (*to_msg_param)(struct optee *optee,
 			    struct optee_msg_param *msg_params,
 			    size_t num_params, const struct tee_param *params);
@@ -157,6 +167,7 @@ struct optee {
 		struct optee_smc smc;
 		struct optee_ffa ffa;
 	};
+	struct optee_shm_arg_cache shm_arg_cache;
 	struct optee_call_queue call_queue;
 	struct optee_notif notif;
 	struct optee_supp supp;
@@ -273,8 +284,18 @@ void optee_cq_wait_for_completion(struct optee_call_queue *cq,
 void optee_cq_wait_final(struct optee_call_queue *cq,
 			 struct optee_call_waiter *w);
 int optee_check_mem_type(unsigned long start, size_t num_pages);
-struct tee_shm *optee_get_msg_arg(struct tee_context *ctx, size_t num_params,
-				  struct optee_msg_arg **msg_arg);
+
+void optee_shm_arg_cache_init(struct optee *optee, u32 flags);
+void optee_shm_arg_cache_uninit(struct optee *optee);
+struct optee_msg_arg *optee_get_msg_arg(struct tee_context *ctx,
+					size_t num_params,
+					struct optee_shm_arg_entry **entry,
+					struct tee_shm **shm_ret,
+					u_int *offs);
+void optee_free_msg_arg(struct tee_context *ctx,
+			struct optee_shm_arg_entry *entry, u_int offs);
+size_t optee_msg_arg_size(size_t rpc_param_count);
+
 
 struct tee_shm *optee_rpc_cmd_alloc_suppl(struct tee_context *ctx, size_t sz);
 void optee_rpc_cmd_free_suppl(struct tee_context *ctx, struct tee_shm *shm);
diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
index b258d7306042..fc6fb802b9bf 100644
--- a/drivers/tee/optee/smc_abi.c
+++ b/drivers/tee/optee/smc_abi.c
@@ -437,6 +437,7 @@ static int optee_shm_register(struct tee_context *ctx, struct tee_shm *shm,
 	struct optee_msg_arg *msg_arg;
 	struct tee_shm *shm_arg;
 	u64 *pages_list;
+	size_t sz;
 	int rc;
 
 	if (!num_pages)
@@ -450,15 +451,30 @@ static int optee_shm_register(struct tee_context *ctx, struct tee_shm *shm,
 	if (!pages_list)
 		return -ENOMEM;
 
-	shm_arg = optee_get_msg_arg(ctx, 1, &msg_arg);
+	/*
+	 * We're about to register shared memory we can't register shared
+	 * memory for this request or there's a catch-22.
+	 *
+	 * So in this we'll have to do the good old temporary private
+	 * allocation instead of using optee_get_msg_arg().
+	 */
+	sz = optee_msg_arg_size(optee->rpc_param_count);
+	shm_arg = tee_shm_alloc_priv_buf(ctx, sz);
 	if (IS_ERR(shm_arg)) {
 		rc = PTR_ERR(shm_arg);
 		goto out;
 	}
+	msg_arg = tee_shm_get_va(shm_arg, 0);
+	if (IS_ERR(msg_arg)) {
+		rc = PTR_ERR(msg_arg);
+		goto out;
+	}
 
 	optee_fill_pages_list(pages_list, pages, num_pages,
 			      tee_shm_get_page_offset(shm));
 
+	memset(msg_arg, 0, OPTEE_MSG_GET_ARG_SIZE(1));
+	msg_arg->num_params = 1;
 	msg_arg->cmd = OPTEE_MSG_CMD_REGISTER_SHM;
 	msg_arg->params->attr = OPTEE_MSG_ATTR_TYPE_TMEM_OUTPUT |
 				OPTEE_MSG_ATTR_NONCONTIG;
@@ -471,7 +487,7 @@ static int optee_shm_register(struct tee_context *ctx, struct tee_shm *shm,
 	msg_arg->params->u.tmem.buf_ptr = virt_to_phys(pages_list) |
 	  (tee_shm_get_page_offset(shm) & (OPTEE_MSG_NONCONTIG_PAGE_SIZE - 1));
 
-	if (optee->ops->do_call_with_arg(ctx, shm_arg) ||
+	if (optee->ops->do_call_with_arg(ctx, shm_arg, 0) ||
 	    msg_arg->ret != TEEC_SUCCESS)
 		rc = -EINVAL;
 
@@ -487,19 +503,37 @@ static int optee_shm_unregister(struct tee_context *ctx, struct tee_shm *shm)
 	struct optee_msg_arg *msg_arg;
 	struct tee_shm *shm_arg;
 	int rc = 0;
+	size_t sz;
 
-	shm_arg = optee_get_msg_arg(ctx, 1, &msg_arg);
+	/*
+	 * We're about to unregister shared memory and we may not be able
+	 * register shared memory for this request in case we're called
+	 * from optee_shm_arg_cache_uninit().
+	 *
+	 * So in order to keep things simple in this function just as in
+	 * optee_shm_register() we'll use temporary private allocation
+	 * instead of using optee_get_msg_arg().
+	 */
+	sz = optee_msg_arg_size(optee->rpc_param_count);
+	shm_arg = tee_shm_alloc_priv_buf(ctx, sz);
 	if (IS_ERR(shm_arg))
 		return PTR_ERR(shm_arg);
+	msg_arg = tee_shm_get_va(shm_arg, 0);
+	if (IS_ERR(msg_arg)) {
+		rc = PTR_ERR(msg_arg);
+		goto out;
+	}
 
+	memset(msg_arg, 0, sz);
+	msg_arg->num_params = 1;
 	msg_arg->cmd = OPTEE_MSG_CMD_UNREGISTER_SHM;
-
 	msg_arg->params[0].attr = OPTEE_MSG_ATTR_TYPE_RMEM_INPUT;
 	msg_arg->params[0].u.rmem.shm_ref = (unsigned long)shm;
 
-	if (optee->ops->do_call_with_arg(ctx, shm_arg) ||
+	if (optee->ops->do_call_with_arg(ctx, shm_arg, 0) ||
 	    msg_arg->ret != TEEC_SUCCESS)
 		rc = -EINVAL;
+out:
 	tee_shm_free(shm_arg);
 	return rc;
 }
@@ -823,6 +857,7 @@ static void optee_handle_rpc(struct tee_context *ctx,
  * optee_smc_do_call_with_arg() - Do an SMC to OP-TEE in secure world
  * @ctx:	calling context
  * @shm:	shared memory holding the message to pass to secure world
+ * @offs:	offset of the message in @shm
  *
  * Does and SMC to OP-TEE in secure world and handles eventual resulting
  * Remote Procedure Calls (RPC) from OP-TEE.
@@ -830,7 +865,7 @@ static void optee_handle_rpc(struct tee_context *ctx,
  * Returns return code from secure world, 0 is OK
  */
 static int optee_smc_do_call_with_arg(struct tee_context *ctx,
-				      struct tee_shm *shm)
+				      struct tee_shm *shm, u_int offs)
 {
 	struct optee *optee = tee_get_drvdata(ctx->teedev);
 	struct optee_call_waiter w;
@@ -843,12 +878,12 @@ static int optee_smc_do_call_with_arg(struct tee_context *ctx,
 		struct optee_msg_arg *arg;
 		unsigned int rpc_arg_offs;
 
-		arg = tee_shm_get_va(shm, 0);
+		arg = tee_shm_get_va(shm, offs);
 		if (IS_ERR(arg))
 			return PTR_ERR(arg);
 
 		rpc_arg_offs = OPTEE_MSG_GET_ARG_SIZE(arg->num_params);
-		rpc_arg = tee_shm_get_va(shm, rpc_arg_offs);
+		rpc_arg = tee_shm_get_va(shm, offs + rpc_arg_offs);
 		if (IS_ERR(arg))
 			return PTR_ERR(arg);
 	}
@@ -856,11 +891,11 @@ static int optee_smc_do_call_with_arg(struct tee_context *ctx,
 	if  (rpc_arg && tee_shm_is_dynamic(shm)) {
 		param.a0 = OPTEE_SMC_CALL_WITH_REGD_ARG;
 		reg_pair_from_64(&param.a1, &param.a2, (u_long)shm);
-		param.a3 = 0;
+		param.a3 = offs;
 	} else {
 		phys_addr_t parg;
 
-		rc = tee_shm_get_pa(shm, 0, &parg);
+		rc = tee_shm_get_pa(shm, offs, &parg);
 		if (rc)
 			return rc;
 
@@ -912,17 +947,19 @@ static int optee_smc_do_call_with_arg(struct tee_context *ctx,
 
 static int simple_call_with_arg(struct tee_context *ctx, u32 cmd)
 {
+	struct optee_shm_arg_entry *entry;
 	struct optee_msg_arg *msg_arg;
 	struct tee_shm *shm;
+	u_int offs;
 
-	shm = optee_get_msg_arg(ctx, 0, &msg_arg);
-	if (IS_ERR(shm))
-		return PTR_ERR(shm);
+	msg_arg = optee_get_msg_arg(ctx, 0, &entry, &shm, &offs);
+	if (IS_ERR(msg_arg))
+		return PTR_ERR(msg_arg);
 
 	msg_arg->cmd = cmd;
-	optee_smc_do_call_with_arg(ctx, shm);
+	optee_smc_do_call_with_arg(ctx, shm, offs);
 
-	tee_shm_free(shm);
+	optee_free_msg_arg(ctx, entry, offs);
 	return 0;
 }
 
@@ -1321,6 +1358,7 @@ static int optee_probe(struct platform_device *pdev)
 {
 	optee_invoke_fn *invoke_fn;
 	struct tee_shm_pool *pool = ERR_PTR(-EINVAL);
+	u32 arg_cache_flags = OPTEE_SHM_ARG_SHARED;
 	struct optee *optee = NULL;
 	void *memremaped_shm = NULL;
 	unsigned int rpc_param_count;
@@ -1353,6 +1391,9 @@ static int optee_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	if (!rpc_param_count)
+		arg_cache_flags |= OPTEE_SHM_ARG_ALLOC_PRIV;
+
 	/*
 	 * Try to use dynamic shared memory if possible
 	 */
@@ -1406,6 +1447,7 @@ static int optee_probe(struct platform_device *pdev)
 	optee_supp_init(&optee->supp);
 	optee->smc.memremaped_shm = memremaped_shm;
 	optee->pool = pool;
+	optee_shm_arg_cache_init(optee, arg_cache_flags);
 
 	platform_set_drvdata(pdev, optee);
 	ctx = teedev_open(optee->teedev);
@@ -1473,6 +1515,7 @@ static int optee_probe(struct platform_device *pdev)
 err_close_ctx:
 	teedev_close_context(ctx);
 err_supp_uninit:
+	optee_shm_arg_cache_uninit(optee);
 	optee_supp_uninit(&optee->supp);
 	mutex_destroy(&optee->call_queue.mutex);
 err_unreg_supp_teedev:
-- 
2.31.1

