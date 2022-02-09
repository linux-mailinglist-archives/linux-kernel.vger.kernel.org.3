Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACD154AE62A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 01:41:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240371AbiBIAkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 19:40:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235164AbiBIAkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 19:40:03 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D84C06157B;
        Tue,  8 Feb 2022 16:40:02 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id w1so783982plb.6;
        Tue, 08 Feb 2022 16:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pw/t13XajTTjXLiskyNzHqhJgEjynQBnyaS9U4Kn/zw=;
        b=iiyQ296Z91oAqLC+EqEc2Sijxui2KK9qgLZLSVl3n3MaDXv2fZe2x1Tn6LDf/HhK/T
         +360JYu6yyj7MRZbJTFBjRMNrdx9hBv+GWaRtf/rW5gvIAYWcTrh9iW/PA8xCq/QFqPY
         H7cdj6tnj4XuT7F2nU/yzFbbgkQfnWH1ptzaTPT5EK/V8nPqnPIvFOgUliUELQ7Kn6Ew
         oK9fT29DnLcRej9IVpxCb2cIaKKLk3C1QdSidx++olK+uACk+PqVvwrcuQhPc+HxgG0j
         zsbldfO0eNDurDUZsOmhH2dCdczPEmPSmLz9grQmj8MEoV7fjI7w1BeVSaWHQxEM5I0t
         8s7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pw/t13XajTTjXLiskyNzHqhJgEjynQBnyaS9U4Kn/zw=;
        b=fQI9/ftcrQwLrLt7qCCIqAGcN4jdj0gIeiK/hXwYoFLDyY5uoyqQiKQibjRpYX7DMv
         WEnh2z7XN0TIskOmuO6o9AAA466oaw1u3X7OW5cm7Ybm6DZPhR/n/goRvHZtIc7zGWIJ
         lCgxIDeLomYKbDtrH8riK7HjggFM97BmpJGQ6kwfI/mg2qkOOY0ahLH8YKZnWp0vpPa5
         mviKuVOeNekgTfOLmhHUOSq/r3KjQpqa0GOfin/3/kyoAJlbg+CLf6InIFZquY+khZMw
         9q6LTQcSnQBdJUwq35WqSPFn195zRnQ8XmH/fesHmCiSGcmb751QnFlBjvL1QJAO0WzG
         /74w==
X-Gm-Message-State: AOAM530OKo4V4YFc2kQfmQ3IsEFA8JGSVly+QiHOO9nlSSzBKwV76Ya7
        FctUWac4sAiZIu6IjkbGBa0=
X-Google-Smtp-Source: ABdhPJw32H1cicCjiYxuExqABk0q04kGpiiS5u5nDIyLnzeSO997/8WlFVcEraNN1er2KGUIara9Pg==
X-Received: by 2002:a17:902:7c02:: with SMTP id x2mr7041282pll.47.1644367201831;
        Tue, 08 Feb 2022 16:40:01 -0800 (PST)
Received: from localhost.localdomain (192.243.120.166.16clouds.com. [192.243.120.166])
        by smtp.gmail.com with ESMTPSA id s32sm10969019pfw.80.2022.02.08.16.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 16:40:01 -0800 (PST)
From:   davidcomponentone@gmail.com
To:     jikos@kernel.org
Cc:     davidcomponentone@gmail.com, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Guang <yang.guang5@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] HID: lenovo: replace snprintf with sysfs_emit
Date:   Wed,  9 Feb 2022 08:39:48 +0800
Message-Id: <124b72fd0751d7f37c64dd517d386db38cf8c189.1644287860.git.yang.guang5@zte.com.cn>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Guang <yang.guang5@zte.com.cn>

coccinelle report:
./drivers/hid/hid-lenovo.c:636:8-16:
WARNING: use scnprintf or sprintf
./drivers/hid/hid-lenovo.c:403:8-16:
WARNING: use scnprintf or sprintf
./drivers/hid/hid-lenovo.c:755:8-16:
WARNING: use scnprintf or sprintf
./drivers/hid/hid-lenovo.c:606:8-16:
WARNING: use scnprintf or sprintf
./drivers/hid/hid-lenovo.c:666:8-16:
WARNING: use scnprintf or sprintf
./drivers/hid/hid-lenovo.c:696:8-16:
WARNING: use scnprintf or sprintf
./drivers/hid/hid-lenovo.c:445:8-16:
WARNING: use scnprintf or sprintf
./drivers/hid/hid-lenovo.c:726:8-16:
WARNING: use scnprintf or sprintf

