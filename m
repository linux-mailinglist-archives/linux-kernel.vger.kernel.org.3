Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1342956AE2E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 00:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236795AbiGGWPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 18:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236726AbiGGWPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 18:15:43 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00FB76053A
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 15:15:40 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id w15-20020a25ac0f000000b0066e50e4a553so8130359ybi.16
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 15:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=lPpbIsaCXVyzpnljdPE3z9idVUmK2xh50STrKr68GjE=;
        b=N82mlzze1rfajqlNRB2P33tl0bL3TZAJAC2eQyzFgbQpXudVSiywcEju60+SmZv8e+
         pqgNNHwUNVlhKImdDJhMgK0rogi4OULnR0EZ/OaaLdkU0oMifEC1w5XJM0pc7ibEKbcI
         rTpeucWobQ/cq5zZBJRe3xAzs/CnMie6A1y+GL+kE/I8k35A9WSPk00Iq3jGy9GcGqFM
         zquTPwPA2oXECQHF7yrAZYXtOeRAjTo7TM4cx7o8PAK9MU/Y90s2ASPRIrmOIij8ws+Y
         65nj2xfZNB0y7g9w3vyyyB/cx5JbTuAuJMgbnmxRkPCyJ7HXZtqk3G9syJXOIlE1prG/
         mXPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lPpbIsaCXVyzpnljdPE3z9idVUmK2xh50STrKr68GjE=;
        b=R+x9yvSy8JYI7nSXygRO3c2TPTDiyPqI0GHdPsIOzuPABUbZJ71Upr3Ssf//m452kA
         YhyvbUsIxMT4DL9RV+y2snXHhqYBvoOvvLY8A8Pwo1Erx4W9hQXrzbinjzRZAiGqu7yW
         AGVj7imypvYQjMPJgNO99SSHwTefJM1fgr8Srtypb1P0aA01Yv2yPnpiWxE2BdV5VEAI
         0nTn2rqVnShJlwn3lUHGHElAZH2btfvyu9fFLeF7PM+RNq1HK6MjvkVex5w84vsaPkI8
         94yihBW6zxb957ZX4MJVQos+0EXpH9rmGI1JqLpqRo7HIDk0pBhhtvw6Lh7BKZzjZeyH
         18SA==
X-Gm-Message-State: AJIora8Nt6FrpLeD6Vw+3xVujnnwMzaC08nfVRE532x4WVWCe9EpJVfh
        X1S/RzyXyhosMLAp5ZiWRyogddTWheDXeA==
X-Google-Smtp-Source: AGRyM1ta+e5k6fX+tItIV9rBwUG2H5Gt/RfLzeLxm8IVd/fsoD8i7qf5LEcjZdEC6TEVl0Xx7PrnLj7QrxchPw==
X-Received: from mmandlik.mtv.corp.google.com ([2620:15c:202:201:dd36:c013:75d8:a382])
 (user=mmandlik job=sendgmr) by 2002:a81:1897:0:b0:31d:5a9:2127 with SMTP id
 145-20020a811897000000b0031d05a92127mr490317ywy.79.1657232139760; Thu, 07 Jul
 2022 15:15:39 -0700 (PDT)
Date:   Thu,  7 Jul 2022 15:15:16 -0700
In-Reply-To: <20220707151420.v3.1.Iaf638bb9f885f5880ab1b4e7ae2f73dd53a54661@changeid>
Message-Id: <20220707151420.v3.3.I61857ea92be43418b8ce16839f79a4704cc89fa6@changeid>
Mime-Version: 1.0
References: <20220707151420.v3.1.Iaf638bb9f885f5880ab1b4e7ae2f73dd53a54661@changeid>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v3 3/3] Bluetooth: btusb: Add Intel devcoredump support
From:   Manish Mandlik <mmandlik@google.com>
To:     marcel@holtmann.org, luiz.dentz@gmail.com
Cc:     linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Manish Mandlik <mmandlik@google.com>,
        Chethan Tumkur Narayan <chethan.tumkur.narayan@intel.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>

