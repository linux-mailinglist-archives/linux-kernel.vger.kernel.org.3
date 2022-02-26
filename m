Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FDDC4C5534
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 11:42:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbiBZKmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 05:42:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiBZKl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 05:41:56 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3BA1290E53
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 02:41:21 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id 139so7028566pge.1
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 02:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mjKhWjMPgXbeTa11qHZqOVCkCLpM7JLImgJi+vBEKC8=;
        b=fmng/ke0W2wco9Dkgh/fE1Mc4KET/2dyix7KRg3kGVQKCHDTQfcvyAPerYvGon36po
         LeWBx2bpFD6t6bWZsEw0JlquCY8SljLS47eIm8IZMJmo9Je9tRCy9yIqns9uDYeKp8+A
         tI3vv9hWYPhbqQcIzLc2+U/IeIbJw6rwms0HPWWh+tVDSNYE+X5VsJ8hZ3ebh2GXd3pg
         QJQFRvil9q6Gw2qATURb9ZHyrR4nbSFU0fbr3KgUFCEZ1UDwXD65smcRs0AvjamfTjOJ
         995OvEwV0pjf7Fwto5W3AFSXTQCJorRELw8KJa0i9Hr4R9KNeCOAQEfNUo7kaknRT7CW
         AU1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mjKhWjMPgXbeTa11qHZqOVCkCLpM7JLImgJi+vBEKC8=;
        b=3N02bw/lNhcmodHzgV/8YCuY5Iq04LPVfKxnjViG+A4shREPERb2oCDGUhmXW0QRs0
         ANNsjkiiznsJYYkHA5ftm8tCQZam4QBhHPwTq1j8olmep4yruS+kSIg5C49pZaM4pR0D
         HIDLIg9lHT4lOHH3Nxe5NsDA6vCUbF2pAc1WygxWAsCA6URRR9VqqkQPckZ0zYSttESD
         9/TC/dnX+juvC1R8jTCx8XWbIZifS1/ABgtgjZt7AU/IScqj0i3dI0fOeAfRBKzRRAeq
         7qPkdZ8zKBuFDbHFlCks3wTNEX9HoJbjLgr9qJptSH+c/sdxFZSfupYvnFenxnK8GTSs
         zTWA==
X-Gm-Message-State: AOAM531zQu6RzMu7dXoXqUAGsL3BSTKphMewAgBJlJLuOrR4x+z11n8I
        m6gTtOjl4wj4h/G8Dqp3P7f0dBRqwiq1lg==
X-Google-Smtp-Source: ABdhPJwkz7N4NjXwnG7ZBWanGBQgQQx6wh8pZy+BiHHzDDCntbMTgl4OsBqWhmBEnJbB8Fm0tus8xQ==
X-Received: by 2002:a63:64a:0:b0:36c:6d40:5688 with SMTP id 71-20020a63064a000000b0036c6d405688mr9731007pgg.554.1645872081193;
        Sat, 26 Feb 2022 02:41:21 -0800 (PST)
Received: from ip-172-31-19-208.ap-northeast-1.compute.internal (ec2-18-181-137-102.ap-northeast-1.compute.amazonaws.com. [18.181.137.102])
        by smtp.gmail.com with ESMTPSA id g9-20020a056a0023c900b004e10365c47dsm6552162pfc.192.2022.02.26.02.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Feb 2022 02:41:20 -0800 (PST)
Date:   Sat, 26 Feb 2022 10:41:16 +0000
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
Subject: Re: [PATCH 1/5] mm/slub: move struct track init out of set_track()
Message-ID: <YhoDzPfUtorL8U8L@ip-172-31-19-208.ap-northeast-1.compute.internal>
References: <20220225180318.20594-1-vbabka@suse.cz>
 <20220225180318.20594-2-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225180318.20594-2-vbabka@suse.cz>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 25, 2022 at 07:03:14PM +0100, Vlastimil Babka wrote:
> set_track() either zeroes out the struct track or fills it, depending on
> the addr parameter. This is unnecessary as there's only one place that
> calls it for the initialization - init_tracking(). We can simply do the
> zeroing there, with a single memset() that covers both TRACK_ALLOC and
> TRACK_FREE as they are adjacent.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/slub.c | 32 +++++++++++++++-----------------
>  1 file changed, 15 insertions(+), 17 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 261474092e43..1fc451f4fe62 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -729,34 +729,32 @@ static void set_track(struct kmem_cache *s, void *object,
>  {
>  	struct track *p = get_track(s, object, alloc);
>  
> -	if (addr) {
>  #ifdef CONFIG_STACKTRACE
> -		unsigned int nr_entries;
> +	unsigned int nr_entries;
>  
> -		metadata_access_enable();
> -		nr_entries = stack_trace_save(kasan_reset_tag(p->addrs),
> -					      TRACK_ADDRS_COUNT, 3);
> -		metadata_access_disable();
> +	metadata_access_enable();
> +	nr_entries = stack_trace_save(kasan_reset_tag(p->addrs),
> +				      TRACK_ADDRS_COUNT, 3);
> +	metadata_access_disable();
>  
> -		if (nr_entries < TRACK_ADDRS_COUNT)
> -			p->addrs[nr_entries] = 0;
> +	if (nr_entries < TRACK_ADDRS_COUNT)
> +		p->addrs[nr_entries] = 0;
>  #endif
> -		p->addr = addr;
> -		p->cpu = smp_processor_id();
> -		p->pid = current->pid;
> -		p->when = jiffies;
> -	} else {
> -		memset(p, 0, sizeof(struct track));
> -	}
> +	p->addr = addr;
> +	p->cpu = smp_processor_id();
> +	p->pid = current->pid;
> +	p->when = jiffies;
>  }
>  
>  static void init_tracking(struct kmem_cache *s, void *object)
>  {
> +	struct track *p;
> +
>  	if (!(s->flags & SLAB_STORE_USER))
>  		return;
>  
> -	set_track(s, object, TRACK_FREE, 0UL);
> -	set_track(s, object, TRACK_ALLOC, 0UL);
> +	p = get_track(s, object, TRACK_ALLOC);
> +	memset(p, 0, 2*sizeof(struct track));
>  }
>

Looks good.
Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

And works nicely.
Tested-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

>  static void print_track(const char *s, struct track *t, unsigned long pr_time)
> -- 
> 2.35.1
> 
> 

-- 
Thank you, You are awesome!
Hyeonggon :-)
