Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3664530F4F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234971AbiEWLeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 07:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234951AbiEWLd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 07:33:57 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6EBE24F9EE
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 04:33:55 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2DA6311FB;
        Mon, 23 May 2022 04:33:55 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.9.63])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C661C3F73D;
        Mon, 23 May 2022 04:33:52 -0700 (PDT)
Date:   Mon, 23 May 2022 12:33:48 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     andrey.konovalov@linux.dev
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH 1/2] arm64: kasan: do not instrument stacktrace.c
Message-ID: <YotxHEQNRet/zXHW@FVFF77S0Q05N>
References: <697e015e22ea78b021c2546f390ad5d773f3af86.1653177005.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <697e015e22ea78b021c2546f390ad5d773f3af86.1653177005.git.andreyknvl@google.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 22, 2022 at 01:50:58AM +0200, andrey.konovalov@linux.dev wrote:
> From: Andrey Konovalov <andreyknvl@google.com>
> 
> Disable KASAN instrumentation of arch/arm64/kernel/stacktrace.c.
> 
> This speeds up Generic KASAN by 5-20%.
> 
> As a side-effect, KASAN is now unable to detect bugs in the stack trace
> collection code. This is taken as an acceptable downside.
> 
> Also replace READ_ONCE_NOCHECK() with READ_ONCE() in stacktrace.c.
> As the file is now not instrumented, there is no need to use the
> NOCHECK version of READ_ONCE().
> 
> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---
>  arch/arm64/kernel/Makefile     | 3 +++
>  arch/arm64/kernel/stacktrace.c | 4 ++--
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
> index fa7981d0d917..da8cf6905c76 100644
> --- a/arch/arm64/kernel/Makefile
> +++ b/arch/arm64/kernel/Makefile
> @@ -14,6 +14,9 @@ CFLAGS_REMOVE_return_address.o = $(CC_FLAGS_FTRACE)
>  CFLAGS_REMOVE_syscall.o	 = -fstack-protector -fstack-protector-strong
>  CFLAGS_syscall.o	+= -fno-stack-protector
>  
> +# Do not instrument to improve performance.
> +KASAN_SANITIZE_stacktrace.o := n

Can we make that a little more descriptive? e.g.

# When KASAN is enabled, a stacktrace is recorded for every alloc/free, which
# can significantly impact performance. Avoid instrumenting the stacktrace code
# to minimize this impact.
KASAN_SANITIZE_stacktrace.o := n

With that:

  Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> +
>  # It's not safe to invoke KCOV when portions of the kernel environment aren't
>  # available or are out-of-sync with HW state. Since `noinstr` doesn't always
>  # inhibit KCOV instrumentation, disable it for the entire compilation unit.
> diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
> index e4103e085681..33e96ae4b15f 100644
> --- a/arch/arm64/kernel/stacktrace.c
> +++ b/arch/arm64/kernel/stacktrace.c
> @@ -110,8 +110,8 @@ static int notrace unwind_frame(struct task_struct *tsk,
>  	 * Record this frame record's values and location. The prev_fp and
>  	 * prev_type are only meaningful to the next unwind_frame() invocation.
>  	 */
> -	frame->fp = READ_ONCE_NOCHECK(*(unsigned long *)(fp));
> -	frame->pc = READ_ONCE_NOCHECK(*(unsigned long *)(fp + 8));
> +	frame->fp = READ_ONCE(*(unsigned long *)(fp));
> +	frame->pc = READ_ONCE(*(unsigned long *)(fp + 8));
>  	frame->prev_fp = fp;
>  	frame->prev_type = info.type;
>  
> -- 
> 2.25.1
> 
