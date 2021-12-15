Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF7F47551C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 10:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241171AbhLOJYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 04:24:33 -0500
Received: from foss.arm.com ([217.140.110.172]:46272 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241165AbhLOJYb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 04:24:31 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 977C86D;
        Wed, 15 Dec 2021 01:24:30 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.66.121])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4D69C3F5A1;
        Wed, 15 Dec 2021 01:24:28 -0800 (PST)
Date:   Wed, 15 Dec 2021 09:24:22 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Jiri Slaby <jslaby@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, ardb@kernel.org,
        broonie@kernel.org, dave.hansen@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, maz@kernel.org,
        mingo@redhat.com, tabba@google.com, tglx@linutronix.de,
        will@kernel.org
Subject: Re: [RFC PATCH 0/6] linkage: better symbol aliasing
Message-ID: <Ybm0Rl6TxdgA0tsB@FVFF77S0Q05N>
References: <20211206124715.4101571-1-mark.rutland@arm.com>
 <YbNsjU2n2uXlg3fc@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbNsjU2n2uXlg3fc@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 03:04:45PM +0000, Catalin Marinas wrote:
> On Mon, Dec 06, 2021 at 12:47:09PM +0000, Mark Rutland wrote:
> > This series aims to make symbol aliasing simpler and more consistent.
> > The basic idea is to replace SYM_FUNC_START_ALIAS(alias) and
> > SYM_FUNC_END_ALIAS(alias) with a new SYM_FUNC_ALIAS(alias, name), so
> > that e.g.
> > 
> >     SYM_FUNC_START(func)
> >     SYM_FUNC_START_ALIAS(alias1)
> >     SYM_FUNC_START_ALIAS(alias2)
> >         ... asm insns ...
> >     SYM_FUNC_END(func)
> >     SYM_FUNC_END_ALIAS(alias1)
> >     SYM_FUNC_END_ALIAS(alias2)
> >     EXPORT_SYMBOL(alias1)
> >     EXPORT_SYMBOL(alias2)
> > 
> > ... can become:
> > 
> >     SYM_FUNC_START(name)
> >         ... asm insns ...
> >     SYM_FUNC_END(name)
> > 
> >     SYM_FUNC_ALIAS(alias1, func)
> >     EXPORT_SYMBOL(alias1)
> > 
> >     SYM_FUNC_ALIAS(alias2, func)
> >     EXPORT_SYMBOL(alias2)
> > 
> > This avoids repetition and hopefully make it easier to ensure
> > consistency (e.g. so each function has a single canonical name and
> > associated metadata).
> > 
> > I'm sending this as an RFC since I want to check:
> > 
> > a) People are happy with the idea in principle.
> > 
> > b) People are happy with the implementation within <linux/linkage.h>.
> > 
> > ... and I haven't yet converted the headers under tools/, which is
> > largely a copy+paste job.
> 
> I'm happy with the approach and acked the arm64 patches for the record.
> Not sure how/when this series will get into mainline.

Thanks!

As to "when", I think I'm going to rework the series atop v5.17-rc1, so for now
would you be happy to pick patch 3 ("arm64: remove __dma_*_area() aliases"):

  https://lore.kernel.org/linux-arm-kernel/20211206124715.4101571-4-mark.rutland@arm.com/

... into the arm64 tree? That'a a pure cleanup with no dependency on the rest
of the series.

For the rest of the series I still need to to the mechanical work for tools/,
there's a token-pasting issue on 32-bit arm, and I'd like to give this a long
soak in -next, so earlier in the next window seems like a better bet.

As for "how", I assume the core linkage bits will go via the tip tree, so I
think it'd make sense for the (remaining) arch bits to go that way too.

Thanks,
Mark.
