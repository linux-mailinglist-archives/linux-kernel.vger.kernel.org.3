Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6054EEC66
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 13:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345527AbiDALaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 07:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238883AbiDALa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 07:30:29 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5689619952E
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 04:28:38 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id EC8CB21A91;
        Fri,  1 Apr 2022 11:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1648812516; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Pjdj3sPTtnawqXk//QrVvb2n7nto8jXDZrUs+omvxH0=;
        b=jLPf1kgL18pI5zOjAz0lQ7/yt3xS7BIovLxpUHPbj9bOLzapuzskLJVAZ/TIwvbqI/8DxU
        iQFBQPMpAzkK9O9pQxl5hclRU2sw626ZaFslvtvzqKP7w9r/46PoukA7BcRpIKKtMR6X6n
        NCqyIOOvvl7USFHGCQtF/VK0tSNJEng=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 2ADC0A3B83;
        Fri,  1 Apr 2022 11:28:36 +0000 (UTC)
Date:   Fri, 1 Apr 2022 13:28:32 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Waiman Long <longman@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH v2] mm/list_lru: Fix possible race in
 memcg_reparent_list_lru_node()
Message-ID: <Ykbh4Ljt7GJXak/S@dhcp22.suse.cz>
References: <20220330191440.1cc1b2de2b849d1ba93d2ba7@linux-foundation.org>
 <89B53D3A-FCC5-4107-8D49-81D5B9AE5172@linux.dev>
 <20220331063956.5uqnab64cqnmcwyr@google.com>
 <YkVcbElWjomA7ofF@dhcp22.suse.cz>
 <20220331181126.815cfe2b05b4281d32b7bf49@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220331181126.815cfe2b05b4281d32b7bf49@linux-foundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 31-03-22 18:11:26, Andrew Morton wrote:
[...]
> Yup.  I did this:
> 
> From: Andrew Morton <akpm@linux-foundation.org>
> Subject: mm/list_lru.c: revert "mm/list_lru: optimize memcg_reparent_list_lru_node()"
> 
> 405cc51fc1049c73 ("mm/list_lru: optimize memcg_reparent_list_lru_node()")
> has subtle races which are proving ugly to fix.  Revert the original
> optimization.  If quantitative testing indicates that we have a
> significant problem here then other implementations can be looked at.
> 
> Fixes: 405cc51fc1049c73 ("mm/list_lru: optimize memcg_reparent_list_lru_node()")
> Cc: Waiman Long <longman@redhat.com>
> Cc: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: Muchun Song <songmuchun@bytedance.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Shakeel Butt <shakeelb@google.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

> ---
> 
>  mm/list_lru.c |    6 ------
>  1 file changed, 6 deletions(-)
> 
> --- a/mm/list_lru.c~revert-1
> +++ a/mm/list_lru.c
> @@ -395,12 +395,6 @@ static void memcg_reparent_list_lru_node
>  	struct list_lru_one *src, *dst;
>  
>  	/*
> -	 * If there is no lru entry in this nlru, we can skip it immediately.
> -	 */
> -	if (!READ_ONCE(nlru->nr_items))
> -		return;
> -
> -	/*
>  	 * Since list_lru_{add,del} may be called under an IRQ-safe lock,
>  	 * we have to use IRQ-safe primitives here to avoid deadlock.
>  	 */
> _

-- 
Michal Hocko
SUSE Labs
