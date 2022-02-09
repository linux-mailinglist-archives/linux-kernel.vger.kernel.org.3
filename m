Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17EEA4AE743
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 03:46:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242735AbiBICqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 21:46:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238304AbiBIArE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 19:47:04 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A1C0C061576;
        Tue,  8 Feb 2022 16:47:04 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id a11-20020a17090a740b00b001b8b506c42fso3640519pjg.0;
        Tue, 08 Feb 2022 16:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lQBeYPP3NnoU0nAcxubYc/fkF2bkRNl0GYFbA4mk8ZU=;
        b=OufpY1qBhQPYKc9mNTnWn90fki/xDDQ3xfTi7TPwURnoUuuoTGxiZ9aJIYK4EZcxjq
         Dt+qVDsIPeZQWPtUgc7sxRPoq+OrNoKZM8/V/KSBR8wHBWKU9rTArB7LSFD3C9pxt1G9
         mzghIJ/3sCXuCgtp6VQwq9bSrpJ+0Mo/ndSYdB3kR/bVeInr/FH2twCxPeAFeYcTotC4
         uIhDYsblK86LtMU8LXm+RPbLg5HAsIjQuM97uu4XTZtWY4v8pHqytH+YJrm+aGk/eeuz
         yfHytX8BIpriEDLMO2ots5x3HNgxvU/6rRYc9aYFzW6TAy9ZnbmUal/KO8ttkz5pBQKC
         3w5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lQBeYPP3NnoU0nAcxubYc/fkF2bkRNl0GYFbA4mk8ZU=;
        b=fw1+yHaF+ERoypJwTTCVmVE9u3vWi9agDvCB+iC1H7PpGht3ZGhn1BrR0BvfYdcl8w
         L4jDQy7qDae88rhnsqrNykt24MUNYi5HG6ZL/823w8vll45VjVl5MrTw6JMSOF6m19nF
         4cue5jqZLAv/JOer7yCQBu9LFdLuTNJ+ONSg5/AplstCzXQbrJoMDs83V333UEdr6BJ8
         x+LYwwRKaJQ9EUPktg0vUv2ajtbUppqThi/CHINfra5UYAkltL+sxpsrzKZQwKZWjdwU
         qf6wzGU/OeGqacRTS/+3vSBwtQv7/bmGdwM0O5T8pFF3m+CU+QhrIQuZFClqXHarQzmc
         5V1A==
X-Gm-Message-State: AOAM530ydzJKimwQVB8JFjZZSQDjy7fngalhMcIHJ8zIEYEIPQzyHi1b
        UxPXzyoQQMLIxMV00AJ7w8Nduc77nRM=
X-Google-Smtp-Source: ABdhPJx8Yk0nRxg3jcilweQYnJwaZcdG071f3ShvgtMH2GzIudEZAehF3vdI9wnlrXRRxLi1rxAliw==
X-Received: by 2002:a17:90a:ad81:: with SMTP id s1mr652078pjq.194.1644367623817;
        Tue, 08 Feb 2022 16:47:03 -0800 (PST)
Received: from localhost.localdomain (192.243.120.166.16clouds.com. [192.243.120.166])
        by smtp.gmail.com with ESMTPSA id s32sm10977754pfw.80.2022.02.08.16.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 16:47:03 -0800 (PST)
From:   davidcomponentone@gmail.com
To:     ketan.mukadam@broadcom.com
Cc:     davidcomponentone@gmail.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Guang <yang.guang5@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] scsi: be2iscsi: replace snprintf with sysfs_emit
Date:   Wed,  9 Feb 2022 08:46:51 +0800
Message-Id: <610469dfb2cc5a4569c6b3c5105ea204b1a540b0.1644284406.git.yang.guang5@zte.com.cn>
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
./drivers/scsi/be2iscsi/be_mgmt.c:1251:9-17:
WARNING: use scnprintf or sprintf
./drivers/scsi/be2iscsi/be_mgmt.c:1145:8-16:
WARNING: use scnprintf or sprintf
./drivers/scsi/be2iscsi/be_mgmt.c:1164:8-16:
WARNING: use scnprintf or sprintf
./drivers/scsi/be2iscsi/be_mgmt.c:1280:8-16:
WARNING: use scnprintf or sprintf

Use sysfs_emit instead of scnprintf or sprintf makes more sense.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Yang Guang <yang.guang5@zte.com.cn>
Signed-off-by: David Yang <davidcomponentone@gmail.com>
---
 drivers/scsi/be2iscsi/be_mgmt.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/scsi/be2iscsi/be_mgmt.c b/drivers/scsi/be2iscsi/be_mgmt.c
index 4e899ec1477d..8b9ace2b3fd3 100644
--- a/drivers/scsi/be2iscsi/be_mgmt.c
+++ b/drivers/scsi/be2iscsi/be_mgmt.c
@@ -1142,7 +1142,7 @@ ssize_t
 beiscsi_drvr_ver_disp(struct device *dev, struct device_attribute *attr,
 		       char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, BE_NAME "\n");
+	return sysfs_emit(buf, BE_NAME "\n");
 }
 
 /**
@@ -1161,7 +1161,7 @@ beiscsi_fw_ver_disp(struct device *dev, struct device_attribute *attr,
 	struct Scsi_Host *shost = class_to_shost(dev);
 	struct beiscsi_hba *phba = iscsi_host_priv(shost);
 
-	return snprintf(buf, PAGE_SIZE, "%s\n", phba->fw_ver_str);
+	return sysfs_emit(buf, "%s\n", phba->fw_ver_str);
 }
 
 /**
@@ -1248,16 +1248,14 @@ beiscsi_adap_family_disp(struct device *dev, struct device_attribute *attr,
 	case BE_DEVICE_ID1:
 	case OC_DEVICE_ID1:
 	case OC_DEVICE_ID2:
-		return snprintf(buf, PAGE_SIZE,
-				"Obsolete/Unsupported BE2 Adapter Family\n");
+		return sysfs_emit(buf, "Obsolete/Unsupported BE2 Adapter Family\n");
 	case BE_DEVICE_ID2:
 	case OC_DEVICE_ID3:
-		return snprintf(buf, PAGE_SIZE, "BE3-R Adapter Family\n");
+		return sysfs_emit(buf, "BE3-R Adapter Family\n");
 	case OC_SKH_ID1:
-		return snprintf(buf, PAGE_SIZE, "Skyhawk-R Adapter Family\n");
+		return sysfs_emit(buf, "Skyhawk-R Adapter Family\n");
 	default:
-		return snprintf(buf, PAGE_SIZE,
-				"Unknown Adapter Family: 0x%x\n", dev_id);
+		return sysfs_emit(buf, "Unknown Adapter Family: 0x%x\n", dev_id);
 	}
 }
 
@@ -1277,7 +1275,7 @@ beiscsi_phys_port_disp(struct device *dev, struct device_attribute *attr,
 	struct Scsi_Host *shost = class_to_shost(dev);
 	struct beiscsi_hba *phba = iscsi_host_priv(shost);
 
-	return snprintf(buf, PAGE_SIZE, "Port Identifier : %u\n",
+	return sysfs_emit(buf, "Port Identifier : %u\n",
 			phba->fw_config.phys_port);
 }
 
-- 
2.30.2

