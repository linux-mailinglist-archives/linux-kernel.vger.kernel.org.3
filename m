Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE81449B9CA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 18:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239517AbiAYRJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 12:09:15 -0500
Received: from foss.arm.com ([217.140.110.172]:56628 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353604AbiAYRHg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 12:07:36 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 892521FB;
        Tue, 25 Jan 2022 09:07:33 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.1.45])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1C3133F766;
        Tue, 25 Jan 2022 09:07:31 -0800 (PST)
Date:   Tue, 25 Jan 2022 17:07:29 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Evgenii Stepanov <eugenis@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: extable: fix null deref in load_unaligned_zeropad.
Message-ID: <YfAuUYovRP7BpUIa@FVFF77S0Q05N>
References: <20220122023447.1480995-1-eugenis@google.com>
 <YfAV6FTN5g6jZGj7@FVFF77S0Q05N>
 <YfAcKZpDWmKMZy8q@FVFF77S0Q05N>
 <CAFKCwrjbn3e2w-LikMY5bOvUKbUBi7_4iwBOD7KQUn8QHPwbng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFKCwrjbn3e2w-LikMY5bOvUKbUBi7_4iwBOD7KQUn8QHPwbng@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 08:59:07AM -0800, Evgenii Stepanov wrote:
> On Tue, Jan 25, 2022 at 7:50 AM Mark Rutland <mark.rutland@arm.com> wrote:
> >
> > On Tue, Jan 25, 2022 at 03:23:20PM +0000, Mark Rutland wrote:
> > > On Fri, Jan 21, 2022 at 06:34:47PM -0800, Evgenii Stepanov wrote:
> > > > ex_handler_load_unaligned_zeropad extracts the source and data register
> > > > numbers from the wrong field of the exception table.
> > >
> > > Ouch. Did you find this by inspection, or did this show up in testing?
> > >
> > > Sorry about this.
> > >
> > > I think we should be a little more explicit as to exactly what goes wrong. How
> > > about:
> > >
> > > | In ex_handler_load_unaligned_zeropad() we erroneously extract the data and
> > > | addr register indices from ex->type rather than ex->data. As ex->type will
> > > | contain EX_TYPE_LOAD_UNALIGNED_ZEROPAD (i.e. 4):
> > > |
> > > | * We'll always treat X0 as the address register, since EX_DATA_REG_ADDR is
> > > |   extracted from bits [9:5]. Thus, we may attempt to dereference an arbitrary
> > > |   address as X0 may hold an arbitary value.
> > > |
> > > | * We'll always treat X4 as the data register, since EX_DATA_REG_DATA is
> > > |   extracted from bits [4:0]. Thus we will corrupt X4 and cause arbitrary
> > > |   behaviour within load_unaligned_zeropad() and its caller.
> > > |
> > > | Fix this by extracting both values from ex->data as originally intended.
> > >
> > > > Fixes: 753b3236
> > >
> > > That should be expanded, e.g.
> > >
> > >   Fixes: 753b32368705c396 ("arm64: extable: add load_unaligned_zeropad() handler")
> > >
> > > With those changes:
> > >
> > > Reviewed-by: Mark Rutland <mark.rutland@arm.com>
> >
> > Looking again, sicne this isn't jsut a null-deref, can we also rework the
> > title, something like:
> >
> > | arm64: extable: fix load_unaligned_zeropad() reg indices
> 
> That's a much better commit message, thank you! I'll upload v2 shortly.
> 
> This was found by updating to a newer QEMU that correctly delivers MTE
> faults from unaligned memory accesses, and triggers this bug reliably
> during Android boot. I'll add a stack trace to v2.

That'd be great, thanks!

Mark.
