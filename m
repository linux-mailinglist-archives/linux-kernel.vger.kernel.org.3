Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D43014EE0F3
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 20:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236919AbiCaSrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 14:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236815AbiCaSrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 14:47:35 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD9A2335F8;
        Thu, 31 Mar 2022 11:45:47 -0700 (PDT)
Date:   Thu, 31 Mar 2022 11:45:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1648752345;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lec1hd5ookT38BpjO46aUl2BmuDZn/r1njoU+y+QByQ=;
        b=wpJ/2gA3GgxjfYWOybRPV0FGQI5lh0L0UaFtEGqaVtWHPvRvc+NqrFVsZl/2fSspA2yoZM
        rZagewvC2zuXGJZn/pgpJ+6sS++qhA89ZDzOhJ3tn2ZJ1+gRBs5JfpDp8SkntqMipU12MF
        JAZOzsQ1YfKZr30dbZjmcvdc2AvhWQM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Vasily Averin <vasily.averin@linux.dev>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>, kernel@openvz.org,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        netfilter-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH nft] nft: memcg accounting for dynamically allocated
 objects
Message-ID: <YkX200lPSHpw8rt8@carbon.dhcp.thefacebook.com>
References: <bf4b8fe3-6dd6-4f3a-12f4-1b5bf2e45783@linux.dev>
 <e730480d-9396-6486-ab98-67ecb683e819@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e730480d-9396-6486-ab98-67ecb683e819@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 11:40:23AM +0300, Vasily Averin wrote:
> nft_*.c files whose NFT_EXPR_STATEFUL flag is set on need to
> use __GFP_ACCOUNT flag for objects that are dynamically
> allocated from the packet path.
> 
> Such objects are allocated inside .init() or .clone() callbacks
> of struct nft_expr_ops executed in task context while processing
> netlink messages.
> 
> In addition, this patch adds accounting to nft_set_elem_expr_clone()
> used for the same purposes.

The patch looks good to me. The only concern I have is a potential
performance regression. Are any of these allocations happening on really
hot paths? From a very brief look it seems like the answer is no,
but I'm not well familiar with the netfilter code. Would be nice to
have a confirmation from somebody working on the netfilter.
We are roughly talking about x2 slower memory allocations, which
is usually not a problem at all, given that allocations are still
very cheap.

Please, feel free to add my
Acked-by: Roman Gushchin <roman.gushchin@linux.dev>

Thanks!

