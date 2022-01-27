Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7EF749E3F4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 14:59:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240149AbiA0N7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 08:59:47 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:54524 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236884AbiA0N7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 08:59:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9645261C65
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 13:59:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0466FC340E4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 13:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643291985;
        bh=C8J8iNsm2mOjo9Dm060FJB/YllzVO4ruYOFz/KHhAH4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rFkBWMy4q7FrCVE/6vBfbjwGtNmsaorxpQllsGRpplinVT38CTUEh7vKsd2Ww0Aqn
         17+1kRNv6dqo30enI5q6HHbly8xsEC/VgpIDkcBsIYFyIhRdGeVB2TJPccKxfFSoPE
         HXQnzOc7X7Leg266+fHMbWmXgaHCenTcNHmv8yR8WVtyQp37kvN4ZYAFE0MjFBEfbY
         UXwmawkZct7uSK+0aj51vx4lDNNcV2M3mznaKZIt0dC/4osdBiifOMgs4D+nwWPzJj
         T22jGPMoWwcvQfhMr+aQAe2gmOB0lsO1NUDALy2WAYkJ6ueX/JoQ0Yi4OeAXdXVQ2F
         7LSrnhWtctfZA==
Received: by mail-wr1-f42.google.com with SMTP id s9so4966865wrb.6
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 05:59:44 -0800 (PST)
X-Gm-Message-State: AOAM530C7n98SK0jRxXbbB22zXq7qXYpgBu2jU3EbyWQsIB93iN0nc2D
        stUGsnN7AdQ4aFp7P18H6uI2UCgPKdK9Y9NwW20=
X-Google-Smtp-Source: ABdhPJxBiMCluf7EE4Hhodg7Y2uall9vY53ZmOj35baIopT3e8YchA16oCTZmbmI5aox4Zffh9Z3UnW53WbZeQ3MVCo=
X-Received: by 2002:a05:6000:15ca:: with SMTP id y10mr3043731wry.417.1643291983359;
 Thu, 27 Jan 2022 05:59:43 -0800 (PST)
MIME-Version: 1.0
References: <e9422643-a210-b77f-a037-da63a9d2e925@linux.alibaba.com>
 <20220124114548.30241947@gandalf.local.home> <0fa0daec-881a-314b-e28b-3828e80bbd90@linux.alibaba.com>
 <YfFclROd+0/61q2d@FVFF77S0Q05N> <YfKGKWW5UfZ15kCW@FVFF77S0Q05N>
 <CAMj1kXHgpr0KYx5PYO_SpqaN8Ar2kfmc9Pb-d26uaYDpjwTz9w@mail.gmail.com>
 <YfKOENgR6sLnHQmA@FVFF77S0Q05N> <CAMj1kXGsmK9pBmgwmMEr302eCHtL=cqs4jqM_jOiK-bLO2gQog@mail.gmail.com>
 <YfKXM0wBfTh0V8+L@FVFF77S0Q05N> <CAMj1kXF3Fg2O=5prQnUWeNFeCqojP1z2zDXMwxFdcNtWLfL7Vg@mail.gmail.com>
 <YfKc8MDwenS1iXqQ@FVFF77S0Q05N>
In-Reply-To: <YfKc8MDwenS1iXqQ@FVFF77S0Q05N>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 27 Jan 2022 14:59:31 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHnQcHmxRrTBQmj0Z2JJ6iWvNCQqSjvPqG_oedWpikfSA@mail.gmail.com>
Message-ID: <CAMj1kXHnQcHmxRrTBQmj0Z2JJ6iWvNCQqSjvPqG_oedWpikfSA@mail.gmail.com>
Subject: Re: [powerpc] ftrace warning kernel/trace/ftrace.c:2068 with
 code-patching selftests
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Yinan Liu <yinan@linux.alibaba.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)" 
        <linuxppc-dev@lists.ozlabs.org>,
        Sachin Sant <sachinp@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jan 2022 at 14:24, Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Thu, Jan 27, 2022 at 02:07:03PM +0100, Ard Biesheuvel wrote:
