Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13E805B078B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 16:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbiIGOxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 10:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiIGOwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 10:52:54 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 448CCACA1C
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 07:52:52 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 317DE1480;
        Wed,  7 Sep 2022 07:52:58 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 925483F71A;
        Wed,  7 Sep 2022 07:52:50 -0700 (PDT)
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
Subject: [PATCH v3 05/10] firmware: arm_ffa: Use FFA_FEATURES to detect if native versions are supported
Date:   Wed,  7 Sep 2022 15:52:35 +0100
Message-Id: <20220907145240.1683088-6-sudeep.holla@arm.com>
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

Currently, the ffa_dev->mode_32bit is use to detect if the native 64-bit
or 32-bit versions of FF-A ABI needs to be used. However for the FF-A
memory ABIs, it is not dependent on the ffa_device(i.e. the partition)
itself, but the partition manager(SPM).

So, the FFA_FEATURES can be use to detect if the native 64bit ABIs are
supported or not and appropriate calls can be made based on that.

Use FFA_FEATURES to detect if native versions of MEM_LEND or MEM_SHARE
are implemented and make of the same to use native memory ABIs later on.

Reviewed-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_ffa/driver.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index 81b8d578b6ea..37a8ee304508 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -163,6 +163,7 @@ struct ffa_drv_info {
 	struct mutex tx_lock; /* lock to protect Tx buffer */
 	void *rx_buffer;
 	void *tx_buffer;
+	bool mem_ops_native;
 };
 
 static struct ffa_drv_info *drv_info;
@@ -597,6 +598,13 @@ static int ffa_features(u32 func_feat_id, u32 input_props,
 	return 0;
 }
 
+static void ffa_set_up_mem_ops_native_flag(void)
+{
+	if (!ffa_features(FFA_FN_NATIVE(MEM_LEND), 0, NULL, NULL) ||
+	    !ffa_features(FFA_FN_NATIVE(MEM_SHARE), 0, NULL, NULL))
+		drv_info->mem_ops_native = true;
+}
+
 static u32 ffa_api_version_get(void)
 {
 	return drv_info->version;
@@ -638,10 +646,10 @@ static int ffa_sync_send_receive(struct ffa_device *dev,
 static int
 ffa_memory_share(struct ffa_device *dev, struct ffa_mem_ops_args *args)
 {
-	if (dev->mode_32bit)
-		return ffa_memory_ops(FFA_MEM_SHARE, args);
+	if (drv_info->mem_ops_native)
+		return ffa_memory_ops(FFA_FN_NATIVE(MEM_SHARE), args);
 
-	return ffa_memory_ops(FFA_FN_NATIVE(MEM_SHARE), args);
+	return ffa_memory_ops(FFA_MEM_SHARE, args);
 }
 
 static int
@@ -654,10 +662,10 @@ ffa_memory_lend(struct ffa_device *dev, struct ffa_mem_ops_args *args)
 	 * however on systems without a hypervisor the responsibility
 	 * falls to the calling kernel driver to prevent access.
 	 */
-	if (dev->mode_32bit)
-		return ffa_memory_ops(FFA_MEM_LEND, args);
+	if (drv_info->mem_ops_native)
+		return ffa_memory_ops(FFA_FN_NATIVE(MEM_LEND), args);
 
-	return ffa_memory_ops(FFA_FN_NATIVE(MEM_LEND), args);
+	return ffa_memory_ops(FFA_MEM_LEND, args);
 }
 
 static const struct ffa_dev_ops ffa_ops = {
@@ -768,6 +776,8 @@ static int __init ffa_init(void)
 
 	ffa_setup_partitions();
 
+	ffa_set_up_mem_ops_native_flag();
+
 	return 0;
 free_pages:
 	if (drv_info->tx_buffer)
-- 
2.37.3

