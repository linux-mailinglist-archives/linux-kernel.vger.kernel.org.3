Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCF1E4C555B
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 12:03:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbiBZLDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 06:03:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbiBZLDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 06:03:46 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7005431340
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 03:03:11 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id p8so6888755pfh.8
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 03:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mmkWsrso01vONxcAXV20rQyXeBZP2Ss9B8KA2fOi8ag=;
        b=k5S5i1E4NCCM4iHYCxYqvpeR9HY1NZVvfuYaFHDFveJx88bYwYsYzzpmFk8bdZ8Pyv
         ANz6YXwgEKKXSkHZE+9vFNHD7Yk7GWyhRAunYXXu5w9W0M7dkcdC05aoSZuWY8JoDTrS
         eqw/NxXlybnE4sRaYgRvV2txym58lE88n/18IPvSkLVoL5r7hjUthkxWFFVFpPxbV4R1
         gYVx1tmOgFwtmRD2If00nSjG6VeGuBgoCdCPMVXUBlOpzR9E/s9m3nOXSp3qLK4o2ICi
         6Pq5/VGCfbv9HEoL9HaNnGuI+mzN+IYGJGmj9ITAiP5J/TzIu8NqTO6u2v0UG8RBFibG
         Zp2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mmkWsrso01vONxcAXV20rQyXeBZP2Ss9B8KA2fOi8ag=;
        b=3YLqK4BCkzvBLSviNk3e6omdorbKfwysKBYipNvtseI2Yjk6cjRJwj8EMslUMdxG8T
         ilHAY8Ftn58u+4e/HsnkIELg/TgvRrIZ7ktdsWMwFFsCwsTJJr1C3YVXUi/x9Yso3DVi
         +NooEmSjpsLj9j9YSGvuv5Wmn9VSMaQpqjYDhJQXhu2k7aZTE9JoC+Kri7tKwrsqDmaz
         sHf6GKreYeEo50ZK09FclH2kqMNfNOAlalrvjYiknL38ZRFIft1xTftShooKR6K2XbFM
         IoSsXnX9xBEivY77UIM5Y/BrQfFDjrNP2VxAxbYde7GxkG/f9gzq9t/0Nlal9wCG5fWx
         disQ==
X-Gm-Message-State: AOAM531cYRpUEWho5PS99DZbUCQ1y57ti0az7hCagyvHa2oFRGWbr5Ic
        s4NqszLc7k6cSBtqz3cygeU=
X-Google-Smtp-Source: ABdhPJyGh83QLjfOwOH3/LsCgjW8UJUiILWwtXv1PlwSvjYNEFnxzWPdKu6rHDHlAfsGcXVIPPCqZg==
X-Received: by 2002:a05:6a00:1ac6:b0:4bd:140:626c with SMTP id f6-20020a056a001ac600b004bd0140626cmr12027035pfv.7.1645873390956;
        Sat, 26 Feb 2022 03:03:10 -0800 (PST)
Received: from ip-172-31-19-208.ap-northeast-1.compute.internal (ec2-18-181-137-102.ap-northeast-1.compute.amazonaws.com. [18.181.137.102])
        by smtp.gmail.com with ESMTPSA id e14-20020a056a001a8e00b004e136d54a15sm6804244pfv.105.2022.02.26.03.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Feb 2022 03:03:10 -0800 (PST)
Date:   Sat, 26 Feb 2022 11:03:05 +0000
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
Subject: Re: [PATCH 4/5] mm/slub: sort debugfs output by frequency of stack
 traces
Message-ID: <YhoI6W+/aXbNQ0NZ@ip-172-31-19-208.ap-northeast-1.compute.internal>
References: <20220225180318.20594-1-vbabka@suse.cz>
 <20220225180318.20594-5-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225180318.20594-5-vbabka@suse.cz>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 25, 2022 at 07:03:17PM +0100, Vlastimil Babka wrote:
> From: Oliver Glitta <glittao@gmail.com>
> 
> Sort the output of debugfs alloc_traces and free_traces by the frequency
> of allocation/freeing stack traces. Most frequently used stack traces
> will be printed first, e.g. for easier memory leak debugging.
> 
> Signed-off-by: Oliver Glitta <glittao@gmail.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/slub.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 06599db4faa3..a74afe59a403 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -38,6 +38,7 @@
>  #include <linux/memcontrol.h>
>  #include <linux/random.h>
>  #include <kunit/test.h>
> +#include <linux/sort.h>
>  
>  #include <linux/debugfs.h>
>  #include <trace/events/kmem.h>
> @@ -6150,6 +6151,17 @@ static void *slab_debugfs_next(struct seq_file *seq, void *v, loff_t *ppos)
>  	return NULL;
>  }
>  
> +static int cmp_loc_by_count(const void *a, const void *b, const void *data)
> +{
> +	struct location *loc1 = (struct location *)a;
> +	struct location *loc2 = (struct location *)b;
> +
> +	if (loc1->count > loc2->count)
> +		return -1;
> +	else
> +		return 1;
> +}
> +
>  static void *slab_debugfs_start(struct seq_file *seq, loff_t *ppos)
>  {
>  	struct loc_track *t = seq->private;
> @@ -6211,6 +6223,10 @@ static int slab_debug_trace_open(struct inode *inode, struct file *filep)
>  		spin_unlock_irqrestore(&n->list_lock, flags);
>  	}
>  
> +	/* Sort locations by count */
> +	sort_r(t->loc, t->count, sizeof(struct location),
> +		cmp_loc_by_count, NULL, NULL);
> +
>  	bitmap_free(obj_map);
>  	return 0;
>  }

This is so cool!

Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Tested-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

> -- 
> 2.35.1
> 
> 

-- 
Thank you, You are awesome!
Hyeonggon :-)
