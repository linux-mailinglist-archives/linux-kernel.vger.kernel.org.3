Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF4046F53E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 21:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbhLIUwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 15:52:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbhLIUwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 15:52:21 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8019EC0617A1
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 12:48:47 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id gx15-20020a17090b124f00b001a695f3734aso5885116pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 12:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2E9kDLwwNQ0Gbn3Uwe88OJMa9WjF0vo6Kuu7UJb0mUg=;
        b=BYG7unjb4oJBjQXDwmJe7IMGw01lsC5JVhUrrtmNkgsX52TRDJUTmboGRQdbpT+o1g
         j9KUbDE0v9xUhFaLYhQ3ldiUvMfYIufWFT/SlJ8pf6nhSA2No8MmXgFAyTcwgT2urGME
         2ktYdpkYq/M/ZgU3QBNf6cfjg5WUfR4IbMcpk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2E9kDLwwNQ0Gbn3Uwe88OJMa9WjF0vo6Kuu7UJb0mUg=;
        b=TMT25A+USMjr4Mm2wPe0bBlCuzID8ccv7UTqIx5lnlXjKtsk0qIftPHt7Ut8pGJQOu
         SAYnl6AdTbpa8MhJ54Il66mlPr6EvHM0TX2x1MZi2oSRxzv5RU2mP6+eACOzFy/BylSZ
         wvjW1VL8m+Bmb/RAC4c+ulHb6V07Th6HMeBDUMK9QQEba81rBchrbKA+FA4B3eJ9jAyQ
         ssaInnHi5uu8EdWj1NLInsaIL7bADk9Aor7Dpqq13GvGXufQ6wTWKssQvEmgP647KzbB
         G5GOwPjNVGBfpqkWip+Y5fUj7kec2baek8dBbEuBz1+rr+GJQMZnrOrprGnsJr+mkLcq
         otlQ==
X-Gm-Message-State: AOAM532G9dWmg053Sk9o/VN9gq4+bO1fRLQ1XX9JC+H06vv24xpgw7rP
        1lMI27ooT3h4Z1sTItTRnFx7PA==
X-Google-Smtp-Source: ABdhPJygNj+tslfTSFbQM3Med1wMuC/7qfQDHXEA98gBbSPtHemrkTPjLSeWLzE5oSIz+n+GiFUpbg==
X-Received: by 2002:a17:902:bd02:b0:142:728b:e475 with SMTP id p2-20020a170902bd0200b00142728be475mr58367811pls.15.1639082927017;
        Thu, 09 Dec 2021 12:48:47 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y12sm568512pfe.140.2021.12.09.12.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 12:48:46 -0800 (PST)
Date:   Thu, 9 Dec 2021 12:48:45 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Marco Elver <elver@google.com>
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
Subject: Re: randomize_kstack: To init or not to init?
Message-ID: <202112091232.51D0DE5535@keescook>
References: <YbHTKUjEejZCLyhX@elver.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbHTKUjEejZCLyhX@elver.google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2021 at 10:58:01AM +0100, Marco Elver wrote:
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
> 	1. These offsets can be as large as 1023 bytes. Performing
> 	   memset() on them isn't exactly cheap, and this is done on
> 	   every syscall entry.
> 
> 	2. Architectures adding add_random_kstack_offset() to syscall
> 	   entry implemented in C require them to be 'noinstr' (e.g. see
> 	   x86 and s390). The potential problem here is that a call to
> 	   memset may occur, which is not noinstr.
> 
> A defconfig kernel with Clang 11 and CONFIG_VMLINUX_VALIDATION shows:
> 
>  | vmlinux.o: warning: objtool: do_syscall_64()+0x9d: call to memset() leaves .noinstr.text section
>  | vmlinux.o: warning: objtool: do_int80_syscall_32()+0xab: call to memset() leaves .noinstr.text section
>  | vmlinux.o: warning: objtool: __do_fast_syscall_32()+0xe2: call to memset() leaves .noinstr.text section
>  | vmlinux.o: warning: objtool: fixup_bad_iret()+0x2f: call to memset() leaves .noinstr.text section
> 
> Switching to INIT_STACK_ALL_NONE resolves the warnings as expected.
> 
> To figure out what the right solution is, the first thing to figure out
> is, do we actually want that offset portion of the stack to be
> auto-init'd?
> 
> There are several options:
> 
> 	A. Make memset (and probably all other mem-transfer functions)
> 	   noinstr compatible, if that is even possible. This only solves
> 	   problem #2.

I'd agree: "A" isn't going to work well here.

> 
> 	B. A workaround could be using a VLA with
> 	   __attribute__((uninitialized)), but requires some restructuring
> 	   to make sure the VLA remains in scope and other trickery to
> 	   convince the compiler to not give up that stack space.

I was hoping the existing trickery would work for a VLA, but it seems
not. It'd be nice if it could work with a VLA, which could just gain the
attribute and we'd be done.

> 	C. Introduce a new __builtin_alloca_uninitialized().

Hrm, this means conditional logic between compilers, too. :(

-- 
Kees Cook
