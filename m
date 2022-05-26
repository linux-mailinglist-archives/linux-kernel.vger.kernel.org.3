Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF890534D6D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 12:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347020AbiEZKfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 06:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbiEZKfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 06:35:43 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA75FCC174;
        Thu, 26 May 2022 03:35:41 -0700 (PDT)
Received: from fraeml745-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4L843k5Ym8z67JwR;
        Thu, 26 May 2022 18:31:30 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml745-chm.china.huawei.com (10.206.15.226) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 26 May 2022 12:35:38 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 26 May 2022 11:35:34 +0100
From:   John Garry <john.garry@huawei.com>
To:     <damien.lemoal@opensource.wdc.com>, <joro@8bytes.org>,
        <will@kernel.org>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <hch@lst.de>,
        <m.szyprowski@samsung.com>, <robin.murphy@arm.com>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-ide@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        <linux-scsi@vger.kernel.org>, <liyihang6@hisilicon.com>,
        <chenxiang66@hisilicon.com>, <thunder.leizhen@huawei.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH v2 0/4] DMA mapping changes for SCSI core
Date:   Thu, 26 May 2022 18:28:30 +0800
Message-ID: <1653560914-82185-1-git-send-email-john.garry@huawei.com>
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

As reported in [0], DMA mappings whose size exceeds the IOMMU IOVA caching
limit may see a big performance hit.

This series introduces a new DMA mapping API, dma_opt_mapping_size(), so
that drivers may know this limit when performance is a factor in the
mapping.

Robin didn't like using dma_max_mapping_size() for this [1].

The SCSI core code is modified to use this limit.

I also added a patch for libata-scsi as it does not currently honour the
shost max_sectors limit.

[0] https://lore.kernel.org/linux-iommu/20210129092120.1482-1-thunder.leizhen@huawei.com/
[1] https://lore.kernel.org/linux-iommu/f5b78c9c-312e-70ab-ecbb-f14623a4b6e3@arm.com/

Changes since v1:
- Relocate scsi_add_host_with_dma() dma_dev check (Reported by Dan)
- Add tags from Damien and Martin (thanks)
  - note: I only added Martin's tag to the SCSI patch

John Garry (4):
  dma-mapping: Add dma_opt_mapping_size()
  dma-iommu: Add iommu_dma_opt_mapping_size()
  scsi: core: Cap shost max_sectors according to DMA optimum mapping
    limits
  libata-scsi: Cap ata_device->max_sectors according to
    shost->max_sectors

 Documentation/core-api/dma-api.rst |  9 +++++++++
 drivers/ata/libata-scsi.c          |  1 +
 drivers/iommu/dma-iommu.c          |  6 ++++++
 drivers/iommu/iova.c               |  5 +++++
 drivers/scsi/hosts.c               |  5 +++++
 drivers/scsi/scsi_lib.c            |  4 ----
 include/linux/dma-map-ops.h        |  1 +
 include/linux/dma-mapping.h        |  5 +++++
 include/linux/iova.h               |  2 ++
 kernel/dma/mapping.c               | 12 ++++++++++++
 10 files changed, 46 insertions(+), 4 deletions(-)

-- 
2.26.2