Intercept debug exception events from the controller and put them into
a devcoredump using hci devcoredump APIs. The debug exception contains
data in a TLV format and it will be parsed in userspace.

Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Signed-off-by: Manish Mandlik <mmandlik@google.com>
Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Reviewed-by: Chethan Tumkur Narayan <chethan.tumkur.narayan@intel.com>
---

(no changes since v2)

Changes in v2:
- Create a local struct to store coredump_info in btintel.c
- Call btintel_register_devcoredump_support() from btintel.c
- Fix strncpy() destination bound warning

 drivers/bluetooth/btintel.c | 68 ++++++++++++++++++++++++++++++++++++-
 drivers/bluetooth/btintel.h | 11 ++++--
 drivers/bluetooth/btusb.c   | 49 ++++++++++++++++++++++----
 3 files changed, 118 insertions(+), 10 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 818681c89db8..8ad77beff17a 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -32,6 +32,13 @@ struct cmd_write_boot_params {
 	u8  fw_build_yy;
 } __packed;
 
+#define DRIVER_NAME_LEN		16
+static struct {
+	char driver_name[DRIVER_NAME_LEN];
+	u8   hw_variant;
+	u32  fw_build_num;
+} coredump_info;
+
 int btintel_check_bdaddr(struct hci_dev *hdev)
 {
 	struct hci_rp_read_bd_addr *bda;
@@ -304,6 +311,9 @@ int btintel_version_info(struct hci_dev *hdev, struct intel_version *ver)
 		return -EINVAL;
 	}
 
+	coredump_info.hw_variant = ver->hw_variant;
+	coredump_info.fw_build_num = ver->fw_build_num;
+
 	bt_dev_info(hdev, "%s revision %u.%u build %u week %u %u",
 		    variant, ver->fw_revision >> 4, ver->fw_revision & 0x0f,
 		    ver->fw_build_num, ver->fw_build_ww,
@@ -497,6 +507,9 @@ static int btintel_version_info_tlv(struct hci_dev *hdev,
 		return -EINVAL;
 	}
 
+	coredump_info.hw_variant = INTEL_HW_VARIANT(version->cnvi_bt);
+	coredump_info.fw_build_num = version->build_num;
+
 	bt_dev_info(hdev, "%s timestamp %u.%u buildtype %u build %u", variant,
 		    2000 + (version->timestamp >> 8), version->timestamp & 0xff,
 		    version->build_type, version->build_num);
@@ -1391,6 +1404,54 @@ int btintel_set_quality_report(struct hci_dev *hdev, bool enable)
 }
 EXPORT_SYMBOL_GPL(btintel_set_quality_report);
 
