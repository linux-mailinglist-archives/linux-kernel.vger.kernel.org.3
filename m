Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50C03533AE0
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 12:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238707AbiEYKrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 06:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233450AbiEYKqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 06:46:25 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C6069B1B0
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 03:46:05 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id pq9-20020a17090b3d8900b001df622bf81dso4676720pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 03:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YFb0SNcpxggXxmh3L1U6bvqHH42Uek+PeM4W6Sd9ZO4=;
        b=K3fVfk+Sn1+tGAYONxbTEGShQ6x6izXfoDmmXj+eneEdIx5zYjRt5VGo6j7vW9DCZg
         Ve/D3i22yw6PjiL2zV+gaCGlyeOsYvwNCiMwYa3Zc3fKlxGDDofE1ocYtEAqZGIjPfe1
         flpdrbgR1NY8UpFrQI3jP/0f9a16xUuwN25rg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YFb0SNcpxggXxmh3L1U6bvqHH42Uek+PeM4W6Sd9ZO4=;
        b=AZvDJMV7CibbWhvM/wFXW8FJmbajoOkPBkl0JLstcK1RVQihsnck3HA93x0T5tbvXy
         MN0t5fSDNGW+gV3rGg5MzuWAyfC7yUm+GpYeTFpHokWxKVK73ZNt6qoVCzhyGsGym5Ti
         rSI4MaKxTdndqG4YJIEy8v8pItDFpNoTa1I2Lp4AOROX19Nim/27NNbFLeN2k1NVfp+1
         CTQvNebj0zNTLRW8bHbiGArNwajfwHoIvPpFsG3TK0iGqAfkCm/BceOlvUukc8UOg/51
         l0jPKNcOLO/ZtevBiBf1oyQJnjFg/JseC1dwdj2yS89h6RjhsYurf4L+tyWV0JYy6Eid
         VJiw==
X-Gm-Message-State: AOAM532nNrIvNVpkbTYk1EHTY4DXdG3iY0UvW/D9iZVW2YdwhiOcUVnQ
        QGTELuQOMB3+Mv9jmuvls2o+DQ==
X-Google-Smtp-Source: ABdhPJx/2oGYye6pAmkDaioVB0xtUbFinhfK21Zyd+S784kZipFqpV1nMwZG0+MPagzqyr1dcGGJyw==
X-Received: by 2002:a17:902:b10f:b0:161:f196:b4e with SMTP id q15-20020a170902b10f00b00161f1960b4emr26115202plr.134.1653475564568;
        Wed, 25 May 2022 03:46:04 -0700 (PDT)
Received: from localhost (174.71.80.34.bc.googleusercontent.com. [34.80.71.174])
        by smtp.gmail.com with UTF8SMTPSA id e4-20020a170902e0c400b00161947ecc82sm1611921pla.199.2022.05.25.03.46.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 May 2022 03:46:04 -0700 (PDT)
From:   Joseph Hwang <josephsih@chromium.org>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com, pali@kernel.org
Cc:     josephsih@google.com, chromeos-bluetooth-upstreaming@chromium.org,
        Joseph Hwang <josephsih@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 4/5] Bluetooth: btintel: setup vendor_get_prefix and vendor_evt
Date:   Wed, 25 May 2022 18:45:44 +0800
Message-Id: <20220525104545.2314653-2-josephsih@chromium.org>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
In-Reply-To: <20220525104545.2314653-1-josephsih@chromium.org>
References: <20220525104545.2314653-1-josephsih@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch sets up vendor_get_prefix and vendor_evt in btintel
to surface Intel telemetry events.

Signed-off-by: Joseph Hwang <josephsih@chromium.org>
---

Changes in v5:
- This is a new patch that holds the Intel specifics in the driver.
- This patch sets up vendor_get_ext_prefix and vendor_evt.
- INTEL_PREFIX is defined in little endian for convenience.
- Define intel_ext_prefix to contain Intel prefix and the telemetry
  subcode which will be returned by btintel_get_ext_prefix().
- Remove the unnecessary "void *data" portion and the double space
  from btintel_vendor_evt.
