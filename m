Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6AFE5A6068
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 12:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbiH3KMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 06:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbiH3KMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 06:12:00 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7827EF2D5C
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 03:07:40 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 49C0A1474;
        Tue, 30 Aug 2022 03:07:46 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DA8713F766;
        Tue, 30 Aug 2022 03:07:38 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Marc Bonnici <marc.bonnici@arm.com>,
        Achin Gupta <achin.gupta@arm.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Valentin Laurent <valentin.laurent@trustonic.com>,
        Lukas Hanel <lukas.hanel@trustonic.com>,
        Coboy Chen <coboy.chen@mediatek.com>
Subject: [PATCH 9/9] firmware: arm_ffa: Split up ffa_dev_ops into info, message and memory operations
Date:   Tue, 30 Aug 2022 11:07:00 +0100
Message-Id: <20220830100700.344594-10-sudeep.holla@arm.com>
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

In preparation to make memory operations accessible for a non
ffa_driver/device, it is better to split the ffa_dev_ops into different
categories of operations: info, message and memory. The info and memory
are ffa_device independent and can be used without any associated
ffa_device from a non ffa_driver.

However, we don't export these info and memory APIs yet without the user.
The first users of these APIs can export them.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_ffa/driver.c | 14 ++++++++++++-
 drivers/tee/optee/ffa_abi.c       | 33 +++++++++++++++++--------------
 include/linux/arm_ffa.h           | 14 ++++++++++++-
 3 files changed, 44 insertions(+), 17 deletions(-)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index 6822241168d6..d7a90c49fdcf 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -676,16 +676,28 @@ static int ffa_memory_lend(struct ffa_mem_ops_args *args)
 	return ffa_memory_ops(FFA_MEM_LEND, args);
 }
 
