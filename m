Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5A605AB253
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 15:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236362AbiIBN4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 09:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238570AbiIBNzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 09:55:19 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6F357EEC6B
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 06:29:28 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DE1081595;
        Fri,  2 Sep 2022 05:41:00 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6259D3F766;
        Fri,  2 Sep 2022 05:40:53 -0700 (PDT)
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
Subject: [PATCH v2 08/10] firmware: arm_ffa: Add v1.1 get_partition_info support
Date:   Fri,  2 Sep 2022 13:40:30 +0100
Message-Id: <20220902124032.788488-9-sudeep.holla@arm.com>
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

FF-A v1.1 adds support to discovery the UUIDs of the partitions that was
missing in v1.0 and which the driver workarounds by using UUIDs supplied
by the ffa_drivers.

Add the v1.1 get_partition_info support and disable the workaround if
the detected FF-A version is greater than v1.0.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_ffa/driver.c | 42 +++++++++++++++++++++++++------
 include/linux/arm_ffa.h           |  1 +
 2 files changed, 35 insertions(+), 8 deletions(-)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index 2532e0f16cc9..dd6ab2f81580 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -264,18 +264,24 @@ static int ffa_rxtx_unmap(u16 vm_id)
 	return 0;
 }
 
+#define PARTITION_INFO_GET_RETURN_COUNT_ONLY	BIT(0)
+
 /* buffer must be sizeof(struct ffa_partition_info) * num_partitions */
 static int
 __ffa_partition_info_get(u32 uuid0, u32 uuid1, u32 uuid2, u32 uuid3,
 			 struct ffa_partition_info *buffer, int num_partitions)
 {
-	int count;
+	int idx, count, flags = 0, size;
 	ffa_value_t partition_info;
 
+	if (!buffer || !num_partitions) /* Just get the count for now */
+		flags = PARTITION_INFO_GET_RETURN_COUNT_ONLY;
+
 	mutex_lock(&drv_info->rx_lock);
 	invoke_ffa_fn((ffa_value_t){
 		      .a0 = FFA_PARTITION_INFO_GET,
 		      .a1 = uuid0, .a2 = uuid1, .a3 = uuid2, .a4 = uuid3,
+		      .a5 = flags,
 		      }, &partition_info);
 
 	if (partition_info.a0 == FFA_ERROR) {
@@ -285,8 +291,18 @@ __ffa_partition_info_get(u32 uuid0, u32 uuid1, u32 uuid2, u32 uuid3,
 
 	count = partition_info.a2;
 
+	if (drv_info->version > FFA_VERSION_1_0) {
+		size = partition_info.a3;
+		if (size > sizeof(*buffer))
+			size = sizeof(*buffer);
+	} else {
+		size = 8; /* FFA_VERSION_1_0 lacks size in the response */
+	}
+
 	if (buffer && count <= num_partitions)
-		memcpy(buffer, drv_info->rx_buffer, sizeof(*buffer) * count);
+		for (idx = 0; idx < count; idx++)
+			memcpy(buffer + idx, drv_info->rx_buffer + idx * size,
+			       size);
 
 	ffa_rx_release();
 
@@ -681,6 +697,14 @@ void ffa_device_match_uuid(struct ffa_device *ffa_dev, const uuid_t *uuid)
 	int count, idx;
 	struct ffa_partition_info *pbuf, *tpbuf;
 
+	/*
+	 * FF-A v1.1 provides UUID for each partition as part of the discovery
+	 * API, the discovered UUID must be populated in the device's UUID and
+	 * there is no need to copy the same from the driver table.
+	 */
+	if (drv_info->version > FFA_VERSION_1_0)
+		return;
+
 	count = ffa_partition_probe(uuid, &pbuf);
 	if (count <= 0)
 		return;
@@ -694,6 +718,7 @@ void ffa_device_match_uuid(struct ffa_device *ffa_dev, const uuid_t *uuid)
 static void ffa_setup_partitions(void)
 {
 	int count, idx;
+	uuid_t uuid;
 	struct ffa_device *ffa_dev;
 	struct ffa_partition_info *pbuf, *tpbuf;
 
@@ -704,14 +729,15 @@ static void ffa_setup_partitions(void)
 	}
 
 	for (idx = 0, tpbuf = pbuf; idx < count; idx++, tpbuf++) {
-		/* Note that the &uuid_null parameter will require
+		import_uuid(&uuid, (u8 *)tpbuf->uuid);
+
+		/* Note that if the UUID will be uuid_null, that will require
 		 * ffa_device_match() to find the UUID of this partition id
-		 * with help of ffa_device_match_uuid(). Once the FF-A spec
-		 * is updated to provide correct UUID here for each partition
-		 * as part of the discovery API, we need to pass the
-		 * discovered UUID here instead.
+		 * with help of ffa_device_match_uuid(). FF-A v1.1 and above
+		 * provides UUID here for each partition as part of the
+		 * discovery API and the same is passed.
 		 */
-		ffa_dev = ffa_device_register(&uuid_null, tpbuf->id, &ffa_ops);
+		ffa_dev = ffa_device_register(&uuid, tpbuf->id, &ffa_ops);
 		if (!ffa_dev) {
 			pr_err("%s: failed to register partition ID 0x%x\n",
 			       __func__, tpbuf->id);
diff --git a/include/linux/arm_ffa.h b/include/linux/arm_ffa.h
index 4c4b06783035..09567ffd1f49 100644
--- a/include/linux/arm_ffa.h
+++ b/include/linux/arm_ffa.h
@@ -107,6 +107,7 @@ struct ffa_partition_info {
 /* partition can send and receive indirect messages. */
 #define FFA_PARTITION_INDIRECT_MSG	BIT(2)
 	u32 properties;
+	u32 uuid[4];
 };
 
 /* For use with FFA_MSG_SEND_DIRECT_{REQ,RESP} which pass data via registers */
-- 
2.37.3