- Remove some unnecessary checking in btintel_vendor_evt.
- As to stripping off the prefix, that was what was done in
  "Series-version: 1". Previous comment about the AOSP function in
  pulling off the prefix header from the skb was "just do a basic
  length check and then move on. The kernel has no interest in this
  data." So that is why the whole skb->data is sent to the user space
  for further handling. This is to be consistent with what AOSP does
  there.

 drivers/bluetooth/btintel.c | 50 +++++++++++++++++++++++++++++++++++++
 drivers/bluetooth/btintel.h | 13 ++++++++++
 2 files changed, 63 insertions(+)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 818681c89db8..7c39cb7352fd 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -2404,6 +2404,10 @@ static int btintel_setup_combined(struct hci_dev *hdev)
 	/* Set up the quality report callback for Intel devices */
 	hdev->set_quality_report = btintel_set_quality_report;
 
+	/* Set up the vendor event callbacks for Intel devices */
+	hdev->vendor_get_ext_prefix = btintel_get_ext_prefix;
+	hdev->vendor_evt = btintel_vendor_evt;
+
 	/* For Legacy device, check the HW platform value and size */
 	if (skb->len == sizeof(ver) && skb->data[1] == 0x37) {
 		bt_dev_dbg(hdev, "Read the legacy Intel version information");
@@ -2650,6 +2654,52 @@ void btintel_secure_send_result(struct hci_dev *hdev,
 }
 EXPORT_SYMBOL_GPL(btintel_secure_send_result);
 
+/* INTEL_PREFIX below is defined in little endian. */
+static unsigned char INTEL_PREFIX[] = { 0x87, 0x80 };
+
+/* Define any Intel sub-opcodes here. */
+#define TELEMETRY_CODE		0x03
+static unsigned char INTEL_SUBCODES[] = { TELEMETRY_CODE };
+
+static struct ext_vendor_prefix intel_ext_prefix = {
+	.prefix         = INTEL_PREFIX,
+	.prefix_len     = sizeof(INTEL_PREFIX),
+	.subcodes       = INTEL_SUBCODES,
+	.subcodes_len   = sizeof(INTEL_SUBCODES),
+};
+
+struct ext_vendor_prefix *btintel_get_ext_prefix(struct hci_dev *hdev)
+{
+	return &intel_ext_prefix;
+}
+EXPORT_SYMBOL_GPL(btintel_get_ext_prefix);
+
+/* An Intel vendor event with prefix has the following structure. */
+struct intel_prefix_evt_data {
+	__le16 prefix; /* INTEL_PREFIX */
+	__u8 subcode;
+	__u8 data[];   /* a number of struct intel_tlv subevents */
+} __packed;
+
+void btintel_vendor_evt(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct intel_prefix_evt_data *ev;
+
+	if (skb->len < sizeof(struct intel_prefix_evt_data))
+		return;
+
+	if (memcmp(skb->data, INTEL_PREFIX, sizeof(INTEL_PREFIX)))
+		return;
+
+	/* Only interested in the telemetry event for now. */
+	ev = (struct intel_prefix_evt_data *)skb->data;
+	if (ev->subcode == TELEMETRY_CODE) {
+		hdev->hci_recv_quality_report(hdev, skb->data, skb->len,
+					      QUALITY_SPEC_INTEL_TELEMETRY);
+	}
+}
+EXPORT_SYMBOL_GPL(btintel_vendor_evt);
+
 MODULE_AUTHOR("Marcel Holtmann <marcel@holtmann.org>");
 MODULE_DESCRIPTION("Bluetooth support for Intel devices ver " VERSION);
 MODULE_VERSION(VERSION);
diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index e0060e58573c..040c41f11e91 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -211,6 +211,8 @@ void btintel_bootup(struct hci_dev *hdev, const void *ptr, unsigned int len);
 void btintel_secure_send_result(struct hci_dev *hdev,
 				const void *ptr, unsigned int len);
 int btintel_set_quality_report(struct hci_dev *hdev, bool enable);
+struct ext_vendor_prefix *btintel_get_ext_prefix(struct hci_dev *hdev);
+void btintel_vendor_evt(struct hci_dev *hdev, struct sk_buff *skb);
 #else
 
 static inline int btintel_check_bdaddr(struct hci_dev *hdev)
@@ -306,4 +308,15 @@ static inline int btintel_set_quality_report(struct hci_dev *hdev, bool enable)
 {
 	return -ENODEV;
 }
+
+static inline struct ext_vendor_prefix *btintel_get_ext_prefix(
+							struct hci_dev *hdev)
+{
+	return NULL;
+}
+
+static inline void btintel_vendor_evt(struct hci_dev *hdev, struct sk_buff *skb)
+{
+}
+
 #endif
-- 
2.36.1.124.g0e6072fb45-goog

