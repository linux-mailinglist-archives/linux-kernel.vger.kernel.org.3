Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B84F5A8404
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 19:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbiHaRKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 13:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbiHaRKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 13:10:01 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 43998B857
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 10:09:59 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7B7B9ED1;
        Wed, 31 Aug 2022 10:10:05 -0700 (PDT)
Received: from [10.57.15.237] (unknown [10.57.15.237])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BCE7D3F766;
        Wed, 31 Aug 2022 10:09:57 -0700 (PDT)
Message-ID: <6cc93088-981e-5c2d-a757-90508455aa42@arm.com>
Date:   Wed, 31 Aug 2022 18:09:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 0/3] More ARM DMA ops cleanup
Content-Language: en-GB
To:     Yongqin Liu <yongqin.liu@linaro.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org, m.szyprowski@samsung.com,
        arnd@kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        "Bajjuri, Praneeth" <praneeth@ti.com>,
        Sumit Semwal <sumit.semwal@linaro.org>
References: <cover.1650539846.git.robin.murphy@arm.com>
 <20220421141300.GC20492@lst.de>
 <665d2b46-c9e2-2543-cad5-9adf022e4bcb@arm.com>
 <CAMSo37XN3PC22JK4ot-B8gUxWOhK+UD-73Zb8LqvYpgPL1Bj6g@mail.gmail.com>
 <9ec5ba90-150a-c675-d95b-b13e3a4e9e10@arm.com>
 <CAMSo37XmxGn4VJJXwOca=mjHfmgYoh-i4bOs_DpP2LdjaN87wA@mail.gmail.com>
 <5c617d66-f04b-df26-bf7a-7f479d081ac2@arm.com>
 <CAMSo37UUXd9FT1coAqgxU4urXi0NeCkONesmWqFfyrdDi+03dA@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <CAMSo37UUXd9FT1coAqgxU4urXi0NeCkONesmWqFfyrdDi+03dA@mail.gmail.com>
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

On 2022-08-31 17:41, Yongqin Liu wrote:
> Hi, Robin
> 
> On Tue, 30 Aug 2022 at 23:37, Robin Murphy <robin.murphy@arm.com> wrote:
>>
>> On 2022-08-30 16:19, Yongqin Liu wrote:
>>> Hi, Robin
>>>
>>> Thanks for the kind reply!
>>>
>>> On Tue, 30 Aug 2022 at 17:48, Robin Murphy <robin.murphy@arm.com> wrote:
>>>>
>>>> On 2022-08-27 13:24, Yongqin Liu wrote:
>>>>> Hi, Robin, Christoph
>>>>>
>>>>> With the changes landed in the mainline kernel,
>>>>> one problem is exposed with our out of tree pvr module.
>>>>> Like the source here[1], arm_dma_ops.sync_single_for_cpu is called in
>>>>> the format like the following:
>>>>>        arm_dma_ops.sync_single_for_cpu(NULL, pStart, pEnd - pStart,
>>>>> DMA_FROM_DEVICE);
>>>>>
>>>>> Not sure if you could give some suggestions on what I should do next
>>>>> to make the pvr module work again.
>>>>
>>>> Wow, that driver reinvents so many standard APIs for no apparent reason
>>>> it's not even funny.
>>>>
>>>> Anyway, from a brief look it seemingly already knows how to call the DMA
>>>> API semi-correctly, so WTF that's doing behind an #ifdef, who knows?
>>>> However it's still so completely wrong in general - fundamentally broken
>>>> AArch64 set/way cache maintenance!? - that it looks largely beyond help.
>>>> "Throw CONFIG_DMA_API_DEBUG at it and cry" is about the extent of
>>>> support I'm prepared to provide for that mess.
>>>
>>> For the moment, I do not care about the AArch64 lines, like if we only
>>> say the following two lines:
>>>       arm_dma_ops.sync_single_for_device(NULL, pStart, pEnd - pStart,
>>> DMA_TO_DEVICE);
>>>       arm_dma_ops.sync_single_for_cpu(NULL, pStart, pEnd - pStart,
>>> DMA_FROM_DEVICE);
>>>
>>> Could you please give some suggestions for that?
>>
>> Remove them. Then remove the #ifdef __arch64__ too, since the code under
>> there is doing a passable impression of generic DMA API usage, as long
>> as one ignores the bigger picture.
> 
> I tried with this method, and found that if I only update for the
> pvr_flush_range
> and the pvr_clean_range functions, the build still could boot to the
> home screen.
> 
> but if I update all the pvr_flush_range, pvr_clean_range and
> pvr_invalidate_range
> functions with this method(remove the arm_dma_ops lines and the #ifdef
> __arch64__ lines),
> then a "Unable to handle kernel NULL pointer dereference at virtual
> address 0000003c"
> error is reported like here: http://ix.io/49gu
> 
> Not sure if you have any idea from the log, or could you please give
> some suggestions
> on how to debug it.

Obviously there's almost certainly going to be more work to do on top to 
make the newly-exposed codepath actually behave as expected - I was 
simply making a general suggestion for a starting point based on looking 
at half a dozen lines of code in isolation.

To restate the point yet again in the hope that it's clear this time, 
the DMA ops on ARM are now effectively the same as the DMA ops on arm64, 
and will behave the same way. Assuming the driver already works on 
arm64, then the aim should be to unify all the ARM and arm64 codepaths 
for things that involve the DMA API. If you don't understand the code 
well enough to do that, please contact Imagination; I don't support 
their driver.

Thanks,
Robin.
