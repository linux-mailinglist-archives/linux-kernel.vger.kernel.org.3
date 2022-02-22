Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 793814BF88B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 13:57:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbiBVM5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 07:57:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232057AbiBVM51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 07:57:27 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F3F195A14;
        Tue, 22 Feb 2022 04:56:49 -0800 (PST)
Received: from fraeml705-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4K2zg62QB0z67y8J;
        Tue, 22 Feb 2022 20:55:46 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.21; Tue, 22 Feb 2022 13:56:47 +0100
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 22 Feb 2022 12:56:44 +0000
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <artur.paszkiewicz@intel.com>, <jinpu.wang@cloud.ionos.com>,
        <chenxiang66@hisilicon.com>, <damien.lemoal@opensource.wdc.com>,
        <hch@lst.de>
CC:     <Ajish.Koshy@microchip.com>, <yanaijie@huawei.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, <linuxarm@huawei.com>,
        <liuqi115@huawei.com>, <Viswas.G@microchip.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH v3 04/18] scsi: libsas: Delete SAS_SG_ERR
Date:   Tue, 22 Feb 2022 20:50:45 +0800
Message-ID: <1645534259-27068-5-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1645534259-27068-1-git-send-email-john.garry@huawei.com>
References: <1645534259-27068-1-git-send-email-john.garry@huawei.com>
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

No LLDD sets exec status as SAS_SG_ERR, so remove support.

Signed-off-by: John Garry <john.garry@huawei.com>
Tested-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/scsi/libsas/sas_ata.c       | 2 --
 drivers/scsi/libsas/sas_scsi_host.c | 3 ---
 include/scsi/libsas.h               | 1 -
 3 files changed, 6 deletions(-)

diff --git a/drivers/scsi/libsas/sas_ata.c b/drivers/scsi/libsas/sas_ata.c
index e0030a093994..71b42fe95b6f 100644
--- a/drivers/scsi/libsas/sas_ata.c
+++ b/drivers/scsi/libsas/sas_ata.c
@@ -52,8 +52,6 @@ static enum ata_completion_errors sas_to_ata_err(struct task_status_struct *ts)
 	case SAS_DATA_OVERRUN:
 	case SAS_QUEUE_FULL:
 	case SAS_DEVICE_UNKNOWN:
-	case SAS_SG_ERR:
-		return AC_ERR_INVALID;
 	case SAS_OPEN_TO:
 	case SAS_OPEN_REJECT:
 		pr_warn("%s: Saw error %d.  What to do?\n",
diff --git a/drivers/scsi/libsas/sas_scsi_host.c b/drivers/scsi/libsas/sas_scsi_host.c
index 19cb954afd80..387083a16a79 100644
--- a/drivers/scsi/libsas/sas_scsi_host.c
+++ b/drivers/scsi/libsas/sas_scsi_host.c
@@ -67,9 +67,6 @@ static void sas_end_task(struct scsi_cmnd *sc, struct sas_task *task)
 		case SAS_DEVICE_UNKNOWN:
 			hs = DID_BAD_TARGET;
 			break;
-		case SAS_SG_ERR:
-			hs = DID_PARITY;
-			break;
 		case SAS_OPEN_REJECT:
 			if (ts->open_rej_reason == SAS_OREJ_RSVD_RETRY)
 				hs = DID_SOFT_ERROR; /* retry */
diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
index 8026c1bb57ba..cd2b2b67bf93 100644
--- a/include/scsi/libsas.h
+++ b/include/scsi/libsas.h
@@ -492,7 +492,6 @@ enum exec_status {
 	SAS_INTERRUPTED,
 	SAS_QUEUE_FULL,
 	SAS_DEVICE_UNKNOWN,
-	SAS_SG_ERR,
 	SAS_OPEN_REJECT,
 	SAS_OPEN_TO,
 	SAS_PROTO_RESPONSE,
-- 
2.26.2

