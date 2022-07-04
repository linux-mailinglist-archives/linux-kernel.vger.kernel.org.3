Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 863E1565C47
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 18:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234805AbiGDQia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 12:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233772AbiGDQi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 12:38:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB8C910DA
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 09:38:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2C375B80BA9
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 16:38:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F12DC3411E;
        Mon,  4 Jul 2022 16:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656952702;
        bh=mzG0J5YucAyiXuHgKf+Yrwf+nVvaGzlD91flHtMAJqU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UPBvt1m5LagRjTUnGpdL55TH6POJhdKUiYb/f9qV5b4BTLSTSYE6NXvrr/Sk4oOuB
         Dou9TT6a4GBPcrRpmb2hM0PVJrsMO2SBj3hx3Q7B5tRb+eFJMX2Hu6rpGKUkd9AkNZ
         GBNs/KbnZi1aRktiXcW81yaNCfGf9GBfw1YPrYcMFdOPTvWWwB7xy1O5W/uG/PToU2
         T3Zb58pVmsyfMz8hF9YVAJ4nMThFp2WlTV2nsZo/Fjq0uX6NrNG+8USsYthWjiU3sc
         H4J8+LUNrPOVxntBROCp+GxEkX/cEtmAezkg4ElE7RhSNQKjvbhceqwjbaP5jlLqpe
         d6qZ//6nD9JJA==
Date:   Mon, 4 Jul 2022 17:38:15 +0100
From:   Will Deacon <will@kernel.org>
To:     "guanghui.fgh" <guanghuifeng@linux.alibaba.com>
Cc:     baolin.wang@linux.alibaba.com, catalin.marinas@arm.com,
        akpm@linux-foundation.org, david@redhat.com, jianyong.wu@arm.com,
        james.morse@arm.com, quic_qiancai@quicinc.com,
        christophe.leroy@csgroup.eu, jonathan@marek.ca,
        mark.rutland@arm.com, thunder.leizhen@huawei.com,
        anshuman.khandual@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, rppt@kernel.org,
        geert+renesas@glider.be, ardb@kernel.org, linux-mm@kvack.org,
        yaohongbo@linux.alibaba.com, alikernel-developer@linux.alibaba.com
Subject: Re: [PATCH v4] arm64: mm: fix linear mem mapping access performance
 degradation
Message-ID: <20220704163815.GA32177@willie-the-truck>
References: <1656777473-73887-1-git-send-email-guanghuifeng@linux.alibaba.com>
 <20220704103523.GC31437@willie-the-truck>
 <73f0c53b-fd17-c5e9-3773-1d71e564eb50@linux.alibaba.com>
 <20220704111402.GA31553@willie-the-truck>
 <4accaeda-572f-f72d-5067-2d0999e4d00a@linux.alibaba.com>
 <20220704131516.GC31684@willie-the-truck>
 <2ae1cae0-ee26-aa59-7ed9-231d67194dce@linux.alibaba.com>
 <20220704142313.GE31684@willie-the-truck>
 <6977c692-78ca-5a67-773e-0389c85f2650@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6977c692-78ca-5a67-773e-0389c85f2650@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 04, 2022 at 10:34:07PM +0800, guanghui.fgh wrote:
> Thanks.
> 
> 在 2022/7/4 22:23, Will Deacon 写道:
> > On Mon, Jul 04, 2022 at 10:11:27PM +0800, guanghui.fgh wrote:
> > > 在 2022/7/4 21:15, Will Deacon 写道:
> > > > On Mon, Jul 04, 2022 at 08:05:59PM +0800, guanghui.fgh wrote:
> > > > > > > 1.Quoted messages from arch/arm64/mm/init.c
> > > > > > > 
> > > > > > > "Memory reservation for crash kernel either done early or deferred
> > > > > > > depending on DMA memory zones configs (ZONE_DMA) --
> > > > > > > 
> > > > > > > In absence of ZONE_DMA configs arm64_dma_phys_limit initialized
> > > > > > > here instead of max_zone_phys().  This lets early reservation of
> > > > > > > crash kernel memory which has a dependency on arm64_dma_phys_limit.
> > > > > > > Reserving memory early for crash kernel allows linear creation of block
> > > > > > > mappings (greater than page-granularity) for all the memory bank rangs.
> > > > > > > In this scheme a comparatively quicker boot is observed.
> > > > > > > 
> > > > > > > If ZONE_DMA configs are defined, crash kernel memory reservation
> > > > > > > is delayed until DMA zone memory range size initialization performed in
> > > > > > > zone_sizes_init().  The defer is necessary to steer clear of DMA zone
> > > > > > > memory range to avoid overlap allocation.
> > > > > > > 
> > > > > > > [[[
> > > > > > > So crash kernel memory boundaries are not known when mapping all bank memory
> > > > > > > ranges, which otherwise means not possible to exclude crash kernel range
> > > > > > > from creating block mappings so page-granularity mappings are created for
> > > > > > > the entire memory range.
> > > > > > > ]]]"
> > > > > > > 
> > > > > > > Namely, the init order: memblock init--->linear mem mapping(4k mapping for
> > > > > > > crashkernel, requirinig page-granularity changing))--->zone dma
> > > > > > > limit--->reserve crashkernel.
> > > > > > > So when enable ZONE DMA and using crashkernel, the mem mapping using 4k
> > > > > > > mapping.
> > > > > > 
> > > > > > Yes, I understand that is how things work today but I'm saying that we may
> > > > > > as well leave the crashkernel mapped (at block granularity) if
> > > > > > !can_set_direct_map() and then I think your patch becomes a lot simpler.
> > > > > 
> > > > > But Page-granularity mapppings are necessary for crash kernel memory range
> > > > > for shrinking its size via /sys/kernel/kexec_crash_size interfac(Quoted from
> > > > > arch/arm64/mm/init.c).
> > > > > So this patch split block/section mapping to 4k page-granularity mapping for
> > > > > crashkernel mem.
> > > > 
> > > > Why? I don't see why the mapping granularity is relevant at all if we
> > > > always leave the whole thing mapped.
> > > > 
> > > There is another reason.
> > > 
> > > When loading crashkernel finish, the do_kexec_load will use
> > > arch_kexec_protect_crashkres to invalid all the pagetable for crashkernel
> > > mem(protect crashkernel mem from access).
> > > 
> > > arch_kexec_protect_crashkres--->set_memory_valid--->...--->apply_to_pmd_range
> > > 
> > > In the apply_to_pmd_range, there is a judement： BUG_ON(pud_huge(*pud)). And
> > > if the crashkernel use block/section mapping, there will be some error.
> > > 
> > > Namely, it's need to use non block/section mapping for crashkernel mem
> > > before shringking.
> > 
> > Well, yes, but we can change arch_kexec_[un]protect_crashkres() not to do
> > that if we're leaving the thing mapped, no?
> > 
> I think we should use arch_kexec_[un]protect_crashkres for crashkernel mem.
> 
> Because when invalid crashkernel mem pagetable, there is no chance to rd/wr
> the crashkernel mem by mistake.
> 
> If we don't use arch_kexec_[un]protect_crashkres to invalid crashkernel mem
> pagetable, there maybe some write operations to these mem by mistake which
> may cause crashkernel boot error and vmcore saving error.

I don't really buy this line of reasoning. The entire main kernel is
writable, so why do we care about protecting the crashkernel so much? The
_code_ to launch the crash kernel is writable! If you care about preventing
writes to memory which should not be writable, then you should use
rodata=full.

Will
