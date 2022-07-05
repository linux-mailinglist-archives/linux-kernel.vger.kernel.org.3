Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6265672BB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 17:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbiGEPeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 11:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbiGEPeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 11:34:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FE4D13DE9
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 08:34:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 81BD161B18
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 15:34:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE516C341C7;
        Tue,  5 Jul 2022 15:34:13 +0000 (UTC)
Date:   Tue, 5 Jul 2022 16:34:09 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        "guanghui.fgh" <guanghuifeng@linux.alibaba.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        baolin.wang@linux.alibaba.com, akpm@linux-foundation.org,
        david@redhat.com, jianyong.wu@arm.com, james.morse@arm.com,
        quic_qiancai@quicinc.com, christophe.leroy@csgroup.eu,
        jonathan@marek.ca, mark.rutland@arm.com,
        thunder.leizhen@huawei.com, anshuman.khandual@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        geert+renesas@glider.be, linux-mm@kvack.org,
        yaohongbo@linux.alibaba.com, alikernel-developer@linux.alibaba.com
Subject: Re: [PATCH v4] arm64: mm: fix linear mem mapping access performance
 degradation
Message-ID: <YsRZ8V8mQ+HM31D6@arm.com>
References: <20220704131516.GC31684@willie-the-truck>
 <2ae1cae0-ee26-aa59-7ed9-231d67194dce@linux.alibaba.com>
 <20220704142313.GE31684@willie-the-truck>
 <6977c692-78ca-5a67-773e-0389c85f2650@linux.alibaba.com>
 <20220704163815.GA32177@willie-the-truck>
 <CAMj1kXEvY5QXOUrXZ7rBp9As=65uTTFRSSq+FPt-n4M2P-_VtQ@mail.gmail.com>
 <20220705095231.GB552@willie-the-truck>
 <5d044fdd-a61a-d60f-d294-89e17de37712@linux.alibaba.com>
 <20220705121115.GB1012@willie-the-truck>
 <YsRSajyMxahXe7ZS@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YsRSajyMxahXe7ZS@kernel.org>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05, 2022 at 06:02:02PM +0300, Mike Rapoport wrote:
> +void __init remap_crashkernel(void)
> +{
> +#ifdef CONFIG_KEXEC_CORE
> +	phys_addr_t start, end, size;
> +	phys_addr_t aligned_start, aligned_end;
> +
> +	if (can_set_direct_map() || IS_ENABLED(CONFIG_KFENCE))
> +	    return;
> +
> +	if (!crashk_res.end)
> +	    return;
> +
> +	start = crashk_res.start & PAGE_MASK;
> +	end = PAGE_ALIGN(crashk_res.end);
> +
> +	aligned_start = ALIGN_DOWN(crashk_res.start, PUD_SIZE);
> +	aligned_end = ALIGN(end, PUD_SIZE);
> +
> +	/* Clear PUDs containing crash kernel memory */
> +	unmap_hotplug_range(__phys_to_virt(aligned_start),
> +			    __phys_to_virt(aligned_end), false, NULL);

What I don't understand is what happens if there's valid kernel data
between aligned_start and crashk_res.start (or the other end of the
range).

-- 
Catalin
