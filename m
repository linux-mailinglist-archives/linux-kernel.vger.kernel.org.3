Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA194758C3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 13:22:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242423AbhLOMWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 07:22:38 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:60866 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234236AbhLOMWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 07:22:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1639570956; x=1671106956;
  h=from:to:cc:subject:date:message-id;
  bh=WSYjARf9I615x4tAMcmvpMwyOLr6e+mLTd1pXbcRWH4=;
  b=jwRSDNXeCW7Q/zEzOY+TSo8Kh3vj1EFYJ01PbHLscfaVRu46OjR9lvtb
   g2Ifq9h1vNUWGzCpBm8sAJXe19Iic7WtNtoseo08Trtq1XOntDlVixwb6
   0WoJcNHI8z/706YM94gU4L6wA4HBUjOx7nC+MSk9AOjzsqiBkuYHoChX+
   A=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 15 Dec 2021 04:22:36 -0800
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 15 Dec 2021 04:22:33 -0800
X-QCInternal: smtphost
Received: from hyd-lablnx377.qualcomm.com ([10.204.178.226])
  by ironmsg02-blr.qualcomm.com with ESMTP; 15 Dec 2021 17:52:15 +0530
Received: by hyd-lablnx377.qualcomm.com (Postfix, from userid 4035820)
        id 89850213E6; Wed, 15 Dec 2021 17:52:14 +0530 (IST)
From:   Sai Teja Aluvala <quic_saluvala@quicinc.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, quic_hemantg@quicinc.com,
        linux-arm-msm@vger.kernel.org, quic_bgodavar@quicinc.com,
        rjliao@codeaurora.org, hbandi@codeaurora.org,
        abhishekpandit@chromium.org, mcchou@chromium.org,
        quic_pharish@quicinc.com,
        Sai Teja Aluvala <quic_saluvala@quicinc.com>
Subject: [PATCH v3] Bluetooth: btqca: sequential validation
Date:   Wed, 15 Dec 2021 17:51:40 +0530
Message-Id: <1639570900-24509-1-git-send-email-quic_saluvala@quicinc.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added Sequential validation support
& patch command config

Signed-off-by: Sai Teja Aluvala <quic_saluvala@quicinc.com>

v3:
* removed rlen,rtype
* Replaced kfree with kfree_skb

v2:
* Added static declaration
* Addressed wrong indentation
* Removed EDL_PATCH_CONFIG_CMD_LEN
*

v1:
*Initial patch
---
 drivers/bluetooth/btqca.c | 48 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/bluetooth/btqca.h |  2 ++
 2 files changed, 50 insertions(+)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index be04d74..21830c6 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -141,6 +141,51 @@ static int qca_read_fw_build_info(struct hci_dev *hdev)
 	return err;
 }
 
+static int qca_send_patch_config_cmd(struct hci_dev *hdev)
+{
+	struct sk_buff *skb;
+	int err = 0;
+	u8 cmd[] = {EDL_PATCH_CONFIG_CMD, 0x01, 0, 0, 0};
+	struct edl_event_hdr *edl;
+
+	bt_dev_dbg(hdev, "QCA Patch config");
+
+	skb = __hci_cmd_sync_ev(hdev, EDL_PATCH_CMD_OPCODE, sizeof(cmd),
+				cmd, HCI_EV_VENDOR, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		err = PTR_ERR(skb);
+		bt_dev_err(hdev, "Sending QCA Patch config failed (%d)", err);
+		return err;
+	}
+
+	if (skb->len != 2) {
+		bt_dev_err(hdev, "QCA Patch config cmd size mismatch len %d", skb->len);
+		err = -EILSEQ;
+		goto out;
+	}
+
+	edl = (struct edl_event_hdr *)(skb->data);
+	if (!edl) {
+		bt_dev_err(hdev, "QCA Patch config with no header");
+		err = -EILSEQ;
+		goto out;
+	}
+
+	if (edl->cresp != EDL_PATCH_CONFIG_RES_EVT || edl->rtype != EDL_PATCH_CONFIG_CMD) {
+		bt_dev_err(hdev, "QCA Wrong packet received %d %d", edl->cresp,
+			   edl->rtype);
+		err = -EIO;
+		goto out;
+	}
+
+out:
+	kfree_skb(skb);
+	if (err)
+		bt_dev_err(hdev, "QCA Patch config cmd failed (%d)", err);
+
+	return err;
+}
+
 static int qca_send_reset(struct hci_dev *hdev)
 {
 	struct sk_buff *skb;
@@ -551,6 +596,9 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 	 */
 	rom_ver = ((soc_ver & 0x00000f00) >> 0x04) | (soc_ver & 0x0000000f);
 
+	if (soc_type == QCA_WCN6750)
+		qca_send_patch_config_cmd(hdev);
+
 	/* Download rampatch file */
 	config.type = TLV_TYPE_PATCH;
 	if (qca_is_wcn399x(soc_type)) {
diff --git a/drivers/bluetooth/btqca.h b/drivers/bluetooth/btqca.h
index 30afa77..61e9a50 100644
--- a/drivers/bluetooth/btqca.h
+++ b/drivers/bluetooth/btqca.h
@@ -13,6 +13,7 @@
 #define EDL_PATCH_TLV_REQ_CMD		(0x1E)
 #define EDL_GET_BUILD_INFO_CMD		(0x20)
 #define EDL_NVM_ACCESS_SET_REQ_CMD	(0x01)
+#define EDL_PATCH_CONFIG_CMD		(0x28)
 #define MAX_SIZE_PER_TLV_SEGMENT	(243)
 #define QCA_PRE_SHUTDOWN_CMD		(0xFC08)
 #define QCA_DISABLE_LOGGING		(0xFC17)
@@ -24,6 +25,7 @@
 #define EDL_CMD_EXE_STATUS_EVT		(0x00)
 #define EDL_SET_BAUDRATE_RSP_EVT	(0x92)
 #define EDL_NVM_ACCESS_CODE_EVT		(0x0B)
+#define EDL_PATCH_CONFIG_RES_EVT	(0x00)
 #define QCA_DISABLE_LOGGING_SUB_OP	(0x14)
 
 #define EDL_TAG_ID_HCI			(17)
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc.

