Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09E0B4C4304
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 12:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239915AbiBYLDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 06:03:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236456AbiBYLDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 06:03:43 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7BF223217;
        Fri, 25 Feb 2022 03:03:11 -0800 (PST)
Received: from fraeml735-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4K4mw90t7rz67mtG;
        Fri, 25 Feb 2022 18:58:17 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml735-chm.china.huawei.com (10.206.15.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 25 Feb 2022 12:03:09 +0100
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 25 Feb 2022 11:03:07 +0000
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>
CC:     <chenxiang66@hisilicon.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <damien.lemoal@opensource.wdc.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH v2 1/2] scsi: libsas: Make sas_notify_{phy,port}_event() return void
Date:   Fri, 25 Feb 2022 18:57:35 +0800
Message-ID: <1645786656-221630-2-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1645786656-221630-1-git-send-email-john.garry@huawei.com>
References: <1645786656-221630-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nobody checks the return codes, so make them return void. Indeed, if the
LLDD cannot send an event, nothing much can be done in the LLDD about it.

Also remove prototype for sas_notify_phy_event() in sas_internal.h, which
should not be there.

Signed-off-by: John Garry <john.garry@huawei.com>
Reviewed-by: Xiang Chen <chenxiang66@hisilicon.com>
Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/scsi/libsas/sas_event.c    | 20 ++++++++------------
 drivers/scsi/libsas/sas_internal.h |  2 --
 include/scsi/libsas.h              |  8 ++++----
 3 files changed, 12 insertions(+), 18 deletions(-)

diff --git a/drivers/scsi/libsas/sas_event.c b/drivers/scsi/libsas/sas_event.c
index 3613b9b315bc..8ff58fd97837 100644
--- a/drivers/scsi/libsas/sas_event.c
+++ b/drivers/scsi/libsas/sas_event.c
@@ -165,8 +165,8 @@ static bool sas_defer_event(struct asd_sas_phy *phy, struct asd_sas_event *ev)
 	return deferred;
 }
 
-int sas_notify_port_event(struct asd_sas_phy *phy, enum port_event event,
-			  gfp_t gfp_flags)
+void sas_notify_port_event(struct asd_sas_phy *phy, enum port_event event,
+			   gfp_t gfp_flags)
 {
 	struct sas_ha_struct *ha = phy->ha;
 	struct asd_sas_event *ev;
@@ -176,7 +176,7 @@ int sas_notify_port_event(struct asd_sas_phy *phy, enum port_event event,
 
 	ev = sas_alloc_event(phy, gfp_flags);
 	if (!ev)
-		return -ENOMEM;
+		return;
 
 	/* Call pm_runtime_put() with pairs in sas_port_event_worker() */
 	pm_runtime_get_noresume(ha->dev);
@@ -184,20 +184,18 @@ int sas_notify_port_event(struct asd_sas_phy *phy, enum port_event event,
 	INIT_SAS_EVENT(ev, sas_port_event_worker, phy, event);
 
 	if (sas_defer_event(phy, ev))
-		return 0;
+		return;
 
 	ret = sas_queue_event(event, &ev->work, ha);
 	if (ret != 1) {
 		pm_runtime_put(ha->dev);
 		sas_free_event(ev);
 	}
-
-	return ret;
 }
 EXPORT_SYMBOL_GPL(sas_notify_port_event);
 
-int sas_notify_phy_event(struct asd_sas_phy *phy, enum phy_event event,
-			 gfp_t gfp_flags)
+void sas_notify_phy_event(struct asd_sas_phy *phy, enum phy_event event,
+			  gfp_t gfp_flags)
 {
 	struct sas_ha_struct *ha = phy->ha;
 	struct asd_sas_event *ev;
@@ -207,7 +205,7 @@ int sas_notify_phy_event(struct asd_sas_phy *phy, enum phy_event event,
 
 	ev = sas_alloc_event(phy, gfp_flags);
 	if (!ev)
-		return -ENOMEM;
+		return;
 
 	/* Call pm_runtime_put() with pairs in sas_phy_event_worker() */
 	pm_runtime_get_noresume(ha->dev);
@@ -215,14 +213,12 @@ int sas_notify_phy_event(struct asd_sas_phy *phy, enum phy_event event,
 	INIT_SAS_EVENT(ev, sas_phy_event_worker, phy, event);
 
 	if (sas_defer_event(phy, ev))
-		return 0;
+		return;
 
 	ret = sas_queue_event(event, &ev->work, ha);
 	if (ret != 1) {
 		pm_runtime_put(ha->dev);
 		sas_free_event(ev);
 	}
-
-	return ret;
 }
 EXPORT_SYMBOL_GPL(sas_notify_phy_event);
diff --git a/drivers/scsi/libsas/sas_internal.h b/drivers/scsi/libsas/sas_internal.h
index b60f0bf612cf..24843db2cb65 100644
--- a/drivers/scsi/libsas/sas_internal.h
+++ b/drivers/scsi/libsas/sas_internal.h
@@ -78,8 +78,6 @@ int sas_smp_phy_control(struct domain_device *dev, int phy_id,
 			enum phy_func phy_func, struct sas_phy_linkrates *);
 int sas_smp_get_phy_events(struct sas_phy *phy);
 
-int sas_notify_phy_event(struct asd_sas_phy *phy, enum phy_event event,
-			 gfp_t flags);
 void sas_device_set_phy(struct domain_device *dev, struct sas_port *port);
 struct domain_device *sas_find_dev_by_rphy(struct sas_rphy *rphy);
 struct domain_device *sas_ex_to_ata(struct domain_device *ex_dev, int phy_id);
diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
index dc529cc92d65..df2c8fc43429 100644
--- a/include/scsi/libsas.h
+++ b/include/scsi/libsas.h
@@ -727,9 +727,9 @@ int sas_lu_reset(struct domain_device *dev, u8 *lun);
 int sas_query_task(struct sas_task *task, u16 tag);
 int sas_abort_task(struct sas_task *task, u16 tag);
 
-int sas_notify_port_event(struct asd_sas_phy *phy, enum port_event event,
-			  gfp_t gfp_flags);
-int sas_notify_phy_event(struct asd_sas_phy *phy, enum phy_event event,
-			 gfp_t gfp_flags);
+void sas_notify_port_event(struct asd_sas_phy *phy, enum port_event event,
+			   gfp_t gfp_flags);
+void sas_notify_phy_event(struct asd_sas_phy *phy, enum phy_event event,
+			   gfp_t gfp_flags);
 
 #endif /* _SASLIB_H_ */
-- 
2.26.2

