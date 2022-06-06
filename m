Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D459953ED11
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbiFFRhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 13:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiFFRfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 13:35:10 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F501B1F49
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 10:35:06 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id h18so10651940qvj.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 10:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ONtgrpUVfgaDiq1zXnbAn6nVrL5RzEEKdEEOpv/ts/w=;
        b=RPfBncwo3xRZLwPCaB9JoOSmhUbJjQWh9/5exDp/xTLykz+3iQC2crnSEzJTjWyngW
         IO+Uunz+rAz2cBH+5mqRSxNUA0mo50556+qYwskvrDKYj/86Oh7U1tHDmYc0kL4XFimb
         28/h/wWggvQUJvn+QDFC8qSqgypcW8OXO5p8MCzEzNPUvxnnLpYDMlj5rkMrpLW2GJpF
         XTzyw1Tx3zPSOsULoI+qZ6DwI6rqRiepjm29aGw7avud7eFNPacK0xOxx8hAb4XLaw+Y
         7B8tg2GZowlAXWZzUhqt/D3u3E+cr/E7Y6CMu+HqfRt7RFUgXIsF9idwf8un6kTDs60i
         IAKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ONtgrpUVfgaDiq1zXnbAn6nVrL5RzEEKdEEOpv/ts/w=;
        b=EriWVPynR372Z8XlEAYtqSMWeYVp+vqEMt0H+BKHvqoi5LdZ7V6uC0tOY9tQVWWmmO
         XMXNlu1ZJknMpxEf0t2fBgJ2ut5O0Lbm1kr/f/9kVtPaNpUpwDw+3cZ2gxzSsHnaiwIr
         /rNJc3xxpwTkRojfs3i4LJ1BrrkT+FgOySgGIXYm+Nrzr6GGVvm59/KXaEYne4hqAHsi
         +4dtRscWF9MEY3YqdVR9F48dPkQKfLoTENp7P/X4yuEgXLxIIy8sCaQgRAjkyQeaPLyh
         hAn//EbINts3/lq9gaHUN47neqOenFuBxFmy/kRtDbjxOmcMHVkKpmLWfg/QgoiEkLwp
         6OWw==
X-Gm-Message-State: AOAM533nE1KEck0w5OUbcWPDuXcgiYoxZNfCM1R0Z7vMZtYhJR5/AwYf
        GvWBZ7V4f7fCFkzGa7FK4aWjiw==
X-Google-Smtp-Source: ABdhPJwHrpLRvcb2wRgm9WoukfE/nzu+lokhq+WkPqXduzdXyYjlDQJX7ghcMowYgUkJL1HDosduPQ==
X-Received: by 2002:a05:6214:1d2f:b0:464:46fe:ca68 with SMTP id f15-20020a0562141d2f00b0046446feca68mr34363805qvd.4.1654536905279;
        Mon, 06 Jun 2022 10:35:05 -0700 (PDT)
Received: from localhost (cpe-67-251-217-1.hvc.res.rr.com. [67.251.217.1])
        by smtp.gmail.com with ESMTPSA id g4-20020a37b604000000b006a5fb8219bbsm11805833qkf.44.2022.06.06.10.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 10:35:04 -0700 (PDT)
Date:   Mon, 6 Jun 2022 13:34:59 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     roman.gushchin@linux.dev, shakeelb@google.com,
        songmuchun@bytedance.com, mhocko@kernel.org,
        akpm@linux-foundation.org, corbet@lwn.net, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v3] mm: memcontrol: add {pgscan,pgsteal}_{kswapd,direct}
 items in memory.stat of cgroup v2
Message-ID: <Yp46w4op9JeX9+g9@cmpxchg.org>
References: <20220606154028.55030-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220606154028.55030-1-zhengqi.arch@bytedance.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 06, 2022 at 11:40:28PM +0800, Qi Zheng wrote:
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
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
> Acked-by: Muchun Song <songmuchun@bytedance.com>
> Acked-by: Shakeel Butt <shakeelb@google.com>
> Acked-by: Michal Hocko <mhocko@suse.com>

