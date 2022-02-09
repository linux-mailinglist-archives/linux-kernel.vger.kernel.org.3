Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D85DF4AE62E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 01:43:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240429AbiBIAnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 19:43:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235164AbiBIAn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 19:43:29 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E661C061576;
        Tue,  8 Feb 2022 16:43:29 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id i186so1492955pfe.0;
        Tue, 08 Feb 2022 16:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fMOnOpTGKn9/jVrcDzClYggaX4u+eL9NpYQ7bzh9GdY=;
        b=VhrPBaW9Pd7tSs4NlnRE27lUVYOlLlE6vXz5Tgjv+0TtyrRrh8+9fB/ddGQblRsR3X
         Pyuovi/mmJE0lZxnk/y4Qdp+sMcVsfqpkbJ2dlLOiWIkRrXVeePBfglBxOEeM0mC7MCH
         ZQhuKSysbxnPNF7Jdnt5x9cZijs/gw9FqPXWy/uyFzw22fOx73dCciWdd9NT1hhWA6xY
         aaHh0shXwOHETOlYJSXDqsw0jEpyxNmoKYyAWmsqcz0QhbpUDpWc24kxkNpksKamO13V
         0bI9S3GcfULUayOPY2ARCDwyaHYqyHzAno9GPxpBdTTSKrx7n019ZSWC7Ok4KJ/p+mIi
         lPyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fMOnOpTGKn9/jVrcDzClYggaX4u+eL9NpYQ7bzh9GdY=;
        b=ZwCeAGyHwNdz0xgoYzN6OW1DNFl6GFAniBM1apOPXCag2b+mAQVpt4LexzBmTWmTSm
         guf9LAKnc0wJmDHNlS8J/C7TgbAEKFc/WDZuJ2PyXVzDy2HJU+0WrE9YucBRsUd5299H
         tWfwZUa2A4p5L9NsbP0pTjCYzxP7QKPVFQfhWdOAnEdeyH/hgRfmvtMrS73NBKdzmy8l
         /11EaVSdiyTtvy1DaZVKrQK8PU4cFCJw6yJPbcDFzFzoLiERBM5svlnXdvigROLCu7Eb
         9RyiEU94BdotJLwvYOL73m84O27SaH+bXw5lAr1ztv8+MGfepopjVyFKanIXMgpUHPPB
         GGZA==
X-Gm-Message-State: AOAM530TTchA6w5GybHKEa840QVeVjHiTTjUAYtFCcFN2E8Lf+IQfqyC
        xxmOsFHJAR0bDJJemKAIk7U=
X-Google-Smtp-Source: ABdhPJxztLUaN8ctWe7jK8i2Ne76K3cV0pjkNHm76KdEOQhk6tD3/DaipquI7XsjKgga/7Jp9/9BZA==
X-Received: by 2002:a65:4b8f:: with SMTP id t15mr5718920pgq.140.1644367408679;
        Tue, 08 Feb 2022 16:43:28 -0800 (PST)
Received: from localhost.localdomain (192.243.120.166.16clouds.com. [192.243.120.166])
        by smtp.gmail.com with ESMTPSA id f22sm17352169pfj.206.2022.02.08.16.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 16:43:28 -0800 (PST)
From:   davidcomponentone@gmail.com
To:     tyreld@linux.ibm.com
Cc:     davidcomponentone@gmail.com, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Yang Guang <yang.guang5@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] scsi: ibmvfc: replace snprintf with sysfs_emit
Date:   Wed,  9 Feb 2022 08:43:15 +0800
Message-Id: <b4c150c86f539d3bac3fc8885252adb9f24ee48f.1644286482.git.yang.guang5@zte.com.cn>
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
 drivers/scsi/ibmvscsi/ibmvfc.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc.c b/drivers/scsi/ibmvscsi/ibmvfc.c
index d0eab5700dc5..d5a197d17e0a 100644
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
@@ -3471,7 +3471,7 @@ static ssize_t ibmvfc_show_log_level(struct device *dev,
 	int len;
 
 	spin_lock_irqsave(shost->host_lock, flags);
-	len = snprintf(buf, PAGE_SIZE, "%d\n", vhost->log_level);
+	len = sysfs_emit(buf, "%d\n", vhost->log_level);
 	spin_unlock_irqrestore(shost->host_lock, flags);
 	return len;
 }
@@ -3509,7 +3509,7 @@ static ssize_t ibmvfc_show_scsi_channels(struct device *dev,
 	int len;
 
 	spin_lock_irqsave(shost->host_lock, flags);
-	len = snprintf(buf, PAGE_SIZE, "%d\n", vhost->client_scsi_channels);
+	len = sysfs_emit(buf, "%d\n", vhost->client_scsi_channels);
 	spin_unlock_irqrestore(shost->host_lock, flags);
 	return len;
 }
-- 
2.30.2

