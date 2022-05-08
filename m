Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4416951EF6A
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 21:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239378AbiEHTHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 15:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238986AbiEHRsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 13:48:53 -0400
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFFA9BE10
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 10:45:01 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id dk23so22895674ejb.8
        for <linux-kernel@vger.kernel.org>; Sun, 08 May 2022 10:45:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=k3E+pHwvsluqh4RQWxDEEF6Q4LCI2lL0+EMS4NMvu6M=;
        b=WrCeko3aBhq9SZ5Zr6f65tgIvhFViDjCFSWqlyFf15cuw4Y+mGNAFUrsyRLTF13fO4
         FtPjpdkSpPUS3o4Ppl0Z+8UN2sggQVIEKHleixTx3wIquVJhgRokfufkcKK+Dk3iXnfb
         ukiZ1GpTfpxU8zxWnDOhd2Qcp45xuWIM11STCs4w+SXNEzc24Y2/mW9BslPhaGEVYLSD
         EZptqSiUtS7mpvP9Shd71DC3XBXHQkDIXAq+aYBa2SPhM/Iap6lQNFrO4vv2AX/1HevI
         9cS5vHa5pFNGrkf+jI8aUH5KfOKObFyAvlriAiJEzx7j0nsrFAXtPt39kZcusW51NT0P
         5NTw==
X-Gm-Message-State: AOAM5331UR7DqlwqGo+vWJ4N5hkBnpW1etOvYIokzqCRkXv6doI8UY5H
        q+RAGxbi61IfCWOlo8+CjFggvXP4d1U=
X-Google-Smtp-Source: ABdhPJwMBsbinqBwxW5+LE53BGDzuuqoEkSLWLSeIaJVJXv4ng7tNLsopng36LHkr0SoO/4JbQ1hTQ==
X-Received: by 2002:a17:907:d01:b0:6f4:d873:d7a0 with SMTP id gn1-20020a1709070d0100b006f4d873d7a0mr11633638ejc.717.1652031900107;
        Sun, 08 May 2022 10:45:00 -0700 (PDT)
Received: from [10.9.0.34] ([46.166.128.205])
        by smtp.gmail.com with ESMTPSA id wi22-20020a170906fd5600b006f3ef214de0sm4237170ejb.70.2022.05.08.10.44.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 May 2022 10:44:59 -0700 (PDT)
Message-ID: <51cea283-3cc7-2361-413c-d1bd8ac845bb@linux.com>
Date:   Sun, 8 May 2022 20:44:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Reply-To: alex.popov@linux.com
Subject: Re: [PATCH v2 02/13] stackleak: move skip_erasing() check earlier
Content-Language: en-US
To:     Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     akpm@linux-foundation.org, catalin.marinas@arm.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        luto@kernel.org, will@kernel.org
References: <20220427173128.2603085-1-mark.rutland@arm.com>
 <20220427173128.2603085-3-mark.rutland@arm.com>
From:   Alexander Popov <alex.popov@linux.com>
In-Reply-To: <20220427173128.2603085-3-mark.rutland@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.04.2022 20:31, Mark Rutland wrote:
> In stackleak_erase() we check skip_erasing() after accessing some fields
> from current. As generating the address of current uses asm which
> hazards with the static branch asm, this work is always performed, even
> when the static branch is patched to jump to the return a the end of the
> function.

Nice find!

