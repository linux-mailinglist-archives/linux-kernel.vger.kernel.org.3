Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66C0C4B91FE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 21:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238495AbiBPT7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 14:59:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238492AbiBPT7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 14:59:51 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D23224968
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 11:59:37 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id m7so3508567pjk.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 11:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vHd6VxD3pISdJKOlDiTb4+AqZmiLYkQPRdmG+nB1JTc=;
        b=Fh17Yn70lbEn1UoieQE1xysG5dalZyz06ZVVRhDL5peLtqwGPyr9lLzz8TFdpGQ7+8
         AzPZMmtqK1vPiXYpjLLdGaEujy4M1oJnBrsx9M990wg0kc5jfhBc55IDftlzHK65z42x
         RtTqPMM8hlG/LlJszXonjkBRRlOx2zq3Fnuqs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vHd6VxD3pISdJKOlDiTb4+AqZmiLYkQPRdmG+nB1JTc=;
        b=yzvlv+PjXkJKuO2IqSlc2lkB5Pf0ToBt4Fyd41qTvhu26WHNBgSGwqWEdXIm0K+sve
         qhjKgpYczvenAcwHgmzGPag2ewBlvqR3ACU1GDExf8KImaRcqgTr9vo39k3UQK8aqRjV
         2bpRmRw2a8AErQRAC61fWyohGci4AXDaAtTH4ZO1/7ZO3i2lKuPBrbF6tJZxkKezP8cM
         9t1UqM18/Hvu6hJEVYhB913F0BEJIK3NXdchgOynxPNXS8yYpIQklEPr/hH33P14tS5v
         2YhZYf+1wNo5F3XCC6br2QhcXY0zVMz/ymoYOkqLqVKJZ5w6a9TiLUR+WAHJoQrp1TBb
         W8FA==
X-Gm-Message-State: AOAM531gHAwT2sX/OacZTZ7dBCg512W4+u4k7r0f119fmG4GJ8bE4QCh
        eVSLDsyEk2l1vfEizlBS4eB8nA==
X-Google-Smtp-Source: ABdhPJxFbYFIiaCMHyzuE9Lo+lXMT0G0Ytnx6QYHtC/R5ZuGNI5uj3ewfIJQWgyF0cFrSKYOm9PAew==
X-Received: by 2002:a17:90a:f482:b0:1bb:8504:864c with SMTP id bx2-20020a17090af48200b001bb8504864cmr3630264pjb.161.1645041577199;
        Wed, 16 Feb 2022 11:59:37 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:5f39:68a1:3c2b:3486])
        by smtp.gmail.com with ESMTPSA id u16sm6078840pgh.54.2022.02.16.11.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 11:59:36 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, benjamin.tissoires@redhat.com,
        Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org,
        "Sean O'Brien" <seobrien@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>
Subject: [PATCH v4 1/4] Input: Extract ChromeOS vivaldi physmap show function
Date:   Wed, 16 Feb 2022 11:58:58 -0800
Message-Id: <20220216195901.1326924-2-swboyd@chromium.org>
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

Let's introduce a common library file for the physmap show function
duplicated between three different keyboard drivers. This largely copies
the code from cros_ec_keyb.c which has the most recent version of the
show function, while using the vivaldi_data struct from the hid-vivaldi
driver. This saves a small amount of space in an allyesconfig build.

$ ./scripts/bloat-o-meter vmlinux.before vmlinux.after

add/remove: 3/0 grow/shrink: 2/3 up/down: 412/-720 (-308)
Function                                     old     new   delta
vivaldi_function_row_physmap_show              -     292    +292
_sub_I_65535_1                           1057564 1057616     +52
_sub_D_65535_0                           1057564 1057616     +52
e843419@49f2_00062737_9b04                     -       8      +8
e843419@20f6_0002a34d_35bc                     -       8      +8
atkbd_parse_fwnode_data                      480     472      -8
atkbd_do_show_function_row_physmap           316      76    -240
function_row_physmap_show                    620     148    -472
Total: Before=285581925, After=285581617, chg -0.00%

