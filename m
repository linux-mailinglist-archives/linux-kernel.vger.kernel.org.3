Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 522705AD1F0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 13:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237705AbiIEL4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 07:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236780AbiIELzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 07:55:33 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C0D2982F;
        Mon,  5 Sep 2022 04:55:33 -0700 (PDT)
Received: from fraeml710-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MLn104437z681Yv;
        Mon,  5 Sep 2022 19:51:32 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml710-chm.china.huawei.com (10.206.15.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 5 Sep 2022 13:55:31 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 5 Sep 2022 12:55:29 +0100
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH 5/5] scsi: hisi_sas: Don't send bcast events from HW during nexus HA reset
Date:   Mon, 5 Sep 2022 19:48:49 +0800
Message-ID: <1662378529-101489-6-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1662378529-101489-1-git-send-email-john.garry@huawei.com>
References: <1662378529-101489-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

Remote devices may go missing from the per-device nexus reset part of the
HA nexus, i.e after the controller reset. This is because libsas may find
the devices to be gone as the phy may be temporarily down when processing
the bcast event generated from the nexus reset. Filter out bcast events
during this time to stop the devices being lost.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas_main.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index 32fa775e7d37..699b07abb6b0 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -1823,12 +1823,14 @@ static int hisi_sas_clear_nexus_ha(struct sas_ha_struct *sas_ha)
 	struct hisi_hba *hisi_hba = sas_ha->lldd_ha;
 	HISI_SAS_DECLARE_RST_WORK_ON_STACK(r);
 	ASYNC_DOMAIN_EXCLUSIVE(async);
-	int i;
+	int i, ret;
 
 	queue_work(hisi_hba->wq, &r.work);
 	wait_for_completion(r.completion);
-	if (!r.done)
-		return TMF_RESP_FUNC_FAILED;
+	if (!r.done) {
+		ret = TMF_RESP_FUNC_FAILED;
+		goto out;
+	}
 
 	for (i = 0; i < HISI_SAS_MAX_DEVICES; i++) {
 		struct hisi_sas_device *sas_dev = &hisi_hba->devices[i];
@@ -1845,7 +1847,9 @@ static int hisi_sas_clear_nexus_ha(struct sas_ha_struct *sas_ha)
 	async_synchronize_full_domain(&async);
 	hisi_sas_release_tasks(hisi_hba);
 
-	return TMF_RESP_FUNC_COMPLETE;
+	ret = TMF_RESP_FUNC_COMPLETE;
+out:
+	return ret;
 }
 
 static int hisi_sas_query_task(struct sas_task *task)
@@ -1993,10 +1997,14 @@ void hisi_sas_phy_bcast(struct hisi_sas_phy *phy)
 {
 	struct asd_sas_phy *sas_phy = &phy->sas_phy;
 	struct hisi_hba	*hisi_hba = phy->hisi_hba;
+	struct sas_ha_struct *sha = &hisi_hba->sha;
 
 	if (test_bit(HISI_SAS_RESETTING_BIT, &hisi_hba->flags))
 		return;
 
+	if (test_bit(SAS_HA_FROZEN, &sha->state))
+		return;
+
 	sas_notify_port_event(sas_phy, PORTE_BROADCAST_RCVD, GFP_ATOMIC);
 }
 EXPORT_SYMBOL_GPL(hisi_sas_phy_bcast);
-- 
2.35.3

