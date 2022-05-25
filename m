Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74208533767
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 09:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234498AbiEYHdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 03:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244236AbiEYHdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 03:33:35 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F7F350E05
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 00:33:27 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id d3so13305522ilr.10
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 00:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=D1QXg+ZJxZudpo1DLstJUE5WBMRrsF/kSmhiXxVx99g=;
        b=C3jipImfWMy0knV4R4k3AKeVpp76f40sy0D0as6hH44YK1UzFCKRf7cS/QNTBbczMn
         hcFTxMwpr/B7E+lBCvsRf9XCHjL7keB28QXAyRwz+7Pqd5VRa/+/ejR/4NdQVNpFT7Tl
         1zWyYpjOA4l5L/Mmgog6fCPTVvoxhSpr+KPC2qWWM1bGZ3kSeB+USL/7l6z1ZIrcn2ID
         7sPhp6ITjYueLKpLVWDj8S89l9MzJ4eR2B4ZoPbLAeCSGpm6CWikJBcVFNQVDYhxV/L9
         vwRtFsnwMRJqo9MvSLV7EFe6O0zG06U1eiT5cHuL+l/ZZC6GGksth7ubDHC6Fm3Q48iC
         qoEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=D1QXg+ZJxZudpo1DLstJUE5WBMRrsF/kSmhiXxVx99g=;
        b=LwSHXBB2wMy5Z2sxeVeGlIcyj8O55/jP2HDaKTq62jg5nWna3vT8YDoEI6lzuS+C6r
         pO7cmfATyqW9ipYPb/HjlBakEVzbjV/P5zmER8BqO7CncOCbT8bUlRL2tnkKuibNZY6U
         HryHhG0At47+uepIZjciQ0Ch6amFrfeY4nb7ci/Y8MyUr/dbTVJ0/t3s/CqTMAK/YZGR
         EOWYY/bHPCpoV9p2b9r+fN9FL0fYPC3qP/PIJWoe5yV261bCoBFud/lW82XeqR/ltvE+
         9KlNppmbwXtn/Gp/qckBqeeh8ePEqX2BUkZ+IJQmS3IQMLcWZp2AhuxmkDhuNbVd7dTB
         /gGA==
X-Gm-Message-State: AOAM530A+PuvWjEF7Iwvgk/1KtlwITH8J0n+NbING0aPD3nVZloQ5J3m
        FCYCc1AuA6f+vVduCbi3UzQ=
X-Google-Smtp-Source: ABdhPJwvk+1xyN+3GXu5wm8Xm5+t4z6lhRUaBaOEQ1H+HED9EnYcEwZ767GhpfDGMWqqWAQ0KL8p9Q==
X-Received: by 2002:a05:6e02:168f:b0:2cf:166b:bb10 with SMTP id f15-20020a056e02168f00b002cf166bbb10mr15762006ila.89.1653464006684;
        Wed, 25 May 2022 00:33:26 -0700 (PDT)
Received: from n2.us-central1-a.c.spheric-algebra-350919.internal (151.16.70.34.bc.googleusercontent.com. [34.70.16.151])
        by smtp.gmail.com with ESMTPSA id q5-20020a0566022f0500b00665862d12bbsm471242iow.46.2022.05.25.00.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 00:33:25 -0700 (PDT)
Date:   Wed, 25 May 2022 07:33:24 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Vasily Averin <vvs@openvz.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, kernel@openvz.org,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-mm@kvack.org,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Michal Hocko <mhocko@suse.com>,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH v4] tracing: add 'accounted' entry into output of
 allocation tracepoints
Message-ID: <Yo3bxCkCWU+n8/3I@n2.us-central1-a.c.spheric-algebra-350919.internal>
References: <0c73ce5c-3625-6187-820e-1277e168b3bc@openvz.org>
 <a1e54672-d824-3ee1-cb68-9ceaa46fc70f@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1e54672-d824-3ee1-cb68-9ceaa46fc70f@openvz.org>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 21, 2022 at 09:36:54PM +0300, Vasily Averin wrote:
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
> ---


Maybe I worried a bit much...

I failed to apply it on slab/for-next and v5.18. What tree is it based on?

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