-static const struct ffa_dev_ops ffa_ops = {
+static const struct ffa_dev_info_ops ffa_info_ops = {
 	.api_version_get = ffa_api_version_get,
 	.partition_info_get = ffa_partition_info_get,
+};
+
+static const struct ffa_dev_msg_ops ffa_msg_ops = {
 	.mode_32bit_set = ffa_mode_32bit_set,
 	.sync_send_receive = ffa_sync_send_receive,
+};
+
+static const struct ffa_dev_mem_ops ffa_mem_ops = {
 	.memory_reclaim = ffa_memory_reclaim,
 	.memory_share = ffa_memory_share,
 	.memory_lend = ffa_memory_lend,
 };
 
+static const struct ffa_dev_ops ffa_ops = {
+	.info_ops = &ffa_info_ops,
+	.msg_ops = &ffa_msg_ops,
+	.mem_ops = &ffa_mem_ops,
+};
+
 void ffa_device_match_uuid(struct ffa_device *ffa_dev, const uuid_t *uuid)
 {
 	int count, idx;
diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
index 7257b42d0545..bbc63fd145a1 100644
--- a/drivers/tee/optee/ffa_abi.c
+++ b/drivers/tee/optee/ffa_abi.c
@@ -272,7 +272,7 @@ static int optee_ffa_shm_register(struct tee_context *ctx, struct tee_shm *shm,
 {
 	struct optee *optee = tee_get_drvdata(ctx->teedev);
 	struct ffa_device *ffa_dev = optee->ffa.ffa_dev;
-	const struct ffa_dev_ops *ffa_ops = ffa_dev->ops;
+	const struct ffa_dev_mem_ops *ffa_mem_ops = ffa_dev->ops->mem_ops;
 	struct ffa_mem_region_attributes mem_attr = {
 		.receiver = ffa_dev->vm_id,
 		.attrs = FFA_MEM_RW,
@@ -294,14 +294,14 @@ static int optee_ffa_shm_register(struct tee_context *ctx, struct tee_shm *shm,
 	if (rc)
 		return rc;
 	args.sg = sgt.sgl;
-	rc = ffa_ops->memory_share(&args);
+	rc = ffa_mem_ops->memory_share(&args);
 	sg_free_table(&sgt);
 	if (rc)
 		return rc;
 
 	rc = optee_shm_add_ffa_handle(optee, shm, args.g_handle);
 	if (rc) {
-		ffa_ops->memory_reclaim(args.g_handle, 0);
+		ffa_mem_ops->memory_reclaim(args.g_handle, 0);
 		return rc;
 	}
 
@@ -315,7 +315,8 @@ static int optee_ffa_shm_unregister(struct tee_context *ctx,
 {
 	struct optee *optee = tee_get_drvdata(ctx->teedev);
 	struct ffa_device *ffa_dev = optee->ffa.ffa_dev;
-	const struct ffa_dev_ops *ffa_ops = ffa_dev->ops;
+	const struct ffa_dev_msg_ops *ffa_msg_ops = ffa_dev->ops->msg_ops;
+	const struct ffa_dev_mem_ops *ffa_mem_ops = ffa_dev->ops->mem_ops;
 	u64 global_handle = shm->sec_world_id;
 	struct ffa_send_direct_data data = {
 		.data0 = OPTEE_FFA_UNREGISTER_SHM,
@@ -327,11 +328,11 @@ static int optee_ffa_shm_unregister(struct tee_context *ctx,
 	optee_shm_rem_ffa_handle(optee, global_handle);
 	shm->sec_world_id = 0;
 
-	rc = ffa_ops->sync_send_receive(ffa_dev, &data);
+	rc = ffa_msg_ops->sync_send_receive(ffa_dev, &data);
 	if (rc)
 		pr_err("Unregister SHM id 0x%llx rc %d\n", global_handle, rc);
 
-	rc = ffa_ops->memory_reclaim(global_handle, 0);
+	rc = ffa_mem_ops->memory_reclaim(global_handle, 0);
 	if (rc)
 		pr_err("mem_reclaim: 0x%llx %d", global_handle, rc);
 
@@ -342,7 +343,7 @@ static int optee_ffa_shm_unregister_supp(struct tee_context *ctx,
 					 struct tee_shm *shm)
 {
 	struct optee *optee = tee_get_drvdata(ctx->teedev);
-	const struct ffa_dev_ops *ffa_ops = optee->ffa.ffa_dev->ops;
+	const struct ffa_dev_mem_ops *ffa_mem_ops;
 	u64 global_handle = shm->sec_world_id;
 	int rc;
 
@@ -353,7 +354,8 @@ static int optee_ffa_shm_unregister_supp(struct tee_context *ctx,
 	 */
 
 	optee_shm_rem_ffa_handle(optee, global_handle);
-	rc = ffa_ops->memory_reclaim(global_handle, 0);
+	ffa_mem_ops = optee->ffa.ffa_dev->ops->mem_ops;
+	rc = ffa_mem_ops->memory_reclaim(global_handle, 0);
 	if (rc)
 		pr_err("mem_reclaim: 0x%llx %d", global_handle, rc);
 
@@ -530,7 +532,7 @@ static int optee_ffa_yielding_call(struct tee_context *ctx,
 {
 	struct optee *optee = tee_get_drvdata(ctx->teedev);
 	struct ffa_device *ffa_dev = optee->ffa.ffa_dev;
-	const struct ffa_dev_ops *ffa_ops = ffa_dev->ops;
+	const struct ffa_dev_msg_ops *ffa_msg_ops = ffa_dev->ops->msg_ops;
 	struct optee_call_waiter w;
 	u32 cmd = data->data0;
 	u32 w4 = data->data1;
@@ -541,7 +543,7 @@ static int optee_ffa_yielding_call(struct tee_context *ctx,
 	/* Initialize waiter */
 	optee_cq_wait_init(&optee->call_queue, &w);
 	while (true) {
-		rc = ffa_ops->sync_send_receive(ffa_dev, data);
+		rc = ffa_msg_ops->sync_send_receive(ffa_dev, data);
 		if (rc)
 			goto done;
 
@@ -576,7 +578,7 @@ static int optee_ffa_yielding_call(struct tee_context *ctx,
 		 * OP-TEE has returned with a RPC request.
 		 *
 		 * Note that data->data4 (passed in register w7) is already
-		 * filled in by ffa_ops->sync_send_receive() returning
+		 * filled in by ffa_mem_ops->sync_send_receive() returning
 		 * above.
 		 */
 		cond_resched();
@@ -654,12 +656,13 @@ static int optee_ffa_do_call_with_arg(struct tee_context *ctx,
 static bool optee_ffa_api_is_compatbile(struct ffa_device *ffa_dev,
 					const struct ffa_dev_ops *ops)
 {
+	const struct ffa_dev_msg_ops *ffa_msg_ops = ops->msg_ops;
 	struct ffa_send_direct_data data = { OPTEE_FFA_GET_API_VERSION };
 	int rc;
 
-	ops->mode_32bit_set(ffa_dev);
+	ffa_msg_ops->mode_32bit_set(ffa_dev);
 
-	rc = ops->sync_send_receive(ffa_dev, &data);
+	rc = ffa_msg_ops->sync_send_receive(ffa_dev, &data);
 	if (rc) {
 		pr_err("Unexpected error %d\n", rc);
 		return false;
@@ -672,7 +675,7 @@ static bool optee_ffa_api_is_compatbile(struct ffa_device *ffa_dev,
 	}
 
 	data = (struct ffa_send_direct_data){ OPTEE_FFA_GET_OS_VERSION };
-	rc = ops->sync_send_receive(ffa_dev, &data);
+	rc = ffa_msg_ops->sync_send_receive(ffa_dev, &data);
 	if (rc) {
 		pr_err("Unexpected error %d\n", rc);
 		return false;
@@ -694,7 +697,7 @@ static bool optee_ffa_exchange_caps(struct ffa_device *ffa_dev,
 	struct ffa_send_direct_data data = { OPTEE_FFA_EXCHANGE_CAPABILITIES };
 	int rc;
 
-	rc = ops->sync_send_receive(ffa_dev, &data);
+	rc = ops->msg_ops->sync_send_receive(ffa_dev, &data);
 	if (rc) {
 		pr_err("Unexpected error %d", rc);
 		return false;
diff --git a/include/linux/arm_ffa.h b/include/linux/arm_ffa.h
index b40afa7933dc..45e2b83d2364 100644
--- a/include/linux/arm_ffa.h
+++ b/include/linux/arm_ffa.h
@@ -255,16 +255,28 @@ struct ffa_mem_ops_args {
 	struct ffa_mem_region_attributes *attrs;
 };
 
-struct ffa_dev_ops {
+struct ffa_dev_info_ops {
 	u32 (*api_version_get)(void);
 	int (*partition_info_get)(const char *uuid_str,
 				  struct ffa_partition_info *buffer);
+};
+
+struct ffa_dev_msg_ops {
 	void (*mode_32bit_set)(struct ffa_device *dev);
 	int (*sync_send_receive)(struct ffa_device *dev,
 				 struct ffa_send_direct_data *data);
+};
+
+struct ffa_dev_mem_ops {
 	int (*memory_reclaim)(u64 g_handle, u32 flags);
 	int (*memory_share)(struct ffa_mem_ops_args *args);
 	int (*memory_lend)(struct ffa_mem_ops_args *args);
 };
 
+struct ffa_dev_ops {
+	const struct ffa_dev_info_ops *info_ops;
+	const struct ffa_dev_msg_ops *msg_ops;
+	const struct ffa_dev_mem_ops *mem_ops;
+};
+
 #endif /* _LINUX_ARM_FFA_H */
-- 
2.37.2