+static int btintel_dmp_hdr(struct hci_dev *hdev, char *buf, size_t size)
+{
+	char *ptr = buf;
+	size_t rem = size;
+	size_t read = 0;
+
+	read = snprintf(ptr, rem, "Controller Name: 0x%X\n",
+			coredump_info.hw_variant);
+	rem -= read;
+	ptr += read;
+
+	read = snprintf(ptr, rem, "Firmware Version: 0x%X\n",
+			coredump_info.fw_build_num);
+	rem -= read;
+	ptr += read;
+
+	read = snprintf(ptr, rem, "Driver: %s\n", coredump_info.driver_name);
+	rem -= read;
+	ptr += read;
+
+	read = snprintf(ptr, rem, "Vendor: Intel\n");
+	rem -= read;
+	ptr += read;
+
+	return size - rem;
+}
+
+static int btintel_register_devcoredump_support(struct hci_dev *hdev)
+{
+	struct intel_debug_features features;
+	int err;
+
+	err = btintel_read_debug_features(hdev, &features);
+	if (err) {
+		bt_dev_info(hdev, "Error reading debug features");
+		return err;
+	}
+
+	if (!(features.page1[0] & 0x3f)) {
+		bt_dev_info(hdev, "Telemetry exception format not supported");
+		return -EOPNOTSUPP;
+	}
+
+	hci_devcoredump_register(hdev, btintel_dmp_hdr, NULL);
+
+	return err;
+}
+
 static const struct firmware *btintel_legacy_rom_get_fw(struct hci_dev *hdev,
 					       struct intel_version *ver)
 {
@@ -2464,6 +2525,7 @@ static int btintel_setup_combined(struct hci_dev *hdev)
 			btintel_set_msft_opcode(hdev, ver.hw_variant);
 
 			err = btintel_bootloader_setup(hdev, &ver);
+			btintel_register_devcoredump_support(hdev);
 			break;
 		default:
 			bt_dev_err(hdev, "Unsupported Intel hw variant (%u)",
@@ -2538,6 +2600,7 @@ static int btintel_setup_combined(struct hci_dev *hdev)
 		btintel_set_msft_opcode(hdev, ver.hw_variant);
 
 		err = btintel_bootloader_setup(hdev, &ver);
+		btintel_register_devcoredump_support(hdev);
 		break;
 	case 0x17:
 	case 0x18:
@@ -2560,6 +2623,7 @@ static int btintel_setup_combined(struct hci_dev *hdev)
 					INTEL_HW_VARIANT(ver_tlv.cnvi_bt));
 
 		err = btintel_bootloader_setup_tlv(hdev, &ver_tlv);
+		btintel_register_devcoredump_support(hdev);
 		break;
 	default:
 		bt_dev_err(hdev, "Unsupported Intel hw variant (%u)",
@@ -2608,7 +2672,7 @@ static int btintel_shutdown_combined(struct hci_dev *hdev)
 	return 0;
 }
 
-int btintel_configure_setup(struct hci_dev *hdev)
+int btintel_configure_setup(struct hci_dev *hdev, const char *driver_name)
 {
 	hdev->manufacturer = 2;
 	hdev->setup = btintel_setup_combined;
@@ -2617,6 +2681,8 @@ int btintel_configure_setup(struct hci_dev *hdev)
 	hdev->set_diag = btintel_set_diag_combined;
 	hdev->set_bdaddr = btintel_set_bdaddr;
 
+	strncpy(coredump_info.driver_name, driver_name, DRIVER_NAME_LEN - 1);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(btintel_configure_setup);
diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index e0060e58573c..8e72e59b5bde 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -137,6 +137,12 @@ struct intel_offload_use_cases {
 	__u8	preset[8];
 } __packed;
 
+#define INTEL_TLV_TYPE_ID		0x1
+
+#define INTEL_TLV_SYSTEM_EXCEPTION	0x0
+#define INTEL_TLV_FATAL_EXCEPTION	0x1
+#define INTEL_TLV_DEBUG_EXCEPTION	0x2
+
 #define INTEL_HW_PLATFORM(cnvx_bt)	((u8)(((cnvx_bt) & 0x0000ff00) >> 8))
 #define INTEL_HW_VARIANT(cnvx_bt)	((u8)(((cnvx_bt) & 0x003f0000) >> 16))
 #define INTEL_CNVX_TOP_TYPE(cnvx_top)	((cnvx_top) & 0x00000fff)
@@ -206,7 +212,7 @@ int btintel_read_boot_params(struct hci_dev *hdev,
 			     struct intel_boot_params *params);
 int btintel_download_firmware(struct hci_dev *dev, struct intel_version *ver,
 			      const struct firmware *fw, u32 *boot_param);
-int btintel_configure_setup(struct hci_dev *hdev);
+int btintel_configure_setup(struct hci_dev *hdev, const char *driver_name);
 void btintel_bootup(struct hci_dev *hdev, const void *ptr, unsigned int len);
 void btintel_secure_send_result(struct hci_dev *hdev,
 				const void *ptr, unsigned int len);
@@ -287,7 +293,8 @@ static inline int btintel_download_firmware(struct hci_dev *dev,
 	return -EOPNOTSUPP;
 }
 
-static inline int btintel_configure_setup(struct hci_dev *hdev)
+static inline int btintel_configure_setup(struct hci_dev *hdev,
+					  const char *driver_name)
 {
 	return -ENODEV;
 }
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index fb1a67189412..1db719ef62c5 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2170,16 +2170,42 @@ static int btusb_recv_bulk_intel(struct btusb_data *data, void *buffer,
 	return btusb_recv_bulk(data, buffer, count);
 }
 
+static int btusb_intel_diagnostics(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct intel_tlv *tlv = (void *)&skb->data[5];
+
+	/* The first event is always an event type TLV */
+	if (tlv->type != INTEL_TLV_TYPE_ID)
+		goto recv_frame;
+
+	switch (tlv->val[0]) {
+	case INTEL_TLV_SYSTEM_EXCEPTION:
+	case INTEL_TLV_FATAL_EXCEPTION:
+	case INTEL_TLV_DEBUG_EXCEPTION:
+		/* Generate devcoredump from exception */
+		if (!hci_devcoredump_init(hdev, skb->len)) {
+			hci_devcoredump_append(hdev, skb);
+			hci_devcoredump_complete(hdev);
+			return 0;
+		}
+		break;
+	}
+
+recv_frame:
+	return hci_recv_frame(hdev, skb);
+}
+
 static int btusb_recv_event_intel(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	if (btintel_test_flag(hdev, INTEL_BOOTLOADER)) {
-		struct hci_event_hdr *hdr = (void *)skb->data;
+	struct hci_event_hdr *hdr = (void *)skb->data;
+	const char diagnostics_hdr[] = { 0x87, 0x80, 0x03 };
 
-		if (skb->len > HCI_EVENT_HDR_SIZE && hdr->evt == 0xff &&
-		    hdr->plen > 0) {
-			const void *ptr = skb->data + HCI_EVENT_HDR_SIZE + 1;
-			unsigned int len = skb->len - HCI_EVENT_HDR_SIZE - 1;
+	if (skb->len > HCI_EVENT_HDR_SIZE && hdr->evt == 0xff &&
+	    hdr->plen > 0) {
+		const void *ptr = skb->data + HCI_EVENT_HDR_SIZE + 1;
+		unsigned int len = skb->len - HCI_EVENT_HDR_SIZE - 1;
 
+		if (btintel_test_flag(hdev, INTEL_BOOTLOADER)) {
 			switch (skb->data[2]) {
 			case 0x02:
 				/* When switching to the operational firmware
@@ -2198,6 +2224,15 @@ static int btusb_recv_event_intel(struct hci_dev *hdev, struct sk_buff *skb)
 				break;
 			}
 		}
+
+		/* Handle all diagnostics events separately. May still call
+		 * hci_recv_frame.
+		 */
+		if (len >= sizeof(diagnostics_hdr) &&
+		    memcmp(&skb->data[2], diagnostics_hdr,
+			   sizeof(diagnostics_hdr)) == 0) {
+			return btusb_intel_diagnostics(hdev, skb);
+		}
 	}
 
 	return hci_recv_frame(hdev, skb);
@@ -3770,7 +3805,7 @@ static int btusb_probe(struct usb_interface *intf,
 
 	/* Combined Intel Device setup to support multiple setup routine */
 	if (id->driver_info & BTUSB_INTEL_COMBINED) {
-		err = btintel_configure_setup(hdev);
+		err = btintel_configure_setup(hdev, btusb_driver.name);
 		if (err)
 			goto out_free_dev;
 
-- 
2.37.0.rc0.161.g10f37bed90-goog