Cc: Jiri Kosina <jikos@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Tested-by: "Sean O'Brien" <seobrien@chromium.org>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/hid/Kconfig                   |  1 +
 drivers/hid/hid-vivaldi.c             | 27 +++++--------------
 drivers/input/Kconfig                 |  7 +++++
 drivers/input/Makefile                |  1 +
 drivers/input/keyboard/Kconfig        |  2 ++
 drivers/input/keyboard/atkbd.c        | 22 +++++----------
 drivers/input/keyboard/cros_ec_keyb.c | 32 ++++++++--------------
 drivers/input/vivaldi-fmap.c          | 39 +++++++++++++++++++++++++++
 include/linux/input/vivaldi-fmap.h    | 28 +++++++++++++++++++
 9 files changed, 102 insertions(+), 57 deletions(-)
 create mode 100644 drivers/input/vivaldi-fmap.c
 create mode 100644 include/linux/input/vivaldi-fmap.h

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index f5544157576c..5569a2029dab 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -411,6 +411,7 @@ config HID_GOOGLE_HAMMER
 
 config HID_VIVALDI
 	tristate "Vivaldi Keyboard"
+	select INPUT_VIVALDIFMAP
 	depends on HID
 	help
 	  Say Y here if you want to enable support for Vivaldi keyboards.
diff --git a/drivers/hid/hid-vivaldi.c b/drivers/hid/hid-vivaldi.c
index efa6140915f4..adb56b342948 100644
--- a/drivers/hid/hid-vivaldi.c
+++ b/drivers/hid/hid-vivaldi.c
@@ -8,37 +8,22 @@
 
 #include <linux/device.h>
 #include <linux/hid.h>
+#include <linux/input/vivaldi-fmap.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/sysfs.h>
 
-#define MIN_FN_ROW_KEY	1
-#define MAX_FN_ROW_KEY	24
 #define HID_VD_FN_ROW_PHYSMAP 0x00000001
 #define HID_USAGE_FN_ROW_PHYSMAP (HID_UP_GOOGLEVENDOR | HID_VD_FN_ROW_PHYSMAP)
 
-struct vivaldi_data {
-	u32 function_row_physmap[MAX_FN_ROW_KEY - MIN_FN_ROW_KEY + 1];
-	int max_function_row_key;
-};
-
 static ssize_t function_row_physmap_show(struct device *dev,
 					 struct device_attribute *attr,
 					 char *buf)
 {
 	struct hid_device *hdev = to_hid_device(dev);
 	struct vivaldi_data *drvdata = hid_get_drvdata(hdev);
-	ssize_t size = 0;
-	int i;
-
-	if (!drvdata->max_function_row_key)
-		return 0;
 
-	for (i = 0; i < drvdata->max_function_row_key; i++)
-		size += sprintf(buf + size, "%02X ",
-				drvdata->function_row_physmap[i]);
-	size += sprintf(buf + size, "\n");
-	return size;
+	return vivaldi_function_row_physmap_show(drvdata, buf);
 }
 
 static DEVICE_ATTR_RO(function_row_physmap);
