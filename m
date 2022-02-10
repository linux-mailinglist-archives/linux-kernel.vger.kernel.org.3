Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 550EB4B0A9D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 11:31:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239650AbiBJKaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 05:30:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238573AbiBJKap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 05:30:45 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0706BFD5;
        Thu, 10 Feb 2022 02:30:47 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id r19so9436353pfh.6;
        Thu, 10 Feb 2022 02:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u8Rld+m6OEJFLOsMO8vIniJg0JFc0WepfyNgmJKCu48=;
        b=hn1uw+yTA6qNKKFEVtpq5qJXS9gBX3gkuxZRQi3zMi3bIOSmY3JofKCqisNIS7R056
         h/Y0mDk1aj0xlheQShSlisg1HLVOo0Ww0f61X6a01WcQjOJ6ekTKJcY1ffx0kOa+O0JS
         OjknpUtRZA6KdPXaFTqavMmbXNQ2lRwoNxtVXb1+gVUy8dNDFKk6fP8J/7NHMFcvvsKt
         F47/ImeydzRQUz6hLRLJAUcsQot/72ywWw95mQHcyo3yesSMcjL1SvATPees4I8fByJd
         /rl+dt5O+pkJF/TeXPK7yT/mCG+Dnqkp+2eyHxHBHd5wmoHrU0B1/rco5vD8EdXoBnZY
         RJyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u8Rld+m6OEJFLOsMO8vIniJg0JFc0WepfyNgmJKCu48=;
        b=RphOYGMEeJ4PyijoU//8C2FIWf3DxypdHZPz0uI4hdO/v9bTX40vVdtvBt6mAKX3rD
         g9LDXnDvrzLNCoF9Y4KjwN4Vrnx1eJ6qoSh3sekOIcwUsEEA2IZiY9mAvmoH2URel1oA
         6W25QLX0F4ReoylXzr/GzU8RFpWrWMsj7IVX6OYlgmXz73ukYqmQ+PbqcHJSb94c0eBv
         +Di6WVv2C4lp+kSdn9mlXe0iyu6EaoG2Wy4xjf92f96WLzLNDiMj+3jYEPPyo1jp5QWn
         XADRbKYENxx536nr4UKdfVF9ts/2s1IECqbmQVQ5RLzqBTdJBSuyUIfnamUGTAx3l2yz
         7TKA==
X-Gm-Message-State: AOAM532oJFvL24jde+5rV30cuRxTtQ12p4rwPLqlMapug+60B1HIJhPu
        BOj7Uv8Pcq9fzuPP8NzXlgA=
X-Google-Smtp-Source: ABdhPJy+48YXnVW5XW4uzVHpXO7BcxA/pbAbynGq8rTHE0PTo4LoEzEPbftoG4ZaMXUe0NNhw14uYw==
X-Received: by 2002:a05:6a00:2305:: with SMTP id h5mr6925065pfh.13.1644489046507;
        Thu, 10 Feb 2022 02:30:46 -0800 (PST)
Received: from localhost.localdomain (192.243.120.166.16clouds.com. [192.243.120.166])
        by smtp.gmail.com with ESMTPSA id s42sm24041730pfg.146.2022.02.10.02.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 02:30:45 -0800 (PST)
From:   davidcomponentone@gmail.com
To:     jikos@kernel.org
Cc:     davidcomponentone@gmail.com, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Guang <yang.guang5@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH v2] HID: lenovo: replace snprintf with sysfs_emit
Date:   Thu, 10 Feb 2022 18:30:30 +0800
Message-Id: <abc0adf5d226f72a0df7de90a08faaa6710647d9.1644396161.git.yang.guang5@zte.com.cn>
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
Change from v1-v2:
- Adjust some format

---
 drivers/hid/hid-lenovo.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/hid/hid-lenovo.c b/drivers/hid/hid-lenovo.c
