Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F12634A5138
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 22:15:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351142AbiAaVPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 16:15:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232007AbiAaVPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 16:15:31 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9EF4C061714
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 13:15:30 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id y17so13627143plg.7
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 13:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cxXm9S9rBUGO+n/qf1n3on2rs5DZHI4UmQ2+ms2iYP4=;
        b=Qo7cE3plH59PbdtmImyac1lX+en/JDRgSaa4LMeLw6ph0k1EzlPT/BWVNjItFxgULh
         uYEe69YWJNHzuLftpsMRKtLU9Yx+i9KI7fKy9zSLAwleJOGwAdqbSQ8bIZt8/KNOt0iP
         XZyBHj77OOJEJ+b4ZrtXZqGJFZNNPAs6Aio2E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cxXm9S9rBUGO+n/qf1n3on2rs5DZHI4UmQ2+ms2iYP4=;
        b=h+b5J6WPv9704tvC9fyET8vmHzLJ2sEg8rr4eFj3fbmF0xxckaRJdeWtkxxaqDDp5u
         OHdX8QPMId2BzxkxH6I0DM7UyU7bTtNGKG/7p7PL6F2+qe3K4fqdybm7t2jP8DoJt2FG
         Wt1wT8l5q/lUW6r4xO/oDWjrZyIDCufa1+7FcyoQ4pWO0TWWbvrtSR7ikeQoEt4bK/d7
         mBA3CnMCwYEHAMm6aNnpcMHkpSRqJVuVcin7ATiiDQ3Rl/BENC/DIpCuawJLthGP03MF
         O3/qp8rkEYhbPfFyMz5FSnS9DWNYKl1MyeQRV/Z6irRMXjgIpuhvUP+2VNUkZWlhE5Eq
         t7CQ==
X-Gm-Message-State: AOAM530Z8Y2msqHbC1LQBmZLQrXqPNHoSODLZj3sqpaYiu01AlbMa4hk
        1zsFmmJYNr9xyMT+XMjIg+dwMg==
X-Google-Smtp-Source: ABdhPJyul6M9uc+iYppo5Cuy0vy4tnGlURb4dMZAIkzric/Dse5pGkQPhJdFSZKL4eflCMSBcXWnew==
X-Received: by 2002:a17:902:d509:: with SMTP id b9mr22602105plg.3.1643663730410;
        Mon, 31 Jan 2022 13:15:30 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id mi18sm219840pjb.35.2022.01.31.13.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 13:15:30 -0800 (PST)
Date:   Mon, 31 Jan 2022 13:15:29 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Marco Elver <elver@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Alexander Potapenko <glider@google.com>, llvm@lists.linux.dev,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] stack: Constrain and fix stack offset
 randomization with Clang builds
Message-ID: <202201311315.B9FDD0A@keescook>
References: <20220131090521.1947110-1-elver@google.com>
 <20220131090521.1947110-2-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220131090521.1947110-2-elver@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 10:05:21AM +0100, Marco Elver wrote:
> All supported versions of Clang perform auto-init of __builtin_alloca()
> when stack auto-init is on (CONFIG_INIT_STACK_ALL_{ZERO,PATTERN}).
> 
> add_random_kstack_offset() uses __builtin_alloca() to add a stack
> offset. This means, when CONFIG_INIT_STACK_ALL_{ZERO,PATTERN} is
> enabled, add_random_kstack_offset() will auto-init that unused portion
> of the stack used to add an offset.
> 
> There are several problems with this:
> 
> 	1. These offsets can be as large as 1023 bytes. Performing
> 	   memset() on them isn't exactly cheap, and this is done on
> 	   every syscall entry.
> 
> 	2. Architectures adding add_random_kstack_offset() to syscall
> 	   entry implemented in C require them to be 'noinstr' (e.g. see
> 	   x86 and s390). The potential problem here is that a call to
> 	   memset may occur, which is not noinstr.
> 
> A x86_64 defconfig kernel with Clang 11 and CONFIG_VMLINUX_VALIDATION shows:
> 
>  | vmlinux.o: warning: objtool: do_syscall_64()+0x9d: call to memset() leaves .noinstr.text section
>  | vmlinux.o: warning: objtool: do_int80_syscall_32()+0xab: call to memset() leaves .noinstr.text section
>  | vmlinux.o: warning: objtool: __do_fast_syscall_32()+0xe2: call to memset() leaves .noinstr.text section
>  | vmlinux.o: warning: objtool: fixup_bad_iret()+0x2f: call to memset() leaves .noinstr.text section
> 
> Clang 14 (unreleased) will introduce a way to skip alloca initialization
> via __builtin_alloca_uninitialized() (https://reviews.llvm.org/D115440).
> 
> Constrain RANDOMIZE_KSTACK_OFFSET to only be enabled if no stack
> auto-init is enabled, the compiler is GCC, or Clang is version 14+. Use
> __builtin_alloca_uninitialized() if the compiler provides it, as is done
> by Clang 14.
> 
> Link: https://lkml.kernel.org/r/YbHTKUjEejZCLyhX@elver.google.com
> Fixes: 39218ff4c625 ("stack: Optionally randomize kernel stack offset each syscall")
> Signed-off-by: Marco Elver <elver@google.com>

Thanks for the tweaks; this looks good to me now.

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
