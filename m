Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3DC4C2B4A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 12:58:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234151AbiBXL5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 06:57:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233759AbiBXL5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 06:57:33 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76EEC3BBC2;
        Thu, 24 Feb 2022 03:57:03 -0800 (PST)
Received: from fraeml715-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4K4BF85RLTz67xDf;
        Thu, 24 Feb 2022 19:55:56 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml715-chm.china.huawei.com (10.206.15.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 24 Feb 2022 12:57:01 +0100
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 24 Feb 2022 11:56:58 +0000
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH 0/6] hisi_sas: Some misc updates
Date:   Thu, 24 Feb 2022 19:51:23 +0800
Message-ID: <1645703489-87194-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
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

Hi Martin,

This series includes some updates as following:
- better management of freeing PCI vectors
  - hopefully the following series can make it soon so we may remove this
    new code:
    https://lore.kernel.org/linux-pci/20210607153916.1021016-1-zhengdejin5@gmail.com/T/#md27a594ac53b8e05abb2f22ec350137b9023ff18
- Fix prot_mask module param permissions
- Change phyup timeout to handle some special SATA disks
- modify underflow handling to quickly identify faulty disks
- debugfs hardening

Please consider for 5.18 - hopefully not too late

Thanks!

Qi Liu (2):
  scsi: hisi_sas: Free irq vectors in order for v3 HW
  scsi: hisi_sas: Rename error labels in hisi_sas_v3_probe()

Xiang Chen (3):
  scsi: hisi_sas: Change permission of parameter prot_mask
  scsi: hisi_sas: Change hisi_sas_control_phy() phyup timeout
  scsi: hisi_sas: Limit users changing debugfs BIST count value

Xingui Yang (1):
  scsi: hisi_sas: Modify v3 HW SSP underflow error processing

 drivers/scsi/hisi_sas/hisi_sas.h       |   2 +-
 drivers/scsi/hisi_sas/hisi_sas_main.c  |   3 +-
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 127 +++++++++++++++++++------
 3 files changed, 100 insertions(+), 32 deletions(-)

-- 
2.26.2

