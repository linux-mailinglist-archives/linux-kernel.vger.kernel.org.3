Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19BC45754FD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 20:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240682AbiGNS3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 14:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240668AbiGNS3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 14:29:48 -0400
Received: from sinmsgout01.his.huawei.com (sinmsgout01.his.huawei.com [119.8.177.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E61275EF;
        Thu, 14 Jul 2022 11:29:47 -0700 (PDT)
Received: from fraeml735-chm.china.huawei.com (unknown [172.18.156.147])
        by sinmsgout01.his.huawei.com (SkyGuard) with ESMTP id 4LkNFH681bz9xF8q;
        Fri, 15 Jul 2022 02:24:51 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml735-chm.china.huawei.com (10.206.15.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 14 Jul 2022 20:29:41 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 14 Jul 2022 19:29:39 +0100
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH 1/5] scsi: hisi_sas: Call hisi_sas_slave_configure() from slave_configure_v3_hw()
Date:   Fri, 15 Jul 2022 02:23:18 +0800
Message-ID: <1657823002-139010-2-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1657823002-139010-1-git-send-email-john.garry@huawei.com>
References: <1657823002-139010-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is duplicated code between slave_configure_v3_hw() and
hisi_sas_slave_configure(), so call common function
hisi_sas_slave_configure() from slave_configure_v3_hw().

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index eb86afb21aab..76c4173e277d 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -2778,16 +2778,13 @@ static DEVICE_ATTR_RW(intr_coal_count_v3_hw);
 static int slave_configure_v3_hw(struct scsi_device *sdev)
 {
 	struct Scsi_Host *shost = dev_to_shost(&sdev->sdev_gendev);
-	struct domain_device *ddev = sdev_to_domain_dev(sdev);
 	struct hisi_hba *hisi_hba = shost_priv(shost);
+	int ret = hisi_sas_slave_configure(sdev);
 	struct device *dev = hisi_hba->dev;
-	int ret = sas_slave_configure(sdev);
 	unsigned int max_sectors;
 
 	if (ret)
 		return ret;
-	if (!dev_is_sata(ddev))
-		sas_change_queue_depth(sdev, 64);
 
 	if (sdev->type == TYPE_ENCLOSURE)
 		return 0;
-- 
2.35.3