index 93b1f935e526..69ae39bdbe70 100644
--- a/drivers/hid/hid-lenovo.c
+++ b/drivers/hid/hid-lenovo.c
@@ -400,7 +400,7 @@ static ssize_t attr_fn_lock_show(struct device *dev,
 	struct hid_device *hdev = to_hid_device(dev);
 	struct lenovo_drvdata *data = hid_get_drvdata(hdev);
 
-	return snprintf(buf, PAGE_SIZE, "%u\n", data->fn_lock);
+	return sysfs_emit(buf, "%u\n", data->fn_lock);
 }
 
 static ssize_t attr_fn_lock_store(struct device *dev,
@@ -442,8 +442,7 @@ static ssize_t attr_sensitivity_show_cptkbd(struct device *dev,
 	struct hid_device *hdev = to_hid_device(dev);
 	struct lenovo_drvdata *cptkbd_data = hid_get_drvdata(hdev);
 
-	return snprintf(buf, PAGE_SIZE, "%u\n",
-		cptkbd_data->sensitivity);
+	return sysfs_emit(buf, "%u\n", cptkbd_data->sensitivity);
 }
 
 static ssize_t attr_sensitivity_store_cptkbd(struct device *dev,
@@ -603,7 +602,7 @@ static ssize_t attr_press_to_select_show_tpkbd(struct device *dev,
 	struct hid_device *hdev = to_hid_device(dev);
 	struct lenovo_drvdata *data_pointer = hid_get_drvdata(hdev);
 
-	return snprintf(buf, PAGE_SIZE, "%u\n", data_pointer->press_to_select);
+	return sysfs_emit(buf, "%u\n", data_pointer->press_to_select);
 }
 
 static ssize_t attr_press_to_select_store_tpkbd(struct device *dev,
@@ -633,7 +632,7 @@ static ssize_t attr_dragging_show_tpkbd(struct device *dev,
 	struct hid_device *hdev = to_hid_device(dev);
 	struct lenovo_drvdata *data_pointer = hid_get_drvdata(hdev);
 
-	return snprintf(buf, PAGE_SIZE, "%u\n", data_pointer->dragging);
+	return sysfs_emit(buf, "%u\n", data_pointer->dragging);
 }
 
 static ssize_t attr_dragging_store_tpkbd(struct device *dev,
@@ -663,7 +662,7 @@ static ssize_t attr_release_to_select_show_tpkbd(struct device *dev,
 	struct hid_device *hdev = to_hid_device(dev);
 	struct lenovo_drvdata *data_pointer = hid_get_drvdata(hdev);
 
-	return snprintf(buf, PAGE_SIZE, "%u\n", data_pointer->release_to_select);
+	return sysfs_emit(buf, "%u\n", data_pointer->release_to_select);
 }
 
 static ssize_t attr_release_to_select_store_tpkbd(struct device *dev,
@@ -693,7 +692,7 @@ static ssize_t attr_select_right_show_tpkbd(struct device *dev,
 	struct hid_device *hdev = to_hid_device(dev);
 	struct lenovo_drvdata *data_pointer = hid_get_drvdata(hdev);
 
-	return snprintf(buf, PAGE_SIZE, "%u\n", data_pointer->select_right);
+	return sysfs_emit(buf, "%u\n", data_pointer->select_right);
 }
 
 static ssize_t attr_select_right_store_tpkbd(struct device *dev,
@@ -723,8 +722,7 @@ static ssize_t attr_sensitivity_show_tpkbd(struct device *dev,
 	struct hid_device *hdev = to_hid_device(dev);
 	struct lenovo_drvdata *data_pointer = hid_get_drvdata(hdev);
 
-	return snprintf(buf, PAGE_SIZE, "%u\n",
-		data_pointer->sensitivity);
+	return sysfs_emit(buf, "%u\n", data_pointer->sensitivity);
 }
 
 static ssize_t attr_sensitivity_store_tpkbd(struct device *dev,
@@ -752,8 +750,7 @@ static ssize_t attr_press_speed_show_tpkbd(struct device *dev,
 	struct hid_device *hdev = to_hid_device(dev);
 	struct lenovo_drvdata *data_pointer = hid_get_drvdata(hdev);
 
-	return snprintf(buf, PAGE_SIZE, "%u\n",
-		data_pointer->press_speed);
+	return sysfs_emit(buf, "%u\n", data_pointer->press_speed);
 }
 
 static ssize_t attr_press_speed_store_tpkbd(struct device *dev,
-- 
2.30.2

