Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEDDA4C2A8F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 12:15:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232873AbiBXLL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 06:11:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233922AbiBXLLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 06:11:31 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F9C0293A31;
        Thu, 24 Feb 2022 03:10:46 -0800 (PST)
Received: from fraeml743-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4K49Cl5J8sz67vrD;
        Thu, 24 Feb 2022 19:09:39 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml743-chm.china.huawei.com (10.206.15.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 24 Feb 2022 12:10:44 +0100
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 24 Feb 2022 11:10:42 +0000
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>
CC:     <chenxiang66@hisilicon.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <damien.lemoal@opensource.wdc.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 2/2] scsi: libsas: Use bool for queue_work() return code
Date:   Thu, 24 Feb 2022 19:04:59 +0800
Message-ID: <1645700699-82369-3-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1645700699-82369-1-git-send-email-john.garry@huawei.com>
References: <1645700699-82369-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

Function queue_work() returns a bool, so use a bool to hold this value
for the return code, which should make the code a tiny bit more clear.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/libsas/sas_event.c    | 23 +++++++++--------------
 drivers/scsi/libsas/sas_internal.h |  2 +-
 2 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/scsi/libsas/sas_event.c b/drivers/scsi/libsas/sas_event.c
index 8ff58fd97837..e5eb24100e2d 100644
--- a/drivers/scsi/libsas/sas_event.c
+++ b/drivers/scsi/libsas/sas_event.c
@@ -10,13 +10,13 @@
 #include <scsi/scsi_host.h>
 #include "sas_internal.h"
 
-int sas_queue_work(struct sas_ha_struct *ha, struct sas_work *sw)
+bool sas_queue_work(struct sas_ha_struct *ha, struct sas_work *sw)
 {
 	/* it's added to the defer_q when draining so return succeed */
-	int rc = 1;
+	bool rc = true;
 
 	if (!test_bit(SAS_HA_REGISTERED, &ha->state))
-		return 0;
+		return false;
 
 	if (test_bit(SAS_HA_DRAINING, &ha->state)) {
 		/* add it to the defer list, if not already pending */
@@ -28,11 +28,11 @@ int sas_queue_work(struct sas_ha_struct *ha, struct sas_work *sw)
 	return rc;
 }
 
-static int sas_queue_event(int event, struct sas_work *work,
+static bool sas_queue_event(int event, struct sas_work *work,
 			    struct sas_ha_struct *ha)
 {
 	unsigned long flags;
-	int rc;
+	bool rc;
 
 	spin_lock_irqsave(&ha->lock, flags);
 	rc = sas_queue_work(ha, work);
@@ -44,13 +44,12 @@ static int sas_queue_event(int event, struct sas_work *work,
 void sas_queue_deferred_work(struct sas_ha_struct *ha)
 {
 	struct sas_work *sw, *_sw;
-	int ret;
 
 	spin_lock_irq(&ha->lock);
 	list_for_each_entry_safe(sw, _sw, &ha->defer_q, drain_node) {
 		list_del_init(&sw->drain_node);
-		ret = sas_queue_work(ha, sw);
-		if (ret != 1) {
+
+		if (sas_queue_work(ha, sw) == false) {
 			pm_runtime_put(ha->dev);
 			sas_free_event(to_asd_sas_event(&sw->work));
 		}
@@ -170,7 +169,6 @@ void sas_notify_port_event(struct asd_sas_phy *phy, enum port_event event,
 {
 	struct sas_ha_struct *ha = phy->ha;
 	struct asd_sas_event *ev;
-	int ret;
 
 	BUG_ON(event >= PORT_NUM_EVENTS);
 
@@ -186,8 +184,7 @@ void sas_notify_port_event(struct asd_sas_phy *phy, enum port_event event,
 	if (sas_defer_event(phy, ev))
 		return;
 
-	ret = sas_queue_event(event, &ev->work, ha);
-	if (ret != 1) {
+	if (sas_queue_event(event, &ev->work, ha) == false) {
 		pm_runtime_put(ha->dev);
 		sas_free_event(ev);
 	}
@@ -199,7 +196,6 @@ void sas_notify_phy_event(struct asd_sas_phy *phy, enum phy_event event,
 {
 	struct sas_ha_struct *ha = phy->ha;
 	struct asd_sas_event *ev;
-	int ret;
 
 	BUG_ON(event >= PHY_NUM_EVENTS);
 
@@ -215,8 +211,7 @@ void sas_notify_phy_event(struct asd_sas_phy *phy, enum phy_event event,
 	if (sas_defer_event(phy, ev))
 		return;
 
-	ret = sas_queue_event(event, &ev->work, ha);
-	if (ret != 1) {
+	if (sas_queue_event(event, &ev->work, ha) == false) {
 		pm_runtime_put(ha->dev);
 		sas_free_event(ev);
 	}
diff --git a/drivers/scsi/libsas/sas_internal.h b/drivers/scsi/libsas/sas_internal.h
index 24843db2cb65..13d0ffaada93 100644
--- a/drivers/scsi/libsas/sas_internal.h
+++ b/drivers/scsi/libsas/sas_internal.h
@@ -67,7 +67,7 @@ void sas_porte_broadcast_rcvd(struct work_struct *work);
 void sas_porte_link_reset_err(struct work_struct *work);
 void sas_porte_timer_event(struct work_struct *work);
 void sas_porte_hard_reset(struct work_struct *work);
-int sas_queue_work(struct sas_ha_struct *ha, struct sas_work *sw);
+bool sas_queue_work(struct sas_ha_struct *ha, struct sas_work *sw);
 
 int sas_notify_lldd_dev_found(struct domain_device *);
 void sas_notify_lldd_dev_gone(struct domain_device *);
-- 
2.26.2

