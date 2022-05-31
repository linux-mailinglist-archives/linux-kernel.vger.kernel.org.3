Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E98F5539008
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 13:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343933AbiEaLrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 07:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242016AbiEaLq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 07:46:59 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B1D49931
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 04:46:58 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id 2so13810158iou.5
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 04:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=93uhBt8Wzct8J4+CdbYjcgwsc3kwGGU4sNgYP7SDugU=;
        b=Ok/wAPTVkx7ULmfKE4buubCQQgiOQrL+1p2aGP6w95FzI5yXyJEl3p1oat5ye85LMe
         8MrC86gVZKkFsUoWalAUpFCHN3p2mBSk4Pl9FybWQiCWOXyXf6hEBD2OtTiSoKH7PCJ6
         MDIXuaxzHxe+Xvn/ucv70+hs8apG5dTtueutariyx7mbE5Iy9jK08VDKtZnNK14gqREa
         CNVDlxagBgDWqwyv/95OZFh0z5XiF/6+w1nRxd7hZhMqiz+dIA11Q/8d8kHYaXwsIsT+
         mqjpmrt97Fu8jzSx+6khcBe7EEQwUrzTEYEvj+fCSmoX8GOS2z2bdkpkFe+EdDyroSk9
         ORpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=93uhBt8Wzct8J4+CdbYjcgwsc3kwGGU4sNgYP7SDugU=;
        b=HGL74C4oFNLu5bCJmEYNJQMNxRny0WPUCz2/cykvBc5aioisB9i/XwlA5BOsVsEdgb
         WpehEG5QJdAH0MsIf/PArTsZVCiQlP5dPZk7DK+hBRJdx4m4HSI9l4Ck6A5OFfVMZRAC
         sa4GonatUlmkWIFYLjd53aSo6+998Rf+4catq720T4NhZWsnIH2vmda+x6jtAEO6YbiT
         eenQrirMHTlmKXg8HgIG33lkwafqtg+7Dkks4cjipi1qizOe8vagKl4WjgOwY9Wyodx1
         d4PmdqLbmQ85ztW1mkHEhhRWEtZkdG2ASmSPaCNKa6MPxYYtoPClYqgJZlWJ9CTsaEqi
         k+og==
X-Gm-Message-State: AOAM532DAnkCdGO8TGw6j7sb8mHW81sD+q1toeVMyqaJyj8at2Pb/IS7
        O3JbkbgnFYspoVjA+cB/GLc=
X-Google-Smtp-Source: ABdhPJxV2VhIXeWm6sXONG+DapOQ+XeGntmxg+hgJTxxViQd6k6Owy195rdwhsURjD9ZZJN4XnvmNw==
X-Received: by 2002:a5d:9d06:0:b0:65e:5162:475b with SMTP id j6-20020a5d9d06000000b0065e5162475bmr23574835ioj.149.1653997617554;
        Tue, 31 May 2022 04:46:57 -0700 (PDT)
Received: from n2.us-central1-a.c.spheric-algebra-350919.internal (151.16.70.34.bc.googleusercontent.com. [34.70.16.151])
        by smtp.gmail.com with ESMTPSA id c18-20020a5ea912000000b00665754e45c2sm4023663iod.24.2022.05.31.04.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 04:46:56 -0700 (PDT)
Date:   Tue, 31 May 2022 11:46:55 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Vasily Averin <vvs@openvz.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>, kernel@openvz.org,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Matthew Wilcox <willy@infradead.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Michal Hocko <mhocko@suse.com>,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH v5] tracing: add 'accounted' entry into output of
 allocation tracepoints
Message-ID: <YpYAL4H/L2ERQ9Fj@n2.us-central1-a.c.spheric-algebra-350919.internal>
References: <c7f687a8-637c-b119-6e3a-7dacc885b851@suse.cz>
 <80bcb043-3782-1d81-d8a2-4bdcb213cf30@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80bcb043-3782-1d81-d8a2-4bdcb213cf30@openvz.org>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 30, 2022 at 10:47:26AM +0300, Vasily Averin wrote:
