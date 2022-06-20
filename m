Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F172F551782
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 13:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237034AbiFTLiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 07:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235801AbiFTLh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 07:37:59 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F66632B
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 04:37:58 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 900E11F8CF;
        Mon, 20 Jun 2022 11:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655725077; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gk50856yvyikasm7bS0OG56qAWkZTO8FSBBzDtB/dnw=;
        b=bS8dARtczrr/thaYtGaFWbzUCIuUilnu3VvA0Hpy5VRddQLxTtV/UzyYVHby5b5eVALWt2
        OUHlUARH37jKTqa5bZ4JN/B+mmeX94bQ0vGWumv9rcjJWwFokGvQ43MwWvWlUCWu2GjuQJ
        UkYqvYl/ibJH9qefIcEv5R3tCWEj0os=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 1705C2C16B;
        Mon, 20 Jun 2022 11:37:57 +0000 (UTC)
Date:   Mon, 20 Jun 2022 13:37:56 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, pmladek@suse.com,
        rostedt@goodmis.org, enozhatsky@chromium.org,
        linux@rasmusvillemoes.dk, willy@infradead.org
Subject: Re: [PATCH v4 24/34] mm/memcontrol.c: Convert to printbuf
Message-ID: <YrBcFLpvvfJOnhGO@dhcp22.suse.cz>
References: <20220620004233.3805-1-kent.overstreet@gmail.com>
 <20220620004233.3805-25-kent.overstreet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220620004233.3805-25-kent.overstreet@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 19-06-22 20:42:23, Kent Overstreet wrote:
> This converts memory_stat_format() from seq_buf to printbuf. Printbuf is
> simalar to seq_buf except that it heap allocates the string buffer:
> here, we were already heap allocating the buffer with kmalloc() so the
> conversion is trivial.
> 
> Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>

I have asked for a justification two times already not hearing anything.
Please drop this patch. I do not see any actual advantage of the
conversion. The primary downside of the existing code is that an
internal buffer is exposed to the caller which is error prone and ugly.
The conversion doesn't really address that part.

Moreover there is an inconsistency between failrure case where the
printbuf is destroyed by a docummented way (printbuf_exit) and when the
caller frees the buffer directly. If printbuf_exit evers need to do more
than just kfree (e.g. kvfree) then this is a subtle bug hard to find.