> > On Thu, 27 Jan 2022 at 13:59, Mark Rutland <mark.rutland@arm.com> wrote:
> > >
> > > On Thu, Jan 27, 2022 at 01:22:17PM +0100, Ard Biesheuvel wrote:
> > > > On Thu, 27 Jan 2022 at 13:20, Mark Rutland <mark.rutland@arm.com> wrote:
> > > > > On Thu, Jan 27, 2022 at 01:03:34PM +0100, Ard Biesheuvel wrote:
> > > > >
> > > > > > These architectures use place-relative extables for the same reason:
> > > > > > place relative references are resolved at build time rather than at
> > > > > > runtime during relocation, making a build time sort feasible.
> > > > > >
> > > > > > arch/alpha/include/asm/extable.h:#define ARCH_HAS_RELATIVE_EXTABLE
> > > > > > arch/arm64/include/asm/extable.h:#define ARCH_HAS_RELATIVE_EXTABLE
> > > > > > arch/ia64/include/asm/extable.h:#define ARCH_HAS_RELATIVE_EXTABLE
> > > > > > arch/parisc/include/asm/uaccess.h:#define ARCH_HAS_RELATIVE_EXTABLE
> > > > > > arch/powerpc/include/asm/extable.h:#define ARCH_HAS_RELATIVE_EXTABLE
> > > > > > arch/riscv/include/asm/extable.h:#define ARCH_HAS_RELATIVE_EXTABLE
> > > > > > arch/s390/include/asm/extable.h:#define ARCH_HAS_RELATIVE_EXTABLE
> > > > > > arch/x86/include/asm/extable.h:#define ARCH_HAS_RELATIVE_EXTABLE
> > > > > >
> > > > > > Note that the swap routine becomes something like the below, given
> > > > > > that the relative references need to be fixed up after the entry
> > > > > > changes place in the sorted list.
> > > > > >
> > > > > > static void swap_ex(void *a, void *b, int size)
> > > > > > {
> > > > > >         struct exception_table_entry *x = a, *y = b, tmp;
> > > > > >         int delta = b - a;
> > > > > >
> > > > > >         tmp = *x;
> > > > > >         x->insn = y->insn + delta;
> > > > > >         y->insn = tmp.insn - delta;
> > > > > >         ...
> > > > > > }
> > > > > >
> > > > > > As a bonus, the resulting footprint of the table in the image is
> > > > > > reduced by 8x, given that every 8 byte pointer has an accompanying 24
> > > > > > byte RELA record, so we go from 32 bytes to 4 bytes for every call to
> > > > > > __gnu_mcount_mc.
> > > > >
> > > > > Absolutely -- it'd be great if we could do that for the callsite locations; the
> > > > > difficulty is that the entries are generated by the compiler itself, so we'd
> > > > > either need some build/link time processing to convert each absolute 64-bit
> > > > > value to a relative 32-bit offset, or new compiler options to generate those as
> > > > > relative offsets from the outset.
> > > >
> > > > Don't we use scripts/recordmcount.pl for that?
> > >
> > > Not quite -- we could adjust it to do so, but today it doesn't consider
> > > existing mcount_loc entries, and just generates new ones where the compiler has
> > > generated calls to mcount, which it finds by scanning the instructions in the
> > > binary. Today it is not used:
> > >
> > > * On arm64 when we default to using `-fpatchable-function-entry=N`.  That makes
> > >   the compiler insert 2 NOPs in the function prologue, and log the location of
> > >   that NOP sled to a section called.  `__patchable_function_entries`.
> > >
> > >   We need the compiler to do that since we can't reliably identify 2 NOPs in a
> > >   function prologue as being intended to be a patch site, as e.g. there could
> > >   be notrace functions where the compiler had to insert NOPs for alignment of a
> > >   subsequent brnach or similar.
> > >
> > > * On architectures with `-nop-mcount`. On these, it's necessary to use
> > >   `-mrecord-mcount` to have the compiler log the patch-site, for the same
> > >   reason as with `-fpatchable-function-entry`.
> > >
> > > * On architectures with `-mrecord-mcount` generally, since this avoids the
> > >   overhead of scanning each object.
> > >
> > > * On x86 when objtool is used.
> > >
> >
> > Right.
> >
> > I suppose that on arm64, we can work around this by passing
> > --apply-dynamic-relocs to the linker, so that all R_AARCH64_RELATIVE
> > targets are prepopulated with the link time value of the respective
> > addresses. It does cause some bloat, which is why we disable that
> > today, but we could make that dependent on ftrace being enabled.
>
> We'd also need to teach the build-time sort to update the relocations, unless
> you mean to also change the boot-time reloc code to RMW with the offset?
>

Why would that be necessary? Every RELA entry has the same effect on
its target address, as it just adds a fixed offset.

> I think for right now the best thing is to disable the build-time sort for
> arm64, but maybe something like that is the right thing to do longer term.
>

Fair enough.

> > I do wonder how much over head we accumulate, though, by having all
> > these relocations, but I suppose that is the situation today in any
> > case.
>
> Yeah; I suspect if we want to do something about that we want to do it more
> generally, and would probably need to do something like the x86 approach and
> rewrite the relocs at build-time to something more compressed. If we applied
> the dynamic relocs with the link-time address we'd only need 4 bytes to
> identify each pointer to apply an offset to.
>
> I'm not exactly sure how we could do that, nor what the trade-off look like in
> practice.
>

It would make sense for -fpic codegen to use relative offsets in
__mcount_loc, but since we don't actually use -fpic on arm64, that
doesn't really help :-)
