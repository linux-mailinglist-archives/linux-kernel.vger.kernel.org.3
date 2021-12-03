Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9894446779A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 13:48:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380903AbhLCMvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 07:51:19 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:59006 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352128AbhLCMvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 07:51:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 25707B826B1
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 12:47:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 858C0C53FAD;
        Fri,  3 Dec 2021 12:47:50 +0000 (UTC)
Date:   Fri, 3 Dec 2021 12:47:47 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     mark.rutland@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        moyufeng@huawei.com
Subject: Re: [RFC PATCH v2] arm64: barrier: add macro dgh() to control memory
 accesses merging
Message-ID: <YaoR874T6/tVLesz@arm.com>
References: <20211015090511.92421-1-wangxiongfeng2@huawei.com>
 <YWnBngJeIvV2S5IB@arm.com>
 <3303413f-a8de-bd41-4095-80ffa98cf75b@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3303413f-a8de-bd41-4095-80ffa98cf75b@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xiongfeng,

On Fri, Oct 22, 2021 at 09:51:40AM +0800, Xiongfeng Wang wrote:
> On 2021/10/16 1:59, Catalin Marinas wrote:
> > On Fri, Oct 15, 2021 at 05:05:11PM +0800, Xiongfeng Wang wrote:
> >> diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
> >> index 451e11e5fd23..d71a7457d619 100644
> >> --- a/arch/arm64/include/asm/barrier.h
> >> +++ b/arch/arm64/include/asm/barrier.h
> >> @@ -18,6 +18,14 @@
> >>  #define wfe()		asm volatile("wfe" : : : "memory")
> >>  #define wfi()		asm volatile("wfi" : : : "memory")
> >>  
> >> +/*
> >> + * Data Gathering Hint:
> >> + * This instruction prohibits merging memory accesses with Normal-NC or
> >> + * Device-GRE attributes before the hint instruction with any memory accesses
> >> + * appearing after the hint instruction.
> >> + */
> >> +#define dgh()		asm volatile("hint #6" : : : "memory")
> > 
> > On its own, this patch doesn't do anything. It's more interesting to see
> > how it will be used and maybe come up with a common name that other
> > architectures would share (or just implement as no-opp). I'm not sure
> > there was any conclusion last time we discussed this.
> 
> In the last mail, I was suggested to investigate the code in other architecture
> to find if there exists similar interface. I searched 'merg' in the code and
> didn't find similar interface.

Maybe no other architecture has such hint. They have write buffer
draining but that's more expensive.

> The only thing similar I found is in Intel Software Developer's Manual. It says
> "Write Combining (WC) ... Writes may be delayed and combined in the write
> combining buffer (WC buffer) to reduce memory accesses. If the WC buffer is
> partially filled, the writes may be delayed until the next occurrence of a
> serializing event; such as an SFENCE or MFENCE instruction, CPUID or other
> serializing instruction, a read or write to uncached memory, an interrupt
> occurrence, or an execution of a LOCK instruction (including one with an
> XACQUIRE or XRELEASE prefix)."
> Maybe this is more like the write combine buffer flushing, not prevent merging.
> Sorry I still didn't understand the difference clearly.

IIUC those drivers on x86 just rely on the microarchitecture aspects of
the draining (e.g. fill 64 bytes). On Arm we don't have such guarantee
as there's a wide variation in implementations, hence the DGH
instruction.

> How about a common name called 'merge_prohibit_hint()'? Could you give me some
> suggestions ?

I think "prohibit" looks more like not allowing any write-buffer merge.
Maybe stop_merge_hint(), stop_write_buffer_merge(),
stop_write_combining() (any other ideas?). It would be a NOP on all
other architectures.

-- 
Catalin
