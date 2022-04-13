Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9724FEEA7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 07:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232554AbiDMFrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 01:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232517AbiDMFqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 01:46:55 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B006A237C3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 22:44:34 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id u7so1572119lfs.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 22:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+iLRC4aU4qXf7p4vZnxdbVNl0iSUfIahtx7crMn/woE=;
        b=yW+2fWO74/EtvYbWgcoWEP43l9iixVreA4b0UHBWAuN/fA4KJTwDhKNxx3BZTeJ+Ce
         I2nuuey9qo2IW2Hu3k0peAb48xv34jRWvNpX7VdcV8mf1JSRqxX3v+t1rZ+KXCNsWqJc
         jOQCiEl6u5FNcbQA5i08f4fkmpCvYt9DR/im1S4I4ES8eOnHzkHitkwP9hC6C9NTRLHI
         0asM1U+zf6U2ngKn7NrDo61sUbkbFwdfGjwO9xaCN2p1UR1EGLEkupfnYwti2v4wX0BJ
         8PVmrlNUUKrZ/I9mzG96I3DF3gw5Wx9fhwl0A0+4E7DFUsrgp4SAtDumzTV3DT0qthyb
         VzxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+iLRC4aU4qXf7p4vZnxdbVNl0iSUfIahtx7crMn/woE=;
        b=KMMyhgRYi+oyEo4BWG86DrqPq6KJ9HMuc3OiBvKqd3NNUuDg+87glHE30eX2XpF62P
         jLX6Onq3EoyDVyna2LU4AO27YLIecgmTl2hpxbJBVhbxp1w8GJRwW4AGY/q5/NexFO+P
         lY9YP5gmOxthY8PYu3FqN2P1TFRaOWdy10O4v0jPk1pVejLdQkcK9WSHJyfUsr4wGxxh
         f74z/oEMFjUvuIXM2Pi43iGlGLzHHfqymGAkCSFaJiBhSQFBvrJqpeKh0MN5J+HI5gZp
         bSo8PYaMgnsDFwBeb4oCkhdO14qhraVR5ujkzowo9/WW9rWpbcccdNntxZOmSVCmq1He
         mlDg==
X-Gm-Message-State: AOAM5332gxsM4Ejb1sG+Z5c4kixG6OXjpHxWbwTTlYNjRSH3Q+S4e5ah
        GXP3MkJTExAsS5S96CBIigW2paxgVLaYdg==
X-Google-Smtp-Source: ABdhPJxfBzFOPRzYxYcJ9o0Hy5UFK2ERnW/X3RJa4RFL/NsqibuseH6x3B1oisBDavLfRmj0kIi9Vg==
X-Received: by 2002:a05:6512:31d5:b0:44a:7a30:d83 with SMTP id j21-20020a05651231d500b0044a7a300d83mr26484525lfe.330.1649828672618;
        Tue, 12 Apr 2022 22:44:32 -0700 (PDT)
Received: from jade.urgonet (h-79-136-84-253.A175.priv.bahnhof.se. [79.136.84.253])
        by smtp.gmail.com with ESMTPSA id o23-20020ac24357000000b0044adb34b68csm3919835lfl.32.2022.04.12.22.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 22:44:31 -0700 (PDT)
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v3 1/4] optee: rename rpc_arg_count to rpc_param_count
Date:   Wed, 13 Apr 2022 07:44:15 +0200
Message-Id: <20220413054418.71996-2-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220413054418.71996-1-jens.wiklander@linaro.org>
References: <20220413054418.71996-1-jens.wiklander@linaro.org>
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

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
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

