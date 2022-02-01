Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04CB54A5B05
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 12:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237216AbiBALSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 06:18:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236928AbiBALSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 06:18:32 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7027BC061714
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 03:18:32 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id t199so15926985oie.10
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 03:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pcT8Frn0n3Hw9SbN/loP8iSe8IeaLdSI0AOmRzA0azM=;
        b=hKzVGBGbfsCPYJ7HefyXr6bWuywoKmYQ1742/PdhXYVL1PPYWI/07d9VBKqIDjQKlG
         AnjyTkWXbTrOui9wEp9Ws/Obt6FXRwK3bogt36ZFKq/2FesmgQhkOtU0Dwdm6g5NExQz
         evPsi84gy9SKtMvgVLeUNRdk5zTgXWxKul8/dDs/VuNoEfqgf+h9cyHuQPsO54btyTyF
         DeqENVu1pV0fem6L4ajx7cvL9IcVau2AH7EWFNtQniJxePcfsA3yBYGT3T/LDabMKlgw
         MFJv8z5GPDcZTCIRSz6oijDhwbdCdy8wRWf1SE7atFeRCLswZe7ZLh5VHO//32pFY91U
         PWjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pcT8Frn0n3Hw9SbN/loP8iSe8IeaLdSI0AOmRzA0azM=;
        b=0JBkqAD0Xd9QNxfkGA0kjOAlTPhycoa7UHK9t/QP9YWrGM8R+QCdp3ikZIUFvh/gfm
         lBUsn7KAfvHooZxlSL02w0DqhfIM2CrqlpuG8MgH8reY/7IHM0ier9v2FF8oucJce3FH
         Y7t+N0biGbII1x94bbTrBD358FWB8gO7BfCLgmMo5ToAuV3SwB6lOOVKxoxef+apovU0
         sDyhuqbCMXyC95mpEalvWFP/L30xM7FIA4cZA/8fLazDIjbtvcxcui19kiEJivPVtMXf
         lEIYUFV/UjPYnUXUcx+z+qfBlvPnQF+LmqU1l+xh6ciTWmnjvf4xY4V33j2B1dvzFZ7L
         sZCg==
X-Gm-Message-State: AOAM532hHj41tScYTg7TxUniCniG3FbABoiSXhxdR8E/5QlF79pZP0Wg
        N22isbLyoH5KXBVL/PyHaT/ZZXfI0rIbaG9LEUpipg==
X-Google-Smtp-Source: ABdhPJwO7fHptuSvmIaQ+/J/5b/+/5PLyjAttUp0EoMB/ZtjFn1J7KrgHwXlEdQXrBtYWjyOG1ilR7VtBLKEvdzrEvU=
X-Received: by 2002:aca:2b16:: with SMTP id i22mr746926oik.128.1643714311558;
 Tue, 01 Feb 2022 03:18:31 -0800 (PST)
MIME-Version: 1.0
References: <20220131090521.1947110-1-elver@google.com> <20220131090521.1947110-2-elver@google.com>
 <202201311315.B9FDD0A@keescook>
In-Reply-To: <202201311315.B9FDD0A@keescook>
From:   Marco Elver <elver@google.com>
Date:   Tue, 1 Feb 2022 12:18:19 +0100
Message-ID: <CANpmjNPvyKF2LiZAzTOz0mvbxPvJW_a7ysJ3n_kcHYvHXxpw+g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] stack: Constrain and fix stack offset
 randomization with Clang builds
To:     Kees Cook <keescook@chromium.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Alexander Potapenko <glider@google.com>, llvm@lists.linux.dev,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jan 2022 at 22:15, Kees Cook <keescook@chromium.org> wrote:
> On Mon, Jan 31, 2022 at 10:05:21AM +0100, Marco Elver wrote:
> > All supported versions of Clang perform auto-init of __builtin_alloca()
> > when stack auto-init is on (CONFIG_INIT_STACK_ALL_{ZERO,PATTERN}).
> >
> > add_random_kstack_offset() uses __builtin_alloca() to add a stack
> > offset. This means, when CONFIG_INIT_STACK_ALL_{ZERO,PATTERN} is
> > enabled, add_random_kstack_offset() will auto-init that unused portion
> > of the stack used to add an offset.
> >
> > There are several problems with this:
> >
> >       1. These offsets can be as large as 1023 bytes. Performing
> >          memset() on them isn't exactly cheap, and this is done on
> >          every syscall entry.
> >
> >       2. Architectures adding add_random_kstack_offset() to syscall
> >          entry implemented in C require them to be 'noinstr' (e.g. see
> >          x86 and s390). The potential problem here is that a call to
> >          memset may occur, which is not noinstr.
> >
> > A x86_64 defconfig kernel with Clang 11 and CONFIG_VMLINUX_VALIDATION shows:
> >
> >  | vmlinux.o: warning: objtool: do_syscall_64()+0x9d: call to memset() leaves .noinstr.text section
> >  | vmlinux.o: warning: objtool: do_int80_syscall_32()+0xab: call to memset() leaves .noinstr.text section
> >  | vmlinux.o: warning: objtool: __do_fast_syscall_32()+0xe2: call to memset() leaves .noinstr.text section
> >  | vmlinux.o: warning: objtool: fixup_bad_iret()+0x2f: call to memset() leaves .noinstr.text section
> >
> > Clang 14 (unreleased) will introduce a way to skip alloca initialization
> > via __builtin_alloca_uninitialized() (https://reviews.llvm.org/D115440).
> >
> > Constrain RANDOMIZE_KSTACK_OFFSET to only be enabled if no stack
> > auto-init is enabled, the compiler is GCC, or Clang is version 14+. Use
> > __builtin_alloca_uninitialized() if the compiler provides it, as is done
> > by Clang 14.
> >
> > Link: https://lkml.kernel.org/r/YbHTKUjEejZCLyhX@elver.google.com
> > Fixes: 39218ff4c625 ("stack: Optionally randomize kernel stack offset each syscall")
> > Signed-off-by: Marco Elver <elver@google.com>
>
> Thanks for the tweaks; this looks good to me now.
>
> Acked-by: Kees Cook <keescook@chromium.org>

Kees, which tree do randomize_kstack changes go through these days?
I've seen previous patches went through -tip via Thomas.

Thanks,
-- Marco
