Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4FC574BB8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 13:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238449AbiGNLWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 07:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbiGNLWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 07:22:15 -0400
X-Greylist: delayed 12585 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 14 Jul 2022 04:22:10 PDT
Received: from sinmsgout03.his.huawei.com (sinmsgout03.his.huawei.com [119.8.177.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB6B6481DE;
        Thu, 14 Jul 2022 04:22:10 -0700 (PDT)
Received: from fraeml742-chm.china.huawei.com (unknown [172.18.156.207])
        by sinmsgout03.his.huawei.com (SkyGuard) with ESMTP id 4LkBrC1b2Lz9v7Bs;
        Thu, 14 Jul 2022 19:20:59 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml742-chm.china.huawei.com (10.206.15.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 14 Jul 2022 13:22:03 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 14 Jul 2022 12:21:59 +0100
From:   John Garry <john.garry@huawei.com>
To:     <damien.lemoal@opensource.wdc.com>, <joro@8bytes.org>,
        <will@kernel.org>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <hch@lst.de>,
        <m.szyprowski@samsung.com>, <robin.murphy@arm.com>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-ide@vger.kernel.org>, <iommu@lists.linux.dev>,
        <linux-scsi@vger.kernel.org>, <linuxarm@huawei.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH v6 0/6] DMA mapping changes for SCSI core
Date:   Thu, 14 Jul 2022 19:15:23 +0800
Message-ID: <1657797329-98541-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

As reported in [0], DMA mappings whose size exceeds the IOMMU IOVA caching
limit may see a big performance hit.

This series introduces a new DMA mapping API, dma_opt_mapping_size(), so
that drivers may know this limit when performance is a factor in the
mapping.

The SCSI SAS transport code is modified only to use this limit. For now I
did not want to touch other hosts as I have a concern that this change
could cause a performance regression.

I also added a patch for libata-scsi as it does not currently honour the
shost max_sectors limit.

[0] https://lore.kernel.org/linux-iommu/20210129092120.1482-1-thunder.leizhen@huawei.com/

Changes since v5:
- Rebase to Linux 5.19-rc6
- Add Martin's tags to unmodified patches (thanks!)
- Apply DMA opt limit to max_sectors in sd driver, and not max_hw_sectors

Changes since v4:
- tweak libata and other patch titles
- Add Robin's tag (thanks!)
- Clarify description of new DMA mapping API

Changes since v3:
- Apply max DMA optimial limit to SAS hosts only
  Note: Even though "scsi: core: Cap shost max_sectors only once when
  adding" is a subset of a previous patch I did not transfer the RB tags
- Rebase on v5.19-rc4

John Garry (6):
  dma-mapping: Add dma_opt_mapping_size()
  dma-iommu: Add iommu_dma_opt_mapping_size()
  scsi: core: Cap shost max_sectors according to DMA limits only once
  scsi: sd: Allow max_sectors be capped at DMA optimal size limit
  scsi: scsi_transport_sas: Cap shost opt_sectors according to DMA
    optimal limit
  ata: libata-scsi: Cap ata_device->max_sectors according to
    shost->max_sectors

 Documentation/core-api/dma-api.rst | 14 ++++++++++++++
 drivers/ata/libata-scsi.c          |  1 +
 drivers/iommu/dma-iommu.c          |  6 ++++++
 drivers/iommu/iova.c               |  5 +++++
 drivers/scsi/hosts.c               |  5 +++++
 drivers/scsi/scsi_lib.c            |  4 ----
 drivers/scsi/scsi_transport_sas.c  |  6 ++++++
 drivers/scsi/sd.c                  |  2 ++
 include/linux/dma-map-ops.h        |  1 +
 include/linux/dma-mapping.h        |  5 +++++
 include/linux/iova.h               |  2 ++
 include/scsi/scsi_host.h           |  1 +
 kernel/dma/mapping.c               | 12 ++++++++++++
 13 files changed, 60 insertions(+), 4 deletions(-)

-- 
2.35.3

