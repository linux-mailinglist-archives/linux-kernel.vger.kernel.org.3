Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E18052A05E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 13:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345158AbiEQL0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 07:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiEQL01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 07:26:27 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BE88222A9
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 04:26:25 -0700 (PDT)
Received: from fraeml734-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4L2Yj52qykz689TL;
        Tue, 17 May 2022 19:26:17 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml734-chm.china.huawei.com (10.206.15.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 17 May 2022 13:26:23 +0200
Received: from [10.47.88.19] (10.47.88.19) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 17 May
 2022 12:26:22 +0100
Message-ID: <9160031b-50be-6993-5a8e-f238391962c5@huawei.com>
Date:   Tue, 17 May 2022 12:26:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [RFC PATCH] dma-iommu: Add iommu_dma_max_mapping_size()
To:     Robin Murphy <robin.murphy@arm.com>, <joro@8bytes.org>,
        <will@kernel.org>, <hch@lst.de>, <m.szyprowski@samsung.com>
CC:     <chenxiang66@hisilicon.com>, <thunder.leizhen@huawei.com>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <liyihang6@hisilicon.com>
References: <1652706361-92557-1-git-send-email-john.garry@huawei.com>
 <f5b78c9c-312e-70ab-ecbb-f14623a4b6e3@arm.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <f5b78c9c-312e-70ab-ecbb-f14623a4b6e3@arm.com>
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

On 17/05/2022 11:40, Robin Murphy wrote:
> On 2022-05-16 14:06, John Garry wrote:
>> For streaming DMA mappings involving an IOMMU and whose IOVA len 
>> regularly
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
>> will limit the total SGL length the driver tries to map and in turn 
>> limits
>> IOVA lengths requested.
>>
>> [0] 
>> https://lore.kernel.org/linux-iommu/20210129092120.1482-1-thunder.leizhen@huawei.com/ 
>>
>>
>> Signed-off-by: John Garry <john.garry@huawei.com>
>> ---
>> Sending as an RFC as iommu_dma_max_mapping_size() is a soft limit, and 
>> not
>> a hard limit which I expect is the semantics of 
>> dma_map_ops.max_mapping_size
> 
> Indeed, sorry but NAK for this being nonsense. As I've said at least 
> once before, if the unnecessary SAC address allocation attempt slows 
> down your workload, make it not do that in the first place. If you don't 
> like the existing command-line parameter then fine, > there are plenty of
> other options, it just needs to be done in a way that doesn't break x86 
> systems with dodgy firmware, as my first attempt turned out to.

Sorry, but I am not interested in this. It was discussed in Jan last 
year without any viable solution.

Anyway we still have the long-term IOVA aging issue, and requesting 
non-cached IOVAs is involved in that. So I would rather keep the SCSI 
driver to requesting cached IOVAs all the time.

I did try to do it the other way around - configuring the IOVA caching 
range according to the drivers requirement but that got nowhere.

> 
> Furthermore, if a particular SCSI driver doesn't benefit from mappings 
> larger than 256KB, then that driver is also free to limit its own 
> mapping size. There are other folks out there with use-cases for mapping 
> *gigabytes* at once; you don't get to cripple the API and say that 
> that's suddenly not allowed just because it happens to make your thing 
> go faster, that's absurd.

I'd say less catastrophically slow, not faster.

So how to inform the SCSI driver of this caching limit then so that it 
may limit the SGL length?

Thanks,
John
