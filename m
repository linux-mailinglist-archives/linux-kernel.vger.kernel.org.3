Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C51749F953
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 13:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237792AbiA1MXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 07:23:36 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:33492 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiA1MXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 07:23:35 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A06F6212B7;
        Fri, 28 Jan 2022 12:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1643372614; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=71M7m26qjEQDHZgi5jO+0z+MJXrkQnj7Uc4OCh8cPbY=;
        b=jKX1hcm5THaAqw3fk9koUnFPbf1DYWasC685eJ5k5OmZpCbFLvlcaLCbf83tGypVN+PQPf
        1lBWi/fxa9b4MBjz9Zsj4lJo8i1+Epa6tRyCCCBdoO4O13ti4AF2orK4JCDkQP7FOJAFX+
        LOz7q195Ybp6GNUnke98QQCR3WBY0wU=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 70006A3B83;
        Fri, 28 Jan 2022 12:23:34 +0000 (UTC)
Date:   Fri, 28 Jan 2022 13:23:33 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Vasily Averin <vvs@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memcg: replace in_interrupt() with !in_task()
Message-ID: <YfPgRU7Swo0VczUd@dhcp22.suse.cz>
References: <20220127162636.3461256-1-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127162636.3461256-1-shakeelb@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 27-01-22 08:26:36, Shakeel Butt wrote:
> Replace the deprecated in_interrupt() with !in_task() because
> in_interrupt() returns true for BH disabled even if the call happens in
> the task context. in_task() is the right interface to differentiate
> task context from NMI, hard IRQ and softirq contexts.

Makes sense. I do not think this will have any visible effect. Except
for removing a deprecated call, right?

> Signed-off-by: Shakeel Butt <shakeelb@google.com>

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

> ---
>  mm/memcontrol.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index d067366002e6..215dfe325e9d 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2688,7 +2688,7 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
>  			READ_ONCE(memcg->swap.high);
>  
>  		/* Don't bother a random interrupted task */
> -		if (in_interrupt()) {
> +		if (!in_task()) {
>  			if (mem_high) {
>  				schedule_work(&memcg->high_work);
>  				break;
> @@ -6968,7 +6968,7 @@ void mem_cgroup_sk_alloc(struct sock *sk)
>  		return;
>  
>  	/* Do not associate the sock with unrelated interrupted task's memcg. */
> -	if (in_interrupt())
> +	if (!in_task())
>  		return;
>  
>  	rcu_read_lock();
> -- 
> 2.35.0.rc0.227.g00780c9af4-goog

-- 
Michal Hocko
SUSE Labs
