Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FFE64E1EC4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 02:34:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344015AbiCUBfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 21:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344006AbiCUBfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 21:35:38 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC5E4DFDD
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 18:34:12 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id k13-20020a25c60d000000b006339008b92fso10269747ybf.1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 18:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=iqWHeTNrg9XYOwrFBTqAP7o8kk60wCjviTK4u7Q8TPQ=;
        b=cD0n34Wro5PWE+IrkNo+WmOflHEZZMrsltF90KGOZUVl2LyBfvD0lrHbIoDBGJXO27
         yNylDnwrG7LOpxUF0lipx3xPkQEsZTsDnQvRZFVLbLmDnr3uurV8oyHT5ePzKN5o9FIb
         UvqfwIHVrERQd0SDWlwGvFFgEu7BDbyS8rldnyw07J6G3taZH5jy2VeSQXIZd8D8Rt/8
         jA8YiE6sJnCYt/EX4rwVKMB1hnQ/H1hN31lN7nG9XvOjQBrgufkdU63u13Pdz+qY/Ivj
         +jyWUzKqAmQRY5SF5sB6Ha4n3JqgDR/0/DuWr76wTr7nDZp8tBDL1Ry2iSjDftS/J0V/
         NktQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=iqWHeTNrg9XYOwrFBTqAP7o8kk60wCjviTK4u7Q8TPQ=;
        b=WBjrMHcrfZ6C6fmIrs2qFrm16uucUj7rcVWC6wZLilJiEhkRWm0YWb2R1T22CZs7vh
         qzCCH+wp1HDLAr3yZn8zmN/d9Or8S8JYti61aOBIwMEYcQCrNq3J+5z9rsENKCtIxP5h
         0+PYAc92+f6qMY/nonk7NsnYrOXqaVurmghzkV2en9Q5Ya2uHefzIeBhdmXfY06UWnUs
         D5EcYfGz5xui6gB9I+LOoJbl4luscak/kZTfCXmFMiAckn523zA6F4MLE3l4NE22O68t
         mPqxIBbaySVmC12/++ppj/8STKR9/q9d38Qerxq++15NG7PHRB+Ns4ddcOPqKlqVTdS+
         yoOA==
X-Gm-Message-State: AOAM530Bjsx9H+ZA3DqKPznCjxD0AsqcK7YdM94hFPrBRKspCbTp49Md
        MIsyDYagB99jhOlRqvFw/tNOa1k+KYJEng==
X-Google-Smtp-Source: ABdhPJyH2EyKwM6rOOKSTPvaP6P3ZaNR7CXgl0Yog9h0oPHtnWdEbUrJAlqA2WW8q2ZPPeHUxpNwLYANXRl6yQ==
X-Received: from mmandlik.mtv.corp.google.com ([2620:15c:202:201:e0cb:81c1:7b8f:ab9f])
 (user=mmandlik job=sendgmr) by 2002:a25:7282:0:b0:633:f254:4541 with SMTP id
 n124-20020a257282000000b00633f2544541mr4385603ybc.414.1647826451794; Sun, 20
 Mar 2022 18:34:11 -0700 (PDT)
Date:   Sun, 20 Mar 2022 18:34:01 -0700
In-Reply-To: <20220320183225.1.Iaf638bb9f885f5880ab1b4e7ae2f73dd53a54661@changeid>
Message-Id: <20220320183225.2.I61857ea92be43418b8ce16839f79a4704cc89fa6@changeid>
Mime-Version: 1.0
References: <20220320183225.1.Iaf638bb9f885f5880ab1b4e7ae2f73dd53a54661@changeid>
X-Mailer: git-send-email 2.35.1.894.gb6a874cedc-goog
Subject: [PATCH 2/2] Bluetooth: btusb: Add Intel devcoredump support
From:   Manish Mandlik <mmandlik@google.com>
To:     marcel@holtmann.org, luiz.dentz@gmail.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org,
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

 drivers/bluetooth/btintel.c | 60 +++++++++++++++++++++++++++++++++++++
 drivers/bluetooth/btintel.h | 14 +++++++++
 drivers/bluetooth/btusb.c   | 47 +++++++++++++++++++++++++----
 3 files changed, 115 insertions(+), 6 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 06514ed66022..9ac7a4441b38 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -32,6 +32,11 @@ struct cmd_write_boot_params {
 	u8  fw_build_yy;
 } __packed;
 
