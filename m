Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1850B4B91FD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 21:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238535AbiBPT7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 14:59:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238493AbiBPT7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 14:59:52 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED669224975
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 11:59:38 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id w20so2795884plq.12
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 11:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7zzRJgn+FCqoLjAj0MMNkZ7DXS/JRbjZIdc8xEusdU0=;
        b=FESKl7EcH8w3bXRbOBtd9IVuVSuTewjG/ItFO8Gkltb5HPM2aDHbpr0tRNQ+u3akLG
         MsbArPM9yY/periuuZDq0nKvJUt/Xf1kMoFio5qmRsAhILO0qRxtnmAeI0NDiItuqDY/
         TpCVjzGeg5hCFYsc7MkAPR9gjw1aVDnQOaCek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7zzRJgn+FCqoLjAj0MMNkZ7DXS/JRbjZIdc8xEusdU0=;
        b=cNSyiUOlua2ywdQvodTY9N6l7KxZZxckMlXGBFjIliXTmOu7wZA/TuHZOf73KefTUK
         U1Tj06bdtB+zHZ1YW8Mcx6js2ws+4UU+AMJb0PZngay8gwOn12m3xNRhS59jy81U5BMa
         /LULYOo7HJyp7SUcsXg9TyLZqBpe6dpmtuEzt+1tanXlVrEKU7LVyNoPTIk0slJa57bq
         X8xGtrc1p/0avYWpvI8c6ldhDWZEkOSXUvbE12LnzirrN30zN/XfCVYv+YF99+/409xU
         UGRSN4y6Z8nvax2S3KiOgdK1mh9acSFCOAxm+4c1wFmfDYnHGlJDW8+RDlSpL3PmL5OS
         HpyQ==
X-Gm-Message-State: AOAM533ROzPL+omljlak1xERhfr3/WVV4ailOTJi00ODYCInPMQMBuzQ
        rS6Y+IYwht83C8wUlejDBjrMaw==
X-Google-Smtp-Source: ABdhPJzYQ/hJ/ixvFZtfAt3j0PWv257QwkVc7Cg7yR4GJiXLrar2/Y2vjByEBfSRgYD6Loalw/FIEw==
X-Received: by 2002:a17:902:82cc:b0:14d:93ce:5bef with SMTP id u12-20020a17090282cc00b0014d93ce5befmr4053327plz.39.1645041578424;
        Wed, 16 Feb 2022 11:59:38 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:5f39:68a1:3c2b:3486])
        by smtp.gmail.com with ESMTPSA id u16sm6078840pgh.54.2022.02.16.11.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 11:59:38 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, benjamin.tissoires@redhat.com,
        Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org,
        "Sean O'Brien" <seobrien@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>,
        Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH v4 2/4] HID: Extract vivaldi hid feature mapping for use in hid-hammer
Date:   Wed, 16 Feb 2022 11:58:59 -0800
Message-Id: <20220216195901.1326924-3-swboyd@chromium.org>
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
In-Reply-To: <20220216195901.1326924-1-swboyd@chromium.org>
References: <20220216195901.1326924-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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
Tested-by: "Sean O'Brien" <seobrien@chromium.org>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>
Acked-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/hid/Kconfig                |  9 +++
 drivers/hid/Makefile               |  1 +
 drivers/hid/hid-vivaldi-common.c   | 97 ++++++++++++++++++++++++++++++
 drivers/hid/hid-vivaldi.c          | 69 +--------------------
 include/linux/input/vivaldi-fmap.h |  9 +++
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
index 000000000000..8a5074fd63b7
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
+#include <linux/input/vivaldi-fmap.h>
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
index adb56b342948..f70cab6a192b 100644
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
diff --git a/include/linux/input/vivaldi-fmap.h b/include/linux/input/vivaldi-fmap.h
index 57563d9da022..c736200b4511 100644
--- a/include/linux/input/vivaldi-fmap.h
+++ b/include/linux/input/vivaldi-fmap.h
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

