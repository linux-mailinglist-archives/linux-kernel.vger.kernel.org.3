Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF8D56521F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 12:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233787AbiGDKWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 06:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234230AbiGDKVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 06:21:46 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 67F0FDFE9
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 03:19:52 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 80C99152B;
        Mon,  4 Jul 2022 03:19:52 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4E1DF3F792;
        Mon,  4 Jul 2022 03:19:51 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, f.fainelli@gmail.com,
        vincent.guittot@linaro.org,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH v2 3/4] firmware: arm_scmi: Add devm_protocol_acquire helper
Date:   Mon,  4 Jul 2022 11:19:32 +0100
Message-Id: <20220704101933.2981635-4-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220704101933.2981635-1-cristian.marussi@arm.com>
References: <20220704101933.2981635-1-cristian.marussi@arm.com>
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

Add a method to get hold of a protocol, causing it to be initialized and
its resource accounting updated, without getting access to its operations
and handle.

Some protocols, like SCMI SystemPower, do not expose any protocol ops to
the Kernel OSPM agent but still need to be at least initialized: this
helper avoids the need to invoke a full devm_get_protocol() only to get
the protocol initialized while throwing away unused the protocol ops and
handle.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/driver.c | 70 +++++++++++++++++++++++-------
 include/linux/scmi_protocol.h      |  5 +++
 2 files changed, 60 insertions(+), 15 deletions(-)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 48392a8a8dcd..38600e320320 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -1667,6 +1667,30 @@ static void scmi_devm_release_protocol(struct device *dev, void *res)
 	scmi_protocol_release(dres->handle, dres->protocol_id);
 }
 
+static struct scmi_protocol_instance __must_check *
+scmi_devres_protocol_instance_get(struct scmi_device *sdev, u8 protocol_id)
+{
+	struct scmi_protocol_instance *pi;
+	struct scmi_protocol_devres *dres;
+
+	dres = devres_alloc(scmi_devm_release_protocol,
+			    sizeof(*dres), GFP_KERNEL);
+	if (!dres)
+		return ERR_PTR(-ENOMEM);
+
+	pi = scmi_get_protocol_instance(sdev->handle, protocol_id);
+	if (IS_ERR(pi)) {
+		devres_free(dres);
+		return pi;
+	}
+
+	dres->handle = sdev->handle;
+	dres->protocol_id = protocol_id;
+	devres_add(&sdev->dev, dres);
+
+	return pi;
+}
+
 /**
  * scmi_devm_protocol_get  - Devres managed get protocol operations and handle
  * @sdev: A reference to an scmi_device whose embedded struct device is to
@@ -1690,32 +1714,47 @@ scmi_devm_protocol_get(struct scmi_device *sdev, u8 protocol_id,
 		       struct scmi_protocol_handle **ph)
 {
 	struct scmi_protocol_instance *pi;
-	struct scmi_protocol_devres *dres;
-	struct scmi_handle *handle = sdev->handle;
 
 	if (!ph)
 		return ERR_PTR(-EINVAL);
 
-	dres = devres_alloc(scmi_devm_release_protocol,
-			    sizeof(*dres), GFP_KERNEL);
-	if (!dres)
-		return ERR_PTR(-ENOMEM);
-
-	pi = scmi_get_protocol_instance(handle, protocol_id);
-	if (IS_ERR(pi)) {
-		devres_free(dres);
+	pi = scmi_devres_protocol_instance_get(sdev, protocol_id);
+	if (IS_ERR(pi))
 		return pi;
-	}
-
-	dres->handle = handle;
-	dres->protocol_id = protocol_id;
-	devres_add(&sdev->dev, dres);
 
 	*ph = &pi->ph;
 
 	return pi->proto->ops;
 }
 
+/**
+ * scmi_devm_protocol_acquire  - Devres managed helper to get hold of a protocol
+ * @sdev: A reference to an scmi_device whose embedded struct device is to
+ *	  be used for devres accounting.
+ * @protocol_id: The protocol being requested.
+ *
+ * Get hold of a protocol accounting for its usage, possibly triggering its
+ * initialization but without getting access to its protocol specific operations
+ * and handle.
+ *
+ * Being a devres based managed method, protocol hold will be automatically
+ * released, and possibly de-initialized on last user, once the SCMI driver
+ * owning the scmi_device is unbound from it.
+ *
+ * Return: 0 on SUCCESS
+ */
+static int __must_check scmi_devm_protocol_acquire(struct scmi_device *sdev,
+						   u8 protocol_id)
+{
+	struct scmi_protocol_instance *pi;
+
+	pi = scmi_devres_protocol_instance_get(sdev, protocol_id);
+	if (IS_ERR(pi))
+		return PTR_ERR(pi);
+
+	return 0;
+}
+
 static int scmi_devm_protocol_match(struct device *dev, void *res, void *data)
 {
 	struct scmi_protocol_devres *dres = res;
@@ -2320,6 +2359,7 @@ static int scmi_probe(struct platform_device *pdev)
 	handle = &info->handle;
 	handle->dev = info->dev;
 	handle->version = &info->version;
+	handle->devm_protocol_acquire = scmi_devm_protocol_acquire;
 	handle->devm_protocol_get = scmi_devm_protocol_get;
 	handle->devm_protocol_put = scmi_devm_protocol_put;
 
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index 10b9c0e9fdf5..7f4f9df1b20f 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -734,6 +734,9 @@ struct scmi_notify_ops {
  *
  * @dev: pointer to the SCMI device
  * @version: pointer to the structure containing SCMI version information
+ * @devm_protocol_acquire: devres managed method to get hold of a protocol,
+ *			   causing its initialization and related resource
+ *			   accounting
  * @devm_protocol_get: devres managed method to acquire a protocol and get specific
  *		       operations and a dedicated protocol handler
  * @devm_protocol_put: devres managed method to release a protocol
@@ -752,6 +755,8 @@ struct scmi_handle {
 	struct device *dev;
 	struct scmi_revision_info *version;
 
+	int __must_check (*devm_protocol_acquire)(struct scmi_device *sdev,
+						  u8 proto);
 	const void __must_check *
 		(*devm_protocol_get)(struct scmi_device *sdev, u8 proto,
 				     struct scmi_protocol_handle **ph);
-- 
2.32.0

