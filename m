Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C46425A89CB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 02:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbiIAAZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 20:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiIAAZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 20:25:24 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 498294DB73
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 17:25:21 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id b128so12583288vsc.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 17:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=AGblqMJVeqiqTttXs8s6V0HV5agdHnP9p/xnbjr8B0c=;
        b=rNNkzHg+zTKGXzIjelCj5tVA/SWTxmt6zMstgmkxQJ+y4DLTwa2FggUUdbK2nobN8q
         Ah1N1gL1njUGKNEbP1VSpNIQRxMaL/xgz/o8u1HayqtpYrw+SICupqAXBUR7GU/dySkX
         /QdcuAvybWi+ncwXwwz91j7mPRhsPh58Hajpr9QPup8pE5aAPalZQt+KO7x4zwhYjEwL
         8druejYou1nVv4FmH0UGESWUwD4Bf/7M22uk6/pRiU+GG1MSSlU5SsrLw3d6c1yoOZxD
         tZPb1fzq/8AY+T6ZQdu9Y1JJKVhUsDrEU0jBxMg3+H9yoxzjumBdtBgul0RM5Eo+Ohht
         BBpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=AGblqMJVeqiqTttXs8s6V0HV5agdHnP9p/xnbjr8B0c=;
        b=uvwTzOUnp9T0hf3cH923bSU91OLhNkC+1RgcuslHv3CfqkRm4nQh+1inl6wYFLodyA
         Ijd24Nq0GYFi3UF8kIOzXsMmPZt9kOTBiNxoXfNXFjwkG6y3gBtltHzV8wj6x4tNQb9Q
         hinxgXORSxn08CgArcjjX/jMoU/8AUnR7YB3jhgnYHdIEwnVFYPC4ZqTfcpCepfHhfts
         Eooa+KDYq9191kcJsmqeAWPdFr4hUeQjT4vwTq4+Ykl+dP8DirPdoxOU8ALV9QvtP5t6
         SRpwyKG66mJvnnBq+yOLbQ/mf00VhNVHDoKQ3PAvO0daYeksX+AEfW0M5CHCCOfG3wsE
         0Zkg==
X-Gm-Message-State: ACgBeo2/QAHNW8TT9tLbZQmfgM/QYOEFTuZH/v4w1dvvL1OvHeu7mNXA
        1jPAZgxDY99Zr51j6f+QUctXZu1lXcp6zR44G73law==
X-Google-Smtp-Source: AA6agR6ZSxxR/lJdTS2J/z5wkfKlYaaaUZqO+2MkqmK4V55gn/u+LkXUcGZU2TnuvZhTvo5q1P4Ah77ta2+R39O0njM=
X-Received: by 2002:a05:6102:5094:b0:388:6903:5f09 with SMTP id
 bl20-20020a056102509400b0038869035f09mr7218977vsb.46.1661991920124; Wed, 31
 Aug 2022 17:25:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220829232934.3277747-1-yuzhao@google.com> <20220831063818.3902572-1-yuzhao@google.com>
 <747f76e1-a5ec-150c-311e-a60396f6f7ab@oracle.com>
In-Reply-To: <747f76e1-a5ec-150c-311e-a60396f6f7ab@oracle.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Wed, 31 Aug 2022 18:24:43 -0600
Message-ID: <CAOUHufYHh3B6A8_pAusnW5==r3VhPxy6bOoUHbxe0qvhNGovqA@mail.gmail.com>
Subject: Re: [PATCH v2] Revert "swiotlb: panic if nslabs is too small"
To:     Dongli Zhang <dongli.zhang@oracle.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        iommu@lists.linux.dev, linux-mips@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 4:20 PM Dongli Zhang <dongli.zhang@oracle.com> wrote:
>
> Hi Yu,
>
> As we discussed in the past, the swiotlb panic on purpose

We should not panic() at all, especially on a platform that has been
working well since at least 4.14.

Did you check out this link I previously shared with you?
https://lore.kernel.org/r/CAHk-=wit-DmhMfQErY29JSPjFgebx_Ld+pnerc4J2Ag990WwAA@mail.gmail.com/

