Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F43346F546
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 21:54:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbhLIU6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 15:58:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbhLIU6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 15:58:17 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC966C0617A1
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 12:54:43 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id h19-20020a9d3e53000000b0056547b797b2so7537167otg.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 12:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HFSacAT887PNCoxtm3wOxVaKJ2m3E3kQPyuB0zZo9cM=;
        b=fr59f5tnC4cszL5DgLtSi0UUz1Iy7+x5sh6vLQZl5Dboa3KS29zlWZOgqp2HUf7ZqG
         qZRtuXWGmvkIIINqZWj4Bg7sCiUYAUggieow6Ygd+26sJ82tEcSP/zqdNS+u+uTs/ObJ
         jlcaYjk6FuhNL1c1+6DejBa821NqM7C7vtZqmy4boDd6vN0E6gV7RComJxcWvM36bY3O
         3i90hAWILkRPoViOS6xaaq+gmMqrR25QksD2nFmstnVsuOpsz7XK8+kXFUTvT7WQ9YaT
         t7uB1pIU0A8BV6NtmPY6wE0KqAiDuCsIaFnZIN6uFNSbvIDwSEze9DKBRfopo1XaQ1Vm
         iD+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HFSacAT887PNCoxtm3wOxVaKJ2m3E3kQPyuB0zZo9cM=;
        b=CkKi2mvFSrkwy4WE/oOHtTZyfw9lP3AW8QOcSHrQ/AgraVMN1c/jcjbT1e0uKvtaxj
         LUgOjC7y3GusoTpXJjvaa6XqT25UXnobJcgGMHuecTaLFvg6qMuNQ8T+YeFworwlG85+
         ++Wzy1GwqYow+1E26lD6WwYFfYWiK9Mu+4Z3DvDiqPIgnlPGtfomKOKyKV/9CEBvG7zc
         le2kJV3fqhy+YDXwq+HveRgvo5naaWvPi2pSv0b8hqlngmge2raxMH7CoscQhjqSyOZF
         nSNPl+ylNn0x5xAldo0BOp2R3q155fdgYIxKlI1HPYeL0iweyHQJkXom3zgjEw0JGDPq
         yptg==
X-Gm-Message-State: AOAM532OLAzZ+WsenI4ll5XxXTQOBunm9bq5eoV10NEAToKsI+M791Ko
        S7eYlsMjAqaq8Y5nFR1ztWbqCame62Mect6KOuG2Ew==
X-Google-Smtp-Source: ABdhPJx+jBbOy/MOlCU/G64fMr/tJptIk0krtWcyASmfxTgqjw/Ub5EF2E3yF1uwX3k6YK+w8LVDL6PDG5PxjGwivkQ=
X-Received: by 2002:a9d:7548:: with SMTP id b8mr7516429otl.92.1639083282784;
 Thu, 09 Dec 2021 12:54:42 -0800 (PST)
MIME-Version: 1.0
References: <YbHTKUjEejZCLyhX@elver.google.com> <202112091232.51D0DE5535@keescook>
In-Reply-To: <202112091232.51D0DE5535@keescook>
From:   Marco Elver <elver@google.com>
Date:   Thu, 9 Dec 2021 21:54:30 +0100
Message-ID: <CANpmjNPJpbKzO46APQgxeirYV=K5YwCw3yssnkMKXG2SGorUPw@mail.gmail.com>
Subject: Re: randomize_kstack: To init or not to init?
To:     Kees Cook <keescook@chromium.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Potapenko <glider@google.com>,
        Jann Horn <jannh@google.com>,
        Peter Collingbourne <pcc@google.com>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-toolchains@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Dec 2021 at 21:48, Kees Cook <keescook@chromium.org> wrote:
>
> On Thu, Dec 09, 2021 at 10:58:01AM +0100, Marco Elver wrote:
> > Clang supports CONFIG_INIT_STACK_ALL_ZERO, which appears to be the
> > default since dcb7c0b9461c2, which is why this came on my radar. And
> > Clang also performs auto-init of allocas when auto-init is on
> > (https://reviews.llvm.org/D60548), with no way to skip. As far as I'm
> > aware, GCC 12's upcoming -ftrivial-auto-var-init= doesn't yet auto-init
> > allocas.
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
> > A defconfig kernel with Clang 11 and CONFIG_VMLINUX_VALIDATION shows:
> >
> >  | vmlinux.o: warning: objtool: do_syscall_64()+0x9d: call to memset() leaves .noinstr.text section
> >  | vmlinux.o: warning: objtool: do_int80_syscall_32()+0xab: call to memset() leaves .noinstr.text section
> >  | vmlinux.o: warning: objtool: __do_fast_syscall_32()+0xe2: call to memset() leaves .noinstr.text section
> >  | vmlinux.o: warning: objtool: fixup_bad_iret()+0x2f: call to memset() leaves .noinstr.text section
> >
> > Switching to INIT_STACK_ALL_NONE resolves the warnings as expected.
> >
> > To figure out what the right solution is, the first thing to figure out
> > is, do we actually want that offset portion of the stack to be
> > auto-init'd?
> >
> > There are several options:
> >
> >       A. Make memset (and probably all other mem-transfer functions)
> >          noinstr compatible, if that is even possible. This only solves
> >          problem #2.
>
> I'd agree: "A" isn't going to work well here.
>
> >
> >       B. A workaround could be using a VLA with
> >          __attribute__((uninitialized)), but requires some restructuring
> >          to make sure the VLA remains in scope and other trickery to
> >          convince the compiler to not give up that stack space.
>
> I was hoping the existing trickery would work for a VLA, but it seems
> not. It'd be nice if it could work with a VLA, which could just gain the
> attribute and we'd be done.
>
> >       C. Introduce a new __builtin_alloca_uninitialized().
>
> Hrm, this means conditional logic between compilers, too. :(

And as Segher just pointed out, I think Clang has a "bug" because
explicit alloca() calls aren't "automatic storage". I think Clang
needs a new -mllvm param.

Because I think making #B work is quite ugly and also brittle. :-/
