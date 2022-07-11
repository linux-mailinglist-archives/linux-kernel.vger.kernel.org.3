Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 467D7570363
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 14:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbiGKMyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 08:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232187AbiGKMyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 08:54:16 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1700E26ACA
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 05:54:15 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id r10so721327wrv.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 05:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=zjEIh4DqFEXRLYwuzGFMNC/3I63SrKxPqVblwnhPmog=;
        b=kJA/NAnsNsjB3IBO7apOW66xuZ2zMyaJxMhEURJWw1AwKCAKPExd0qEE3n+vu0wSYb
         CS2PCCgRiEn3I6CslpnOCHwUorwpj6K8k0IgRrGFjn824TgreOnqK8tZwz+4vfN8ytgY
         icHgMkdCeKHMWvpsvaIfl939GMlDT3Qfw1YZeoJpC7HsKakEY/QZ029hacHl7TBQ5pR9
         T8x1tiwT5HOx9mCxfaGA3AD7/N8EPrOe/P1BZODfpGh3dWB3/5Lo62edJA4b4ZuQlkzc
         QXuK6qboNB9OK+040ZMV4tHRgRGIZnmjgeJcXRYLtq4GJCmnNeioX+AgmHjI6JgKEg2b
         kf+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zjEIh4DqFEXRLYwuzGFMNC/3I63SrKxPqVblwnhPmog=;
        b=1/guOT6DDXwA7g09x/NCP4VPaq5QCLKkBSbhIqa4672gXraJrG6Q7ymu5xS50Njp2i
         uvUfkuA43RbuKnvqvIZvmY9Vr8fbqS1nvG08T6qnJ54E9e1MOOg2k49xyoGMhYDH9gfj
         IQ/KnF33NH4F96VO8QA6x499Vz6k7qq9H5Dfb6MJnm2v8vhGI9rCdtWf7KGgNGu7cf21
         HRA8QU7443c9wlZTH/JPBEPtc2URfH5FWVByZsHj6x00l1ObN31NDuZ/XDVBt4tSgKwA
         /DF0f8oNS2fbeAZNtNSIWWCoPHOGskapfERTUhxTbPCzEwhye7s89zlE9nQsUyO8UTOc
         Mk3g==
X-Gm-Message-State: AJIora8YP8gxctDbCHKBcZwuoWiH9vN+Z6p/z+eRe1Hv6I4Dibh+z9r+
        NwFthBaeSkZZLDxiUh518XCNiKm+NQ5ocfbg
X-Google-Smtp-Source: AGRyM1sEUkePYczWBSqEyhSQyn8LZryJCwMsuoh8eIAEeLas5yuDPs6yaRkyucKd4Hlu6ig/uWlZRw==
X-Received: by 2002:a5d:4a01:0:b0:21d:8ce1:8b6d with SMTP id m1-20020a5d4a01000000b0021d8ce18b6dmr16532000wrq.718.1657544053570;
        Mon, 11 Jul 2022 05:54:13 -0700 (PDT)
Received: from [10.35.4.171] ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id l5-20020a05600c4f0500b003a04e6410e0sm10142773wmq.33.2022.07.11.05.54.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 05:54:12 -0700 (PDT)
Message-ID: <265d7b6b-a0a4-ecaf-10bd-15e1ea416a06@sifive.com>
Date:   Mon, 11 Jul 2022 13:54:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] swiotlb: ensure io_tlb_default_mem spinlock always
 initialised
Content-Language: en-GB
To:     Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
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
 <ac4944b8-5d15-4761-6315-7dba6eaee0e7@arm.com>
From:   Ben Dooks <ben.dooks@sifive.com>
In-Reply-To: <ac4944b8-5d15-4761-6315-7dba6eaee0e7@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/07/2022 12:01, Robin Murphy wrote:
> On 2022-07-11 11:42, Ben Dooks wrote:
>> On 11/07/2022 11:39, Christoph Hellwig wrote:
>>> On Mon, Jul 11, 2022 at 11:24:51AM +0100, Ben Dooks wrote:
>>>> On 11/07/2022 11:21, Christoph Hellwig wrote:
>>>>> On Mon, Jul 11, 2022 at 11:07:17AM +0100, Robin Murphy wrote:
>>>>>> If none of your peripherals should need SWIOTLB, then the fact that
>>>>>> you're ending up in swiotlb_map() at all is a clear sign that
>>>>>> something's wrong. Most likely someone's forgotten to set their DMA
>>>>>> masks correctly.
>>>>>
>>>>> Yes.
>>>>
>>>> Possibly, we had at least one driver which attempted to set a 32 bit
>>>> DMA mask which had to be removed as the DMA layer accepts this but
>>>> since there is no DMA32 memory the allocator then just fails.
>>>>
>>>> I expect the above may need to be a separate discussion(s) of how to
>>>> default the DMA mask and how to stop the implicit acceptance of setting
>>>> a 32-bit DMA mask.
>>>
>>> No.  Linux simply assumes you can do 32-bit DMA and this won't
>>> change.  So we'll need to fix your platform to support swiotlb
>>> eventually.
>>
>> Ok, is there any examples currently in the kernel that have no memory
>> in the DMA32 zone that do use swiotlb?
> 
> The arm64 code originally made an assumption that a system with that 
> kind of memory layout would use a DMA offset in the interconnect, and so 
> placed ZONE_DMA32 in the first 4GB of available RAM rather than actual 
> physical address space. The only relatively mainstream platform we 
> subsequently saw with all RAM above 32 bits was AMD Seattle, which also 
> *didn't* use a DMA offset, so it "worked" by virtue of this bodge in the 
> sense that allocations didn't fail, but DMA transactions would then 
> disappear off into nowhere when the device truncated the MSBs of 
> whatever too-big DMA address it was given.
> 
> I think that stuff's long gone by now, and if any of handful of 
> remaining Seattle users plug in a 32-bit PCIe device and try to use it 
> with the IOMMU disabled, they'll probably see the fireworks as intended.
> 
> Much as we'd like to make DMA an explicit opt-in for all drivers, that's 
> something which can only really be solved 30 years ago.

I need to go back and check through what we did to get some that worked
for us, and then come back and try and make some idea of how that is
best done with upstream kernel.

It might be possible for the PCIe controller to do some sort of very
simple IOMMU for the case where we might have somehow an PCI device
added to the system, but that is a very rare use-case I expect and
if someone does it they can do the effort of updating the PCIe code
and everything else that goes with it.

-- 
Ben

