Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D44F4B0AAC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 11:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239701AbiBJKeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 05:34:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236014AbiBJKeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 05:34:09 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F780B9B;
        Thu, 10 Feb 2022 02:34:07 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id 9so6561029pfx.12;
        Thu, 10 Feb 2022 02:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yZrnHVGdRb2E3LKqHBhEp3nq9Ei2BPCgAdM7PxxwMUI=;
        b=PXSYfz1zlVDEi9sS6GcnqRPXe6uYTBJ9eWKA+Lz9jSghUhglwdFclzfXxQyE3j/5yJ
         825mmWLFHknGcmPg8a471WS8c+Rr1LFzJiJ12GpN8vwGUTfx0mEzrhYJCwrNCA3PJ1I7
         /k8med1t4oqKWNDv0et45hVWUgsLCFIxG3SRD7nurNmnIvgdi8L9SLL+OlIixTgMscd2
         h+CtSTrwCrToMb1Jk4YWSPRjxuqkGaSRLUs+wRmKXxbmPa1KaTRR0OjIqkozDvTht89m
         ZsMMZYvdQSzX2V7X5miQUOtXopp+4Z6W0tsz6yKvygUnTeOES3VhwXXLGAPLE5uKtaFb
         DHIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yZrnHVGdRb2E3LKqHBhEp3nq9Ei2BPCgAdM7PxxwMUI=;
        b=EWHyhusB8XXil6AuoqHnH/Py/royZ2hfUZ8z30lxjPxae5OfiLh6t2/wzCxSk8myyb
         y5N4BBoc7cwoDQJdiUGmoKTf/Rv3hqpgVrWcMh576KYdlAkg/KiIXFHR9qihhN54NINc
         JG9yQl7h31Q62eYqTyqdUFF4WUiaJTJ+RBg4Z2OcfbWYzRON6vvfZE7l/51fc08JuHhy
         rjelW4LTu8/2IIJEawBQ3f8j2gb/cUBfBBw0zGLmG0ZzcfrhFZhkCLCnE1alKPXyKHu+
         5ZyLObH1W2cWK+Q5OohBSi+bNSMaYDQcSLPU3HoJikHms7iqCDPCf1fYcXHhPVE/iZLl
         /Prg==
X-Gm-Message-State: AOAM533QOEDh66J+gDsVWxy/Jpj+2OJCgFiEkLchSsCT+wz4VaC0xYoU
        FuCdsgJxRRUBjwmiAfN6Yr4=
X-Google-Smtp-Source: ABdhPJz+7MqFtDttNvkV2X42b/qYinotvqOCw91RqjewAExO8EGpTeo1aV5tFMRxmG3VHYU0H1nRfQ==
X-Received: by 2002:a63:358c:: with SMTP id c134mr5647595pga.116.1644489247124;
        Thu, 10 Feb 2022 02:34:07 -0800 (PST)
Received: from localhost.localdomain (192.243.120.166.16clouds.com. [192.243.120.166])
        by smtp.gmail.com with ESMTPSA id p21sm10044134pfo.97.2022.02.10.02.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 02:34:06 -0800 (PST)
From:   davidcomponentone@gmail.com
To:     tyreld@linux.ibm.com
Cc:     davidcomponentone@gmail.com, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Yang Guang <yang.guang5@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH v2] scsi: ibmvfc: replace snprintf with sysfs_emit
Date:   Thu, 10 Feb 2022 18:33:51 +0800
Message-Id: <6e673c1aeb3140ab7ac89a56e79be624e713f152.1644397683.git.yang.guang5@zte.com.cn>
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
./drivers/scsi/ibmvscsi/ibmvfc.c:3453:8-16:
WARNING: use scnprintf or sprintf
./drivers/scsi/ibmvscsi/ibmvfc.c:3416:8-16:
WARNING: use scnprintf or sprintf
./drivers/scsi/ibmvscsi/ibmvfc.c:3436:8-16:
WARNING: use scnprintf or sprintf
./drivers/scsi/ibmvscsi/ibmvfc.c:3426:8-16:
WARNING: use scnprintf or sprintf
./drivers/scsi/ibmvscsi/ibmvfc.c:3445:8-16:
WARNING: use scnprintf or sprintf
./drivers/scsi/ibmvscsi/ibmvfc.c:3406:8-16:
WARNING: use scnprintf or sprintf

Use sysfs_emit instead of scnprintf or sprintf makes more sense.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Yang Guang <yang.guang5@zte.com.cn>
Signed-off-by: David Yang <davidcomponentone@gmail.com>

---
Change from v1-v2:
- Adjust some format

