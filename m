Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12E464B0A9F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 11:31:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239687AbiBJKbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 05:31:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239673AbiBJKbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 05:31:47 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F2CF314;
        Thu, 10 Feb 2022 02:31:48 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id c5-20020a17090a1d0500b001b904a7046dso6513387pjd.1;
        Thu, 10 Feb 2022 02:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mQwimnxQRXJMfPIyBGZ3iGi9RpcyB/DkeR7gKv6K3uo=;
        b=Q6BMv1JopFf3kqgLVrTX9V0erFFTtcWUxM/ibAfziAg7vXzKZ6yZZOLc3oaFhadInZ
         XH9MbZsUj1UjV56t62/YlvAKZZ9KKDehFR7zaIE5uwas0g3HRgKMlr/S4/aQFHrgu0zS
         +o982eOGsepOe+neBR8gYbMdIVqp5PCD+pLLfms5wKzSZGilvyzDLnM8diy/vglqkriQ
         aupxYbyDaVSB/WAgE/4t/IG+Zl/wwZaJjCWGgGFdbPrUUklY3euB/zwX0DWZsc6dMC98
         w77My1yv7T3r6/ZQgz0/BnxAfo2wgcyiD++S3Bsz7RBNyJxgutyYj1evnG6m3h7yOREQ
         Hj9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mQwimnxQRXJMfPIyBGZ3iGi9RpcyB/DkeR7gKv6K3uo=;
        b=5MDC1npiBV+2Cwf7+B2IUMM9v2jt5htVnsJsRx7qeVx73CoPH5CqpHNwWAaNWOAgIO
         mNEicEDEKffmFosk1tt9/n0s6PfgIShXMx1NwVag4gICQtvFxAFSyMReR+YOYMmEyWmx
         v1MuKz2HRQPiT3Ih0BTPq2gvPkFYYtF6Qi1gWSC4MC6Tkfa3WN7y4vtWX5up5ZPdon0+
         9VwTXd5JgE+17yj8I/1cyXi/r6T7AkmoF/HyCGdxD/ejg070mr5cpNuipMq56E367LNs
         SISEVQO6lp2In/W3kLl+ESILxe9t+tzS/0tntja7PKwQyhbfZCyY6JpoNcWQ/kGIiJYu
         xM9w==
X-Gm-Message-State: AOAM532IS6lMTxGwyFn6F246IiYBKzSQMZ/l22D6KvU/kQcE5OFeoTkc
        IR81L27RTDZyJM0lqfpy3ro=
X-Google-Smtp-Source: ABdhPJxKhOejSPNub8hfZey1y/CZEzIXktOQ9+yhyy3EwyiRqlCEk2d0oxCyRq9f+EB3SOn5HpUliA==
X-Received: by 2002:a17:903:1cf:: with SMTP id e15mr6853918plh.12.1644489107598;
        Thu, 10 Feb 2022 02:31:47 -0800 (PST)
Received: from localhost.localdomain (192.243.120.166.16clouds.com. [192.243.120.166])
        by smtp.gmail.com with ESMTPSA id g4sm22862530pfv.63.2022.02.10.02.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 02:31:46 -0800 (PST)
From:   davidcomponentone@gmail.com
To:     jejb@linux.ibm.com
Cc:     davidcomponentone@gmail.com, martin.petersen@oracle.com,
        yang.guang5@zte.com.cn, bvanassche@acm.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH v2] scsi: arcmsr: replace snprintf with sysfs_emit
Date:   Thu, 10 Feb 2022 18:31:25 +0800
Message-Id: <d52e540c63c88f31ffd7103dd0560fca915d07c8.1644399148.git.yang.guang5@zte.com.cn>
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
Change from v1-v2:
- Adjust some format

---
 drivers/scsi/arcmsr/arcmsr_attr.c | 43 ++++++++++---------------------
 1 file changed, 14 insertions(+), 29 deletions(-)

diff --git a/drivers/scsi/arcmsr/arcmsr_attr.c b/drivers/scsi/arcmsr/arcmsr_attr.c
index baeb5e795690..94ab25ef50dd 100644
--- a/drivers/scsi/arcmsr/arcmsr_attr.c
+++ b/drivers/scsi/arcmsr/arcmsr_attr.c
@@ -258,9 +258,7 @@ static ssize_t
 arcmsr_attr_host_driver_version(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE,
-			"%s\n",
-			ARCMSR_DRIVER_VERSION);
+	return sysfs_emit(buf, "%s\n", ARCMSR_DRIVER_VERSION);
 }
 
 static ssize_t
