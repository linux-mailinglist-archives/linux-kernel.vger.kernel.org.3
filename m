Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 325F355C292
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234104AbiF0Jti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 05:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiF0Jtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 05:49:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CDF15FC8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 02:49:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AA85EB80ECB
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 09:49:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F684C341C8;
        Mon, 27 Jun 2022 09:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656323367;
        bh=lJWk+ZM/8CuKn4jl1pGVvyZOF/4mTJyZtzz1FEVIr+A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t5vdQ9yyiawb2Yw1dKWIj339rFFdhRmHbHxXY7n7lXvF/7UcJnOJTOJoTDMAkWz83
         ctHVP1qYmst9pxRIed942RMcgwUMIQNzgmRvSxp0nbx/+WJTsrF95NkfpQXUfBLIpg
         VeS6+9d7tRYKIc8RNsNfJIaXuyHJFd+CGR7PPyyqU/h1zR9uRZXZ8Ty99em1Dy0YJO
         r2sb5JCzu8RGkdIasEcUk5BqsVx3hOhK1U2ldALP1lzOG9OwVmCLTQKWw2wZYvo9pR
         ffMY+2h+oMCPJoak2gGFbPcMn2PIWFc2d4RyzEYds8cB1vVW2shlSlhn1TD6Tfy5Kj
         PWPMNPqpdDG7Q==
Date:   Mon, 27 Jun 2022 12:49:09 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     "guanghui.fgh" <guanghuifeng@linux.alibaba.com>
Cc:     baolin.wang@linux.alibaba.com, catalin.marinas@arm.com,
        will@kernel.org, akpm@linux-foundation.org, david@redhat.com,
        jianyong.wu@arm.com, james.morse@arm.com, quic_qiancai@quicinc.com,
        christophe.leroy@csgroup.eu, jonathan@marek.ca,
        mark.rutland@arm.com, thunder.leizhen@huawei.com,
        anshuman.khandual@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, geert+renesas@glider.be,
        ardb@kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] arm64: mm: fix linear mapping mem access performace
 degradation
Message-ID: <Yrl9FcVv1wZ5MnRp@kernel.org>
References: <1656241815-28494-1-git-send-email-guanghuifeng@linux.alibaba.com>
 <YrlPfjv2Wf/C77DI@kernel.org>
 <4d18d303-aeed-0beb-a8a4-32893f2d438d@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4d18d303-aeed-0beb-a8a4-32893f2d438d@linux.alibaba.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please don't post HTML.

On Mon, Jun 27, 2022 at 05:24:10PM +0800, guanghui.fgh wrote:
> Thanks.
> 
> 在 2022/6/27 14:34, Mike Rapoport 写道:
> 
>     On Sun, Jun 26, 2022 at 07:10:15PM +0800, Guanghui Feng wrote:
> 
>         The arm64 can build 2M/1G block/sectiion mapping. When using DMA/DMA32 zone
>         (enable crashkernel, disable rodata full, disable kfence), the mem_map will
>         use non block/section mapping(for crashkernel requires to shrink the region
>         in page granularity). But it will degrade performance when doing larging
>         continuous mem access in kernel(memcpy/memmove, etc).
> 
>         There are many changes and discussions:
>         commit 031495635b46
>         commit 1a8e1cef7603
>         commit 8424ecdde7df
>         commit 0a30c53573b0
>         commit 2687275a5843
> 
>     Please include oneline summary of the commit. (See section "Describe your
>     changes" in Documentation/process/submitting-patches.rst)
> 
> OK, I will add oneline summary in the git commit messages.
> 
>         This patch changes mem_map to use block/section mapping with crashkernel.
>         Firstly, do block/section mapping(normally 2M or 1G) for all avail mem at
>         mem_map, reserve crashkernel memory. And then walking pagetable to split
>         block/section mapping to non block/section mapping(normally 4K) [[[only]]]
>         for crashkernel mem.
> 
>     This already happens when ZONE_DMA/ZONE_DMA32 are disabled. Please explain
>     why is it Ok to change the way the memory is mapped with
>     ZONE_DMA/ZONE_DMA32 enabled.
> 
> In short:
>
> 1.building all avail mem with block/section mapping（normally 1G/2M） without
> inspecting crashkernel
> 2. Reserve crashkernel mem as same as previous doing
> 3. only change the crashkernle mem mapping to normal mapping(normally 4k).
> With this method, there are block/section mapping as more as possible.

This does not answer the question why changing the way the memory is mapped
when there is ZONE_DMA/DMA32 and crashkernel won't cause a regression.

-- 
Sincerely yours,
Mike.
