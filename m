Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61DFA4CFFB4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 14:12:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242780AbiCGNNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 08:13:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241410AbiCGNN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 08:13:29 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C931B26AF0;
        Mon,  7 Mar 2022 05:12:34 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 74BC6D6E;
        Mon,  7 Mar 2022 05:12:34 -0800 (PST)
Received: from [10.57.39.47] (unknown [10.57.39.47])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 574253F66F;
        Mon,  7 Mar 2022 05:12:33 -0800 (PST)
Message-ID: <b7a3e828-c848-2d42-9f91-d282b9c1ac9e@arm.com>
Date:   Mon, 7 Mar 2022 13:12:29 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [BUG] crypto: ccree: driver does not handle case where cryptlen =
 authsize =0
Content-Language: en-GB
From:   Robin Murphy <robin.murphy@arm.com>
To:     Gilad Ben-Yossef <gilad@benyossef.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
References: <CAOtvUMeoYcVm7OQdqXd1V5iPSXW_BkVxx6TA6nF7zTLVeHe0Ww@mail.gmail.com>
 <CAOtvUMfy1fF35B2sfbOMui8n9Q4iCke9rgn5TiYMUMjd8gqHsA@mail.gmail.com>
 <YhKV55t90HWm6bhv@Red>
 <CAOtvUMdRU4wnRCXsC+U5XBDp+b+u8w7W7JCUKW2+ohuJz3PVhQ@mail.gmail.com>
 <YhOcEQEjIKBrbMIZ@Red>
 <CAOtvUMfN8U4+eG-TEVW4bSE6kOzuOSsJE4dOYGXYuWQKNzv7wQ@mail.gmail.com>
 <CAOtvUMeRb=j=NDrc88x8aB-3=D1mxZ_-aA1d4FfvJmj7Jrbi4w@mail.gmail.com>
 <YiIUXtxd44ut5uzV@Red> <YiUsWosH+MKMF7DQ@gondor.apana.org.au>
 <CAOtvUMcudG3ySU+VeE7hfneDVWGLKFTnws-xjhq4hgFYSj0qOg@mail.gmail.com>
 <YiXjCcXXk0f18FDL@Red> <aca4117c-b7a5-f7eb-eb03-4e1f1a93a730@arm.com>
 <CAOtvUMePFR4e2jgHZKOvs3J3Xt4NzRbzD_=vr_49Qgs5HTrvHw@mail.gmail.com>
 <6cf91f43-df23-3ac9-e9b5-958d99d37422@arm.com>
 <CAOtvUMedqSNKx9Aah0R_aAyjKO0pn4K75MrCnbh_zX+Zw9vRQA@mail.gmail.com>
 <371ef3f2-883d-91ab-ed96-da8921efb465@arm.com>
In-Reply-To: <371ef3f2-883d-91ab-ed96-da8921efb465@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-03-07 13:03, Robin Murphy wrote:
> On 2022-03-07 12:47, Gilad Ben-Yossef wrote:
>> On Mon, Mar 7, 2022 at 2:36 PM Robin Murphy <robin.murphy@arm.com> wrote:
>>>
>>> On 2022-03-07 12:17, Gilad Ben-Yossef wrote:
>>>> On Mon, Mar 7, 2022 at 1:14 PM Robin Murphy <robin.murphy@arm.com> 
>>>> wrote:
>>>>
>>>>> The "overlap" is in the sense of having more than one mapping 
>>>>> within the
>>>>> same cacheline:
>>>>>
>>>>> [  142.458120] DMA-API: add_dma_entry start P=ba79f200 N=ba79f
>>>>> D=ba79f200 L=10 DMA_FROM_DEVICE attrs=0
>>>>> [  142.458156] DMA-API: add_dma_entry start P=445dc010 N=445dc
>>>>> D=445dc010 L=10 DMA_TO_DEVICE attrs=0
>>>>> [  142.458178] sun8i-ss 1c15000.crypto: SRC 0/1/1 445dc000 len=16 bi=0
>>>>> [  142.458215] sun8i-ss 1c15000.crypto: DST 0/1/1 ba79f200 len=16 bi=0
>>>>> [  142.458234] DMA-API: add_dma_entry start P=ba79f210 N=ba79f
>>>>> D=ba79f210 L=10 DMA_FROM_DEVICE attrs=0
>>>>>
>>>>> This actually illustrates exactly the reason why this is 
>>>>> unsupportable.
>>>>> ba79f200 is mapped for DMA_FROM_DEVICE, therefore subsequently mapping
>>>>> ba79f210 for DMA_TO_DEVICE may cause the cacheline covering the range
>>>>> ba79f200-ba79f23f to be written back over the top of data that the
>>>>> device has already started to write to memory. Hello data corruption.
>>>>>
>>>>> Separate DMA mappings should be from separate memory allocations,
>>>>> respecting ARCH_DMA_MINALIGN.
>>>>
>>>> hmm... I know I'm missing something here, but how does this align with
>>>> the following from active_cacheline_insert() in kernel/dma/debug.c ?
>>>>
>>>>           /* If the device is not writing memory then we don't have any
>>>>            * concerns about the cpu consuming stale data.  This 
>>>> mitigates
>>>>            * legitimate usages of overlapping mappings.
>>>>            */
>>>>           if (entry->direction == DMA_TO_DEVICE)
>>>>                   return 0;
>>>
>>> It's OK to have multiple mappings that are *all* DMA_TO_DEVICE, which
>>> looks to be the case that this check was intended to allow. However I
>>> think you're right that it should still actually check for conflicting
>>> directions between the new entry and any existing ones, otherwise it
>>> ends up a bit too lenient.
>>>
>>> Cheers,
>>> Robin.
>>
>> I understand what you are saying about why checking for conflicting
>> directions may be a good thing, but given that the code is as it is
>> right now, how are we seeing the warning for two mapping that one of
>> them is DMA_TO_DEVICE?
> 
> Because it's the second one that isn't. The warning is triggered by 
> adding the DMA_FROM_DEVICE entry, which *is* checked, and finds the 
> DMA_TO_DEVICE entry already present. What's not great is that if those 
> two mappings happened to be made in the opposite order then it would be 
> missed entirely.

Urgh, no, sorry, that's some imaginary conflation of the cacheline radix 
tree with the entry hash bucket...

What's actually happened here is that I've failed to read the log 
properly and they're both DMA_FROM_DEVICE. But the potential problem of 
mixed-direction mappings being missed does still stand in general.

Robin.
