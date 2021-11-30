Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F21F463464
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 13:34:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241604AbhK3MiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 07:38:07 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:33880 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbhK3MiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 07:38:02 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5E19F1FD59;
        Tue, 30 Nov 2021 12:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1638275682; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fpzJzpUtUcBoti6u4Vx5MyjLRfI5xfFsHhW6Dr3Lcnw=;
        b=DpHiyHM2XViEBM4KfBrpR8vi43+dHuXUoqUN4Rz/0PdviP2Nz0MoV67Nf4aTOu1QB3ejlj
        noNin37l/OCjegAPe8Y+ovsl+Qrdulwj8QCMsSubl1mVOV1P5779H/HGe6/tzwbM/tiIvv
        KTv+1aYyn8zp9qe6VkgTMGEnQrbB7Ko=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1638275682;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fpzJzpUtUcBoti6u4Vx5MyjLRfI5xfFsHhW6Dr3Lcnw=;
        b=tIuNx6Tqh3yW0Dk8rpvwsrucH0KSqz7uF1jKvl52jXl6zJybsDC1GYMxlonxhSkman64bb
        4zfb9pA7l6tRziBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1C1D613D04;
        Tue, 30 Nov 2021 12:34:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6qowBmIapmGXeQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 30 Nov 2021 12:34:42 +0000
Message-ID: <37053057-1aa0-6ed3-7c84-c3eeb26cbcf1@suse.cz>
Date:   Tue, 30 Nov 2021 13:34:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] lib/stackdepot: always do filter_irq_stacks() in
 stack_depot_save()
Content-Language: en-US
To:     Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vijayanand Jitta <vjitta@codeaurora.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Imran Khan <imran.f.khan@oracle.com>,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, Chris Wilson <chris@chris-wilson.co.uk>,
        Jani Nikula <jani.nikula@intel.com>,
        Mika Kuoppala <mika.kuoppala@linux.intel.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
References: <20211130095727.2378739-1-elver@google.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20211130095727.2378739-1-elver@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/30/21 10:57, Marco Elver wrote:
> The non-interrupt portion of interrupt stack traces before interrupt
> entry is usually arbitrary. Therefore, saving stack traces of interrupts
> (that include entries before interrupt entry) to stack depot leads to
> unbounded stackdepot growth.
> 
> As such, use of filter_irq_stacks() is a requirement to ensure
> stackdepot can efficiently deduplicate interrupt stacks.
> 
> Looking through all current users of stack_depot_save(), none (except
> KASAN) pass the stack trace through filter_irq_stacks() before passing
> it on to stack_depot_save().
> 
> Rather than adding filter_irq_stacks() to all current users of
> stack_depot_save(), it became clear that stack_depot_save() should
> simply do filter_irq_stacks().

Agree.

> Signed-off-by: Marco Elver <elver@google.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

Thanks.

> ---
>  lib/stackdepot.c  | 13 +++++++++++++
>  mm/kasan/common.c |  1 -
>  2 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/stackdepot.c b/lib/stackdepot.c
> index b437ae79aca1..519c7898c7f2 100644
> --- a/lib/stackdepot.c
> +++ b/lib/stackdepot.c
> @@ -305,6 +305,9 @@ EXPORT_SYMBOL_GPL(stack_depot_fetch);
>   * (allocates using GFP flags of @alloc_flags). If @can_alloc is %false, avoids
>   * any allocations and will fail if no space is left to store the stack trace.
>   *
> + * If the stack trace in @entries is from an interrupt, only the portion up to
> + * interrupt entry is saved.
> + *
>   * Context: Any context, but setting @can_alloc to %false is required if
>   *          alloc_pages() cannot be used from the current context. Currently
>   *          this is the case from contexts where neither %GFP_ATOMIC nor
> @@ -323,6 +326,16 @@ depot_stack_handle_t __stack_depot_save(unsigned long *entries,
>  	unsigned long flags;
>  	u32 hash;
>  
> +	/*
> +	 * If this stack trace is from an interrupt, including anything before
> +	 * interrupt entry usually leads to unbounded stackdepot growth.
> +	 *
> +	 * Because use of filter_irq_stacks() is a requirement to ensure
> +	 * stackdepot can efficiently deduplicate interrupt stacks, always
> +	 * filter_irq_stacks() to simplify all callers' use of stackdepot.
> +	 */
> +	nr_entries = filter_irq_stacks(entries, nr_entries);
> +
>  	if (unlikely(nr_entries == 0) || stack_depot_disable)
>  		goto fast_exit;
>  
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index 8428da2aaf17..efaa836e5132 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -36,7 +36,6 @@ depot_stack_handle_t kasan_save_stack(gfp_t flags, bool can_alloc)
>  	unsigned int nr_entries;
>  
>  	nr_entries = stack_trace_save(entries, ARRAY_SIZE(entries), 0);
> -	nr_entries = filter_irq_stacks(entries, nr_entries);
>  	return __stack_depot_save(entries, nr_entries, flags, can_alloc);
>  }
>  
> 

