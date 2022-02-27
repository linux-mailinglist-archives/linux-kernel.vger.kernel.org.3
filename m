Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4551C4C58C3
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 01:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbiB0ATO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 19:19:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiB0ATN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 19:19:13 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5CBD186BBE
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 16:18:37 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id a5so7014765pfv.9
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 16:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=n1TJ0Y2cV3ooViKl4YV0Gg01JoStoDXO+vd94Rnxvno=;
        b=FsPjxCbTXnQGUqDn4BqP5TqcxkgUQF/5Lnfz86M++Dz1AC/lqN/7gyMRQ8bxGAC24l
         l1xfrXzBc8wBuEbD05QWy+oKejfRJ+BR+K6ZyTnaz8bTZOfNYrY8uov8qmzR39OGwcpC
         UFYKfK2g3pTDpLWAi3FX1ThIfbLtzLIpwfIcys7xrRaDeqW7D4GPbKhAuUO6zrhk2O5p
         VjmtSd0k+lB7cZ9TInEDJ6NJlPY8BWMbHp2qOvLHXvGpKaN+tBMeF8WHA5yGvI0b3U2h
         d3+exONWiqXdaNw7qlel7MdPW+2FmKVWF9cGME+ygP69N75RJlr42RMStGVzc8bVJkma
         aH7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=n1TJ0Y2cV3ooViKl4YV0Gg01JoStoDXO+vd94Rnxvno=;
        b=rVShFvFjZp1eyzVpPcp2gx7oiFrFwio5tqbzfDP6jyI7f84TpZKe1MAyCxuUOJAqU3
         x909+pZ1rkdGKTc3xCtc1Evh5sZh1qqIccru1WCSsepj0f8Lp50oMrJ6k5Q5hcSuhgCJ
         JPNzvdvwY7c6nuNzvjuCJxikhSF/MiiCdceRrMi3USS3BNJIfBBvawnfXE/j7hNZ13jU
         V2AZILaTSCvYhPpi0B+vf2IxhzJNAVnVTwAufaFOABO21JgJ0oqOSaQDtl09DWWwAQQ2
         sqLP/CCEjqEyrCh5zf6vabMT1eTQBkN0hBxhaaKvy8RQ79n50uWZVSznSUa9MIbWZ+Tt
         kW/Q==
X-Gm-Message-State: AOAM533hpMOr2VEMdgao90eU6H/6r3QqlEqkbB02+plNco61P+lidfJd
        2jIojjMcbYm8LBg570eGj3E=
X-Google-Smtp-Source: ABdhPJzaYbE9wt0hN6MMtWdOuTFNdyKrRrDJ7UMIDxzQDw8mKBv5MAvizizTGG+QwUbzX63Q1vVT3Q==
X-Received: by 2002:a05:6a00:1691:b0:4e1:935f:94dd with SMTP id k17-20020a056a00169100b004e1935f94ddmr14605506pfc.83.1645921117113;
        Sat, 26 Feb 2022 16:18:37 -0800 (PST)
Received: from ip-172-31-19-208.ap-northeast-1.compute.internal (ec2-18-181-137-102.ap-northeast-1.compute.amazonaws.com. [18.181.137.102])
        by smtp.gmail.com with ESMTPSA id 124-20020a620582000000b004dee0e77128sm7412648pff.166.2022.02.26.16.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Feb 2022 16:18:36 -0800 (PST)
Date:   Sun, 27 Feb 2022 00:18:32 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        Oliver Glitta <glittao@gmail.com>,
        Faiyaz Mohammed <faiyazm@codeaurora.org>
Subject: Re: [PATCH 3/5] mm/slub: aggregate and print stack traces in debugfs
 files
Message-ID: <YhrDWK+TfC3uyjyX@ip-172-31-19-208.ap-northeast-1.compute.internal>
References: <20220225180318.20594-1-vbabka@suse.cz>
 <20220225180318.20594-4-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225180318.20594-4-vbabka@suse.cz>
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FROM_FMBLA_NEWDOM,
        HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 25, 2022 at 07:03:16PM +0100, Vlastimil Babka wrote:
