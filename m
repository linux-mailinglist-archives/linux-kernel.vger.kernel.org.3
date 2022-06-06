Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 195B953E388
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 10:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbiFFG6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 02:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbiFFG6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 02:58:41 -0400
Received: from m12-11.163.com (m12-11.163.com [220.181.12.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9E0EE27FC8;
        Sun,  5 Jun 2022 23:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=hKU5A
        rRzebO/PE+A96fqDA5Q8vQg8R9L8GsPEj4JphE=; b=IiVdN7NNxICc5j1HeQD+B
        WmmSHTO8T7BYST/tH1blW+7S4GK7S3RU+zZs1BTWsU2ZAD2xWrX0wF++8zWTb8F8
        MqBHLdLt2j/WYXlFhlTSvkI1WWaN9RKcLzj09I5ZfoJ+MNRuXLoXKhGSjsiS1s14
        bRFpi3Z2U/PAuS9RbsDOrE=
Received: from carlis-virtual-machine (unknown [218.17.89.93])
        by smtp7 (Coremail) with SMTP id C8CowAC3Rbp3pZ1iSKn7GQ--.60343S2;
        Mon, 06 Jun 2022 14:58:00 +0800 (CST)
From:   Xuezhi Zhang <zhangxuezhi1@coolpad.com>
To:     linux@highpoint-tech.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xuezhi Zhang <zhangxuezhi1@coolpad.com>
Subject: [PATCH] scsi: hptiop: convert sysfs snprintf to sysfs_emit
Date:   Mon,  6 Jun 2022 14:57:57 +0800
Message-Id: <20220606065757.48514-1-zhangxuezhi1@coolpad.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C8CowAC3Rbp3pZ1iSKn7GQ--.60343S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WF13JFy5XFWxKr1kWw48WFg_yoW8Jw1xpF
        47Ga47urs5Aw47WF1UXF1fZFyFvas3tr9rJaykW3s8uF17JrWDJFW5AFWjqryrGay8Grya
        yF4qkFy5ua18Ar7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jkBMtUUUUU=
X-Originating-IP: [218.17.89.93]
Sender: llyz108@163.com
X-CM-SenderInfo: xoo16iiqy6il2tof0z/xtbB0RgYhVzIBMhdNgAAsn
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warnings:
drivers/scsi/hptiop.c:1126:8-16:
WARNING: use scnprintf or sprintf
drivers/scsi/hptiop.c:1117:8-16:
WARNING: use scnprintf or sprintf

Signed-off-by: Xuezhi Zhang <zhangxuezhi1@coolpad.com>
---
 drivers/scsi/hptiop.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/hptiop.c b/drivers/scsi/hptiop.c
index f18b770626e6..51833839c850 100644
--- a/drivers/scsi/hptiop.c
+++ b/drivers/scsi/hptiop.c
@@ -1114,7 +1114,7 @@ static int hptiop_adjust_disk_queue_depth(struct scsi_device *sdev,
 static ssize_t hptiop_show_version(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%s\n", driver_ver);
+	return sysfs_emit(buf, "%s\n", driver_ver);
 }
 
 static ssize_t hptiop_show_fw_version(struct device *dev,
@@ -1123,7 +1123,7 @@ static ssize_t hptiop_show_fw_version(struct device *dev,
 	struct Scsi_Host *host = class_to_shost(dev);
 	struct hptiop_hba *hba = (struct hptiop_hba *)host->hostdata;
 
-	return snprintf(buf, PAGE_SIZE, "%d.%d.%d.%d\n",
+	return sysfs_emit(buf, "%d.%d.%d.%d\n",
 				hba->firmware_version >> 24,
 				(hba->firmware_version >> 16) & 0xff,
 				(hba->firmware_version >> 8) & 0xff,
-- 
2.34.1

