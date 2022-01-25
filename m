Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9041449B8D3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 17:36:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1583900AbiAYQe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 11:34:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380581AbiAYQ3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 11:29:55 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B43C061747
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 08:29:54 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id x23so10844180lfc.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 08:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sngM1MTBG7FbSgx6kzN4DBsXrM+u+p1VNu+9KTohzwQ=;
        b=vXR6w3Ct9pbhQBGqGIWoXvBNUWYe2WkFktusJV1qAdeMikoPAbHFB47bJ6QqSjeNuL
         lr1LKkfbp0mVu+HlAQd6wowoxaFLoHOp6L5EnS7UyNNZFqN+cmRjSTA49LWQWA5rh+zC
         GZHB2LJLNOj+MTVc/IiaTvvsDmQlE2EOKyF+N6YvS0ZdNzPYVW9HuYcFLkVwdmGgemwG
         Je2cNjWc1bB7BqeLPNg5HRT3lYe6fpkdmNY7mi3VDvfhvkfGDB774fiBFMlKyXe5hh0Y
         FBP0hfznOJGirRdT1Pozi0OZBMhtK5xuiPQkSph3pik8RmuCvThdniVaTvouZT6f+p6j
         UgSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sngM1MTBG7FbSgx6kzN4DBsXrM+u+p1VNu+9KTohzwQ=;
        b=LbEw28XKqr+jKsezTEsFTQeMPjMnRvQyqOO/ifGNDrY9AbBhXmI7VfVTJPqHoqXPe6
         HWoQ0wEe8JX/71HBOAoBBllGOLU0P37uzLR7BFP225sV0McA486AtFQ7dZwIUrQUMJyS
         jcr3URgaknxHIQ66PFr5PqWyrbP3Up4I2o632KKsi8jkox/HocXKGl26PTVxKZqC6twq
         oJaG8k+MWZXpeYnmVN1X5G1JsE007cvmtIKRXSOiJWnALUYxaD5epNwzbk221iQ5vz3T
         8e53/6rHsOpTTTQWEuBjBIxn/7d992qp0+yWRzbwV8fRnfFArFflXIAPMMZa7o7Ws5J5
         GMlQ==
X-Gm-Message-State: AOAM533mf21XYF1kJ8O51BdsA/Bkv4pHPN3rJ6HfHt+NzXEiYPWWfBRZ
        d93DwzXZtjWIJEQcvcVNw9Z64AzO+CyWrQ==
X-Google-Smtp-Source: ABdhPJwGxDw457LD2Vw2V0f5S3EHpS3N44t4L6sI0rbhLQv23J+AO+xeJARfEWNjtfaw4Zix46+DFw==
X-Received: by 2002:a05:6512:118c:: with SMTP id g12mr17393250lfr.55.1643128192950;
        Tue, 25 Jan 2022 08:29:52 -0800 (PST)
Received: from jade.urgonet (h-94-254-48-165.A175.priv.bahnhof.se. [94.254.48.165])
        by smtp.gmail.com with ESMTPSA id d13sm536240lfq.75.2022.01.25.08.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 08:29:52 -0800 (PST)
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        Rijo Thomas <Rijo-john.Thomas@amd.com>,
        David Howells <dhowells@redhat.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        stable@vger.kernel.org
Subject: [PATCH v3 07/12] optee: use driver internal tee_contex for some rpc
Date:   Tue, 25 Jan 2022 17:29:33 +0100
Message-Id: <20220125162938.838382-8-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220125162938.838382-1-jens.wiklander@linaro.org>
References: <20220125162938.838382-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Uses the new driver internal tee_context when allocating driver private
shared memory. This decouples the shared memory object from its original
tee_context. This is needed when the life time of such a memory
allocation outlives the client tee_context.

Fixes: 217e0250cccb ("tee: use reference counting for tee_context")
Cc: stable@vger.kernel.org
Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/tee/optee/ffa_abi.c | 17 +++++++++--------
 drivers/tee/optee/smc_abi.c |  7 ++++---
 2 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