> Slab caches marked with SLAB_ACCOUNT force accounting for every
> allocation from this cache even if __GFP_ACCOUNT flag is not passed.
> Unfortunately, at the moment this flag is not visible in ftrace output,
> and this makes it difficult to analyze the accounted allocations.
> 
> This patch adds boolean "accounted" entry into trace output,
> and set it to 'true' for calls used __GFP_ACCOUNT flag and
> for allocations from caches marked with SLAB_ACCOUNT.
> 
> Signed-off-by: Vasily Averin <vvs@openvz.org>
> Acked-by: Shakeel Butt <shakeelb@google.com>
> Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
> 
> ---
> v5:
>  1) re-based to current upstream (v5.18-11267-gb00ed48bb0a7)
>  2) added "Acked-by" from Roman
>  3) re-addressed to slab maintaiers
> 
> v4:
>  1) replaced in patch descripion: "accounted" instead of "allocated"
>  2) added "Acked-by" from Shakeel,
>  3) re-addressed to akpm@
> 
> v3:
>  1) rework kmem_cache_alloc* tracepoints once again,
>     added struct kmem_cache argument into existing templates,
> 	thanks to Matthew Wilcox
>  2) updated according trace_* calls
>  3) added boolean "allocated" entry into trace output,
> 	thanks to Roman
>  4) updated patch subject and description
> 
> v2:
>  1) handle kmem_cache_alloc_node(), thanks to Shakeel
>  2) rework kmem_cache_alloc* tracepoints to use cachep instead
>     of current cachep->*size parameters.
>     NB: kmem_cache_alloc_node tracepoint in SLOB cannot use cachep,
>         and therefore it was replaced by kmalloc_node.
> ---
>  include/trace/events/kmem.h | 38 +++++++++++++++++++++++--------------
>  mm/slab.c                   | 10 +++++-----
>  mm/slab_common.c            |  9 ++++-----
>  mm/slob.c                   |  8 ++++----
>  mm/slub.c                   | 20 +++++++++----------
>  5 files changed, 47 insertions(+), 38 deletions(-)
> 

Looks good to me.
Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

a small comment:
>  
>  	TP_fast_assign(
> @@ -33,42 +35,46 @@ DECLARE_EVENT_CLASS(kmem_alloc,
>  		__entry->bytes_req	= bytes_req;
>  		__entry->bytes_alloc	= bytes_alloc;
>  		__entry->gfp_flags	= (__force unsigned long)gfp_flags;
> +		__entry->accounted	= (gfp_flags & __GFP_ACCOUNT) ||
> +					  (s && s->flags & SLAB_ACCOUNT);
>  	),
>  

It doesn't make sense for SLOB to print accounted=true because SLOB does
not support object accounting.

>  DEFINE_EVENT(kmem_alloc, kmalloc,
>  
> -	TP_PROTO(unsigned long call_site, const void *ptr,
> +	TP_PROTO(unsigned long call_site, const void *ptr, struct kmem_cache *s,
>  		 size_t bytes_req, size_t bytes_alloc, gfp_t gfp_flags),
>  
> -	TP_ARGS(call_site, ptr, bytes_req, bytes_alloc, gfp_flags)
> +	TP_ARGS(call_site, ptr, s, bytes_req, bytes_alloc, gfp_flags)
>  );
>  
>  DEFINE_EVENT(kmem_alloc, kmem_cache_alloc,
>  
> -	TP_PROTO(unsigned long call_site, const void *ptr,
> +	TP_PROTO(unsigned long call_site, const void *ptr, struct kmem_cache *s,
>  		 size_t bytes_req, size_t bytes_alloc, gfp_t gfp_flags),
>  
> -	TP_ARGS(call_site, ptr, bytes_req, bytes_alloc, gfp_flags)
> +	TP_ARGS(call_site, ptr, s, bytes_req, bytes_alloc, gfp_flags)
>  );
>  
>  DECLARE_EVENT_CLASS(kmem_alloc_node,
>  
>  	TP_PROTO(unsigned long call_site,
>  		 const void *ptr,
> +		 struct kmem_cache *s,
>  		 size_t bytes_req,
>  		 size_t bytes_alloc,
>  		 gfp_t gfp_flags,
>  		 int node),
>  
> -	TP_ARGS(call_site, ptr, bytes_req, bytes_alloc, gfp_flags, node),
> +	TP_ARGS(call_site, ptr, s, bytes_req, bytes_alloc, gfp_flags, node),
>  
>  	TP_STRUCT__entry(
>  		__field(	unsigned long,	call_site	)
> @@ -77,6 +83,7 @@ DECLARE_EVENT_CLASS(kmem_alloc_node,
>  		__field(	size_t,		bytes_alloc	)
>  		__field(	unsigned long,	gfp_flags	)
>  		__field(	int,		node		)
> +		__field(	bool,		accounted	)
>  	),
>  
>  	TP_fast_assign(
> @@ -86,33 +93,36 @@ DECLARE_EVENT_CLASS(kmem_alloc_node,
>  		__entry->bytes_alloc	= bytes_alloc;
>  		__entry->gfp_flags	= (__force unsigned long)gfp_flags;
>  		__entry->node		= node;
> +		__entry->accounted	= (gfp_flags & __GFP_ACCOUNT) ||
> +					  (s && s->flags & SLAB_ACCOUNT);
>  	),
