Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 554D85B1259
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 04:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbiIHCGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 22:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiIHCGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 22:06:12 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B7CADCD2
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 19:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662602771; x=1694138771;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cwyIneQDYmXvAFfgDqQkbLNXcw1T1FsKuFKsibrJ0v0=;
  b=W05wEa8Ry5Yu0pTMiR+QsaP6Tqugnkb6sBXpdo7BKhjZgLAeJUFYwM/C
   2db10mfq9atihDp3SP1i/bLgP96t4MCmxXQpSNMyrI82oUfMocERMRdIQ
   DckvrgawRCM4h9kr4RX7Wn1fnN3g0luTMkVVlr4o1tJ+c9dkvos5AabRH
   xOHpwlXeTtqGbNOQlm1j3RS06v0gMBkqwIdEiNuniav6tqp9vj31EgCRF
   xyXSu1fKkDPUmUNJlEnVFtdne0PFprYamHlEc4J2f+3vMYSmvOHEHTOFH
   9nCPlDH13M6rt4fu1tiDfSR4zmsIcnV3THZ0Y/RhvCu5fS7UTZoxr8Z2V
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="298379075"
X-IronPort-AV: E=Sophos;i="5.93,298,1654585200"; 
   d="scan'208";a="298379075"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 19:06:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,298,1654585200"; 
   d="scan'208";a="703829962"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.117])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Sep 2022 19:06:09 -0700
From:   kah.jing.lee@intel.com
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     linux-kernel@vger.kernel.org, tien.sung.ang@intel.com,
        Radu Bacrau <radu.bacrau@intel.com>,
        Kah Jing Lee <kah.jing.lee@intel.com>
Subject: [PATCH 2/2] firmware: stratix10-rsu: query spt addresses
Date:   Thu,  8 Sep 2022 10:05:27 +0800
Message-Id: <20220908020526.2745662-1-kah.jing.lee@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Radu Bacrau <radu.bacrau@intel.com>

Extend Intel Remote System Update (RSU) driver to get SPT
(Sub-Partition Table) addresses. The query SPT address can be used
to determine if the RSU QSPI layout is 32kB or 64kB aligned.
The alignment can be determined by minus the upper with the lower of
the SPT addresses.

This patch depends on patch:
firmware: stratix10-svc: Generic Mailbox Command

Signed-off-by: Radu Bacrau <radu.bacrau@intel.com>
Signed-off-by: Kah Jing Lee <kah.jing.lee@intel.com>
---
 drivers/firmware/stratix10-rsu.c | 100 ++++++++++++++++++++++++++++++-
 1 file changed, 99 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/stratix10-rsu.c b/drivers/firmware/stratix10-rsu.c
index e51c95f8d445..9f82d5147890 100644
--- a/drivers/firmware/stratix10-rsu.c
+++ b/drivers/firmware/stratix10-rsu.c
@@ -34,6 +34,10 @@
 #define INVALID_RETRY_COUNTER		0xFF
 #define INVALID_DCMF_VERSION		0xFF
 #define INVALID_DCMF_STATUS		0xFFFFFFFF
+#define INVALID_SPT_ADDRESS		0x0
+
+#define RSU_GET_SPT_CMD			0x5A
+#define RSU_GET_SPT_RESP_LEN		(4 * sizeof(unsigned int))
 
 typedef void (*rsu_callback)(struct stratix10_svc_client *client,
 			     struct stratix10_svc_cb_data *data);
