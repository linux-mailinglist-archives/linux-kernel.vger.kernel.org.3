Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3645A5AEFB1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 18:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbiIFP6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 11:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233964AbiIFPzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 11:55:48 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D8493F1FF;
        Tue,  6 Sep 2022 08:14:56 -0700 (PDT)
Received: from fraeml710-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MMTSM5Tptz67y8S;
        Tue,  6 Sep 2022 23:14:11 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml710-chm.china.huawei.com (10.206.15.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 6 Sep 2022 17:14:54 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 6 Sep 2022 16:14:51 +0100
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <jinpu.wang@cloud.ionos.com>, <damien.lemoal@opensource.wdc.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <yangxingui@huawei.com>, <hare@suse.de>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH v3 6/6] scsi: libsas: Make sas_{alloc, alloc_slow, free}_task() private
Date:   Tue, 6 Sep 2022 23:08:10 +0800
Message-ID: <1662476890-15467-7-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1662476890-15467-1-git-send-email-john.garry@huawei.com>
References: <1662476890-15467-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have no users outside libsas any longer, so make sas_alloc_task(),
sas_alloc_slow_task(), and sas_free_task() private.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/libsas/sas_init.c     | 3 ---
 drivers/scsi/libsas/sas_internal.h | 4 ++++
 include/scsi/libsas.h              | 4 ----
 3 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/libsas/sas_init.c b/drivers/scsi/libsas/sas_init.c
index e4f77072a58d..f2c05ebeb72f 100644
--- a/drivers/scsi/libsas/sas_init.c
+++ b/drivers/scsi/libsas/sas_init.c
@@ -35,7 +35,6 @@ struct sas_task *sas_alloc_task(gfp_t flags)
 
 	return task;
 }
-EXPORT_SYMBOL_GPL(sas_alloc_task);
 
 struct sas_task *sas_alloc_slow_task(gfp_t flags)
 {
@@ -56,7 +55,6 @@ struct sas_task *sas_alloc_slow_task(gfp_t flags)
 
 	return task;
 }
-EXPORT_SYMBOL_GPL(sas_alloc_slow_task);
 
 void sas_free_task(struct sas_task *task)
 {
@@ -65,7 +63,6 @@ void sas_free_task(struct sas_task *task)
 		kmem_cache_free(sas_task_cache, task);
 	}
 }
-EXPORT_SYMBOL_GPL(sas_free_task);
 
 /*------------ SAS addr hash -----------*/
 void sas_hash_addr(u8 *hashed, const u8 *sas_addr)
diff --git a/drivers/scsi/libsas/sas_internal.h b/drivers/scsi/libsas/sas_internal.h
index 8d0ad3abc7b5..b54bcf3c9a9d 100644
--- a/drivers/scsi/libsas/sas_internal.h
+++ b/drivers/scsi/libsas/sas_internal.h
@@ -52,6 +52,10 @@ void sas_unregister_phys(struct sas_ha_struct *sas_ha);
 struct asd_sas_event *sas_alloc_event(struct asd_sas_phy *phy, gfp_t gfp_flags);
 void sas_free_event(struct asd_sas_event *event);
 
+struct sas_task *sas_alloc_task(gfp_t flags);
+struct sas_task *sas_alloc_slow_task(gfp_t flags);
+void sas_free_task(struct sas_task *task);
+
 int  sas_register_ports(struct sas_ha_struct *sas_ha);
 void sas_unregister_ports(struct sas_ha_struct *sas_ha);
 
diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
index 2dbead74a2af..f86b56bf7833 100644
--- a/include/scsi/libsas.h
+++ b/include/scsi/libsas.h
@@ -639,10 +639,6 @@ struct sas_task_slow {
 #define SAS_TASK_STATE_ABORTED      4
 #define SAS_TASK_NEED_DEV_RESET     8
 
-extern struct sas_task *sas_alloc_task(gfp_t flags);
-extern struct sas_task *sas_alloc_slow_task(gfp_t flags);
-extern void sas_free_task(struct sas_task *task);
-
 static inline bool sas_is_internal_abort(struct sas_task *task)
 {
 	return task->task_proto == SAS_PROTOCOL_INTERNAL_ABORT;
-- 
2.35.3