> From: Oliver Glitta <glittao@gmail.com>
> 
> Aggregate objects in slub cache by stack trace in addition to caller
> address when producing contents of debugfs files alloc_traces and
> free_traces in debugfs. Also add the stack traces to the debugfs
> output. This makes it much more useful to e.g. debug memory leaks.
> 
> Signed-off-by: Oliver Glitta <glittao@gmail.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/slub.c | 28 ++++++++++++++++++++++++++--
>  1 file changed, 26 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 3140f763e819..06599db4faa3 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -5075,6 +5075,7 @@ EXPORT_SYMBOL(validate_slab_cache);
>   */
>  
>  struct location {
> +	depot_stack_handle_t handle;
>  	unsigned long count;
>  	unsigned long addr;
>  	long long sum_time;
> @@ -5127,9 +5128,13 @@ static int add_location(struct loc_track *t, struct kmem_cache *s,
>  {
>  	long start, end, pos;
>  	struct location *l;
> -	unsigned long caddr;
> +	unsigned long caddr, chandle;
>  	unsigned long age = jiffies - track->when;
> +	depot_stack_handle_t handle = 0;
>  
> +#ifdef CONFIG_STACKDEPOT
> +	handle = READ_ONCE(track->handle);
> +#endif
>  	start = -1;
>  	end = t->count;
>  
> @@ -5144,7 +5149,8 @@ static int add_location(struct loc_track *t, struct kmem_cache *s,
>  			break;
>  
>  		caddr = t->loc[pos].addr;
> -		if (track->addr == caddr) {
> +		chandle = t->loc[pos].handle;
> +		if ((track->addr == caddr) && (handle == chandle)) {
>
>  			l = &t->loc[pos];
>  			l->count++;
> @@ -5169,6 +5175,8 @@ static int add_location(struct loc_track *t, struct kmem_cache *s,
>  
>  		if (track->addr < caddr)
>  			end = pos;
> +		else if (track->addr == caddr && handle < chandle)
> +			end = pos;
>  		else
>  			start = pos;
>  	}
> @@ -5191,6 +5199,7 @@ static int add_location(struct loc_track *t, struct kmem_cache *s,
>  	l->max_time = age;
>  	l->min_pid = track->pid;
>  	l->max_pid = track->pid;
> +	l->handle = handle;
>  	cpumask_clear(to_cpumask(l->cpus));
>  	cpumask_set_cpu(track->cpu, to_cpumask(l->cpus));
>  	nodes_clear(l->nodes);
> @@ -6102,6 +6111,21 @@ static int slab_debugfs_show(struct seq_file *seq, void *v)
>  			seq_printf(seq, " nodes=%*pbl",
>  				 nodemask_pr_args(&l->nodes));
>  
> +#ifdef CONFIG_STACKDEPOT
> +		{
> +			depot_stack_handle_t handle;
> +			unsigned long *entries;
> +			unsigned int nr_entries, j;
> +
> +			handle = READ_ONCE(l->handle);
> +			if (handle) {
> +				nr_entries = stack_depot_fetch(handle, &entries);
> +				seq_puts(seq, "\n");
> +				for (j = 0; j < nr_entries; j++)
> +					seq_printf(seq, "        %pS\n", (void *)entries[j]);
> +			}
> +		}
> +#endif
>  		seq_puts(seq, "\n");
>  	}
>

Yeah this is necessary as we collect not only caller address, but also
stacks. stacks can be different even if caller address is same. 
So we need to aggregate by both caller address and handle.

This patch looks good.

Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

And it works nicely. After this patch I see now it can differentiate
by stack too.

Tested-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

I like this so much. This makes {free,alloc}_traces much more useful.

before patch:
# cat alloc_traces 
   2924 __d_alloc+0x30/0x3ac age=1/13709/14330 pid=0-184 cpus=0-3

after patch:
# cat alloc_traces 
    757 __d_alloc+0x30/0x3b0 age=2041/7771/7874 pid=1-179 cpus=0-3
        __slab_alloc.constprop.0+0x30/0x74
        kmem_cache_alloc+0x2c0/0x300
        __d_alloc+0x30/0x3b0
        d_alloc_parallel+0xd8/0x824
        path_openat+0xadc/0x16bc
        do_filp_open+0xf8/0x1f4
        do_sys_openat2+0x120/0x26c
        __arm64_sys_openat+0xf0/0x160
        invoke_syscall+0x60/0x190
        el0_svc_common.constprop.0+0x7c/0x160
        do_el0_svc+0x88/0xa4
        el0_svc+0x3c/0x80
        el0t_64_sync_handler+0xa8/0x130
        el0t_64_sync+0x1a0/0x1a4

    301 __d_alloc+0x30/0x3b0 age=8217/8237/8309 pid=51 cpus=1-2
        __slab_alloc.constprop.0+0x30/0x74
        kmem_cache_alloc+0x2c0/0x300
        __d_alloc+0x30/0x3b0
        d_alloc+0x30/0xd0
        __lookup_hash+0x70/0xf0
        filename_create+0xf4/0x220

	[...]

> -- 
> 2.35.1
> 

-- 
Thank you, You are awesome!
Hyeonggon :-)