> This patch avoids this redundant work by moving the skip_erasing() check
> earlier.
> 
> To avoid complicating initialization within stackleak_erase(), the body
> of the function is split out into a __stackleak_erase() helper, with the
> check left in a wrapper function. The __stackleak_erase() helper is
> marked __always_inline to ensure that this is inlined into
> stackleak_erase() and not instrumented.
> 
> Before this patch, on x86-64 w/ GCC 11.1.0 the start of the function is:
> 
> <stackleak_erase>:
>     65 48 8b 04 25 00 00    mov    %gs:0x0,%rax
>     00 00
>     48 8b 48 20             mov    0x20(%rax),%rcx
>     48 8b 80 98 0a 00 00    mov    0xa98(%rax),%rax
>     66 90                   xchg   %ax,%ax  <------------ static branch
>     48 89 c2                mov    %rax,%rdx
>     48 29 ca                sub    %rcx,%rdx
>     48 81 fa ff 3f 00 00    cmp    $0x3fff,%rdx
> 
> After this patch, on x86-64 w/ GCC 11.1.0 the start of the function is:
> 
> <stackleak_erase>:
>     0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)  <--- static branch
>     65 48 8b 04 25 00 00    mov    %gs:0x0,%rax
>     00 00
>     48 8b 48 20             mov    0x20(%rax),%rcx
>     48 8b 80 98 0a 00 00    mov    0xa98(%rax),%rax
>     48 89 c2                mov    %rax,%rdx
>     48 29 ca                sub    %rcx,%rdx
>     48 81 fa ff 3f 00 00    cmp    $0x3fff,%rdx
> 
> Before this patch, on arm64 w/ GCC 11.1.0 the start of the function is:
> 
> <stackleak_erase>:
>     d503245f        bti     c
>     d5384100        mrs     x0, sp_el0
>     f9401003        ldr     x3, [x0, #32]
>     f9451000        ldr     x0, [x0, #2592]
>     d503201f        nop  <------------------------------- static branch
>     d503233f        paciasp
>     cb030002        sub     x2, x0, x3
>     d287ffe1        mov     x1, #0x3fff
>     eb01005f        cmp     x2, x1
> 
> After this patch, on arm64 w/ GCC 11.1.0 the start of the function is:
> 
> <stackleak_erase>:
>     d503245f        bti     c
>     d503201f        nop  <------------------------------- static branch
>     d503233f        paciasp
>     d5384100        mrs     x0, sp_el0
>     f9401003        ldr     x3, [x0, #32]
>     d287ffe1        mov     x1, #0x3fff
>     f9451000        ldr     x0, [x0, #2592]
>     cb030002        sub     x2, x0, x3
>     eb01005f        cmp     x2, x1
> 
> While this may not be a huge win on its own, moving the static branch
> will permit further optimization of the body of the function in
> subsequent patches.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Alexander Popov <alex.popov@linux.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Kees Cook <keescook@chromium.org>
> ---
>   kernel/stackleak.c | 13 +++++++++----
>   1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/stackleak.c b/kernel/stackleak.c
> index ddb5a7f48d69e..753eab797a04d 100644
> --- a/kernel/stackleak.c
> +++ b/kernel/stackleak.c
> @@ -70,7 +70,7 @@ late_initcall(stackleak_sysctls_init);
>   #define skip_erasing()	false
>   #endif /* CONFIG_STACKLEAK_RUNTIME_DISABLE */
>   
> -asmlinkage void noinstr stackleak_erase(void)
> +static __always_inline void __stackleak_erase(void)

Are you sure that __stackleak_erase() doesn't need asmlinkage and noinstr as well?

>   {
>   	/* It would be nice not to have 'kstack_ptr' and 'boundary' on stack */
>   	unsigned long kstack_ptr = current->lowest_stack;
> @@ -78,9 +78,6 @@ asmlinkage void noinstr stackleak_erase(void)
>   	unsigned int poison_count = 0;
>   	const unsigned int depth = STACKLEAK_SEARCH_DEPTH / sizeof(unsigned long);
>   
> -	if (skip_erasing())
> -		return;
> -
>   	/* Check that 'lowest_stack' value is sane */
>   	if (unlikely(kstack_ptr - boundary >= THREAD_SIZE))
>   		kstack_ptr = boundary;
> @@ -125,6 +122,14 @@ asmlinkage void noinstr stackleak_erase(void)
>   	current->lowest_stack = current_top_of_stack() - THREAD_SIZE/64;
>   }
>   
> +asmlinkage void noinstr stackleak_erase(void)
> +{
> +	if (skip_erasing())
> +		return;
> +
> +	__stackleak_erase();
> +}
> +
>   void __used __no_caller_saved_registers noinstr stackleak_track_stack(void)
>   {
>   	unsigned long sp = current_stack_pointer;

