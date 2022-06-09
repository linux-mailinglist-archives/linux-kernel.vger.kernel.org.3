Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5ACF5448F9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 12:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234905AbiFIKgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 06:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233351AbiFIKgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 06:36:01 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 542CE31536;
        Thu,  9 Jun 2022 03:35:59 -0700 (PDT)
Received: from fraeml738-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LJgNr6RXCz682sD;
        Thu,  9 Jun 2022 18:31:08 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml738-chm.china.huawei.com (10.206.15.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 9 Jun 2022 12:35:56 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 9 Jun 2022 11:35:53 +0100
From:   John Garry <john.garry@huawei.com>
To:     <axboe@kernel.dk>, <damien.lemoal@opensource.wdc.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <brking@us.ibm.com>, <hare@suse.de>, <hch@lst.de>
CC:     <linux-block@vger.kernel.org>, <linux-ide@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <chenxiang66@hisilicon.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH RFC v2 00/18] blk-mq/libata/scsi: SCSI driver tagging improvements
Date:   Thu, 9 Jun 2022 18:29:01 +0800
Message-ID: <1654770559-101375-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

Currently SCSI low-level drivers are required to manage tags for commands
which do not come via the block layer - libata internal commands would be
an example of one of these. We want to make blk-mq manage these tags also.

There was some work to provide "reserved commands" support in such series
as https://lore.kernel.org/linux-scsi/20211125151048.103910-1-hare@suse.de/

This was based on allocating a request for the lifetime of the "internal"
command.

This series tries to solve that problem by not just allocating the request
but also sending it as a request through the block layer. Reasons to do
this:
- Normal flow of a request and also commonality for regular scsi command
  lifetime
- We don't leave request and scsi_cmnd fields dangling as when we just
  allocate and free the request for the lifetime of the "internal" command
- For poll mode support we can only poll in block layer, so could not send
  internal commands on poll mode queues if we did not do this, which is a
  problem
- Can get rid of duplicated code like libsas internal command timeout
  handling

Based on v5.19-rc1

Please consider as an PoC for now. I have broken builds, bisectablility,
and functionality for a lot of libsas drivers, like pm8001. Indeed, 
10/18 onwards need a lot of work...

Testing:
QEMU with AHCI with disk and cdrom attached and hisi_sas v2 both boot.

v1 was sent here:
https://lore.kernel.org/linux-scsi/1647945585-197349-1-git-send-email-john.garry@huawei.com/

Hannes Reinecke (1):
  scsi: core: Implement reserved command handling

John Garry (17):
  blk-mq: Add a flag for reserved requests
  scsi: core: Resurrect scsi_{get,free}_host_dev()
  scsi: core: Add support to send reserved commands
  scsi: core: Allocate SCSI host sdev when required
  libata-scsi: Add ata_scsi_queue_internal()
  libata-scsi: Add ata_internal_queuecommand()
  libata: Queue ATA internal commands as requests
  scsi: ipr: Support reserved commands
  libata/scsi: libsas: Add sas_queuecommand_internal()
  scsi: libsas: Don't attempt to find scsi host rphy in slave alloc
  scsi: libsas drivers: Prepare for reserved commands
  scsi: libsas: Allocate SCSI commands for tasks
  scsi: libsas: Queue SMP commands as requests
  scsi: libsas: Queue TMF commands as requests
  scsi: core: Add scsi_alloc_request_hwq()
  scsi: libsas: Queue internal abort commands as requests
  scsi: libsas drivers: Remove private tag management

 block/blk-mq.c                         |   6 +
 drivers/ata/libata-core.c              | 145 +++++++++++++++----------
 drivers/ata/libata-sata.c              |   5 +-
 drivers/ata/libata-scsi.c              |  61 ++++++++++-
 drivers/ata/libata.h                   |   4 -
 drivers/scsi/hisi_sas/hisi_sas_main.c  |  93 ++++------------
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c |   6 +-
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c |   3 +-
 drivers/scsi/hosts.c                   |  14 +++
 drivers/scsi/ipr.c                     |  17 ++-
 drivers/scsi/libsas/sas_ata.c          |  22 ++--
 drivers/scsi/libsas/sas_expander.c     |  24 ++--
 drivers/scsi/libsas/sas_init.c         |  74 ++++++++-----
 drivers/scsi/libsas/sas_internal.h     |   6 +
 drivers/scsi/libsas/sas_scsi_host.c    | 121 +++++++++++++++------
 drivers/scsi/scsi_lib.c                |  50 ++++++++-
 drivers/scsi/scsi_scan.c               |  57 ++++++++++
 include/linux/blk-mq.h                 |   6 +
 include/linux/libata.h                 |  13 ++-
 include/scsi/libsas.h                  |  57 +++++++++-
 include/scsi/scsi_cmnd.h               |   8 ++
 include/scsi/scsi_host.h               |  34 +++++-
 22 files changed, 597 insertions(+), 229 deletions(-)

-- 
2.26.2

