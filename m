Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33F824B8F48
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 18:38:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237198AbiBPRiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 12:38:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236646AbiBPRiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 12:38:12 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E69C9A9A8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 09:37:58 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id d187so2686083pfa.10
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 09:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xKWNPErVMGQufioCW/qqLYLJrDk+7uqAfpmgky9+H0g=;
        b=nR7qUVxsrONuU7dHcrwwAP7NQ0egh4qC86H13RFU+ZxhAzpC4G5/lZPRySMHur9UYp
         arbZvfO/bcceCgvNfc6/+iG4AGuh6MY775KclpU42+hl27vxtkWkbHW6efL587qdbUdM
         9oVUbu36pzLUF/g9g7mIR2OHWwWPyqgzvMuEAjgWikODdrhInuhP6OSav2y7TL+wpTVl
         Sk1NFKXM5OJ93Fzm5RJEfImD08oU+kybm6HuGtlPAjJpzlKHZgKGRHxZ/EEOSr+Xs+/O
         dS+qFY6PE/nlt4PmR//J4S+nfPBPNBwaTyf6ExtWHgN9pBn/dnOkifGNV6c6tRPBOvEN
         wInA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xKWNPErVMGQufioCW/qqLYLJrDk+7uqAfpmgky9+H0g=;
        b=LCTzoKWSEvpcZ+Th0rCpyaHr1vXmw5utUv3v5yo6o2pz4OU3dKT7GkCiaNfDwB1GZA
         p426chKLEcMbledI1UEaAaqT/MVS4QmGnG7vcXKE59vGNRE5z+MVfMDg6Xds6x+7633Y
         G3fbdNuiIOaiEpQJu650bKCHuyjaLWP8Lz35mXmtpbK6bKpKxZNV5AT+wsj33GTL/7wa
         zWquBM29VKTzF2KQa+/9C8tiz+6PZcnok8FvcmIxxjnbJN6+FhOXRaAIMeiKvtupOPhB
         MHPWrEzQ/O9WgeArR4/Ru02s+RH/fQyH6kBbPvkAHPLRwn7YAaxmVwygeiO+gWdqtoiM
         5KFQ==
X-Gm-Message-State: AOAM532+Y65GC+l15GIIdoJUR9s9mk2sDYMKsk2lHZ6I6SH4N4oL4VdL
        yu7BgLTQRu67nluauO/NtOg=
X-Google-Smtp-Source: ABdhPJxAUyUhwYWwsVuwu50HkmYt/yVB7saLqaVbzXLlqKAD8LuDwqg2pYUGRDML9SUNy5ni4StB5w==
X-Received: by 2002:a05:6a00:21c6:b0:49f:dcb7:2bf2 with SMTP id t6-20020a056a0021c600b0049fdcb72bf2mr4104026pfj.19.1645033078197;
        Wed, 16 Feb 2022 09:37:58 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id ob12sm14203422pjb.5.2022.02.16.09.37.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Feb 2022 09:37:57 -0800 (PST)
Subject: Re: [PATCH] dma-contiguous: Prioritize restricted DMA pool over
 shared DMA pool
To:     Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org
Cc:     bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
        opendmb@gmail.com, robh@kernel.org, will@kernel.org,
        tientzu@chromium.org, Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "open list:DMA MAPPING HELPERS" <iommu@lists.linux-foundation.org>
References: <20220215224344.1779145-1-f.fainelli@gmail.com>
 <39ed2187-2345-297d-2dd3-0b0974ce8b31@arm.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <50ae9c05-2ec4-09a8-965c-0d70ea74d879@gmail.com>
Date:   Wed, 16 Feb 2022 09:37:55 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <39ed2187-2345-297d-2dd3-0b0974ce8b31@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/16/22 3:13 AM, Robin Murphy wrote:
> On 2022-02-15 22:43, Florian Fainelli wrote:
>> Some platforms might define the same memory region to be suitable for
>> used by a kernel supporting CONFIG_DMA_RESTRICTED_POOL while maintaining
>> compatibility with older kernels that do not support that. This is
>> achieved by declaring the node this way;
> 
> Those platforms are doing something inexplicably wrong, then.

Matter of perspective I guess.

> 
> "restricted-dma-pool" says that DMA for the device has to be bounced
> through a dedicated pool because it can't be trusted with visibility of
> regular OS memory. "reusable" tells the OS that it's safe to use the
> pool as regular OS memory while it's idle. Do you see how those concepts
> are fundamentally incompatible?

From the perspective of the software or firmware agent that is
responsible for setting up the appropriate protection on the reserved
memory, it does not matter what the compatible string is, the only
properties that matter are the base address, size, and possibly whether
'no-map' is specified or not to set-up appropriate protection for the
various memory controller agents (CPU, PCIe, everything else).

Everything else is just information provided to the OS in order to
provide a different implementation keyed off the compatible string. So
with that in mind, you can imagine that before the introduction of
'restricted-dma-pool' in 5.15, some platforms already had such a concept
of a reserved DMA region, that was backed by a device private CMA pool,
they would allocate memory from that region and would create their own
middle layer for bounce buffering if they liked to. This is obviously
not ideal on a number of levels starting from not being done at the
appropriate level but it was done.

Now that 'restricted-dma-pool' is supported, transitioning them over is
obviously better and updating the compatible string for those specific
regions to include the more descriptive 'restrictded-dma-pool' sounded
to me as an acceptable way to maintain forward/backward DTB
compatibility rather than doubly reserving these region one with the
"old" compatible and one with the "new" compatible, not that the system
is even capable of doing that anyway, so we would have had to
essentially make them adjacent.

And no, we are not bringing Linux version awareness to our boot loader
mangling the Device Tree blob, that's not happening, hence this patch.

> 
> Linux is right to reject contradictory information rather than attempt
> to guess at what might be safe or not.

The piece of contradictory information here specifically is the
'reusable' boolean property, but as I explain the commit message
message, if you have a "properly formed" 'restricted-dma-pool' region
then it should not have that property in the first place, but even if it
does, it does not harm anything to have it.

> 
> Furthermore, down at the practical level, a SWIOTLB pool is used for
> bouncing streaming DMA API mappings, while a coherent/CMA pool is used
> for coherent DMA API allocations; they are not functionally
> interchangeable either. If a device depends on coherent allocations
> rather than streaming DMA, it should still have a coherent pool even
> under a physical memory protection scheme, and if it needs both
> streaming DMA and coherent buffers then it can have both types of pool -
> the bindings explicitly call that out. It's true that SWIOTLB pools can
> act as an emergency fallback for small allocations for I/O-coherent
> devices, but that's not really intended to be relied upon heavily.
> 
> So no, I do not see anything wrong with the current handling of
> nonsensical DTs here, sorry.

There is nothing wrong in the current code, but with changes that have
no adverse effect on "properly" constructed reserved memory entries we
can accept both types of reservation and maintain forward/backward
compatibility in our case. So why not?
-- 
Florian
