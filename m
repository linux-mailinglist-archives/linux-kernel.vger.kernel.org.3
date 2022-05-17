Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6531D529D27
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 11:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243934AbiEQJCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 05:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238173AbiEQJCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 05:02:05 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8CFC1AD85
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 02:02:03 -0700 (PDT)
Received: from fraeml710-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4L2VR854Wrz67L0F;
        Tue, 17 May 2022 16:59:00 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml710-chm.china.huawei.com (10.206.15.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 17 May 2022 11:02:01 +0200
Received: from [10.47.88.19] (10.47.88.19) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 17 May
 2022 10:02:00 +0100
Message-ID: <3e7c4d27-a0cb-2d9e-ca79-248ce26c6787@huawei.com>
Date:   Tue, 17 May 2022 10:02:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [RFC PATCH] dma-iommu: Add iommu_dma_max_mapping_size()
To:     Christoph Hellwig <hch@lst.de>
CC:     <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
        <m.szyprowski@samsung.com>, <chenxiang66@hisilicon.com>,
        <thunder.leizhen@huawei.com>, <iommu@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <liyihang6@hisilicon.com>
References: <1652706361-92557-1-git-send-email-john.garry@huawei.com>
 <20220517083834.GA16965@lst.de>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <20220517083834.GA16965@lst.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.88.19]
X-ClientProxiedBy: lhreml743-chm.china.huawei.com (10.201.108.193) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/05/2022 09:38, Christoph Hellwig wrote:
> On Mon, May 16, 2022 at 09:06:01PM +0800, John Garry wrote:
>> For streaming DMA mappings involving an IOMMU and whose IOVA len regularly
>> exceeds the IOVA rcache upper limit (meaning that they are not cached),
>> performance can be reduced.
>>
>> Add the IOMMU callback for DMA mapping API dma_max_mapping_size(), which
>> allows the drivers to know the mapping limit and thus limit the requested
>> IOVA lengths.
>>
>> This resolves the performance issue originally reported in [0] for a SCSI
>> HBA driver which was regularly mapping SGLs which required IOVAs in
>> excess of the IOVA caching limit. In this case the block layer limits the
>> max sectors per request - as configured in __scsi_init_queue() - which
>> will limit the total SGL length the driver tries to map and in turn limits
>> IOVA lengths requested.

BTW, on a separate topic, I noticed that even with this change my ATA 
devices have max_hw_sectors_kb of 32767, as opposed to 128 for SAS 
devices. It seems that libata-scsi - specifically ata_scsi_dev_config() 
- doesn't honour the shost max_sectors limit. I guess that is not 
intentional.

>>
>> [0] https://lore.kernel.org/linux-iommu/20210129092120.1482-1-thunder.leizhen@huawei.com/
>>
>> Signed-off-by: John Garry <john.garry@huawei.com>
>> ---
>> Sending as an RFC as iommu_dma_max_mapping_size() is a soft limit, and not
>> a hard limit which I expect is the semantics of dma_map_ops.max_mapping_size
>>
>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>> index 09f6e1c0f9c0..e2d5205cde37 100644
>> --- a/drivers/iommu/dma-iommu.c
>> +++ b/drivers/iommu/dma-iommu.c
>> @@ -1442,6 +1442,21 @@ static unsigned long iommu_dma_get_merge_boundary(struct device *dev)
>>   	return (1UL << __ffs(domain->pgsize_bitmap)) - 1;
>>   }
>>   
> 
>> +	if (!domain)
>> +		return 0;
>> +
>> +	cookie = domain->iova_cookie;
>> +	if (!cookie || cookie->type != IOMMU_DMA_IOVA_COOKIE)
>> +		return 0;
> 
> Can these conditions even be true here?

I don't think so. Paranoia on my part.

> 
>> +static inline unsigned long iova_rcache_range(void)
>> +{
>> +	return 0;
>> +}
> 
> Given that IOMMU_DMA select IOMMU_IOVA there is no need for this stub.

hmmm.. ok. Policy was to be stub everything but I think that it has changed.

> 
> Otherwise this looks sensible to me.
> 
> .

Great, thanks.
