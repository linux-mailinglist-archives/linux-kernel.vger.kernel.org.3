Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E31EA5A1311
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 16:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241471AbiHYOMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 10:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240732AbiHYOMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 10:12:18 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E1C4B65826
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 07:12:16 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B81515BF;
        Thu, 25 Aug 2022 07:12:21 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D37513F71A;
        Thu, 25 Aug 2022 07:12:14 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, wleavitt@marvell.com,
        peter.hilber@opensynergy.com, nicola.mazzucato@arm.com,
        tarek.el-sherbiny@arm.com, cristian.marussi@arm.com
Subject: [PATCH v2 3/9] firmware: arm_scmi: Use dedicated devices to initialize channels
Date:   Thu, 25 Aug 2022 15:11:46 +0100
Message-Id: <20220825141152.2334536-4-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220825141152.2334536-1-cristian.marussi@arm.com>
References: <20220825141152.2334536-1-cristian.marussi@arm.com>
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

Refactor channels initialization to use dedicated devices instead of using
devices borrowed from the SCMI drivers.

Initialize all channels as described in the DT upfront.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/driver.c | 94 ++++++++++++++++++++++--------
 1 file changed, 70 insertions(+), 24 deletions(-)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 62e02b6475ff..56b1a917f618 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -2019,23 +2019,20 @@ static int scmi_xfer_info_init(struct scmi_info *sinfo)
 	return ret;
 }
 
-static int scmi_chan_setup(struct scmi_info *info, struct device *dev,
+static int scmi_chan_setup(struct scmi_info *info, struct device_node *of_node,
 			   int prot_id, bool tx)
 {
 	int ret, idx;
+	char name[32];
 	struct scmi_chan_info *cinfo;
 	struct idr *idr;
+	struct scmi_device *tdev = NULL;
 
 	/* Transmit channel is first entry i.e. index 0 */
 	idx = tx ? 0 : 1;
 	idr = tx ? &info->tx_idr : &info->rx_idr;
 
-	/* check if already allocated, used for multiple device per protocol */
-	cinfo = idr_find(idr, prot_id);
-	if (cinfo)
-		return 0;
-
-	if (!info->desc->ops->chan_available(dev->of_node, idx)) {
+	if (!info->desc->ops->chan_available(of_node, idx)) {
 		cinfo = idr_find(idr, SCMI_PROTOCOL_BASE);
 		if (unlikely(!cinfo)) /* Possible only if platform has no Rx */
 			return -EINVAL;
@@ -2046,26 +2043,41 @@ static int scmi_chan_setup(struct scmi_info *info, struct device *dev,
 	if (!cinfo)
 		return -ENOMEM;
 
-	cinfo->dev = dev;
+	/* Create a unique name for this transport device */
+	snprintf(name, 32, "__scmi_transport_device_%s_%02X",
+		 idx ? "rx" : "tx", prot_id);
+	/* Create a uniquely named, dedicated transport device for this chan */
+	tdev = scmi_device_create(of_node, info->dev, prot_id, name);
+	if (!tdev) {
+		devm_kfree(info->dev, cinfo);
+		return -EINVAL;
+	}
 
+	cinfo->dev = &tdev->dev;
 	ret = info->desc->ops->chan_setup(cinfo, info->dev, tx);
-	if (ret)
+	if (ret) {
+		scmi_device_destroy(tdev);
+		devm_kfree(info->dev, cinfo);
 		return ret;
+	}
 
 	if (tx && is_polling_required(cinfo, info)) {
 		if (is_transport_polling_capable(info))
-			dev_info(dev,
+			dev_info(&tdev->dev,
 				 "Enabled polling mode TX channel - prot_id:%d\n",
 				 prot_id);
 		else
-			dev_warn(dev,
+			dev_warn(&tdev->dev,
 				 "Polling mode NOT supported by transport.\n");
 	}
 
 idr_alloc:
 	ret = idr_alloc(idr, cinfo, prot_id, prot_id + 1, GFP_KERNEL);
 	if (ret != prot_id) {
-		dev_err(dev, "unable to allocate SCMI idr slot err %d\n", ret);
+		dev_err(info->dev,
+			"unable to allocate SCMI idr slot err %d\n", ret);
+		if (tdev)
+			scmi_device_destroy(tdev);
 		return ret;
 	}
 
@@ -2074,16 +2086,57 @@ static int scmi_chan_setup(struct scmi_info *info, struct device *dev,
 }
 
 static inline int
-scmi_txrx_setup(struct scmi_info *info, struct device *dev, int prot_id)
+scmi_txrx_setup(struct scmi_info *info, struct device_node *of_node,
+		int prot_id)
 {
-	int ret = scmi_chan_setup(info, dev, prot_id, true);
+	int ret = scmi_chan_setup(info, of_node, prot_id, true);
 
 	if (!ret) /* Rx is optional, hence no error check */
-		scmi_chan_setup(info, dev, prot_id, false);
+		scmi_chan_setup(info, of_node, prot_id, false);
 
 	return ret;
 }
 
+/**
+ * scmi_channels_setup  - Helper to initialize all required channels
+ *
+ * @info: The SCMI instance descriptor.
+ *
+ * Initialize all the channels found described in the DT against the underlying
+ * configured transport using custom defined dedicated devices instead of
+ * borrowing devices from the SCMI drivers; this way channels are initialized
+ * upfront during core SCMI stack probing and are operational even if then no
+ * SCMI driver is loaded. (useful to operate in Raw mode)
+ *
+ * Return: 0 on Success
+ */
+static int scmi_channels_setup(struct scmi_info *info)
+{
+	int ret;
+	struct device_node *child, *top_np = info->dev->of_node;
+
+	ret = scmi_txrx_setup(info, top_np, SCMI_PROTOCOL_BASE);
+	if (ret)
+		return ret;
+
+	for_each_available_child_of_node(top_np, child) {
+		u32 prot_id;
+
+		if (of_property_read_u32(child, "reg", &prot_id))
+			continue;
+
+		if (!FIELD_FIT(MSG_PROTOCOL_ID_MASK, prot_id))
+			dev_err(info->dev,
+				"Out of range protocol %d\n", prot_id);
+
+		ret = scmi_txrx_setup(info, child, prot_id);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 /**
  * scmi_get_protocol_device  - Helper to get/create an SCMI device.
  *
@@ -2133,14 +2186,6 @@ scmi_get_protocol_device(struct device_node *np, struct scmi_info *info,
 		return NULL;
 	}
 
-	if (scmi_txrx_setup(info, &sdev->dev, prot_id)) {
-		dev_err(&sdev->dev, "failed to setup transport\n");
-		scmi_device_destroy(sdev);
-		mutex_unlock(&scmi_syspower_mtx);
-
-		return NULL;
-	}
-
 	if (prot_id == SCMI_PROTOCOL_SYSTEM)
 		scmi_syspower_registered = true;
 
@@ -2432,7 +2477,8 @@ static int scmi_probe(struct platform_device *pdev)
 			return ret;
 	}
 
-	ret = scmi_txrx_setup(info, dev, SCMI_PROTOCOL_BASE);
+	/* Setup all channels described in the DT at first */
+	ret = scmi_channels_setup(info);
 	if (ret)
 		return ret;
 
-- 
2.32.0

