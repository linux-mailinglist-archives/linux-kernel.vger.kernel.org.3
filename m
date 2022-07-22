Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED7857E0D8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 13:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234621AbiGVLbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 07:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234615AbiGVLaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 07:30:46 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872B577A71;
        Fri, 22 Jul 2022 04:30:42 -0700 (PDT)
Received: from fraeml742-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Lq6bb6NhCz67NZt;
        Fri, 22 Jul 2022 19:27:07 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml742-chm.china.huawei.com (10.206.15.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 22 Jul 2022 13:30:39 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 22 Jul 2022 12:30:36 +0100
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <jinpu.wang@cloud.ionos.com>, <damien.lemoal@opensource.wdc.com>,
        <yangxingui@huawei.com>, <chenxiang66@hisilicon.com>,
        <hare@suse.de>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 5/6] scsi: hisi_sas: Add SATA_DISK_ERR bit handling for v3 hw
Date:   Fri, 22 Jul 2022 19:24:08 +0800
Message-ID: <1658489049-232850-6-git-send-email-john.garry@huawei.com>
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

From: Xingui Yang <yangxingui@huawei.com>

When CQ header dw3 SATA_DISK_ERR is set it means this SATA disk is in error
state and the current IPTT is invalid. An invalid IPTT does not correspond
to any slot.

In this scenario, new I/Os that delivered to disk will be rejected by the,
controller and all I/Os remained on the disk should be aborted, which we
add here with the sas_ata_link_abort() call.

Signed-off-by: Xingui Yang <yangxingui@huawei.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index eb86afb21aab..7be3ea23f170 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -423,6 +423,8 @@
 #define CMPLT_HDR_DEV_ID_OFF		16
 #define CMPLT_HDR_DEV_ID_MSK		(0xffff << CMPLT_HDR_DEV_ID_OFF)
 /* dw3 */
+#define CMPLT_HDR_SATA_DISK_ERR_OFF	16
+#define CMPLT_HDR_SATA_DISK_ERR_MSK	(0x1 << CMPLT_HDR_SATA_DISK_ERR_OFF)
 #define CMPLT_HDR_IO_IN_TARGET_OFF	17
 #define CMPLT_HDR_IO_IN_TARGET_MSK	(0x1 << CMPLT_HDR_IO_IN_TARGET_OFF)
 
@@ -2379,14 +2381,30 @@ static irqreturn_t  cq_thread_v3_hw(int irq_no, void *p)
 	while (rd_point != wr_point) {
 		struct hisi_sas_complete_v3_hdr *complete_hdr;
 		struct device *dev = hisi_hba->dev;
-		u32 dw1;
+		u32 dw0, dw1, dw3;
 		int iptt;
 
 		complete_hdr = &complete_queue[rd_point];
+		dw0 = le32_to_cpu(complete_hdr->dw0);
 		dw1 = le32_to_cpu(complete_hdr->dw1);
+		dw3 = le32_to_cpu(complete_hdr->dw3);
 
 		iptt = dw1 & CMPLT_HDR_IPTT_MSK;
-		if (likely(iptt < HISI_SAS_COMMAND_ENTRIES_V3_HW)) {
+		if (unlikely((dw0 & CMPLT_HDR_CMPLT_MSK) == 0x3) &&
+			     (dw3 & CMPLT_HDR_SATA_DISK_ERR_MSK)) {
+			int device_id = (dw1 & CMPLT_HDR_DEV_ID_MSK) >>
+					CMPLT_HDR_DEV_ID_OFF;
+			struct hisi_sas_itct *itct =
+				&hisi_hba->itct[device_id];
+			struct hisi_sas_device *sas_dev =
+				&hisi_hba->devices[device_id];
+			struct domain_device *device = sas_dev->sas_device;
+
+			dev_err(dev, "erroneous completion disk err dev id=%d sas_addr=0x%llx CQ hdr: 0x%x 0x%x 0x%x 0x%x\n",
+				device_id, itct->sas_addr, dw0, dw1,
+				complete_hdr->act, dw3);
+			sas_ata_link_abort(device);
+		} else if (likely(iptt < HISI_SAS_COMMAND_ENTRIES_V3_HW)) {
 			slot = &hisi_hba->slot_info[iptt];
 			slot->cmplt_queue_slot = rd_point;
 			slot->cmplt_queue = queue;
-- 
2.35.3

