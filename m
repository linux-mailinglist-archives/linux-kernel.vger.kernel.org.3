Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D83745A7F1D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 15:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbiHaNnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 09:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbiHaNnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 09:43:09 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C06CD127B;
        Wed, 31 Aug 2022 06:43:07 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id c66so4183272pfc.10;
        Wed, 31 Aug 2022 06:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=QX+pK6pl51LdKNSDDQw1Lof7kBsf/PjbDKJj0w0kufU=;
        b=MstNWsW/rd4BWnVxjuRvSSOPnjbd5+FGCvfiM9EtPwTb1rKQqMKE1g0y56Z/O2qOXL
         KmuI1XlrmqqRLaw3gUVvtqDE5z2y1ZHARqdoG6gGJsab4Uj/nY8/Y4To03lJDNkEhu+c
         ZnMNGHXINUTqolRFVbCftNiwX7casPkhcZGq3dLqVOCOCrjWVTTaYHyvvkz4jNRtiB/L
         B9F4cEEZdjOjcNOIXzK8W2nhDOAPv4yqNyxTzEHNqbExfJTyYmHDAndE7E0LsAS6GA/B
         SicjUg/qZq29h2IUu9WfN8+W7a9gZCFiZqxQRrI8EFH9saY+HGs1BxXBs/xuq0ldQ8hc
         1ymQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=QX+pK6pl51LdKNSDDQw1Lof7kBsf/PjbDKJj0w0kufU=;
        b=raNALThCNOkYla6r3nR3JAGOKzllsyV/zAawe/3SUYV1ReDBqCnYqwIU602+6hURsF
         Nt+4S+NOyNDbEYeDDCHoQS0qxOwEqrm7lbZn6RTBX3rfOvk12tl5AK9Qw0jFWAT4QInd
         bjLSk4flCf0VtKTRevRRlf/upPT+vq2CYZwH973GBPlo+yNZIoXlENgsdoCV8pzuz9SB
         kL8T4Ow99qe2UjgiKSuSRar66geZW/7264IN93VJZ17lF5vluMmbewgY+2JxQF2gyFZe
         JVllPRCIbatsUoZQXqdlay+hDEIFZo7grlm7XPMdD7ewKrqQDWhcu4wtWHB1hSD653zC
         Z+Gw==
X-Gm-Message-State: ACgBeo24nSe/QRc62MM3Aj/zC41Sylq1IT0V1wZy1LBDQYibWs50i6jY
        keRD2r3acFAoQyliwHJp+Q8=
X-Google-Smtp-Source: AA6agR5LhvjAGAJAC1ejVM7dLx4XQes9u2zFghzTOqsZhZPlcA8t2SbOtphu9/fXDpMrGsTDyJr1aQ==
X-Received: by 2002:a65:5688:0:b0:3c2:1015:988e with SMTP id v8-20020a655688000000b003c21015988emr22104168pgs.280.1661953387018;
        Wed, 31 Aug 2022 06:43:07 -0700 (PDT)
Received: from carlis-virtual-machine.localdomain ([156.236.96.164])
        by smtp.gmail.com with ESMTPSA id a19-20020a170902ee9300b0016d773aae60sm7288858pld.19.2022.08.31.06.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 06:43:06 -0700 (PDT)
From:   Xuezhi Zhang <zhangxuezhi3@gmail.com>
To:     erazor_de@users.sourceforge.net, jikos@kernel.org,
        benjamin.tissoires@redhat.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhangxuezhi3@gmail.com, Xuezhi Zhang <zhangxuezhi1@coolpad.com>
Subject: [PATCH] HID: roccat: convert sysfs snprintf to sysfs_emit
Date:   Wed, 31 Aug 2022 21:43:02 +0800
Message-Id: <20220831134302.366439-1-zhangxuezhi3@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xuezhi Zhang <zhangxuezhi1@coolpad.com>

Fix up all sysfs show entries to use sysfs_emit

Signed-off-by: Xuezhi Zhang <zhangxuezhi1@coolpad.com>
---
 drivers/hid/hid-roccat-pyra.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-roccat-pyra.c b/drivers/hid/hid-roccat-pyra.c
index 4fcc8e7d276f..8b4d2519d4c4 100644
--- a/drivers/hid/hid-roccat-pyra.c
+++ b/drivers/hid/hid-roccat-pyra.c
@@ -286,7 +286,7 @@ static ssize_t pyra_sysfs_show_actual_cpi(struct device *dev,
 {
 	struct pyra_device *pyra =
 			hid_get_drvdata(dev_get_drvdata(dev->parent->parent));
-	return snprintf(buf, PAGE_SIZE, "%d\n", pyra->actual_cpi);
+	return sysfs_emit(buf, "%d\n", pyra->actual_cpi);
 }
 static DEVICE_ATTR(actual_cpi, 0440, pyra_sysfs_show_actual_cpi, NULL);
 
@@ -303,7 +303,7 @@ static ssize_t pyra_sysfs_show_actual_profile(struct device *dev,
 			&settings, PYRA_SIZE_SETTINGS);
 	mutex_unlock(&pyra->pyra_lock);
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", settings.startup_profile);
+	return sysfs_emit(buf, "%d\n", settings.startup_profile);
 }
 static DEVICE_ATTR(actual_profile, 0440, pyra_sysfs_show_actual_profile, NULL);
 static DEVICE_ATTR(startup_profile, 0440, pyra_sysfs_show_actual_profile, NULL);
@@ -324,7 +324,7 @@ static ssize_t pyra_sysfs_show_firmware_version(struct device *dev,
 			&info, PYRA_SIZE_INFO);
 	mutex_unlock(&pyra->pyra_lock);
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", info.firmware_version);
+	return sysfs_emit(buf, "%d\n", info.firmware_version);
 }
 static DEVICE_ATTR(firmware_version, 0440, pyra_sysfs_show_firmware_version,
 		   NULL);
-- 
2.25.1

