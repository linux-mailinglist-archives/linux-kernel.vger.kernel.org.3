Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1811E49E555
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 16:02:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242250AbiA0PB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 10:01:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237314AbiA0PB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 10:01:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DACF5C061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 07:01:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 79FB661D4A
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 15:01:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1C63C340EB
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 15:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643295715;
        bh=D9pZPNALxzUy2MOE5m871kxKJx0h8nCXhJyu4D4OTYA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rCx4TppZ1iSxWXTEcEmBC+lURlv9ew7NOXXUweRoUkmZ/8g33zmDVcqVWWZW9+y7o
         y0H45OWnjwUJpK/UGx6rblT/HhzSpVaxDdZYzjTGiWL+tojQRCazROLu5un8layCNd
         U4T/hCAPPyim+457/ajM3mo5OrojJG8fd5i2O09396PufD0LQCgl+Nebs5oVB7JD8/
         iyRXU735G6gcuKwNxDWWWxGd+fp4OjTNwG20/+nFsbvAFt3P255YxfU5H60Qnw+6LH
         5CeuIcg3ARmefuGAXblW+QcgwLpG5Ro1pkVIPRl78nha/k565gYhy2Y+4fBfYydiPO
         epJM0qoYwUZIw==
Received: by mail-lj1-f175.google.com with SMTP id a25so4720456lji.9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 07:01:55 -0800 (PST)
X-Gm-Message-State: AOAM533qyk1kih5F9YzAdUMOAEKkxtH6Lo74mkNmbp9wy7kYAnxXlHn9
        Qp66YIQ5/kP0JF27cyGnE4zv2tujewF8km8rqQQ=
X-Google-Smtp-Source: ABdhPJzcLRdCLHzw1a3IBl+G877pZwFu5rFJbH+uriNAzcI+IssD+8p2HA5o3bUPvQcsnTQOg7au+CtoF0Lb/JLSCyk=
X-Received: by 2002:a2e:a17c:: with SMTP id u28mr1570447ljl.115.1643295713848;
 Thu, 27 Jan 2022 07:01:53 -0800 (PST)
MIME-Version: 1.0
References: <0fa0daec-881a-314b-e28b-3828e80bbd90@linux.alibaba.com>
 <YfFclROd+0/61q2d@FVFF77S0Q05N> <YfKGKWW5UfZ15kCW@FVFF77S0Q05N>
 <CAMj1kXHgpr0KYx5PYO_SpqaN8Ar2kfmc9Pb-d26uaYDpjwTz9w@mail.gmail.com>
 <YfKOENgR6sLnHQmA@FVFF77S0Q05N> <CAMj1kXGsmK9pBmgwmMEr302eCHtL=cqs4jqM_jOiK-bLO2gQog@mail.gmail.com>
 <YfKXM0wBfTh0V8+L@FVFF77S0Q05N> <CAMj1kXF3Fg2O=5prQnUWeNFeCqojP1z2zDXMwxFdcNtWLfL7Vg@mail.gmail.com>
 <YfKc8MDwenS1iXqQ@FVFF77S0Q05N> <CAMj1kXHnQcHmxRrTBQmj0Z2JJ6iWvNCQqSjvPqG_oedWpikfSA@mail.gmail.com>
 <YfKyNwYl/pkmVmDm@FVFF77S0Q05N>
In-Reply-To: <YfKyNwYl/pkmVmDm@FVFF77S0Q05N>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 27 Jan 2022 16:01:42 +0100
X-Gmail-Original-Message-ID: <CAMj1kXETdD_Ezh9rervebLOrExzUqX+4Gk8EBgX1e1Kacvd19Q@mail.gmail.com>
Message-ID: <CAMj1kXETdD_Ezh9rervebLOrExzUqX+4Gk8EBgX1e1Kacvd19Q@mail.gmail.com>
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

On Thu, 27 Jan 2022 at 15:55, Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Thu, Jan 27, 2022 at 02:59:31PM +0100, Ard Biesheuvel wrote:
> > On Thu, 27 Jan 2022 at 14:24, Mark Rutland <mark.rutland@arm.com> wrote:
> > >
> > > On Thu, Jan 27, 2022 at 02:07:03PM +0100, Ard Biesheuvel wrote:
> > > > I suppose that on arm64, we can work around this by passing
> > > > --apply-dynamic-relocs to the linker, so that all R_AARCH64_RELATIVE
> > > > targets are prepopulated with the link time value of the respective
> > > > addresses. It does cause some bloat, which is why we disable that
> > > > today, but we could make that dependent on ftrace being enabled.
> > >
> > > We'd also need to teach the build-time sort to update the relocations, unless
> > > you mean to also change the boot-time reloc code to RMW with the offset?
> >
> > Why would that be necessary? Every RELA entry has the same effect on
> > its target address, as it just adds a fixed offset.
>
> Currently in relocate_kernel() we generate the absolute address from the
> relocation alone, with the core of the relocation logic being as follows, with
> x9 being the pointer to a RELA entry, and x23 being the offset relative to the
> default load address:
>
>         ldp     x12, x13, [x9], #24
>         ldr     x14, [x9, #-8]
>
>         add     x14, x14, x23                   // relocate
>         str     x14, [x12, x23]
>
> ... and (as per another reply), a sample RELA entry currently contains:
>
>         0xffff8000090b1ab0      // default load VA of pointer to update
>         0x0000000000000403      // R_AARCH64_RELATIVE
>         0xffff8000090b6000      // default load VA of addr to write
>
> So either:
>
> * That code stays as-is, and we must update the relocs to correspond to their
>   new sorted locations, or we'll blat the sorted values with the original
>   relocs as we do today.
>
> * The code needs to change to RMW: read the existing value, add the offset
>   (ignoring the content of the RELA entry's addend field), and write it back.
>   This is what I meant when I said "change the boot-time reloc code to RMW with
>   the offset".
>
> Does that make sense, or have I misunderstood?
>

No you're right. We'd have to use different sequences here depending
on whether the relocation target is populated or not, which currently
we don't care about.
