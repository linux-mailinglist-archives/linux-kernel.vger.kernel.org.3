Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6875657E0D9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 13:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234958AbiGVLbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 07:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234877AbiGVLa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 07:30:58 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD1BBDA1F;
        Fri, 22 Jul 2022 04:30:45 -0700 (PDT)
Received: from fraeml741-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Lq6ZR4xMdz67h3l;
        Fri, 22 Jul 2022 19:26:07 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml741-chm.china.huawei.com (10.206.15.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 22 Jul 2022 13:30:43 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 22 Jul 2022 12:30:39 +0100
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <jinpu.wang@cloud.ionos.com>, <damien.lemoal@opensource.wdc.com>,
        <yangxingui@huawei.com>, <chenxiang66@hisilicon.com>,
        <hare@suse.de>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 6/6] scsi: libsas: Make sas_{alloc, alloc_slow, free}_task() private
Date:   Fri, 22 Jul 2022 19:24:09 +0800
Message-ID: <1658489049-232850-7-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1658489049-232850-1-git-send-email-john.garry@huawei.com>
References: <1658489049-232850-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
index dc35f0f8eae3..fad4fb731bf3 100644
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
index 13d0ffaada93..19856e107ebd 100644
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
index ff04eb6d250b..1c45575d1082 100644
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

