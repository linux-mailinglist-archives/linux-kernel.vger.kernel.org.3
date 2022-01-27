Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA4F49E312
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 14:07:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241530AbiA0NHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 08:07:19 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:55034 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241475AbiA0NHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 08:07:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA90161B68
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 13:07:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35200C340EE
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 13:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643288837;
        bh=xjiolTwYVgGM09+KCzAYuvgj9y0KyzZcSIFHpSpItXk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cHc5VHlihuPJPzEw19OXPSBoYC9RPfNlXkwGNLkvm+KUQudBmM9Sj8rWPQTZMmfbf
         EXV7wCWkZ13UfOiHLWeh+cnQFFdgrk/c/vfxQzGlscQO2EEqJCVrtZUnPqES1t/8Fk
         tPKfBFWLFUE6xLTdUddIqtF54ycDJu5xvJZ1KmVpuDRij580Fwcx+WUn6MONstaCPg
         Zbkny7OxzuqjoMsChYY6YxTs9rDl4lVupvUl/IuVvZnoPIYw18E/Yr7kNZXz6ORYSY
         eEsqjOeE5qWSQBotsndY/ru7EX8FhcaeZ0TYTjKM0z9az+dp6EaWyTxMPiciikQO2z
         aqcRUGlrfUxzw==
Received: by mail-wm1-f43.google.com with SMTP id l35-20020a05600c1d2300b0034d477271c1so1811933wms.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 05:07:17 -0800 (PST)
X-Gm-Message-State: AOAM533Femq8wo53Z16yHPKISCF3ngLCx/tz/1nX5o5M5HKXYCFPCRNq
        4cho42F3UzDexqq5/imkS/CKb0DD4mr+izYnoqk=
X-Google-Smtp-Source: ABdhPJwbCwCWLtbAbT8kLcweQn+kTjBpSx1tf+fD4KUCz2yJl1aENEcupjcDD8pDx8dzv7OGcDz8MrNZd3DgigGp4iU=
X-Received: by 2002:a05:600c:a47:: with SMTP id c7mr3158487wmq.25.1643288834852;
 Thu, 27 Jan 2022 05:07:14 -0800 (PST)
MIME-Version: 1.0
References: <944D10DA-8200-4BA9-8D0A-3BED9AA99F82@linux.ibm.com>
 <e9422643-a210-b77f-a037-da63a9d2e925@linux.alibaba.com> <20220124114548.30241947@gandalf.local.home>
 <0fa0daec-881a-314b-e28b-3828e80bbd90@linux.alibaba.com> <YfFclROd+0/61q2d@FVFF77S0Q05N>
 <YfKGKWW5UfZ15kCW@FVFF77S0Q05N> <CAMj1kXHgpr0KYx5PYO_SpqaN8Ar2kfmc9Pb-d26uaYDpjwTz9w@mail.gmail.com>
 <YfKOENgR6sLnHQmA@FVFF77S0Q05N> <CAMj1kXGsmK9pBmgwmMEr302eCHtL=cqs4jqM_jOiK-bLO2gQog@mail.gmail.com>
 <YfKXM0wBfTh0V8+L@FVFF77S0Q05N>
In-Reply-To: <YfKXM0wBfTh0V8+L@FVFF77S0Q05N>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 27 Jan 2022 14:07:03 +0100
X-Gmail-Original-Message-ID: <CAMj1kXF3Fg2O=5prQnUWeNFeCqojP1z2zDXMwxFdcNtWLfL7Vg@mail.gmail.com>
Message-ID: <CAMj1kXF3Fg2O=5prQnUWeNFeCqojP1z2zDXMwxFdcNtWLfL7Vg@mail.gmail.com>
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

