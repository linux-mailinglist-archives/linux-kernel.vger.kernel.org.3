Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4C04C58C7
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 01:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbiB0AXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 19:23:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiB0AXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 19:23:36 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 245A818BA70
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 16:23:01 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id q8-20020a17090a178800b001bc299b8de1so8173406pja.1
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 16:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dnqnUC19xO35MCy9LRDHO0Cui2vrFHNNs03zEs4NcDw=;
        b=PrZSLUN3MtjGPfHYaaY7BMwDWIbdVnmoXTS30IMzZlpZDFnUT5yitvdblFN1ZdNjLo
         owG3WClAMkuCWEUTCUO6HyB62hBXaW5jpm6MUrOX1a+DiKola00Kwq655ZKClUnSu4a+
         Mtlz1lkGuykQR2wkRStiRGhiOJDlwKhS0dWl4Vjh7a41NGSA/CGpdhMRUmjyXk3PNgEx
         WDhCaX7jC+Y8ha4vAREzLCH2xHTm2iRmx4E49+SJavbsKx+sReOgYy1acv1Sj4JsO2r1
         pba2QDiNlaY4rHX8tAmMerHss4bUctg9hIFPA0FBvWIThFFaJo2R3j3NccmQXeFwHcKV
         d4ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dnqnUC19xO35MCy9LRDHO0Cui2vrFHNNs03zEs4NcDw=;
        b=XWOnkZ9LKeRNAEun+I1zUnF23eqK4nljATqNLlItLpXero0zn5YgbGxTDZ2EhC4rt9
         RMTZURXKCmPCI1KsTUV3WK5ir4drTzvmxB8c8KF+DOAVLzP8qMYU+6nSBkWDVHOhrjCQ
         ZvZ7UCjJyxMtU01B4fI5IvxX5yiTgJP1NgJlw1lX4gUQEc6FMbB98O7EdMbCVZqi0sXN
         ZYpzeaDOk4GV1gV4w9H2pATQRHq4s+VX5qSp1gJ4NtzYSkHWfzGvGcCLYX1RuJc1btWP
         yL5gt8bkS1tW2Y4HYB3edFOx5vY78hdTbho4nCyojuJkuO4EoeRiNdeVYvSgZPnD/C4e
         kHcQ==
X-Gm-Message-State: AOAM5308OR49gQbnwJou1jzDGKpFSimFqRpJcg+UY1+EEAdTOMwpYZyS
        OOTBhaU1KYHt0fBg6L/EX3wMSULjSm9CJQ==
X-Google-Smtp-Source: ABdhPJy1Fn+k0zmImu33O6WiH3LwjSnckxuFNoe7Wsf8iwvi/lRFbXV6YRdNIZGJHFxctNldLVmCyg==
X-Received: by 2002:a17:90a:db15:b0:1bd:71f:8123 with SMTP id g21-20020a17090adb1500b001bd071f8123mr7067540pjv.126.1645921380516;
        Sat, 26 Feb 2022 16:23:00 -0800 (PST)
Received: from ip-172-31-19-208.ap-northeast-1.compute.internal (ec2-18-181-137-102.ap-northeast-1.compute.amazonaws.com. [18.181.137.102])
        by smtp.gmail.com with ESMTPSA id h3-20020a056a00170300b004f104c635e4sm8263288pfc.99.2022.02.26.16.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Feb 2022 16:23:00 -0800 (PST)
Date:   Sun, 27 Feb 2022 00:22:55 +0000
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
Message-ID: <YhrEXwdK2/9x93Qp@ip-172-31-19-208.ap-northeast-1.compute.internal>
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

I think it will be better if subject was something like
"Differentiate by stack and print stack traces in debugfs"?

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
> -- 
> 2.35.1
> 

-- 
Thank you, You are awesome!
Hyeonggon :-)