@@ -270,8 +268,8 @@ arcmsr_attr_host_driver_posted_cmd(struct device *dev,
 	struct Scsi_Host *host = class_to_shost(dev);
 	struct AdapterControlBlock *acb =
 		(struct AdapterControlBlock *) host->hostdata;
-	return snprintf(buf, PAGE_SIZE,
-			"%4d\n",
+
+	return sysfs_emit(buf, "%4u\n",
 			atomic_read(&acb->ccboutstandingcount));
 }
 
@@ -282,9 +280,8 @@ arcmsr_attr_host_driver_reset(struct device *dev,
 	struct Scsi_Host *host = class_to_shost(dev);
 	struct AdapterControlBlock *acb =
 		(struct AdapterControlBlock *) host->hostdata;
-	return snprintf(buf, PAGE_SIZE,
-			"%4d\n",
-			acb->num_resets);
+
+	return sysfs_emit(buf, "%4u\n", acb->num_resets);
 }
 
 static ssize_t
@@ -294,9 +291,8 @@ arcmsr_attr_host_driver_abort(struct device *dev,
 	struct Scsi_Host *host = class_to_shost(dev);
 	struct AdapterControlBlock *acb =
 		(struct AdapterControlBlock *) host->hostdata;
-	return snprintf(buf, PAGE_SIZE,
-			"%4d\n",
-			acb->num_aborts);
+
+	return sysfs_emit(buf, "%4u\n", acb->num_aborts);
 }
 
 static ssize_t
@@ -306,9 +302,8 @@ arcmsr_attr_host_fw_model(struct device *dev, struct device_attribute *attr,
 	struct Scsi_Host *host = class_to_shost(dev);
 	struct AdapterControlBlock *acb =
 		(struct AdapterControlBlock *) host->hostdata;
-	return snprintf(buf, PAGE_SIZE,
-			"%s\n",
-			acb->firm_model);
+
+	return sysfs_emit(buf, "%s\n", acb->firm_model);
 }
 
 static ssize_t
@@ -319,9 +314,7 @@ arcmsr_attr_host_fw_version(struct device *dev,
 	struct AdapterControlBlock *acb =
 			(struct AdapterControlBlock *) host->hostdata;
 
-	return snprintf(buf, PAGE_SIZE,
-			"%s\n",
-			acb->firm_version);
+	return sysfs_emit(buf, "%s\n", acb->firm_version);
 }
 
 static ssize_t
@@ -332,9 +325,7 @@ arcmsr_attr_host_fw_request_len(struct device *dev,
 	struct AdapterControlBlock *acb =
 		(struct AdapterControlBlock *) host->hostdata;
 
-	return snprintf(buf, PAGE_SIZE,
-			"%4d\n",
-			acb->firm_request_len);
+	return sysfs_emit(buf, "%4u\n", acb->firm_request_len);
 }
 
 static ssize_t
@@ -345,9 +336,7 @@ arcmsr_attr_host_fw_numbers_queue(struct device *dev,
 	struct AdapterControlBlock *acb =
 		(struct AdapterControlBlock *) host->hostdata;
 
-	return snprintf(buf, PAGE_SIZE,
-			"%4d\n",
-			acb->firm_numbers_queue);
+	return sysfs_emit(buf, "%4u\n", acb->firm_numbers_queue);
 }
 
 static ssize_t
@@ -358,9 +347,7 @@ arcmsr_attr_host_fw_sdram_size(struct device *dev,
 	struct AdapterControlBlock *acb =
 		(struct AdapterControlBlock *) host->hostdata;
 
-	return snprintf(buf, PAGE_SIZE,
-			"%4d\n",
-			acb->firm_sdram_size);
+	return sysfs_emit(buf, "%4u\n", acb->firm_sdram_size);
 }
 
 static ssize_t
@@ -371,9 +358,7 @@ arcmsr_attr_host_fw_hd_channels(struct device *dev,
 	struct AdapterControlBlock *acb =
 		(struct AdapterControlBlock *) host->hostdata;
 
-	return snprintf(buf, PAGE_SIZE,
-			"%4d\n",
-			acb->firm_hd_channels);
+	return sysfs_emit(buf, "%4u\n", acb->firm_hd_channels);
 }
 
 static DEVICE_ATTR(host_driver_version, S_IRUGO, arcmsr_attr_host_driver_version, NULL);
-- 
2.30.2

