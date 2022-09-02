Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D181D5AB31B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 16:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238958AbiIBOMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 10:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238877AbiIBOLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 10:11:41 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 92A111181D
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 06:39:48 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6E7FC1596;
        Fri,  2 Sep 2022 05:41:02 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E59503F766;
        Fri,  2 Sep 2022 05:40:54 -0700 (PDT)
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
Subject: [PATCH v2 09/10] firmware: arm_ffa: Set up 32bit execution mode flag using partiion property
Date:   Fri,  2 Sep 2022 13:40:31 +0100
Message-Id: <20220902124032.788488-10-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220902124032.788488-1-sudeep.holla@arm.com>
References: <20220902124032.788488-1-sudeep.holla@arm.com>
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

FF-A v1.1 adds a flag in the partition properties to indicate if the
partition runs in the AArch32 or AArch64 execution state. Use the same
to set-up the 32-bit execution flag mode in the ffa_dev automatically
and ignore any requests to do the same from the ffa_driver.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_ffa/driver.c | 13 ++++++++++++-
 include/linux/arm_ffa.h           |  2 ++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index dd6ab2f81580..dbbe15592173 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -647,11 +647,19 @@ static int ffa_partition_info_get(const char *uuid_str,
 	return 0;
 }
 
-static void ffa_mode_32bit_set(struct ffa_device *dev)
+static void _ffa_mode_32bit_set(struct ffa_device *dev)
 {
 	dev->mode_32bit = true;
 }
 
+static void ffa_mode_32bit_set(struct ffa_device *dev)
+{
+	if (drv_info->version > FFA_VERSION_1_0)
+		return;
+
+	_ffa_mode_32bit_set(dev);
+}
+
 static int ffa_sync_send_receive(struct ffa_device *dev,
 				 struct ffa_send_direct_data *data)
 {
@@ -743,6 +751,9 @@ static void ffa_setup_partitions(void)
 			       __func__, tpbuf->id);
 			continue;
 		}
+
+		if (tpbuf->properties & FFA_PARTITION_AARCH64_EXEC)
+			_ffa_mode_32bit_set(ffa_dev);
 	}
 	kfree(pbuf);
 }
diff --git a/include/linux/arm_ffa.h b/include/linux/arm_ffa.h
index 09567ffd1f49..5964b6104996 100644
--- a/include/linux/arm_ffa.h
+++ b/include/linux/arm_ffa.h
@@ -106,6 +106,8 @@ struct ffa_partition_info {
 #define FFA_PARTITION_DIRECT_SEND	BIT(1)
 /* partition can send and receive indirect messages. */
 #define FFA_PARTITION_INDIRECT_MSG	BIT(2)
+/* partition runs in the AArch64 execution state. */
+#define FFA_PARTITION_AARCH64_EXEC	BIT(8)
 	u32 properties;
 	u32 uuid[4];
 };
-- 
2.37.3

