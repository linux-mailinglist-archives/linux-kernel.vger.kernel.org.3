Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9F9C56388E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 19:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbiGARYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 13:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbiGARYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 13:24:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA218344DC
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 10:24:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 83BFBB830FA
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 17:24:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78BB2C3411E;
        Fri,  1 Jul 2022 17:24:32 +0000 (UTC)
Date:   Fri, 1 Jul 2022 18:24:28 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Guanghui Feng <guanghuifeng@linux.alibaba.com>
Cc:     baolin.wang@linux.alibaba.com, will@kernel.org,
        akpm@linux-foundation.org, david@redhat.com, jianyong.wu@arm.com,
        james.morse@arm.com, quic_qiancai@quicinc.com,
        christophe.leroy@csgroup.eu, jonathan@marek.ca,
        mark.rutland@arm.com, thunder.leizhen@huawei.com,
        anshuman.khandual@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, rppt@kernel.org,
        geert+renesas@glider.be, ardb@kernel.org, linux-mm@kvack.org,
        yaohongbo@linux.alibaba.com, alikernel-developer@linux.alibaba.com
Subject: Re: [PATCH v3] arm64: mm: fix linear mapping mem access performance
 degradation
Message-ID: <Yr8tzOJi5CGBl767@arm.com>
References: <1656586222-98555-1-git-send-email-guanghuifeng@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1656586222-98555-1-git-send-email-guanghuifeng@linux.alibaba.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 06:50:22PM +0800, Guanghui Feng wrote:
> +static void init_pmd_remap(pud_t *pudp, unsigned long addr, unsigned long end,
> +			   phys_addr_t phys, pgprot_t prot,
> +			   phys_addr_t (*pgtable_alloc)(int), int flags)
> +{
> +	unsigned long next;
> +	pmd_t *pmdp;
> +	phys_addr_t map_offset;
> +	pmdval_t pmdval;
> +
> +	pmdp = pmd_offset(pudp, addr);
> +	do {
> +		next = pmd_addr_end(addr, end);
> +
> +		if (!pmd_none(*pmdp) && pmd_sect(*pmdp)) {
> +			phys_addr_t pte_phys = pgtable_alloc(PAGE_SHIFT);
> +			pmd_clear(pmdp);
> +			pmdval = PMD_TYPE_TABLE | PMD_TABLE_UXN;
> +			if (flags & NO_EXEC_MAPPINGS)
> +				pmdval |= PMD_TABLE_PXN;
> +			__pmd_populate(pmdp, pte_phys, pmdval);
> +			flush_tlb_kernel_range(addr, addr + PAGE_SIZE);

This doesn't follow the architecture requirements for "break before
make" when changing live page tables. While it may work, it risks
triggering a TLB conflict abort. The correct sequence normally is:

	pmd_clear();
	flush_tlb_kernel_range();
	__pmd_populate();

However, do we have any guarantees that the kernel doesn't access the
pmd range being unmapped temporarily? The page table itself might live
in one of these sections, so set_pmd() etc. can get a translation fault.

-- 
Catalin
