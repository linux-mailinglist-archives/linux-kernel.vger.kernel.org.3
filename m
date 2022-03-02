Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 688E94CAC67
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 18:47:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244227AbiCBRr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 12:47:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244274AbiCBRr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 12:47:56 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D5AD19B1
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 09:47:12 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id p9so3942021wra.12
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 09:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=babB7lz53+t2z0xMSNGpVBWnIE028PwCS5tlqxlaCt4=;
        b=iQHkTcjGH932p2hqrL2Znc97cS2n8fBFEDQZZyTnQUOd57pWEttKWiYBxiBdN+x0g8
         FbCvxQ0nbcty/dtamxohDvRjFqFzpQQB+ZkEoJ7SMXASfKPiK6KFUyIWEcsvcTpS4M0n
         gBOJcg4ph/jAxQei3OeKzwxCNpi3udAmQI3wGq7KmqTVIQSDCA/O+JVOEJIZwL/nG2zO
         Jl+6hzOml42W6qkYYgiGhkQlzSiRh5u8QJhfYrqgwbWosVSh1c3gJ8PeACJTOstvwLUk
         5f52K09Cuc1Ada/scL/yUCPfMnbrm6j2mAKupizg6tPxKb1z2DNn5yF/K1U0yqLAqrxt
         pyZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=babB7lz53+t2z0xMSNGpVBWnIE028PwCS5tlqxlaCt4=;
        b=hFKpEt+v6baPq0t/49XBGd1otnTZFntRqy/jMbij8VFCNfYWneeVIWHTOiSrIZ8NkI
         +koLyH3N+aJihpiWdXreSabe3fXd18TV+JGghWC+Dn0Mf32SArba+a5Oy59pbFuWZBvE
         4tLro1AZIPZYMxHhBHdCuHen7YGPbUh/Rv+ColCLXaBoiwG+8t8fZTMdJeiGs1MhWHEk
         ZMQuy9gQ8NH73LGo5Vc0qzAfUL02sr7ow9DXqhlEQKhWF/MMQBTLqc11d+sJRH759J7r
         n27oreF4fTYklTN6bcNaWlRzzhNeh0glF2ZT0jWh1Pvd9iqV54ilfubdFGpIUvu0NFzF
         b4Fw==
X-Gm-Message-State: AOAM533arn/pqQng/Z9r46bAAV7nKifbPXAi6youqVcxqXh9BHDq9P/9
        7wbmpx0+c4mD4qum49JfCOP33Q==
X-Google-Smtp-Source: ABdhPJzUUEWMcnms/5qjdNhJPBP5UEjbNdvLuLz4bPej2xsS5DQyaFuN1zOPIFK2ogEEOKhkCPI2tQ==
X-Received: by 2002:a5d:47a1:0:b0:1f0:3440:2d04 with SMTP id 1-20020a5d47a1000000b001f034402d04mr2801204wrb.357.1646243230762;
        Wed, 02 Mar 2022 09:47:10 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:2ddb:aa6:c006:df16])
        by smtp.gmail.com with ESMTPSA id 2-20020a1c1902000000b00380d3873d6asm6525416wmz.43.2022.03.02.09.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 09:47:10 -0800 (PST)
Date:   Wed, 2 Mar 2022 18:47:04 +0100
From:   Marco Elver <elver@google.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        Oliver Glitta <glittao@gmail.com>,
        Faiyaz Mohammed <faiyazm@codeaurora.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Imran Khan <imran.f.khan@oracle.com>
Subject: Re: [PATCH v2 1/6] lib/stackdepot: allow requesting early
 initialization dynamically
Message-ID: <Yh+tmJT0ov8uwC6/@elver.google.com>
References: <20220302173122.11939-1-vbabka@suse.cz>
 <20220302173122.11939-2-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220302173122.11939-2-vbabka@suse.cz>
User-Agent: Mutt/2.1.4 (2021-12-11)
X-Spam-Status: No, score=-18.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2022 at 06:31PM +0100, Vlastimil Babka wrote:
> In a later patch we want to add stackdepot support for object owner
> tracking in slub caches, which is enabled by slub_debug boot parameter.
> This creates a bootstrap problem as some caches are created early in
> boot when slab_is_available() is false and thus stack_depot_init()
> tries to use memblock. But, as reported by Hyeonggon Yoo [1] we are
> already beyond memblock_free_all(). Ideally memblock allocation should
> fail, yet it succeeds, but later the system crashes, which is a
> separately handled issue.
> 
> To resolve this boostrap issue in a robust way, this patch adds another
> way to request stack_depot_early_init(), which happens at a well-defined
> point of time. In addition to build-time CONFIG_STACKDEPOT_ALWAYS_INIT,
> code that's e.g. processing boot parmeters (which happens early enough)
> can set a new variable stack_depot_want_early_init as true.

