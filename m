Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57BFD4C0588
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 00:48:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236359AbiBVXtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 18:49:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236378AbiBVXsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 18:48:55 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B40AE205E3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 15:48:18 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id ay3so8249660plb.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 15:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=QHrAS3A8IcMIjqhd+x7nT/pax8A9IkaVmYq/eD6UPq8=;
        b=YlfM1kO4ptvT/e1FagzFXsEe8gOa3MZTgvK/6HVo+9mABi6khL+U77cXvM+rKC3LSg
         MpcDSVsxHnik7Np0YrpcNQf63jSopJ/n7bTcdbBmqc+3fQIqK0Qzm/pWxuUv5FI1t0T8
         VNwFbj/0xgD3jimV8y0fkQmGYBg73OJD8ZW/ftgB9PyJVLSXgiA/7VGhTay92MgtA6Nn
         EJOXMcbqJs6qn0cVaAegFr2RBCwqT1AgRm1S8kfLHbpr6vxGsX2GlvoENB14YdI9k8J0
         ci7PDnUMLujzURubjF7J9QN3QWK92V6/LTo4WF/kL0AkAKbwUm8a2LNn853luFmlJ27c
         qhYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=QHrAS3A8IcMIjqhd+x7nT/pax8A9IkaVmYq/eD6UPq8=;
        b=TqC6QnlYwQeiC/WsrOUAscup/VHPsSxH4szHcVUY8AwqOyKnix6RD7Elq1YrA7QA81
         AovvqbiBXELqXFo7FRAeP41mCJuK/wn9ZawnjogD2a/UW3LTyRCrocrYb60/nicZWLfT
         JpTYUns7vyBHBGfnk7WoTr6wxvFS3G1Bh5F/7L6QGihK+ftFLHaXkz8A6AWagH/WcLRC
         egJQJZGMTr+u99tHPXWEHvGRvH8E6Vcvp3luQcDiPcPOHOxnTEyX/8/t0xOdpHAmlbiC
         7pXtyWZi0gQzGNEYS3EEhpV6dklKikHC8i08qvuYuekv3P5tEY4b5fH1W3b00BKg5DGD
         hJQQ==
X-Gm-Message-State: AOAM533O88R7iBbrtEESFB7WC90OoXu9Y1TiO61SrRO7ZQrkzeR8HoXa
        TEnOWYURwYUP9YXzAFtwEe0seg==
X-Google-Smtp-Source: ABdhPJx5QYgdP+V0SOujHmb8fCcQLYTtX+5XbFBHLUWH9l6WovBtPOraI7jXZd6BSlWd47c+YlDJNA==
X-Received: by 2002:a17:903:32c6:b0:14f:c5ec:9f28 with SMTP id i6-20020a17090332c600b0014fc5ec9f28mr9291210plr.51.1645573697992;
        Tue, 22 Feb 2022 15:48:17 -0800 (PST)
Received: from [2620:15c:29:204:6b0f:423a:fd82:4e05] ([2620:15c:29:204:6b0f:423a:fd82:4e05])
        by smtp.gmail.com with ESMTPSA id u12-20020a17090a890c00b001b8efcf8e48sm739687pjn.14.2022.02.22.15.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 15:48:17 -0800 (PST)
Date:   Tue, 22 Feb 2022 15:48:16 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
cc:     linux-mm@kvack.org, Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>
Subject: Re: [PATCH 4/5] mm/slub: Limit min_partial only in cache creation
In-Reply-To: <20220221105336.522086-5-42.hyeyoo@gmail.com>
Message-ID: <91cc8ab-a0f0-2687-df99-10b2267c7a9@google.com>
References: <20220221105336.522086-1-42.hyeyoo@gmail.com> <20220221105336.522086-5-42.hyeyoo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Mon, 21 Feb 2022, Hyeonggon Yoo wrote:

> SLUB sets number of minimum partial slabs for node (min_partial) using
> set_min_partial(). SLUB holds at least min_partial slabs even if they're empty
> to avoid excessive use of page allocator.
> 
> set_min_partial() limits value of min_partial between MIN_PARTIAL and
> MAX_PARTIAL. As set_min_partial() can be called by min_partial_store()
> too, Only limit value of min_partial in kmem_cache_open() so that it
> can be changed to value that a user wants.
> 
> Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

I think this makes sense and there is no reason to limit the bounds that 
may be set at runtime with undocumented behavior.

However, since set_min_partial() is only setting the value in the 
kmem_cache, could we remove the helper function entirely and fold it into 
its two callers?

> ---
>  mm/slub.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 3a4458976ab7..a4964deccb61 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -4002,10 +4002,6 @@ static int init_kmem_cache_nodes(struct kmem_cache *s)
>  
>  static void set_min_partial(struct kmem_cache *s, unsigned long min)
>  {
> -	if (min < MIN_PARTIAL)
> -		min = MIN_PARTIAL;
> -	else if (min > MAX_PARTIAL)
> -		min = MAX_PARTIAL;
>  	s->min_partial = min;
>  }
>  
> @@ -4184,6 +4180,8 @@ static int calculate_sizes(struct kmem_cache *s, int forced_order)
>  
>  static int kmem_cache_open(struct kmem_cache *s, slab_flags_t flags)
>  {
> +	int min_partial;
> +
>  	s->flags = kmem_cache_flags(s->size, flags, s->name);
>  #ifdef CONFIG_SLAB_FREELIST_HARDENED
>  	s->random = get_random_long();
> @@ -4215,7 +4213,10 @@ static int kmem_cache_open(struct kmem_cache *s, slab_flags_t flags)
>  	 * The larger the object size is, the more slabs we want on the partial
>  	 * list to avoid pounding the page allocator excessively.
>  	 */
> -	set_min_partial(s, ilog2(s->size) / 2);
> +	min_partial = min(MAX_PARTIAL, ilog2(s->size) / 2);
> +	min_partial = max(MIN_PARTIAL, min_partial);
> +
> +	set_min_partial(s, min_partial);
>  
>  	set_cpu_partial(s);
>  
> -- 
> 2.33.1
> 
> 
