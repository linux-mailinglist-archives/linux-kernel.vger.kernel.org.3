Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27F404FFBCA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 18:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235554AbiDMQ4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 12:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiDMQ4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 12:56:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C5D68301
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 09:53:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D70D61E71
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 16:53:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B77CBC385A3;
        Wed, 13 Apr 2022 16:53:41 +0000 (UTC)
Date:   Wed, 13 Apr 2022 17:53:38 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Guanghui Feng <guanghuifeng@linux.alibaba.com>
Cc:     will@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, baolin.wang@linux.alibaba.com
Subject: Re: [PATCH RFC v1] arm64: mm: change mem_map to use block/section
 mapping with crashkernel
Message-ID: <YlcAEo3lpKJg8HJf@arm.com>
References: <1649754476-8713-1-git-send-email-guanghuifeng@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1649754476-8713-1-git-send-email-guanghuifeng@linux.alibaba.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2022 at 05:07:56PM +0800, Guanghui Feng wrote:
> There are many changes and discussions:
> commit 031495635b46
> commit 1a8e1cef7603
> commit 8424ecdde7df
> commit 0a30c53573b0
> commit 2687275a5843
> 
> When using DMA/DMA32 zone and crashkernel, disable rodata full and kfence,
> mem_map will use non block/section mapping(for crashkernel requires to shrink
> the region in page granularity). But it will degrade performance when doing
> larging continuous mem access in kernel(memcpy/memmove, etc).
> 
> This patch firstly do block/section mapping at mem_map, reserve crashkernel
> memory. And then walking pagetable to split block/section mapping
> to non block/section mapping [only] for crashkernel mem. We will accelerate
> mem access about 10-20% performance improvement, and reduce the cpu dTLB miss
> conspicuously on some platform with this optimization.

Do you actually have some real world use-cases where this improvement
matters? I don't deny that large memcpy over the kernel linear map may
be slightly faster but where does this really matter?

> +static void init_crashkernel_pmd(pud_t *pudp, unsigned long addr,
> +				 unsigned long end, phys_addr_t phys,
> +				 pgprot_t prot,
> +				 phys_addr_t (*pgtable_alloc)(int), int flags)
> +{
> +	phys_addr_t map_offset;
> +	unsigned long next;
> +	pmd_t *pmdp;
> +	pmdval_t pmdval;
> +
> +	pmdp = pmd_offset(pudp, addr);
> +	do {
> +		next = pmd_addr_end(addr, end);
> +		if (!pmd_none(*pmdp) && pmd_sect(*pmdp)) {
> +			phys_addr_t pte_phys = pgtable_alloc(PAGE_SHIFT);
> +			pmd_clear(pmdp);
> +			pmdval = PMD_TYPE_TABLE | PMD_TABLE_UXN;
> +			if (flags & NO_EXEC_MAPPINGS)
> +				pmdval |= PMD_TABLE_PXN;
> +			__pmd_populate(pmdp, pte_phys, pmdval);
> +			flush_tlb_kernel_range(addr, addr + PAGE_SIZE);

The architecture requires us to do a break-before-make here, so
pmd_clear(), TLBI, __pmd_populate() - in this order. And that's where it
gets tricky, if the kernel happens to access this pmd range while it is
unmapped, you'd get a translation fault.

-- 
Catalin
