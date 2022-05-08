Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3DE51EF57
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 21:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240651AbiEHTIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 15:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237753AbiEHR2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 13:28:34 -0400
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F879DED0
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 10:24:43 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id ba17so13848788edb.5
        for <linux-kernel@vger.kernel.org>; Sun, 08 May 2022 10:24:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wqd1pfOpFBNim3pwEebs2UZOYdL6NZjjBjoV+dIe6iY=;
        b=Fa7QmJcNo9SbT+IHpWFUIRIB7pilgr4sqMl/rPj/8sa13GAJqZBvJG9GreTTzTPIeF
         pn1bId3gtRSSVKeShFNhmACtM2Wje1WDxpiAAoH40mQ1zGCsMa4R3y9YyIQciMA6HaPe
         7uMxltjyniEsTBRCfqcN8+Q0GwGNABCT9TM6X8WujSYuXiZN1jER0SqMGHxNeobdFmp3
         VqNHYJNhNw9yjS2OZJqFqrjuhtm/IcpliGZslXH4SaStId0c8oWJuPNh+9BdJXMbdJWU
         YH4ddX2JnDgCqVFBU6Y6xFaEvjUD1tJ8YzvFGfdMtXsJElj6uqd3wzXquEUdqypOJ5Kx
         t/WQ==
X-Gm-Message-State: AOAM531lSrJBBhNuLlIUi2GSWuM1QfYMTOPDv8PGwjjIgI/K4cBjPP5t
        8AMJEEJVoYAfcA5Uo130Xy0=
X-Google-Smtp-Source: ABdhPJyo/rfuIQKNUAXvvILf5E3b882Jcte6XFXtzxTuyZm+ayghbOJg1YOFA1rXbKlUpGy3fKe2Nw==
X-Received: by 2002:aa7:ca15:0:b0:428:3259:984a with SMTP id y21-20020aa7ca15000000b004283259984amr13826192eds.59.1652030681735;
        Sun, 08 May 2022 10:24:41 -0700 (PDT)
Received: from [10.9.0.34] ([46.166.128.205])
        by smtp.gmail.com with ESMTPSA id qs24-20020a170906459800b006f3ef214e66sm4143967ejc.204.2022.05.08.10.24.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 May 2022 10:24:41 -0700 (PDT)
Message-ID: <3d65baac-93b6-7f21-1bf6-9b17d1fce843@linux.com>
Date:   Sun, 8 May 2022 20:24:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Reply-To: alex.popov@linux.com
Subject: Re: [PATCH v2 01/13] arm64: stackleak: fix current_top_of_stack()
Content-Language: en-US
To:     Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     akpm@linux-foundation.org, catalin.marinas@arm.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        luto@kernel.org, will@kernel.org
References: <20220427173128.2603085-1-mark.rutland@arm.com>
 <20220427173128.2603085-2-mark.rutland@arm.com>
From:   Alexander Popov <alex.popov@linux.com>
In-Reply-To: <20220427173128.2603085-2-mark.rutland@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark!

On 27.04.2022 20:31, Mark Rutland wrote:
> Due to some historical confusion, arm64's current_top_of_stack() isn't
> what the stackleak code expects. This could in theory result in a number
> of problems, and practically results in an unnecessary performance hit.
> We can avoid this by aligning the arm64 implementation with the x86
> implementation.
> 
> The arm64 implementation of current_top_of_stack() was added
> specifically for stackleak in commit:
> 
>    0b3e336601b82c6a ("arm64: Add support for STACKLEAK gcc plugin")
> 
> This was intended to be equivalent to the x86 implementation, but the
> implementation, semantics, and performance characteristics differ
> wildly:
> 
> * On x86, current_top_of_stack() returns the top of the current task's
>    task stack, regardless of which stack is in active use.
> 
>    The implementation accesses a percpu variable which the x86 entry code
>    maintains, and returns the location immediately above the pt_regs on
>    the task stack (above which x86 has some padding).
> 
> * On arm64 current_top_of_stack() returns the top of the stack in active
>    use (i.e. the one which is currently being used).
> 
>    The implementation checks the SP against a number of
>    potentially-accessible stacks, and will BUG() if no stack is found.

As I could understand, for arm64, calling stackleak_erase() not from the thread 
stack would bring troubles because current_top_of_stack() would return an 
unexpected address from a foreign stack. Is this correct?

But this bug doesn't happen because arm64 always calls stackleak_erase() from 
the current thread stack. Right?

> The core stackleak_erase() code determines the upper bound of stack to
> erase with:
> 
> | if (on_thread_stack())
> |         boundary = current_stack_pointer;
> | else
> |         boundary = current_top_of_stack();
> 
> On arm64 stackleak_erase() is always called on a task stack, and
> on_thread_stack() should always be true. On x86, stackleak_erase() is
> mostly called on a trampoline stack, and is sometimes called on a task
> stack.
> 
> Currently, this results in a lot of unnecessary code being generated for
> arm64 for the impossible !on_thread_stack() case. Some of this is
> inlined, bloating stackleak_erase(), while portions of this are left
> out-of-line and permitted to be instrumented (which would be a
> functional problem if that code were reachable).

Sorry, I didn't understand this part about instrumentation. Could you elaborate 
please?

> As a first step towards improving this, this patch aligns arm64's
> implementation of current_top_of_stack() with x86's, always returning
> the top of the current task's stack. With GCC 11.1.0 this results in the
> bulk of the unnecessary code being removed, including all of the
> out-of-line instrumentable code.
> 
> While I don't believe there's a functional problem in practice I've
> marked this as a fix since the semantic was clearly wrong, the fix
> itself is simple, and other code might rely upon this in future.
> 
> Fixes: 0b3e336601b82c6a ("arm64: Add support for STACKLEAK gcc plugin")
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Alexander Popov <alex.popov@linux.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Will Deacon <will@kernel.org>
> ---
>   arch/arm64/include/asm/processor.h | 10 ++++------
>   1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
> index 73e38d9a540ce..6b1a12c23fe77 100644
> --- a/arch/arm64/include/asm/processor.h
> +++ b/arch/arm64/include/asm/processor.h
> @@ -381,12 +381,10 @@ long get_tagged_addr_ctrl(struct task_struct *task);
>    * of header definitions for the use of task_stack_page.
>    */
>   
> -#define current_top_of_stack()								\
> -({											\
> -	struct stack_info _info;							\
> -	BUG_ON(!on_accessible_stack(current, current_stack_pointer, 1, &_info));	\
> -	_info.high;									\
> -})
> +/*
> + * The top of the current task's task stack
> + */
> +#define current_top_of_stack()	((unsigned long)current->stack + THREAD_SIZE)
>   #define on_thread_stack()	(on_task_stack(current, current_stack_pointer, 1, NULL))
>   
>   #endif /* __ASSEMBLY__ */

