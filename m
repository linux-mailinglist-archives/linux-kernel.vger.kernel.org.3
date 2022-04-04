Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7A84F13D5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 13:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359500AbiDDLe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 07:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349295AbiDDLe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 07:34:57 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E063C739
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 04:33:01 -0700 (PDT)
Received: from fraeml705-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KX7rM1QGyz67Lnh;
        Mon,  4 Apr 2022 19:30:59 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Mon, 4 Apr 2022 13:32:58 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 4 Apr 2022 12:32:55 +0100
From:   John Garry <john.garry@huawei.com>
To:     <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>
CC:     <mst@redhat.com>, <jasowang@redhat.com>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>,
        <chenxiang66@hisilicon.com>, <thunder.leizhen@huawei.com>,
        <jean-philippe@linaro.org>, <linuxarm@huawei.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH RESEND v5 0/5] iommu: Allow IOVA rcache range be configured
Date:   Mon, 4 Apr 2022 19:27:09 +0800
Message-ID: <1649071634-188535-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For streaming DMA mappings involving an IOMMU and whose IOVA len regularly
exceeds the IOVA rcache upper limit (meaning that they are not cached),
performance can be reduced. 

This may be much more pronounced from commit 4e89dce72521 ("iommu/iova:
Retry from last rb tree node if iova search fails"), as discussed at [0].

IOVAs which cannot be cached are highly involved in the IOVA ageing issue,
as discussed at [1].

This series allows the IOVA rcache range be configured, so that we may
cache all IOVAs per domain, thus improving performance.

A new IOMMU group sysfs file is added - max_opt_dma_size - which is used
indirectly to configure the IOVA rcache range:
/sys/kernel/iommu_groups/X/max_opt_dma_size

This file is updated same as how the IOMMU group default domain type is
updated, i.e. must unbind the only device in the group first.

The inspiration here comes from block layer request queue sysfs
"optimal_io_size" file, in /sys/block/sdX/queue/optimal_io_size

Some old figures* for storage scenario (when increasing IOVA rcache range
to cover all DMA mapping sizes from the LLD):
v5.13-rc1 baseline:			1200K IOPS
With series:				1800K IOPS

All above are for IOMMU strict mode. Non-strict mode gives ~1800K IOPS in
all scenarios.

Based on v5.18-rc1
* I lost my high data throughout test setup

Differences to v4:
https://lore.kernel.org/linux-iommu/1626259003-201303-1-git-send-email-john.garry@huawei.com/
- Major rebase
- Change the "Refactor iommu_group_store_type()" to not use a callback
  and an op type enum instead
  - I didn't pick up Will's Ack as it has changed so much
- Use a domain feature flag to keep same default group type
- Add wrapper for default IOVA rcache range
- Combine last 2x patches

[0] https://lore.kernel.org/linux-iommu/20210129092120.1482-1-thunder.leizhen@huawei.com/
[1] https://lore.kernel.org/linux-iommu/1607538189-237944-1-git-send-email-john.garry@huawei.com/

John Garry (5):
  iommu: Refactor iommu_group_store_type()
  iova: Allow rcache range upper limit to be flexible
  iommu: Allow iommu_change_dev_def_domain() realloc same default domain
    type
  iommu: Allow max opt DMA len be set for a group via sysfs
  iova: Add iova_len argument to iova_domain_init_rcaches()

 .../ABI/testing/sysfs-kernel-iommu_groups     |  16 ++
 drivers/iommu/dma-iommu.c                     |  15 +-
 drivers/iommu/iommu.c                         | 202 +++++++++++++-----
 drivers/iommu/iova.c                          |  37 ++--
 drivers/vdpa/vdpa_user/iova_domain.c          |   4 +-
 include/linux/iommu.h                         |   7 +
 include/linux/iova.h                          |   6 +-
 7 files changed, 212 insertions(+), 75 deletions(-)

-- 
2.26.2

