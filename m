Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAD8F5B078F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 16:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbiIGOxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 10:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbiIGOw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 10:52:59 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 75F7FAA365
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 07:52:55 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5FADF106F;
        Wed,  7 Sep 2022 07:53:01 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A48A03F71A;
        Wed,  7 Sep 2022 07:52:53 -0700 (PDT)
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
Subject: [PATCH v3 07/10] firmware: arm_ffa: Rename ffa_dev_ops as ffa_ops
Date:   Wed,  7 Sep 2022 15:52:37 +0100
Message-Id: <20220907145240.1683088-8-sudeep.holla@arm.com>
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

Except the message APIs, all other APIs are ffa_device independent and can
be used without any associated ffa_device from a non ffa_driver.

In order to reflect the same, just rename ffa_dev_ops as ffa_ops to
avoid any confusion or to keep it simple.

Suggested-by: Sumit Garg <sumit.garg@linaro.org>
Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
Reviewed-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_ffa/bus.c    |  2 +-
 drivers/firmware/arm_ffa/driver.c |  2 +-
 drivers/tee/optee/ffa_abi.c       | 14 +++++++-------
 include/linux/arm_ffa.h           |  8 ++++----
 4 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/firmware/arm_ffa/bus.c b/drivers/firmware/arm_ffa/bus.c
index 69328041fbc3..99d439480612 100644
--- a/drivers/firmware/arm_ffa/bus.c
+++ b/drivers/firmware/arm_ffa/bus.c
@@ -168,7 +168,7 @@ bool ffa_device_is_valid(struct ffa_device *ffa_dev)
 }
 
 struct ffa_device *ffa_device_register(const uuid_t *uuid, int vm_id,
-				       const struct ffa_dev_ops *ops)
+				       const struct ffa_ops *ops)
 {
 	int ret;
 	struct device *dev;
diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index e4fd35773071..2532e0f16cc9 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -666,7 +666,7 @@ static int ffa_memory_lend(struct ffa_mem_ops_args *args)
 	return ffa_memory_ops(FFA_MEM_LEND, args);
 }
 