> because the
> mips/cavium-octeon/dma-octeon.c requests to allocate only PAGE_SIZE swiotlb
> buffer.

What's wrong with PAGE_SIZE swiotlb?

> This is smaller than IO_TLB_MIN_SLABS.

IO_TLB_MIN_SLABS is an arbitrary number, and it's inherited from IA64.
So does the comment below. What exactly is the rationale behind it?

> The below comments mentioned that IO_TLB_MIN_SLABS is the "Minimum IO TLB size
> to bother booting with".
>
> 56 /*
> 57  * Minimum IO TLB size to bother booting with.  Systems with mainly
> 58  * 64bit capable cards will only lightly use the swiotlb.  If we can't
> 59  * allocate a contiguous 1MB, we're probably in trouble anyway.
> 60  */
> 61 #define IO_TLB_MIN_SLABS ((1<<20) >> IO_TLB_SHIFT)
>
>
> The arm may create swiotlb conditionally. That is, the swiotlb is not
> initialized if (1) CONFIG_ARM_LPAE is not set (line 273), or (2) max_pfn <=
> arm_dma_pfn_limit (line 274).
>
> arch/arm/mm/init.c
>
> 271 void __init mem_init(void)
> 272 {
> 273 #ifdef CONFIG_ARM_LPAE
> 274         swiotlb_init(max_pfn > arm_dma_pfn_limit, SWIOTLB_VERBOSE);
> 275 #endif
> 276
> 277         set_max_mapnr(pfn_to_page(max_pfn) - mem_map);
>
>
> On x86, the swiotlb is not initialized if the memory is small (> MAX_DMA32_PFN,
> at line 47), or the secure memory is not required.
>
> 44 static void __init pci_swiotlb_detect(void)
> 45 {
> 46         /* don't initialize swiotlb if iommu=off (no_iommu=1) */
> 47         if (!no_iommu && max_possible_pfn > MAX_DMA32_PFN)
> 48                 x86_swiotlb_enable = true;
> 49
> 50         /*
> 51          * Set swiotlb to 1 so that bounce buffers are allocated and used for
> 52          * devices that can't support DMA to encrypted memory.
> 53          */
> 54         if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT))
> 55                 x86_swiotlb_enable = true;
> 56
> 57         /*
> 58          * Guest with guest memory encryption currently perform all DMA through
> 59          * bounce buffers as the hypervisor can't access arbitrary VM memory
> 60          * that is not explicitly shared with it.
> 61          */
> 62         if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT)) {
> 63                 x86_swiotlb_enable = true;
> 64                 x86_swiotlb_flags |= SWIOTLB_FORCE;
> 65         }
> 66 }

Thanks for the code snippets. But I failed to see a point.

> Regardless whether the current patch will be reverted, unless there is specific
> reason (e.g., those PAGE_SIZE will be used), I do not think it is a good idea to
> allocate <IO_TLB_MIN_SLABS swiotlb buffer.

For what specific reason? My current understanding is that you want to
be future/fool-proof. If so, then you got the priority wrong. We need
to make sure currently working systems continue to work first, then
future/fool-proof.

> I will wait for the suggestion from
> the swiotlb maintainer.

Chris is on vacation. I sure can wait.

But it sounds like you are unsure about what to do. If so, it's not
what you claimed "we have already understood everything related to
swiotlb" previously.

> Since I do not have a mips environment, I am not able to test if the below makes
> any trouble in your situation at arch/mips/cavium-octeon/dma-octeon.c.
>
> @@ -234,6 +234,8 @@ void __init plat_swiotlb_setup(void)
>                 swiotlbsize = 64 * (1<<20);
>  #endif
>
> -       swiotlb_adjust_size(swiotlbsize);
> -       swiotlb_init(true, SWIOTLB_VERBOSE);
> +       if (swiotlbsize != PAGE_SIZE) {
> +               swiotlb_adjust_size(swiotlbsize);
> +               swiotlb_init(true, SWIOTLB_VERBOSE);
> +       }
>  }

Please ask the MIPS/Octeon maintainers to check this first.
