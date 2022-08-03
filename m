Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4261F588782
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 08:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235846AbiHCGl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 02:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233734AbiHCGlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 02:41:19 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF633337A;
        Tue,  2 Aug 2022 23:41:18 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 19F2E5C006B;
        Wed,  3 Aug 2022 02:41:18 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 03 Aug 2022 02:41:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1659508878; x=1659595278; bh=jUaLFYINvqKx+M6zsZxzZlQ1O
        Yc3iNm9/LdyYF2RyoY=; b=kp/uPnwEv75XWejnosTifI0nWdSWU4vDNb2Aw2OCy
        TCql3HI3J+Kwj1EBzZfBumRCa+u0Rdt7i5a/or9NAyse4Pr9knu+sPw0OcNpDXFi
        dZqnbjtoXoO9L8SS/Y+oNbjIlfTw0T0gdYFGFRlqhq4txstzCSFfiDMav/5QmJCd
        OuU3Z3SOo4C1KVwcBK5xxUhcgSUhrbiOU2HIHIKUUZXGIFI9qz0k4bnbulCHN9Pc
        Pw3y6gvEx12OPP39ScGG2lqAY0fZlRhRuRBU91ocjNWHY+AlJgoAxEWb6z3PSnJ/
        IujJSCt9bqSSxBuXD91zYXSNy5XBqFN0YBaLVT/mJvhIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1659508878; x=1659595278; bh=jUaLFYINvqKx+M6zsZxzZlQ1OYc3iNm9/Ld
        yYF2RyoY=; b=oMqxDEiTsRZYf7Xj1HDz3XoR6L7ex1BCWqzHaCSfXrNor5v2hdA
        PtNn/PsZayEKmBErEbeH91wL1Xg3ydfrVnIrq1LIsVV4h5VEF06n0xEMVI4Gc4yk
        6ClurOrYRq7oclh/ccHMhX1vxnwUbsyYFpmFF4ZzmA92sWq3cB2Cg9IgPeDqxJQu
        /62G42Y8Vgh9TCQidP+1c1QJwDFqAMWDDz/GOHsGWjxveg9H1WBl+5V90iLc41Go
        omS7hAq+DTdq67jEnloyJ8HSjiQAt6zJFYY9kcueKYe/2u6GXw4LYMFZhs7/ZDfH
        q/HR+ufNWpN6k8dxtUz8OiStYrffWt3TnAg==
X-ME-Sender: <xms:jRjqYu6TNsej7_GVFK3zdRGbcFBLmYwJb4m5toBJiZXfszEG9GDRNQ>
    <xme:jRjqYn7sguatoMYxtLB9ryMQfpseTzD20lk7zNQ4xRt4wpKinO4fEGq13q8Tx2qns
    V0v4-e3l3HQjI5u0b4>
X-ME-Received: <xmr:jRjqYtc9wAUgfaFjssufTlP05DvtBN6zP1RUIgzPwaXKe93l9TMl5DDaD-hC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvddviedgudduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgggfestdekre
    dtredttdenucfhrhhomhepfdfnuhhkvgcuffdrucflohhnvghsfdcuoehluhhkvgeslhhj
    ohhnvghsrdguvghvqeenucggtffrrghtthgvrhhnpefgudejtdfhuddukefffeekiefftd
    dtvdfhgeduudeuffeuhfefgfegfeetvedvgeenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:jRjqYrLqgOPzkz4lrs2CPaAKVyp09jE0r8-HKp1kBtivDNaYKu5MRg>
    <xmx:jRjqYiKeG6WS00GvdQjQ1bKhqJMvtpbzL5f405QUhHKRzJo-RdIfnw>
    <xmx:jRjqYsx8E-F0XyGLP1BuURx4hafTt099jQCzB0-fYy1mBQ_PXtum7w>
    <xmx:jhjqYnH1FLP5j3ic-aIvDCC55CKhtHTH8u_1SAI5aEloBGaeVuD87Q>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Aug 2022 02:41:15 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     linux-kernel@vger.kernel.org
