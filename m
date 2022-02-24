Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D21C4C2B4F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 12:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234181AbiBXL6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 06:58:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234222AbiBXL56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 06:57:58 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5040BFA205;
        Thu, 24 Feb 2022 03:57:17 -0800 (PST)
Received: from fraeml706-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4K4BFQ6pP7z685Ym;
        Thu, 24 Feb 2022 19:56:10 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml706-chm.china.huawei.com (10.206.15.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.21; Thu, 24 Feb 2022 12:57:15 +0100
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 24 Feb 2022 11:57:12 +0000
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Xingui Yang <yangxingui@huawei.com>,
        Qi Liu <liuqi115@huawei.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 6/6] scsi: hisi_sas: Modify v3 HW SSP underflow error processing
Date:   Thu, 24 Feb 2022 19:51:29 +0800
Message-ID: <1645703489-87194-7-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1645703489-87194-1-git-send-email-john.garry@huawei.com>
References: <1645703489-87194-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

From: Xingui Yang <yangxingui@huawei.com>

In case of SSP underflow allow the response frame IU to be examined for
setting the response stat value rather than always setting
SAS_DATA_UNDERRUN.

This will mean that we call sas_ssp_task_response() in those scenarios
and may send sense data to upper layer.

Such a condition would be for bad blocks were we just reporting an
underflow error to upper layer, but now the sense data will tell
immediately that the media is faulty.

Signed-off-by: Xingui Yang <yangxingui@huawei.com>
Signed-off-by: Qi Liu <liuqi115@huawei.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 39 +++++++++++++++++---------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index ad3e2db0f520..914ae4e82f5e 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -406,6 +406,8 @@
 #define CMPLT_HDR_ERROR_PHASE_MSK   (0xff << CMPLT_HDR_ERROR_PHASE_OFF)
 #define CMPLT_HDR_RSPNS_XFRD_OFF	10
 #define CMPLT_HDR_RSPNS_XFRD_MSK	(0x1 << CMPLT_HDR_RSPNS_XFRD_OFF)
+#define CMPLT_HDR_RSPNS_GOOD_OFF	11
+#define CMPLT_HDR_RSPNS_GOOD_MSK	(0x1 << CMPLT_HDR_RSPNS_GOOD_OFF)
 #define CMPLT_HDR_ERX_OFF		12
 #define CMPLT_HDR_ERX_MSK		(0x1 << CMPLT_HDR_ERX_OFF)
 #define CMPLT_HDR_ABORT_STAT_OFF	13
@@ -2140,7 +2142,7 @@ static irqreturn_t fatal_axi_int_v3_hw(int irq_no, void *p)
 	return IRQ_HANDLED;
 }
 
-static void
+static bool
 slot_err_v3_hw(struct hisi_hba *hisi_hba, struct sas_task *task,
 	       struct hisi_sas_slot *slot)
 {
@@ -2158,6 +2160,15 @@ slot_err_v3_hw(struct hisi_hba *hisi_hba, struct sas_task *task,
 	switch (task->task_proto) {
 	case SAS_PROTOCOL_SSP:
 		if (dma_rx_err_type & RX_DATA_LEN_UNDERFLOW_MSK) {
+			/*
+			 * If returned response frame is incorrect because of data underflow,
+			 * but I/O information has been written to the host memory, we examine
+			 * response IU.
+			 */
+			if (!(complete_hdr->dw0 & CMPLT_HDR_RSPNS_GOOD_MSK) &&
+				(complete_hdr->dw0 & CMPLT_HDR_RSPNS_XFRD_MSK))
+				return false;
+
 			ts->residual = trans_tx_fail_type;
 			ts->stat = SAS_DATA_UNDERRUN;
 		} else if (dw3 & CMPLT_HDR_IO_IN_TARGET_MSK) {
@@ -2189,6 +2200,7 @@ slot_err_v3_hw(struct hisi_hba *hisi_hba, struct sas_task *task,
 	default:
 		break;
 	}
+	return true;
 }
 
 static void slot_complete_v3_hw(struct hisi_hba *hisi_hba,
@@ -2262,19 +2274,20 @@ static void slot_complete_v3_hw(struct hisi_hba *hisi_hba,
 	if ((dw0 & CMPLT_HDR_CMPLT_MSK) == 0x3) {
 		u32 *error_info = hisi_sas_status_buf_addr_mem(slot);
 
-		slot_err_v3_hw(hisi_hba, task, slot);
-		if (ts->stat != SAS_DATA_UNDERRUN)
-			dev_info(dev, "erroneous completion iptt=%d task=%pK dev id=%d addr=%016llx CQ hdr: 0x%x 0x%x 0x%x 0x%x Error info: 0x%x 0x%x 0x%x 0x%x\n",
-				 slot->idx, task, sas_dev->device_id,
-				 SAS_ADDR(device->sas_addr),
-				 dw0, dw1, complete_hdr->act, dw3,
-				 error_info[0], error_info[1],
-				 error_info[2], error_info[3]);
-		if (unlikely(slot->abort)) {
-			sas_task_abort(task);
-			return;
+		if (slot_err_v3_hw(hisi_hba, task, slot)) {
+			if (ts->stat != SAS_DATA_UNDERRUN)
+				dev_info(dev, "erroneous completion iptt=%d task=%pK dev id=%d addr=%016llx CQ hdr: 0x%x 0x%x 0x%x 0x%x Error info: 0x%x 0x%x 0x%x 0x%x\n",
+					slot->idx, task, sas_dev->device_id,
+					SAS_ADDR(device->sas_addr),
+					dw0, dw1, complete_hdr->act, dw3,
+					error_info[0], error_info[1],
+					error_info[2], error_info[3]);
+			if (unlikely(slot->abort)) {
+				sas_task_abort(task);
+				return;
+			}
+			goto out;
 		}
-		goto out;
 	}
 
 	switch (task->task_proto) {
-- 
2.26.2

