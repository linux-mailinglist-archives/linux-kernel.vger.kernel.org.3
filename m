Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3FE4AA119
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 21:20:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238412AbiBDUUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 15:20:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237509AbiBDUUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 15:20:31 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E37C06174E
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 12:20:27 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id d5so6602927pjk.5
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 12:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tMoGWwtYjtAOUkhvjOCJhK5Z921yyMCRTQ3P/6tLMeQ=;
        b=EZQw7V0nciNULmOoKV0u6+j3J4Th8yfFdf2cixYWjKZzUxhmEE9UrcN8ziHQi+Wr/Y
         +wf98/Jjury9vKO+q8e4YmOheXUMX77em3S3OTeuMbty8gImxuUsR274hlQFr2/m/WPU
         UBf3vWPDR3jhjm5EpQmVpfa2R6C5q0Xh8a494=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tMoGWwtYjtAOUkhvjOCJhK5Z921yyMCRTQ3P/6tLMeQ=;
        b=v8BRj8rETAjnGvr5+Yz7qnqhixeNNb1qrnfZ05ygnoQeSKP1nd8jMwwQUpY3m0eKLp
         IG7hwALY7g9RcWcLT5QDevIEDRQEqAfzdX4fBvRwTMDkso/ZtQsT2abqVXQqIRAIr8HG
         fGmMp/Bd6kUBKbNffei0Snb9rykmmYdwNnmBGuUmQ8GLjx5n930gAegq6aHOuucBLViK
         indqyEatO15m0UOX06vyfSp+uCneKOBYB+nZiOrGhoJPI54JktjXxh5OJZQsuXazKwfS
         Rru1ho0tg7xQGnzyMJfVu0q3aPAB0RAODzg7gIQst+d8qMuHlDnZ4dUdCCGUOGcMzyeQ
         YSkw==
X-Gm-Message-State: AOAM533jhloA2U5i+rlq+jAJNMmZjMH0EQIGs6lsrB2w4MKjPYPjyrSG
        YnwUdV2w1AERPcBpioQvAop1bQ==
X-Google-Smtp-Source: ABdhPJzwzksZG09mPu3PVdnBmhWKM/mGYwFEmZf3l2C9kovSBF42eZ1ixFuDBFfZMLITTgq3Zy/D7Q==
X-Received: by 2002:a17:902:e5c3:: with SMTP id u3mr1779787plf.21.1644006026504;
        Fri, 04 Feb 2022 12:20:26 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:1ba2:dd59:3b59:18bc])
        by smtp.gmail.com with ESMTPSA id q17sm3385561pfk.108.2022.02.04.12.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 12:20:26 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     benjamin.tissoires@redhat.com,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Kosina <jikos@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        "Sean O'Brien" <seobrien@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>
Subject: [PATCH 3/5] HID: Extract vivaldi hid feature mapping for use in hid-hammer
Date:   Fri,  4 Feb 2022 12:20:19 -0800
Message-Id: <20220204202021.895426-4-swboyd@chromium.org>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
In-Reply-To: <20220204202021.895426-1-swboyd@chromium.org>
References: <20220204202021.895426-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need to support parsing the HID device in both the vivaldi and the
hammer drivers so that we can properly expose the function row physmap
to userspace when a hammer device uses a vivaldi keyboard layout for the
function row keys. Extract the feature mapping logic from the vivaldi
driver into the vivaldi-keymap library so we can use it from both
HID drivers.

Cc: Jiri Kosina <jikos@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "Sean O'Brien" <seobrien@chromium.org>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/hid/hid-vivaldi.c            | 69 +---------------------
 drivers/input/vivaldi-keymap.c       | 86 ++++++++++++++++++++++++++++
 include/linux/input/vivaldi-keymap.h |  9 +++
 3 files changed, 97 insertions(+), 67 deletions(-)

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
diff --git a/drivers/input/vivaldi-keymap.c b/drivers/input/vivaldi-keymap.c
index da6dc4070216..7d472b8126b2 100644
--- a/drivers/input/vivaldi-keymap.c
+++ b/drivers/input/vivaldi-keymap.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/export.h>
+#include <linux/hid.h>
 #include <linux/input/vivaldi-keymap.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -36,4 +37,89 @@ ssize_t vivaldi_function_row_physmap_show(const struct vivaldi_data *data,
 }
 EXPORT_SYMBOL_GPL(vivaldi_function_row_physmap_show);
 
+#if IS_ENABLED(CONFIG_HID)
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
+#endif /* CONFIG_HID */
+
 MODULE_LICENSE("GPL");
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

