Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97B1851FEDC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 15:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236491AbiEINzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 09:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236387AbiEINzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 09:55:38 -0400
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01DE7388
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 06:51:41 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id g23so16365399edy.13
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 06:51:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=I+UuQQokEhtgBChlmBpHBCypu5a717cVzWM10GSoKUc=;
        b=c7XTCFiRb+ozPWtTQ9+sGd7LhnCN+WgdOflzQXHHsaov3VKSbmv+8lh67jwQJn9V2W
         4RzSZO2+YzyYzA25qfwNTdLVSUnlVfg3K2P7F8yon3l+GWk1agW9Cg4Puc0mVhhHGGI6
         opBN5mX26S8PJrKgoEAq+jKjyuvI72PtH2VZMPVXg1N6rYkZTIbycvK89Z6ffQaTAfaW
         LB5EVKDuP6H7Hp+m4yi6W/etVvobwaCCEtsW276o0rACEY68Arvt1zNDDls90PnI5uko
         s3jWkVs1cl8xQJAvVksaWWYMrAdOCBLg3SEBlHCR/C8RC9h3zrlmiST84x95kCXB50yf
         XPRg==
X-Gm-Message-State: AOAM5311r+i5HjlF64ntS4QyusSUrquzuB+/LM2XXRb7SiSD7LPDKNYq
        FG2zvrWO+2INab67q/18Y+s=
X-Google-Smtp-Source: ABdhPJwND82xQrYoV0/Sg89Rz15jSrtBVj+DZR70cD1DkdiJ5sWJLLDn2pIC3QJLcv7ssC789XK1Pw==
X-Received: by 2002:aa7:c403:0:b0:428:8741:63a2 with SMTP id j3-20020aa7c403000000b00428874163a2mr9808150edq.219.1652104299377;
        Mon, 09 May 2022 06:51:39 -0700 (PDT)
Received: from [10.9.0.34] ([46.166.128.205])
        by smtp.gmail.com with ESMTPSA id b7-20020a1709065e4700b006f3ef214db5sm5095641eju.27.2022.05.09.06.51.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 May 2022 06:51:38 -0700 (PDT)
Message-ID: <268ea8f7-472b-f1d4-6b8b-0c8fefccc0fa@linux.com>
Date:   Mon, 9 May 2022 16:51:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Reply-To: alex.popov@linux.com
Subject: Re: [PATCH v2 07/13] stackleak: rework poison scanning
Content-Language: en-US
To:     Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     akpm@linux-foundation.org, catalin.marinas@arm.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        luto@kernel.org, will@kernel.org
References: <20220427173128.2603085-1-mark.rutland@arm.com>
 <20220427173128.2603085-8-mark.rutland@arm.com>
From:   Alexander Popov <alex.popov@linux.com>
In-Reply-To: <20220427173128.2603085-8-mark.rutland@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mark!

On 27.04.2022 20:31, Mark Rutland wrote:
> Currently we over-estimate the region of stack which must be erased.
> 
> To determine the region to be erased, we scan downards for a contiguous
> block of poison values (or the low bound of the stack). There are a few
> minor problems with this today:
> 
> * When we find a block of poison values, we include this block within
>    the region to erase.
> 
>    As this is included within the region to erase, this causes us to
>    redundantly overwrite 'STACKLEAK_SEARCH_DEPTH' (128) bytes with
>    poison.

Right, this can be improved.

> * As the loop condition checks 'poison_count <= depth', it will run an
>    additional iteration after finding the contiguous block of poison,
>    decrementing 'erase_low' once more than necessary.

Actually, I think the current code is correct.

I'm intentionally searching one poison value more than STACKLEAK_SEARCH_DEPTH to 
avoid the corner case. See the BUILD_BUG_ON assertion in stackleak_track_stack() 
that describes it:

/*
  * Having CONFIG_STACKLEAK_TRACK_MIN_SIZE larger than
  * STACKLEAK_SEARCH_DEPTH makes the poison search in
  * stackleak_erase() unreliable. Let's prevent that.
  */
BUILD_BUG_ON(CONFIG_STACKLEAK_TRACK_MIN_SIZE > STACKLEAK_SEARCH_DEPTH);

>    As this is included within the region to erase, this causes us to
>    redundantly overwrite an additional unsigned long with poison.
> 
> * As we always decrement 'erase_low' after checking an element on the
>    stack, we always include the element below this within the region to
>    erase.
> 
>    As this is included within the region to erase, this causes us to
>    redundantly overwrite an additional unsigned long with poison.
> 
>    Note that this is not a functional problem. As the loop condition
>    checks 'erase_low > task_stack_low', we'll never clobber the
>    STACK_END_MAGIC. As we always decrement 'erase_low' after this, we'll
>    never fail to erase the element immediately above the STACK_END_MAGIC.

