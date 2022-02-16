Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2BB4B928A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 21:39:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232604AbiBPUj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 15:39:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiBPUjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 15:39:55 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CBD92AF3D2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 12:39:42 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id y18so2883778plb.11
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 12:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=l0yXqLaXkDzRuyoi2/xFAHFgcqQhOzk3wyGzx4DsOBc=;
        b=FHD4YA3TmZO7g1EKJUaWqk3dV1npJy/TrX2A5AVZIpUX7DJ0xdg+N/z9bMVlC/+Sy7
         Sa9xo9PmeRKA524z91+WdTp+uDpAuxgQh54PByyR9WaHt0BQpRp3rEI6T5sXuvGrkVuH
         tTd0WvtPd0VP8pP0msvIDzAusFPw/mGvttecf2jsslkI6nb6F/x64hQ3zMr6d9KFYaIc
         /RkCKILuGfObiD1WAimgZwwveFO1TN64oXGX+b2K7Fv2eybT2kM61B3Ef5AVYj1nXDY4
         UDC7SJRBdDK+pr7+0JT9LbzYhoglViL7XzrtDSrhmanaiuj0DqDLzfAnr7UJzudf+pf5
         7Fbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=l0yXqLaXkDzRuyoi2/xFAHFgcqQhOzk3wyGzx4DsOBc=;
        b=lDMkj0W5PV50YVin/6QkrIPkx5qMuLhBrbkSH7NcwoZ/NiYqbFfqN81VVk5UtA2UPr
         LxclInbB4Ije+m8wY+DrioQJG7C5xnCxcp9N5BOXjaAxJwgSLBD9O92ownC4XhH+ZQkQ
         uhPHvX+OyTHeVQ/f5WIYbMdgDNLYsiLpQjFkjiTt5BPfpQ9C0hDfmpyDI807QbeI6T6p
         cWDiKr3hlN+xncirzPT+n4m7eHUI/SXUPbIaJn+BIRhQNT6qdbZ/1AUIjxGua3y6uXm5
         Zb2onHjOEnn5ndamT+QTc3TPV5kkcq6qne+dS3R0HfMexYLYxFn10D6y5Oal15GrF4YW
         8LHQ==
X-Gm-Message-State: AOAM533lxs2Izy2KM3giuuHZ+OOAtYI3cUTlZJZYD3Dm2AtQNQGr1tQ0
        ZszBLL8xcWF1ucAbiXB7Q5A=
X-Google-Smtp-Source: ABdhPJxxTUxkvqVV5KxYqxbtqqKN+2upRC+YRlTBpZlKqg9JidgNjV2PqilWoTKxwaK8PPD236G0Cw==
X-Received: by 2002:a17:90b:4b52:b0:1b8:c554:3bdd with SMTP id mi18-20020a17090b4b5200b001b8c5543bddmr3739118pjb.5.1645043982006;
        Wed, 16 Feb 2022 12:39:42 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id h14sm50167772pfh.95.2022.02.16.12.39.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Feb 2022 12:39:41 -0800 (PST)
Subject: Re: [PATCH] dma-contiguous: Prioritize restricted DMA pool over
 shared DMA pool
To:     Robin Murphy <robin.murphy@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
        opendmb@gmail.com, robh@kernel.org, will@kernel.org,
        tientzu@chromium.org, Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "open list:DMA MAPPING HELPERS" <iommu@lists.linux-foundation.org>
References: <20220215224344.1779145-1-f.fainelli@gmail.com>
 <39ed2187-2345-297d-2dd3-0b0974ce8b31@arm.com>
 <50ae9c05-2ec4-09a8-965c-0d70ea74d879@gmail.com>
 <27b10c12-e3f2-6ac4-26b5-44625e61d7ae@arm.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <4eac1aac-8fe6-3629-df17-b1264d976f3a@gmail.com>
Date:   Wed, 16 Feb 2022 12:39:39 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <27b10c12-e3f2-6ac4-26b5-44625e61d7ae@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/16/22 11:48 AM, Robin Murphy wrote:
> On 2022-02-16 17:37, Florian Fainelli wrote:
>> On 2/16/22 3:13 AM, Robin Murphy wrote:
>>> On 2022-02-15 22:43, Florian Fainelli wrote:
>>>> Some platforms might define the same memory region to be suitable for
>>>> used by a kernel supporting CONFIG_DMA_RESTRICTED_POOL while
>>>> maintaining
>>>> compatibility with older kernels that do not support that. This is
>>>> achieved by declaring the node this way;
>>>
>>> Those platforms are doing something inexplicably wrong, then.
>>
>> Matter of perspective I guess.
>>
>>>
>>> "restricted-dma-pool" says that DMA for the device has to be bounced
>>> through a dedicated pool because it can't be trusted with visibility of
>>> regular OS memory. "reusable" tells the OS that it's safe to use the
>>> pool as regular OS memory while it's idle. Do you see how those concepts
>>> are fundamentally incompatible?
>>
>>  From the perspective of the software or firmware agent that is
>> responsible for setting up the appropriate protection on the reserved
>> memory, it does not matter what the compatible string is, the only
>> properties that matter are the base address, size, and possibly whether
>> 'no-map' is specified or not to set-up appropriate protection for the
>> various memory controller agents (CPU, PCIe, everything else).
>>
>> Everything else is just information provided to the OS in order to
>> provide a different implementation keyed off the compatible string. So
>> with that in mind, you can imagine that before the introduction of
>> 'restricted-dma-pool' in 5.15, some platforms already had such a concept
>> of a reserved DMA region, that was backed by a device private CMA pool,
>> they would allocate memory from that region and would create their own
>> middle layer for bounce buffering if they liked to. This is obviously
>> not ideal on a number of levels starting from not being done at the
>> appropriate level but it was done.
>>
>> Now that 'restricted-dma-pool' is supported, transitioning them over is
>> obviously better and updating the compatible string for those specific
>> regions to include the more descriptive 'restrictded-dma-pool' sounded
>> to me as an acceptable way to maintain forward/backward DTB
>> compatibility rather than doubly reserving these region one with the
>> "old" compatible and one with the "new" compatible, not that the system
>> is even capable of doing that anyway, so we would have had to
>> essentially make them adjacent.
>>
>> And no, we are not bringing Linux version awareness to our boot loader
>> mangling the Device Tree blob, that's not happening, hence this patch.
> 
> If the patch was adding a "brcm,insecure-dma-pool" compatible and
> hooking it up, I'd be less bothered. As it is, I remain unconvinced that
> describing two things that are not interchangeable with each other as
> interchangeable with each other is in any way "better".