-static const struct ffa_dev_ops ffa_ops = {
+static const struct ffa_ops ffa_ops = {
 	.api_version_get = ffa_api_version_get,
 	.partition_info_get = ffa_partition_info_get,
 	.mode_32bit_set = ffa_mode_32bit_set,
diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
index 7257b42d0545..2ce5b87dfb27 100644
--- a/drivers/tee/optee/ffa_abi.c
+++ b/drivers/tee/optee/ffa_abi.c
@@ -272,7 +272,7 @@ static int optee_ffa_shm_register(struct tee_context *ctx, struct tee_shm *shm,
 {
 	struct optee *optee = tee_get_drvdata(ctx->teedev);
 	struct ffa_device *ffa_dev = optee->ffa.ffa_dev;
-	const struct ffa_dev_ops *ffa_ops = ffa_dev->ops;
+	const struct ffa_ops *ffa_ops = ffa_dev->ops;
 	struct ffa_mem_region_attributes mem_attr = {
 		.receiver = ffa_dev->vm_id,
 		.attrs = FFA_MEM_RW,
@@ -315,7 +315,7 @@ static int optee_ffa_shm_unregister(struct tee_context *ctx,
 {
 	struct optee *optee = tee_get_drvdata(ctx->teedev);
 	struct ffa_device *ffa_dev = optee->ffa.ffa_dev;
-	const struct ffa_dev_ops *ffa_ops = ffa_dev->ops;
+	const struct ffa_ops *ffa_ops = ffa_dev->ops;
 	u64 global_handle = shm->sec_world_id;
 	struct ffa_send_direct_data data = {
 		.data0 = OPTEE_FFA_UNREGISTER_SHM,
@@ -342,7 +342,7 @@ static int optee_ffa_shm_unregister_supp(struct tee_context *ctx,
 					 struct tee_shm *shm)
 {
 	struct optee *optee = tee_get_drvdata(ctx->teedev);
-	const struct ffa_dev_ops *ffa_ops = optee->ffa.ffa_dev->ops;
+	const struct ffa_ops *ffa_ops = optee->ffa.ffa_dev->ops;
 	u64 global_handle = shm->sec_world_id;
 	int rc;
 
@@ -530,7 +530,7 @@ static int optee_ffa_yielding_call(struct tee_context *ctx,
 {
 	struct optee *optee = tee_get_drvdata(ctx->teedev);
 	struct ffa_device *ffa_dev = optee->ffa.ffa_dev;
-	const struct ffa_dev_ops *ffa_ops = ffa_dev->ops;
+	const struct ffa_ops *ffa_ops = ffa_dev->ops;
 	struct optee_call_waiter w;
 	u32 cmd = data->data0;
 	u32 w4 = data->data1;
@@ -652,7 +652,7 @@ static int optee_ffa_do_call_with_arg(struct tee_context *ctx,
  */
 
 static bool optee_ffa_api_is_compatbile(struct ffa_device *ffa_dev,
-					const struct ffa_dev_ops *ops)
+					const struct ffa_ops *ops)
 {
 	struct ffa_send_direct_data data = { OPTEE_FFA_GET_API_VERSION };
 	int rc;
@@ -687,7 +687,7 @@ static bool optee_ffa_api_is_compatbile(struct ffa_device *ffa_dev,
 }
 
 static bool optee_ffa_exchange_caps(struct ffa_device *ffa_dev,
-				    const struct ffa_dev_ops *ops,
+				    const struct ffa_ops *ops,
 				    u32 *sec_caps,
 				    unsigned int *rpc_param_count)
 {
@@ -783,7 +783,7 @@ static void optee_ffa_remove(struct ffa_device *ffa_dev)
 
 static int optee_ffa_probe(struct ffa_device *ffa_dev)
 {
-	const struct ffa_dev_ops *ffa_ops;
+	const struct ffa_ops *ffa_ops;
 	unsigned int rpc_param_count;
 	struct tee_shm_pool *pool;
 	struct tee_device *teedev;
diff --git a/include/linux/arm_ffa.h b/include/linux/arm_ffa.h
index eafab07c9f58..4c4b06783035 100644
--- a/include/linux/arm_ffa.h
+++ b/include/linux/arm_ffa.h
@@ -17,7 +17,7 @@ struct ffa_device {
 	bool mode_32bit;
 	uuid_t uuid;
 	struct device dev;
-	const struct ffa_dev_ops *ops;
+	const struct ffa_ops *ops;
 };
 
 #define to_ffa_dev(d) container_of(d, struct ffa_device, dev)
@@ -49,7 +49,7 @@ static inline void *ffa_dev_get_drvdata(struct ffa_device *fdev)
 
 #if IS_REACHABLE(CONFIG_ARM_FFA_TRANSPORT)
 struct ffa_device *ffa_device_register(const uuid_t *uuid, int vm_id,
-				       const struct ffa_dev_ops *ops);
+				       const struct ffa_ops *ops);
 void ffa_device_unregister(struct ffa_device *ffa_dev);
 int ffa_driver_register(struct ffa_driver *driver, struct module *owner,
 			const char *mod_name);
@@ -59,7 +59,7 @@ bool ffa_device_is_valid(struct ffa_device *ffa_dev);
 #else
 static inline
 struct ffa_device *ffa_device_register(const uuid_t *uuid, int vm_id,
-				       const struct ffa_dev_ops *ops)
+				       const struct ffa_ops *ops)
 {
 	return NULL;
 }
@@ -254,7 +254,7 @@ struct ffa_mem_ops_args {
 	struct ffa_mem_region_attributes *attrs;
 };
 
-struct ffa_dev_ops {
+struct ffa_ops {
 	u32 (*api_version_get)(void);
 	int (*partition_info_get)(const char *uuid_str,
 				  struct ffa_partition_info *buffer);
-- 
2.37.3