On Thu, 27 Jan 2022 at 13:59, Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Thu, Jan 27, 2022 at 01:22:17PM +0100, Ard Biesheuvel wrote:
> > On Thu, 27 Jan 2022 at 13:20, Mark Rutland <mark.rutland@arm.com> wrote:
> > > On Thu, Jan 27, 2022 at 01:03:34PM +0100, Ard Biesheuvel wrote:
> > >
> > > > These architectures use place-relative extables for the same reason:
> > > > place relative references are resolved at build time rather than at
> > > > runtime during relocation, making a build time sort feasible.
> > > >
> > > > arch/alpha/include/asm/extable.h:#define ARCH_HAS_RELATIVE_EXTABLE
> > > > arch/arm64/include/asm/extable.h:#define ARCH_HAS_RELATIVE_EXTABLE
> > > > arch/ia64/include/asm/extable.h:#define ARCH_HAS_RELATIVE_EXTABLE
> > > > arch/parisc/include/asm/uaccess.h:#define ARCH_HAS_RELATIVE_EXTABLE
> > > > arch/powerpc/include/asm/extable.h:#define ARCH_HAS_RELATIVE_EXTABLE
> > > > arch/riscv/include/asm/extable.h:#define ARCH_HAS_RELATIVE_EXTABLE
> > > > arch/s390/include/asm/extable.h:#define ARCH_HAS_RELATIVE_EXTABLE
> > > > arch/x86/include/asm/extable.h:#define ARCH_HAS_RELATIVE_EXTABLE
> > > >
> > > > Note that the swap routine becomes something like the below, given
> > > > that the relative references need to be fixed up after the entry
> > > > changes place in the sorted list.
> > > >
> > > > static void swap_ex(void *a, void *b, int size)
> > > > {
> > > >         struct exception_table_entry *x = a, *y = b, tmp;
> > > >         int delta = b - a;
> > > >
> > > >         tmp = *x;
> > > >         x->insn = y->insn + delta;
> > > >         y->insn = tmp.insn - delta;
> > > >         ...
> > > > }
> > > >
> > > > As a bonus, the resulting footprint of the table in the image is
> > > > reduced by 8x, given that every 8 byte pointer has an accompanying 24
> > > > byte RELA record, so we go from 32 bytes to 4 bytes for every call to
> > > > __gnu_mcount_mc.
> > >
> > > Absolutely -- it'd be great if we could do that for the callsite locations; the
> > > difficulty is that the entries are generated by the compiler itself, so we'd
> > > either need some build/link time processing to convert each absolute 64-bit
> > > value to a relative 32-bit offset, or new compiler options to generate those as
> > > relative offsets from the outset.
> >
> > Don't we use scripts/recordmcount.pl for that?
>
> Not quite -- we could adjust it to do so, but today it doesn't consider
> existing mcount_loc entries, and just generates new ones where the compiler has
> generated calls to mcount, which it finds by scanning the instructions in the
> binary. Today it is not used:
>
> * On arm64 when we default to using `-fpatchable-function-entry=N`.  That makes
>   the compiler insert 2 NOPs in the function prologue, and log the location of
>   that NOP sled to a section called.  `__patchable_function_entries`.
>
>   We need the compiler to do that since we can't reliably identify 2 NOPs in a
>   function prologue as being intended to be a patch site, as e.g. there could
>   be notrace functions where the compiler had to insert NOPs for alignment of a
>   subsequent brnach or similar.
>
> * On architectures with `-nop-mcount`. On these, it's necessary to use
>   `-mrecord-mcount` to have the compiler log the patch-site, for the same
>   reason as with `-fpatchable-function-entry`.
>
> * On architectures with `-mrecord-mcount` generally, since this avoids the
>   overhead of scanning each object.
>
> * On x86 when objtool is used.
>

Right.

I suppose that on arm64, we can work around this by passing
--apply-dynamic-relocs to the linker, so that all R_AARCH64_RELATIVE
targets are prepopulated with the link time value of the respective
addresses. It does cause some bloat, which is why we disable that
today, but we could make that dependent on ftrace being enabled.

I do wonder how much over head we accumulate, though, by having all
these relocations, but I suppose that is the situation today in any
case.