@@ -86,10 +71,10 @@ static void vivaldi_feature_mapping(struct hid_device *hdev,
 		return;
 
 	fn_key = (usage->hid & HID_USAGE);
-	if (fn_key < MIN_FN_ROW_KEY || fn_key > MAX_FN_ROW_KEY)
+	if (fn_key < VIVALDI_MIN_FN_ROW_KEY || fn_key > VIVALDI_MAX_FN_ROW_KEY)
 		return;
-	if (fn_key > drvdata->max_function_row_key)
-		drvdata->max_function_row_key = fn_key;
+	if (fn_key > drvdata->num_function_row_keys)
+		drvdata->num_function_row_keys = fn_key;
 
 	report_data = buf = hid_alloc_report_buf(report, GFP_KERNEL);
 	if (!report_data)
@@ -134,7 +119,7 @@ static void vivaldi_feature_mapping(struct hid_device *hdev,
 		goto out;
 	}
 
-	drvdata->function_row_physmap[fn_key - MIN_FN_ROW_KEY] =
+	drvdata->function_row_physmap[fn_key - VIVALDI_MIN_FN_ROW_KEY] =
 	    field->value[usage->usage_index];
 
 out:
diff --git a/drivers/input/Kconfig b/drivers/input/Kconfig
index 5baebf62df33..e2752f7364bc 100644
--- a/drivers/input/Kconfig
+++ b/drivers/input/Kconfig
@@ -77,6 +77,13 @@ config INPUT_MATRIXKMAP
 	  To compile this driver as a module, choose M here: the
 	  module will be called matrix-keymap.
 
+config INPUT_VIVALDIFMAP
+	tristate
+	help
+	  ChromeOS Vivaldi keymap support library. This is a hidden
+	  option so that drivers can use common code to parse and
+	  expose the vivaldi function row keymap.
+
 comment "Userland interfaces"
 
 config INPUT_MOUSEDEV
diff --git a/drivers/input/Makefile b/drivers/input/Makefile
index 037cc595106c..f91874e76567 100644
--- a/drivers/input/Makefile
+++ b/drivers/input/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_INPUT)		+= input-core.o
 input-core-y := input.o input-compat.o input-mt.o input-poller.o ff-core.o
 input-core-y += touchscreen.o
 
+obj-$(CONFIG_INPUT_VIVALDIFMAP)	+= vivaldi-fmap.o
 obj-$(CONFIG_INPUT_FF_MEMLESS)	+= ff-memless.o
 obj-$(CONFIG_INPUT_SPARSEKMAP)	+= sparse-keymap.o
 obj-$(CONFIG_INPUT_MATRIXKMAP)	+= matrix-keymap.o
diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index 0c607da9ee10..8b4477e54a01 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -103,6 +103,7 @@ config KEYBOARD_ATKBD
 	select SERIO_LIBPS2
 	select SERIO_I8042 if ARCH_MIGHT_HAVE_PC_SERIO
 	select SERIO_GSCPS2 if GSC
+	select INPUT_VIVALDIFMAP
 	help
 	  Say Y here if you want to use a standard AT or PS/2 keyboard. Usually
 	  you'll need this, unless you have a different type keyboard (USB, ADB
@@ -749,6 +750,7 @@ config KEYBOARD_XTKBD
 config KEYBOARD_CROS_EC
 	tristate "ChromeOS EC keyboard"
 	select INPUT_MATRIXKMAP
+	select INPUT_VIVALDIFMAP
 	depends on CROS_EC
 	help
 	  Say Y here to enable the matrix keyboard used by ChromeOS devices
diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
index fbdef95291e9..fc980435c97a 100644
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -19,6 +19,7 @@
 #include <linux/interrupt.h>
 #include <linux/init.h>
 #include <linux/input.h>
+#include <linux/input/vivaldi-fmap.h>
 #include <linux/serio.h>
 #include <linux/workqueue.h>
 #include <linux/libps2.h>
