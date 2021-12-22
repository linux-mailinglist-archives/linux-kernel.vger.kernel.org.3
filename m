Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD52B47D16D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 13:01:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244759AbhLVMBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 07:01:11 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:44831 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235474AbhLVMBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 07:01:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1640174470; x=1671710470;
  h=from:to:cc:subject:date:message-id;
  bh=o55U/4pnFLIo4sAG3BA6KooL0dSILvHheNBtvDCnyy8=;
  b=Ey6paIFbVDpqTTOIQtZ0o3HuMd/KLCgN06Q2lfuLSorJhOZuwiJvje4h
   KvrGndiXvtPXsgK5XoRVsbgANJDGv/82Ffd00gfW5jatDhceN5v9FiHyP
   luk7D9b2eBtYl/Cd84Pv9AWSjvIJowTTL/pm9c6AV76e5MWpwL2N7EOuZ
   g=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 22 Dec 2021 04:01:09 -0800
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA; 22 Dec 2021 04:01:07 -0800
X-QCInternal: smtphost
Received: from hyd-lablnx377.qualcomm.com ([10.204.178.226])
  by ironmsg02-blr.qualcomm.com with ESMTP; 22 Dec 2021 17:30:50 +0530
Received: by hyd-lablnx377.qualcomm.com (Postfix, from userid 4035820)
        id 37A7821435; Wed, 22 Dec 2021 17:30:49 +0530 (IST)
From:   Sai Teja Aluvala <quic_saluvala@quicinc.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, quic_hemantg@quicinc.com,
        linux-arm-msm@vger.kernel.org, quic_bgodavar@quicinc.com,
        rjliao@codeaurora.org, hbandi@codeaurora.org,
        abhishekpandit@chromium.org, mcchou@chromium.org,
        quic_pharish@quicinc.com,
        Sai Teja Aluvala <quic_saluvala@quicinc.com>
Subject: [PATCH v4] Bluetooth: btqca: sequential validation
Date:   Wed, 22 Dec 2021 17:30:44 +0530
Message-Id: <1640174444-28561-1-git-send-email-quic_saluvala@quicinc.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change will have sequential validation support
& patch config command is added

Signed-off-by: Sai Teja Aluvala <quic_saluvala@quicinc.com>

v4:
* addressed the change from u8 cmd to const u8 cmd

v3:
* removed rlen,rtype
* Replaced kfree with kfree_skb

v2:
* Added static declaration
* Addressed wrong indentation
* Removed EDL_PATCH_CONFIG_CMD_LEN

v1:
*Initial patch
---
 drivers/bluetooth/btqca.c | 48 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/bluetooth/btqca.h |  2 ++
 2 files changed, 50 insertions(+)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index be04d74..9091a88 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -141,6 +141,51 @@ static int qca_read_fw_build_info(struct hci_dev *hdev)
 	return err;
 }
 
+static int qca_send_patch_config_cmd(struct hci_dev *hdev)
+{
+	struct sk_buff *skb;
+	int err = 0;
+	const u8 cmd[] = {EDL_PATCH_CONFIG_CMD, 0x01, 0, 0, 0};
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

