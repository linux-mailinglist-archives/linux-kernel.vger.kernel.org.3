Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADD1F5969EC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 09:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233349AbiHQG6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 02:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbiHQG6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 02:58:31 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 34D3372B76;
        Tue, 16 Aug 2022 23:58:25 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 27H6w0n65013321, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 27H6w0n65013321
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 17 Aug 2022 14:58:00 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 17 Aug 2022 14:58:12 +0800
Received: from localhost.localdomain (172.21.132.192) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 17 Aug 2022 14:58:12 +0800
From:   <hildawu@realtek.com>
To:     <marcel@holtmann.org>
CC:     <johan.hedberg@gmail.com>, <luiz.dentz@gmail.com>,
        <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <apusaka@chromium.org>, <yinghsu@chromium.org>,
        <max.chou@realtek.com>, <alex_lu@realsil.com.cn>,
        <kidman@realtek.com>
Subject: [PATCH] Bluetooth: btusb: Workaround for spotty SCO quality
Date:   Wed, 17 Aug 2022 14:58:07 +0800
Message-ID: <20220817065807.21824-1-hildawu@realtek.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.132.192]
X-ClientProxiedBy: RTEXH36504.realtek.com.tw (172.21.6.27) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 08/17/2022 06:34:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzgvMTcgpFekyCAwMToyMjowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hilda Wu <hildawu@realtek.com>

When streaming HFP, once a few minutes a brief pause in audio can be
heard on some platform with Realtek Bluetooth. When the issue occurs,
the system will see the SCO packet for unknown connection handle messages.

Note: This issue affects (e)SCO only, does not affect ACLs.
Because the duplicate packet causing the problem only occurs in Realtek BT.
This is to filter out duplicate packet for avoiding influence.

Signed-off-by: Hilda Wu <hildawu@realtek.com>
---
 drivers/bluetooth/btrtl.c | 28 ++++++++++++++++++++++++++++
 drivers/bluetooth/btrtl.h | 29 +++++++++++++++++++++++++++++
 drivers/bluetooth/btusb.c | 14 ++++++++++++++
 3 files changed, 71 insertions(+)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index fb52313a1d45..15223b3ed94d 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -781,6 +781,7 @@ void btrtl_set_quirks(struct hci_dev *hdev, struct btrtl_device_info *btrtl_dev)
 	case CHIP_ID_8852C:
 		set_bit(HCI_QUIRK_VALID_LE_STATES, &hdev->quirks);
 		set_bit(HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED, &hdev->quirks);
+		btrealtek_set_flag(hdev, REALTEK_WBS_FILTER);
 		hci_set_aosp_capable(hdev);
 		break;
 	default:
@@ -937,6 +938,33 @@ int btrtl_get_uart_settings(struct hci_dev *hdev,
 }
 EXPORT_SYMBOL_GPL(btrtl_get_uart_settings);
 
+int btrtl_usb_recv_isoc(u16 pos, u8 *data, u8 *p, int len,
+			u16 wMaxPacketSize)
+{
+	u8 *prev;
+
+	if (pos >= HCI_SCO_HDR_SIZE && pos >= wMaxPacketSize &&
+	    len == wMaxPacketSize && !(pos % wMaxPacketSize) &&
+	    wMaxPacketSize >= 10 && p[0] == data[0] && p[1] == data[1]) {
+		prev = data + (pos - wMaxPacketSize);
+
+		/* Detect the sco data of usb isoc pkt duplication. */
+		if (!memcmp(p + 2, prev + 2, 8))
+			return -EILSEQ;
+
+		if (wMaxPacketSize >= 12 &&
+		    p[2] == prev[6] && p[3] == prev[7] &&
+		    p[4] == prev[4] && p[5] == prev[5] &&
+		    p[6] == prev[10] && p[7] == prev[11] &&
+		    p[8] == prev[8] && p[9] == prev[9]) {
+			return -EILSEQ;
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(btrtl_usb_recv_isoc);
+
 MODULE_AUTHOR("Daniel Drake <drake@endlessm.com>");
 MODULE_DESCRIPTION("Bluetooth support for Realtek devices ver " VERSION);
 MODULE_VERSION(VERSION);
diff --git a/drivers/bluetooth/btrtl.h b/drivers/bluetooth/btrtl.h
index 2c441bda390a..84c0d17377bf 100644
--- a/drivers/bluetooth/btrtl.h
+++ b/drivers/bluetooth/btrtl.h
@@ -47,6 +47,27 @@ struct rtl_vendor_config {
 	struct rtl_vendor_config_entry entry[];
 } __packed;
 
+enum {
+	REALTEK_WBS_FILTER,
+
+	__REALTEK_NUM_FLAGS,
+};
+
+struct btrealtek_data {
+	DECLARE_BITMAP(flags, __REALTEK_NUM_FLAGS);
+};
+
+#define btrealtek_set_flag(hdev, nr)					\
+	do {								\
+		struct btrealtek_data *realtek = hci_get_priv((hdev));	\
+		set_bit((nr), realtek->flags);				\
+	} while (0)
+
+#define btrealtek_get_flag(hdev)						\
+	(((struct btrealtek_data *)hci_get_priv(hdev))->flags)
+
+#define btrealtek_test_flag(hdev, nr)	test_bit((nr), btrealtek_get_flag(hdev))
+
 #if IS_ENABLED(CONFIG_BT_RTL)
 
 struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
@@ -62,6 +83,8 @@ int btrtl_get_uart_settings(struct hci_dev *hdev,
 			    struct btrtl_device_info *btrtl_dev,
 			    unsigned int *controller_baudrate,
 			    u32 *device_baudrate, bool *flow_control);
+int btrtl_usb_recv_isoc(u16 pos, u8 *data, u8 *buffer, int len,
+				u16 wMaxPacketSize);
 
 #else
 
@@ -105,4 +128,10 @@ static inline int btrtl_get_uart_settings(struct hci_dev *hdev,
 	return -ENOENT;
 }
 
+static inline int btrtl_usb_recv_isoc(u16 pos, u8 *data, u8 *buffer, int len,
+					u16 wMaxPacketSize)
+{
+	return -EOPNOTSUPP;
+}
+
 #endif
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 30dd443f395f..1578cf2a7469 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -956,6 +956,7 @@ static int btusb_recv_isoc(struct btusb_data *data, void *buffer, int count)
 	struct sk_buff *skb;
 	unsigned long flags;
 	int err = 0;
+	u16 wMaxPacketSize = le16_to_cpu(data->isoc_rx_ep->wMaxPacketSize);
 
 	spin_lock_irqsave(&data->rxlock, flags);
 	skb = data->sco_skb;
@@ -975,6 +976,19 @@ static int btusb_recv_isoc(struct btusb_data *data, void *buffer, int count)
 		}
 
 		len = min_t(uint, hci_skb_expect(skb), count);
+
+		/* Gaps in audio could be heard while streaming WBS using USB
+		 * alt settings 3 on some platforms, since this is only used
+		 * with RTK chips so let vendor function detect it.
+		 */
+		if (test_bit(BTUSB_USE_ALT3_FOR_WBS, &data->flags) &&
+			btrealtek_test_flag(data->hdev, REALTEK_WBS_FILTER)) {
+			err = btrtl_usb_recv_isoc(skb->len, skb->data, buffer,
+							len, wMaxPacketSize);
+			if (err)
+				break;
+		}
+
 		skb_put_data(skb, buffer, len);
 
 		count -= len;
-- 
2.17.1

