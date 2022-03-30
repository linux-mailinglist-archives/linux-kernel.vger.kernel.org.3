Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1AB4EB7E9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 03:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241696AbiC3Bo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 21:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241691AbiC3Box (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 21:44:53 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E871F181170
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 18:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648604588; x=1680140588;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cBP3+rPsvboNFrLtw9wxDJU44mX2ElzZO1PSlsLD6T8=;
  b=ZdXFsPwaADS/0+z0P9P5IiAKuXmunnKh65CYt/LHW5ofKkN6lkRDW6hy
   Iu7KvcugWlvTVCjydMWWuDl7Q7NUV8l8b7X9N7/vngQw3c1Ke39ZdWOv2
   0GfXNeFxYZAPPH+sq6I1uBzLQCHl0ndoR2IDFIagAG38FlDyggmRYHYeJ
   9CYg8KmezRYGoNzagS7QHIuLrItZchCNnQ2Y4rW+Uts8zVpog4SeKY68H
   YpsDjGOZiJg6xZie5n0+WQtNs6MczEANc/G1cAK901qrNoTF/9PtCN9iT
   p0I+ShraSXtfoONqUxIsErcJwQ2u3fT7gecwQKlnBRhNlMumPa16GiJb3
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="239351337"
X-IronPort-AV: E=Sophos;i="5.90,221,1643702400"; 
   d="scan'208";a="239351337"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 18:43:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,221,1643702400"; 
   d="scan'208";a="694935431"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.87])
  by fmsmga001.fm.intel.com with ESMTP; 29 Mar 2022 18:43:06 -0700
From:   kah.jing.lee@intel.com
To:     dinguyen@kernel.org
Cc:     linux-kernel@vger.kernel.org, kah.jing.lee@intel.com,
        Radu Bacrau <radu.bacrau@intel.com>,
        Ang Tien Sung <tien.sung.ang@intel.com>
Subject: [PATCH v4] firmware: stratix10-rsu & svc: extend RSU & svc driver to get DCMF status
Date:   Wed, 30 Mar 2022 17:42:53 +0800
Message-Id: <20220330094253.3248179-2-kah.jing.lee@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220330094253.3248179-1-kah.jing.lee@intel.com>
References: <be70b809-659e-9a7e-2819-c38450c1014e@kernel.org>
 <20220330094253.3248179-1-kah.jing.lee@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lee Kah Jing <kah.jing.lee@intel.com>

Extend RSU driver & Intel Stratix10 service layer driver to get DCMF status
reporting.

The status of each DCMF is reported. The currently used DCMF is used as
reference, while the other three are compared against it to determine if
they are corrupted.

DCMF = Decision Configuration Management Firmware.
RSU = Remote System Update

