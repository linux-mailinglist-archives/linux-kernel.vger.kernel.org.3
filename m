Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3165B078C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 16:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbiIGOxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 10:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbiIGOwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 10:52:55 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AE4EBAE9C2
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 07:52:53 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B476913D5;
        Wed,  7 Sep 2022 07:52:59 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 215373F71A;
        Wed,  7 Sep 2022 07:52:52 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        op-tee@lists.trustedfirmware.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Marc Bonnici <marc.bonnici@arm.com>,
        Achin Gupta <achin.gupta@arm.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Valentin Laurent <valentin.laurent@trustonic.com>,
        Lukas Hanel <lukas.hanel@trustonic.com>,
        Coboy Chen <coboy.chen@mediatek.com>
Subject: [PATCH v3 06/10] firmware: arm_ffa: Make memory apis ffa_device independent
Date:   Wed,  7 Sep 2022 15:52:36 +0100
Message-Id: <20220907145240.1683088-7-sudeep.holla@arm.com>
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

There is a requirement to make memory APIs independent of the ffa_device.
One of the use-case is to have a common memory driver that manages the
memory for all the ffa_devices. That common memory driver won't be a
ffa_driver or won't have any ffa_device associated with it. So having
these memory APIs accessible without a ffa_device is needed and should
be possible as most of these are handled by the partition manager(SPM
or hypervisor).

Drop the ffa_device argument to the memory APIs and make them ffa_device
independent.

Acked-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_ffa/driver.c | 6 ++----
 drivers/tee/optee/ffa_abi.c       | 2 +-
 include/linux/arm_ffa.h           | 6 ++----
 3 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index 37a8ee304508..e4fd35773071 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -643,8 +643,7 @@ static int ffa_sync_send_receive(struct ffa_device *dev,
 				       dev->mode_32bit, data);
 }
 
-static int
-ffa_memory_share(struct ffa_device *dev, struct ffa_mem_ops_args *args)
+static int ffa_memory_share(struct ffa_mem_ops_args *args)
 {
 	if (drv_info->mem_ops_native)
 		return ffa_memory_ops(FFA_FN_NATIVE(MEM_SHARE), args);
@@ -652,8 +651,7 @@ ffa_memory_share(struct ffa_device *dev, struct ffa_mem_ops_args *args)
 	return ffa_memory_ops(FFA_MEM_SHARE, args);
 }
 
-static int
-ffa_memory_lend(struct ffa_device *dev, struct ffa_mem_ops_args *args)
+static int ffa_memory_lend(struct ffa_mem_ops_args *args)
 {
 	/* Note that upon a successful MEM_LEND request the caller
 	 * must ensure that the memory region specified is not accessed
diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
index 3d4079575ccd..7257b42d0545 100644
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
2.37.3

