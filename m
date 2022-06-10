Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76414546B10
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 18:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349912AbiFJQxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 12:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349841AbiFJQwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 12:52:55 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 936961116F;
        Fri, 10 Jun 2022 09:52:52 -0700 (PDT)
Received: from fraeml741-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LKRnF2Zclz688sb;
        Sat, 11 Jun 2022 00:51:29 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml741-chm.china.huawei.com (10.206.15.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 10 Jun 2022 18:52:50 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 10 Jun 2022 17:52:48 +0100
From:   John Garry <john.garry@huawei.com>
To:     <jinpu.wang@cloud.ionos.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <hare@suse.de>, <damien.lemoal@opensource.wdc.com>,
        <Ajish.Koshy@microchip.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH 3/4] scsi: pm8001: Use non-atomic bitmap ops for tag alloc + free
Date:   Sat, 11 Jun 2022 00:46:41 +0800
Message-ID: <1654879602-33497-4-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1654879602-33497-1-git-send-email-john.garry@huawei.com>
References: <1654879602-33497-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In pm8001_tag_alloc() we don't require atomic set_bit() as we are already
in atomic context. In pm8001_tag_free() we should use the same host
spinlock to protect clearing the tag (and then don't require the atomic
clear_bit()).

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/pm8001/pm8001_sas.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/pm8001/pm8001_sas.c b/drivers/scsi/pm8001/pm8001_sas.c
index 3a863d776724..8e3f2f9ddaac 100644
--- a/drivers/scsi/pm8001/pm8001_sas.c
+++ b/drivers/scsi/pm8001/pm8001_sas.c
@@ -66,7 +66,11 @@ static int pm8001_find_tag(struct sas_task *task, u32 *tag)
 void pm8001_tag_free(struct pm8001_hba_info *pm8001_ha, u32 tag)
 {
 	void *bitmap = pm8001_ha->tags;
-	clear_bit(tag, bitmap);
+	unsigned long flags;
+
+	spin_lock_irqsave(&pm8001_ha->bitmap_lock, flags);
+	__clear_bit(tag, bitmap);
+	spin_unlock_irqrestore(&pm8001_ha->bitmap_lock, flags);
 }
 
 /**
@@ -76,9 +80,9 @@ void pm8001_tag_free(struct pm8001_hba_info *pm8001_ha, u32 tag)
   */
 int pm8001_tag_alloc(struct pm8001_hba_info *pm8001_ha, u32 *tag_out)
 {
-	unsigned int tag;
 	void *bitmap = pm8001_ha->tags;
 	unsigned long flags;
+	unsigned int tag;
 
 	spin_lock_irqsave(&pm8001_ha->bitmap_lock, flags);
 	tag = find_first_zero_bit(bitmap, pm8001_ha->tags_num);
@@ -86,7 +90,7 @@ int pm8001_tag_alloc(struct pm8001_hba_info *pm8001_ha, u32 *tag_out)
 		spin_unlock_irqrestore(&pm8001_ha->bitmap_lock, flags);
 		return -SAS_QUEUE_FULL;
 	}
-	set_bit(tag, bitmap);
+	__set_bit(tag, bitmap);
 	spin_unlock_irqrestore(&pm8001_ha->bitmap_lock, flags);
 	*tag_out = tag;
 	return 0;
-- 
2.26.2

