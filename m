Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE4E5A7861
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 10:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbiHaICw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 04:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiHaICp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 04:02:45 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C1146B99D3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 01:02:44 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B043CED1;
        Wed, 31 Aug 2022 01:02:50 -0700 (PDT)
Received: from [10.57.15.237] (unknown [10.57.15.237])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 13CBF3F766;
        Wed, 31 Aug 2022 01:03:11 -0700 (PDT)
Message-ID: <19a47bae-91ff-648c-c407-759468b8af6a@arm.com>
Date:   Wed, 31 Aug 2022 09:02:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] swiotlb: fix a typo
Content-Language: en-GB
To:     Chao Gao <chao.gao@intel.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        hch@infradead.org, m.szyprowski@samsung.com
References: <20220826095046.880626-1-chao.gao@intel.com>
 <cd53526d-2564-996b-7b0d-d1fe9f114590@arm.com> <Yw7iFQGpStC6YodP@gao-cwp>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <Yw7iFQGpStC6YodP@gao-cwp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-08-31 05:22, Chao Gao wrote:
> On Tue, Aug 30, 2022 at 10:23:51AM +0100, Robin Murphy wrote:
>> On 2022-08-26 10:50, Chao Gao wrote:
>>> "overwirte" isn't a word. It should be "overwrite".
>>>
>>> Signed-off-by: Chao Gao <chao.gao@intel.com>
>>> ---
>>> BTW, I am wondering if copying the original buffer to the tlb buffer
>>> unconditionally will leak the original buffer to the VMM, especially
>>> when VMM isn't trusted e.g., by confidential VMs. Would it be better
>>> to zero the tlb buffer for dir == DMA_FROM_DEVICE?
>>
>> No, at the point of dma_map(), the buffer contents are owned by the caller,
>> so if parts of that buffer are sensitive and shouldn't be exposed to DMA,
>> then don't map the whole buffer for DMA. There are more DMA API
>> implementations than SWIOTLB.
>>
> 
> I am not sure if all existing drivers ensure that all buffers allocated
> for DMA_FROM_DEVICE are zeroed/poisoned so that they don't have sensitive
> data before dma_map(). If that isn't the case, bouncing the original contents
> (left by the previous user of the buffer) effectively makes the contents
> visible to host/VMM. I am afraid it may be a concern for confidential VMs.

Sure, and in a scheme where pages can be dynamically shared in-place 
instead of using SWIOTLB to bounce through a pre-shared buffer, then 
those same drivers will still expose the same stale data. Similarly, a 
driver could massively over-map with DMA_TO_DEVICE or DMA_BIDIRECTIONAL 
and expose all manner of potential secrets that way. It's a concern that 
cannot be addressed at the DMA API level. Anyone who wants to completely 
trust drivers not to do anything stupid in a confidential compute 
scenario is going to have to audit and possibly fix those drivers.

Robin.
