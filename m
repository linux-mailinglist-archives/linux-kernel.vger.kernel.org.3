Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A140747415F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 12:20:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233471AbhLNLUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 06:20:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbhLNLUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 06:20:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44723C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 03:20:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 07BB8B81870
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 11:20:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0A1FC34601;
        Tue, 14 Dec 2021 11:20:38 +0000 (UTC)
Date:   Tue, 14 Dec 2021 11:20:35 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     Xiongfeng Wang <wangxiongfeng2@huawei.com>, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        moyufeng@huawei.com
Subject: Re: [RFC PATCH v2] arm64: barrier: add macro dgh() to control memory
 accesses merging
Message-ID: <Ybh+A27uNc02PoZt@arm.com>
References: <20211015090511.92421-1-wangxiongfeng2@huawei.com>
 <YWnBngJeIvV2S5IB@arm.com>
 <3303413f-a8de-bd41-4095-80ffa98cf75b@huawei.com>
 <YaoR874T6/tVLesz@arm.com>
 <20211214104620.GA13682@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211214104620.GA13682@willie-the-truck>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 10:46:20AM +0000, Will Deacon wrote:
> On Fri, Dec 03, 2021 at 12:47:47PM +0000, Catalin Marinas wrote:
> > On Fri, Oct 22, 2021 at 09:51:40AM +0800, Xiongfeng Wang wrote:
> > > On 2021/10/16 1:59, Catalin Marinas wrote:
> > > > On Fri, Oct 15, 2021 at 05:05:11PM +0800, Xiongfeng Wang wrote:
> > > >> diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
> > > >> index 451e11e5fd23..d71a7457d619 100644
> > > >> --- a/arch/arm64/include/asm/barrier.h
> > > >> +++ b/arch/arm64/include/asm/barrier.h
> > > >> @@ -18,6 +18,14 @@
> > > >>  #define wfe()		asm volatile("wfe" : : : "memory")
> > > >>  #define wfi()		asm volatile("wfi" : : : "memory")
> > > >>  
> > > >> +/*
> > > >> + * Data Gathering Hint:
> > > >> + * This instruction prohibits merging memory accesses with Normal-NC or
> > > >> + * Device-GRE attributes before the hint instruction with any memory accesses
> > > >> + * appearing after the hint instruction.
> > > >> + */
> > > >> +#define dgh()		asm volatile("hint #6" : : : "memory")
> > > > 
> > > > On its own, this patch doesn't do anything. It's more interesting to see
> > > > how it will be used and maybe come up with a common name that other
> > > > architectures would share (or just implement as no-opp). I'm not sure
> > > > there was any conclusion last time we discussed this.
> > > 
> > > In the last mail, I was suggested to investigate the code in other architecture
> > > to find if there exists similar interface. I searched 'merg' in the code and
> > > didn't find similar interface.
> > 
> > Maybe no other architecture has such hint. They have write buffer
> > draining but that's more expensive.
> > 
> > > The only thing similar I found is in Intel Software Developer's Manual. It says
> > > "Write Combining (WC) ... Writes may be delayed and combined in the write
> > > combining buffer (WC buffer) to reduce memory accesses. If the WC buffer is
> > > partially filled, the writes may be delayed until the next occurrence of a
> > > serializing event; such as an SFENCE or MFENCE instruction, CPUID or other
> > > serializing instruction, a read or write to uncached memory, an interrupt
> > > occurrence, or an execution of a LOCK instruction (including one with an
> > > XACQUIRE or XRELEASE prefix)."
> > > Maybe this is more like the write combine buffer flushing, not prevent merging.
> > > Sorry I still didn't understand the difference clearly.
> > 
> > IIUC those drivers on x86 just rely on the microarchitecture aspects of
> > the draining (e.g. fill 64 bytes). On Arm we don't have such guarantee
> > as there's a wide variation in implementations, hence the DGH
> > instruction.
> > 
> > > How about a common name called 'merge_prohibit_hint()'? Could you give me some
> > > suggestions ?
> > 
> > I think "prohibit" looks more like not allowing any write-buffer merge.
> > Maybe stop_merge_hint(), stop_write_buffer_merge(),
> > stop_write_combining() (any other ideas?). It would be a NOP on all
> > other architectures.
> 
> Given that DGH only affects prior memory accesses to Normal-NC or Device-GRE
> memory, we probably want to avoid making this too broad. We don't use GRE in
> Linux and I think Normal-NC is only exposed as an explicit part of the I/O
> accessors in ioremap_wc(). So I'd be inclined to add something like:
> 
> 	io_stop_wc()
> 
> with corresponding documentation in Documentation/memory-barriers.txt.

Looks fine to me.

-- 
Catalin
