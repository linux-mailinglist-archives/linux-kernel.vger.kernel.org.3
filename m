Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 495D251390A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 17:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349649AbiD1Pyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 11:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349338AbiD1Pyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 11:54:41 -0400
Received: from m12-14.163.com (m12-14.163.com [220.181.12.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7AA23B82CE;
        Thu, 28 Apr 2022 08:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=+e7JZ
        FWImB/gYWPb56BE8Z6CjV8zZZto66kxquF1544=; b=jn5dK5tSBLkHFi4I6rFPz
        M8B6ivLS6y9bAG45SqnezsFdKLe3i90GDFnTwL9d53ihibzHAARm2FDGS8r7+o2o
        McGDph9zhhjqhRK5VvmjzcLvPzIwXVhOkm1eaSrs8VecYC+Xbx9RAyxV2oH6nkEj
        TAiJggSynkhLGcrZUYxCG8=
Received: from carlis (unknown [120.229.64.124])
        by smtp10 (Coremail) with SMTP id DsCowACX01rxt2pi8R3GDQ--.41376S2;
        Thu, 28 Apr 2022 23:51:14 +0800 (CST)
From:   Xuezhi Zhang <zhangxuezhi1@coolpad.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xuezhi Zhang <zhangxuezhi1@coolpad.com>
Subject: [PATCH v3] scsi: pmcraid: convert sysfs snprintf to sysfs_emit
Date:   Thu, 28 Apr 2022 15:51:11 +0000
Message-Id: <20220428155111.257880-1-zhangxuezhi1@coolpad.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DsCowACX01rxt2pi8R3GDQ--.41376S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CF48CF18tr47Zr45tFy3CFg_yoW8Ar4Dpa
        yrGryUAr4kJr1UZrWjgay0va4FvayxJa4DtFWkZ3savF9ayrWkGa9rAayagFs5Gr4kZr9x
        Zr4qyr1Y9a1jyrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j-5rcUUUUU=
X-Originating-IP: [120.229.64.124]
Sender: llyz108@163.com
X-CM-SenderInfo: xoo16iiqy6il2tof0z/1tbiMhLwhVWBy9fKWgAAsN
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warnings:
drivers/scsi/pmcraid.c:3591:8-16:
WARNING: use scnprintf or sprintf
drivers/scsi/pmcraid.c:3557:8-16:
WARNING: use scnprintf or sprintf
drivers/scsi/pmcraid.c:3496:8-16:
WARNING: use scnprintf or sprintf

Signed-off-by: Xuezhi Zhang <zhangxuezhi1@coolpad.com>
---
v2: fix the sysfs_emt error.
v3: delete the added config changes in v2.
---
 drivers/scsi/pmcraid.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/pmcraid.c b/drivers/scsi/pmcraid.c
index 3d5cd337a2a6..57a6fe8aaf70 100644
--- a/drivers/scsi/pmcraid.c
+++ b/drivers/scsi/pmcraid.c
@@ -3493,7 +3493,7 @@ static ssize_t pmcraid_show_log_level(
 	struct Scsi_Host *shost = class_to_shost(dev);
 	struct pmcraid_instance *pinstance =
 		(struct pmcraid_instance *)shost->hostdata;
-	return snprintf(buf, PAGE_SIZE, "%d\n", pinstance->current_log_level);
+	return sysfs_emit(buf, "%d\n", pinstance->current_log_level);
 }
 
 /**
@@ -3554,8 +3554,7 @@ static ssize_t pmcraid_show_drv_version(
 	char *buf
 )
 {
-	return snprintf(buf, PAGE_SIZE, "version: %s\n",
-			PMCRAID_DRIVER_VERSION);
+	return sysfs_emit(buf, "version: %s\n", PMCRAID_DRIVER_VERSION);
 }
 
 static struct device_attribute pmcraid_driver_version_attr = {
@@ -3588,8 +3587,7 @@ static ssize_t pmcraid_show_adapter_id(
 		pinstance->pdev->devfn;
 	u32 aen_group = pmcraid_event_family.id;
 
-	return snprintf(buf, PAGE_SIZE,
-			"adapter id: %d\nminor: %d\naen group: %d\n",
+	return sysfs_emit(buf, "adapter id: %d\nminor: %d\naen group: %d\n",
 			adapter_id, MINOR(pinstance->cdev.dev), aen_group);
 }
 
-- 
2.25.1

