Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 277FE49D687
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 01:04:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233728AbiA0AEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 19:04:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbiA0AEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 19:04:01 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C97C06161C;
        Wed, 26 Jan 2022 16:04:01 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id r59so1134059pjg.4;
        Wed, 26 Jan 2022 16:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OuIniMVIxxilYOA1dxjmUwo8IvZPISl5pXlBuNuLVGc=;
        b=j3YxHjYez8flBa7zFpCry1yfDvWQpY6Nvvn+oHnQOoK3DlF2FJx+8jDLIPgI3oa8wh
         GINxp/XeSstTkGas4VFObFwMjC/BA1v8Vo5OVtbAodJSuvOJuZuftTglp1Z9Mox1rbiR
         26bEUtL9zXATb9uKJfYjTfLYYA9wmb0XGMYcLGGzlXfebzO6BVjL27ivK7fycktakZEM
         FKkevyQGy/DbayKDXb8m8VSKU73uUZX9WQLL57/Xmrio81DvzxM+ZdFgCPmexhDPOFaG
         YwU+dh3l21Lyyx1XnMp+/cpmQKBFqbo0Ji7dRLA++L4ce/MZiY+uuJNFXFoba+EvoK4U
         +45Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OuIniMVIxxilYOA1dxjmUwo8IvZPISl5pXlBuNuLVGc=;
        b=H7VB2HV/70mSBPLQg5+V8oe25p/TTDd4v90rl6DtB3Qb/vJbFZTOpmw5L2rOf9z9/H
         K9dcZyA+AO8rsQH0yXNAK0jHiN2j5MtEvbf8HmIIwJA+ag2itG+Y9TKzFdMZlwEMnTEU
         ZxZOnrOZ9TtbpSRhPQNlxOApaQLyQ/j+oMDG3iDceHlOM4eu1i7ugeC4t0Rsyn6nyXUD
         kIUU8DXZ+w73UfGE4gBZMwapHpja3MBlKP/QyaApnWQjAGrfDHKQ04w06a0jtBBm4FWF
         lF6x99cM8bqGMABTTDzBNFbj3RM3fzu24UjhAHuoWZ+oOX+RCd06NlclM5hU2omiyWb0
         RCFw==
X-Gm-Message-State: AOAM533AEJpJBTEahv3OkkV9MPcOsg6ISc9dW/e2YBRALSClA6FNNvOo
        RPes5QTfcCi++73AN1toInc=
X-Google-Smtp-Source: ABdhPJzU1PUrR3Ra11EPkRBHZmULKaRoo8rtOxWrNTjBEUpTUHfu7DEpoUefmtcjGXv25Elm2mnLOg==
X-Received: by 2002:a17:902:9689:: with SMTP id n9mr1076339plp.33.1643241840933;
        Wed, 26 Jan 2022 16:04:00 -0800 (PST)
Received: from localhost.localdomain (192.243.120.23.16clouds.com. [192.243.120.23])
        by smtp.gmail.com with ESMTPSA id f9sm17408932pgf.94.2022.01.26.16.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 16:04:00 -0800 (PST)
From:   davidcomponentone@gmail.com
To:     anil.gurumurthy@qlogic.com
Cc:     davidcomponentone@gmail.com, sudarsana.kalluru@qlogic.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Guang <yang.guang5@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] scsi: bfa: replace snprintf with sysfs_emit
Date:   Thu, 27 Jan 2022 08:03:46 +0800
Message-Id: <def83ff75faec64ba592b867a8499b1367bae303.1643181468.git.yang.guang5@zte.com.cn>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Guang <yang.guang5@zte.com.cn>

coccinelle report:
./drivers/scsi/bfa/bfad_attr.c:908:8-16:
WARNING: use scnprintf or sprintf
./drivers/scsi/bfa/bfad_attr.c:860:8-16:
WARNING: use scnprintf or sprintf
./drivers/scsi/bfa/bfad_attr.c:888:8-16:
WARNING: use scnprintf or sprintf
./drivers/scsi/bfa/bfad_attr.c:853:8-16:
WARNING: use scnprintf or sprintf
./drivers/scsi/bfa/bfad_attr.c:808:8-16:
WARNING: use scnprintf or sprintf
./drivers/scsi/bfa/bfad_attr.c:728:8-16:
WARNING: use scnprintf or sprintf
./drivers/scsi/bfa/bfad_attr.c:822:8-16:
WARNING: use scnprintf or sprintf
./drivers/scsi/bfa/bfad_attr.c:927:9-17:
WARNING: use scnprintf or sprintf
./drivers/scsi/bfa/bfad_attr.c:900:8-16:
WARNING: use scnprintf or sprintf
./drivers/scsi/bfa/bfad_attr.c:874:8-16:
WARNING: use scnprintf or sprintf
./drivers/scsi/bfa/bfad_attr.c:714:8-16:
WARNING: use scnprintf or sprintf
./drivers/scsi/bfa/bfad_attr.c:839:8-16:
WARNING: use scnprintf or sprintf

Use sysfs_emit instead of scnprintf or sprintf makes more sense.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Yang Guang <yang.guang5@zte.com.cn>
Signed-off-by: David Yang <davidcomponentone@gmail.com>
---
 drivers/scsi/bfa/bfad_attr.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/scsi/bfa/bfad_attr.c b/drivers/scsi/bfa/bfad_attr.c
