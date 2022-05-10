Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78FDF5212DE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 12:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240421AbiEJK6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 06:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240034AbiEJK62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 06:58:28 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210124FC6D;
        Tue, 10 May 2022 03:51:50 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id n10so4458946pjh.5;
        Tue, 10 May 2022 03:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eCsMj0d1/H3KDoAfroxIa4b76PXDccyfi+yCHTDyPoE=;
        b=CtJrbRkdYLd2m75y3KnT1llgVR0TrXUGgcfjKnerzLytO3KhE+tKJrXpMCdL73JkrV
         wAE/cO12OX9q8ZV1cNOS2d1PVJ3Qq6lwn2BevdYI7dWmfYZ2/oqbSVU++K8smSj58FPP
         qH2VzrXI9m/8h87/7bLOVM9SJ/Z9Qi1/Vg02c9t+/YE5MskdJQkY7Yv27xiblP6N0kXP
         TG6LEgZiozrbLNKeR8paleRjAh4a35//96uGyg2aupHR9sl3JIWgl3G7DgaAYcn7yoVu
         aMcsAfjp+U4rmcJo3ncmyakDkU9nWPvBVkGpPNnXlLE+sUg0xrn3ZP5fFh2UEWYFW7Qe
         yjHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eCsMj0d1/H3KDoAfroxIa4b76PXDccyfi+yCHTDyPoE=;
        b=nyw9qC0QGpBG1qp7yi6s9pHz7lMpeigzY639MYZL6hnxK5nNm6Fzwjmzg714w9vRC1
         UYO0mMVq4O7jKQqajkd5JF+qIR77+CnoulgDRhnsgGRBTgStoZRvxac7OLOkRLLWtYNd
         zrePeTLzB3OJcxU5qqbvlRoQN7EMUJmhW3Huc48R4qZYyVe/20dfnKRIq6/rrG+65hut
         2WB0Bn8RtVgWectZ05Nlw9+fDrirGBml9eCIfO8PFouqGZrm1CfYZnUElisuSuUwus2l
         8M3mVxMmgWylWmhnp+DOtvuPa8bDDKEx5UOyzMPF6cGKHXJH5TXKWV98wLv7qnMCQY2t
         VvQA==
X-Gm-Message-State: AOAM530eylbINopiecyeAtkmZZRHgbRRBGt+oNG/+9MpPNnCkl65Y7gY
        +zFiTcIEzz4dMgJNp16xgdU=
X-Google-Smtp-Source: ABdhPJwkdiCGUU+XM88WpYZnDkq5K9ncI89i87n9dQBbbP43hghm580ctBP9FYiQdGdVRcOiq1UP3w==
X-Received: by 2002:a17:903:1d1:b0:15e:9607:d4c9 with SMTP id e17-20020a17090301d100b0015e9607d4c9mr20156470plh.41.1652179909689;
        Tue, 10 May 2022 03:51:49 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id r9-20020a056a00216900b0050dc7628195sm10288927pff.111.2022.05.10.03.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 03:51:49 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     james.smart@broadcom.com
Cc:     dick.kennedy@broadcom.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] lpfc: use kobj_to_dev()
Date:   Tue, 10 May 2022 10:51:45 +0000
Message-Id: <20220510105145.1352030-1-chi.minghao@zte.com.cn>
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
 drivers/scsi/lpfc/lpfc_attr.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_attr.c b/drivers/scsi/lpfc/lpfc_attr.c
index 3caaa7c4af48..97f87155c1bd 100644
--- a/drivers/scsi/lpfc/lpfc_attr.c
+++ b/drivers/scsi/lpfc/lpfc_attr.c
@@ -4376,8 +4376,7 @@ sysfs_drvr_stat_data_read(struct file *filp, struct kobject *kobj,
 		struct bin_attribute *bin_attr,
 		char *buf, loff_t off, size_t count)
 {
-	struct device *dev = container_of(kobj, struct device,
-		kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct Scsi_Host  *shost = class_to_shost(dev);
 	struct lpfc_vport *vport = (struct lpfc_vport *) shost->hostdata;
 	struct lpfc_hba   *phba = vport->phba;
@@ -6396,7 +6395,7 @@ sysfs_ctlreg_write(struct file *filp, struct kobject *kobj,
 		   char *buf, loff_t off, size_t count)
 {
 	size_t buf_off;
-	struct device *dev = container_of(kobj, struct device, kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct Scsi_Host  *shost = class_to_shost(dev);
 	struct lpfc_vport *vport = (struct lpfc_vport *) shost->hostdata;
 	struct lpfc_hba   *phba = vport->phba;
@@ -6456,7 +6455,7 @@ sysfs_ctlreg_read(struct file *filp, struct kobject *kobj,
 {
 	size_t buf_off;
 	uint32_t * tmp_ptr;
-	struct device *dev = container_of(kobj, struct device, kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct Scsi_Host  *shost = class_to_shost(dev);
 	struct lpfc_vport *vport = (struct lpfc_vport *) shost->hostdata;
 	struct lpfc_hba   *phba = vport->phba;
-- 
2.25.1