Cc:     linux-input@vger.kernel.org, benjamin.tissoires@redhat.com,
        jikos@kernel.org, basavaraj.natikar@amd.com,
        nehal-bakulchandra.shah@amd.com, "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH 1/1] HID: amd_sfh: Add keyguard for ASUS ROG X13 tablet
Date:   Wed,  3 Aug 2022 18:41:09 +1200
Message-Id: <20220803064109.766342-1-luke@ljones.dev>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for ROG X13 Flow 2-in-1 to disable the keyboard when
the lid is flipped.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.c        |  7 ++++-
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.h        |  1 +
 .../hid_descriptor/amd_sfh_hid_desc.c         | 27 +++++++++++++++++++
 .../hid_descriptor/amd_sfh_hid_desc.h         |  9 +++++++
 .../hid_descriptor/amd_sfh_hid_report_desc.h  | 19 +++++++++++++
 5 files changed, 62 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
index dadc491bbf6b..243541d426d8 100644
--- a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
+++ b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
@@ -26,6 +26,7 @@
 #define ACEL_EN		BIT(0)
 #define GYRO_EN		BIT(1)
 #define MAGNO_EN	BIT(2)
+#define KBGUARD_EN	BIT(15)
 #define HPD_EN		BIT(16)
 #define ALS_EN		BIT(19)
 
@@ -232,6 +233,9 @@ int amd_mp2_get_sensor_num(struct amd_mp2_dev *privdata, u8 *sensor_id)
 	if (HPD_EN & activestatus)
 		sensor_id[num_of_sensors++] = HPD_IDX;
 
+	if (KBGUARD_EN & activestatus)
+		sensor_id[num_of_sensors++] = KBGUARD_IDX;
+
 	return num_of_sensors;
 }
 
@@ -373,7 +377,8 @@ static int __maybe_unused amd_mp2_pci_suspend(struct device *dev)
 
 	for (i = 0; i < cl_data->num_hid_devices; i++) {
 		if (cl_data->sensor_idx[i] != HPD_IDX &&
-		    cl_data->sensor_sts[i] == SENSOR_ENABLED) {
+			cl_data->sensor_idx[i] != KBGUARD_IDX &&
+			cl_data->sensor_sts[i] == SENSOR_ENABLED) {
 			mp2->mp2_ops->stop(mp2, cl_data->sensor_idx[i]);
 			status = amd_sfh_wait_for_response
 					(mp2, cl_data->sensor_idx[i], SENSOR_DISABLED);
diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.h b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.h
index 8c760526132a..4a86bc6038a2 100644
--- a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.h
+++ b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.h
@@ -36,6 +36,7 @@
 #define SENSOR_DISABLED    5
 
 #define HPD_IDX		16
+#define KBGUARD_IDX	15
 
 #define AMD_SFH_IDLE_LOOP	200
 
diff --git a/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.c b/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.c
index 76095bd53c65..f41d28ea7b93 100644
--- a/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.c
+++ b/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.c
@@ -57,6 +57,11 @@ int get_report_descriptor(int sensor_idx, u8 *rep_desc)
 		memcpy(rep_desc, hpd_report_descriptor,
 		       sizeof(hpd_report_descriptor));
 		break;
+	case KBGUARD_IDX: /* kbguard ? */
+		memset(rep_desc, 0, sizeof(kbguard_report_descriptor));
+		memcpy(rep_desc, kbguard_report_descriptor,
+		       sizeof(kbguard_report_descriptor));
+		break;
 	default:
 		break;
 	}
@@ -116,6 +121,16 @@ u32 get_descr_sz(int sensor_idx, int descriptor_name)
 			return sizeof(struct hpd_feature_report);
 		}
 		break;
+	case KBGUARD_IDX:
+		switch (descriptor_name) {
+		case descr_size:
+			return sizeof(kbguard_report_descriptor);
+		case input_size:
+			return sizeof(struct kbguard_input_report);
+		case feature_size:
+			return sizeof(struct kbguard_feature_report);
+		}
+		break;
 
 	default:
 		break;
@@ -139,6 +154,7 @@ u8 get_feature_report(int sensor_idx, int report_id, u8 *feature_report)
 	struct gyro_feature_report gyro_feature;
 	struct magno_feature_report magno_feature;
 	struct hpd_feature_report hpd_feature;
