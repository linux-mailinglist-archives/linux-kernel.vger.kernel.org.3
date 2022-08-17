Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3FA6597234
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 17:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239929AbiHQO6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 10:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbiHQO6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 10:58:35 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A20F2F64D;
        Wed, 17 Aug 2022 07:58:34 -0700 (PDT)
Received: from fraeml705-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4M79xt2j7bz67MfB;
        Wed, 17 Aug 2022 22:53:38 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Wed, 17 Aug 2022 16:58:32 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 17 Aug 2022 15:58:29 +0100
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <jinpu.wang@cloud.ionos.com>, <damien.lemoal@opensource.wdc.com>,
        <yangxingui@huawei.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <hare@suse.de>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH v2 0/6] libsas and drivers: NCQ error handling
Date:   Wed, 17 Aug 2022 22:52:08 +0800
Message-ID: <1660747934-60059-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

As reported in [0], the pm8001 driver NCQ error handling more or less
duplicates what libata does in link error handling, as follows:
- abort all commands
- do autopsy with read log ext 10 command
- reset the target to recover

Indeed for the hisi_sas driver we want to add similar handling for NCQ
errors.

This series add a new libsas API - sas_ata_device_link_abort() - to handle
host NCQ errors, and fixes up pm8001 and hisi_sas drivers to use it. As
mentioned in the pm8001 changeover patch, I would prefer a better place to
locate the SATA ABORT command (rather that nexus reset callback).

Damien kindly tested the v1 series for pm8001, but any further pm8001
testing would be appreciated as I have since tweaked
sas_ata_device_link_abort(). This is because the pm8001 driver hangs on my
arm64 machine read log ext10 command.

Finally with these changes we can make the libsas task alloc/free APIs
private, which they should always have been.

Based on v6.0-rc1

[0] https://lore.kernel.org/linux-scsi/8fb3b093-55f0-1fab-81f4-e8519810a978@huawei.com/

Changes since v1:
- Rename sas_ata_link_abort() -> sas_ata_device_link_abort()
- Set EH RESET flag in sas_ata_device_link_abort()
- Add Jack's Ack tags
- Rebase

John Garry (5):
  scsi: pm8001: Modify task abort handling for SATA task
  scsi: libsas: Add sas_ata_device_link_abort()
  scsi: pm8001: Use sas_ata_device_link_abort() to handle NCQ errors
  scsi: hisi_sas: Don't issue ATA softreset in hisi_sas_abort_task()
  scsi: libsas: Make sas_{alloc, alloc_slow, free}_task() private

Xingui Yang (1):
  scsi: hisi_sas: Add SATA_DISK_ERR bit handling for v3 hw

 drivers/scsi/hisi_sas/hisi_sas_main.c  |   5 +-
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c |  22 ++-
 drivers/scsi/libsas/sas_ata.c          |  11 ++
 drivers/scsi/libsas/sas_init.c         |   3 -
 drivers/scsi/libsas/sas_internal.h     |   4 +
 drivers/scsi/pm8001/pm8001_hwi.c       | 194 +++++++------------------
 drivers/scsi/pm8001/pm8001_sas.c       |  13 ++
 drivers/scsi/pm8001/pm8001_sas.h       |   8 +-
 drivers/scsi/pm8001/pm80xx_hwi.c       | 177 ++--------------------
 include/scsi/libsas.h                  |   4 -
 include/scsi/sas_ata.h                 |   5 +
 11 files changed, 133 insertions(+), 313 deletions(-)

-- 
2.35.3

