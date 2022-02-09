Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4B464B00C5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 23:56:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236689AbiBIW4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 17:56:20 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:34660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236608AbiBIWz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 17:55:59 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33694E04FF04
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 14:56:02 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id x4so244561plb.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 14:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OD3ScagW/UVEvAgXcoCt88MegSsPUonQOP/whnuiG6c=;
        b=IdqQVxvkIDlWqFoR5ZkdpFlMKtj+Rwf9Ot9GDH2GxmjZ5Lt8AtA5Z5hsfTb/QXFmGm
         X5Fk4Mi8YKk4mpkvl9DPcDgkofoO7HgW8+JxfmhuA1Z02HU0/DGFIHTYu8s/p+vGuXYq
         OqObv8659R8SbEDzlNM4BHGOjPxoU3PsDeoAQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OD3ScagW/UVEvAgXcoCt88MegSsPUonQOP/whnuiG6c=;
        b=Mt+ctkj+9JuDT4QabMMBxy2GT8GzRdn/fcWZcDVBt3816QF3aevazeTXnDs1FOENt5
         JhwOle6ROGjy2Z6u/hKu+8XyNjs0AA0WNALWzIOlCrDhISq3y8tmvuOG0dGsixaj7Ucw
         MnQV/irk/slm7e46AyDMMxVuIDGzrNXQ55m+0eNxNlxK+/bp1r0UPyQWX87gDCNLvFcF
         LdwXDCU7XG0FNxMIeqliMIqByDzlweqcUulDJNTBbV2Fp4eC5zDNLh+wz1gYEY6jbjOF
         PaNO8KTGtTcu6cimQcd98FIYdI4AurZtXvfUfxLnOQq6pWruRYr0Mt6sYW/1b8DVKzx8
         dHkg==
X-Gm-Message-State: AOAM5328q+wkr+PAI88JP7V4MNDJJHBpsv3iVqjk9KyAj75H4pga2KCi
        uNxhnsPwM2G81Pq+pQxEprSgsw==
X-Google-Smtp-Source: ABdhPJy/n7z7OnxkklzAPapMuR6v5FKtUfoFTwrSu2jJqxkQSYKA6+VsygyAUOuGgNnuZMn/TUwwoA==
X-Received: by 2002:a17:903:41c6:: with SMTP id u6mr4349471ple.74.1644447361711;
        Wed, 09 Feb 2022 14:56:01 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:5193:6865:e38e:3a5b])
        by smtp.gmail.com with ESMTPSA id b1sm5982015pgb.66.2022.02.09.14.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 14:56:01 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     benjamin.tissoires@redhat.com,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Kosina <jikos@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        "Sean O'Brien" <seobrien@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>
Subject: [PATCH v2 3/5] HID: Extract vivaldi hid feature mapping for use in hid-hammer
Date:   Wed,  9 Feb 2022 14:55:54 -0800
Message-Id: <20220209225556.3992827-4-swboyd@chromium.org>
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
In-Reply-To: <20220209225556.3992827-1-swboyd@chromium.org>
References: <20220209225556.3992827-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need to support parsing the HID device in both the vivaldi and the
hammer drivers so that we can properly expose the function row physmap
to userspace when a hammer device uses a vivaldi keyboard layout for the
function row keys. Extract the feature mapping logic from the vivaldi
driver into an hid specific vivaldi library so we can use it from both
HID drivers.

Cc: Jiri Kosina <jikos@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "Sean O'Brien" <seobrien@chromium.org>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/hid/Kconfig                  |  9 +++
 drivers/hid/Makefile                 |  1 +
 drivers/hid/hid-vivaldi-common.c     | 97 ++++++++++++++++++++++++++++
 drivers/hid/hid-vivaldi.c            | 69 +-------------------
 include/linux/input/vivaldi-keymap.h |  9 +++
 5 files changed, 118 insertions(+), 67 deletions(-)
 create mode 100644 drivers/hid/hid-vivaldi-common.c

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 5569a2029dab..ea8fa71c9e9c 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -403,14 +403,23 @@ config HOLTEK_FF
 	  Say Y here if you have a Holtek On Line Grip based game controller
 	  and want to have force feedback support for it.
 
+config HID_VIVALDI_COMMON
+	tristate
+	help
+	  ChromeOS Vivaldi HID parsing support library. This is a hidden
+	  option so that drivers can use common code to parse the HID
+	  descriptors for vivaldi function row keymap.
+
 config HID_GOOGLE_HAMMER
 	tristate "Google Hammer Keyboard"