+	struct kbguard_feature_report kbguard_feature;
 	struct als_feature_report als_feature;
 	u8 report_size = 0;
 
@@ -186,6 +202,11 @@ u8 get_feature_report(int sensor_idx, int report_id, u8 *feature_report)
 		memcpy(feature_report, &hpd_feature, sizeof(hpd_feature));
 		report_size = sizeof(hpd_feature);
 		break;
+	case KBGUARD_IDX:  /* auto disable keyboard when flip out */
+		get_common_features(&kbguard_feature.common_property, report_id);
+		memcpy(feature_report, &kbguard_feature, sizeof(kbguard_feature));
+		report_size = sizeof(kbguard_feature);
+		break;
 
 	default:
 		break;
@@ -210,6 +231,7 @@ u8 get_input_report(u8 current_index, int sensor_idx, int report_id, struct amd_
 	struct accel3_input_report acc_input;
 	struct gyro_input_report gyro_input;
 	struct hpd_input_report hpd_input;
+	struct kbguard_input_report kbguard_input;
 	struct als_input_report als_input;
 	struct hpd_status hpdstatus;
 	u8 report_size = 0;
@@ -262,6 +284,11 @@ u8 get_input_report(u8 current_index, int sensor_idx, int report_id, struct amd_
 		report_size = sizeof(hpd_input);
 		memcpy(input_report, &hpd_input, sizeof(hpd_input));
 		break;
+	case KBGUARD_IDX: /* kb guard */
+		get_common_inputs(&kbguard_input.common_property, report_id);
+		report_size = sizeof(kbguard_input);
+		memcpy(input_report, &kbguard_input, sizeof(kbguard_input));
+break;
 	default:
 		break;
 	}
diff --git a/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.h b/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.h
index 70b1b7abe2c6..98571a8597b3 100644
--- a/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.h
+++ b/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.h
@@ -105,12 +105,21 @@ struct hpd_feature_report {
 	struct common_feature_property common_property;
 } __packed;
 
+struct kbguard_feature_report {
+	struct common_feature_property common_property;
+} __packed;
+
 struct hpd_input_report {
 	struct common_input_property common_property;
 	 /* values specific to human presence sensor */
 	u8 human_presence;
 } __packed;
 
+struct kbguard_input_report {
+	struct common_input_property common_property;
+} __packed;
+
+
 int get_report_descriptor(int sensor_idx, u8 rep_desc[]);
 u32 get_descr_sz(int sensor_idx, int descriptor_name);
 u8 get_feature_report(int sensor_idx, int report_id, u8 *feature_report);
diff --git a/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_report_desc.h b/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_report_desc.h
index 697f2791ea9c..7a62fcec2c73 100644
--- a/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_report_desc.h
+++ b/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_report_desc.h
@@ -644,6 +644,25 @@ static const u8 als_report_descriptor[] = {
 0xC0			/* HID end collection */
 };
 
+
+static const u8 kbguard_report_descriptor[] = {
+0x06, 0x43, 0xFF,  // Usage Page (Vendor Defined 0xFF43)
+0x0A, 0x02, 0x02,  // Usage (0x0202)
+0xA1, 0x01, // Collection (Application)
+0x85, 0x11, //   Report ID (17)
+0x15, 0x00, //   Logical Minimum (0)
+0x25, 0x01, //   Logical Maximum (1)
+0x35, 0x00, //   Physical Minimum (0)
+0x45, 0x01, //   Physical Maximum (1)
+0x65, 0x00, //   Unit (None)
+0x55, 0x00, //   Unit Exponent (0)
+0x75, 0x01, //   Report Size (1)
+0x95, 0x98, //   Report Count (-104)
+0x81, 0x03, //   Input (Const,Var,Abs,No Wrap,Linear,Preferred State,No Null Position)
+0x91, 0x03, //   Output (Const,Var,Abs,No Wrap,Linear,Preferred State,No Null Position,Non-volatile)
+0xC1, 0x00, // End Collection
+};
+
 /* BIOMETRIC PRESENCE*/
 static const u8 hpd_report_descriptor[] = {
 0x05, 0x20,          /* Usage page */
-- 
2.37.1

