Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F32A748EC4A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 16:09:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242451AbiANPJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 10:09:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242273AbiANPIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 10:08:47 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5BA6C06173E
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 07:08:46 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id x11so5463884lfa.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 07:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OtN0NK8H68RvtV1DUCOaMv7wLfC2kxbWO3RbKAx6JAo=;
        b=vMje8KFNPRAamdH6/q4NYp/LtdTyAgv8Yd3+M08wCU8FfZLzjYS6RGjekqX/X67HJQ
         HCqGWOmMdIEErsj15iT7ZtMFS6pyFpHHZdn6tMS5SLyKZTp2RxF0MuM5vUBVZblSLu5Q
         JPoe9xz8ExoOIHV14sTaQES7O3OIfmqCesMg10d3VsfavpTWXKvduaWPrUr8zHrwEyqX
         c/t/voU3yaJZMe5hCotVZYN2GPnfLG3kGDKpKhVxeJVxvymWLqBWxBR5txoIBdvpBOBo
         zxs+Ug7xCL+SfYzseBwUvyVKhkGV+FkKkuVycbg+J8APrXpFXMqB3koqNj4ScifOJqr8
         P0qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OtN0NK8H68RvtV1DUCOaMv7wLfC2kxbWO3RbKAx6JAo=;
        b=5GlvIGavuHfxTwc0E4LuV/kzlYeyOdV9jRHVV8AlLnqigW8OTq4ijtTvVT5/NwEgRD
         h2r3bsLwAaqiA7UA78DHEPZM89cG5gbhXsWG1Dchxg37X2MvGPl9RSXHw36hTO3xUUXI
         iAfYakrZVjU9gJtgk6amgS3SJhkbLM1HfN562oNpNvqREpmRJRELkJI7n43Xvj9dhWO1
         pRieaZI/TJqRnkVfIRmNM68Y6m6UgYD1PHSwE5lMP7wpw0SNwT5QKmlcuIgkLkoq+xfN
         nwpoPnnVuEVHbPBaqvKSl8OgJkdcE6/vAhdE0In5aWri0G7UI8UKhwelQ1P4F8pjQr/g
         RS5Q==
X-Gm-Message-State: AOAM531863nRLZk1lfPppNwV2zKvATkmDj5KGf1BXF6euFfRBCuHV4US
        yGtXIxfKqLKuu2oswppqR3NXRK720GhhTA==
X-Google-Smtp-Source: ABdhPJy00T4Ymu3vn1vX4t4VhUcoBRtNhKDHrTvvWRPLiqjzCjmT9JDZpB4GN+9v8QV+mRq6d29WzQ==
X-Received: by 2002:a05:651c:198b:: with SMTP id bx11mr6757950ljb.379.1642172925132;
        Fri, 14 Jan 2022 07:08:45 -0800 (PST)
Received: from jade.urgonet (h-94-254-48-165.A175.priv.bahnhof.se. [94.254.48.165])
        by smtp.gmail.com with ESMTPSA id i31sm40517lfv.67.2022.01.14.07.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 07:08:44 -0800 (PST)
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        Rijo Thomas <Rijo-john.Thomas@amd.com>,
        David Howells <dhowells@redhat.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v2 07/12] optee: use driver internal tee_contex for some rpc
Date:   Fri, 14 Jan 2022 16:08:19 +0100
Message-Id: <20220114150824.3578829-8-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220114150824.3578829-1-jens.wiklander@linaro.org>
References: <20220114150824.3578829-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Uses the new driver internal tee_context when allocating driver private
shared memory. This decouples the shared memory object from its original
tee_context. This is needed when the life time of such a memory
allocation outlives the client tee_context.

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/tee/optee/ffa_abi.c | 16 ++++++++--------
 drivers/tee/optee/smc_abi.c |  7 ++++---
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
index 88a028d4fb7b..5ec484b42432 100644
--- a/drivers/tee/optee/ffa_abi.c
+++ b/drivers/tee/optee/ffa_abi.c
@@ -424,6 +424,7 @@ static struct tee_shm_pool *optee_ffa_shm_pool_alloc_pages(void)
  */
 
 static void handle_ffa_rpc_func_cmd_shm_alloc(struct tee_context *ctx,
+					      struct optee *optee,
 					      struct optee_msg_arg *arg)
 {
 	struct tee_shm *shm;
@@ -439,7 +440,7 @@ static void handle_ffa_rpc_func_cmd_shm_alloc(struct tee_context *ctx,
 		shm = optee_rpc_cmd_alloc_suppl(ctx, arg->params[0].u.value.b);
 		break;
 	case OPTEE_RPC_SHM_TYPE_KERNEL:
-		shm = tee_shm_alloc_priv_kernel_buf(ctx,
+		shm = tee_shm_alloc_priv_kernel_buf(optee->ctx,
 						    arg->params[0].u.value.b);
 		break;
 	default:
@@ -493,14 +494,13 @@ static void handle_ffa_rpc_func_cmd_shm_free(struct tee_context *ctx,
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
@@ -510,12 +510,12 @@ static void handle_ffa_rpc_func_cmd(struct tee_context *ctx,
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
@@ -582,7 +582,7 @@ static int optee_ffa_yielding_call(struct tee_context *ctx,
 		 * above.
 		 */
 		cond_resched();
-		optee_handle_ffa_rpc(ctx, data->data1, rpc_arg);
+		optee_handle_ffa_rpc(ctx, optee, data->data1, rpc_arg);
 		cmd = OPTEE_FFA_YIELDING_CALL_RESUME;
 		data->data0 = cmd;
 		data->data1 = 0;
diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
index 1dbb13b08381..f2ef76451443 100644
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
-		shm = tee_shm_alloc_priv_kernel_buf(ctx, sz);
+		shm = tee_shm_alloc_priv_kernel_buf(optee->ctx, sz);
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
-		shm = tee_shm_alloc_priv_kernel_buf(ctx, param->a1);
+		shm = tee_shm_alloc_priv_kernel_buf(optee->ctx, param->a1);
 		if (!IS_ERR(shm) && !tee_shm_get_pa(shm, 0, &pa)) {
 			reg_pair_from_64(&param->a1, &param->a2, pa);
 			reg_pair_from_64(&param->a4, &param->a5,
-- 
2.31.1

