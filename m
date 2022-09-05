Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD235AD1E5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 13:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238348AbiIEL4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 07:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237449AbiIELzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 07:55:44 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C29643622;
        Mon,  5 Sep 2022 04:55:35 -0700 (PDT)
Received: from fraeml712-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MLn12564fz68B7b;
        Mon,  5 Sep 2022 19:51:34 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml712-chm.china.huawei.com (10.206.15.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 5 Sep 2022 13:55:33 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 5 Sep 2022 12:55:25 +0100
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH 3/5] scsi: hisi_sas: Drain bcast events in hisi_sas_rescan_topology()
Date:   Mon, 5 Sep 2022 19:48:47 +0800
Message-ID: <1662378529-101489-4-git-send-email-john.garry@huawei.com>
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

In resetting the controller, SATA devices may be lost.

The issue is that when we insert the bcast events to rescan the topology
in hisi_sas_rescan_topology(), when we subsequently nexus reset the
SATA devices in hisi_sas_async_I_T_nexus_reset(), there is a small timing
window in which the remote phy is down and we process the bcast event
(meaning that libsas judges that the disk is lost).

Ensure that all bcast events are processed prior to the nexus reset to
close this window.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas_main.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index a33d46a5d7cd..2edadd4008c0 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -1341,6 +1341,7 @@ static void hisi_sas_refresh_port_id(struct hisi_hba *hisi_hba)
 
 static void hisi_sas_rescan_topology(struct hisi_hba *hisi_hba, u32 state)
 {
+	struct sas_ha_struct *sas_ha = &hisi_hba->sha;
 	struct asd_sas_port *_sas_port = NULL;
 	int phy_no;
 
@@ -1369,6 +1370,12 @@ static void hisi_sas_rescan_topology(struct hisi_hba *hisi_hba, u32 state)
 			hisi_sas_phy_down(hisi_hba, phy_no, 0, GFP_KERNEL);
 		}
 	}
+	/*
+	 * Ensure any bcast events are processed prior to calling async nexus
+	 * reset calls from hisi_sas_clear_nexus_ha() ->
+	 * hisi_sas_async_I_T_nexus_reset()
+	 */
+	sas_drain_work(sas_ha);
 }
 
 static void hisi_sas_reset_init_all_devices(struct hisi_hba *hisi_hba)
-- 
2.35.3

