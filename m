Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 063275AEFB3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 18:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238739AbiIFP5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 11:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233902AbiIFPzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 11:55:44 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B32432FFCC;
        Tue,  6 Sep 2022 08:14:50 -0700 (PDT)
Received: from fraeml713-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MMTNR0xqgz67D3d;
        Tue,  6 Sep 2022 23:10:47 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml713-chm.china.huawei.com (10.206.15.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 6 Sep 2022 17:14:48 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 6 Sep 2022 16:14:46 +0100
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <jinpu.wang@cloud.ionos.com>, <damien.lemoal@opensource.wdc.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <yangxingui@huawei.com>, <hare@suse.de>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH v3 4/6] scsi: hisi_sas: Don't issue ATA softreset in hisi_sas_abort_task()
Date:   Tue, 6 Sep 2022 23:08:08 +0800
Message-ID: <1662476890-15467-5-git-send-email-john.garry@huawei.com>
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

It is not necessary to issue an ATA softreset in hisi_sas_abort_task().
This is because in the libsas EH scheme we will defer to ATA EH which will
deal with any device reset during recovery.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas_main.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index 33af5b8dede2..2fe5290ac56c 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -1598,13 +1598,16 @@ static int hisi_sas_abort_task(struct sas_task *task)
 	} else if (task->task_proto & SAS_PROTOCOL_SATA ||
 		task->task_proto & SAS_PROTOCOL_STP) {
 		if (task->dev->dev_type == SAS_SATA_DEV) {
+			struct hisi_sas_slot *slot = task->lldd_task;
+
+			slot->task = NULL;
 			rc = hisi_sas_internal_task_abort_dev(sas_dev, false);
 			if (rc < 0) {
 				dev_err(dev, "abort task: internal abort failed\n");
 				goto out;
 			}
 			hisi_sas_dereg_device(hisi_hba, device);
-			rc = hisi_sas_softreset_ata_disk(device);
+			rc = TMF_RESP_FUNC_COMPLETE;
 		}
 	} else if (task->lldd_task && task->task_proto & SAS_PROTOCOL_SMP) {
 		/* SMP */
-- 
2.35.3

