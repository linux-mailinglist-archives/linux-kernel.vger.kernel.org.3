Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 606DC5212DC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 12:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240543AbiEJK6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 06:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240918AbiEJK4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 06:56:44 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2409B49CB6;
        Tue, 10 May 2022 03:51:18 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id j6so14603756pfe.13;
        Tue, 10 May 2022 03:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hAHq/Z/cN7zV+XdkiKU02nzI59eCs7rRP6xEiwk+ttM=;
        b=omAx8HgDVZ/N16gcZs7NwcDCejSq3mv/wK0bmHiwGOCdpzpFBaEL9oJp59J3TefASW
         VWqJ5eXPMLZnfGvy0rwgMy4XQE9RfeaNHByd00RzEW2DkNQpAaR3GjcNk0tGp1a3/Ouk
         1X/mczkeIzuYf6tOdlntClgX3cBujoyE7N7zUJ51QQ19aneUoH/m5gkR3Na4QHyhaJud
         1olm5tqo7xBbVvuFZtgJGn7jjstObBrJ+7bWaPFYOXiFj7DSs8fMCTHu6peNEuGhx7z9
         22a+0pheq7GEFUAgaXhizFz6bMHBHIuwhCHgrhINnuCMAGLn1UHz6vJ33DIUopRD/5g8
         gCmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hAHq/Z/cN7zV+XdkiKU02nzI59eCs7rRP6xEiwk+ttM=;
        b=uqDOQ1D+20DLacIvGOOyQwgcrRFfTdsP8vItO8XfUbxNBY0BB+e8Xr3nbJt92Wr1q6
         ejrpJ2C90i2QJOb3YhPjcLo0Nii1vJeBRdWBfJpPiVqq69B+uvVvvVRaLtSBUXU7QPqT
         JkKsQohNXfAr3iHNwM/0qeYRhKmvokiS5oK0d+N9kQgQ9QeVrOtwCm/F8dk2bthXnkJ5
         kcik1miDrj+GNsMHOpk8rpaUx7PtyxVT+GTbdoZb0KSlguULBtz3M+56at7LyVyQkvZY
         N96qmXkDPF6cRVt4kZZKfnDdEsWLTNJlgy5EW7uhDDF1jqJdlzVQlQgWLZIoMXKemTwQ
         s4Zw==
X-Gm-Message-State: AOAM530mPWb+w4bf4T8ugpSW8jhXB8FbTJCf7BNDzT4dnlnHbGXDRv/W
        Hvh6veAk/0FyTOVNzNulUDE=
X-Google-Smtp-Source: ABdhPJy+fryPMGgXljHO9c+vcQpQNMh6ymww+rTFw9yfICLO78dc6yMkKnygW8lA+g2+4HS1DnAojw==
X-Received: by 2002:a62:4e90:0:b0:505:fa47:b611 with SMTP id c138-20020a624e90000000b00505fa47b611mr19933137pfb.65.1652179877328;
        Tue, 10 May 2022 03:51:17 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id cq21-20020a056a00331500b0050dc76281e0sm10249669pfb.186.2022.05.10.03.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 03:51:17 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     brking@us.ibm.com
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] [SCSI] ipr: use kobj_to_dev()
Date:   Tue, 10 May 2022 10:51:13 +0000
Message-Id: <20220510105113.1351891-1-chi.minghao@zte.com.cn>
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

From: Minghao Chi <chi.minghao@zte.com.cn>

Use kobj_to_dev() instead of open-coding it.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 drivers/scsi/ipr.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/ipr.c b/drivers/scsi/ipr.c
index 353cf47db79c..256ec6d08c16 100644
--- a/drivers/scsi/ipr.c
+++ b/drivers/scsi/ipr.c
@@ -3456,7 +3456,7 @@ static ssize_t ipr_read_trace(struct file *filp, struct kobject *kobj,
 			      struct bin_attribute *bin_attr,
 			      char *buf, loff_t off, size_t count)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct Scsi_Host *shost = class_to_shost(dev);
 	struct ipr_ioa_cfg *ioa_cfg = (struct ipr_ioa_cfg *)shost->hostdata;
 	unsigned long lock_flags = 0;
@@ -4182,7 +4182,7 @@ static ssize_t ipr_read_async_err_log(struct file *filep, struct kobject *kobj,
 				struct bin_attribute *bin_attr, char *buf,
 				loff_t off, size_t count)
 {
-	struct device *cdev = container_of(kobj, struct device, kobj);
+	struct device *cdev = kobj_to_dev(kobj);
 	struct Scsi_Host *shost = class_to_shost(cdev);
 	struct ipr_ioa_cfg *ioa_cfg = (struct ipr_ioa_cfg *)shost->hostdata;
 	struct ipr_hostrcb *hostrcb;
@@ -4206,7 +4206,7 @@ static ssize_t ipr_next_async_err_log(struct file *filep, struct kobject *kobj,
 				struct bin_attribute *bin_attr, char *buf,
 				loff_t off, size_t count)
 {
-	struct device *cdev = container_of(kobj, struct device, kobj);
+	struct device *cdev = kobj_to_dev(kobj);
 	struct Scsi_Host *shost = class_to_shost(cdev);
 	struct ipr_ioa_cfg *ioa_cfg = (struct ipr_ioa_cfg *)shost->hostdata;
 	struct ipr_hostrcb *hostrcb;
@@ -4267,7 +4267,7 @@ static ssize_t ipr_read_dump(struct file *filp, struct kobject *kobj,
 			     struct bin_attribute *bin_attr,
 			     char *buf, loff_t off, size_t count)
 {
-	struct device *cdev = container_of(kobj, struct device, kobj);
+	struct device *cdev = kobj_to_dev(kobj);
 	struct Scsi_Host *shost = class_to_shost(cdev);
 	struct ipr_ioa_cfg *ioa_cfg = (struct ipr_ioa_cfg *)shost->hostdata;
 	struct ipr_dump *dump;
@@ -4456,7 +4456,7 @@ static ssize_t ipr_write_dump(struct file *filp, struct kobject *kobj,
 			      struct bin_attribute *bin_attr,
 			      char *buf, loff_t off, size_t count)
 {
-	struct device *cdev = container_of(kobj, struct device, kobj);
+	struct device *cdev = kobj_to_dev(kobj);
 	struct Scsi_Host *shost = class_to_shost(cdev);
 	struct ipr_ioa_cfg *ioa_cfg = (struct ipr_ioa_cfg *)shost->hostdata;
 	int rc;
-- 
2.25.1


