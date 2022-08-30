Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF5325A6069
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 12:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbiH3KMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 06:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbiH3KLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 06:11:55 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DED95FB0E2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 03:07:38 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C082723A;
        Tue, 30 Aug 2022 03:07:44 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 666F33F766;
        Tue, 30 Aug 2022 03:07:37 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Marc Bonnici <marc.bonnici@arm.com>,
        Achin Gupta <achin.gupta@arm.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Valentin Laurent <valentin.laurent@trustonic.com>,
        Lukas Hanel <lukas.hanel@trustonic.com>,
        Coboy Chen <coboy.chen@mediatek.com>
Subject: [PATCH 8/9] tee: optee: Drop ffa_ops in optee_ffa structure
Date:   Tue, 30 Aug 2022 11:06:59 +0100
Message-Id: <20220830100700.344594-9-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220830100700.344594-1-sudeep.holla@arm.com>
References: <20220830100700.344594-1-sudeep.holla@arm.com>
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

Since the ffa_device itself carries ffa_dev_ops now, there is no need
to keep a copy in optee_ffa structure.

Drop ffa_ops in the optee_ffa structure as it is not needed anymore.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/tee/optee/ffa_abi.c       | 9 ++++-----
 drivers/tee/optee/optee_private.h | 1 -
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
index 7ec0a2f9a63b..7257b42d0545 100644
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
@@ -817,7 +817,6 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
 
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
2.37.2

