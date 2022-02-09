Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAA834AE727
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 03:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344891AbiBICo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 21:44:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241003AbiBIAsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 19:48:09 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544AFC061576;
        Tue,  8 Feb 2022 16:48:08 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id y5so1405060pfe.4;
        Tue, 08 Feb 2022 16:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DxejLyJZOr+Wj9kJP5Bh3+D+UCu71YvuxzkpYt5n3nQ=;
        b=ArHH/2BI46pSXLM93jBgG29wqGQ8UCztyzoxY8wYh+tDQ+LWbFQO4mEOozYkwuhLD0
         ct1V56llS6x6hlyWQWOT/Mrs2LCthjkG66S6QankTK071FrAmUZbYc5H1WMwk4HTKG0x
         JQvJhNgc13yjToQM4r0cL9SH9qrG2oON+rEge6jK7WYIpaqT3AlnZsSU7qgDEXzfpSMz
         3jXCd+k5ob9o9VE2/RHIvYLL2jgm0DLwp0LSZYWzF4+RKmmt0oX3u44EvSRmR6hxRWLC
         0rPspknfR4ed4C8X3m0lpDx+522dO01k9EpahIaQuIwMnL2XypDlXwmYWAkSxnjCmhjI
         laWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DxejLyJZOr+Wj9kJP5Bh3+D+UCu71YvuxzkpYt5n3nQ=;
        b=UXRQIHHkYyROjIQK2bjT+JXKFmvfEGds3R6839psyHFgePfEFobjhn8kSClioe3igm
         f+bF22p1uZLm0+Der4VLYW0u3VGft8EnCWPKqmq65tipyfkak0zLyCYiZ1s+HAJ4Txr/
         ve72MbWH9SyWwaGkgKbdx0CJ/JBQXqRcLfruzjyuXn8GC7yJNGr4p/Y9jtdmyQtcPWiM
         VZl8OX7Tew4J2ye+Uojh3+LTaHVs9a+iI1n+hdjJHjD7xcaPXe9SBnD5Q8KgiAMtWgFa
         KEPTNsfyu7EZJq2Yss70bTngfLBocAbL/OOkW2N4211q3q0jsL/0nx9ctHz8VngRApd3
         KHuw==
X-Gm-Message-State: AOAM531hd1nbpNwXVIVY+diJc8nx5ytiLSVFUeulao8ya/nKfl32T1yg
        3YVZzpkfvOiU9+zLEY9pv34=
X-Google-Smtp-Source: ABdhPJzphsSMkiPhojvBatZrHfBuu0GRELRnZ5kBq4wN8yungzUl2GYKsMC8I3TevIAcEVFsPd27dA==
X-Received: by 2002:a63:914b:: with SMTP id l72mr2989198pge.223.1644367687889;
        Tue, 08 Feb 2022 16:48:07 -0800 (PST)
Received: from localhost.localdomain (192.243.120.166.16clouds.com. [192.243.120.166])
        by smtp.gmail.com with ESMTPSA id t9sm3826518pjg.44.2022.02.08.16.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 16:48:07 -0800 (PST)
From:   davidcomponentone@gmail.com
To:     jejb@linux.ibm.com
Cc:     davidcomponentone@gmail.com, martin.petersen@oracle.com,
        yang.guang5@zte.com.cn, bvanassche@acm.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] scsi: arcmsr: replace snprintf with sysfs_emit
Date:   Wed,  9 Feb 2022 08:47:55 +0800
Message-Id: <1c5ade32e6e60c94dd357c4a159df64a7e311459.1644283712.git.yang.guang5@zte.com.cn>
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
./drivers/scsi/arcmsr/arcmsr_attr.c:297:8-16:
WARNING: use scnprintf or sprintf
./drivers/scsi/arcmsr/arcmsr_attr.c:273:8-16:
WARNING: use scnprintf or sprintf
./drivers/scsi/arcmsr/arcmsr_attr.c:285:8-16:
WARNING: use scnprintf or sprintf
./drivers/scsi/arcmsr/arcmsr_attr.c:261:8-16:
WARNING: use scnprintf or sprintf
./drivers/scsi/arcmsr/arcmsr_attr.c:374:8-16:
WARNING: use scnprintf or sprintf
./drivers/scsi/arcmsr/arcmsr_attr.c:309:8-16:
WARNING: use scnprintf or sprintf
./drivers/scsi/arcmsr/arcmsr_attr.c:348:8-16:
WARNING: use scnprintf or sprintf
./drivers/scsi/arcmsr/arcmsr_attr.c:335:8-16:
WARNING: use scnprintf or sprintf
./drivers/scsi/arcmsr/arcmsr_attr.c:361:8-16:
WARNING: use scnprintf or sprintf
./drivers/scsi/arcmsr/arcmsr_attr.c:322:8-16:
WARNING: use scnprintf or sprintf

