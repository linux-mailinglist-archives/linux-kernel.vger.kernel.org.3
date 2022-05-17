Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E79C0529BD4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 10:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234864AbiEQIKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 04:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239899AbiEQIKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 04:10:38 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D24643C73E;
        Tue, 17 May 2022 01:10:37 -0700 (PDT)
Received: from fraeml707-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4L2THp2D8xz6H8FG;
        Tue, 17 May 2022 16:07:34 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml707-chm.china.huawei.com (10.206.15.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 17 May 2022 10:10:35 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 17 May 2022 09:10:27 +0100
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH] scsi: hisi_sas: Fix memory ordering in hisi_sas_task_deliver()
Date:   Tue, 17 May 2022 16:04:21 +0800
Message-ID: <1652774661-12935-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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

The memories for the slot should be observed to be written prior to
observing the slot as ready.

Prior to commit 26fc0ea74fcb ("scsi: libsas: Drop SAS_TASK_AT_INITIATOR"),
we had a spin_lock() + spin_unlock() immediately before marking the slot
as ready. The spin_unlock() - with release semantics - caused the slot
memory to be observed to be written.

Now that the spin_lock() + spin_unlock() is gone, use a smp_wmb().

Fixes: 26fc0ea74fcb ("scsi: libsas: Drop SAS_TASK_AT_INITIATOR")
Reported-by: Yihang Li <liyihang6@hisilicon.com>
Tested-by: Yihang Li <liyihang6@hisilicon.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
Hi Martin, Please consider for v5.18, thanks!

diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index 4bda2f6cb352..f56dd01230ce 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -446,6 +446,8 @@ void hisi_sas_task_deliver(struct hisi_hba *hisi_hba,
 		return;
 	}
 
+	/* Make slot memories observable before marking as ready */
+	smp_wmb();
 	WRITE_ONCE(slot->ready, 1);
 
 	spin_lock(&dq->lock);
-- 
2.26.2

