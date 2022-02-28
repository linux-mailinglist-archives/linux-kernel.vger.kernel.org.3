Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AEAB4C65E4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 10:44:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233558AbiB1JpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 04:45:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbiB1JpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 04:45:02 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB8169CC4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 01:44:23 -0800 (PST)
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4K6b6729ZDz67xv7;
        Mon, 28 Feb 2022 17:43:11 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 28 Feb 2022 10:44:21 +0100
Received: from [10.47.86.223] (10.47.86.223) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.21; Mon, 28 Feb
 2022 09:44:20 +0000
Message-ID: <a8158643-4bf3-2482-3d8e-ff75a31d5a7b@huawei.com>
Date:   Mon, 28 Feb 2022 09:44:19 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v5 0/5] iommu: Allow IOVA rcache range be configured
To:     <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>
CC:     <mst@redhat.com>, <jasowang@redhat.com>,
        <baolu.lu@linux.intel.com>, <iommu@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>, <hch@lst.de>,
        <chenxiang66@hisilicon.com>, <linuxarm@huawei.com>
References: <1644859746-20279-1-git-send-email-john.garry@huawei.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <1644859746-20279-1-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.86.223]
X-ClientProxiedBy: lhreml708-chm.china.huawei.com (10.201.108.57) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/02/2022 17:29, John Garry wrote:

Hi guys,

And a friendly reminder on this series also.

Cheers,
john


> For streaming DMA mappings involving an IOMMU and whose IOVA len regularly
> exceeds the IOVA rcache upper limit (meaning that they are not cached),
> performance can be reduced.
> 
> This may be much more pronounced from commit 4e89dce72521 ("iommu/iova:
> Retry from last rb tree node if iova search fails"), as discussed at [0].
> 
> IOVAs which cannot be cached are highly involved in the IOVA ageing issue,
> as discussed at [1].
> 
> This series allows the IOVA rcache range be configured, so that we may
> cache all IOVAs per domain, thus improving performance.
> 
> A new IOMMU group sysfs file is added - max_opt_dma_size - which is used
> indirectly to configure the IOVA rcache range:
> /sys/kernel/iommu_groups/X/max_opt_dma_size
> 
> This file is updated same as how the IOMMU group default domain type is
> updated, i.e. must unbind the only device in the group first.
> 
> The inspiration here comes from block layer request queue sysfs
> "optimal_io_size" file, in /sys/block/sdX/queue/optimal_io_size
> 
> Some old figures* for storage scenario (when increasing IOVA rcache range
> to cover all DMA mapping sizes from the LLD):
> v5.13-rc1 baseline:			1200K IOPS
> With series:				1800K IOPS
> 
> All above are for IOMMU strict mode. Non-strict mode gives ~1800K IOPS in
> all scenarios.
> 
> Based on v5.17-rc4 + [2]
> * I lost my high data throughout test setup
> 
> Differences to v4:
> https://lore.kernel.org/linux-iommu/1626259003-201303-1-git-send-email-john.garry@huawei.com/
> - Major rebase
> - Change the "Refactor iommu_group_store_type()" to not use a callback
>    and an op type enum instead
>    - I didn't pick up Will's Ack as it has changed so much
> - Use a domain feature flag to keep same default group type
> - Add wrapper for default IOVA rcache range
> - Combine last 2x patches
> 
> [0] https://lore.kernel.org/linux-iommu/20210129092120.1482-1-thunder.leizhen@huawei.com/
> [1] https://lore.kernel.org/linux-iommu/1607538189-237944-1-git-send-email-john.garry@huawei.com/
> [2] https://lore.kernel.org/linux-iommu/20220203063345-mutt-send-email-mst@kernel.org/T/#m5b2b59576d35cad544314470f32e5f40ac5d1fe9
> 
> John Garry (5):
>    iommu: Refactor iommu_group_store_type()
>    iova: Allow rcache range upper limit to be flexible
>    iommu: Allow iommu_change_dev_def_domain() realloc same default domain
>      type
>    iommu: Allow max opt DMA len be set for a group via sysfs
>    iova: Add iova_len argument to iova_domain_init_rcaches()
> 
>   .../ABI/testing/sysfs-kernel-iommu_groups     |  16 ++
>   drivers/iommu/dma-iommu.c                     |  15 +-
>   drivers/iommu/iommu.c                         | 202 +++++++++++++-----
>   drivers/iommu/iova.c                          |  37 ++--
>   drivers/vdpa/vdpa_user/iova_domain.c          |   4 +-
>   include/linux/iommu.h                         |   7 +
>   include/linux/iova.h                          |   6 +-
>   7 files changed, 212 insertions(+), 75 deletions(-)
> 

