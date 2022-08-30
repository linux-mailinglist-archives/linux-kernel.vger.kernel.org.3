Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8EB5A6060
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 12:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbiH3KMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 06:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbiH3KLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 06:11:53 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EB9EEFB0CC
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 03:07:35 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CAF231474;
        Tue, 30 Aug 2022 03:07:41 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6F8F93F766;
        Tue, 30 Aug 2022 03:07:34 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Marc Bonnici <marc.bonnici@arm.com>,
        Achin Gupta <achin.gupta@arm.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Valentin Laurent <valentin.laurent@trustonic.com>,
        Lukas Hanel <lukas.hanel@trustonic.com>,
        Coboy Chen <coboy.chen@mediatek.com>
Subject: [PATCH 6/9] firmware: arm_ffa: Make memory apis ffa_device independent
Date:   Tue, 30 Aug 2022 11:06:57 +0100
Message-Id: <20220830100700.344594-7-sudeep.holla@arm.com>
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

There is a requirement to make memory APIs independent of the ffa_device.
One of the use-case is to have a common memory driver that manages the
memory for all the ffa_devices. That commom memory driver won't be a
ffa_driver or won't have any ffa_device associated with it. So having
these memory APIs accessible without a ffa_device is needed and should
be possible as most of these are handled by the partition manager(SPM
or hypervisor).

Drop the ffa_device argument to the memory APIs and make them ffa_device
independent.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_ffa/driver.c | 6 ++----
 drivers/tee/optee/ffa_abi.c       | 2 +-
 include/linux/arm_ffa.h           | 6 ++----
 3 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index 5f02b670e964..5c8484b05c50 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -640,8 +640,7 @@ static int ffa_sync_send_receive(struct ffa_device *dev,
 				       dev->mode_32bit, data);
 }
 
-static int
-ffa_memory_share(struct ffa_device *dev, struct ffa_mem_ops_args *args)
+static int ffa_memory_share(struct ffa_mem_ops_args *args)
 {
 	if (drv_info->mem_ops_native)
 		return ffa_memory_ops(FFA_FN_NATIVE(MEM_SHARE), args);
@@ -649,8 +648,7 @@ ffa_memory_share(struct ffa_device *dev, struct ffa_mem_ops_args *args)
 	return ffa_memory_ops(FFA_MEM_SHARE, args);
 }
 
-static int
-ffa_memory_lend(struct ffa_device *dev, struct ffa_mem_ops_args *args)
+static int ffa_memory_lend(struct ffa_mem_ops_args *args)
 {
 	/* Note that upon a successful MEM_LEND request the caller
 	 * must ensure that the memory region specified is not accessed
diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
index 4c3b5d0008dd..7ec0a2f9a63b 100644
--- a/drivers/tee/optee/ffa_abi.c
+++ b/drivers/tee/optee/ffa_abi.c
@@ -294,7 +294,7 @@ static int optee_ffa_shm_register(struct tee_context *ctx, struct tee_shm *shm,
 	if (rc)
 		return rc;
 	args.sg = sgt.sgl;
-	rc = ffa_ops->memory_share(ffa_dev, &args);
+	rc = ffa_ops->memory_share(&args);
 	sg_free_table(&sgt);
 	if (rc)
 		return rc;
diff --git a/include/linux/arm_ffa.h b/include/linux/arm_ffa.h
index 556f50f27fb1..eafab07c9f58 100644
--- a/include/linux/arm_ffa.h
+++ b/include/linux/arm_ffa.h
@@ -262,10 +262,8 @@ struct ffa_dev_ops {
 	int (*sync_send_receive)(struct ffa_device *dev,
 				 struct ffa_send_direct_data *data);
 	int (*memory_reclaim)(u64 g_handle, u32 flags);
-	int (*memory_share)(struct ffa_device *dev,
-			    struct ffa_mem_ops_args *args);
-	int (*memory_lend)(struct ffa_device *dev,
-			   struct ffa_mem_ops_args *args);
+	int (*memory_share)(struct ffa_mem_ops_args *args);
+	int (*memory_lend)(struct ffa_mem_ops_args *args);
 };
 
 #endif /* _LINUX_ARM_FFA_H */
-- 
2.37.2