Use sysfs_emit instead of scnprintf or sprintf makes more sense.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Yang Guang <yang.guang5@zte.com.cn>
Signed-off-by: David Yang <davidcomponentone@gmail.com>
---
 drivers/hid/hid-lenovo.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/hid/hid-lenovo.c b/drivers/hid/hid-lenovo.c
index 93b1f935e526..086a7aec7c1e 100644
--- a/drivers/hid/hid-lenovo.c
+++ b/drivers/hid/hid-lenovo.c
@@ -400,7 +400,7 @@ static ssize_t attr_fn_lock_show(struct device *dev,
 	struct hid_device *hdev = to_hid_device(dev);
 	struct lenovo_drvdata *data = hid_get_drvdata(hdev);
 
-	return snprintf(buf, PAGE_SIZE, "%u\n", data->fn_lock);
+	return sysfs_emit(buf, "%u\n", data->fn_lock);
 }
 
 static ssize_t attr_fn_lock_store(struct device *dev,
@@ -442,7 +442,7 @@ static ssize_t attr_sensitivity_show_cptkbd(struct device *dev,
 	struct hid_device *hdev = to_hid_device(dev);
 	struct lenovo_drvdata *cptkbd_data = hid_get_drvdata(hdev);
 
-	return snprintf(buf, PAGE_SIZE, "%u\n",
+	return sysfs_emit(buf, "%u\n",
 		cptkbd_data->sensitivity);
 }
 
@@ -603,7 +603,7 @@ static ssize_t attr_press_to_select_show_tpkbd(struct device *dev,
 	struct hid_device *hdev = to_hid_device(dev);
 	struct lenovo_drvdata *data_pointer = hid_get_drvdata(hdev);
 
-	return snprintf(buf, PAGE_SIZE, "%u\n", data_pointer->press_to_select);
+	return sysfs_emit(buf, "%u\n", data_pointer->press_to_select);
 }
 
 static ssize_t attr_press_to_select_store_tpkbd(struct device *dev,
@@ -633,7 +633,7 @@ static ssize_t attr_dragging_show_tpkbd(struct device *dev,
 	struct hid_device *hdev = to_hid_device(dev);
 	struct lenovo_drvdata *data_pointer = hid_get_drvdata(hdev);
 
-	return snprintf(buf, PAGE_SIZE, "%u\n", data_pointer->dragging);
+	return sysfs_emit(buf, "%u\n", data_pointer->dragging);
 }
 
 static ssize_t attr_dragging_store_tpkbd(struct device *dev,
@@ -663,7 +663,7 @@ static ssize_t attr_release_to_select_show_tpkbd(struct device *dev,
 	struct hid_device *hdev = to_hid_device(dev);
 	struct lenovo_drvdata *data_pointer = hid_get_drvdata(hdev);
 
-	return snprintf(buf, PAGE_SIZE, "%u\n", data_pointer->release_to_select);
+	return sysfs_emit(buf, "%u\n", data_pointer->release_to_select);
 }
 
 static ssize_t attr_release_to_select_store_tpkbd(struct device *dev,
@@ -693,7 +693,7 @@ static ssize_t attr_select_right_show_tpkbd(struct device *dev,
 	struct hid_device *hdev = to_hid_device(dev);
 	struct lenovo_drvdata *data_pointer = hid_get_drvdata(hdev);
 
-	return snprintf(buf, PAGE_SIZE, "%u\n", data_pointer->select_right);
+	return sysfs_emit(buf, "%u\n", data_pointer->select_right);
 }
 
 static ssize_t attr_select_right_store_tpkbd(struct device *dev,
@@ -723,7 +723,7 @@ static ssize_t attr_sensitivity_show_tpkbd(struct device *dev,
 	struct hid_device *hdev = to_hid_device(dev);
 	struct lenovo_drvdata *data_pointer = hid_get_drvdata(hdev);
 
-	return snprintf(buf, PAGE_SIZE, "%u\n",
+	return sysfs_emit(buf, "%u\n",
 		data_pointer->sensitivity);
 }
 
@@ -752,7 +752,7 @@ static ssize_t attr_press_speed_show_tpkbd(struct device *dev,
 	struct hid_device *hdev = to_hid_device(dev);
 	struct lenovo_drvdata *data_pointer = hid_get_drvdata(hdev);
 
-	return snprintf(buf, PAGE_SIZE, "%u\n",
+	return sysfs_emit(buf, "%u\n",
 		data_pointer->press_speed);
 }
 
-- 
2.30.2

