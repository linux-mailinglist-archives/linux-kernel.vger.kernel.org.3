Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF2EC512A39
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 05:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232462AbiD1DyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 23:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242578AbiD1Dx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 23:53:56 -0400
X-Greylist: delayed 853 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 27 Apr 2022 20:50:41 PDT
Received: from m12-18.163.com (m12-18.163.com [220.181.12.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B8B3B7EA2A
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 20:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=TuAYJ
        x2UQjUJILtv4fv1iO/Jz1QPcGkbW4bVTIpTF8w=; b=RO90y+koyHK7K2Mc0E6ep
        HuI/4gLK96BkEw1swxBeoN/DpwFdSkspgXAOi0PpjwceJ2QCKXwGbWlxb1oabiRj
        Ee6mb2lYHWtB+t3PJKBI+uEOZ/N76m+IiE3b3Mvz6Ww/PZQo/MgnS9FqKT6JNiuZ
        g9Ae6Zecb8NOhyNCOL5Jh0=
Received: from carlis (unknown [218.17.89.92])
        by smtp14 (Coremail) with SMTP id EsCowAB3LeT_Dmpi0PglDQ--.39180S2;
        Thu, 28 Apr 2022 11:50:23 +0800 (CST)
From:   Xuezhi Zhang <zhangxuezhi1@coolpad.com>
To:     jikos@kernel.org, benjamin.tissoires@redhat.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xuezhi Zhang <zhangxuezhi1@coolpad.com>
Subject: [PATCH] HID: lenovo: convert sysfs snprintf to sysfs_emit
Date:   Thu, 28 Apr 2022 03:50:20 +0000
Message-Id: <20220428035020.250438-1-zhangxuezhi1@coolpad.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EsCowAB3LeT_Dmpi0PglDQ--.39180S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJFWftF45urW5uw4fuF4fAFb_yoWrZrW7pF
        17GayUArWUGrn7uw1YkF1IvasYvw1Iv347WryxG3WruFnayrWDKFyUua40q345CrWDAry3
        WF4rtrW5u3W8Xw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jlnmiUUUUU=
X-Originating-IP: [218.17.89.92]
Sender: llyz108@163.com
X-CM-SenderInfo: xoo16iiqy6il2tof0z/1tbiQxLwhVc7Y-ijwgAAsy
X-Spam-Status: No, score=3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warnings:
drivers/hid/hid-lenovo.c:636:8-16:
WARNING: use scnprintf or sprintf
drivers/hid/hid-lenovo.c:403:8-16:
WARNING: use scnprintf or sprintf
drivers/hid/hid-lenovo.c:755:8-16:
WARNING: use scnprintf or sprintf
drivers/hid/hid-lenovo.c:606:8-16:
WARNING: use scnprintf or sprintf
drivers/hid/hid-lenovo.c:666:8-16:
WARNING: use scnprintf or sprintf
drivers/hid/hid-lenovo.c:696:8-16:
WARNING: use scnprintf or sprintf
drivers/hid/hid-lenovo.c:445:8-16:
WARNING: use scnprintf or sprintf
drivers/hid/hid-lenovo.c:726:8-16:
WARNING: use scnprintf or sprintf

Signed-off-by: Xuezhi Zhang <zhangxuezhi1@coolpad.com>
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
2.25.1