Signed-off-by: Radu Bacrau <radu.bacrau@intel.com>
Signed-off-by: Ang Tien Sung <tien.sung.ang@intel.com>
Signed-off-by: Lee Kah Jing <kah.jing.lee@intel.com>
---
Changelog v2:
* Fix the compilation error missing header file for COMMAND_RSU_DCMF_STATUS
---
Changelog v3:
* Resent, miss spacing
---
Changelog v4:
* Squash the stratix10-svc together, since stratix-rsu requires underlying 
svc call to retrieve DCMF status in order to work
---
 drivers/firmware/stratix10-rsu.c              | 131 +++++++++++++++++-
 drivers/firmware/stratix10-svc.c              |  20 ++-
 include/linux/firmware/intel/stratix10-smc.h  |  24 +++-
 .../firmware/intel/stratix10-svc-client.h     |   7 +-
 4 files changed, 166 insertions(+), 16 deletions(-)

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
diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index 29c0a616b317..32d86f6f1f0f 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -306,6 +306,7 @@ static void svc_thread_recv_status_ok(struct stratix10_svc_data *p_data,
 		break;
 	case COMMAND_RSU_RETRY:
 	case COMMAND_RSU_MAX_RETRY:
+	case COMMAND_RSU_DCMF_STATUS:
 		cb_data->status = BIT(SVC_STATUS_OK);
 		cb_data->kaddr1 = &res.a1;
 		break;
@@ -422,6 +423,11 @@ static int svc_normal_to_secure_thread(void *data)
 			a1 = 0;
 			a2 = 0;
 			break;
+		case COMMAND_RSU_DCMF_STATUS:
+			a0 = INTEL_SIP_SMC_RSU_DCMF_STATUS;
+			a1 = 0;
+			a2 = 0;
+			break;
 		default:
 			pr_warn("it shouldn't happen\n");
 			break;
@@ -477,9 +483,10 @@ static int svc_normal_to_secure_thread(void *data)
 		case INTEL_SIP_SMC_RSU_ERROR:
 			pr_err("%s: STATUS_ERROR\n", __func__);
 			cbdata->status = BIT(SVC_STATUS_ERROR);
-			cbdata->kaddr1 = NULL;
-			cbdata->kaddr2 = NULL;
-			cbdata->kaddr3 = NULL;
+			cbdata->kaddr1 = &res.a1;
+			cbdata->kaddr2 = (res.a2) ?
+				svc_pa_to_va(res.a2) : NULL;
+			cbdata->kaddr3 = (res.a3) ? &res.a3 : NULL;
 			pdata->chan->scl->receive_cb(pdata->chan->scl, cbdata);
 			break;
 		default:
@@ -487,11 +494,10 @@ static int svc_normal_to_secure_thread(void *data)
 
 			/*
 			 * be compatible with older version firmware which
-			 * doesn't support RSU notify or retry
+			 * doesn't support newer RSU commands
 			 */
-			if ((pdata->command == COMMAND_RSU_RETRY) ||
-			    (pdata->command == COMMAND_RSU_MAX_RETRY) ||
-				(pdata->command == COMMAND_RSU_NOTIFY)) {
+			if ((pdata->command != COMMAND_RSU_UPDATE) &&
+			    (pdata->command != COMMAND_RSU_STATUS)) {
 				cbdata->status =
 					BIT(SVC_STATUS_NO_SUPPORT);
 				cbdata->kaddr1 = NULL;
diff --git a/include/linux/firmware/intel/stratix10-smc.h b/include/linux/firmware/intel/stratix10-smc.h
index c3e5ab014caf..b20b486edace 100644
--- a/include/linux/firmware/intel/stratix10-smc.h
+++ b/include/linux/firmware/intel/stratix10-smc.h
@@ -321,8 +321,6 @@ INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FPGA_CONFIG_COMPLETED_WRITE)
 #define INTEL_SIP_SMC_ECC_DBE \
 	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_ECC_DBE)
 
-#endif
-
 /**
  * Request INTEL_SIP_SMC_RSU_NOTIFY
  *
@@ -404,3 +402,25 @@ INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FPGA_CONFIG_COMPLETED_WRITE)
 #define INTEL_SIP_SMC_FUNCID_RSU_MAX_RETRY 18
 #define INTEL_SIP_SMC_RSU_MAX_RETRY \
 	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_RSU_MAX_RETRY)
+
+/**
+ * Request INTEL_SIP_SMC_RSU_DCMF_STATUS
+ *
+ * Sync call used by service driver at EL1 to query DCMF status from FW
+ *
+ * Call register usage:
+ * a0 INTEL_SIP_SMC_RSU_DCMF_STATUS
+ * a1-7 not used
+ *
+ * Return status
+ * a0 INTEL_SIP_SMC_STATUS_OK
+ * a1 dcmf3 | dcmf2 | dcmf1 | dcmf0
+ *
+ * Or
+ *
+ * a0 INTEL_SIP_SMC_RSU_ERROR
+ */
+#define INTEL_SIP_SMC_FUNCID_RSU_DCMF_STATUS 20
+#define INTEL_SIP_SMC_RSU_DCMF_STATUS \
+	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_RSU_DCMF_STATUS)
+#endif
diff --git a/include/linux/firmware/intel/stratix10-svc-client.h b/include/linux/firmware/intel/stratix10-svc-client.h
index 19781b0f6429..daaa861bd7a6 100644
--- a/include/linux/firmware/intel/stratix10-svc-client.h
+++ b/include/linux/firmware/intel/stratix10-svc-client.h
@@ -104,6 +104,9 @@ struct stratix10_svc_chan;
  *
  * @COMMAND_RSU_DCMF_VERSION: query firmware for the DCMF version, return status
  * is SVC_STATUS_OK or SVC_STATUS_ERROR
+ *
+ * @COMMAND_RSU_DCMF_STATUS: query firmware for the DCMF status
+ * return status is SVC_STATUS_OK or SVC_STATUS_ERROR
  */
 enum stratix10_svc_command_code {
 	COMMAND_NOOP = 0,
@@ -111,12 +114,14 @@ enum stratix10_svc_command_code {
 	COMMAND_RECONFIG_DATA_SUBMIT,
 	COMMAND_RECONFIG_DATA_CLAIM,
 	COMMAND_RECONFIG_STATUS,
-	COMMAND_RSU_STATUS,
+	/* for RSU */
+	COMMAND_RSU_STATUS = 10,
 	COMMAND_RSU_UPDATE,
 	COMMAND_RSU_NOTIFY,
 	COMMAND_RSU_RETRY,
 	COMMAND_RSU_MAX_RETRY,
 	COMMAND_RSU_DCMF_VERSION,
+	COMMAND_RSU_DCMF_STATUS,
 };
 
 /**
-- 
2.25.1

