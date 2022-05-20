Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9D8352EE45
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 16:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350384AbiETOde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 10:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350363AbiETOdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 10:33:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 230AB9D4C4
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 07:33:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F22D61BAC
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 14:33:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ED71C34113;
        Fri, 20 May 2022 14:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653057196;
        bh=QLpCoFfmq5b/tzYENSmun6iJdG2Fb0Ne6l7YZzDfvZg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ATFvsW49tMIYn5tn73ment+Taum4NfeU4bVuB9mB4RUkJyOdaKaIBF34dRRP8GqMh
         gkJJNUX2llBkD3EFqp7pvShSrdhX8+zqNMVeCtIrceYAQ/DrP2sNLKu16C0y6Vr7bX
         XyOiy1H6DpZu6TeT1kIZcpItjDDRJatuc0+lBnyMjCd1xGpMZmsUm6Pogi9/kam3ZK
         /eH142Q1JYdDZY9z+HyD78bteEoAq+jLlnjekciVGBNVTjMRXHuArC9YddZUdNZafk
         WL3YBLU0yHwT1rdgu3eZWvID7tLpB6mvSIIlxH9fBilD41YSstP/ArBtTMYjr9qiim
         1cd4sMtNcxu9w==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Tal Cohen <talcohen@habana.ai>
Subject: [PATCH 5/5] habanalabs: use separate structure info for each error collect data
Date:   Fri, 20 May 2022 17:33:04 +0300
Message-Id: <20220520143304.1906895-5-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220520143304.1906895-1-ogabbay@kernel.org>
References: <20220520143304.1906895-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tal Cohen <talcohen@habana.ai>

Create separate info structure for each error type.
The structures shall be used inside the large structure that contains
the last session error.
This is more scalable for adding more errors in the future.

Signed-off-by: Tal Cohen <talcohen@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../habanalabs/common/command_submission.c    |  7 +-
 drivers/misc/habanalabs/common/habanalabs.h   | 71 +++++++++++--------
 .../misc/habanalabs/common/habanalabs_drv.c   |  4 +-
 .../misc/habanalabs/common/habanalabs_ioctl.c | 18 ++---
 drivers/misc/habanalabs/gaudi/gaudi.c         | 15 ++--
 5 files changed, 63 insertions(+), 52 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index d8b6a2a4b210..fb30b7de4aab 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -735,11 +735,10 @@ static void cs_timedout(struct work_struct *work)
 	hdev = cs->ctx->hdev;
 
 	/* Save only the first CS timeout parameters */