Right, I don't see any bug in the current erasing code.

When I wrote the current code, I carefully checked all the corner cases. For 
example, on the first stack erasing, the STACK_END_MAGIC was not overwritten, 
but the memory next to it was erased. Same for the beginning of the stack: I 
carefully checked that no unpoisoned bytes were left on the thread stack.

> In total, this can cause us to erase `128 + 2 * sizeof(unsigned long)`
> bytes more than necessary, which is unfortunate.
> 
> This patch reworks the logic to find the address immediately above the
> poisoned region, by finding the lowest non-poisoned address. This is
> factored into a stackleak_find_top_of_poison() helper both for clarity
> and so that this can be shared with the LKDTM test in subsequent
> patches.

You know, I wrote stackleak_erase() in very plain C. I wanted a compiler to 
generate assembly that is very close to the original asm version. I worried that 
compilers might do weird stuff with the local variables and the stack pointer.

So I checked stackleak for gcc versions 4.8, 5, 6, 7, 8, 9, and 10 on x86_64, 
i386 and arm64. This is my project that helped with this work:
https://github.com/a13xp0p0v/kernel-build-containers

Mark, in this patch series you use many local variables and helper functions.
Honestly, this worries me. For example, compilers can (and usually do) ignore 
the presence of the 'inline' specifier for the purpose of optimization.

Thanks!

> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Alexander Popov <alex.popov@linux.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Kees Cook <keescook@chromium.org>
> ---
>   include/linux/stackleak.h | 26 ++++++++++++++++++++++++++
>   kernel/stackleak.c        | 18 ++++--------------
>   2 files changed, 30 insertions(+), 14 deletions(-)
> 
> diff --git a/include/linux/stackleak.h b/include/linux/stackleak.h
> index 467661aeb4136..c36e7a3b45e7e 100644
> --- a/include/linux/stackleak.h
> +++ b/include/linux/stackleak.h
> @@ -42,6 +42,32 @@ stackleak_task_high_bound(const struct task_struct *tsk)
>   	return (unsigned long)task_pt_regs(tsk);
>   }
>   
> +/*
> + * Find the address immediately above the poisoned region of the stack, where
> + * that region falls between 'low' (inclusive) and 'high' (exclusive).
> + */
> +static __always_inline unsigned long
> +stackleak_find_top_of_poison(const unsigned long low, const unsigned long high)
> +{
> +	const unsigned int depth = STACKLEAK_SEARCH_DEPTH / sizeof(unsigned long);
> +	unsigned int poison_count = 0;
> +	unsigned long poison_high = high;
> +	unsigned long sp = high;
> +
> +	while (sp > low && poison_count < depth) {
> +		sp -= sizeof(unsigned long);
> +
> +		if (*(unsigned long *)sp == STACKLEAK_POISON) {
> +			poison_count++;
> +		} else {
> +			poison_count = 0;
> +			poison_high = sp;
> +		}
> +	}
> +
> +	return poison_high;
> +}
> +
>   static inline void stackleak_task_init(struct task_struct *t)
>   {
>   	t->lowest_stack = stackleak_task_low_bound(t);
> diff --git a/kernel/stackleak.c b/kernel/stackleak.c
> index ba346d46218f5..afd54b8e10b83 100644
> --- a/kernel/stackleak.c
> +++ b/kernel/stackleak.c
> @@ -74,20 +74,10 @@ static __always_inline void __stackleak_erase(void)
>   {
>   	const unsigned long task_stack_low = stackleak_task_low_bound(current);
>   	const unsigned long task_stack_high = stackleak_task_high_bound(current);
> -	unsigned long erase_low = current->lowest_stack;
> -	unsigned long erase_high;
> -	unsigned int poison_count = 0;
> -	const unsigned int depth = STACKLEAK_SEARCH_DEPTH / sizeof(unsigned long);
> -
> -	/* Search for the poison value in the kernel stack */
> -	while (erase_low > task_stack_low && poison_count <= depth) {
> -		if (*(unsigned long *)erase_low == STACKLEAK_POISON)
> -			poison_count++;
> -		else
> -			poison_count = 0;
> -
> -		erase_low -= sizeof(unsigned long);
> -	}
> +	unsigned long erase_low, erase_high;
> +
> +	erase_low = stackleak_find_top_of_poison(task_stack_low,
> +						 current->lowest_stack);
>   
>   #ifdef CONFIG_STACKLEAK_METRICS
>   	current->prev_lowest_stack = erase_low;

