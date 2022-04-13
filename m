Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C88B4FF771
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 15:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235720AbiDMNN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 09:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233614AbiDMNNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 09:13:23 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D6E7A3981F
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 06:11:02 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6446A12FC;
        Wed, 13 Apr 2022 06:11:02 -0700 (PDT)
Received: from [10.57.41.19] (unknown [10.57.41.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 23AB13F73B;
        Wed, 13 Apr 2022 06:11:01 -0700 (PDT)
Message-ID: <4a993382-6a29-a0f4-4600-90ab60ad982a@arm.com>
Date:   Wed, 13 Apr 2022 14:10:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] dma-direct: avoid redundant memory sync for swiotlb
Content-Language: en-GB
To:     Christoph Hellwig <hch@lst.de>, Chao Gao <chao.gao@intel.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        m.szyprowski@samsung.com,
        Wang Zhaoyang1 <zhaoyang1.wang@intel.com>,
        Gao Liang <liang.gao@intel.com>,
        Kevin Tian <kevin.tian@intel.com>
References: <20220412113805.3210-1-chao.gao@intel.com>
 <e25fbb7e-a67e-5421-b7be-700fd0209b0d@arm.com>
 <20220413010157.GA10502@gao-cwp> <20220413045958.GA31209@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220413045958.GA31209@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-04-13 05:59, Christoph Hellwig wrote:
> On Wed, Apr 13, 2022 at 09:02:02AM +0800, Chao Gao wrote:
>> dma_direct_sync_single_for_cpu() also calls arch_sync_dma_for_cpu_all()
>> and arch_dma_mark_clean() in some cases. if SWIOTLB does sync internally,
>> should these two functions be called by SWIOTLB?
>>
>> Personally, it might be better if swiotlb can just focus on bounce buffer
>> alloc/free. Adding more DMA coherence logic into swiotlb will make it
>> a little complicated.
>>
>> How about an open-coded version of dma_direct_sync_single_for_cpu
>> in dma_direct_unmap_page with swiotlb_sync_single_for_cpu replaced by
>> swiotlb_tbl_unmap_single?
> 
> I don't think the swiotlb and non-coherent case ever fully worked.
> Before the merge of swiotlb into dma-direct they obviously were
> mutally exclusive, and even now all the cache maintainance is done
> on the physical address of the original data, not the swiotlb buffer.

Are you sure? AFAICS swiotlb_map() does the right thing, and 
dma_direct_{sync,unmap} are working off the DMA address, which is that 
of the bounce slot when SWIOTLB is involved (not least, how would the 
is_swiotlb_buffer() checks work otherwise?)

> If we want to fix that properly all the arch dma calls will need to
> move into swiotlb, but that is a much bigger patch.
> 
> So for now I'd be happy with the one liner presented here, but
> eventually the whole area could use an overhaul.

Sure, whoever gets round to tackling DMA_ATTR_NO_SNOOP first will need 
to go through all the cache maintenance hooks anyway, so happy to kick 
the can down the road until then.

Thanks,
Robin.
