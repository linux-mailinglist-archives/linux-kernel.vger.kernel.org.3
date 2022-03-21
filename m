Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C36EA4E233C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 10:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345851AbiCUJXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 05:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345834AbiCUJXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 05:23:30 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7FD143442
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 02:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647854525; x=1679390525;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NSz37lo5jIFrpR9cvSDf+RjBw9qiPB5q2YAIoatLyl4=;
  b=ITw+1AJ+1mRii8PiQIbfjoGp29IMjTu49RhjfSkkVxdu8l0j8rSSwO3K
   kMqb713PalYRHDPj7UYZWqSl/hOMRAFBGqE1geQqhO2NLGouboMg504mZ
   Ii+v04TnWiljtVnJTYMAR1km/A76rVifzwF+Ky61ey25OnsSPn5rvdL3L
   D2+ilCNxKIbTdg7ATfopfe+0YAqo2FWZwcuB8QHlFCJiAkI0KLBtWvQ8E
   0HziaJbkKNsw74IESTYdMerOcBCTl7DSIdF25knhTdqdQZIpYWZmFJVsm
   HrgXzAMyJCF5aSit1DCnT2p7QpiE+LH+0Pl/KiiCRxWP81xHPOU0pchG5
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10292"; a="318217263"
X-IronPort-AV: E=Sophos;i="5.90,198,1643702400"; 
   d="scan'208";a="318217263"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 02:22:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,198,1643702400"; 
   d="scan'208";a="784936168"
Received: from pglc00034.png.intel.com ([10.221.207.54])
  by fmsmga006.fm.intel.com with ESMTP; 21 Mar 2022 02:22:01 -0700
From:   kah.jing.lee@intel.com
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     linux-kernel@vger.kernel.org, radu.bacrau@intel.com,
        tien.sung.ang@intel.com, Kah Jing Lee <kah.jing.lee@intel.com>
Subject: [PATCH] firmware: stratix10-rsu: extend RSU driver to get DCMF status
Date:   Mon, 21 Mar 2022 17:21:58 +0800
Message-Id: <20220321092158.16456-1-kah.jing.lee@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kah Jing Lee <kah.jing.lee@intel.com>

Extend RSU driver to get DCMF status.

The status of each DCMF is reported. The currently used DCMF is used as
reference, while the other three are compared against it to determine if
they are corrupted.

DCMF = Decision Configuration Management Firmware.
RSU = Remote System Update

Signed-off-by: Radu Bacrau <radu.bacrau@intel.com>
Signed-off-by: Kah Jing Lee <kah.jing.lee@intel.com>
---
 drivers/firmware/stratix10-rsu.c | 131 +++++++++++++++++++++++++++++--
 1 file changed, 125 insertions(+), 6 deletions(-)

diff --git a/drivers/firmware/stratix10-rsu.c b/drivers/firmware/stratix10-rsu.c
index 9378075d04e9..856bc03ca07c 100644
--- a/drivers/firmware/stratix10-rsu.c
+++ b/drivers/firmware/stratix10-rsu.c
@@ -24,12 +24,16 @@
 #define RSU_DCMF1_MASK			GENMASK_ULL(63, 32)
 #define RSU_DCMF2_MASK			GENMASK_ULL(31, 0)
 #define RSU_DCMF3_MASK			GENMASK_ULL(63, 32)
+#define RSU_DCMF0_STATUS_MASK		GENMASK_ULL(15, 0)
+#define RSU_DCMF1_STATUS_MASK		GENMASK_ULL(31, 16)
+#define RSU_DCMF2_STATUS_MASK		GENMASK_ULL(47, 32)
+#define RSU_DCMF3_STATUS_MASK		GENMASK_ULL(63, 48)
 
 #define RSU_TIMEOUT	(msecs_to_jiffies(SVC_RSU_REQUEST_TIMEOUT_MS))
 
 #define INVALID_RETRY_COUNTER		0xFF
 #define INVALID_DCMF_VERSION		0xFF
-
+#define INVALID_DCMF_STATUS		0xFFFFFFFF
 
 typedef void (*rsu_callback)(struct stratix10_svc_client *client,
 			     struct stratix10_svc_cb_data *data);