We most definitively should have done that but we did not because we
sort of like to maintain as fewer patches as possible against the
mainline kernel, believe it or not. Also, it would have been fun to
explain why we went with our own compatible string to obtain the same
semantics from the kernel as the generic one, but I will stick a pin in
that idea.

> 
>>> Linux is right to reject contradictory information rather than attempt
>>> to guess at what might be safe or not.
>>
>> The piece of contradictory information here specifically is the
>> 'reusable' boolean property, but as I explain the commit message
>> message, if you have a "properly formed" 'restricted-dma-pool' region
>> then it should not have that property in the first place, but even if it
>> does, it does not harm anything to have it.
>>
>>>
>>> Furthermore, down at the practical level, a SWIOTLB pool is used for
>>> bouncing streaming DMA API mappings, while a coherent/CMA pool is used
>>> for coherent DMA API allocations; they are not functionally
>>> interchangeable either. If a device depends on coherent allocations
>>> rather than streaming DMA, it should still have a coherent pool even
>>> under a physical memory protection scheme, and if it needs both
>>> streaming DMA and coherent buffers then it can have both types of pool -
>>> the bindings explicitly call that out. It's true that SWIOTLB pools can
>>> act as an emergency fallback for small allocations for I/O-coherent
>>> devices, but that's not really intended to be relied upon heavily.
>>>
>>> So no, I do not see anything wrong with the current handling of
>>> nonsensical DTs here, sorry.
>>
>> There is nothing wrong in the current code, but with changes that have
>> no adverse effect on "properly" constructed reserved memory entries we
>> can accept both types of reservation and maintain forward/backward
>> compatibility in our case. So why not?
> 
> Would you be happy to give me blanket permission to point a gun at your
> foot and pull the trigger at any point in the future, if right now I
> show you an unloaded gun?
> 
> Security and lazy shortcuts do not mix well.

Security is not enforced by the kernel here but by a piece of hardware
external to the CPU, that is true of the platforms that prompted the
'restricted-dma-pool' work in the first place by Claire. The compatible
string is irrelevant to that entity. There is no question this is lazy,
that is the whole point actually. The kernel is just communicated a
reserved memory region, if it can support a given behavior and expose a
set of services to do that, great, we leverage that, else we fall back
to another kind that we can also use, albeit differently.

> You are literally arguing
> that mainline Linux should support a back-door ABI for illegal DT
> properties which at worst has the potential to defeat a generic security
> feature.

Not quite, I am arguing that in the event that someone thought it was
possible to maintain his/her own notion of backward and forward
compatibility we *could* be supporting this. and with minimal amounts of
code to the kernel.

The kernel is not a trusted entity in the security model revolving
around the 'restricted-dma-pool' anyway which is why it is told where
these reserved memory regions are defined, and does not decide where to
place them. If the aperture is not set-up properly there is no DMA
to/from that region period so the results are pretty clear: you do not
get your device to work. Whether the kernel thinks that region is a
device-private CMA pool or a device-private SWIOTLB pool is largely
irrelevant in the security model that is a kernel mechanism on how you
want to leverage the region.

> The "restricted-dma-pool" binding explicitly says "When using
> this, the no-map and reusable properties must not be set" (I should spin
> up a patch enforcing that in the schema...).
> No matter how convinced you
> are that no OS past present or future could possibly ever behave
> differently from the particular downstream software stack you care
> about, NAK to subverting the "restricted-dma-pool" compatible in any
> way, sorry.
> I for one wish to have no part in the next
> trendy-name-compromise down the line where a protected VM can be tricked
> into exposing its page cache to a "DMA attack" by an untrusted
> hypervisor because fixing Florian's bootloader is hard.

I suppose your concern is that if we accept my patch, one could build a
kernel with CONFIG_DMA_RESTRICTED_POOL turned off to obtain a device
private CMA pool instead of a truly restricted DMA pool, then the
hypervisor allocates from that area and put sensitive stuff in there,
but later on we let a malicious VM-owned PCIe VF or actual PF DMA from
that location and we exfiltrate out of that location?

That exists today however as soon as an un-trusted DTB can be passed to
that hypervisor, so what is new here that I am missing? If you use the
example I provide in the patch, and given how the code is structured and
the link order, you will get a device private CMA pool instead of a
restricted DMA pool because kernel/dma/contiguous.c will match that
entry before kernel/dma/swiotlb.c (if built) does. Similarly if I can
mangle the DTB passed to the kernel to substitute "restricted-dma-pool'
with 'shared-dma-pool' I would obtain a different behavior for the
kernel than originally intended. The point though is that there should
be adequate security enforced around the reserved memory region in a way
that is orthogonal to the kernel.

Anyway, I thought this might be acceptable, I would like to hear from
others just in case, but will not pursue this router anymore unless
someone tells me otherwise. Thank you, I guess.
-- 
Florian
