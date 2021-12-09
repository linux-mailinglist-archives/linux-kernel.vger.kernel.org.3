Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CFA646F5CB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 22:16:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbhLIVUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 16:20:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbhLIVUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 16:20:19 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC61C061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 13:16:44 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id cf39so2381569lfb.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 13:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n/PRQqohZJZoWPfeAL4/gTv4y1kA/vUHTgUSzu+kjUk=;
        b=g4y37LIT8HPOzLKutUXtaDJvUeJ0+/CGyv38hQvAw62juFYmPp8xY81qmdfR94ekL1
         zJ01fAhqXrPsyVAyF4Rmu71FEe7b28kHRnIAs2gPOubcJVu4C+S4OAM5l5NsTVl1nUNo
         0geMJEqdhmk9vQoyehfiLCCzsf/vPPpjohT2YtqD+4MZUylekERGXpzLIRlt0a9eGNCv
         KmdCs4oTnEFlZcz8/j+4GFmLlTedEmnaISi73JDXUTgJvBbOnsFbIJm7FedBs7yGJ+pb
         B4qRT10iZ7dD3pd3uO4PQnPTq3oVMAcH4oq7NgGzrPRyFYEnuVNDFoz/NHO+Fejw9b/e
         9Q5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n/PRQqohZJZoWPfeAL4/gTv4y1kA/vUHTgUSzu+kjUk=;
        b=r/d9ehpTs043VjmzqOqaHtUETHhCNKy/zBO32JGmE+MRSgQQTznkHIWX+g2OO5CZ6d
         dpWGQxHNd0q+aThY7tOjxFKQcySUlrSn0JIPlVOfYMVDYjiP1Oa3bBEI/PGrdw38eLuJ
         yi9bsJAssb8JegiEYJvjZtxnetYpBRcxPC8A6/7WrEvGucVGIDL28J5xpETELmQgB+K4
         sH0NA7HWw6owR8YsLSnX2zpM+m0y4Ym46z8CIEW2wrINUx8Tnnoj9QwZgmzK6U2GGVxO
         g6CZXfSgzsgkDJpsTcL1YcKiRJcLRro1iedKrDmZpziyvB7GS8IEH5Y278VWMsYDrFW0
         uk8A==
X-Gm-Message-State: AOAM530ogdO1L6gWoKF5OiErb00w6btUQ+GGJJ1zrxYzAfV9LgTcYqX6
        etJUxeRfxfkD1d7cjAwgw6+P6zJVpXFmT9WcjzSCPw==
X-Google-Smtp-Source: ABdhPJzkqPmVslx+nMihnzHioqa5Jxg3UR3GK3CFA0GryeYJKVH2W5AracL5avcjGmE6Wnoa9W0q6oVMoXkEqKZl8SM=
X-Received: by 2002:ac2:418f:: with SMTP id z15mr7863545lfh.213.1639084602937;
 Thu, 09 Dec 2021 13:16:42 -0800 (PST)
MIME-Version: 1.0
References: <YbHTKUjEejZCLyhX@elver.google.com>
In-Reply-To: <YbHTKUjEejZCLyhX@elver.google.com>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 9 Dec 2021 22:16:16 +0100
Message-ID: <CAG48ez0dZwigkLHVWvNS6Cg-7bL4GoCMULyQzWteUv4zZ=OnWQ@mail.gmail.com>
Subject: Re: randomize_kstack: To init or not to init?
To:     Marco Elver <elver@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Potapenko <glider@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-toolchains@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 9, 2021 at 10:58 AM Marco Elver <elver@google.com> wrote:
> Clang supports CONFIG_INIT_STACK_ALL_ZERO, which appears to be the
> default since dcb7c0b9461c2, which is why this came on my radar. And
> Clang also performs auto-init of allocas when auto-init is on
> (https://reviews.llvm.org/D60548), with no way to skip. As far as I'm
> aware, GCC 12's upcoming -ftrivial-auto-var-init= doesn't yet auto-init
> allocas.
>
> add_random_kstack_offset() uses __builtin_alloca() to add a stack
> offset. This means, when CONFIG_INIT_STACK_ALL_{ZERO,PATTERN} is
> enabled, add_random_kstack_offset() will auto-init that unused portion
> of the stack used to add an offset.
>
> There are several problems with this:
>
>         1. These offsets can be as large as 1023 bytes. Performing
>            memset() on them isn't exactly cheap, and this is done on
>            every syscall entry.
>
>         2. Architectures adding add_random_kstack_offset() to syscall
>            entry implemented in C require them to be 'noinstr' (e.g. see
>            x86 and s390). The potential problem here is that a call to
>            memset may occur, which is not noinstr.

This doesn't just affect alloca(), right? According to godbolt.org
(https://godbolt.org/z/jYrWEx7o8):

void bar(char *p);
void foo() {
  char arr[512];
  bar(arr);
}

when compiled with "-ftrivial-auto-var-init=pattern -O2 -mno-sse"
gives this result:

foo:                                    # @foo
        push    rbx
        sub     rsp, 512
        mov     rbx, rsp
        mov     edx, 512
        mov     rdi, rbx
        mov     esi, 170
        call    memset@PLT
        mov     rdi, rbx
        call    bar
        add     rsp, 512
        pop     rbx
        ret

So I think to fix this properly in a way that doesn't conflict with
noinstr validation, I think you'll have to add a compiler flag that
lets you specify a noinstr-safe replacement for memset() that should
be used here?