index 954e88866968..fb7345941024 100644
--- a/drivers/tee/optee/ffa_abi.c
+++ b/drivers/tee/optee/ffa_abi.c
@@ -424,6 +424,7 @@ static struct tee_shm_pool *optee_ffa_shm_pool_alloc_pages(void)
  */
 
 static void handle_ffa_rpc_func_cmd_shm_alloc(struct tee_context *ctx,
+					      struct optee *optee,
 					      struct optee_msg_arg *arg)
 {
 	struct tee_shm *shm;
@@ -439,7 +440,8 @@ static void handle_ffa_rpc_func_cmd_shm_alloc(struct tee_context *ctx,
 		shm = optee_rpc_cmd_alloc_suppl(ctx, arg->params[0].u.value.b);
 		break;
 	case OPTEE_RPC_SHM_TYPE_KERNEL:
-		shm = tee_shm_alloc_priv_buf(ctx, arg->params[0].u.value.b);
+		shm = tee_shm_alloc_priv_buf(optee->ctx,
+					     arg->params[0].u.value.b);
 		break;
 	default:
 		arg->ret = TEEC_ERROR_BAD_PARAMETERS;
@@ -492,14 +494,13 @@ static void handle_ffa_rpc_func_cmd_shm_free(struct tee_context *ctx,
 }
 
 static void handle_ffa_rpc_func_cmd(struct tee_context *ctx,
+				    struct optee *optee,
 				    struct optee_msg_arg *arg)
 {
-	struct optee *optee = tee_get_drvdata(ctx->teedev);
-
 	arg->ret_origin = TEEC_ORIGIN_COMMS;
 	switch (arg->cmd) {
 	case OPTEE_RPC_CMD_SHM_ALLOC:
-		handle_ffa_rpc_func_cmd_shm_alloc(ctx, arg);
+		handle_ffa_rpc_func_cmd_shm_alloc(ctx, optee, arg);
 		break;
 	case OPTEE_RPC_CMD_SHM_FREE:
 		handle_ffa_rpc_func_cmd_shm_free(ctx, optee, arg);
@@ -509,12 +510,12 @@ static void handle_ffa_rpc_func_cmd(struct tee_context *ctx,
 	}
 }
 
-static void optee_handle_ffa_rpc(struct tee_context *ctx, u32 cmd,
-				 struct optee_msg_arg *arg)
+static void optee_handle_ffa_rpc(struct tee_context *ctx, struct optee *optee,
+				 u32 cmd, struct optee_msg_arg *arg)
 {
 	switch (cmd) {
 	case OPTEE_FFA_YIELDING_CALL_RETURN_RPC_CMD:
-		handle_ffa_rpc_func_cmd(ctx, arg);
+		handle_ffa_rpc_func_cmd(ctx, optee, arg);
 		break;
 	case OPTEE_FFA_YIELDING_CALL_RETURN_INTERRUPT:
 		/* Interrupt delivered by now */
@@ -581,7 +582,7 @@ static int optee_ffa_yielding_call(struct tee_context *ctx,
 		 * above.
 		 */
 		cond_resched();
-		optee_handle_ffa_rpc(ctx, data->data1, rpc_arg);
+		optee_handle_ffa_rpc(ctx, optee, data->data1, rpc_arg);
 		cmd = OPTEE_FFA_YIELDING_CALL_RESUME;
 		data->data0 = cmd;
 		data->data1 = 0;
diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
index b1082a34cda2..0dc383c974a3 100644
--- a/drivers/tee/optee/smc_abi.c
+++ b/drivers/tee/optee/smc_abi.c
@@ -621,6 +621,7 @@ static void handle_rpc_func_cmd_shm_free(struct tee_context *ctx,
 }
 
 static void handle_rpc_func_cmd_shm_alloc(struct tee_context *ctx,
+					  struct optee *optee,
 					  struct optee_msg_arg *arg,
 					  struct optee_call_ctx *call_ctx)
 {
@@ -650,7 +651,7 @@ static void handle_rpc_func_cmd_shm_alloc(struct tee_context *ctx,
 		shm = optee_rpc_cmd_alloc_suppl(ctx, sz);
 		break;
 	case OPTEE_RPC_SHM_TYPE_KERNEL:
-		shm = tee_shm_alloc_priv_buf(ctx, sz);
+		shm = tee_shm_alloc_priv_buf(optee->ctx, sz);
 		break;
 	default:
 		arg->ret = TEEC_ERROR_BAD_PARAMETERS;
@@ -746,7 +747,7 @@ static void handle_rpc_func_cmd(struct tee_context *ctx, struct optee *optee,
 	switch (arg->cmd) {
 	case OPTEE_RPC_CMD_SHM_ALLOC:
 		free_pages_list(call_ctx);
-		handle_rpc_func_cmd_shm_alloc(ctx, arg, call_ctx);
+		handle_rpc_func_cmd_shm_alloc(ctx, optee, arg, call_ctx);
 		break;
 	case OPTEE_RPC_CMD_SHM_FREE:
 		handle_rpc_func_cmd_shm_free(ctx, arg);
@@ -775,7 +776,7 @@ static void optee_handle_rpc(struct tee_context *ctx,
 
 	switch (OPTEE_SMC_RETURN_GET_RPC_FUNC(param->a0)) {
 	case OPTEE_SMC_RPC_FUNC_ALLOC:
-		shm = tee_shm_alloc_priv_buf(ctx, param->a1);
+		shm = tee_shm_alloc_priv_buf(optee->ctx, param->a1);
 		if (!IS_ERR(shm) && !tee_shm_get_pa(shm, 0, &pa)) {
 			reg_pair_from_64(&param->a1, &param->a2, pa);
 			reg_pair_from_64(&param->a4, &param->a5,
-- 
2.31.1

