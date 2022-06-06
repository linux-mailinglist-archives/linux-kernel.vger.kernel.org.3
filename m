Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B96A53E639
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236160AbiFFMEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 08:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235894AbiFFMEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 08:04:04 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C3E513E16;
        Mon,  6 Jun 2022 05:04:02 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id C0AE821A5C;
        Mon,  6 Jun 2022 12:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1654517040; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CZfbvYWKjKsB+23H/W7org8aRzTVXyVE8kdib5DA8+A=;
        b=jcF8iBoG9VE/bG+eSReaeL4gfHyFGDthvx6RiW/gjsDWzhaqrw7aX+dln8LJCEc0kxKXNQ
        tyrPd/7VLmrP8u6mmCPTTALWmexNRou2t6Y6LcmvJS88QN5wnv2mgh4iJ/LDFNbMpcSesH
        50BPh3SjLuQOz4bNH+m3HkCt5KOCqew=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 3C6362C141;
        Mon,  6 Jun 2022 12:04:00 +0000 (UTC)
Date:   Mon, 6 Jun 2022 14:03:56 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     hannes@cmpxchg.org, roman.gushchin@linux.dev, shakeelb@google.com,
        songmuchun@bytedance.com, akpm@linux-foundation.org,
        corbet@lwn.net, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v2] mm: memcontrol: add {pgscan,pgsteal}_{kswapd,direct}
 items in memory.stat of cgroup v2
Message-ID: <Yp3tLNi0wybMw7La@dhcp22.suse.cz>
References: <20220604082209.55174-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220604082209.55174-1-zhengqi.arch@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 04-06-22 16:22:09, Qi Zheng wrote:
> There are already statistics of {pgscan,pgsteal}_kswapd and
> {pgscan,pgsteal}_direct of memcg event here, but now only the
> sum of the two is displayed in memory.stat of cgroup v2.
> 
> In order to obtain more accurate information during monitoring
> and debugging, and to align with the display in /proc/vmstat,
> it better to display {pgscan,pgsteal}_kswapd and
> {pgscan,pgsteal}_direct separately.
> 
> Also, for forward compatibility, we still display pgscan and
> pgsteal items so that it won't break existing applications.

I do not remember why we have chosen to report cumulative stats rather
than the direct and kswapd parts. Looking back when Roman has introduced
those (http://lkml.kernel.org/r/1494530183-30808-1-git-send-email-guro@fb.com)
I do not see any discussion around that. So it was likely just not
a priority.

I have just one question. Say we even decide to have a per memcg kswapd
in some form, would we report that into the same counter?

> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
> Acked-by: Muchun Song <songmuchun@bytedance.com>

In any case
Acked-by: Michal Hocko <mhocko@suse.com>

One nit below
[...]
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 0d3fe0a0c75a..fd78c4d6bbc7 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1460,6 +1460,28 @@ static inline unsigned long memcg_page_state_output(struct mem_cgroup *memcg,
>  	return memcg_page_state(memcg, item) * memcg_page_state_unit(item);
>  }
>  

I would just add the following for clarity

/* Subset of vm_event_item to report for memcg event stats */
> +static const unsigned int memcg_vm_event_stat[] = {
> +	PGSCAN_KSWAPD,
> +	PGSCAN_DIRECT,
> +	PGSTEAL_KSWAPD,
> +	PGSTEAL_DIRECT,
> +	PGFAULT,
> +	PGMAJFAULT,
> +	PGREFILL,
> +	PGACTIVATE,
> +	PGDEACTIVATE,
> +	PGLAZYFREE,
> +	PGLAZYFREED,
> +#if defined(CONFIG_MEMCG_KMEM) && defined(CONFIG_ZSWAP)
> +	ZSWPIN,
> +	ZSWPOUT,
> +#endif
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +	THP_FAULT_ALLOC,
> +	THP_COLLAPSE_ALLOC,
> +#endif
> +};

-- 
Michal Hocko
SUSE Labs