> ---
>  mm/memcontrol.c | 68 ++++++++++++++++++++++++-------------------------
>  1 file changed, 33 insertions(+), 35 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 598fece89e..57861dc9fe 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -62,7 +62,7 @@
>  #include <linux/file.h>
>  #include <linux/resume_user_mode.h>
>  #include <linux/psi.h>
> -#include <linux/seq_buf.h>
> +#include <linux/printbuf.h>
>  #include "internal.h"
>  #include <net/sock.h>
>  #include <net/ip.h>
> @@ -1461,13 +1461,9 @@ static inline unsigned long memcg_page_state_output(struct mem_cgroup *memcg,
>  
>  static char *memory_stat_format(struct mem_cgroup *memcg)
>  {
> -	struct seq_buf s;
> +	struct printbuf buf = PRINTBUF;
>  	int i;
>  
> -	seq_buf_init(&s, kmalloc(PAGE_SIZE, GFP_KERNEL), PAGE_SIZE);
> -	if (!s.buffer)
> -		return NULL;
> -
>  	/*
>  	 * Provide statistics on the state of the memory subsystem as
>  	 * well as cumulative event counters that show past behavior.
> @@ -1484,49 +1480,51 @@ static char *memory_stat_format(struct mem_cgroup *memcg)
>  		u64 size;
>  
>  		size = memcg_page_state_output(memcg, memory_stats[i].idx);
> -		seq_buf_printf(&s, "%s %llu\n", memory_stats[i].name, size);
> +		prt_printf(&buf, "%s %llu\n", memory_stats[i].name, size);
>  
>  		if (unlikely(memory_stats[i].idx == NR_SLAB_UNRECLAIMABLE_B)) {
>  			size += memcg_page_state_output(memcg,
>  							NR_SLAB_RECLAIMABLE_B);
> -			seq_buf_printf(&s, "slab %llu\n", size);
> +			prt_printf(&buf, "slab %llu\n", size);
>  		}
>  	}
>  
>  	/* Accumulated memory events */
>  
> -	seq_buf_printf(&s, "%s %lu\n", vm_event_name(PGFAULT),
> -		       memcg_events(memcg, PGFAULT));
> -	seq_buf_printf(&s, "%s %lu\n", vm_event_name(PGMAJFAULT),
> -		       memcg_events(memcg, PGMAJFAULT));
> -	seq_buf_printf(&s, "%s %lu\n",  vm_event_name(PGREFILL),
> -		       memcg_events(memcg, PGREFILL));
> -	seq_buf_printf(&s, "pgscan %lu\n",
> -		       memcg_events(memcg, PGSCAN_KSWAPD) +
> -		       memcg_events(memcg, PGSCAN_DIRECT));
> -	seq_buf_printf(&s, "pgsteal %lu\n",
> -		       memcg_events(memcg, PGSTEAL_KSWAPD) +
> -		       memcg_events(memcg, PGSTEAL_DIRECT));
> -	seq_buf_printf(&s, "%s %lu\n", vm_event_name(PGACTIVATE),
> -		       memcg_events(memcg, PGACTIVATE));
> -	seq_buf_printf(&s, "%s %lu\n", vm_event_name(PGDEACTIVATE),
> -		       memcg_events(memcg, PGDEACTIVATE));
> -	seq_buf_printf(&s, "%s %lu\n", vm_event_name(PGLAZYFREE),
> -		       memcg_events(memcg, PGLAZYFREE));
> -	seq_buf_printf(&s, "%s %lu\n", vm_event_name(PGLAZYFREED),
> -		       memcg_events(memcg, PGLAZYFREED));
> +	prt_printf(&buf, "%s %lu\n", vm_event_name(PGFAULT),
> +	       memcg_events(memcg, PGFAULT));
> +	prt_printf(&buf, "%s %lu\n", vm_event_name(PGMAJFAULT),
> +	       memcg_events(memcg, PGMAJFAULT));
> +	prt_printf(&buf, "%s %lu\n",  vm_event_name(PGREFILL),
> +	       memcg_events(memcg, PGREFILL));
> +	prt_printf(&buf, "pgscan %lu\n",
> +	       memcg_events(memcg, PGSCAN_KSWAPD) +
> +	       memcg_events(memcg, PGSCAN_DIRECT));
> +	prt_printf(&buf, "pgsteal %lu\n",
> +	       memcg_events(memcg, PGSTEAL_KSWAPD) +
> +	       memcg_events(memcg, PGSTEAL_DIRECT));
> +	prt_printf(&buf, "%s %lu\n", vm_event_name(PGACTIVATE),
> +	       memcg_events(memcg, PGACTIVATE));
> +	prt_printf(&buf, "%s %lu\n", vm_event_name(PGDEACTIVATE),
> +	       memcg_events(memcg, PGDEACTIVATE));
> +	prt_printf(&buf, "%s %lu\n", vm_event_name(PGLAZYFREE),
> +	       memcg_events(memcg, PGLAZYFREE));
> +	prt_printf(&buf, "%s %lu\n", vm_event_name(PGLAZYFREED),
> +	       memcg_events(memcg, PGLAZYFREED));
>  
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> -	seq_buf_printf(&s, "%s %lu\n", vm_event_name(THP_FAULT_ALLOC),
> -		       memcg_events(memcg, THP_FAULT_ALLOC));
> -	seq_buf_printf(&s, "%s %lu\n", vm_event_name(THP_COLLAPSE_ALLOC),
> -		       memcg_events(memcg, THP_COLLAPSE_ALLOC));
> +	prt_printf(&buf, "%s %lu\n", vm_event_name(THP_FAULT_ALLOC),
> +	       memcg_events(memcg, THP_FAULT_ALLOC));
> +	prt_printf(&buf, "%s %lu\n", vm_event_name(THP_COLLAPSE_ALLOC),
> +	       memcg_events(memcg, THP_COLLAPSE_ALLOC));
>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>  
> -	/* The above should easily fit into one page */
> -	WARN_ON_ONCE(seq_buf_has_overflowed(&s));
> +	if (buf.allocation_failure) {
> +		printbuf_exit(&buf);
> +		return NULL;
> +	}
>  
> -	return s.buffer;
> +	return buf.buf;
>  }
>  
>  #define K(x) ((x) << (PAGE_SHIFT-10))
> -- 
> 2.36.1

-- 
Michal Hocko
SUSE Labs
