Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 078454E272B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 14:04:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347705AbiCUNFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 09:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347685AbiCUNFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 09:05:20 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7616011A00
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 06:03:54 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id bt26so24475611lfb.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 06:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=86psb8kPn4M1qHzNjl7a471DNz143YZ1CZe8yVwqHQk=;
        b=MZUi50SU3X1QiEt6eexLrwpbhToWV7FokIX44P2Zx5tZM4Gxgf8FGqmAMSynY0csS6
         ib7J7JUObbOTWIOz4HA2GD04z1Vo7Fv8UmE1gXVEbPDNtrzru7f+3rSUWml05mgtJqmx
         cn43SDW38HkLw2lD8627WiENyV8aQydMnRbzYqkTUvVAjGl0rQZJZJiYeXlU/FCKcp0d
         aq419H6wZind4UdWlv8b0t2KtDlYiSthE3ecbVFAybtz9pULCrnkt9ZsuRkfqULOD6Ra
         +1pb9R9UTsoNdBoKL0MYcfJnRWRIskc86zyg0KIIPTeVLU5450n4SeUKE34zVy8YIKUs
         s9VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=86psb8kPn4M1qHzNjl7a471DNz143YZ1CZe8yVwqHQk=;
        b=OLJYemygjE81fK15aGYbtz4FqWo1teiWCE8dfHOr99v4MtlS+yYvC/1Zws1TFe/gcJ
         1ONGermQLbX0DoEJAfKjoS4ad7Itig41/U0Zma0MGrfYq101hCd3Js+yXAOw+aAMffsg
         /b7CfvFR02aC7PkVIydhLhqek0eF+WP3oukVxnScwYkXoT1LrVWk+9Pj+BuUErApt0TO
         OE48tvCF3Dum7A7VfVbi5SFlpb/IZHk+Vg2MO9p69zwct1/Aw6NUUgJYtr9ldbv8Z5rL
         RZMLQDCQhmAJiU4NNLftFwg83PV3XbcRj++EPvzg3lzqUXztt54yEwNRH1qMzxmiBWzn
         ncDA==
X-Gm-Message-State: AOAM53223fxsK8GOk7rZKZ0dFcci81SoGtM33pMSoHf0EQ45x+t0MEYf
        pZ6BemcWBuukTBua5g3QJaUnZLrwrkF5Yw==
X-Google-Smtp-Source: ABdhPJwhDZguVWPogpCGYKoMEAwtip8urqaIuhszw8dc4AwNWLn+GAVav2oryEAtcT0n8bKfiij+Wg==
X-Received: by 2002:a05:6512:16a2:b0:448:1fbb:8ca1 with SMTP id bu34-20020a05651216a200b004481fbb8ca1mr14832890lfb.125.1647867832136;
        Mon, 21 Mar 2022 06:03:52 -0700 (PDT)
Received: from jade.urgonet (h-79-136-84-253.A175.priv.bahnhof.se. [79.136.84.253])
        by smtp.gmail.com with ESMTPSA id t27-20020a2e8e7b000000b00247f32b572asm2067738ljk.19.2022.03.21.06.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 06:03:51 -0700 (PDT)
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v2 1/4] optee: rename rpc_arg_count to rpc_param_count
Date:   Mon, 21 Mar 2022 14:03:38 +0100
Message-Id: <20220321130341.935535-2-jens.wiklander@linaro.org>
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

Renames the field rpc_arg_count in struct optee to rpc_param_count.
Function parameter names and local variables are also renamed to match.

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/tee/optee/call.c          |  6 +++---
 drivers/tee/optee/ffa_abi.c       | 10 +++++-----
 drivers/tee/optee/optee_private.h |  4 ++--
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
index bd49ec934060..a9a237d20c61 100644
--- a/drivers/tee/optee/call.c
+++ b/drivers/tee/optee/call.c
@@ -113,12 +113,12 @@ struct tee_shm *optee_get_msg_arg(struct tee_context *ctx, size_t num_params,
 	struct optee_msg_arg *ma;
 
 	/*
-	 * rpc_arg_count is set to the number of allocated parameters in
+	 * rpc_param_count is set to the number of allocated parameters in
 	 * the RPC argument struct if a second MSG arg struct is expected.
 	 * The second arg struct will then be used for RPC.
 	 */
-	if (optee->rpc_arg_count)
-		sz += OPTEE_MSG_GET_ARG_SIZE(optee->rpc_arg_count);
+	if (optee->rpc_param_count)
+		sz += OPTEE_MSG_GET_ARG_SIZE(optee->rpc_param_count);
 
 	shm = tee_shm_alloc_priv_buf(ctx, sz);
 	if (IS_ERR(shm))
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
-- 
2.31.1

