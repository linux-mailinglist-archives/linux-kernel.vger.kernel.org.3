Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0162D4D0EBA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 05:40:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245115AbiCHEkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 23:40:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237826AbiCHEkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 23:40:51 -0500
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED7E31EC58
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 20:39:54 -0800 (PST)
Date:   Mon, 7 Mar 2022 20:39:45 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1646714393;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Oqg4FK2E02yUZ3pAW+Qrnt3Pk7Nlrsl6nBcS0deBrTU=;
        b=mvWpkTv/kqQIyYzCAaonqDgaCKq96kChTppQ73G3QurJrXOGI/FB3nNrkGkSrUV0DFgb9A
        bTmjAISmYwUgDVuZ9KPXWnq2KH9mWy5kBH7rHjJ2/5+lbBRNsjgy1IgR+io/7uUC5o1jIS
        T810bTl+7hjhqNkkQYN0VXg43BeliPM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Waiman Long <longman@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH] mm/list_lru: Optimize memcg_drain_list_lru_node()
Message-ID: <YibeERR3Nmh7+9ZA@carbon.dhcp.thefacebook.com>
References: <20220308033009.1400464-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220308033009.1400464-1-longman@redhat.com>
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

On Mon, Mar 07, 2022 at 10:30:09PM -0500, Waiman Long wrote:
> Since commit 2c80cd57c743 ("mm/list_lru.c: fix list_lru_count_node()
> to be race free"), we are tracking the total number of lru
> entries in a list_lru_node in its nr_items field.  In the case of
> memcg_drain_list_lru_node(), there is nothing to be done if nr_items
> is 0.  We don't even need to take the nlru->lock as no new lru entry
> could be added by a racing list_lru_add() to the draining src_idx memcg
> at this point.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>

Hi Waiman!

The patch makes total sense to me, however it needs to be rebased at least
on top of "mm: list_lru: rename memcg_drain_all_list_lrus to memcg_reparent_list_lrus".

Thanks!


> ---
>  mm/list_lru.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/mm/list_lru.c b/mm/list_lru.c
> index 0cd5e89ca063..100ca453e885 100644
> --- a/mm/list_lru.c
> +++ b/mm/list_lru.c
> @@ -518,6 +518,12 @@ static void memcg_drain_list_lru_node(struct list_lru *lru, int nid,
>  	int dst_idx = dst_memcg->kmemcg_id;
>  	struct list_lru_one *src, *dst;
>  
> +	/*
> +	 * If there is no lru entry in this nlru, we can skip it immediately.
> +	 */
> +	if (!READ_ONCE(nlru->nr_items))
> +		return;
> +
>  	/*
>  	 * Since list_lru_{add,del} may be called under an IRQ-safe lock,
>  	 * we have to use IRQ-safe primitives here to avoid deadlock.
> -- 
> 2.27.0
> 
> 
