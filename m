Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF5FF4D5672
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 01:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345017AbiCKAUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 19:20:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245492AbiCKAUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 19:20:13 -0500
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850D2199D5F;
        Thu, 10 Mar 2022 16:19:11 -0800 (PST)
Received: by mail-oo1-xc32.google.com with SMTP id j7-20020a4ad6c7000000b0031c690e4123so8759341oot.11;
        Thu, 10 Mar 2022 16:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U0AZdJmAf3KnMnmaCT6PVX8yffxCxk1VkTp4io1uedY=;
        b=T7XZ0yttiyIczz6uUfertqFXDorsdoEbYKOzkVYQ4f1F0sSgHVZNGmWLUQqMWopSCw
         wCpJDGiczXpAGxAsxY3eh0v/y887FlVKpRsp/JNqLeG2+Zmd5JxE911nGx+vfQEF5zM1
         +80MRU0TCJmvCYirCevEPleQn6VQTfqBeGCJ5dhEeoc1rtmnhNyGg4lyJTS0Vtk5vPO8
         8KRdPxSVo8vFGT069tWZdJOZnxS6uJ85vsdm6VJgXFM33/FzsOpM44QPc31dC4XjqRro
         UfeNcYV585i3AoBTSWSC4m1MXE/IkZ1GhXcrfc3RSUtkF1vJ839aBiR4+MZYKOwaG9dP
         jrrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U0AZdJmAf3KnMnmaCT6PVX8yffxCxk1VkTp4io1uedY=;
        b=dwNUH+nJ5iaqfvUvZa4RNPf0PdEa5yigK0q0U/2CpXSEOJkNCK5wRJVviAhRLqI+O2
         m98996fmAH0VJQRpoil9dzHr3qwFY5dJgXF9TsixELrc0nFRnzMW60oNEI8Y2yxCXSye
         M1zxeSUhRAiatP0UMqVMNr3LSMaVAyhejfmMe1GcHxFw0xO8E6+3B4fYs4Lqx8h5H6Xa
         uVzot2IG9YV143ZmWguggN08yR/BBoChyhPrlr8wNdnExWBVgGkwpXJoU3xn+ynWmKId
         sTk0G0QKBQXrTxKqi1cn1DdTC5P8GOj9MZ/mEbrIWXcxAKC4xP6KO48BACAfHR5L0yZV
         u5+w==
X-Gm-Message-State: AOAM531PN3OA5FSLAOk3J+VA/j+77ipkeZlYz2m9OvGtFDBENE/khMfm
        Zt1gRws0wSYq3/76AuSxP5c=
X-Google-Smtp-Source: ABdhPJyiVhuWhrH8JIV4+a4K60XF6nqM1KS+9cIGeBeVK6gpoCOYo1uIgDu+V3vdeOg8/+HhKcvR+A==
X-Received: by 2002:a05:6870:590:b0:d7:b0:7412 with SMTP id m16-20020a056870059000b000d700b07412mr9849300oap.115.1646957950797;
        Thu, 10 Mar 2022 16:19:10 -0800 (PST)
Received: from fstone04p1.aus.stglabs.ibm.com ([129.41.86.7])
        by smtp.gmail.com with ESMTPSA id m17-20020a0568080f1100b002d71e151e51sm3211000oiw.0.2022.03.10.16.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 16:19:10 -0800 (PST)
From:   Brandon Wyman <bjwyman@gmail.com>
To:     Joel Stanley <joel@jms.id.au>, openbmc@lists.ozlabs.org,
        Eddie James <eajames@linux.ibm.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Brandon Wyman <bjwyman@gmail.com>
Subject: [PATCH] hwmon: (pmbus/ibm-cffps) Add clear_faults debugfs entry
Date:   Fri, 11 Mar 2022 00:18:58 +0000
Message-Id: <20220311001858.4166205-1-bjwyman@gmail.com>
X-Mailer: git-send-email 2.25.1
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

Add a clear_faults write-only debugfs entry for the ibm-cffps device
driver.

Signed-off-by: Brandon Wyman <bjwyman@gmail.com>
---
 drivers/hwmon/pmbus/ibm-cffps.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/hwmon/pmbus/ibm-cffps.c b/drivers/hwmon/pmbus/ibm-cffps.c
index e3294a1a54bb..fca2642a8ed4 100644
--- a/drivers/hwmon/pmbus/ibm-cffps.c
+++ b/drivers/hwmon/pmbus/ibm-cffps.c
@@ -67,6 +67,7 @@ enum {
 	CFFPS_DEBUGFS_CCIN,
 	CFFPS_DEBUGFS_FW,
 	CFFPS_DEBUGFS_ON_OFF_CONFIG,
+	CFFPS_DEBUGFS_CLEAR_FAULTS,
 	CFFPS_DEBUGFS_NUM_ENTRIES
 };
 
@@ -274,6 +275,13 @@ static ssize_t ibm_cffps_debugfs_write(struct file *file,
 		if (rc)
 			return rc;
 
+		rc = 1;
+		break;
+	case CFFPS_DEBUGFS_CLEAR_FAULTS:
+		rc = i2c_smbus_write_byte(psu->client, PMBUS_CLEAR_FAULTS);
+		if (rc < 0)
+			return rc;
+
 		rc = 1;
 		break;
 	default:
@@ -607,6 +615,9 @@ static int ibm_cffps_probe(struct i2c_client *client)
 	debugfs_create_file("on_off_config", 0644, ibm_cffps_dir,
 			    &psu->debugfs_entries[CFFPS_DEBUGFS_ON_OFF_CONFIG],
 			    &ibm_cffps_fops);
+	debugfs_create_file("clear_faults", 0200, ibm_cffps_dir,
+			    &psu->debugfs_entries[CFFPS_DEBUGFS_CLEAR_FAULTS],
+			    &ibm_cffps_fops);
 
 	return 0;
 }
-- 
2.25.1