> 
> Signed-off-by: Vasily Averin <vvs@openvz.org>
> ---
>  net/netfilter/nf_tables_api.c | 2 +-
>  net/netfilter/nft_connlimit.c | 4 ++--
>  net/netfilter/nft_counter.c   | 4 ++--
>  net/netfilter/nft_last.c      | 4 ++--
>  net/netfilter/nft_limit.c     | 4 ++--
>  net/netfilter/nft_quota.c     | 4 ++--
>  6 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
> index 04be94236a34..e01241151ef7 100644
> --- a/net/netfilter/nf_tables_api.c
> +++ b/net/netfilter/nf_tables_api.c
> @@ -5447,7 +5447,7 @@ int nft_set_elem_expr_clone(const struct nft_ctx *ctx, struct nft_set *set,
>  	int err, i, k;
>  
>  	for (i = 0; i < set->num_exprs; i++) {
> -		expr = kzalloc(set->exprs[i]->ops->size, GFP_KERNEL);
> +		expr = kzalloc(set->exprs[i]->ops->size, GFP_KERNEL_ACCOUNT);
>  		if (!expr)
>  			goto err_expr;
>  
> diff --git a/net/netfilter/nft_connlimit.c b/net/netfilter/nft_connlimit.c
> index 3362417ebfdb..9c2146aac59e 100644
> --- a/net/netfilter/nft_connlimit.c
> +++ b/net/netfilter/nft_connlimit.c
> @@ -77,7 +77,7 @@ static int nft_connlimit_do_init(const struct nft_ctx *ctx,
>  			invert = true;
>  	}
>  
> -	priv->list = kmalloc(sizeof(*priv->list), GFP_KERNEL);
> +	priv->list = kmalloc(sizeof(*priv->list), GFP_KERNEL_ACCOUNT);
>  	if (!priv->list)
>  		return -ENOMEM;
>  
> @@ -214,7 +214,7 @@ static int nft_connlimit_clone(struct nft_expr *dst, const struct nft_expr *src)
>  	struct nft_connlimit *priv_dst = nft_expr_priv(dst);
>  	struct nft_connlimit *priv_src = nft_expr_priv(src);
>  
> -	priv_dst->list = kmalloc(sizeof(*priv_dst->list), GFP_ATOMIC);
> +	priv_dst->list = kmalloc(sizeof(*priv_dst->list), GFP_ATOMIC | __GFP_ACCOUNT);
>  	if (!priv_dst->list)
>  		return -ENOMEM;
>  
> diff --git a/net/netfilter/nft_counter.c b/net/netfilter/nft_counter.c
> index f179e8c3b0ca..040a697d96b3 100644
> --- a/net/netfilter/nft_counter.c
> +++ b/net/netfilter/nft_counter.c
> @@ -62,7 +62,7 @@ static int nft_counter_do_init(const struct nlattr * const tb[],
>  	struct nft_counter __percpu *cpu_stats;
>  	struct nft_counter *this_cpu;
>  
> -	cpu_stats = alloc_percpu(struct nft_counter);
> +	cpu_stats = alloc_percpu_gfp(struct nft_counter, GFP_KERNEL_ACCOUNT);
>  	if (cpu_stats == NULL)
>  		return -ENOMEM;
>  
> @@ -235,7 +235,7 @@ static int nft_counter_clone(struct nft_expr *dst, const struct nft_expr *src)
>  
>  	nft_counter_fetch(priv, &total);
>  
> -	cpu_stats = alloc_percpu_gfp(struct nft_counter, GFP_ATOMIC);
> +	cpu_stats = alloc_percpu_gfp(struct nft_counter, GFP_ATOMIC | __GFP_ACCOUNT);
>  	if (cpu_stats == NULL)
>  		return -ENOMEM;
>  
> diff --git a/net/netfilter/nft_last.c b/net/netfilter/nft_last.c
> index 4f745a409d34..4cf4f6349855 100644
> --- a/net/netfilter/nft_last.c
> +++ b/net/netfilter/nft_last.c
> @@ -30,7 +30,7 @@ static int nft_last_init(const struct nft_ctx *ctx, const struct nft_expr *expr,
>  	u64 last_jiffies;
>  	int err;
>  
> -	last = kzalloc(sizeof(*last), GFP_KERNEL);
> +	last = kzalloc(sizeof(*last), GFP_KERNEL_ACCOUNT);
>  	if (!last)
>  		return -ENOMEM;
>  
> @@ -105,7 +105,7 @@ static int nft_last_clone(struct nft_expr *dst, const struct nft_expr *src)
>  {
>  	struct nft_last_priv *priv_dst = nft_expr_priv(dst);
>  
> -	priv_dst->last = kzalloc(sizeof(*priv_dst->last), GFP_ATOMIC);
> +	priv_dst->last = kzalloc(sizeof(*priv_dst->last), GFP_ATOMIC | __GFP_ACCOUNT);
>  	if (!priv_dst->last)
>  		return -ENOMEM;
>  
> diff --git a/net/netfilter/nft_limit.c b/net/netfilter/nft_limit.c
> index a726b623963d..d7779d5f3cbb 100644
> --- a/net/netfilter/nft_limit.c
> +++ b/net/netfilter/nft_limit.c
> @@ -90,7 +90,7 @@ static int nft_limit_init(struct nft_limit_priv *priv,
>  				 priv->rate);
>  	}
>  
> -	priv->limit = kmalloc(sizeof(*priv->limit), GFP_KERNEL);
> +	priv->limit = kmalloc(sizeof(*priv->limit), GFP_KERNEL_ACCOUNT);
>  	if (!priv->limit)
>  		return -ENOMEM;
>  
> @@ -144,7 +144,7 @@ static int nft_limit_clone(struct nft_limit_priv *priv_dst,
>  	priv_dst->burst = priv_src->burst;
>  	priv_dst->invert = priv_src->invert;
>  
> -	priv_dst->limit = kmalloc(sizeof(*priv_dst->limit), GFP_ATOMIC);
> +	priv_dst->limit = kmalloc(sizeof(*priv_dst->limit), GFP_ATOMIC | __GFP_ACCOUNT);
>  	if (!priv_dst->limit)
>  		return -ENOMEM;
>  
> diff --git a/net/netfilter/nft_quota.c b/net/netfilter/nft_quota.c
> index f394a0b562f6..2def4d92a170 100644
> --- a/net/netfilter/nft_quota.c
> +++ b/net/netfilter/nft_quota.c
> @@ -90,7 +90,7 @@ static int nft_quota_do_init(const struct nlattr * const tb[],
>  			return -EOPNOTSUPP;
>  	}
>  
> -	priv->consumed = kmalloc(sizeof(*priv->consumed), GFP_KERNEL);
> +	priv->consumed = kmalloc(sizeof(*priv->consumed), GFP_KERNEL_ACCOUNT);
>  	if (!priv->consumed)
>  		return -ENOMEM;
>  
> @@ -236,7 +236,7 @@ static int nft_quota_clone(struct nft_expr *dst, const struct nft_expr *src)
>  {
>  	struct nft_quota *priv_dst = nft_expr_priv(dst);
>  
> -	priv_dst->consumed = kmalloc(sizeof(*priv_dst->consumed), GFP_ATOMIC);
> +	priv_dst->consumed = kmalloc(sizeof(*priv_dst->consumed), GFP_ATOMIC | __GFP_ACCOUNT);
>  	if (!priv_dst->consumed)
>  		return -ENOMEM;
>  
> -- 
> 2.31.1
> 
