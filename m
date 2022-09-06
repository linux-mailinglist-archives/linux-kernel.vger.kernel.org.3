Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60A0E5AEFBF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 18:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236485AbiIFP5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 11:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238522AbiIFPzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 11:55:44 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74A81E3E0;
        Tue,  6 Sep 2022 08:14:53 -0700 (PDT)
Received: from fraeml715-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MMTSK1Z7Wz67xfT;
        Tue,  6 Sep 2022 23:14:09 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml715-chm.china.huawei.com (10.206.15.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 6 Sep 2022 17:14:51 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 6 Sep 2022 16:14:48 +0100
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <jinpu.wang@cloud.ionos.com>, <damien.lemoal@opensource.wdc.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <yangxingui@huawei.com>, <hare@suse.de>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH v3 5/6] scsi: hisi_sas: Add SATA_DISK_ERR bit handling for v3 hw
Date:   Tue, 6 Sep 2022 23:08:09 +0800
Message-ID: <1662476890-15467-6-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1662476890-15467-1-git-send-email-john.garry@huawei.com>
References: <1662476890-15467-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

From: Xingui Yang <yangxingui@huawei.com>

When CQ header dw3 SATA_DISK_ERR is set it means this SATA disk is in error
state and the current IPTT is invalid. An invalid IPTT does not correspond
to any slot.

In this scenario, new I/Os that delivered to disk will be rejected by the,
controller and all I/Os remained on the disk should be aborted, which we
add here with the sas_ata_device_link_abort() call.

Signed-off-by: Xingui Yang <yangxingui@huawei.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index efe8c5be5870..a469712ed447 100644
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
 
@@ -2384,14 +2386,30 @@ static irqreturn_t  cq_thread_v3_hw(int irq_no, void *p)
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
+			sas_ata_device_link_abort(device, true);
+		} else if (likely(iptt < HISI_SAS_COMMAND_ENTRIES_V3_HW)) {
 			slot = &hisi_hba->slot_info[iptt];
 			slot->cmplt_queue_slot = rd_point;
 			slot->cmplt_queue = queue;
-- 
2.35.3

