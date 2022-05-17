Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66B5152ADEE
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 00:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbiEQWRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 18:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiEQWRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 18:17:15 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6BFB37025;
        Tue, 17 May 2022 15:17:13 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id q18so54851pln.12;
        Tue, 17 May 2022 15:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=cwZoaiE0qmCYO1y5XITA8VMbwPlD4wCftR3Cmz5EzWQ=;
        b=WpIU6+iLtUdKTEvfXkzkkeqrJv+csuMlTbkjyZ58RL7R+atph3mOyl0ILFcR/qdoDi
         TTgrO/o5IWMVBVAzHWsfezMALCkir658HhBEzdo14Az8nieVvefMCGxyKRRAAQeJBeU2
         TgyxLi5mEAd7+S44hm2Nsz81jXVETx3PHvaKwdRwalYXqjdJJWGYYZudW6nU/JJYUkDl
         MFm87cBXuubtsS7skOsTVisERs5t2hxvaINJqDcjO42vMYFP0j0z3SidKH21n1yLam0U
         tyVfeAQBqh6Ri7F0jdM0TCToUMYl5XPdfqsS+XDD/tgGjw/Ajx7gIeWC8VgJioTsWhgN
         a7qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=cwZoaiE0qmCYO1y5XITA8VMbwPlD4wCftR3Cmz5EzWQ=;
        b=sqlEctfGAK8Q1dtELjb6tzqxGsM/Lj/HKFOmc9EWQkcc66Y+kC/V9fIPJnXf3fEXVW
         lOQ4Jn8fxrFB0HkrRPRawqZdeXujkYDEPqW+KvmMAQnj8E+eKisrSvJIhZalqhf2Nm7T
         8ksaOu0QdJbzmZPkynhaM+w6wc7yvvWLiP/pxRN69y4jdVEAe/WjVcsQZq8Yksc/GkYq
         YE9RHUVXCwj5TdFEd+ic32ZdhsdvyxQVwVlxfAIbA11yuAGJxoZB2BpKsr/eWJL7dceT
         EK0MhnIoJ6eXGm/vCMKS/Aa0sInhdE+D9u7LBjIT8v1z9XKXgRiHj4r8FcggFkRp/1RI
         Lw/w==
X-Gm-Message-State: AOAM532xPK0KjU0JLzt9d5z0LFjQXP8C45Ybp8u//8DalBuLJ/n4g1yX
        2yWh9MkGg5zEiSEeb3P5kF4=
X-Google-Smtp-Source: ABdhPJxPQ3x6WdCO0nqnEy5e3j1aSQWYkXx9yZ8Le1Oqsy6rlgqK8t8SljOVxU9+aNkBz0dHa3H9hA==
X-Received: by 2002:a17:90a:a385:b0:1cb:bfa8:ae01 with SMTP id x5-20020a17090aa38500b001cbbfa8ae01mr26754743pjp.116.1652825833285;
        Tue, 17 May 2022 15:17:13 -0700 (PDT)
Received: from localhost (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id i71-20020a62874a000000b0050dc7628141sm246532pfe.27.2022.05.17.15.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 15:17:12 -0700 (PDT)
Date:   Tue, 17 May 2022 15:15:00 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Christophe de Dinechin <dinechin@redhat.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 2/2] nodemask: Fix return values to be unsigned
Message-ID: <YoQeZIl2P9wOK+u8@yury-laptop>
References: <20220517212234.868181-1-keescook@chromium.org>
 <20220517212234.868181-3-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220517212234.868181-3-keescook@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2022 at 02:22:34PM -0700, Kees Cook wrote:
> The nodemask routines had mixed return values that provided potentially
> signed return values that could never happen. This was leading to the
> compiler getting confusing about the range of possible return values
> (it was thinking things could be negative where they could not be). Fix
> all the nodemask routines that should be returning unsigned
> (or bool) values. Silences:
> 
>  mm/swapfile.c: In function ‘setup_swap_info’:
>  mm/swapfile.c:2291:47: error: array subscript -1 is below array bounds of ‘struct plist_node[]’ [-Werror=array-bounds]
>   2291 |                                 p->avail_lists[i].prio = 1;
>        |                                 ~~~~~~~~~~~~~~^~~
>  In file included from mm/swapfile.c:16:
>  ./include/linux/swap.h:292:27: note: while referencing ‘avail_lists’
>    292 |         struct plist_node avail_lists[]; /*
>        |                           ^~~~~~~~~~~
> 
> Reported-by: Christophe de Dinechin <dinechin@redhat.com>
> Link: https://lore.kernel.org/lkml/20220414150855.2407137-3-dinechin@redhat.com/
> Cc: Alexey Dobriyan <adobriyan@gmail.com>
> Cc: Yury Norov <yury.norov@gmail.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Zhen Lei <thunder.leizhen@huawei.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  include/linux/nodemask.h | 38 +++++++++++++++++++-------------------
>  lib/nodemask.c           |  2 +-
>  2 files changed, 20 insertions(+), 20 deletions(-)
> 
> diff --git a/include/linux/nodemask.h b/include/linux/nodemask.h
> index 567c3ddba2c4..2c39663c3407 100644
> --- a/include/linux/nodemask.h
> +++ b/include/linux/nodemask.h
> @@ -42,11 +42,11 @@
>   * void nodes_shift_right(dst, src, n)	Shift right
>   * void nodes_shift_left(dst, src, n)	Shift left
>   *
> - * int first_node(mask)			Number lowest set bit, or MAX_NUMNODES
> - * int next_node(node, mask)		Next node past 'node', or MAX_NUMNODES
> - * int next_node_in(node, mask)		Next node past 'node', or wrap to first,
> + * unsigned int first_node(mask)	Number lowest set bit, or MAX_NUMNODES
> + * unsigend int next_node(node, mask)	Next node past 'node', or MAX_NUMNODES
> + * unsigned int next_node_in(node, mask) Next node past 'node', or wrap to first,
>   *					or MAX_NUMNODES
> - * int first_unset_node(mask)		First node not set in mask, or 
> + * unsigned int first_unset_node(mask)	First node not set in mask, or
>   *					MAX_NUMNODES
>   *
>   * nodemask_t nodemask_of_node(node)	Return nodemask with bit 'node' set
> @@ -153,7 +153,7 @@ static inline void __nodes_clear(nodemask_t *dstp, unsigned int nbits)
>  
>  #define node_test_and_set(node, nodemask) \
>  			__node_test_and_set((node), &(nodemask))
> -static inline int __node_test_and_set(int node, nodemask_t *addr)
> +static inline bool __node_test_and_set(int node, nodemask_t *addr)
>  {
>  	return test_and_set_bit(node, addr->bits);
>  }
> @@ -200,7 +200,7 @@ static inline void __nodes_complement(nodemask_t *dstp,
>  
>  #define nodes_equal(src1, src2) \
>  			__nodes_equal(&(src1), &(src2), MAX_NUMNODES)
> -static inline int __nodes_equal(const nodemask_t *src1p,
> +static inline bool __nodes_equal(const nodemask_t *src1p,
>  					const nodemask_t *src2p, unsigned int nbits)
>  {
>  	return bitmap_equal(src1p->bits, src2p->bits, nbits);
> @@ -208,7 +208,7 @@ static inline int __nodes_equal(const nodemask_t *src1p,
>  
>  #define nodes_intersects(src1, src2) \
>  			__nodes_intersects(&(src1), &(src2), MAX_NUMNODES)
> -static inline int __nodes_intersects(const nodemask_t *src1p,
> +static inline bool __nodes_intersects(const nodemask_t *src1p,
>  					const nodemask_t *src2p, unsigned int nbits)
>  {
>  	return bitmap_intersects(src1p->bits, src2p->bits, nbits);
> @@ -216,20 +216,20 @@ static inline int __nodes_intersects(const nodemask_t *src1p,
>  
>  #define nodes_subset(src1, src2) \
>  			__nodes_subset(&(src1), &(src2), MAX_NUMNODES)
> -static inline int __nodes_subset(const nodemask_t *src1p,
> +static inline bool __nodes_subset(const nodemask_t *src1p,
>  					const nodemask_t *src2p, unsigned int nbits)
>  {
>  	return bitmap_subset(src1p->bits, src2p->bits, nbits);
>  }
>  
>  #define nodes_empty(src) __nodes_empty(&(src), MAX_NUMNODES)
> -static inline int __nodes_empty(const nodemask_t *srcp, unsigned int nbits)
> +static inline bool __nodes_empty(const nodemask_t *srcp, unsigned int nbits)
>  {
>  	return bitmap_empty(srcp->bits, nbits);
>  }
>  
>  #define nodes_full(nodemask) __nodes_full(&(nodemask), MAX_NUMNODES)
> -static inline int __nodes_full(const nodemask_t *srcp, unsigned int nbits)
> +static inline bool __nodes_full(const nodemask_t *srcp, unsigned int nbits)
>  {
>  	return bitmap_full(srcp->bits, nbits);
>  }
> @@ -260,15 +260,15 @@ static inline void __nodes_shift_left(nodemask_t *dstp,
>            > MAX_NUMNODES, then the silly min_ts could be dropped. */
>  
>  #define first_node(src) __first_node(&(src))
> -static inline int __first_node(const nodemask_t *srcp)
> +static inline unsigned int __first_node(const nodemask_t *srcp)
>  {
> -	return min_t(int, MAX_NUMNODES, find_first_bit(srcp->bits, MAX_NUMNODES));
> +	return min_t(unsigned int, MAX_NUMNODES, find_first_bit(srcp->bits, MAX_NUMNODES));
>  }
>  
>  #define next_node(n, src) __next_node((n), &(src))
> -static inline int __next_node(int n, const nodemask_t *srcp)
> +static inline unsigned int __next_node(int n, const nodemask_t *srcp)
>  {
> -	return min_t(int,MAX_NUMNODES,find_next_bit(srcp->bits, MAX_NUMNODES, n+1));
> +	return min_t(unsigned int, MAX_NUMNODES, find_next_bit(srcp->bits, MAX_NUMNODES, n+1));
>  }
>  
>  /*
> @@ -276,7 +276,7 @@ static inline int __next_node(int n, const nodemask_t *srcp)
>   * the first node in src if needed.  Returns MAX_NUMNODES if src is empty.
>   */
>  #define next_node_in(n, src) __next_node_in((n), &(src))
> -int __next_node_in(int node, const nodemask_t *srcp);
> +unsigned int __next_node_in(int node, const nodemask_t *srcp);
>  
>  static inline void init_nodemask_of_node(nodemask_t *mask, int node)
>  {
> @@ -296,9 +296,9 @@ static inline void init_nodemask_of_node(nodemask_t *mask, int node)
>  })
>  
>  #define first_unset_node(mask) __first_unset_node(&(mask))
> -static inline int __first_unset_node(const nodemask_t *maskp)
> +static inline unsigned int __first_unset_node(const nodemask_t *maskp)
>  {
> -	return min_t(int,MAX_NUMNODES,
> +	return min_t(unsigned int, MAX_NUMNODES,
>  			find_first_zero_bit(maskp->bits, MAX_NUMNODES));
>  }
>  
> @@ -436,11 +436,11 @@ static inline int num_node_state(enum node_states state)
>  
>  #define first_online_node	first_node(node_states[N_ONLINE])
>  #define first_memory_node	first_node(node_states[N_MEMORY])
> -static inline int next_online_node(int nid)
> +static inline unsigned int next_online_node(int nid)
>  {
>  	return next_node(nid, node_states[N_ONLINE]);
>  }
> -static inline int next_memory_node(int nid)
> +static inline unsigned int next_memory_node(int nid)
>  {
>  	return next_node(nid, node_states[N_MEMORY]);
>  }
> diff --git a/lib/nodemask.c b/lib/nodemask.c
> index 3aa454c54c0d..a334cf722189 100644
> --- a/lib/nodemask.c
> +++ b/lib/nodemask.c
> @@ -3,7 +3,7 @@
>  #include <linux/module.h>
>  #include <linux/random.h>
>  
> -int __next_node_in(int node, const nodemask_t *srcp)
> +unsigned int __next_node_in(int node, const nodemask_t *srcp)
>  {
>  	int ret = __next_node(node, srcp);

Now this should be unsigned int, right?
  
> -- 
> 2.32.0