---
 drivers/scsi/ibmvscsi/ibmvfc.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc.c b/drivers/scsi/ibmvscsi/ibmvfc.c
index d0eab5700dc5..ec63c45bf66b 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc.c
@@ -3403,8 +3403,7 @@ static ssize_t ibmvfc_show_host_partition_name(struct device *dev,
 	struct Scsi_Host *shost = class_to_shost(dev);
 	struct ibmvfc_host *vhost = shost_priv(shost);
 
-	return snprintf(buf, PAGE_SIZE, "%s\n",
-			vhost->login_buf->resp.partition_name);
+	return sysfs_emit(buf, "%s\n", vhost->login_buf->resp.partition_name);
 }
 
 static ssize_t ibmvfc_show_host_device_name(struct device *dev,
@@ -3413,8 +3412,7 @@ static ssize_t ibmvfc_show_host_device_name(struct device *dev,
 	struct Scsi_Host *shost = class_to_shost(dev);
 	struct ibmvfc_host *vhost = shost_priv(shost);
 
-	return snprintf(buf, PAGE_SIZE, "%s\n",
-			vhost->login_buf->resp.device_name);
+	return sysfs_emit(buf, "%s\n", vhost->login_buf->resp.device_name);
 }
 
 static ssize_t ibmvfc_show_host_loc_code(struct device *dev,
@@ -3423,8 +3421,7 @@ static ssize_t ibmvfc_show_host_loc_code(struct device *dev,
 	struct Scsi_Host *shost = class_to_shost(dev);
 	struct ibmvfc_host *vhost = shost_priv(shost);
 
-	return snprintf(buf, PAGE_SIZE, "%s\n",
-			vhost->login_buf->resp.port_loc_code);
+	return sysfs_emit(buf, "%s\n", vhost->login_buf->resp.port_loc_code);
 }
 
 static ssize_t ibmvfc_show_host_drc_name(struct device *dev,
@@ -3433,8 +3430,7 @@ static ssize_t ibmvfc_show_host_drc_name(struct device *dev,
 	struct Scsi_Host *shost = class_to_shost(dev);
 	struct ibmvfc_host *vhost = shost_priv(shost);
 
-	return snprintf(buf, PAGE_SIZE, "%s\n",
-			vhost->login_buf->resp.drc_name);
+	return sysfs_emit(buf, "%s\n", vhost->login_buf->resp.drc_name);
 }
 
 static ssize_t ibmvfc_show_host_npiv_version(struct device *dev,
@@ -3442,7 +3438,8 @@ static ssize_t ibmvfc_show_host_npiv_version(struct device *dev,
 {
 	struct Scsi_Host *shost = class_to_shost(dev);
 	struct ibmvfc_host *vhost = shost_priv(shost);
-	return snprintf(buf, PAGE_SIZE, "%d\n", be32_to_cpu(vhost->login_buf->resp.version));
+
+	return sysfs_emit(buf, "%u\n", be32_to_cpu(vhost->login_buf->resp.version));
 }
 
 static ssize_t ibmvfc_show_host_capabilities(struct device *dev,
@@ -3450,7 +3447,8 @@ static ssize_t ibmvfc_show_host_capabilities(struct device *dev,
 {
 	struct Scsi_Host *shost = class_to_shost(dev);
 	struct ibmvfc_host *vhost = shost_priv(shost);
-	return snprintf(buf, PAGE_SIZE, "%llx\n", be64_to_cpu(vhost->login_buf->resp.capabilities));
+
+	return sysfs_emit(buf, "%llx\n", be64_to_cpu(vhost->login_buf->resp.capabilities));
 }
 
 /**
@@ -3471,7 +3469,7 @@ static ssize_t ibmvfc_show_log_level(struct device *dev,
 	int len;
 
 	spin_lock_irqsave(shost->host_lock, flags);
-	len = snprintf(buf, PAGE_SIZE, "%d\n", vhost->log_level);
+	len = sysfs_emit(buf, "%d\n", vhost->log_level);
 	spin_unlock_irqrestore(shost->host_lock, flags);
 	return len;
 }
@@ -3509,7 +3507,7 @@ static ssize_t ibmvfc_show_scsi_channels(struct device *dev,
 	int len;
 
 	spin_lock_irqsave(shost->host_lock, flags);
-	len = snprintf(buf, PAGE_SIZE, "%d\n", vhost->client_scsi_channels);
+	len = sysfs_emit(buf, "%d\n", vhost->client_scsi_channels);
 	spin_unlock_irqrestore(shost->host_lock, flags);
 	return len;
 }
-- 
2.30.2