@@ -237,8 +238,7 @@ struct atkbd {
 	/* Serializes reconnect(), attr->set() and event work */
 	struct mutex mutex;
 
-	u32 function_row_physmap[MAX_FUNCTION_ROW_KEYS];
-	int num_function_row_keys;
+	struct vivaldi_data vdata;
 };
 
 /*
@@ -308,17 +308,9 @@ static struct attribute *atkbd_attributes[] = {
 
 static ssize_t atkbd_show_function_row_physmap(struct atkbd *atkbd, char *buf)
 {
-	ssize_t size = 0;
-	int i;
-
-	if (!atkbd->num_function_row_keys)
-		return 0;
+	const struct vivaldi_data *data = &atkbd->vdata;
 
-	for (i = 0; i < atkbd->num_function_row_keys; i++)
-		size += scnprintf(buf + size, PAGE_SIZE - size, "%02X ",
-				  atkbd->function_row_physmap[i]);
-	size += scnprintf(buf + size, PAGE_SIZE - size, "\n");
-	return size;
+	return vivaldi_function_row_physmap_show(data, buf);
 }
 
 static umode_t atkbd_attr_is_visible(struct kobject *kobj,
@@ -329,7 +321,7 @@ static umode_t atkbd_attr_is_visible(struct kobject *kobj,
 	struct atkbd *atkbd = serio_get_drvdata(serio);
 
 	if (attr == &atkbd_attr_function_row_physmap.attr &&
-	    !atkbd->num_function_row_keys)
+	    !atkbd->vdata.num_function_row_keys)
 		return 0;
 
 	return attr->mode;
@@ -1208,8 +1200,8 @@ static void atkbd_parse_fwnode_data(struct serio *serio)
 	n = device_property_count_u32(dev, "function-row-physmap");
 	if (n > 0 && n <= MAX_FUNCTION_ROW_KEYS &&
 	    !device_property_read_u32_array(dev, "function-row-physmap",
-					    atkbd->function_row_physmap, n)) {
-		atkbd->num_function_row_keys = n;
+					    atkbd->vdata.function_row_physmap, n)) {
+		atkbd->vdata.num_function_row_keys = n;
 		dev_dbg(dev, "FW reported %d function-row key locations\n", n);
 	}
 }
diff --git a/drivers/input/keyboard/cros_ec_keyb.c b/drivers/input/keyboard/cros_ec_keyb.c
index fc02c540636e..3151e887b0f1 100644
--- a/drivers/input/keyboard/cros_ec_keyb.c
+++ b/drivers/input/keyboard/cros_ec_keyb.c
@@ -15,6 +15,7 @@
 #include <linux/bitops.h>
 #include <linux/i2c.h>
 #include <linux/input.h>
+#include <linux/input/vivaldi-fmap.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/notifier.h>
@@ -44,9 +45,7 @@
  * @idev: The input device for the matrix keys.
  * @bs_idev: The input device for non-matrix buttons and switches (or NULL).
  * @notifier: interrupt event notifier for transport devices
- * @function_row_physmap: An array of the encoded rows/columns for the top
- *                        row function keys, in an order from left to right
- * @num_function_row_keys: The number of top row keys in a custom keyboard
+ * @vdata: vivaldi function row data
  */
 struct cros_ec_keyb {
 	unsigned int rows;
@@ -64,8 +63,7 @@ struct cros_ec_keyb {
 	struct input_dev *bs_idev;
 	struct notifier_block notifier;
 
-	u16 function_row_physmap[MAX_NUM_TOP_ROW_KEYS];
-	size_t num_function_row_keys;
+	struct vivaldi_data vdata;
 };
 
 /**
@@ -537,7 +535,7 @@ static int cros_ec_keyb_register_matrix(struct cros_ec_keyb *ckdev)
 	int err;
 	struct property *prop;
 	const __be32 *p;
-	u16 *physmap;
+	u32 *physmap;
 	u32 key_pos;
 	int row, col;
 
@@ -591,10 +589,10 @@ static int cros_ec_keyb_register_matrix(struct cros_ec_keyb *ckdev)
 	ckdev->idev = idev;
 	cros_ec_keyb_compute_valid_keys(ckdev);
 
-	physmap = ckdev->function_row_physmap;
+	physmap = ckdev->vdata.function_row_physmap;
 	of_property_for_each_u32(dev->of_node, "function-row-physmap",
 				 prop, p, key_pos) {
-		if (ckdev->num_function_row_keys == MAX_NUM_TOP_ROW_KEYS) {
+		if (ckdev->vdata.num_function_row_keys == MAX_NUM_TOP_ROW_KEYS) {
 			dev_warn(dev, "Only support up to %d top row keys\n",
 				 MAX_NUM_TOP_ROW_KEYS);
 			break;
@@ -603,7 +601,7 @@ static int cros_ec_keyb_register_matrix(struct cros_ec_keyb *ckdev)
 		col = KEY_COL(key_pos);
 		*physmap = MATRIX_SCAN_CODE(row, col, ckdev->row_shift);
 		physmap++;
-		ckdev->num_function_row_keys++;
+		ckdev->vdata.num_function_row_keys++;
 	}
 
 	err = input_register_device(ckdev->idev);
@@ -619,18 +617,10 @@ static ssize_t function_row_physmap_show(struct device *dev,
 					 struct device_attribute *attr,
 					 char *buf)
 {
-	ssize_t size = 0;
-	int i;
-	struct cros_ec_keyb *ckdev = dev_get_drvdata(dev);
-	u16 *physmap = ckdev->function_row_physmap;
-
-	for (i = 0; i < ckdev->num_function_row_keys; i++)
-		size += scnprintf(buf + size, PAGE_SIZE - size,
-				  "%s%02X", size ? " " : "", physmap[i]);
-	if (size)
-		size += scnprintf(buf + size, PAGE_SIZE - size, "\n");
+	const struct cros_ec_keyb *ckdev = dev_get_drvdata(dev);
+	const struct vivaldi_data *data = &ckdev->vdata;
 
-	return size;
+	return vivaldi_function_row_physmap_show(data, buf);
 }
 
 static DEVICE_ATTR_RO(function_row_physmap);
@@ -648,7 +638,7 @@ static umode_t cros_ec_keyb_attr_is_visible(struct kobject *kobj,
 	struct cros_ec_keyb *ckdev = dev_get_drvdata(dev);
 
 	if (attr == &dev_attr_function_row_physmap.attr &&
-	    !ckdev->num_function_row_keys)
+	    !ckdev->vdata.num_function_row_keys)
 		return 0;
 
 	return attr->mode;
diff --git a/drivers/input/vivaldi-fmap.c b/drivers/input/vivaldi-fmap.c
new file mode 100644
index 000000000000..6dae83d96806
--- /dev/null
+++ b/drivers/input/vivaldi-fmap.c
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Helpers for ChromeOS Vivaldi keyboard function row mapping
+ *
+ * Copyright (C) 2022 Google, Inc
+ */
+
+#include <linux/export.h>
+#include <linux/input/vivaldi-fmap.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/types.h>
+
+/**
+ * vivaldi_function_row_physmap_show - Print vivaldi function row physmap attribute
+ * @data: The vivaldi function row map
+ * @buf: Buffer to print the function row phsymap to
+ */
+ssize_t vivaldi_function_row_physmap_show(const struct vivaldi_data *data,
+					  char *buf)
+{
+	ssize_t size = 0;
+	int i;
+	const u32 *physmap = data->function_row_physmap;
+
+	if (!data->num_function_row_keys)
+		return 0;
+
+	for (i = 0; i < data->num_function_row_keys; i++)
+		size += scnprintf(buf + size, PAGE_SIZE - size,
+				  "%s%02X", size ? " " : "", physmap[i]);
+	if (size)
+		size += scnprintf(buf + size, PAGE_SIZE - size, "\n");
+
+	return size;
+}
+EXPORT_SYMBOL_GPL(vivaldi_function_row_physmap_show);
+
+MODULE_LICENSE("GPL");
diff --git a/include/linux/input/vivaldi-fmap.h b/include/linux/input/vivaldi-fmap.h
new file mode 100644
index 000000000000..57563d9da022
--- /dev/null
+++ b/include/linux/input/vivaldi-fmap.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _VIVALDI_KEYMAP_H
+#define _VIVALDI_KEYMAP_H
+
+#include <linux/types.h>
+
+#define VIVALDI_MIN_FN_ROW_KEY	1
+#define VIVALDI_MAX_FN_ROW_KEY	24
+
+/**
+ * struct vivaldi_data - Function row keymap data for ChromeOS vivaldi keyboards
+ * @function_row_physmap: An array of the encoded rows/columns for the top
+ *                        row function keys, in an order from left to right
+ * @num_function_row_keys: The number of top row keys in a custom keyboard
+ *
+ * This structure is supposed to be used by ChromeOS keyboards using
+ * the vivaldi keyboard function row design.
+ */
+struct vivaldi_data {
+	u32 function_row_physmap[VIVALDI_MAX_FN_ROW_KEY - VIVALDI_MIN_FN_ROW_KEY + 1];
+	int num_function_row_keys;
+};
+
+
+ssize_t vivaldi_function_row_physmap_show(const struct vivaldi_data *data,
+					  char *buf);
+
+#endif /* _VIVALDI_KEYMAP_H */
-- 
https://chromeos.dev