Agree, I think this is the best solution.

> In this patch we also convert page_owner to this approach. While it
> doesn't have the bootstrap issue as slub, it's also a functionality
> enabled by a boot param and can thus request stack_depot_early_init()
> with memblock allocation instead of later initialization with
> kvmalloc().
> 
> [1] https://lore.kernel.org/all/YhnUcqyeMgCrWZbd@ip-172-31-19-208.ap-northeast-1.compute.internal/
> 
> Reported-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  include/linux/stackdepot.h | 16 ++++++++++++++--
>  lib/stackdepot.c           |  2 ++
>  mm/page_owner.c            |  9 ++++++---
>  3 files changed, 22 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/stackdepot.h b/include/linux/stackdepot.h
> index 17f992fe6355..1217ba2b636e 100644
> --- a/include/linux/stackdepot.h
> +++ b/include/linux/stackdepot.h
> @@ -15,6 +15,8 @@
>  
>  typedef u32 depot_stack_handle_t;
>  
> +extern bool stack_depot_want_early_init;
> +
>  depot_stack_handle_t __stack_depot_save(unsigned long *entries,
>  					unsigned int nr_entries,
>  					gfp_t gfp_flags, bool can_alloc);
> @@ -26,11 +28,21 @@ depot_stack_handle_t __stack_depot_save(unsigned long *entries,
>   * The alternative is to select STACKDEPOT_ALWAYS_INIT to have stack depot
>   * enabled as part of mm_init(), for subsystems where it's known at compile time
>   * that stack depot will be used.
> + *
> + * Another alternative is to set stack_depot_want_early_init as true, when the
> + * decision to use stack depot is taken e.g. when evaluating kernel boot
> + * parameters, which precedes the call to stack_depot_want_early_init().
>   */
>  int stack_depot_init(void);

I think for stack_depot_init() it might now be convenient to provide a
no-op version automatically if !STACKDEPOT, which would avoid
some 'if (.. && IS_ENABLED(CONFIG_STACKDEPOT))' in a later patch.

Similarly, for stack_depot_want_early_init, where instead you could
simply provide stack_depot_want_early_init() as a function, which simply
sets a boolean __stack_depot_want_early_init. If !STACKDEPOT, it'll also
just be a no-op function.

>  
> -#ifdef CONFIG_STACKDEPOT_ALWAYS_INIT
> -static inline int stack_depot_early_init(void)	{ return stack_depot_init(); }
> +#ifdef CONFIG_STACKDEPOT
> +static inline int stack_depot_early_init(void)
> +{
> +	if (IS_ENABLED(CONFIG_STACKDEPOT_ALWAYS_INIT)
> +	    || stack_depot_want_early_init)
> +		return stack_depot_init();
> +	return 0;
> +}
>  #else
>  static inline int stack_depot_early_init(void)	{ return 0; }
>  #endif
> diff --git a/lib/stackdepot.c b/lib/stackdepot.c
> index bf5ba9af0500..02e2b5fcbf3b 100644
> --- a/lib/stackdepot.c
> +++ b/lib/stackdepot.c
> @@ -66,6 +66,8 @@ struct stack_record {
>  	unsigned long entries[];	/* Variable-sized array of entries. */
>  };
>  
> +bool stack_depot_want_early_init = false;
> +

This can be __initdata, right?

>  static void *stack_slabs[STACK_ALLOC_MAX_SLABS];
>  
>  static int depot_index;
> diff --git a/mm/page_owner.c b/mm/page_owner.c
> index 99e360df9465..40dce2b81d13 100644
> --- a/mm/page_owner.c
> +++ b/mm/page_owner.c
> @@ -42,7 +42,12 @@ static void init_early_allocated_pages(void);
>  
>  static int __init early_page_owner_param(char *buf)
>  {
> -	return kstrtobool(buf, &page_owner_enabled);
> +	int ret = kstrtobool(buf, &page_owner_enabled);
> +
> +	if (page_owner_enabled)
> +		stack_depot_want_early_init = true;
> +
> +	return ret;
>  }
>  early_param("page_owner", early_page_owner_param);
>  
> @@ -80,8 +85,6 @@ static __init void init_page_owner(void)
>  	if (!page_owner_enabled)
>  		return;
>  
> -	stack_depot_init();
> -
>  	register_dummy_stack();
>  	register_failure_stack();
>  	register_early_stack();
> -- 
> 2.35.1
> 
