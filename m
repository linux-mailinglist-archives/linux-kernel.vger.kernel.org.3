Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 969634AE636
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 01:44:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240748AbiBIAod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 19:44:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231954AbiBIAoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 19:44:32 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26858C06157B;
        Tue,  8 Feb 2022 16:44:32 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id u12so775808plq.10;
        Tue, 08 Feb 2022 16:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PhTkr9X2ah1asuD3CJaoPYxIIUBXeUj/IV+DwOdgVXo=;
        b=Lp9hYtALz3JjG+ygVTjC/6yQYeq6ycUyyf5FSqYciSLle2keOrS7A85VJ1s/QHxqkn
         DwBpgRFt7BdEq/3FEN27loA0dh7v5uYwnbXf7hEq66NVlQhl9sS9EiuhGNujx4BknmhZ
         FBrSxOAPmz4QBqVefdhi0x+ji6IU5sBEFN/T0kzpP1yshJyiusF9MsLKLnO40jDT4rn6
         waVKeEzoBPoiptU0qX2CAFBQN+gYUoTlghBlMvi0Es4xaBeSteZuKxOsJoySQcVXMDYJ
         3jqm7XaRVTt5HUgYu2zKtNKQsSjSCrAbGoGjikuPBSf0Q6gBpBaCk7SVxXY4uezq13OQ
         B0vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PhTkr9X2ah1asuD3CJaoPYxIIUBXeUj/IV+DwOdgVXo=;
        b=UgNWoTsIRc+zl3MpZz98zVFm6lUbNcu+MGMcoWnHs6OkK1JVwrBKFVAnQSxB4RY2XF
         RSkDxFRzHsZSAiGznfWMGTyfptVvqs9Jh7AE+0Rrd+nOgAuA0zpBQwZUPU0bkDQ1jOlO
         XpbizGrmtPfzTXzrJINmRT8ix6KR+SJomM2Hmoz757YUjQEIjYFTPeTcokj2d9KFxaWt
         hZ045dCVQ5uNvuIQgnqLnvziagT5MwDxsxpi5Pq+zZ1vxxMM/QnYOP/4Ri5ncmADZjkk
         wpiiv0Wo6gIAQI95yYg0iPaYyBf4cKs/OCQDHJXSv0SSJs/Sk1BiPJPI8oR9R2pDkxq6
         KG0w==
X-Gm-Message-State: AOAM530HUK9CNeF2PJVEm8NAGvAyThzzeye/wNnY2s64hUS19aWHLB+J
        De1uU6eiFkm9JZ79Ff5Z1kg=
X-Google-Smtp-Source: ABdhPJytSqgPHdkgDrOt40m/jphipT+7Bnqd121V07WmUoJqTHxyqx5C0HU0dq8NUKaJM60Z/onu9Q==
X-Received: by 2002:a17:902:a58b:: with SMTP id az11mr762807plb.138.1644367471668;
        Tue, 08 Feb 2022 16:44:31 -0800 (PST)
Received: from localhost.localdomain (192.243.120.166.16clouds.com. [192.243.120.166])
        by smtp.gmail.com with ESMTPSA id o125sm13339621pfb.116.2022.02.08.16.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 16:44:31 -0800 (PST)
From:   davidcomponentone@gmail.com
To:     jikos@kernel.org
Cc:     davidcomponentone@gmail.com, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Guang <yang.guang5@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] HID: sony: replace snprintf with sysfs_emit
Date:   Wed,  9 Feb 2022 08:44:18 +0800
Message-Id: <2f021167336d2404aaba4c3bd7a075867a6a7e39.1644285940.git.yang.guang5@zte.com.cn>
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
./drivers/hid/hid-sony.c:710:8-16:
WARNING: use scnprintf or sprintf
./drivers/hid/hid-sony.c:747:8-16:
WARNING: use scnprintf or sprintf
./drivers/hid/hid-sony.c:759:8-16:
WARNING: use scnprintf or sprintf

Use sysfs_emit instead of scnprintf or sprintf makes more sense.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Yang Guang <yang.guang5@zte.com.cn>
Signed-off-by: David Yang <davidcomponentone@gmail.com>
---
 drivers/hid/hid-sony.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 60ec2b29d54d..94291472b381 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -707,7 +707,7 @@ static ssize_t ds4_show_poll_interval(struct device *dev,
 	struct hid_device *hdev = to_hid_device(dev);
 	struct sony_sc *sc = hid_get_drvdata(hdev);
 
-	return snprintf(buf, PAGE_SIZE, "%i\n", sc->ds4_bt_poll_interval);
+	return sysfs_emit(buf, "%i\n", sc->ds4_bt_poll_interval);
 }
 
 static ssize_t ds4_store_poll_interval(struct device *dev,
@@ -744,7 +744,7 @@ static ssize_t sony_show_firmware_version(struct device *dev,
 	struct hid_device *hdev = to_hid_device(dev);
 	struct sony_sc *sc = hid_get_drvdata(hdev);
 
-	return snprintf(buf, PAGE_SIZE, "0x%04x\n", sc->fw_version);
+	return sysfs_emit(buf, "0x%04x\n", sc->fw_version);
 }
 
 static DEVICE_ATTR(firmware_version, 0444, sony_show_firmware_version, NULL);
@@ -756,7 +756,7 @@ static ssize_t sony_show_hardware_version(struct device *dev,
 	struct hid_device *hdev = to_hid_device(dev);
 	struct sony_sc *sc = hid_get_drvdata(hdev);
 
-	return snprintf(buf, PAGE_SIZE, "0x%04x\n", sc->hw_version);
+	return sysfs_emit(buf, "0x%04x\n", sc->hw_version);
 }
 
 static DEVICE_ATTR(hardware_version, 0444, sony_show_hardware_version, NULL);
-- 
2.30.2

