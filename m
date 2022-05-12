Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 959E9524B7D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 13:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353336AbiELLW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 07:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353131AbiELLV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 07:21:28 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E37306;
        Thu, 12 May 2022 04:21:27 -0700 (PDT)
Received: from fraeml706-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KzTmR2pmqz687hF;
        Thu, 12 May 2022 19:18:31 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml706-chm.china.huawei.com (10.206.15.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Thu, 12 May 2022 13:21:25 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 12 May 2022 12:21:23 +0100
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH 1/3] scsi: libsas: Refactor sas_ata_hard_reset()
Date:   Thu, 12 May 2022 19:15:32 +0800
Message-ID: <1652354134-171343-2-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1652354134-171343-1-git-send-email-john.garry@huawei.com>
References: <1652354134-171343-1-git-send-email-john.garry@huawei.com>
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

Create function sas_ata_wait_after_reset() from sas_ata_hard_reset() as
some LLDDs may want to check for a remote ATA phy is up after reset.

Signed-off-by: John Garry <john.garry@huawei.com>
Reviewed-by: Xiang Chen <chenxiang66@hisilicon.com>
Tested-by: Yihang Li <liyihang6@hisilicon.com>
---
 drivers/scsi/libsas/sas_ata.c | 41 +++++++++++++++++++++++------------
 include/scsi/sas_ata.h        |  7 ++++++
 2 files changed, 34 insertions(+), 14 deletions(-)

diff --git a/drivers/scsi/libsas/sas_ata.c b/drivers/scsi/libsas/sas_ata.c
index d34c82e24d9a..d35c9296f738 100644
--- a/drivers/scsi/libsas/sas_ata.c
+++ b/drivers/scsi/libsas/sas_ata.c
@@ -358,22 +358,14 @@ static int sas_ata_printk(const char *level, const struct domain_device *ddev,
 	return r;
 }
 
-static int sas_ata_hard_reset(struct ata_link *link, unsigned int *class,
-			      unsigned long deadline)
+int sas_ata_wait_after_reset(struct domain_device *dev, unsigned long deadline)
 {
-	int ret = 0, res;
-	struct sas_phy *phy;
-	struct ata_port *ap = link->ap;
+	struct sata_device *sata_dev = &dev->sata_dev;
 	int (*check_ready)(struct ata_link *link);
-	struct domain_device *dev = ap->private_data;
-	struct sas_internal *i = dev_to_sas_internal(dev);
-
-	res = i->dft->lldd_I_T_nexus_reset(dev);
-	if (res == -ENODEV)
-		return res;
-
-	if (res != TMF_RESP_FUNC_COMPLETE)
-		sas_ata_printk(KERN_DEBUG, dev, "Unable to reset ata device?\n");
+	struct ata_port *ap = sata_dev->ap;
+	struct ata_link *link = &ap->link;
+	struct sas_phy *phy;
+	int ret;
 
 	phy = sas_get_local_phy(dev);
 	if (scsi_is_sas_phy_local(phy))
@@ -386,6 +378,27 @@ static int sas_ata_hard_reset(struct ata_link *link, unsigned int *class,
 	if (ret && ret != -EAGAIN)
 		sas_ata_printk(KERN_ERR, dev, "reset failed (errno=%d)\n", ret);
 
+	return ret;
+}
+EXPORT_SYMBOL_GPL(sas_ata_wait_after_reset);
+
+static int sas_ata_hard_reset(struct ata_link *link, unsigned int *class,
+			      unsigned long deadline)
+{
+	struct ata_port *ap = link->ap;
+	struct domain_device *dev = ap->private_data;
+	struct sas_internal *i = dev_to_sas_internal(dev);
+	int ret;
+
+	ret = i->dft->lldd_I_T_nexus_reset(dev);
+	if (ret == -ENODEV)
+		return ret;
+
+	if (ret != TMF_RESP_FUNC_COMPLETE)
+		sas_ata_printk(KERN_DEBUG, dev, "Unable to reset ata device?\n");
+
+	ret = sas_ata_wait_after_reset(dev, deadline);
+
 	*class = dev->sata_dev.class;
 
 	ap->cbl = ATA_CBL_SATA;
diff --git a/include/scsi/sas_ata.h b/include/scsi/sas_ata.h
index d47dea70855d..a1df4f9d57a3 100644
--- a/include/scsi/sas_ata.h
+++ b/include/scsi/sas_ata.h
@@ -34,6 +34,7 @@ void sas_resume_sata(struct asd_sas_port *port);
 void sas_ata_end_eh(struct ata_port *ap);
 int sas_execute_ata_cmd(struct domain_device *device, u8 *fis,
 			int force_phy_id);
+int sas_ata_wait_after_reset(struct domain_device *dev, unsigned long deadline);
 #else
 
 
@@ -91,6 +92,12 @@ static inline int sas_execute_ata_cmd(struct domain_device *device, u8 *fis,
 {
 	return 0;
 }
+
+static inline int sas_ata_wait_after_reset(struct domain_device *dev,
+					   unsigned long deadline)
+{
+	return -ETIMEDOUT;
+}
 #endif
 
 #endif /* _SAS_ATA_H_ */
-- 
2.26.2

