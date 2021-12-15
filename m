Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50F38475AE6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 15:44:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243565AbhLOOna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 09:43:30 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4293 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243487AbhLOOnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 09:43:20 -0500
Received: from fraeml737-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JDdGY2Sgnz67vyR;
        Wed, 15 Dec 2021 22:41:09 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml737-chm.china.huawei.com (10.206.15.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 15 Dec 2021 15:43:18 +0100
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 15 Dec 2021 14:43:15 +0000
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH 8/8] scsi: libsas: Decode SAM status and host byte codes
Date:   Wed, 15 Dec 2021 22:37:41 +0800
Message-ID: <1639579061-179473-9-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1639579061-179473-1-git-send-email-john.garry@huawei.com>
References: <1639579061-179473-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Value 0 is used for SAM status and libsas exec_status bytes codes in
sas_end_task() - use defined macros instead. In addition, change to
proper enum types.

Also replace SAM_STAT_CHECK_CONDITION with SAS_SAM_STAT_CHECK_CONDITION,
the former being a proper member of enum exec_status.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/libsas/sas_scsi_host.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/libsas/sas_scsi_host.c b/drivers/scsi/libsas/sas_scsi_host.c
index d337fdf1b9ca..fb19e739a39c 100644
--- a/drivers/scsi/libsas/sas_scsi_host.c
+++ b/drivers/scsi/libsas/sas_scsi_host.c
@@ -37,7 +37,8 @@
 static void sas_end_task(struct scsi_cmnd *sc, struct sas_task *task)
 {
 	struct task_status_struct *ts = &task->task_status;
-	int hs = 0, stat = 0;
+	enum scsi_host_status hs = DID_OK;
+	enum exec_status stat = SAS_SAM_STAT_GOOD;
 
 	if (ts->resp == SAS_TASK_UNDELIVERED) {
 		/* transport error */
@@ -82,10 +83,10 @@ static void sas_end_task(struct scsi_cmnd *sc, struct sas_task *task)
 		case SAS_ABORTED_TASK:
 			hs = DID_ABORT;
 			break;
-		case SAM_STAT_CHECK_CONDITION:
+		case SAS_SAM_STAT_CHECK_CONDITION:
 			memcpy(sc->sense_buffer, ts->buf,
 			       min(SCSI_SENSE_BUFFERSIZE, ts->buf_valid_size));
-			stat = SAM_STAT_CHECK_CONDITION;
+			stat = SAS_SAM_STAT_CHECK_CONDITION;
 			break;
 		default:
 			stat = ts->stat;
-- 
2.26.2

