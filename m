Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 342695B078A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 16:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbiIGOw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 10:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbiIGOws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 10:52:48 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D2823AA365
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 07:52:47 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 90A02143D;
        Wed,  7 Sep 2022 07:52:53 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D70883F71A;
        Wed,  7 Sep 2022 07:52:45 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        op-tee@lists.trustedfirmware.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Marc Bonnici <marc.bonnici@arm.com>,
        Achin Gupta <achin.gupta@arm.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Valentin Laurent <valentin.laurent@trustonic.com>,
        Lukas Hanel <lukas.hanel@trustonic.com>,
        Coboy Chen <coboy.chen@mediatek.com>,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v3 02/10] tee: optee: Drop ffa_ops in optee_ffa structure using ffa_dev->ops directly
Date:   Wed,  7 Sep 2022 15:52:32 +0100
Message-Id: <20220907145240.1683088-3-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220907145240.1683088-1-sudeep.holla@arm.com>
References: <20220907145240.1683088-1-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the ffa_device structure holds the pointer to ffa_dev_ops,
there is no need to obtain the same through ffa_dev_ops_get().

Just use the ffa_dev->ops directly. Since the ffa_device itself carries
ffa_dev_ops now, there is no need to keep a copy in optee_ffa structure.

Drop ffa_ops in the optee_ffa structure as it is not needed anymore.

Reviewed-by: Jens Wiklander <jens.wiklander@linaro.org>
Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/tee/optee/ffa_abi.c       | 15 +++++----------
 drivers/tee/optee/optee_private.h |  1 -
 2 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
index 7ab31740cff8..3d4079575ccd 100644
--- a/drivers/tee/optee/ffa_abi.c
+++ b/drivers/tee/optee/ffa_abi.c
@@ -271,8 +271,8 @@ static int optee_ffa_shm_register(struct tee_context *ctx, struct tee_shm *shm,
 				  unsigned long start)
 {
 	struct optee *optee = tee_get_drvdata(ctx->teedev);
-	const struct ffa_dev_ops *ffa_ops = optee->ffa.ffa_ops;
 	struct ffa_device *ffa_dev = optee->ffa.ffa_dev;
+	const struct ffa_dev_ops *ffa_ops = ffa_dev->ops;
 	struct ffa_mem_region_attributes mem_attr = {
 		.receiver = ffa_dev->vm_id,
 		.attrs = FFA_MEM_RW,
@@ -314,8 +314,8 @@ static int optee_ffa_shm_unregister(struct tee_context *ctx,
 				    struct tee_shm *shm)
 {
 	struct optee *optee = tee_get_drvdata(ctx->teedev);
-	const struct ffa_dev_ops *ffa_ops = optee->ffa.ffa_ops;
 	struct ffa_device *ffa_dev = optee->ffa.ffa_dev;
+	const struct ffa_dev_ops *ffa_ops = ffa_dev->ops;
 	u64 global_handle = shm->sec_world_id;
 	struct ffa_send_direct_data data = {
 		.data0 = OPTEE_FFA_UNREGISTER_SHM,
@@ -342,7 +342,7 @@ static int optee_ffa_shm_unregister_supp(struct tee_context *ctx,
 					 struct tee_shm *shm)
 {
 	struct optee *optee = tee_get_drvdata(ctx->teedev);
-	const struct ffa_dev_ops *ffa_ops = optee->ffa.ffa_ops;
+	const struct ffa_dev_ops *ffa_ops = optee->ffa.ffa_dev->ops;
 	u64 global_handle = shm->sec_world_id;
 	int rc;
 
@@ -529,8 +529,8 @@ static int optee_ffa_yielding_call(struct tee_context *ctx,
 				   struct optee_msg_arg *rpc_arg)
 {
 	struct optee *optee = tee_get_drvdata(ctx->teedev);
-	const struct ffa_dev_ops *ffa_ops = optee->ffa.ffa_ops;
 	struct ffa_device *ffa_dev = optee->ffa.ffa_dev;
+	const struct ffa_dev_ops *ffa_ops = ffa_dev->ops;
 	struct optee_call_waiter w;
 	u32 cmd = data->data0;
 	u32 w4 = data->data1;
@@ -793,11 +793,7 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
 	u32 sec_caps;
 	int rc;
 
-	ffa_ops = ffa_dev_ops_get(ffa_dev);
-	if (!ffa_ops) {
-		pr_warn("failed \"method\" init: ffa\n");
-		return -ENOENT;
-	}
+	ffa_ops = ffa_dev->ops;
 
 	if (!optee_ffa_api_is_compatbile(ffa_dev, ffa_ops))
 		return -EINVAL;
@@ -821,7 +817,6 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
 
 	optee->ops = &optee_ffa_ops;
 	optee->ffa.ffa_dev = ffa_dev;
-	optee->ffa.ffa_ops = ffa_ops;
 	optee->rpc_param_count = rpc_param_count;
 
 	teedev = tee_device_alloc(&optee_ffa_clnt_desc, NULL, optee->pool,
diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
index a33d98d17cfd..04ae58892608 100644
--- a/drivers/tee/optee/optee_private.h
+++ b/drivers/tee/optee/optee_private.h
@@ -111,7 +111,6 @@ struct optee_smc {
  */
 struct optee_ffa {
 	struct ffa_device *ffa_dev;
-	const struct ffa_dev_ops *ffa_ops;
 	/* Serializes access to @global_ids */
 	struct mutex mutex;
 	struct rhashtable global_ids;
-- 
2.37.3

