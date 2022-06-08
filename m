Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE0C542D96
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 12:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236976AbiFHK0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 06:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237373AbiFHKYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 06:24:19 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB0C142A8D;
        Wed,  8 Jun 2022 03:14:12 -0700 (PDT)
Received: from fraeml739-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LJ32H3WYkz6H6pv;
        Wed,  8 Jun 2022 18:12:55 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml739-chm.china.huawei.com (10.206.15.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 8 Jun 2022 12:14:09 +0200
Received: from [10.47.90.54] (10.47.90.54) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 8 Jun
 2022 11:14:08 +0100
Message-ID: <202f1969-41e4-5f9a-3ff6-0009757434f5@huawei.com>
Date:   Wed, 8 Jun 2022 11:14:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
From:   John Garry <john.garry@huawei.com>
Subject: Re: [PATCH v3 0/4] DMA mapping changes for SCSI core
To:     Bart Van Assche <bvanassche@acm.org>,
        <damien.lemoal@opensource.wdc.com>, <joro@8bytes.org>,
        <will@kernel.org>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <hch@lst.de>,
        <m.szyprowski@samsung.com>, <robin.murphy@arm.com>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-ide@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        <linux-scsi@vger.kernel.org>, <liyihang6@hisilicon.com>,
        <chenxiang66@hisilicon.com>, <thunder.leizhen@huawei.com>
References: <1654507822-168026-1-git-send-email-john.garry@huawei.com>
 <3e2324dc-2ab1-6a35-46ab-72d970cc466c@acm.org>
In-Reply-To: <3e2324dc-2ab1-6a35-46ab-72d970cc466c@acm.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.47.90.54]
X-ClientProxiedBy: lhreml744-chm.china.huawei.com (10.201.108.194) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/2022 23:43, Bart Van Assche wrote:
> On 6/6/22 02:30, John Garry wrote:
>> As reported in [0], DMA mappings whose size exceeds the IOMMU IOVA 
>> caching
>> limit may see a big performance hit.
>>
>> This series introduces a new DMA mapping API, dma_opt_mapping_size(), so
>> that drivers may know this limit when performance is a factor in the
>> mapping.
>>
>> Robin didn't like using dma_max_mapping_size() for this [1].
>>
>> The SCSI core code is modified to use this limit.
>>
>> I also added a patch for libata-scsi as it does not currently honour the
>> shost max_sectors limit.
>>
>> Note: Christoph has previously kindly offered to take this series via the
>>        dma-mapping tree, so I think that we just need an ack from the
>>        IOMMU guys now.
>>
>> [0] 
>> https://lore.kernel.org/linux-iommu/20210129092120.1482-1-thunder.leizhen@huawei.com/ 
>>
>> [1] 
>> https://lore.kernel.org/linux-iommu/f5b78c9c-312e-70ab-ecbb-f14623a4b6e3@arm.com/ 
>>
> 
> Regarding [0], that patch reverts commit 4e89dce72521 ("iommu/iova: 
> Retry from last rb tree node if iova search fails"). Reading the 
> description of that patch, it seems to me that the iova allocator can be 
> improved. Shouldn't the iova allocator be improved such that we don't 
> need this patch series? There are algorithms that handle fragmentation 
> much better than the current iova allocator algorithm, e.g. the 
> https://en.wikipedia.org/wiki/Buddy_memory_allocation algorithm.

Regardless of whether the IOVA allocator can be improved - which it 
probably can be - this series is still useful. That is due to the IOVA 
rcache - that is a cache of pre-allocated IOVAs which can be quickly 
used in the DMA mapping. The rache contains IOVAs up to certain fixed 
size. In this series we limit the DMA mapping length to the rcache size 
upper limit to always bypass the allocator (when we have a cached IOVA 
available) - see alloc_iova_fast().

Even if the IOVA allocator were greatly optimised for speed, there would 
still be an overhead in the alloc and free for those larger IOVAs which 
would outweigh the advantage of having larger DMA mappings. But is there 
even an advantage in very large streaming DMA mappings? Maybe for iotlb 
efficiency. But some say it's better to have the DMA engine start 
processing the data ASAP and not wait for larger lists to be built.

Thanks,
John

