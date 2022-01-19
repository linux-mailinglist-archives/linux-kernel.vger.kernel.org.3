Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 841F1493769
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 10:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352570AbiASJfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 04:35:32 -0500
Received: from foss.arm.com ([217.140.110.172]:51594 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348111AbiASJf3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 04:35:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8A0906D;
        Wed, 19 Jan 2022 01:35:29 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.38.123])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C0C943F766;
        Wed, 19 Jan 2022 01:35:27 -0800 (PST)
Date:   Wed, 19 Jan 2022 09:35:25 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     He Ying <heying24@huawei.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, marcan@marcan.st,
        maz@kernel.org, joey.gouly@arm.com, pcc@google.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: entry: Save some nops when
 CONFIG_ARM64_PSEUDO_NMI is not set
Message-ID: <20220119093525.GB42546@C02TD0UTHF1T.local>
References: <20220107085536.214501-1-heying24@huawei.com>
 <20220112032410.29231-1-heying24@huawei.com>
 <e6293ec4-7c56-194a-95f9-98b102d80b31@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e6293ec4-7c56-194a-95f9-98b102d80b31@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2022 at 02:40:58PM +0800, He Ying wrote:
> Hi all,
> 
> Ping. Any comments?

The patch looks fine, but as it's the middle of the merge window people
are busy and unlikely to look at this for the next few days.

Generally it's a good idea to wait until rc1 or rc2, rebase atop that,
and post the updated patch. Stuff like this usually gets queued around
rc3/rc4 time.

> 锟斤拷 2022/1/12 11:24, He Ying 写锟斤拷:
> > Arm64 pseudo-NMI feature code brings some additional nops
> > when CONFIG_ARM64_PSEUDO_NMI is not set, which is not
> > necessary. So add necessary ifdeffery to avoid it.
> > 
> > Signed-off-by: He Ying <heying24@huawei.com>

FWIW:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> > ---
> >   arch/arm64/kernel/entry.S | 4 ++++
> >   1 file changed, 4 insertions(+)
> > 
> > diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> > index 2f69ae43941d..ffc32d3d909a 100644
> > --- a/arch/arm64/kernel/entry.S
> > +++ b/arch/arm64/kernel/entry.S
> > @@ -300,6 +300,7 @@ alternative_else_nop_endif
> >   	str	w21, [sp, #S_SYSCALLNO]
> >   	.endif
> > +#ifdef CONFIG_ARM64_PSEUDO_NMI
> >   	/* Save pmr */
> >   alternative_if ARM64_HAS_IRQ_PRIO_MASKING
> >   	mrs_s	x20, SYS_ICC_PMR_EL1
> > @@ -307,6 +308,7 @@ alternative_if ARM64_HAS_IRQ_PRIO_MASKING
> >   	mov	x20, #GIC_PRIO_IRQON | GIC_PRIO_PSR_I_SET
> >   	msr_s	SYS_ICC_PMR_EL1, x20
> >   alternative_else_nop_endif
> > +#endif
> >   	/* Re-enable tag checking (TCO set on exception entry) */
> >   #ifdef CONFIG_ARM64_MTE
> > @@ -330,6 +332,7 @@ alternative_else_nop_endif
> >   	disable_daif
> >   	.endif
> > +#ifdef CONFIG_ARM64_PSEUDO_NMI
> >   	/* Restore pmr */
> >   alternative_if ARM64_HAS_IRQ_PRIO_MASKING
> >   	ldr	x20, [sp, #S_PMR_SAVE]
> > @@ -339,6 +342,7 @@ alternative_if ARM64_HAS_IRQ_PRIO_MASKING
> >   	dsb	sy				// Ensure priority change is seen by redistributor
> >   .L__skip_pmr_sync\@:
> >   alternative_else_nop_endif
> > +#endif
> >   	ldp	x21, x22, [sp, #S_PC]		// load ELR, SPSR