+	select HID_VIVALDI_COMMON
 	depends on USB_HID && LEDS_CLASS && CROS_EC
 	help
 	Say Y here if you have a Google Hammer device.
 
 config HID_VIVALDI
 	tristate "Vivaldi Keyboard"
+	select HID_VIVALDI_COMMON
 	select INPUT_VIVALDIFMAP
 	depends on HID
 	help
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index 6d3e630e81af..469a6159ebae 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -50,6 +50,7 @@ obj-$(CONFIG_HID_FT260)		+= hid-ft260.o
 obj-$(CONFIG_HID_GEMBIRD)	+= hid-gembird.o
 obj-$(CONFIG_HID_GFRM)		+= hid-gfrm.o
 obj-$(CONFIG_HID_GLORIOUS)  += hid-glorious.o
+obj-$(CONFIG_HID_VIVALDI_COMMON) += hid-vivaldi-common.o
 obj-$(CONFIG_HID_GOOGLE_HAMMER)	+= hid-google-hammer.o
 obj-$(CONFIG_HID_VIVALDI)	+= hid-vivaldi.o
 obj-$(CONFIG_HID_GT683R)	+= hid-gt683r.o
diff --git a/drivers/hid/hid-vivaldi-common.c b/drivers/hid/hid-vivaldi-common.c
new file mode 100644
index 000000000000..c00f11e6530f
--- /dev/null
+++ b/drivers/hid/hid-vivaldi-common.c
@@ -0,0 +1,97 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Helpers for ChromeOS HID Vivaldi keyboards
+ *
+ * Copyright (C) 2022 Google, Inc
+ */
+
+#include <linux/export.h>
+#include <linux/hid.h>
+#include <linux/input/vivaldi-keymap.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/types.h>
+
+#define HID_VD_FN_ROW_PHYSMAP 0x00000001
+#define HID_USAGE_FN_ROW_PHYSMAP (HID_UP_GOOGLEVENDOR | HID_VD_FN_ROW_PHYSMAP)
+
+/**
+ * vivaldi_hid_feature_mapping - Fill out vivaldi keymap data exposed via HID
+ * @data: The vivaldi function keymap
+ * @hdev: HID device to parse
+ * @field: HID field to parse
+ * @usage: HID usage to parse
+ */
+void vivaldi_hid_feature_mapping(struct vivaldi_data *data,
+				 struct hid_device *hdev,
+				 struct hid_field *field,
+				 struct hid_usage *usage)
+{
+	struct hid_report *report = field->report;
+	int fn_key;
+	int ret;
+	u32 report_len;
+	u8 *report_data, *buf;
+
+	if (field->logical != HID_USAGE_FN_ROW_PHYSMAP ||
+	    (usage->hid & HID_USAGE_PAGE) != HID_UP_ORDINAL)
+		return;
+
+	fn_key = (usage->hid & HID_USAGE);
+	if (fn_key < VIVALDI_MIN_FN_ROW_KEY || fn_key > VIVALDI_MAX_FN_ROW_KEY)
+		return;
+	if (fn_key > data->num_function_row_keys)
+		data->num_function_row_keys = fn_key;
+
+	report_data = buf = hid_alloc_report_buf(report, GFP_KERNEL);
+	if (!report_data)
+		return;
+
+	report_len = hid_report_len(report);
+	if (!report->id) {
+		/*
+		 * hid_hw_raw_request() will stuff report ID (which will be 0)
+		 * into the first byte of the buffer even for unnumbered
+		 * reports, so we need to account for this to avoid getting
+		 * -EOVERFLOW in return.
+		 * Note that hid_alloc_report_buf() adds 7 bytes to the size
+		 * so we can safely say that we have space for an extra byte.
+		 */
+		report_len++;
+	}
+
+	ret = hid_hw_raw_request(hdev, report->id, report_data,
+				 report_len, HID_FEATURE_REPORT,
+				 HID_REQ_GET_REPORT);
+	if (ret < 0) {
+		dev_warn(&hdev->dev, "failed to fetch feature %d\n",
+			 field->report->id);
+		goto out;
+	}
+
+	if (!report->id) {
+		/*
+		 * Undo the damage from hid_hw_raw_request() for unnumbered
+		 * reports.
+		 */
+		report_data++;
+		report_len--;
+	}
+
+	ret = hid_report_raw_event(hdev, HID_FEATURE_REPORT, report_data,
+				   report_len, 0);
+	if (ret) {
+		dev_warn(&hdev->dev, "failed to report feature %d\n",
+			 field->report->id);
+		goto out;
+	}
+
+	data->function_row_physmap[fn_key - VIVALDI_MIN_FN_ROW_KEY] =
+	    field->value[usage->usage_index];
+
+out:
+	kfree(buf);
+}
+EXPORT_SYMBOL_GPL(vivaldi_hid_feature_mapping);
+
+MODULE_LICENSE("GPL");
diff --git a/drivers/hid/hid-vivaldi.c b/drivers/hid/hid-vivaldi.c
index 78ae3725bc89..361ba6200387 100644
--- a/drivers/hid/hid-vivaldi.c
+++ b/drivers/hid/hid-vivaldi.c
@@ -13,9 +13,6 @@
 #include <linux/module.h>
 #include <linux/sysfs.h>
 
