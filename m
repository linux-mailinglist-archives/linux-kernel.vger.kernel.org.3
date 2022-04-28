Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 904D75138E4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 17:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349540AbiD1Pq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 11:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349587AbiD1Pqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 11:46:44 -0400
Received: from m12-11.163.com (m12-11.163.com [220.181.12.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D491FB8218
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 08:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=omlQ6
        9E2x/SzIK747ck5UAd2ZJMPM/qYh2oIEJ2dY0M=; b=EZ8tSs91Sj7wRs6F3JGO4
        mKeC3ULdIuDzhbNR3l/1ikOltCGHG/HFEq04yq3dNp5y7vbmcE45WAC8Ul7HNCP0
        jaMr42QC/+bv3KlC/thWHID9oRLqA/6Pr1C0AoMRQ7nAcp8z4WoFUg/KHcDovcCB
        Y6ZjzCz6se+d8bXg00Ud/U=
Received: from carlis (unknown [120.229.64.124])
        by smtp7 (Coremail) with SMTP id C8CowAD3Zaa0tWpitrEwDg--.12573S2;
        Thu, 28 Apr 2022 23:41:41 +0800 (CST)
From:   Xuezhi Zhang <zhangxuezhi1@coolpad.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xuezhi Zhang <zhangxuezhi1@coolpad.com>
Subject: [PATCH v2] scsi: pmcraid: convert sysfs snprintf to sysfs_emit
Date:   Thu, 28 Apr 2022 15:41:37 +0000
Message-Id: <20220428154138.257250-1-zhangxuezhi1@coolpad.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C8CowAD3Zaa0tWpitrEwDg--.12573S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CF48CF18tr47Zr45uFWkCrg_yoW8tr1Upa
        4fGryDAF48Gr15AFWUXayv93WFva93J34qqFWkA340vF93ArWUJ39rZFWagF4DXF4kArsx
        Zr4vgr1a9a1jq3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jU5rcUUUUU=
X-Originating-IP: [120.229.64.124]
Sender: llyz108@163.com
X-CM-SenderInfo: xoo16iiqy6il2tof0z/1tbiQw3whVc7ZAeOEgAAso
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
---
 arch/arm64/configs/defconfig | 4 ++++
 drivers/scsi/pmcraid.c       | 8 +++-----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 476c5a9488d0..8688ed761cfd 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1295,3 +1295,7 @@ CONFIG_DEBUG_KERNEL=y
 # CONFIG_DEBUG_PREEMPT is not set
 # CONFIG_FTRACE is not set
 CONFIG_MEMTEST=y
+CONFIG_UEVENT_HELPER=y
+CONFIG_UEVENT_HELPER_PATH="/sbin/mdev"
+CONFIG_INITRAMFS_SOURCE="_install_arm64"
+
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

