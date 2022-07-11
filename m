Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0408857006B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 13:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbiGKL0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 07:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbiGKLZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 07:25:59 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3C9C111A22
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 04:01:06 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6BD6516A3;
        Mon, 11 Jul 2022 04:01:06 -0700 (PDT)
Received: from [10.57.85.194] (unknown [10.57.85.194])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C23353F792;
        Mon, 11 Jul 2022 04:01:04 -0700 (PDT)
Message-ID: <ac4944b8-5d15-4761-6315-7dba6eaee0e7@arm.com>
Date:   Mon, 11 Jul 2022 12:01:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] swiotlb: ensure io_tlb_default_mem spinlock always
 initialised
Content-Language: en-GB
To:     Ben Dooks <ben.dooks@sifive.com>, Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        iommu@lists.linux-foundation.org,
        Sudip Mukherjee <sudip.mukherjee@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
References: <20220708170811.270589-1-ben.dooks@sifive.com>
 <fdf5d34e-7668-c05c-9098-30e34939c88a@arm.com>
 <683344bd-dc9b-0bb5-9377-b3e9ab410a74@sifive.com>
 <e6c43ef0-870b-5fe6-141e-0a3d566b030e@arm.com> <20220711102134.GB4639@lst.de>
 <4fa8b709-c883-54dc-c302-20c9e55ae93a@sifive.com>
 <20220711103921.GA6542@lst.de>
 <43426798-44df-c2c7-1f46-0b79201cb620@sifive.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <43426798-44df-c2c7-1f46-0b79201cb620@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-07-11 11:42, Ben Dooks wrote:
> On 11/07/2022 11:39, Christoph Hellwig wrote:
>> On Mon, Jul 11, 2022 at 11:24:51AM +0100, Ben Dooks wrote:
>>> On 11/07/2022 11:21, Christoph Hellwig wrote:
>>>> On Mon, Jul 11, 2022 at 11:07:17AM +0100, Robin Murphy wrote:
>>>>> If none of your peripherals should need SWIOTLB, then the fact that
>>>>> you're ending up in swiotlb_map() at all is a clear sign that
>>>>> something's wrong. Most likely someone's forgotten to set their DMA
>>>>> masks correctly.
>>>>
>>>> Yes.
>>>
>>> Possibly, we had at least one driver which attempted to set a 32 bit
>>> DMA mask which had to be removed as the DMA layer accepts this but
>>> since there is no DMA32 memory the allocator then just fails.
>>>
>>> I expect the above may need to be a separate discussion(s) of how to
>>> default the DMA mask and how to stop the implicit acceptance of setting
>>> a 32-bit DMA mask.
>>
>> No.  Linux simply assumes you can do 32-bit DMA and this won't
>> change.  So we'll need to fix your platform to support swiotlb
>> eventually.
> 
> Ok, is there any examples currently in the kernel that have no memory
> in the DMA32 zone that do use swiotlb?

The arm64 code originally made an assumption that a system with that 
kind of memory layout would use a DMA offset in the interconnect, and so 
placed ZONE_DMA32 in the first 4GB of available RAM rather than actual 
physical address space. The only relatively mainstream platform we 
subsequently saw with all RAM above 32 bits was AMD Seattle, which also 
*didn't* use a DMA offset, so it "worked" by virtue of this bodge in the 
sense that allocations didn't fail, but DMA transactions would then 
disappear off into nowhere when the device truncated the MSBs of 
whatever too-big DMA address it was given.

I think that stuff's long gone by now, and if any of handful of 
remaining Seattle users plug in a 32-bit PCIe device and try to use it 
with the IOMMU disabled, they'll probably see the fireworks as intended.

Much as we'd like to make DMA an explicit opt-in for all drivers, that's 
something which can only really be solved 30 years ago.

Robin.
