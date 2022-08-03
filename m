Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBD775892FC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 22:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236742AbiHCUJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 16:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbiHCUJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 16:09:39 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B26A2981A
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 13:09:38 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id l22so22810323wrz.7
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 13:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+vbIHQxok3iBrj2ygZ5X4w7Hfhhf7olzopwK/xIfKBc=;
        b=mHTRC+oFNfZb6JnTQ4lIKW0p5Bq+p96OmXG2ESZkjtS2+U/rjSzs5tcrvtLnxgcCr3
         UyIaybazLa37uyvoWS3AOPDojwLvWkTWMFSXafcGH0e/pZFtt8y5knHUTmmEDotQNXxE
         TzmzGzELV5fmEGXXkQUoomEiT9sgpKHKiJ0TZ0rN6paBCOCxoJYjOMVD5PzaRHiOApoS
         kmVzX+i1yHUbXhfj3ytGQny/cLReJ13lF2JBswLq5jF+9SXR5GWS1Jbq5uJ2zsv3lyun
         cp6SlGP9pjoUg+EuttD/37MIgtVtESyrPympdrFCRUOz0rKkrlJ4KUgnaF7YRqZgyHjo
         Ya0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+vbIHQxok3iBrj2ygZ5X4w7Hfhhf7olzopwK/xIfKBc=;
        b=6ezlS84mvWDEynYCGesymtF1CNqxhKcUG6naNuMU51Vsx5pix7088ZU1t4fFKQeBOG
         ePnE7ZgnrgXwwrNbjXBCcfpAVJQFcsBUZdC/joY8KRSkz2Ld5uoqjfD9o/+JB/dcUs7t
         uZTUhZRunPj8RT6ji2tqhz3HYQ/rBwDyY1EeytZr562R9Ssav4w6DRdoEDhgsdz9+5y4
         OneNhyBH4tdR3QIASNxlB9Lj/5JgiX/OmAdtEI1WuaCEDAxw4TJiRwebjfTh7WDXYLtJ
         lHQpoCAKdCBZ1QvZ5x5Lg+DGp2bu/IvHF/TzmswZVCvZXFeaCIRAAOiTJ33h9RRMJwp4
         p7sQ==
X-Gm-Message-State: ACgBeo0VrbbqU5Gr+knSRdXuRNmg17IMY0pw/7sILSmy/LChKdxig6RW
        +tVLQLm91JU54k8DHA8oCL2Lcg==
X-Google-Smtp-Source: AA6agR6+hUx1RNa8pxKHdhQLYNSh0MrQSlw66W0kmYGZkGvbm8Bg5GIAMjomA/yhRPlosfi+yXvbGQ==
X-Received: by 2002:a5d:590f:0:b0:21f:c78:4693 with SMTP id v15-20020a5d590f000000b0021f0c784693mr16993089wrd.544.1659557377015;
        Wed, 03 Aug 2022 13:09:37 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:9c:201:3b95:8ad2:f0d4:6c46])
        by smtp.gmail.com with ESMTPSA id g9-20020adff3c9000000b0021eed2414c9sm18642635wrp.40.2022.08.03.13.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 13:09:36 -0700 (PDT)
Date:   Wed, 3 Aug 2022 22:09:29 +0200
From:   Marco Elver <elver@google.com>
To:     andrey.konovalov@linux.dev
Cc:     Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Florian Mayer <fmayer@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH mm v2 32/33] kasan: dynamically allocate stack ring
 entries
Message-ID: <YurV+SDkF2dQCQLn@elver.google.com>
References: <cover.1658189199.git.andreyknvl@google.com>
 <4db564768f1cb900b9687849a062156b470eb902.1658189199.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4db564768f1cb900b9687849a062156b470eb902.1658189199.git.andreyknvl@google.com>
User-Agent: Mutt/2.2.4 (2022-04-30)
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2022 at 02:10AM +0200, andrey.konovalov@linux.dev wrote:
> From: Andrey Konovalov <andreyknvl@google.com>
> 
> Instead of using a large static array, allocate the stack ring dynamically
> via memblock_alloc().
> 
> The size of the stack ring is controlled by a new kasan.stack_ring_size
> command-line parameter. When kasan.stack_ring_size is not provided, the
> default value of 32 << 10 is used.
> 
> When the stack trace collection is disabled via kasan.stacktrace=off,
> the stack ring is not allocated.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> 
> ---
> 
> Changes v1->v2:
> - This is a new patch.
> ---
>  mm/kasan/kasan.h       |  5 +++--
>  mm/kasan/report_tags.c |  4 ++--
>  mm/kasan/tags.c        | 22 +++++++++++++++++++++-
>  3 files changed, 26 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index 447baf1a7a2e..4afe4db751da 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -252,12 +252,13 @@ struct kasan_stack_ring_entry {
>  	bool is_free;
>  };
>  
> -#define KASAN_STACK_RING_SIZE (32 << 10)
> +#define KASAN_STACK_RING_SIZE_DEFAULT (32 << 10)
>  

