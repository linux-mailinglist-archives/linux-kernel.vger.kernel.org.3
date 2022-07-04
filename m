Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7BD5656CC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 15:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234301AbiGDNPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 09:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234561AbiGDNP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 09:15:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD90B48D
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 06:15:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 712B8B80EEC
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 13:15:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 912B2C3411E;
        Mon,  4 Jul 2022 13:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656940524;
        bh=W4jY2582373XRTfcKBJP0Y10Z3L0De/BiuG1GjmXPVE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rO40aR8JqCr9UpcglvqfoRbslQJROtvQhCq6vvefcP3fF4p/PTrmcyYEexIR1qrO1
         c6Q21r3H30D8Gg/jJcsP5kAQKNCAIyFoSOzZghoO779bV3N+kYPDB+aHhBIZzd7wnE
         T5bfOhz2ptu+Af1v9Q0/oOJLkWobYQ2bDUI7zY1MJtFUkT5SePHD/yAS5DlJvZ8A00
         LmGC+XEqh/bPyC+lgn6/mKelWvVpJuY5roj1bQHAOkbwpWvS8EJSZZ02B8h8CxDBmc
         PxoatHneSFnAClVGEl/MxgSZY52FBuVcTSdJdf2FPX24XaEkAwdXfwLb4PgCjgUtgY
         rCLa/7WXYfKTg==
Date:   Mon, 4 Jul 2022 14:15:16 +0100
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
Message-ID: <20220704131516.GC31684@willie-the-truck>
References: <1656777473-73887-1-git-send-email-guanghuifeng@linux.alibaba.com>
 <20220704103523.GC31437@willie-the-truck>
 <73f0c53b-fd17-c5e9-3773-1d71e564eb50@linux.alibaba.com>
 <20220704111402.GA31553@willie-the-truck>
 <4accaeda-572f-f72d-5067-2d0999e4d00a@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4accaeda-572f-f72d-5067-2d0999e4d00a@linux.alibaba.com>
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

On Mon, Jul 04, 2022 at 08:05:59PM +0800, guanghui.fgh wrote:
> 
> 
> 在 2022/7/4 19:14, Will Deacon 写道:
> > On Mon, Jul 04, 2022 at 06:58:20PM +0800, guanghui.fgh wrote:
> > > 
> > > 
> > > 在 2022/7/4 18:35, Will Deacon 写道:
> > > > On Sat, Jul 02, 2022 at 11:57:53PM +0800, Guanghui Feng wrote:
> > > > > The arm64 can build 2M/1G block/sectiion mapping. When using DMA/DMA32 zone
> > > > > (enable crashkernel, disable rodata full, disable kfence), the mem_map will
> > > > > use non block/section mapping(for crashkernel requires to shrink the region
> > > > > in page granularity). But it will degrade performance when doing larging
> > > > > continuous mem access in kernel(memcpy/memmove, etc).
> > > > 
> > > > Hmm. It seems a bit silly to me that we take special care to unmap the
> > > > crashkernel from the linear map even when can_set_direct_map() is false, as
> > > > we won't be protecting the main kernel at all!
> > > > 
> > > > Why don't we just leave the crashkernel mapped if !can_set_direct_map()
> > > > and then this problem just goes away?
> > > 
> > > This question had been asked lask week.
> > 
> > Sorry, I didn't spot that. Please could you link me to the conversation, as
> > I'm still unable to find it in my inbox?
> 
> Please access this link:
> https://lore.kernel.org/linux-arm-kernel/075b0a8e-cb7e-70f6-b45a-54cd31886794@linux.alibaba.com/T/

Sorry, but I read through the thread and I still can't find where the
possibility of leaving the crashkernel mapped was discussed.

> > > 1.Quoted messages from arch/arm64/mm/init.c
> > > 
> > > "Memory reservation for crash kernel either done early or deferred
> > > depending on DMA memory zones configs (ZONE_DMA) --
> > > 
> > > In absence of ZONE_DMA configs arm64_dma_phys_limit initialized
> > > here instead of max_zone_phys().  This lets early reservation of
> > > crash kernel memory which has a dependency on arm64_dma_phys_limit.
> > > Reserving memory early for crash kernel allows linear creation of block
> > > mappings (greater than page-granularity) for all the memory bank rangs.
> > > In this scheme a comparatively quicker boot is observed.
> > > 
> > > If ZONE_DMA configs are defined, crash kernel memory reservation
> > > is delayed until DMA zone memory range size initialization performed in
> > > zone_sizes_init().  The defer is necessary to steer clear of DMA zone
> > > memory range to avoid overlap allocation.
> > > 
> > > [[[
> > > So crash kernel memory boundaries are not known when mapping all bank memory
> > > ranges, which otherwise means not possible to exclude crash kernel range
> > > from creating block mappings so page-granularity mappings are created for
> > > the entire memory range.
> > > ]]]"
> > > 
> > > Namely, the init order: memblock init--->linear mem mapping(4k mapping for
> > > crashkernel, requirinig page-granularity changing))--->zone dma
> > > limit--->reserve crashkernel.
> > > So when enable ZONE DMA and using crashkernel, the mem mapping using 4k
> > > mapping.
> > 
> > Yes, I understand that is how things work today but I'm saying that we may
> > as well leave the crashkernel mapped (at block granularity) if
> > !can_set_direct_map() and then I think your patch becomes a lot simpler.
> 
> But Page-granularity mapppings are necessary for crash kernel memory range
> for shrinking its size via /sys/kernel/kexec_crash_size interfac(Quoted from
> arch/arm64/mm/init.c).
> So this patch split block/section mapping to 4k page-granularity mapping for
> crashkernel mem.

Why? I don't see why the mapping granularity is relevant at all if we
always leave the whole thing mapped.

Will
