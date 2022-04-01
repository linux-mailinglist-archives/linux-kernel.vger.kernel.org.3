Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A25104EECCA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 14:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345725AbiDAMFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 08:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345187AbiDAMFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 08:05:36 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ADAB5F68;
        Fri,  1 Apr 2022 05:03:45 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1naG0E-0007M7-Ag; Fri, 01 Apr 2022 14:03:42 +0200
Date:   Fri, 1 Apr 2022 14:03:42 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Vasily Averin <vasily.averin@linux.dev>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>, kernel@openvz.org,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        netfilter-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Roman Gushchin <roman.gushchin@linux.dev>
Subject: Re: [PATCH nft] nft: memcg accounting for dynamically allocated
 objects
Message-ID: <20220401120342.GC9545@breakpoint.cc>
References: <bf4b8fe3-6dd6-4f3a-12f4-1b5bf2e45783@linux.dev>
 <e730480d-9396-6486-ab98-67ecb683e819@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e730480d-9396-6486-ab98-67ecb683e819@linux.dev>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vasily Averin <vasily.averin@linux.dev> wrote:
> nft_*.c files whose NFT_EXPR_STATEFUL flag is set on need to
> use __GFP_ACCOUNT flag for objects that are dynamically
> allocated from the packet path.
> 
> Such objects are allocated inside .init() or .clone() callbacks
> of struct nft_expr_ops executed in task context while processing
> netlink messages.

They can also be called from packet path.

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

This is ok.

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

Same.

> @@ -214,7 +214,7 @@ static int nft_connlimit_clone(struct nft_expr *dst, const struct nft_expr *src)
>  	struct nft_connlimit *priv_dst = nft_expr_priv(dst);
>  	struct nft_connlimit *priv_src = nft_expr_priv(src);
>  
> -	priv_dst->list = kmalloc(sizeof(*priv_dst->list), GFP_ATOMIC);
> +	priv_dst->list = kmalloc(sizeof(*priv_dst->list), GFP_ATOMIC | __GFP_ACCOUNT);

This can be called from packet path, via nft_dynset.c.

nft_do_chain -> nft_dynset_eval -> nft_dynset_new ->
nft_dynset_expr_setup -> nft_expr_clone -> src->ops->clone()

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

This is ok.

> @@ -235,7 +235,7 @@ static int nft_counter_clone(struct nft_expr *dst, const struct nft_expr *src)
>  
>  	nft_counter_fetch(priv, &total);
>  
> -	cpu_stats = alloc_percpu_gfp(struct nft_counter, GFP_ATOMIC);
> +	cpu_stats = alloc_percpu_gfp(struct nft_counter, GFP_ATOMIC | __GFP_ACCOUNT);
>  	if (cpu_stats == NULL)
>  		return -ENOMEM;

Same problem as connlimit, can be called from packet path.
Basically all GFP_ATOMIC are suspicious.

Not sure how to resolve this, similar mechanics in iptables world (e.g.
connlimit or SET target) don't use memcg accounting.

Perhaps for now resend with only the GFP_KERNEL parts converted?
Those are safe.

Insertion from packet path is limited by set->size (element count) only
at this time.