-	rc = atomic_cmpxchg(&hdev->last_error.cs_write_disable, 0, 1);
+	rc = atomic_cmpxchg(&hdev->last_error.cs_timeout.write_disable, 0, 1);
 	if (!rc) {
-		hdev->last_error.open_dev_timestamp = hdev->last_successful_open_ktime;
-		hdev->last_error.cs_timeout_timestamp = ktime_get();
-		hdev->last_error.cs_timeout_seq = cs->sequence;
+		hdev->last_error.cs_timeout.timestamp = ktime_get();
+		hdev->last_error.cs_timeout.seq = cs->sequence;
 	}
 
 	switch (cs->type) {
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 99cbed5ef0e6..b0b0f3f89865 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -2568,37 +2568,50 @@ struct hl_clk_throttle {
 };
 
 /**
- * struct last_error_session_info - info about last session in which CS timeout or
- *                                    razwi error occurred.
- * @open_dev_timestamp: device open timestamp.
- * @cs_timeout_timestamp: CS timeout timestamp.
- * @razwi_timestamp: razwi timestamp.
- * @cs_write_disable: if set writing to CS parameters in the structure is disabled so the
- *                    first (root cause) CS timeout will not be overwritten.
- * @razwi_write_disable: if set writing to razwi parameters in the structure is disabled so the
- *                       first (root cause) razwi will not be overwritten.
- * @cs_timeout_seq: CS timeout sequence number.
- * @razwi_addr: address that caused razwi.
- * @razwi_engine_id_1: engine id of the razwi initiator, if it was initiated by engine that does
- *                     not have engine id it will be set to U16_MAX.
- * @razwi_engine_id_2: second engine id of razwi initiator. Might happen that razwi have 2 possible
- *                     engines which one them caused the razwi. In that case, it will contain the
- *                     second possible engine id, otherwise it will be set to U16_MAX.
- * @razwi_non_engine_initiator: in case the initiator of the razwi does not have engine id.
- * @razwi_type: cause of razwi, page fault or access error, otherwise it will be set to U8_MAX.
+ * struct cs_timeout_info - info of last CS timeout occurred.
+ * @timestamp: CS timeout timestamp.
+ * @write_disable: if set writing to CS parameters in the structure is disabled so,
+ *                 the first (root cause) CS timeout will not be overwritten.
+ * @seq: CS timeout sequence number.
+ */
+struct cs_timeout_info {
+	ktime_t		timestamp;
+	atomic_t	write_disable;
+	u64		seq;
+};
+
+/**
+ * struct razwi_info - info about last razwi error occurred.
+ * @timestamp: razwi timestamp.
+ * @write_disable: if set writing to razwi parameters in the structure is disabled so the
+ *                 first (root cause) razwi will not be overwritten.
+ * @addr: address that caused razwi.
+ * @engine_id_1: engine id of the razwi initiator, if it was initiated by engine that does
+ *               not have engine id it will be set to U16_MAX.
+ * @engine_id_2: second engine id of razwi initiator. Might happen that razwi have 2 possible
+ *               engines which one them caused the razwi. In that case, it will contain the
+ *               second possible engine id, otherwise it will be set to U16_MAX.
+ * @non_engine_initiator: in case the initiator of the razwi does not have engine id.
+ * @type: cause of razwi, page fault or access error, otherwise it will be set to U8_MAX.
+ */
+struct razwi_info {
+	ktime_t		timestamp;
+	atomic_t	write_disable;
+	u64		addr;
+	u16		engine_id_1;
+	u16		engine_id_2;
+	u8		non_engine_initiator;
+	u8		type;
+};
+
+/**
+ * struct last_error_session_info - info about last session errors occurred.
+ * @cs_timeout: CS timeout error last information.
+ * @razwi: razwi last information.
  */
 struct last_error_session_info {
-	ktime_t		open_dev_timestamp;
-	ktime_t		cs_timeout_timestamp;
-	ktime_t		razwi_timestamp;
-	atomic_t	cs_write_disable;
-	atomic_t	razwi_write_disable;
-	u64		cs_timeout_seq;
-	u64		razwi_addr;
-	u16		razwi_engine_id_1;
-	u16		razwi_engine_id_2;
-	u8		razwi_non_engine_initiator;
-	u8		razwi_type;
+	struct	cs_timeout_info	cs_timeout;
+	struct	razwi_info	razwi;
 };
 
 /**
diff --git a/drivers/misc/habanalabs/common/habanalabs_drv.c b/drivers/misc/habanalabs/common/habanalabs_drv.c
index 9ead0927208d..37edb69a7255 100644
--- a/drivers/misc/habanalabs/common/habanalabs_drv.c
+++ b/drivers/misc/habanalabs/common/habanalabs_drv.c
@@ -195,8 +195,8 @@ int hl_device_open(struct inode *inode, struct file *filp)
 
 	hl_debugfs_add_file(hpriv);
 
-	atomic_set(&hdev->last_error.cs_write_disable, 0);
-	atomic_set(&hdev->last_error.razwi_write_disable, 0);
+	atomic_set(&hdev->last_error.cs_timeout.write_disable, 0);
+	atomic_set(&hdev->last_error.razwi.write_disable, 0);
 
 	hdev->open_counter++;
 	hdev->last_successful_open_jif = jiffies;
diff --git a/drivers/misc/habanalabs/common/habanalabs_ioctl.c b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
index 8fd2b427863f..c7864d6bb0a1 100644
--- a/drivers/misc/habanalabs/common/habanalabs_ioctl.c
+++ b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
@@ -569,7 +569,7 @@ static int last_err_open_dev_info(struct hl_fpriv *hpriv, struct hl_info_args *a
 	if ((!max_size) || (!out))
 		return -EINVAL;
 
-	info.timestamp = ktime_to_ns(hdev->last_error.open_dev_timestamp);
+	info.timestamp = ktime_to_ns(hdev->last_successful_open_ktime);
 
 	return copy_to_user(out, &info, min_t(size_t, max_size, sizeof(info))) ? -EFAULT : 0;
 }
@@ -584,8 +584,8 @@ static int cs_timeout_info(struct hl_fpriv *hpriv, struct hl_info_args *args)
 	if ((!max_size) || (!out))
 		return -EINVAL;
 
-	info.seq = hdev->last_error.cs_timeout_seq;
-	info.timestamp = ktime_to_ns(hdev->last_error.cs_timeout_timestamp);
+	info.seq = hdev->last_error.cs_timeout.seq;
+	info.timestamp = ktime_to_ns(hdev->last_error.cs_timeout.timestamp);
 
 	return copy_to_user(out, &info, min_t(size_t, max_size, sizeof(info))) ? -EFAULT : 0;
 }
@@ -600,12 +600,12 @@ static int razwi_info(struct hl_fpriv *hpriv, struct hl_info_args *args)
 	if ((!max_size) || (!out))
 		return -EINVAL;
 
-	info.timestamp = ktime_to_ns(hdev->last_error.razwi_timestamp);
-	info.addr = hdev->last_error.razwi_addr;
-	info.engine_id_1 = hdev->last_error.razwi_engine_id_1;
-	info.engine_id_2 = hdev->last_error.razwi_engine_id_2;
-	info.no_engine_id = hdev->last_error.razwi_non_engine_initiator;
-	info.error_type = hdev->last_error.razwi_type;
+	info.timestamp = ktime_to_ns(hdev->last_error.razwi.timestamp);
+	info.addr = hdev->last_error.razwi.addr;
+	info.engine_id_1 = hdev->last_error.razwi.engine_id_1;
+	info.engine_id_2 = hdev->last_error.razwi.engine_id_2;
+	info.no_engine_id = hdev->last_error.razwi.non_engine_initiator;
+	info.error_type = hdev->last_error.razwi.type;
 
 	return copy_to_user(out, &info, min_t(size_t, max_size, sizeof(info))) ? -EFAULT : 0;
 }
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 96a83317b302..fba322241096 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -7404,19 +7404,18 @@ static void gaudi_print_irq_info(struct hl_device *hdev, u16 event_type,
 		gaudi_print_and_get_mmu_error_info(hdev, &razwi_addr, &razwi_type);
 
 		/* In case it's the first razwi, save its parameters*/
-		rc = atomic_cmpxchg(&hdev->last_error.razwi_write_disable, 0, 1);
+		rc = atomic_cmpxchg(&hdev->last_error.razwi.write_disable, 0, 1);
 		if (!rc) {
-			hdev->last_error.open_dev_timestamp = hdev->last_successful_open_ktime;
-			hdev->last_error.razwi_timestamp = ktime_get();
-			hdev->last_error.razwi_addr = razwi_addr;
-			hdev->last_error.razwi_engine_id_1 = engine_id_1;
-			hdev->last_error.razwi_engine_id_2 = engine_id_2;
+			hdev->last_error.razwi.timestamp = ktime_get();
+			hdev->last_error.razwi.addr = razwi_addr;
+			hdev->last_error.razwi.engine_id_1 = engine_id_1;
+			hdev->last_error.razwi.engine_id_2 = engine_id_2;
 			/*
 			 * If first engine id holds non valid value the razwi initiator
 			 * does not have engine id
 			 */
-			hdev->last_error.razwi_non_engine_initiator = (engine_id_1 == U16_MAX);
-			hdev->last_error.razwi_type = razwi_type;
+			hdev->last_error.razwi.non_engine_initiator = (engine_id_1 == U16_MAX);
+			hdev->last_error.razwi.type = razwi_type;
 
 		}
 	}
-- 
2.25.1