index f46989bd083c..5a85401e9e2d 100644
--- a/drivers/scsi/bfa/bfad_attr.c
+++ b/drivers/scsi/bfa/bfad_attr.c
@@ -711,7 +711,7 @@ bfad_im_serial_num_show(struct device *dev, struct device_attribute *attr,
 	char serial_num[BFA_ADAPTER_SERIAL_NUM_LEN];
 
 	bfa_get_adapter_serial_num(&bfad->bfa, serial_num);
-	return snprintf(buf, PAGE_SIZE, "%s\n", serial_num);
+	return sysfs_emit(buf, "%s\n", serial_num);
 }
 
 static ssize_t
@@ -725,7 +725,7 @@ bfad_im_model_show(struct device *dev, struct device_attribute *attr,
 	char model[BFA_ADAPTER_MODEL_NAME_LEN];
 
 	bfa_get_adapter_model(&bfad->bfa, model);
-	return snprintf(buf, PAGE_SIZE, "%s\n", model);
+	return sysfs_emit(buf, "%s\n", model);
 }
 
 static ssize_t
@@ -805,7 +805,7 @@ bfad_im_model_desc_show(struct device *dev, struct device_attribute *attr,
 		snprintf(model_descr, BFA_ADAPTER_MODEL_DESCR_LEN,
 			"Invalid Model");
 
-	return snprintf(buf, PAGE_SIZE, "%s\n", model_descr);
+	return sysfs_emit(buf, "%s\n", model_descr);
 }
 
 static ssize_t
@@ -819,7 +819,7 @@ bfad_im_node_name_show(struct device *dev, struct device_attribute *attr,
 	u64        nwwn;
 
 	nwwn = bfa_fcs_lport_get_nwwn(port->fcs_port);
-	return snprintf(buf, PAGE_SIZE, "0x%llx\n", cpu_to_be64(nwwn));
+	return sysfs_emit(buf, "0x%llx\n", cpu_to_be64(nwwn));
 }
 
 static ssize_t
@@ -836,7 +836,7 @@ bfad_im_symbolic_name_show(struct device *dev, struct device_attribute *attr,
 	bfa_fcs_lport_get_attr(&bfad->bfa_fcs.fabric.bport, &port_attr);
 	strlcpy(symname, port_attr.port_cfg.sym_name.symname,
 			BFA_SYMNAME_MAXLEN);
-	return snprintf(buf, PAGE_SIZE, "%s\n", symname);
+	return sysfs_emit(buf, "%s\n", symname);
 }
 
 static ssize_t
@@ -850,14 +850,14 @@ bfad_im_hw_version_show(struct device *dev, struct device_attribute *attr,
 	char hw_ver[BFA_VERSION_LEN];
 
 	bfa_get_pci_chip_rev(&bfad->bfa, hw_ver);
-	return snprintf(buf, PAGE_SIZE, "%s\n", hw_ver);
+	return sysfs_emit(buf, "%s\n", hw_ver);
 }
 
 static ssize_t
 bfad_im_drv_version_show(struct device *dev, struct device_attribute *attr,
 				char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%s\n", BFAD_DRIVER_VERSION);
+	return sysfs_emit(buf, "%s\n", BFAD_DRIVER_VERSION);
 }
 
 static ssize_t
@@ -871,7 +871,7 @@ bfad_im_optionrom_version_show(struct device *dev,
 	char optrom_ver[BFA_VERSION_LEN];
 
 	bfa_get_adapter_optrom_ver(&bfad->bfa, optrom_ver);
-	return snprintf(buf, PAGE_SIZE, "%s\n", optrom_ver);
+	return sysfs_emit(buf, "%s\n", optrom_ver);
 }
 
 static ssize_t
@@ -885,7 +885,7 @@ bfad_im_fw_version_show(struct device *dev, struct device_attribute *attr,
 	char fw_ver[BFA_VERSION_LEN];
 
 	bfa_get_adapter_fw_ver(&bfad->bfa, fw_ver);
-	return snprintf(buf, PAGE_SIZE, "%s\n", fw_ver);
+	return sysfs_emit(buf, "%s\n", fw_ver);
 }
 
 static ssize_t
@@ -897,7 +897,7 @@ bfad_im_num_of_ports_show(struct device *dev, struct device_attribute *attr,
 			(struct bfad_im_port_s *) shost->hostdata[0];
 	struct bfad_s *bfad = im_port->bfad;
 
-	return snprintf(buf, PAGE_SIZE, "%d\n",
+	return sysfs_emit(buf, "%d\n",
 			bfa_get_nports(&bfad->bfa));
 }
 
@@ -905,7 +905,7 @@ static ssize_t
 bfad_im_drv_name_show(struct device *dev, struct device_attribute *attr,
 				char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%s\n", BFAD_DRIVER_NAME);
+	return sysfs_emit(buf, "%s\n", BFAD_DRIVER_NAME);
 }
 
 static ssize_t
@@ -924,14 +924,14 @@ bfad_im_num_of_discovered_ports_show(struct device *dev,
 	rports = kcalloc(nrports, sizeof(struct bfa_rport_qualifier_s),
 			 GFP_ATOMIC);
 	if (rports == NULL)
-		return snprintf(buf, PAGE_SIZE, "Failed\n");
+		return sysfs_emit(buf, "Failed\n");
 
 	spin_lock_irqsave(&bfad->bfad_lock, flags);
 	bfa_fcs_lport_get_rport_quals(port->fcs_port, rports, &nrports);
 	spin_unlock_irqrestore(&bfad->bfad_lock, flags);
 	kfree(rports);
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", nrports);
+	return sysfs_emit(buf, "%d\n", nrports);
 }
 
 static          DEVICE_ATTR(serial_number, S_IRUGO,
-- 
2.30.2

