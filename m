Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22FBB5514F7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 11:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240584AbiFTJyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 05:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239833AbiFTJya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 05:54:30 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A17513E16
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 02:54:29 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id s1so13876480wra.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 02:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/5XQWxUT78CJ9q4IKK57xGusAoxHrjt7w5b5bQek9HA=;
        b=HeTIwbsdqxTlA6dnJyf7K/MPvYGDs+ekgNBGuf/QI/nMpkPVYE/lzCyvyLrzqiUlIi
         YGN8SG5jr5aCTedEE5DrZ0AQ9cStZmCYIs5+FDtef0xGw57/QYpSn7teIYN7Bsxz6kco
         ZgFFHAlBfzUHox6+rXb20NTfCJ6d8c/en1GKc4GhrlsERxjMsYLYV5dUYlfCYmiqGbkl
         LvMrADI2Y1du47q5PLoR7vEUvV131eHlDe3CgaeK6u+xz6THfV3bHIZZzc1xZfpjew3w
         Vsho5v7hLodwpKyGgoMt7eQnmR/3tJH8RuTXyHcTlUNAjELbiPEQN14td7jsvPX4aruE
         202w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/5XQWxUT78CJ9q4IKK57xGusAoxHrjt7w5b5bQek9HA=;
        b=1JgVsIIdmI1AJ9UXSKrqAEcL94osiyFB5KD2wXCFjXeoMsIr7Tfc0wSu+XizR4zA8h
         b24/WtWQoy0ozrzmiMxvba7CIAnxRSbs4Kr6QY0DEcQiKSg2jtgG91K+0Y3Hjm7HxVaf
         X7j7khR6l1aiGQMFnRk+EZ9Bs34iFtbNorD1uEbICamk6IcgLSgrk0vmtuQZORwF67v3
         A3XH1cWNAsR+CI4gbIbdcP2PzfACWD9y2jgcjsD3U4EuP/ypj/lwRXm4t/D83TT0Dub8
         PmnqYNtu9wk/XmhPzpBSOUcW2yXkR9tF7A/80R7h3V/1cqp2pHR1ywpqgjKk2kSGGmmf
         1PAQ==
X-Gm-Message-State: AJIora9GgqxQm8tPIKx3Nmch2hECFraOZXgzbPTBZiRCzHHKzRLR/4UC
        Azg4yEnd0L7co4kIcEmf4OVwCw==
X-Google-Smtp-Source: AGRyM1syJP7htSzs0rJB262nXQ0Y+FJd1OOBP4w+WYMDOyC5HF6+bK1dXdRGh0DPmaMD+cqj9jFKzQ==
X-Received: by 2002:a5d:47a7:0:b0:218:5a5d:6c55 with SMTP id 7-20020a5d47a7000000b002185a5d6c55mr22074873wrb.192.1655718867517;
        Mon, 20 Jun 2022 02:54:27 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:9c:201:3746:a989:7595:e29f])
        by smtp.gmail.com with ESMTPSA id z6-20020a5d4d06000000b0021a3dd1c5d5sm10312787wrt.96.2022.06.20.02.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 02:54:26 -0700 (PDT)
Date:   Mon, 20 Jun 2022 11:54:20 +0200
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
Subject: Re: [PATCH 19/32] kasan: pass tagged pointers to
 kasan_save_alloc/free_info
Message-ID: <YrBDzKTZMnWztGIQ@elver.google.com>
References: <cover.1655150842.git.andreyknvl@google.com>
 <9363b16202fb04a3223de714e70b7a6b72c4367e.1655150842.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9363b16202fb04a3223de714e70b7a6b72c4367e.1655150842.git.andreyknvl@google.com>
User-Agent: Mutt/2.2.3 (2022-04-12)
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 10:14PM +0200, andrey.konovalov@linux.dev wrote:
> From: Andrey Konovalov <andreyknvl@google.com>
> 
> Pass tagged pointers to kasan_save_alloc/free_info().
> 
> This is a preparatory patch to simplify other changes in the series.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---
>  mm/kasan/common.c  | 4 ++--
>  mm/kasan/generic.c | 3 +--
>  mm/kasan/kasan.h   | 2 +-
>  mm/kasan/tags.c    | 3 +--
>  4 files changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index f937b6c9e86a..519fd0b3040b 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -227,7 +227,7 @@ static inline bool ____kasan_slab_free(struct kmem_cache *cache, void *object,
>  		return false;
>  
>  	if (kasan_stack_collection_enabled())
> -		kasan_save_free_info(cache, object, tag);
> +		kasan_save_free_info(cache, tagged_object);
>  

Variable 'tag' becomes unused in this function after this patch.

>  	return kasan_quarantine_put(cache, object);
>  }
> @@ -316,7 +316,7 @@ void * __must_check __kasan_slab_alloc(struct kmem_cache *cache,
>  
>  	/* Save alloc info (if possible) for non-kmalloc() allocations. */
>  	if (kasan_stack_collection_enabled() && !cache->kasan_info.is_kmalloc)
> -		kasan_save_alloc_info(cache, (void *)object, flags);
> +		kasan_save_alloc_info(cache, tagged_object, flags);
>  
>  	return tagged_object;
>  }
> diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
> index f6bef347de87..aff39af3c532 100644
> --- a/mm/kasan/generic.c
> +++ b/mm/kasan/generic.c
> @@ -500,8 +500,7 @@ void kasan_save_alloc_info(struct kmem_cache *cache, void *object, gfp_t flags)
>  		kasan_set_track(&alloc_meta->alloc_track, flags);
>  }
>  
> -void kasan_save_free_info(struct kmem_cache *cache,
> -				void *object, u8 tag)
> +void kasan_save_free_info(struct kmem_cache *cache, void *object)
>  {
>  	struct kasan_free_meta *free_meta;
>  
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index 30ec9ebf52c3..e8329935fbfb 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -308,7 +308,7 @@ static inline void kasan_init_object_meta(struct kmem_cache *cache, const void *
>  depot_stack_handle_t kasan_save_stack(gfp_t flags, bool can_alloc);
>  void kasan_set_track(struct kasan_track *track, gfp_t flags);
>  void kasan_save_alloc_info(struct kmem_cache *cache, void *object, gfp_t flags);
> -void kasan_save_free_info(struct kmem_cache *cache, void *object, u8 tag);
> +void kasan_save_free_info(struct kmem_cache *cache, void *object);
>  struct kasan_track *kasan_get_alloc_track(struct kmem_cache *cache,
>  						void *object);
>  struct kasan_track *kasan_get_free_track(struct kmem_cache *cache,
> diff --git a/mm/kasan/tags.c b/mm/kasan/tags.c
> index 4f24669085e9..fd11d10a4ffc 100644
> --- a/mm/kasan/tags.c
> +++ b/mm/kasan/tags.c
> @@ -21,8 +21,7 @@ void kasan_save_alloc_info(struct kmem_cache *cache, void *object, gfp_t flags)
>  {
>  }
>  
> -void kasan_save_free_info(struct kmem_cache *cache,
> -				void *object, u8 tag)
> +void kasan_save_free_info(struct kmem_cache *cache, void *object)
>  {
>  }
>  
> -- 
> 2.25.1
> 
> -- 
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/9363b16202fb04a3223de714e70b7a6b72c4367e.1655150842.git.andreyknvl%40google.com.
