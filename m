Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21A7D4628DD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 01:06:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232274AbhK3AKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 19:10:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232165AbhK3AKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 19:10:08 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DEC2C061574;
        Mon, 29 Nov 2021 16:06:49 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id 8so18667514pfo.4;
        Mon, 29 Nov 2021 16:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EzaxcIY5royQHN5xoXfZ35t2h3OBMnvlOC7rpJ9geNk=;
        b=dbimWW9gB8wJlLfjWTb78/MzsnhGlNhemdzZFVzUkIlvmNlTFT5fPJXcPj51zxfoyV
         VSb6Ztdx09Cm7QOCeZQ6zKY1YHfXoJW9i5OvPW8tgv4QNV6L05rMI4f8777qKuLwV2ss
         UQ4P8DjB4WfuAq6/zi5ZdS4an2o/4W9cmkVkJC7EDLG2d5RETz8s0drfBcJYpagfyQJy
         6BpUWV/A5uMgfFXouyrVnWu2wbdAlH/hK8h88tZdWDmjji2pmy6hu9nbdh5JfLULa5qN
         WvbRjlgy2elDKFIa0Ycovy5dY5r+L1xeRra6jAMD1KgkUQx4Ux9LhBXnASdRmUjg3leq
         uDNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EzaxcIY5royQHN5xoXfZ35t2h3OBMnvlOC7rpJ9geNk=;
        b=FWgpEiGx77y3Sr0RcNJ/WnnMnThet1vcLSTD29duEqWp17nj7r7IyRDxGIGEMCWi4Q
         hjE6u8J5QATUhQ4xsGJoeUj9vasgZ+CiTYDwhRuuWkhTXKTAP0qEu+TXMt8kezb6rcsa
         vNYXBMSn+cW8ZOExRZRiOJ1llQAfSbOfJGJ1ZOgJs8qdozfewBtm3+9VtE9LouvsmIyv
         sDNFlEYJrlLIVKhmCUbaRpbry/tcCHb37pOtQAqxfQY5Ox3wZPysmzn3P+kMPjfe8vPU
         p/mmKydgj/8PeL4Dob5xAHJWEsxs0O5BIcrZ0IwbvEUNoH38CG3dzmA3kgL9KsOB89MU
         q2GA==
X-Gm-Message-State: AOAM533imIrbTCo5w4neNPeEt+tuLuoOsSLSjNdJ3Rip4pi3VrV8K+hJ
        MoKncFstFM1dvJjyiMt9604=
X-Google-Smtp-Source: ABdhPJypnMItEAw3uRBbEUbGdiIRonmaVfX9GMtHOHZavbW1dFGiq/gM25pzztQR7UT7Wq2c5PywWQ==
X-Received: by 2002:a63:4244:: with SMTP id p65mr37945736pga.440.1638230809236;
        Mon, 29 Nov 2021 16:06:49 -0800 (PST)
Received: from debian11-dev-61.localdomain (192.243.120.180.16clouds.com. [192.243.120.180])
        by smtp.gmail.com with ESMTPSA id lx15sm415227pjb.44.2021.11.29.16.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 16:06:49 -0800 (PST)
From:   davidcomponentone@gmail.com
X-Google-Original-From: yang.guang5@zte.com.cn
To:     tyreld@linux.ibm.com
Cc:     davidcomponentone@gmail.com, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Yang Guang <yang.guang5@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] scsi: ibmvfc: replace snprintf with sysfs_emit
Date:   Tue, 30 Nov 2021 08:06:37 +0800
Message-Id: <eb06c0df4ef4b4786cbafbbe4d74c890dc50fa7b.1638185169.git.yang.guang5@zte.com.cn>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
---
 drivers/scsi/ibmvscsi/ibmvfc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc.c b/drivers/scsi/ibmvscsi/ibmvfc.c
index d0eab5700dc5..69bf55c037a5 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc.c
@@ -3403,7 +3403,7 @@ static ssize_t ibmvfc_show_host_partition_name(struct device *dev,
 	struct Scsi_Host *shost = class_to_shost(dev);
 	struct ibmvfc_host *vhost = shost_priv(shost);
 
-	return snprintf(buf, PAGE_SIZE, "%s\n",
+	return sysfs_emit(buf, "%s\n",
 			vhost->login_buf->resp.partition_name);
 }
 
@@ -3413,7 +3413,7 @@ static ssize_t ibmvfc_show_host_device_name(struct device *dev,
 	struct Scsi_Host *shost = class_to_shost(dev);
 	struct ibmvfc_host *vhost = shost_priv(shost);
 
-	return snprintf(buf, PAGE_SIZE, "%s\n",
+	return sysfs_emit(buf, "%s\n",
 			vhost->login_buf->resp.device_name);
 }
 
@@ -3423,7 +3423,7 @@ static ssize_t ibmvfc_show_host_loc_code(struct device *dev,
 	struct Scsi_Host *shost = class_to_shost(dev);
 	struct ibmvfc_host *vhost = shost_priv(shost);
 
-	return snprintf(buf, PAGE_SIZE, "%s\n",
+	return sysfs_emit(buf, "%s\n",
 			vhost->login_buf->resp.port_loc_code);
 }
 
@@ -3433,7 +3433,7 @@ static ssize_t ibmvfc_show_host_drc_name(struct device *dev,
 	struct Scsi_Host *shost = class_to_shost(dev);
 	struct ibmvfc_host *vhost = shost_priv(shost);
 
-	return snprintf(buf, PAGE_SIZE, "%s\n",
+	return sysfs_emit(buf, "%s\n",
 			vhost->login_buf->resp.drc_name);
 }
 
@@ -3442,7 +3442,7 @@ static ssize_t ibmvfc_show_host_npiv_version(struct device *dev,
 {
 	struct Scsi_Host *shost = class_to_shost(dev);
 	struct ibmvfc_host *vhost = shost_priv(shost);
-	return snprintf(buf, PAGE_SIZE, "%d\n", be32_to_cpu(vhost->login_buf->resp.version));
+	return sysfs_emit(buf, "%d\n", be32_to_cpu(vhost->login_buf->resp.version));
 }
 
 static ssize_t ibmvfc_show_host_capabilities(struct device *dev,
@@ -3450,7 +3450,7 @@ static ssize_t ibmvfc_show_host_capabilities(struct device *dev,
 {
 	struct Scsi_Host *shost = class_to_shost(dev);
 	struct ibmvfc_host *vhost = shost_priv(shost);
-	return snprintf(buf, PAGE_SIZE, "%llx\n", be64_to_cpu(vhost->login_buf->resp.capabilities));
+	return sysfs_emit(buf, "%llx\n", be64_to_cpu(vhost->login_buf->resp.capabilities));
 }
 
 /**
-- 
2.30.2