@@ -49,6 +53,10 @@ typedef void (*rsu_callback)(struct stratix10_svc_client *client,
  * @dcmf_version.dcmf1: Quartus dcmf1 version
  * @dcmf_version.dcmf2: Quartus dcmf2 version
  * @dcmf_version.dcmf3: Quartus dcmf3 version
+ * @dcmf_status.dcmf0: dcmf0 status
+ * @dcmf_status.dcmf1: dcmf1 status
+ * @dcmf_status.dcmf2: dcmf2 status
+ * @dcmf_status.dcmf3: dcmf3 status
  * @retry_counter: the current image's retry counter
  * @max_retry: the preset max retry value
  */
@@ -73,6 +81,13 @@ struct stratix10_rsu_priv {
 		unsigned int dcmf3;
 	} dcmf_version;
 
+	struct {
+		unsigned int dcmf0;
+		unsigned int dcmf1;
+		unsigned int dcmf2;
+		unsigned int dcmf3;
+	} dcmf_status;
+
 	unsigned int retry_counter;
 	unsigned int max_retry;
 };
@@ -129,7 +144,7 @@ static void rsu_command_callback(struct stratix10_svc_client *client,
 	struct stratix10_rsu_priv *priv = client->priv;
 
 	if (data->status == BIT(SVC_STATUS_NO_SUPPORT))
-		dev_warn(client->dev, "FW doesn't support notify\n");
+		dev_warn(client->dev, "Secure FW doesn't support notify\n");
 	else if (data->status == BIT(SVC_STATUS_ERROR))
 		dev_err(client->dev, "Failure, returned status is %lu\n",
 			BIT(data->status));
@@ -139,7 +154,7 @@ static void rsu_command_callback(struct stratix10_svc_client *client,
 
 /**
  * rsu_retry_callback() - Callback from Intel service layer for getting
- * the current image's retry counter from the firmware
+ * the current image's retry counter from firmware
  * @client: pointer to client
  * @data: pointer to callback data structure
  *
@@ -156,7 +171,7 @@ static void rsu_retry_callback(struct stratix10_svc_client *client,
 	if (data->status == BIT(SVC_STATUS_OK))
 		priv->retry_counter = *counter;
 	else if (data->status == BIT(SVC_STATUS_NO_SUPPORT))
-		dev_warn(client->dev, "FW doesn't support retry\n");
+		dev_warn(client->dev, "Secure FW doesn't support retry\n");
 	else
 		dev_err(client->dev, "Failed to get retry counter %lu\n",
 			BIT(data->status));
@@ -181,7 +196,7 @@ static void rsu_max_retry_callback(struct stratix10_svc_client *client,
 	if (data->status == BIT(SVC_STATUS_OK))
 		priv->max_retry = *max_retry;
 	else if (data->status == BIT(SVC_STATUS_NO_SUPPORT))
-		dev_warn(client->dev, "FW doesn't support max retry\n");
+		dev_warn(client->dev, "Secure FW doesn't support max retry\n");
 	else
 		dev_err(client->dev, "Failed to get max retry %lu\n",
 			BIT(data->status));
@@ -215,6 +230,35 @@ static void rsu_dcmf_version_callback(struct stratix10_svc_client *client,
 	complete(&priv->completion);
 }
 
+/**
+ * rsu_dcmf_status_callback() - Callback from Intel service layer for getting
+ * the DCMF status
+ * @client: pointer to client
+ * @data: pointer to callback data structure
+ *
+ * Callback from Intel service layer for DCMF status
+ */
+static void rsu_dcmf_status_callback(struct stratix10_svc_client *client,
+				     struct stratix10_svc_cb_data *data)
+{
+	struct stratix10_rsu_priv *priv = client->priv;
+	unsigned long long *value = (unsigned long long *)data->kaddr1;
+
+	if (data->status == BIT(SVC_STATUS_OK)) {
+		priv->dcmf_status.dcmf0 = FIELD_GET(RSU_DCMF0_STATUS_MASK,
+						    *value);
+		priv->dcmf_status.dcmf1 = FIELD_GET(RSU_DCMF1_STATUS_MASK,
+						    *value);
+		priv->dcmf_status.dcmf2 = FIELD_GET(RSU_DCMF2_STATUS_MASK,
+						    *value);
+		priv->dcmf_status.dcmf3 = FIELD_GET(RSU_DCMF3_STATUS_MASK,
+						    *value);
+	} else
+		dev_err(client->dev, "failed to get DCMF status\n");
+
+	complete(&priv->completion);
+}
+
 /**
  * rsu_send_msg() - send a message to Intel service layer
  * @priv: pointer to rsu private data
@@ -361,7 +405,8 @@ static ssize_t max_retry_show(struct device *dev,
 	if (!priv)
 		return -ENODEV;
 
-	return sprintf(buf, "0x%08x\n", priv->max_retry);
+	return scnprintf(buf, sizeof(priv->max_retry),
+			 "0x%08x\n", priv->max_retry);
 }
 
 static ssize_t dcmf0_show(struct device *dev,
@@ -408,6 +453,61 @@ static ssize_t dcmf3_show(struct device *dev,
 	return sprintf(buf, "0x%08x\n", priv->dcmf_version.dcmf3);
 }
 
+static ssize_t dcmf0_status_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	struct stratix10_rsu_priv *priv = dev_get_drvdata(dev);
+
+	if (!priv)
+		return -ENODEV;
+
+	if (priv->dcmf_status.dcmf0 == INVALID_DCMF_STATUS)
+		return -EIO;
+
+	return sprintf(buf, "0x%08x\n", priv->dcmf_status.dcmf0);
+}
+
+static ssize_t dcmf1_status_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	struct stratix10_rsu_priv *priv = dev_get_drvdata(dev);
+
+	if (!priv)
+		return -ENODEV;
+
+	if (priv->dcmf_status.dcmf1 == INVALID_DCMF_STATUS)
+		return -EIO;
+
+	return sprintf(buf, "0x%08x\n", priv->dcmf_status.dcmf1);
+}
+
+static ssize_t dcmf2_status_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct stratix10_rsu_priv *priv = dev_get_drvdata(dev);
+
+	if (!priv)
+		return -ENODEV;
+
+	if (priv->dcmf_status.dcmf2 == INVALID_DCMF_STATUS)
+		return -EIO;
+
+	return sprintf(buf, "0x%08x\n", priv->dcmf_status.dcmf2);
+}
+
+static ssize_t dcmf3_status_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	struct stratix10_rsu_priv *priv = dev_get_drvdata(dev);
+
+	if (!priv)
+		return -ENODEV;
+
+	if (priv->dcmf_status.dcmf3 == INVALID_DCMF_STATUS)
+		return -EIO;
+
+	return sprintf(buf, "0x%08x\n", priv->dcmf_status.dcmf3);
+}
 static ssize_t reboot_image_store(struct device *dev,
 				  struct device_attribute *attr,
 				  const char *buf, size_t count)
@@ -484,6 +584,10 @@ static DEVICE_ATTR_RO(dcmf0);
 static DEVICE_ATTR_RO(dcmf1);
 static DEVICE_ATTR_RO(dcmf2);
 static DEVICE_ATTR_RO(dcmf3);
+static DEVICE_ATTR_RO(dcmf0_status);
+static DEVICE_ATTR_RO(dcmf1_status);
+static DEVICE_ATTR_RO(dcmf2_status);
+static DEVICE_ATTR_RO(dcmf3_status);
 static DEVICE_ATTR_WO(reboot_image);
 static DEVICE_ATTR_WO(notify);
 
@@ -500,6 +604,10 @@ static struct attribute *rsu_attrs[] = {
 	&dev_attr_dcmf1.attr,
 	&dev_attr_dcmf2.attr,
 	&dev_attr_dcmf3.attr,
+	&dev_attr_dcmf0_status.attr,
+	&dev_attr_dcmf1_status.attr,
+	&dev_attr_dcmf2_status.attr,
+	&dev_attr_dcmf3_status.attr,
 	&dev_attr_reboot_image.attr,
 	&dev_attr_notify.attr,
 	NULL
@@ -532,6 +640,10 @@ static int stratix10_rsu_probe(struct platform_device *pdev)
 	priv->dcmf_version.dcmf2 = INVALID_DCMF_VERSION;
 	priv->dcmf_version.dcmf3 = INVALID_DCMF_VERSION;
 	priv->max_retry = INVALID_RETRY_COUNTER;
+	priv->dcmf_status.dcmf0 = INVALID_DCMF_STATUS;
+	priv->dcmf_status.dcmf1 = INVALID_DCMF_STATUS;
+	priv->dcmf_status.dcmf2 = INVALID_DCMF_STATUS;
+	priv->dcmf_status.dcmf3 = INVALID_DCMF_STATUS;
 
 	mutex_init(&priv->lock);
 	priv->chan = stratix10_svc_request_channel_byname(&priv->client,
@@ -561,6 +673,13 @@ static int stratix10_rsu_probe(struct platform_device *pdev)
 		stratix10_svc_free_channel(priv->chan);
 	}
 
+	ret = rsu_send_msg(priv, COMMAND_RSU_DCMF_STATUS,
+			   0, rsu_dcmf_status_callback);
+	if (ret) {
+		dev_err(dev, "Error, getting DCMF status %i\n", ret);
+		stratix10_svc_free_channel(priv->chan);
+	}
+
 	ret = rsu_send_msg(priv, COMMAND_RSU_RETRY, 0, rsu_retry_callback);
 	if (ret) {
 		dev_err(dev, "Error, getting RSU retry %i\n", ret);
-- 
2.26.2

