Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1121C4AE739
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 03:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234551AbiBICpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 21:45:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240910AbiBIAqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 19:46:17 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E600DC061576;
        Tue,  8 Feb 2022 16:46:16 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id a11-20020a17090a740b00b001b8b506c42fso3639131pjg.0;
        Tue, 08 Feb 2022 16:46:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s4mwh3fmLLPxnZWV6Va7gZyohTfajy6eCYjc+ulM7/Q=;
        b=AAfGd3/lZ9HMxC6YhGy8ZGhOKbAyfRBzUF++fnqACslLwSt5+jewWwfk884I+SMd41
         2wpzme4z9l2t3Ox8tb4Emkjd8upKs/5jY0InHKGj+lNNmLb8Rnk4YXLPnHy63066T35J
         6WEhIHBtImmSXWDTeeHGqull+FNrVtjKt17xbWhX0eWs4/+DaK6nV7TMrivFTUUh6E22
         X4rnrajk86ti/0gnP++8rphBHNOiFntlFCPPpeDo4reAr7fAVxdxS6X0ntglU5IUwOuP
         a3f63M/kr1Z1PJaaLKGDowEQN6g6z+u1WVlKLyeimjcEQaOh1t8l6kz0lu6GABnjfvd9
         76Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s4mwh3fmLLPxnZWV6Va7gZyohTfajy6eCYjc+ulM7/Q=;
        b=MCP62/yPb0FWEGOmHNT3m8KzGdEP1rWtRop9mekkSLG86N1laFieUzU9jhWy+USbzw
         6REDDDSMHEzew2PkECN+CDVs81vDSOMfqxC7FH4IPDTNVEW9JMDxL9WewjKse78R6ZbW
         lw4F6+rmV8Tg0mVze/wIewqexbENP5qn4Szn7xr1j9NxA6dYyBBdsdAVTgkG+8OjDGhL
         3qJS9ixnQJEYI5byBR/7m7N6lecN4tjz4KUYPc57WXJ45dytJYMsuBVNh2SnOzJHAWrf
         WhLnG7Qv+w1vKclwrGmkqRB8+Uav14RSsgUankjA3MDwMPf6EX+QknWYdF5jxKyNDCzv
         mamg==
X-Gm-Message-State: AOAM533L+7qFwU2vCKUWV4Ynvct9iz3MTPhbJcNMS1h4O54VqJ39TN5o
        Ha+6OHSeCwIviSOXdSc3aD8=
X-Google-Smtp-Source: ABdhPJwKIjAkrU43Ez89nlaZfp0v1g46r3efeDx5mHvXpWBFskggvtrQfQaafKzY0dA4rH0IF1u6lw==
X-Received: by 2002:a17:90b:507:: with SMTP id r7mr659415pjz.78.1644367576455;
        Tue, 08 Feb 2022 16:46:16 -0800 (PST)
Received: from localhost.localdomain (192.243.120.166.16clouds.com. [192.243.120.166])
        by smtp.gmail.com with ESMTPSA id q1sm3781099pjd.48.2022.02.08.16.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 16:46:16 -0800 (PST)
From:   davidcomponentone@gmail.com
To:     erazor_de@users.sourceforge.net
Cc:     davidcomponentone@gmail.com, jikos@kernel.org,
        benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Guang <yang.guang5@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] HID: roccat: replace snprintf with sysfs_emit
Date:   Wed,  9 Feb 2022 08:45:59 +0800
Message-Id: <eb90e8fcdc793419550e42fda772ef2a5cb6751c.1644284775.git.yang.guang5@zte.com.cn>
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
./drivers/hid/hid-roccat-kovaplus.c:330:8-16:
WARNING: use scnprintf or sprintf
./drivers/hid/hid-roccat-kovaplus.c:277:8-16:
WARNING: use scnprintf or sprintf
./drivers/hid/hid-roccat-kovaplus.c:339:8-16:
WARNING: use scnprintf or sprintf
./drivers/hid/hid-roccat-kovaplus.c:349:8-16:
WARNING: use scnprintf or sprintf
./drivers/hid/hid-roccat-kovaplus.c:370:8-16:
WARNING: use scnprintf or sprintf

Use sysfs_emit instead of scnprintf or sprintf makes more sense.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Yang Guang <yang.guang5@zte.com.cn>
Signed-off-by: David Yang <davidcomponentone@gmail.com>
---
 drivers/hid/hid-roccat-kovaplus.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-roccat-kovaplus.c b/drivers/hid/hid-roccat-kovaplus.c
index 6fb9b9563769..7f6238a19739 100644
--- a/drivers/hid/hid-roccat-kovaplus.c
+++ b/drivers/hid/hid-roccat-kovaplus.c
@@ -274,7 +274,7 @@ static ssize_t kovaplus_sysfs_show_actual_profile(struct device *dev,
 {
 	struct kovaplus_device *kovaplus =
 			hid_get_drvdata(dev_get_drvdata(dev->parent->parent));
-	return snprintf(buf, PAGE_SIZE, "%d\n", kovaplus->actual_profile);
+	return sysfs_emit(buf, "%d\n", kovaplus->actual_profile);
 }
 
 static ssize_t kovaplus_sysfs_set_actual_profile(struct device *dev,
@@ -327,7 +327,7 @@ static ssize_t kovaplus_sysfs_show_actual_cpi(struct device *dev,
 {
 	struct kovaplus_device *kovaplus =
 			hid_get_drvdata(dev_get_drvdata(dev->parent->parent));
-	return snprintf(buf, PAGE_SIZE, "%d\n", kovaplus->actual_cpi);
+	return sysfs_emit(buf, "%d\n", kovaplus->actual_cpi);
 }
 static DEVICE_ATTR(actual_cpi, 0440, kovaplus_sysfs_show_actual_cpi, NULL);
 
@@ -336,7 +336,7 @@ static ssize_t kovaplus_sysfs_show_actual_sensitivity_x(struct device *dev,
 {
 	struct kovaplus_device *kovaplus =
 			hid_get_drvdata(dev_get_drvdata(dev->parent->parent));
-	return snprintf(buf, PAGE_SIZE, "%d\n", kovaplus->actual_x_sensitivity);
+	return sysfs_emit(buf, "%d\n", kovaplus->actual_x_sensitivity);
 }
 static DEVICE_ATTR(actual_sensitivity_x, 0440,
 		   kovaplus_sysfs_show_actual_sensitivity_x, NULL);
@@ -346,7 +346,7 @@ static ssize_t kovaplus_sysfs_show_actual_sensitivity_y(struct device *dev,
 {
 	struct kovaplus_device *kovaplus =
 			hid_get_drvdata(dev_get_drvdata(dev->parent->parent));
-	return snprintf(buf, PAGE_SIZE, "%d\n", kovaplus->actual_y_sensitivity);
+	return sysfs_emit(buf, "%d\n", kovaplus->actual_y_sensitivity);
 }
 static DEVICE_ATTR(actual_sensitivity_y, 0440,
 		   kovaplus_sysfs_show_actual_sensitivity_y, NULL);
@@ -367,7 +367,7 @@ static ssize_t kovaplus_sysfs_show_firmware_version(struct device *dev,
 			&info, KOVAPLUS_SIZE_INFO);
 	mutex_unlock(&kovaplus->kovaplus_lock);
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", info.firmware_version);
+	return sysfs_emit(buf, "%d\n", info.firmware_version);
 }
 static DEVICE_ATTR(firmware_version, 0440,
 		   kovaplus_sysfs_show_firmware_version, NULL);
-- 
2.30.2