No objection to keeping pgscan and pgsteal, but can you please fix the
doc to present the items in the same order as memory.stat has them?

> @@ -1445,9 +1445,21 @@ PAGE_SIZE multiple when read back.
>  	  pgscan (npn)
>  		Amount of scanned pages (in an inactive LRU list)
>  
> +	  pgscan_kswapd (npn)
> +		Amount of scanned pages by kswapd (in an inactive LRU list)
> +
> +	  pgscan_direct (npn)
> +		Amount of scanned pages directly  (in an inactive LRU list)
> +
>  	  pgsteal (npn)
>  		Amount of reclaimed pages
>  
> +	  pgsteal_kswapd (npn)
> +		Amount of reclaimed pages by kswapd
> +
> +	  pgsteal_direct (npn)
> +		Amount of reclaimed pages directly
> +
>  	  pgactivate (npn)
>  		Amount of pages moved to the active LRU list

vs:

> @@ -1495,41 +1518,17 @@ static char *memory_stat_format(struct mem_cgroup *memcg)
>  	}
>  
>  	/* Accumulated memory events */
> -
> -	seq_buf_printf(&s, "%s %lu\n", vm_event_name(PGFAULT),
> -		       memcg_events(memcg, PGFAULT));
> -	seq_buf_printf(&s, "%s %lu\n", vm_event_name(PGMAJFAULT),
> -		       memcg_events(memcg, PGMAJFAULT));
> -	seq_buf_printf(&s, "%s %lu\n",  vm_event_name(PGREFILL),
> -		       memcg_events(memcg, PGREFILL));
>  	seq_buf_printf(&s, "pgscan %lu\n",
>  		       memcg_events(memcg, PGSCAN_KSWAPD) +
>  		       memcg_events(memcg, PGSCAN_DIRECT));
>  	seq_buf_printf(&s, "pgsteal %lu\n",
>  		       memcg_events(memcg, PGSTEAL_KSWAPD) +
>  		       memcg_events(memcg, PGSTEAL_DIRECT));
> -	seq_buf_printf(&s, "%s %lu\n", vm_event_name(PGACTIVATE),
> -		       memcg_events(memcg, PGACTIVATE));
> -	seq_buf_printf(&s, "%s %lu\n", vm_event_name(PGDEACTIVATE),
> -		       memcg_events(memcg, PGDEACTIVATE));
> -	seq_buf_printf(&s, "%s %lu\n", vm_event_name(PGLAZYFREE),
> -		       memcg_events(memcg, PGLAZYFREE));
> -	seq_buf_printf(&s, "%s %lu\n", vm_event_name(PGLAZYFREED),
> -		       memcg_events(memcg, PGLAZYFREED));
> -
> -#if defined(CONFIG_MEMCG_KMEM) && defined(CONFIG_ZSWAP)
> -	seq_buf_printf(&s, "%s %lu\n", vm_event_name(ZSWPIN),
> -		       memcg_events(memcg, ZSWPIN));
> -	seq_buf_printf(&s, "%s %lu\n", vm_event_name(ZSWPOUT),
> -		       memcg_events(memcg, ZSWPOUT));
> -#endif
>  
> -#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> -	seq_buf_printf(&s, "%s %lu\n", vm_event_name(THP_FAULT_ALLOC),
> -		       memcg_events(memcg, THP_FAULT_ALLOC));
> -	seq_buf_printf(&s, "%s %lu\n", vm_event_name(THP_COLLAPSE_ALLOC),
> -		       memcg_events(memcg, THP_COLLAPSE_ALLOC));
> -#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
> +	for (i = 0; i < ARRAY_SIZE(memcg_vm_event_stat); i++)
> +		seq_buf_printf(&s, "%s %lu\n",
> +			       vm_event_name(memcg_vm_event_stat[i]),
> +			       memcg_events(memcg, memcg_vm_event_stat[i]));

Thanks
