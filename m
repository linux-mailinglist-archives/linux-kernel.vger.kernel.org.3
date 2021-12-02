Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADECD466541
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 15:28:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355313AbhLBObc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 09:31:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347233AbhLBOb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 09:31:28 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6FBC06174A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 06:28:06 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id q3so37177894wru.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 06:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0bMo5owWEWMIAHQEq+ayNoaDPR5E2HoxKytk6h0JhPY=;
        b=TPi+XE3Oo+N09uSXdVOp7OEyleERqi72ChP0+G0uqZhZshuZxSAfAprKOVRe1GIEqz
         gRzzEK1xzF09jzf+kPRhI2C0VJo/LRHtaHhvWb9/YOHb8EBkVvu9pY9LiE6Li+lE/7sY
         7BuS03jEhWmkch/mmbrMu47CzL9UdkeorBmre8tYVi0wtzohdMJLqO+1tEqqYvXu8k08
         UqJ7sGFj4wwjQN6aid7XGc7e8d3ShtTTd9qrwuAHemTFX6OPz6MUmtIzgTVQNVQk6YDf
         bEl+TwOcQdk31SNEgEPPK2Im7xt5Cq3tp/emUcIPqrkqmYyAEHRv0e5WgRmUrsdNFeQv
         gT0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0bMo5owWEWMIAHQEq+ayNoaDPR5E2HoxKytk6h0JhPY=;
        b=rp4Z6x6pT/6pClExjmyC4yo3Z+fqJ3Ze2ZynTJdiZiDXKK6mUd8ocvYpmi3ZCgOqef
         9DdnePlmb+FwVXkG4kZbysCO5TFYsCyo01Ce+j+X+TVHLFN8pHEIC/I1db6J9Ipojy7Q
         Ri5tU4hPyCz227b6RdzdZZUmWkdhz9HMhBUv6JS/pP+HpUuVAe0gyZr3JkSfidhRY+N9
         +ra2ufcYtJ3Ht+jx/oEqoO57Xp9/pKr/0e/CNeVva6sZFgruP3S5L0j/ctR9vxKMYBqK
         jhVG/nSteEhFpRIGzb91EWKBUw4DzYLEpccSY5o2D/d6CyoETwaHJih94mGNltl5UMb8
         8bGg==
X-Gm-Message-State: AOAM533bKV5lcz3pr5jwmlDAvI0dkhC+1AiWVgZX2Y5y0TMd0pVMI0it
        o/472R2OKoZSqhKkhc8ZcNa/6Q==
X-Google-Smtp-Source: ABdhPJwOjT3KMKwLy1T16G1ueo5MPcTda4YCBsvgXWbw9NLVsW9gvMLOA03kXSxG0jRiauRt8sfvyQ==
X-Received: by 2002:adf:f0c5:: with SMTP id x5mr14116782wro.484.1638455284429;
        Thu, 02 Dec 2021 06:28:04 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:ddd6:f3c9:b2f0:82f3])
        by smtp.gmail.com with ESMTPSA id k37sm2403749wms.21.2021.12.02.06.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 06:28:03 -0800 (PST)
Date:   Thu, 2 Dec 2021 15:27:58 +0100
From:   Marco Elver <elver@google.com>
To:     andrey.konovalov@linux.dev
Cc:     Alexander Potapenko <glider@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Evgenii Stepanov <eugenis@google.com>,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH 21/31] kasan, fork: don't tag stacks allocated with
 vmalloc
Message-ID: <YajX7pyIK27Gd+IE@elver.google.com>
References: <cover.1638308023.git.andreyknvl@google.com>
 <4fbc6668845e699bf708aee5c11ad9fd012d4dcd.1638308023.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4fbc6668845e699bf708aee5c11ad9fd012d4dcd.1638308023.git.andreyknvl@google.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 11:07PM +0100, andrey.konovalov@linux.dev wrote:
> From: Andrey Konovalov <andreyknvl@google.com>
> 
> Once tag-based KASAN modes start tagging vmalloc() allocations,
> kernel stacks will start getting tagged if CONFIG_VMAP_STACK is enabled.
> 
> Reset the tag of kernel stack pointers after allocation.
> 
> For SW_TAGS KASAN, when CONFIG_KASAN_STACK is enabled, the
> instrumentation can't handle the sp register being tagged.
> 
> For HW_TAGS KASAN, there's no instrumentation-related issues. However,
> the impact of having a tagged SP pointer needs to be properly evaluated,
> so keep it non-tagged for now.

Don't VMAP_STACK stacks have guards? So some out-of-bounds would already
be caught.

What would be the hypothetical benefit of using a tagged stack pointer?
Perhaps wildly out-of-bounds accesses derived from stack pointers?

I agree that unless we understand the impact of using a tagged stack
pointers, it should remain non-tagged for now.

> Note, that the memory for the stack allocation still gets tagged to
> catch vmalloc-into-stack out-of-bounds accesses.

Will the fact it's tagged cause issues for other code? I think kmemleak
already untags all addresses it scans for pointers. Anything else?

> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---
>  kernel/fork.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 3244cc56b697..062d1484ef42 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -253,6 +253,7 @@ static unsigned long *alloc_thread_stack_node(struct task_struct *tsk, int node)
>  	 * so cache the vm_struct.
>  	 */
>  	if (stack) {
> +		stack = kasan_reset_tag(stack);
>  		tsk->stack_vm_area = find_vm_area(stack);
>  		tsk->stack = stack;
>  	}
> -- 
> 2.25.1
> 