This could be moved to tags.c, as there are no other users elsewhere.

>  struct kasan_stack_ring {
>  	rwlock_t lock;
> +	size_t size;
>  	atomic64_t pos;
> -	struct kasan_stack_ring_entry entries[KASAN_STACK_RING_SIZE];
> +	struct kasan_stack_ring_entry *entries;
>  };
>  
>  #endif /* CONFIG_KASAN_SW_TAGS || CONFIG_KASAN_HW_TAGS */
> diff --git a/mm/kasan/report_tags.c b/mm/kasan/report_tags.c
> index a996489e6dac..7e267e69ce19 100644
> --- a/mm/kasan/report_tags.c
> +++ b/mm/kasan/report_tags.c
> @@ -56,11 +56,11 @@ void kasan_complete_mode_report_info(struct kasan_report_info *info)
>  	 * entries relevant to the buggy object can be overwritten.
>  	 */
>  
> -	for (u64 i = pos - 1; i != pos - 1 - KASAN_STACK_RING_SIZE; i--) {
> +	for (u64 i = pos - 1; i != pos - 1 - stack_ring.size; i--) {
>  		if (alloc_found && free_found)
>  			break;
>  
> -		entry = &stack_ring.entries[i % KASAN_STACK_RING_SIZE];
> +		entry = &stack_ring.entries[i % stack_ring.size];
>  
>  		/* Paired with smp_store_release() in save_stack_info(). */
>  		ptr = (void *)smp_load_acquire(&entry->ptr);
> diff --git a/mm/kasan/tags.c b/mm/kasan/tags.c
> index 0eb6cf6717db..fd8c5f919156 100644
> --- a/mm/kasan/tags.c
> +++ b/mm/kasan/tags.c
> @@ -10,6 +10,7 @@
>  #include <linux/init.h>
>  #include <linux/kasan.h>
>  #include <linux/kernel.h>
> +#include <linux/memblock.h>
>  #include <linux/memory.h>
>  #include <linux/mm.h>
>  #include <linux/static_key.h>
> @@ -52,6 +53,16 @@ static int __init early_kasan_flag_stacktrace(char *arg)
>  }
>  early_param("kasan.stacktrace", early_kasan_flag_stacktrace);
>  
> +/* kasan.stack_ring_size=32768 */

What does that comment say? Is it "kasan.stack_ring_size=<entries>"?

Is it already in the documentation?

> +static int __init early_kasan_flag_stack_ring_size(char *arg)
> +{
> +	if (!arg)
> +		return -EINVAL;
> +
> +	return kstrtoul(arg, 0, &stack_ring.size);
> +}
> +early_param("kasan.stack_ring_size", early_kasan_flag_stack_ring_size);
> +
>  void __init kasan_init_tags(void)
>  {
>  	switch (kasan_arg_stacktrace) {
> @@ -65,6 +76,15 @@ void __init kasan_init_tags(void)
>  		static_branch_enable(&kasan_flag_stacktrace);
>  		break;
>  	}
> +
> +	if (kasan_stack_collection_enabled()) {
> +		if (!stack_ring.size)
> +			stack_ring.size = KASAN_STACK_RING_SIZE_DEFAULT;
> +		stack_ring.entries = memblock_alloc(
> +					sizeof(stack_ring.entries[0]) *
> +						stack_ring.size,
> +					SMP_CACHE_BYTES);

memblock_alloc() can fail. Because unlikely, stack collection should
probably just be disabled.

(minor: excessive line breaks makes the above unreadable.)

> +	}
>  }
>  
>  static void save_stack_info(struct kmem_cache *cache, void *object,
> @@ -86,7 +106,7 @@ static void save_stack_info(struct kmem_cache *cache, void *object,
>  
>  next:
>  	pos = atomic64_fetch_add(1, &stack_ring.pos);
> -	entry = &stack_ring.entries[pos % KASAN_STACK_RING_SIZE];
> +	entry = &stack_ring.entries[pos % stack_ring.size];
>  
>  	/* Detect stack ring entry slots that are being written to. */
>  	old_ptr = READ_ONCE(entry->ptr);
> -- 
> 2.25.1
