Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34D3A4D26A8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 05:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbiCICPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 21:15:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbiCICOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 21:14:50 -0500
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D506F13D3A
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 18:13:48 -0800 (PST)
Date:   Tue, 8 Mar 2022 18:13:41 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1646792027;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AZyBLdCR0kgX9arBffEGB7+wNon6htqyedlw61KqXnI=;
        b=wzx2F4Am1rKGCYm836F+pUCYe5wjescsJQG4khVSUmpuIrWbdj1TQm+EyIJVFm3xrfzu42
        rd2jrtdzAn/Hb20VuzGa2LA4lmU7db5g20d8GB1Eaarq5vEJOj0h1JlFnzCv4rN5unukZD
        3bl0yqWQm+/oyPOJrW4gaKcYnD0YST4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Waiman Long <longman@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH-mm v2] mm/list_lru: Optimize
 memcg_reparent_list_lru_node()
Message-ID: <YigNVbz/h8wzNjs/@carbon.dhcp.thefacebook.com>
References: <20220309011824.1454619-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220309011824.1454619-1-longman@redhat.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 08, 2022 at 08:18:24PM -0500, Waiman Long wrote:
> Since commit 2c80cd57c743 ("mm/list_lru.c: fix list_lru_count_node()
> to be race free"), we are tracking the total number of lru
> entries in a list_lru_node in its nr_items field.  In the case of
> memcg_reparent_list_lru_node(), there is nothing to be done if nr_items
> is 0.  We don't even need to take the nlru->lock as no new lru entry
> could be added by a racing list_lru_add() to the draining src_idx memcg
> at this point.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  mm/list_lru.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/mm/list_lru.c b/mm/list_lru.c
> index ba76428ceece..c669d87001a6 100644
> --- a/mm/list_lru.c
> +++ b/mm/list_lru.c
> @@ -394,6 +394,12 @@ static void memcg_reparent_list_lru_node(struct list_lru *lru, int nid,
>  	int dst_idx = dst_memcg->kmemcg_id;
>  	struct list_lru_one *src, *dst;
>  
> +	/*
> +	 * If there is no lru entry in this nlru, we can skip it immediately.
> +	 */
> +	if (!READ_ONCE(nlru->nr_items))
> +		return;

This is a per-node counter, not a per-memcg, right?
If so, do we optimize for the case when all lru items belong to one node and
others are empty?
