Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 303AB597223
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 17:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240407AbiHQO6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 10:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240057AbiHQO6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 10:58:41 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 224D845060;
        Wed, 17 Aug 2022 07:58:40 -0700 (PDT)
Received: from fraeml703-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4M79y022B0z67MfB;
        Wed, 17 Aug 2022 22:53:44 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml703-chm.china.huawei.com (10.206.15.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Wed, 17 Aug 2022 16:58:38 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 17 Aug 2022 15:58:35 +0100
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <jinpu.wang@cloud.ionos.com>, <damien.lemoal@opensource.wdc.com>,
        <yangxingui@huawei.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <hare@suse.de>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH v2 2/6] scsi: libsas: Add sas_ata_device_link_abort()
Date:   Wed, 17 Aug 2022 22:52:10 +0800
Message-ID: <1660747934-60059-3-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1660747934-60059-1-git-send-email-john.garry@huawei.com>
References: <1660747934-60059-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

Similar to how AHCI handles NCQ errors in ahci_error_intr() ->
ata_port_abort() -> ata_do_link_abort(), add an NCQ error handler for LLDDs
to call to initiate a link abort.

This will mark all outstanding QCs as failed and kick-off EH.

Note:
The ATA_EH_RESET flag is set for following reasons:
- For hisi_sas, SATA device resources during error handling will only be
  released during reset for ATA EH.
  ATA EH could decide during autopsy that EH would not be required, so
  ensure that it happens (by setting the flag).
- Similar to hisi_sas, pm8001 NCQ error handling requires a hardreset to
  ensure necessary recovery commands are sent (so again we require flag
  ATA_EH_RESET to be set as an insurance policy).

Suggested-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/libsas/sas_ata.c | 11 +++++++++++
 include/scsi/sas_ata.h        |  5 +++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/scsi/libsas/sas_ata.c b/drivers/scsi/libsas/sas_ata.c
index d35c9296f738..9daae64be37e 100644
--- a/drivers/scsi/libsas/sas_ata.c
+++ b/drivers/scsi/libsas/sas_ata.c
@@ -861,6 +861,17 @@ void sas_ata_wait_eh(struct domain_device *dev)
 	ata_port_wait_eh(ap);
 }
 
+void sas_ata_device_link_abort(struct domain_device *device)
+{
+	struct ata_port *ap = device->sata_dev.ap;
+	struct ata_link *link = &ap->link;
+
+	link->eh_info.err_mask |= AC_ERR_DEV;
+	link->eh_info.action |= ATA_EH_RESET;
+	ata_link_abort(link);
+}
+EXPORT_SYMBOL_GPL(sas_ata_device_link_abort);
+
 int sas_execute_ata_cmd(struct domain_device *device, u8 *fis, int force_phy_id)
 {
 	struct sas_tmf_task tmf_task = {};
diff --git a/include/scsi/sas_ata.h b/include/scsi/sas_ata.h
index a1df4f9d57a3..cad0b33064a5 100644
--- a/include/scsi/sas_ata.h
+++ b/include/scsi/sas_ata.h
@@ -32,6 +32,7 @@ void sas_probe_sata(struct asd_sas_port *port);
 void sas_suspend_sata(struct asd_sas_port *port);
 void sas_resume_sata(struct asd_sas_port *port);
 void sas_ata_end_eh(struct ata_port *ap);
+void sas_ata_device_link_abort(struct domain_device *dev);
 int sas_execute_ata_cmd(struct domain_device *device, u8 *fis,
 			int force_phy_id);
 int sas_ata_wait_after_reset(struct domain_device *dev, unsigned long deadline);
@@ -87,6 +88,10 @@ static inline void sas_ata_end_eh(struct ata_port *ap)
 {
 }
 
+static inline void sas_ata_device_link_abort(struct domain_device *dev)
+{
+}
+
 static inline int sas_execute_ata_cmd(struct domain_device *device, u8 *fis,
 				      int force_phy_id)
 {
-- 
2.35.3