@@ -59,6 +63,9 @@ typedef void (*rsu_callback)(struct stratix10_svc_client *client,
  * @dcmf_status.dcmf3: dcmf3 status
  * @retry_counter: the current image's retry counter
  * @max_retry: the preset max retry value
+ * @spt0_address: address of spt0
+ * @spt1_address: address of spt1
+ * @get_spt_response_buf: response from sdm for get_spt command
  */
 struct stratix10_rsu_priv {
 	struct stratix10_svc_chan *chan;
@@ -90,6 +97,11 @@ struct stratix10_rsu_priv {
 
 	unsigned int retry_counter;
 	unsigned int max_retry;
+
+	unsigned long spt0_address;
+	unsigned long spt1_address;
+
+	unsigned int *get_spt_response_buf;
 };
 
 /**
@@ -259,6 +271,36 @@ static void rsu_dcmf_status_callback(struct stratix10_svc_client *client,
 	complete(&priv->completion);
 }
 
+static void rsu_get_spt_callback(struct stratix10_svc_client *client,
+				     struct stratix10_svc_cb_data *data)
+{
+	struct stratix10_rsu_priv *priv = client->priv;
+	unsigned long *mbox_err = (unsigned long *)data->kaddr1;
+	unsigned long *resp_len = (unsigned long *)data->kaddr2;
+
+	if ((data->status != BIT(SVC_STATUS_OK)) || (*mbox_err) ||
+	    (*resp_len != RSU_GET_SPT_RESP_LEN))
+		goto error;
+
+	priv->spt0_address = priv->get_spt_response_buf[0];
+	priv->spt0_address <<= 32;
+	priv->spt0_address |= priv->get_spt_response_buf[1];
+
+	priv->spt1_address = priv->get_spt_response_buf[2];
+	priv->spt1_address <<= 32;
+	priv->spt1_address |= priv->get_spt_response_buf[3];
+
+	goto complete;
+
+error:
+	dev_err(client->dev, "failed to get SPTs\n");
+
+complete:
+	stratix10_svc_free_memory(priv->chan, priv->get_spt_response_buf);
+	priv->get_spt_response_buf = NULL;
+	complete(&priv->completion);
+}
+
 /**
  * rsu_send_msg() - send a message to Intel service layer
  * @priv: pointer to rsu private data
@@ -288,6 +330,14 @@ static int rsu_send_msg(struct stratix10_rsu_priv *priv,
 	if (arg)
 		msg.arg[0] = arg;
 
+	if (command == COMMAND_MBOX_SEND_CMD) {
+		msg.arg[1] = 0;
+		msg.payload = NULL;
+		msg.payload_length = 0;
+		msg.payload_output = priv->get_spt_response_buf;
+		msg.payload_length_output = RSU_GET_SPT_RESP_LEN;
+	}
+
 	ret = stratix10_svc_send(priv->chan, &msg);
 	if (ret < 0)
 		goto status_done;
@@ -572,6 +622,34 @@ static ssize_t notify_store(struct device *dev,
 	return count;
 }
 
+static ssize_t spt0_address_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct stratix10_rsu_priv *priv = dev_get_drvdata(dev);
+
+	if (!priv)
+		return -ENODEV;
+
+	if (priv->spt0_address == INVALID_SPT_ADDRESS)
+		return -EIO;
+
+	return scnprintf(buf, PAGE_SIZE, "0x%08lx\n", priv->spt0_address);
+}
+
+static ssize_t spt1_address_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct stratix10_rsu_priv *priv = dev_get_drvdata(dev);
+
+	if (!priv)
+		return -ENODEV;
+
+	if (priv->spt1_address == INVALID_SPT_ADDRESS)
+		return -EIO;
+
+	return scnprintf(buf, PAGE_SIZE, "0x%08lx\n", priv->spt1_address);
+}
+
 static DEVICE_ATTR_RO(current_image);
 static DEVICE_ATTR_RO(fail_image);
 static DEVICE_ATTR_RO(state);
@@ -590,6 +668,8 @@ static DEVICE_ATTR_RO(dcmf2_status);
 static DEVICE_ATTR_RO(dcmf3_status);
 static DEVICE_ATTR_WO(reboot_image);
 static DEVICE_ATTR_WO(notify);
+static DEVICE_ATTR_RO(spt0_address);
+static DEVICE_ATTR_RO(spt1_address);
 
 static struct attribute *rsu_attrs[] = {
 	&dev_attr_current_image.attr,
@@ -610,6 +690,8 @@ static struct attribute *rsu_attrs[] = {
 	&dev_attr_dcmf3_status.attr,
 	&dev_attr_reboot_image.attr,
 	&dev_attr_notify.attr,
+	&dev_attr_spt0_address.attr,
+	&dev_attr_spt1_address.attr,
 	NULL
 };
 
@@ -639,11 +721,13 @@ static int stratix10_rsu_probe(struct platform_device *pdev)
 	priv->dcmf_version.dcmf1 = INVALID_DCMF_VERSION;
 	priv->dcmf_version.dcmf2 = INVALID_DCMF_VERSION;
 	priv->dcmf_version.dcmf3 = INVALID_DCMF_VERSION;
-	priv->max_retry = INVALID_RETRY_COUNTER;
 	priv->dcmf_status.dcmf0 = INVALID_DCMF_STATUS;
 	priv->dcmf_status.dcmf1 = INVALID_DCMF_STATUS;
 	priv->dcmf_status.dcmf2 = INVALID_DCMF_STATUS;
 	priv->dcmf_status.dcmf3 = INVALID_DCMF_STATUS;
+	priv->max_retry = INVALID_RETRY_COUNTER;
+	priv->spt0_address = INVALID_SPT_ADDRESS;
+	priv->spt1_address = INVALID_SPT_ADDRESS;
 
 	mutex_init(&priv->lock);
 	priv->chan = stratix10_svc_request_channel_byname(&priv->client,
@@ -693,6 +777,20 @@ static int stratix10_rsu_probe(struct platform_device *pdev)
 		stratix10_svc_free_channel(priv->chan);
 	}
 
+	priv->get_spt_response_buf =
+		stratix10_svc_allocate_memory(priv->chan, RSU_GET_SPT_RESP_LEN);
+
+	if (!priv->get_spt_response_buf) {
+		dev_err(dev, "failed to allocate get spt buffer\n");
+	} else {
+		int ret_val = rsu_send_msg(priv, COMMAND_MBOX_SEND_CMD,
+				   RSU_GET_SPT_CMD, rsu_get_spt_callback);
+		if (ret_val) {
+			dev_err(dev, "Error, getting SPT table %i\n", ret_val);
+			stratix10_svc_free_channel(priv->chan);
+		}
+	}
+
 	return ret;
 }
 
-- 
2.25.1

