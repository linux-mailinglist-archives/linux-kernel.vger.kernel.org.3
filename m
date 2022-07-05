Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40582566F4B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 15:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232214AbiGENfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 09:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231324AbiGENew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 09:34:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 527901EAEC
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 05:56:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C5778B817DD
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 12:56:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2418C341C7;
        Tue,  5 Jul 2022 12:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657025794;
        bh=/DkYeQmQMOp7ocOqXErwSAITKoW0dXUGUzjZIpwaCAQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VlSYE0suFgc8JYonqgLLHklZJIU8r838nt4yo7iiToxsUJW9tT05b1sd9ghCytjjJ
         7QLZwcvp62iwxGzt6rYEL4o0jDGavZGwpXXKuo8y9GlnCasZA0NNyU6Ft1T+9ajkXY
         Ewqz/3GZQxsDhk8AyDzmuncJEIHOHKofOScSSsS1T/MVkrDR439ofwFqJRxf8KML3F
         3F9LsZC77qu69MhnVru5m+QVNe7whdhpiNVGHSN1IcdNA1TUQQpiN6+RfClV9X1Bt+
         1x2uzsIQXUIAuPKSM08LIhGMf/XkdCMn5jlxEphmTyeqiQjWkvX8/TZ/YqbG8wkFI+
         V/KMvE1nVJ79g==
Date:   Tue, 5 Jul 2022 15:56:14 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Will Deacon <will@kernel.org>
Cc:     "guanghui.fgh" <guanghuifeng@linux.alibaba.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        baolin.wang@linux.alibaba.com, catalin.marinas@arm.com,
        akpm@linux-foundation.org, david@redhat.com, jianyong.wu@arm.com,
        james.morse@arm.com, quic_qiancai@quicinc.com,
        christophe.leroy@csgroup.eu, jonathan@marek.ca,
        mark.rutland@arm.com, thunder.leizhen@huawei.com,
        anshuman.khandual@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, geert+renesas@glider.be,
        linux-mm@kvack.org, yaohongbo@linux.alibaba.com,
        alikernel-developer@linux.alibaba.com
Subject: Re: [PATCH v4] arm64: mm: fix linear mem mapping access performance
 degradation
Message-ID: <YsQ07kvZX5sO2ov2@kernel.org>
References: <4accaeda-572f-f72d-5067-2d0999e4d00a@linux.alibaba.com>
 <20220704131516.GC31684@willie-the-truck>
 <2ae1cae0-ee26-aa59-7ed9-231d67194dce@linux.alibaba.com>
 <20220704142313.GE31684@willie-the-truck>
 <6977c692-78ca-5a67-773e-0389c85f2650@linux.alibaba.com>
 <20220704163815.GA32177@willie-the-truck>
 <CAMj1kXEvY5QXOUrXZ7rBp9As=65uTTFRSSq+FPt-n4M2P-_VtQ@mail.gmail.com>
 <20220705095231.GB552@willie-the-truck>
 <5d044fdd-a61a-d60f-d294-89e17de37712@linux.alibaba.com>
 <20220705121115.GB1012@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220705121115.GB1012@willie-the-truck>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05, 2022 at 01:11:16PM +0100, Will Deacon wrote:
> On Tue, Jul 05, 2022 at 08:07:07PM +0800, guanghui.fgh wrote:
> > 
> > 1.The rodata full is harm to the performance and has been disabled in-house.
> > 
> > 2.When using crashkernel with rodata non full, the kernel also will use non
> > block/section mapping which cause high d-TLB miss and degrade performance
> > greatly.
> > This patch fix it to use block/section mapping as far as possible.
> > 
> > bool can_set_direct_map(void)
> > {
> > 	return rodata_full || debug_pagealloc_enabled();
> > }
> > 
> > map_mem:
> > if (can_set_direct_map() || IS_ENABLED(CONFIG_KFENCE))
> > 	flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
> > 
> > 3.When rodata full is disabled, crashkernel also need protect(keep
> > arch_kexec_[un]protect_crashkres using).
> > I think crashkernel should't depend on radata full(Maybe other architecture
> > don't support radata full now).
> 
> I think this is going round in circles :/
> 
> As a first step, can we please leave the crashkernel mapped unless
> rodata=full? It should be a much simpler patch to write, review and maintain
> and it gives you the performance you want when crashkernel is being used.

Since we are talking about large systems, what do you think about letting
them set CRASH_ALIGN to PUD_SIZE, then

	unmap(crashkernel);
	__create_pgd_mapping(crashkernel, NO_BLOCK_MAPPINGS);

should be enough to make crash kernel mapped with base pages.
 
> Will

-- 
Sincerely yours,
Mike.
