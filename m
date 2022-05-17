Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78AF152A3D5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 15:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347191AbiEQNuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 09:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232153AbiEQNub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 09:50:31 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED0B4C790
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 06:50:28 -0700 (PDT)
Received: from fraeml738-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4L2cqw2BnSz67xWY;
        Tue, 17 May 2022 21:47:24 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml738-chm.china.huawei.com (10.206.15.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 17 May 2022 15:50:25 +0200
Received: from [10.47.88.19] (10.47.88.19) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 17 May
 2022 14:50:24 +0100
Message-ID: <1043830a-02af-bf8a-6089-0eb7a84a8e85@huawei.com>
Date:   Tue, 17 May 2022 14:50:24 +0100
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
 <9160031b-50be-6993-5a8e-f238391962c5@huawei.com>
 <8f193bdd-3a0a-f9ed-0726-e6081f374320@arm.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <8f193bdd-3a0a-f9ed-0726-e6081f374320@arm.com>
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

On 17/05/2022 13:02, Robin Murphy wrote:
>>>
>>> Indeed, sorry but NAK for this being nonsense. As I've said at least 
>>> once before, if the unnecessary SAC address allocation attempt slows 
>>> down your workload, make it not do that in the first place. If you 
>>> don't like the existing command-line parameter then fine, > there are 
>>> plenty of
>>> other options, it just needs to be done in a way that doesn't break 
>>> x86 systems with dodgy firmware, as my first attempt turned out to.
>>
>> Sorry, but I am not interested in this. It was discussed in Jan last 
>> year without any viable solution.
> 
> Er, OK, if you're not interested in solving that problem I don't see why 
> you'd bring it up, but hey ho. *I* still think it's important, so I 
> guess I'll revive my old patch with a CONFIG_X86 bodge and have another 
> go at some point.

Let me rephrase, I would be happy to help fix that problem if we really 
can get it fixed, however for my problem it's better to try to get the 
SCSI driver to stop requesting uncached IOVAs foremost.

> 
>> Anyway we still have the long-term IOVA aging issue, and requesting 
>> non-cached IOVAs is involved in that. So I would rather keep the SCSI 
>> driver to requesting cached IOVAs all the time.
>>
>> I did try to do it the other way around - configuring the IOVA caching 
>> range according to the drivers requirement but that got nowhere.

Note that this is still not a final solution as it's not always viable 
to ask a user to unbind + bind the driver.

> 
> FWIW I thought that all looked OK, it just kept getting drowned out by 
> more critical things in my inbox so I hoped someone else might comment. 
> If it turns out that I've become the de-facto IOVA maintainer in 
> everyone else's minds now and they're all waiting for my word then fair 
> enough, I just need to know and reset my expectations accordingly. Joerg?

It would be great to see an improvement here...

> 
>>> Furthermore, if a particular SCSI driver doesn't benefit from 
>>> mappings larger than 256KB, then that driver is also free to limit 
>>> its own mapping size. There are other folks out there with use-cases 
>>> for mapping *gigabytes* at once; you don't get to cripple the API and 
>>> say that that's suddenly not allowed just because it happens to make 
>>> your thing go faster, that's absurd.
>>
>> I'd say less catastrophically slow, not faster.
>>
>> So how to inform the SCSI driver of this caching limit then so that it 
>> may limit the SGL length?
> 
> Driver-specific mechanism; block-layer-specific mechanism; redefine this 
> whole API to something like dma_opt_mapping_size(), as a limit above 
> which mappings might become less efficient or start to fail (callback to 
> my thoughts on [1] as well, I suppose); many options.

ok, fine.

> Just not imposing 
> a ridiculously low *maximum* on everyone wherein mapping calls "should 
> not be larger than the returned value" when that's clearly bollocks.

I agree that this change is in violation as the documentation clearly 
implies a hard limit.

However, FWIW, from looking at users of dma_max_mapping_size(), they 
seem to use in a similar way to SCSI/block layer core, i.e. use this 
value to limit the max SGL total len per IO command. And not as a method 
to learn max DMA consistent mappings size for ring buffers, etc.

Anyway I'll look at dma_opt_mapping_size() but I am not sure how keen 
Christoph will be on this... it is strange to introduce that API due to 
peculiarity of the IOVA allocator.

> 
> 
> [1] 
> https://lore.kernel.org/linux-iommu/20220510142109.777738-1-ltykernel@gmail.com/

Thanks,
John