-#define HID_VD_FN_ROW_PHYSMAP 0x00000001
-#define HID_USAGE_FN_ROW_PHYSMAP (HID_UP_GOOGLEVENDOR | HID_VD_FN_ROW_PHYSMAP)
-
 static ssize_t function_row_physmap_show(struct device *dev,
 					 struct device_attribute *attr,
 					 char *buf)
@@ -60,70 +57,8 @@ static void vivaldi_feature_mapping(struct hid_device *hdev,
 				    struct hid_usage *usage)
 {
 	struct vivaldi_data *drvdata = hid_get_drvdata(hdev);
-	struct hid_report *report = field->report;
-	int fn_key;
-	int ret;
-	u32 report_len;
-	u8 *report_data, *buf;
-
-	if (field->logical != HID_USAGE_FN_ROW_PHYSMAP ||
-	    (usage->hid & HID_USAGE_PAGE) != HID_UP_ORDINAL)
-		return;
-
-	fn_key = (usage->hid & HID_USAGE);
-	if (fn_key < VIVALDI_MIN_FN_ROW_KEY || fn_key > VIVALDI_MAX_FN_ROW_KEY)
-		return;
-	if (fn_key > drvdata->num_function_row_keys)
-		drvdata->num_function_row_keys = fn_key;
-
-	report_data = buf = hid_alloc_report_buf(report, GFP_KERNEL);
-	if (!report_data)
-		return;
-
-	report_len = hid_report_len(report);
-	if (!report->id) {
-		/*
-		 * hid_hw_raw_request() will stuff report ID (which will be 0)
-		 * into the first byte of the buffer even for unnumbered
-		 * reports, so we need to account for this to avoid getting
-		 * -EOVERFLOW in return.
-		 * Note that hid_alloc_report_buf() adds 7 bytes to the size
-		 * so we can safely say that we have space for an extra byte.
-		 */
-		report_len++;
-	}
-
-	ret = hid_hw_raw_request(hdev, report->id, report_data,
-				 report_len, HID_FEATURE_REPORT,
-				 HID_REQ_GET_REPORT);
-	if (ret < 0) {
-		dev_warn(&hdev->dev, "failed to fetch feature %d\n",
-			 field->report->id);
-		goto out;
-	}
-
-	if (!report->id) {
-		/*
-		 * Undo the damage from hid_hw_raw_request() for unnumbered
-		 * reports.
-		 */
-		report_data++;
-		report_len--;
-	}
-
-	ret = hid_report_raw_event(hdev, HID_FEATURE_REPORT, report_data,
-				   report_len, 0);
-	if (ret) {
-		dev_warn(&hdev->dev, "failed to report feature %d\n",
-			 field->report->id);
-		goto out;
-	}
-
-	drvdata->function_row_physmap[fn_key - VIVALDI_MIN_FN_ROW_KEY] =
-	    field->value[usage->usage_index];
-
-out:
-	kfree(buf);
+
+	vivaldi_hid_feature_mapping(drvdata, hdev, field, usage);
 }
 
 static int vivaldi_input_configured(struct hid_device *hdev,
diff --git a/include/linux/input/vivaldi-keymap.h b/include/linux/input/vivaldi-keymap.h
index 4023b65e1649..7cf5bc650fed 100644
--- a/include/linux/input/vivaldi-keymap.h
+++ b/include/linux/input/vivaldi-keymap.h
@@ -4,6 +4,10 @@
 
 #include <linux/types.h>
 
+struct hid_device;
+struct hid_field;
+struct hid_usage;
+
 #define VIVALDI_MIN_FN_ROW_KEY	1
 #define VIVALDI_MAX_FN_ROW_KEY	24
 
@@ -25,4 +29,9 @@ struct vivaldi_data {
 ssize_t vivaldi_function_row_physmap_show(const struct vivaldi_data *data,
 					  char *buf);
 
+void vivaldi_hid_feature_mapping(struct vivaldi_data *data,
+				 struct hid_device *hdev,
+				 struct hid_field *field,
+				 struct hid_usage *usage);
+
 #endif /* _VIVALDI_KEYMAP_H */
-- 
https://chromeos.dev

