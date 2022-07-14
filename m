Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED03F5757EB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 01:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240907AbiGNXQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 19:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240880AbiGNXP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 19:15:59 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B7EE70E52
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 16:15:58 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id fy29so4941229ejc.12
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 16:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mhQ2HipCSIsUJpyE/i8kxJC7kPv5Mey32tmIcjzcEvM=;
        b=E2/At9bh0D+VaRs0orvvuVOXh4fB5WM8tcn/3FipPHKSOBT3NhDUeIDNQ/mQER9x8Z
         XV9jeVxH9x2+zduW3/Gu50S4g+78OEXb8l1fM82ztO6lYoOZ7JpbZ0y5SP0OKbgx8XbJ
         km0wJxtnSUeQCP/qz9ngZvdi21muhw6ELdWE4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mhQ2HipCSIsUJpyE/i8kxJC7kPv5Mey32tmIcjzcEvM=;
        b=kZn1ThNsT0evrOwIGchyCfjIdGVmYQUrh7JGyJnWarY1VSrUvDVEi7Xtdg1DBlPbVw
         f5ScOXZ8orRwYbvrP/AsirsqfEEJ2wezkI8uXUB/0IHIvRNw8LrJBViMfGkwVwxynPUI
         f56bBJ2qhpUPyDbStMc2iXtTH3ppj+mWrOioKqDvdqb9HSYmP19lrJkYmh8plIIZbeR0
         NHptITq+e3AMd3ILqvPMXaHuqOqxIokFkTtIkXQiFnotHlqSXACpmSCJvYCow+p99kDF
         5o++uyDgkF5LvZQHBYxv6efQ2WMJxJR/bpSlYBUh7Lp2GVK6Uut5DjADqWlpD3Qr0EP8
         T3eA==
X-Gm-Message-State: AJIora929IhkuZbZKUzmXI9FWms36PG/AInlh+feoxNGKybC3LGHGuIO
        guBbI6yTu0nJ4GrdlGcbdKz1lK2nCY1beAFBN3s=
X-Google-Smtp-Source: AGRyM1snORHGI001uNgByURWZOVbHiMha9X60wa7wQl1k5wcx7srG8uIruSmAOia91vFAURfEG5LKg==
X-Received: by 2002:a17:906:49d4:b0:6d6:e5ec:9a23 with SMTP id w20-20020a17090649d400b006d6e5ec9a23mr11312708ejv.79.1657840556631;
        Thu, 14 Jul 2022 16:15:56 -0700 (PDT)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com. [209.85.221.50])
        by smtp.gmail.com with ESMTPSA id d23-20020a170906305700b0072b7d76211dsm1237305ejd.107.2022.07.14.16.15.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 16:15:53 -0700 (PDT)
Received: by mail-wr1-f50.google.com with SMTP id bk26so4485140wrb.11
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 16:15:52 -0700 (PDT)
X-Received: by 2002:a05:6000:1a88:b0:21d:aa97:cb16 with SMTP id
 f8-20020a0560001a8800b0021daa97cb16mr10335067wry.97.1657840551971; Thu, 14
 Jul 2022 16:15:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220714205646.4023495-1-ndesaulniers@google.com>
In-Reply-To: <20220714205646.4023495-1-ndesaulniers@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 14 Jul 2022 16:15:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgf=mrK7KzNh23dGtegSfJZx=423dCwF0hVTPOjfQ7jtQ@mail.gmail.com>
Message-ID: <CAHk-=wgf=mrK7KzNh23dGtegSfJZx=423dCwF0hVTPOjfQ7jtQ@mail.gmail.com>
Subject: Re: [PATCH] ubsan: disable UBSAN_DIV_ZERO for clang
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 1:56 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> Building with UBSAN_DIV_ZERO with clang produces numerous fallthrough
> warnings from objtool.

Ok, with this applied, things are better.

There are still the "__ubsan_handle_load_invalid_value() with UACCESS
enabled" messages, but those are misfeatures of the kvm cmpxchg
implementation.

I'm not entirely sure why the clang build warns but gcc doesn't, but I
*think* it's because clang is just being silly. It *looks* like it
checks that a "bool" has a value range of 0/1, and will complain if
not.

And the reason I say that's silly is that if I read it correctly, then
that value has literally been generated by clang itself, using "setz"
instruction.

It's the __try_cmpxchg_user_asm() macro, and with clang-14 I have it's
that CONFIG_CC_HAS_ASM_GOTO_TIED_OUTPUT case, and the C code uses
inline asm and does

        asm_volatile_goto("\n"                                          \
                     "1: " LOCK_PREFIX "cmpxchg"itype" %[new], %[ptr]\n"\
                     _ASM_EXTABLE_UA(1b, %l[label])                     \
                     : CC_OUT(z) (success),                             \

where that CC_OUT() in this case turns into

   # define CC_OUT(c) "=@cc" #c

and clang generates this code for it:

   7d01e:       f0 48 0f b1 4d 00       lock cmpxchg %rcx,0x0(%rbp)
   7d024:       49 89 c5                mov    %rax,%r13
   7d027:       0f 94 c0                sete   %al
   7d02a:       41 88 c6                mov    %al,%r14b
   7d02d:       bf 02 00 00 00          mov    $0x2,%edi
   7d032:       44 89 f6                mov    %r14d,%esi
   7d035:       e8 00 00 00 00          call    __sanitizer_cov_trace_const_cmp1
   7d03a:       41 80 fe 01             cmp    $0x1,%r14b
   7d03e:       0f 87 af 01 00 00       ja     7d1f3
<emulator_cmpxchg_emulated+0x6b3>

where that last "ja     7d1f3" is the branch to the code that then
calls __ubsan_handle_load_invalid_value.

But look at that code: it's literally

    sete   %al
    mov    %al,%r14b
    cmp    $0x1,%r14b

where clang has generated that "sete itself, and then it verifies that
the result is "<= 1".

IOW, clang seems to be literally just checking that the "sete"
instruction works right.

That's silly.

Maybe I'm misreading this, but I think the reason the clang build
complains, but the gcc build does not, is simply because gcc isn't
doing crazy checks of how the CPU works.

Some mis-feature of the "asm with flag output" code, where clang
doesn't understand that it generated that code itself, and the "setcc"
instruction always returns 0/1?

The old issue with "memcpy/memset() leaves .noinstr.text section"
because clang has generated out-of-line functions for trivial copies
also remains, but whatever.

             Linus