Use sysfs_emit instead of scnprintf or sprintf makes more sense.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Yang Guang <yang.guang5@zte.com.cn>
Signed-off-by: David Yang <davidcomponentone@gmail.com>
---
 drivers/scsi/arcmsr/arcmsr_attr.c | 30 ++++++++++--------------------
 1 file changed, 10 insertions(+), 20 deletions(-)

diff --git a/drivers/scsi/arcmsr/arcmsr_attr.c b/drivers/scsi/arcmsr/arcmsr_attr.c
index baeb5e795690..e66d761926e9 100644
--- a/drivers/scsi/arcmsr/arcmsr_attr.c
+++ b/drivers/scsi/arcmsr/arcmsr_attr.c
@@ -258,8 +258,7 @@ static ssize_t
 arcmsr_attr_host_driver_version(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE,
-			"%s\n",
+	return sysfs_emit(buf, "%s\n",
 			ARCMSR_DRIVER_VERSION);
 }
 
@@ -270,8 +269,7 @@ arcmsr_attr_host_driver_posted_cmd(struct device *dev,
 	struct Scsi_Host *host = class_to_shost(dev);
 	struct AdapterControlBlock *acb =
 		(struct AdapterControlBlock *) host->hostdata;
-	return snprintf(buf, PAGE_SIZE,
-			"%4d\n",
+	return sysfs_emit(buf, "%4d\n",
 			atomic_read(&acb->ccboutstandingcount));
 }
 
@@ -282,8 +280,7 @@ arcmsr_attr_host_driver_reset(struct device *dev,
 	struct Scsi_Host *host = class_to_shost(dev);
 	struct AdapterControlBlock *acb =
 		(struct AdapterControlBlock *) host->hostdata;
-	return snprintf(buf, PAGE_SIZE,
-			"%4d\n",
+	return sysfs_emit(buf, "%4d\n",
 			acb->num_resets);
 }
 
@@ -294,8 +291,7 @@ arcmsr_attr_host_driver_abort(struct device *dev,
 	struct Scsi_Host *host = class_to_shost(dev);
 	struct AdapterControlBlock *acb =
 		(struct AdapterControlBlock *) host->hostdata;
-	return snprintf(buf, PAGE_SIZE,
-			"%4d\n",
+	return sysfs_emit(buf, "%4d\n",
 			acb->num_aborts);
 }
 
@@ -306,8 +302,7 @@ arcmsr_attr_host_fw_model(struct device *dev, struct device_attribute *attr,
 	struct Scsi_Host *host = class_to_shost(dev);
 	struct AdapterControlBlock *acb =
 		(struct AdapterControlBlock *) host->hostdata;
-	return snprintf(buf, PAGE_SIZE,
-			"%s\n",
+	return sysfs_emit(buf, "%s\n",
 			acb->firm_model);
 }
 
@@ -319,8 +314,7 @@ arcmsr_attr_host_fw_version(struct device *dev,
 	struct AdapterControlBlock *acb =
 			(struct AdapterControlBlock *) host->hostdata;
 
-	return snprintf(buf, PAGE_SIZE,
-			"%s\n",
+	return sysfs_emit(buf, "%s\n",
 			acb->firm_version);
 }
 
@@ -332,8 +326,7 @@ arcmsr_attr_host_fw_request_len(struct device *dev,
 	struct AdapterControlBlock *acb =
 		(struct AdapterControlBlock *) host->hostdata;
 
-	return snprintf(buf, PAGE_SIZE,
-			"%4d\n",
+	return sysfs_emit(buf, "%4d\n",
 			acb->firm_request_len);
 }
 
@@ -345,8 +338,7 @@ arcmsr_attr_host_fw_numbers_queue(struct device *dev,
 	struct AdapterControlBlock *acb =
 		(struct AdapterControlBlock *) host->hostdata;
 
-	return snprintf(buf, PAGE_SIZE,
-			"%4d\n",
+	return sysfs_emit(buf, "%4d\n",
 			acb->firm_numbers_queue);
 }
 
@@ -358,8 +350,7 @@ arcmsr_attr_host_fw_sdram_size(struct device *dev,
 	struct AdapterControlBlock *acb =
 		(struct AdapterControlBlock *) host->hostdata;
 
-	return snprintf(buf, PAGE_SIZE,
-			"%4d\n",
+	return sysfs_emit(buf, "%4d\n",
 			acb->firm_sdram_size);
 }
 
@@ -371,8 +362,7 @@ arcmsr_attr_host_fw_hd_channels(struct device *dev,
 	struct AdapterControlBlock *acb =
 		(struct AdapterControlBlock *) host->hostdata;
 
-	return snprintf(buf, PAGE_SIZE,
-			"%4d\n",
+	return sysfs_emit(buf, "%4d\n",
 			acb->firm_hd_channels);
 }
 
-- 
2.30.2

