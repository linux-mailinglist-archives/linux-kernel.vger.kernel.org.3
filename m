Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12BBC5972FA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 17:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240209AbiHQP0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 11:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235568AbiHQP0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 11:26:32 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA315EDC2;
        Wed, 17 Aug 2022 08:26:30 -0700 (PDT)
Received: from fraeml739-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4M7BZ61jJJz67Hfl;
        Wed, 17 Aug 2022 23:21:34 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml739-chm.china.huawei.com (10.206.15.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 17 Aug 2022 17:26:28 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 17 Aug 2022 16:26:26 +0100
From:   John Garry <john.garry@huawei.com>
To:     <damien.lemoal@opensource.wdc.com>, <oliver.sang@intel.com>
CC:     <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, <martin.petersen@oracle.com>,
        <hch@lst.de>, John Garry <john.garry@huawei.com>
Subject: [RFT PATCH] ata: libata: Set __ATA_BASE_SHT max_sectors
Date:   Wed, 17 Aug 2022 23:20:08 +0800
Message-ID: <1660749608-62897-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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

Commit 0568e6122574 ("ata: libata-scsi: cap ata_device->max_sectors
according to shost->max_sectors") inadvertently capped the max_sectors
value for some SATA disks to a value which is lower than we would want.

For a device which supports LBA48, we would previously have request queue
max_sectors_kb and max_hw_sectors_kb values of 1280 and 32767 respectively.

For AHCI controllers, the value chosen for shost max sectors comes from
the minimum of the SCSI host default max sectors in
SCSI_DEFAULT_MAX_SECTORS (1024) and the shost DMA device mapping limit.

This means that we would now set the max_sectors_kb and max_hw_sectors_kb
values for a disk which supports LBA48 at 512, ignoring DMA mapping limit.

As report by Oliver at [0], this caused a performance regression.

Fix by picking a large enough max sectors value for ATA host controllers
such that we don't needlessly reduce max_sectors_kb for LBA48 disks.

[0] https://lore.kernel.org/linux-ide/YvsGbidf3na5FpGb@xsang-OptiPlex-9020/T/#m22d9fc5ad15af66066dd9fecf3d50f1b1ef11da3

Fixes: 0568e6122574 ("ata: libata-scsi: cap ata_device->max_sectors according to shost->max_sectors")
Reported-by: Oliver Sang <oliver.sang@intel.com>
Signed-off-by: John Garry <john.garry@huawei.com>

diff --git a/include/linux/libata.h b/include/linux/libata.h
index 0269ff114f5a..698032e5ef2d 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1382,7 +1382,8 @@ extern const struct attribute_group *ata_common_sdev_groups[];
 	.proc_name		= drv_name,			\
 	.slave_destroy		= ata_scsi_slave_destroy,	\
 	.bios_param		= ata_std_bios_param,		\
-	.unlock_native_capacity	= ata_scsi_unlock_native_capacity
+	.unlock_native_capacity	= ata_scsi_unlock_native_capacity,\
+	.max_sectors		= ATA_MAX_SECTORS_LBA48
 
 #define ATA_SUBBASE_SHT(drv_name)				\
 	__ATA_BASE_SHT(drv_name),				\
-- 
2.35.3

