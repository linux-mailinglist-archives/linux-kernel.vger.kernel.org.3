Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF13E4F17CA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 17:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347003AbiDDPDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 11:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378422AbiDDPDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 11:03:15 -0400
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 921112F033;
        Mon,  4 Apr 2022 08:01:18 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 6981F419BC;
        Mon,  4 Apr 2022 15:01:12 +0000 (UTC)
Subject: Re: [PATCH 4/9] soc: apple: Add SART driver
To:     Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc:     Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Keith Busch <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
        "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
        Marc Zyngier <maz@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvme@lists.infradead.org
References: <20220321165049.35985-1-sven@svenpeter.dev>
 <20220321165049.35985-5-sven@svenpeter.dev>
 <CAK8P3a19F8K0MvZV_R6HrmmR+WBsDge+u6U3iEVEjZ74i6+nEg@mail.gmail.com>
 <f06576c8-76c6-41ae-874d-81ea0b5b5603@www.fastmail.com>
 <CAK8P3a3xioqJDb7hQ3dvxQyHPg2hgJbeJywEP+N4cDzpo=8VhQ@mail.gmail.com>
 <YksHoQvDqXOK70EX@robh.at.kernel.org>
From:   Hector Martin <marcan@marcan.st>
Message-ID: <15ace529-1fea-1141-b87f-598e9bfa12dc@marcan.st>
Date:   Tue, 5 Apr 2022 00:01:09 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YksHoQvDqXOK70EX@robh.at.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: es-ES
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/04/2022 23.58, Rob Herring wrote:
> On Sat, Apr 02, 2022 at 09:07:17PM +0200, Arnd Bergmann wrote:
>> On Sat, Apr 2, 2022 at 2:38 PM Sven Peter <sven@svenpeter.dev> wrote:
>>> On Mon, Mar 21, 2022, at 18:07, Arnd Bergmann wrote:
>>>> On Mon, Mar 21, 2022 at 5:50 PM Sven Peter <sven@svenpeter.dev> wrote:
>>>>> The NVMe co-processor on the Apple M1 uses a DMA address filter called
>>>>> SART for some DMA transactions. This adds a simple driver used to
>>>>> configure the memory regions from which DMA transactions are allowed.
>>>>>
>>>>> Co-developed-by: Hector Martin <marcan@marcan.st>
>>>>> Signed-off-by: Hector Martin <marcan@marcan.st>
>>>>> Signed-off-by: Sven Peter <sven@svenpeter.dev>
>>>>
>>>> Can you add some explanation about why this uses a custom interface
>>>> instead of hooking into the dma_map_ops?
>>>
>>> Sure.
>>> In a perfect world this would just be an IOMMU implementation but since
>>> SART can't create any real IOVA space using pagetables it doesn't fit
>>> inside that subsytem.
>>>
>>> In a slightly less perfect world I could just implement dma_map_ops here
>>> but that won't work either because not all DMA buffers of the NVMe
>>> device have to go through SART and those allocations happen
>>> inside the same device and would use the same dma_map_ops.
>>>
>>> The NVMe controller has two separate DMA filters:
>>>
>>>    - NVMMU, which must be set up for any command that uses PRPs and
>>>      ensures that the DMA transactions only touch the pages listed
>>>      inside the PRP structure. NVMMU itself is tightly coupled
>>>      to the NVMe controller: The list of allowed pages is configured
>>>      based on command's tag id and even commands that require no DMA
>>>      transactions must be listed inside NVMMU before they are started.
>>>    - SART, which must be set up for some shared memory buffers (e.g.
>>>      log messages from the NVMe firmware) and for some NVMe debug
>>>      commands that don't use PRPs.
>>>      SART is only loosely coupled to the NVMe controller and could
>>>      also be used together with other devices. It's also the only
>>>      thing that changed between M1 and M1 Pro/Max/Ultra and that's
>>>      why I decided to separate it from the NVMe driver.
>>>
>>> I'll add this explanation to the commit message.
>>
>> Ok, thanks.
>>
>>>>> +static void sart2_get_entry(struct apple_sart *sart, int index, u8 *flags,
>>>>> +                           phys_addr_t *paddr, size_t *size)
>>>>> +{
>>>>> +       u32 cfg = readl_relaxed(sart->regs + APPLE_SART2_CONFIG(index));
>>>>> +       u32 paddr_ = readl_relaxed(sart->regs + APPLE_SART2_PADDR(index));
>>>>
>>>> Why do you use the _relaxed() accessors here and elsewhere in the driver?
>>>
>>> This device itself doesn't do any DMA transactions so it needs no memory
>>> synchronization barriers. Only the consumer (i.e. rtkit and nvme) read/write
>>> from/to these buffers (multiple times) and they have the required barriers
>>> in place whenever they are used.
>>>
>>> These buffers so far are only allocated at probe time though so even using
>>> the normal writel/readl here won't hurt performance at all. I can just use
>>> those if you prefer or alternatively add a comment why _relaxed is fine here.
>>>
>>> This is a bit similar to the discussion for the pinctrl series last year [1].
>>
>> I think it's better to only use the _relaxed version where it actually helps,
>> with a comment about it, and use the normal version elsewhere, in
>> particular in functions that you have copied from the normal nvme driver.
>> I had tried to compare some of your code with the other version and
>> was rather confused by that.
> 
> Oh good, I tell folks the opposite (and others do too). We don't accept 
> random explicit barriers without explanation, but implicit ones are 
> okay? The resulting code on arm32 is also pretty horrible with the L2x0 
> and OMAP sync hooks not that that matters here.
> 
> I don't really care too much which way we go, but we should document one 
> rule and follow that.

I'm sure maz@ has an opinion here too :-)

(3... 2... 1... fight!)

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
