Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 815754B1B34
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 02:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346803AbiBKBZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 20:25:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346779AbiBKBZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 20:25:16 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA9C267F
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 17:25:15 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id l19so7656650pfu.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 17:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AsLXjK6e9UsPAGLtYMvBnmfAvMBSAFTGDaOubRDaaw4=;
        b=AzQpbZggGx0YBZ3nbbhgl3SFFfQWDYm9ReQFa6+d6nlq5CuYT+TS4i9JfFr9ZRggbZ
         L4PETDzhEy4BzORTDjyLfBmD/3Pqnb0kacmrRw1vdF4MhConmBVFlSlG2FxB0q/3Rkku
         f9EvsNQA/4f8bh2Qg/JDwHSFIkM992crN0498=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AsLXjK6e9UsPAGLtYMvBnmfAvMBSAFTGDaOubRDaaw4=;
        b=WpC9DWYUEWdt8DCAUzNRi2e1ZPG2KozZVi6Xfo8oOUElhxM2i4yhGmEzdx9Nkwm1bD
         Ct+iZdYXk8DFu50gXomeFqyr4WmbV4bVl+CSXX+T/latVcH8O46hlOzEdp21jhocvctt
         H5vWY0+I70EXR3g4RwK2WQk3Q1HedhRPbS5MRctdePjbofrwDlgH1QjtmmN2u9emT533
         q3j0rK3Pc9Il33q8nvP2JzpGuECCdeaGXaes3sUiMHxfnpls20KR52tHeXHotov5DVwD
         gHkhKOqMLtAjZTLIQxAt5gJh0i+f753/KC3WD2buwMUa9Qrt8CxDUb/Z5Ukdh/Y2Ehyp
         zX7A==
X-Gm-Message-State: AOAM533C6NPIy+qLDEzZ5XoobT+FC9AhP/aeQDhEGZ2x/ZdWaU16Avnx
        RO5XM4JoTaBBS2Z69aEa88t2LA==
X-Google-Smtp-Source: ABdhPJyOd+e0D3w2RvH0YwzjDS210l9X8dygNIzrstcAZIOzOTSN4BMw+qhHS4sbCr7ElWr3z2Hlmw==
X-Received: by 2002:a63:ea54:: with SMTP id l20mr4140855pgk.148.1644542715191;
        Thu, 10 Feb 2022 17:25:15 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:fb9d:6747:c0b4:f7ee])
        by smtp.gmail.com with ESMTPSA id m13sm23260146pfh.197.2022.02.10.17.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 17:25:14 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     benjamin.tissoires@redhat.com,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Kosina <jikos@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        "Sean O'Brien" <seobrien@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>
Subject: [PATCH v3 2/4] HID: Extract vivaldi hid feature mapping for use in hid-hammer
Date:   Thu, 10 Feb 2022 17:25:08 -0800
Message-Id: <20220211012510.1198155-3-swboyd@chromium.org>
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
In-Reply-To: <20220211012510.1198155-1-swboyd@chromium.org>
References: <20220211012510.1198155-1-swboyd@chromium.org>
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
index 57563d9da022..c736200b4511 100644
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