+#define DRIVER_NAME_LEN		16
+static char driver_name[DRIVER_NAME_LEN];
+static u8 hw_variant;
+static u32 fw_build_num;
+
 int btintel_check_bdaddr(struct hci_dev *hdev)
 {
 	struct hci_rp_read_bd_addr *bda;
@@ -304,6 +309,9 @@ int btintel_version_info(struct hci_dev *hdev, struct intel_version *ver)
 		return -EINVAL;
 	}
 
+	hw_variant = ver->hw_variant;
+	fw_build_num = ver->fw_build_num;
+
 	bt_dev_info(hdev, "%s revision %u.%u build %u week %u %u",
 		    variant, ver->fw_revision >> 4, ver->fw_revision & 0x0f,
 		    ver->fw_build_num, ver->fw_build_ww,
@@ -497,6 +505,9 @@ static int btintel_version_info_tlv(struct hci_dev *hdev,
 		return -EINVAL;
 	}
 
+	hw_variant = INTEL_HW_VARIANT(version->cnvi_bt);
+	fw_build_num = version->build_num;
+
 	bt_dev_info(hdev, "%s timestamp %u.%u buildtype %u build %u", variant,
 		    2000 + (version->timestamp >> 8), version->timestamp & 0xff,
 		    version->build_type, version->build_num);
@@ -1391,6 +1402,55 @@ int btintel_set_quality_report(struct hci_dev *hdev, bool enable)
 }
 EXPORT_SYMBOL_GPL(btintel_set_quality_report);
 
+static int btintel_dmp_hdr(struct hci_dev *hdev, char *buf, size_t size)
+{
+	char *ptr = buf;
+	size_t rem = size;
+	size_t read = 0;
+
+	read = snprintf(ptr, rem, "Controller Name: 0x%X\n", hw_variant);
+	rem -= read;
+	ptr += read;
+
+	read = snprintf(ptr, rem, "Firmware Version: 0x%X\n", fw_build_num);
+	rem -= read;
+	ptr += read;
+
+	read = snprintf(ptr, rem, "Driver: %s\n", driver_name);
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
+int btintel_register_devcoredump_support(struct hci_dev *hdev,
+					 const char *driver)
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
+	strncpy(driver_name, driver, DRIVER_NAME_LEN);
+	hci_devcoredump_register(hdev, btintel_dmp_hdr, NULL);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(btintel_register_devcoredump_support);
+
 static const struct firmware *btintel_legacy_rom_get_fw(struct hci_dev *hdev,
 					       struct intel_version *ver)
 {
diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index e0060e58573c..785c63cc6c1d 100644
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
@@ -206,6 +212,8 @@ int btintel_read_boot_params(struct hci_dev *hdev,
 			     struct intel_boot_params *params);
 int btintel_download_firmware(struct hci_dev *dev, struct intel_version *ver,
 			      const struct firmware *fw, u32 *boot_param);
+int btintel_register_devcoredump_support(struct hci_dev *hdev,
+					 const char *driver);
 int btintel_configure_setup(struct hci_dev *hdev);
 void btintel_bootup(struct hci_dev *hdev, const void *ptr, unsigned int len);
 void btintel_secure_send_result(struct hci_dev *hdev,
@@ -302,6 +310,12 @@ static inline void btintel_secure_send_result(struct hci_dev *hdev,
 {
 }
 
+static int btintel_register_devcoredump_support(struct hci_dev *hdev,
+						const char *driver)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline int btintel_set_quality_report(struct hci_dev *hdev, bool enable)
 {
 	return -ENODEV;
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 50df417207af..42a3d90180a4 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2155,16 +2155,42 @@ static int btusb_recv_bulk_intel(struct btusb_data *data, void *buffer,
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
@@ -2183,6 +2209,15 @@ static int btusb_recv_event_intel(struct hci_dev *hdev, struct sk_buff *skb)
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
-- 
2.35.1.894.gb6a874cedc-goog

