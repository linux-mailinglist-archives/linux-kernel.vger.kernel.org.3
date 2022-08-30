Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5355A5FC3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 11:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbiH3JsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 05:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiH3JsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 05:48:13 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A60E67B1D2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 02:48:12 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8A7D623A;
        Tue, 30 Aug 2022 02:48:18 -0700 (PDT)
Received: from [10.57.13.45] (unknown [10.57.13.45])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D4ADD3F766;
        Tue, 30 Aug 2022 02:48:10 -0700 (PDT)
Message-ID: <9ec5ba90-150a-c675-d95b-b13e3a4e9e10@arm.com>
Date:   Tue, 30 Aug 2022 10:48:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 0/3] More ARM DMA ops cleanup
To:     Yongqin Liu <yongqin.liu@linaro.org>,
        Christoph Hellwig <hch@lst.de>
Cc:     linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        m.szyprowski@samsung.com, arnd@kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        "Bajjuri, Praneeth" <praneeth@ti.com>,
        Sumit Semwal <sumit.semwal@linaro.org>
References: <cover.1650539846.git.robin.murphy@arm.com>
 <20220421141300.GC20492@lst.de>
 <665d2b46-c9e2-2543-cad5-9adf022e4bcb@arm.com>
 <CAMSo37XN3PC22JK4ot-B8gUxWOhK+UD-73Zb8LqvYpgPL1Bj6g@mail.gmail.com>
Content-Language: en-GB
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <CAMSo37XN3PC22JK4ot-B8gUxWOhK+UD-73Zb8LqvYpgPL1Bj6g@mail.gmail.com>
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

On 2022-08-27 13:24, Yongqin Liu wrote:
> Hi, Robin, Christoph
> 
> With the changes landed in the mainline kernel,
> one problem is exposed with our out of tree pvr module.
> Like the source here[1], arm_dma_ops.sync_single_for_cpu is called in
> the format like the following:
>      arm_dma_ops.sync_single_for_cpu(NULL, pStart, pEnd - pStart,
> DMA_FROM_DEVICE);
> 
> Not sure if you could give some suggestions on what I should do next
> to make the pvr module work again.

Wow, that driver reinvents so many standard APIs for no apparent reason 
it's not even funny.

Anyway, from a brief look it seemingly already knows how to call the DMA 
API semi-correctly, so WTF that's doing behind an #ifdef, who knows? 
However it's still so completely wrong in general - fundamentally broken 
AArch64 set/way cache maintenance!? - that it looks largely beyond help. 
"Throw CONFIG_DMA_API_DEBUG at it and cry" is about the extent of 
support I'm prepared to provide for that mess.

Thanks,
Robin.

> Thanks in advance!
> 
> [1]: https://android-git.linaro.org/kernel/omap-modules.git/tree/pvr/services4/srvkm/env/linux/osfunc.c?h=android-mainline#n4615
> 
> Thanks,
> Yongqin Liu
> 
> On Thu, 21 Apr 2022 at 22:35, Robin Murphy <robin.murphy@arm.com> wrote:
>>
>> On 2022-04-21 15:13, Christoph Hellwig wrote:
>>> On Thu, Apr 21, 2022 at 12:36:56PM +0100, Robin Murphy wrote:
>>>> Hi all,
>>>>
>>>> Thanks to Christoph's latest series, I'm reminded that, if we're going
>>>> to give the ARM DMA ops some cleanup this cycle, it's as good a time as
>>>> any to dust off these old patches and add them on top as well. I've
>>>> based these on the arm-dma-direct branch which I assume matches the
>>>> patches posted at [1].
>>>
>>> All these do look sensible to me.  But weren't you working on replacing
>>> the ARM iommu dma_ops with dma-іommu anyway?
>>
>> Yes, that's somewhat entangled with the IOMMU bus ops stuff, so I'll
>> probably get to the point of having to revisit it in a couple of months
>> or so. These patches are off the bottom of that stack from my first
>> attempt, where the aim was to make the current ops the same shape first
>> so that the switch is then easier to reason about (particularly in terms
>> of sounding out any issues with the hooking up of dev->dma_coherent,
>> although your series will now be taking most of the load off there).
>>
>> Cheers,
>> Robin.
> 
> 
> 
