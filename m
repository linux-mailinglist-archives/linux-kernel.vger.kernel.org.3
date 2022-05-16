Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BACBA528DC0
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 21:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345333AbiEPTKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 15:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231625AbiEPTKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 15:10:31 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018B2393CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 12:10:31 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id r71so14613474pgr.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 12:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k7syZc7e4IW6qXe22/aRGymPtljsSZmZ6kuls0rngww=;
        b=pryikHjo//4oXh00NHAFRzEFc8xVE45r9L6sXoKJBVHQDNhL/LQklaC57uEu/17Q+b
         dRvVFL9MqpXJp4B/km6LzslI9DUvI/G5fKF9unFpjw6x7+zroRzCQDD7oArwEpyCvtwJ
         /M2XguzXXebiijMs7MLC1aRqG0m2tEguDg+/8rZZv+JY4A1mzaCokkL+pVa4DWGHQdI+
         h5TyB39mAc5LVUYaKfPdMJnn1DBBlkJoTmK71AqBh94dysQqgUiiep3hy2A1jbJXDBAD
         tkPH4amzgGTO8xqy/15Z/MQDy1lrpMOLfkfel27CzGH4NRYdEqm/nyFeSNCDT79nmcvo
         Ispg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k7syZc7e4IW6qXe22/aRGymPtljsSZmZ6kuls0rngww=;
        b=qSQRoCtcjJTtCw9PMTSXKHHGZ5HHtNY8L9H/9Sc2Fi35dhvL4Y142Pp/6iN4eEjuyY
         kU+lo6rYoYoTwI0gGJPiAysYUxOQkq1nyCohR2C6fIbEBFYuSiV9wExESaOs5ilmnOPl
         Q5gj5SFCSYx54r6wzOZtOGO6gJTc1gxJODjgTw6LjjR9b/zHTrBGRW3z2nfhCxpL1Kxv
         v0cqvTMPwtmlzmI+Ev1xpMiWpJRsDO4ZEkEiJ6goTU+kdDrE12SoapRtCZ1Pn04Zv8v9
         5umSp3V47lIw+Bn9lEh6/r6noLeN7sCbaXWNBZ5yeA28mp3+k2MH1iJ3Y9mSSr0LwZJ7
         yGfg==
X-Gm-Message-State: AOAM530GXyKAURUa+LTzVu9KUwUEvnF14lh9uYZiwt5N+OyQD6Tx6TWw
        02tUWeWNt3F8imtV2fMphJV/XdbeOEYOtA4HX/tMug==
X-Google-Smtp-Source: ABdhPJxv79JhgA/Y27cIO4j/iP8xxQw8o9x2TXc7qHLtuGufyQqRW1cosxYGmLpfaoOdPJF4hTxN64c6uaicn0cpU1I=
X-Received: by 2002:a65:6d06:0:b0:3c6:890:5609 with SMTP id
 bf6-20020a656d06000000b003c608905609mr16140622pgb.357.1652728230125; Mon, 16
 May 2022 12:10:30 -0700 (PDT)
MIME-Version: 1.0
References: <1fd21e25-b095-e055-fc2e-abda640a0575@openvz.org>
In-Reply-To: <1fd21e25-b095-e055-fc2e-abda640a0575@openvz.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 16 May 2022 12:10:19 -0700
Message-ID: <CALvZod6wmxxigoLVg8Q+upqOkyoh+nPuVT0yx_XTbu8RXYYFgA@mail.gmail.com>
Subject: Re: [PATCH] tracing: add ACCOUNT flag for allocations from marked
 slab caches
To:     Vasily Averin <vvs@openvz.org>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Christoph Lameter <cl@linux.com>, kernel@openvz.org,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2022 at 11:53 AM Vasily Averin <vvs@openvz.org> wrote:
>
> Slab caches marked with SLAB_ACCOUNT force accounting for every
> allocation from this cache even if __GFP_ACCOUNT flag is not passed.
> Unfortunately, at the moment this flag is not visible in ftrace output,
> and this makes it difficult to analyze the accounted allocations.
>
> This patch adds the __GFP_ACCOUNT flag for allocations from slab caches
> marked with SLAB_ACCOUNT to the ftrace output.
>
> Signed-off-by: Vasily Averin <vvs@openvz.org>
> ---
>  mm/slab.c | 3 +++
>  mm/slub.c | 3 +++
>  2 files changed, 6 insertions(+)
>
> diff --git a/mm/slab.c b/mm/slab.c
> index 0edb474edef1..4c3da8dfcbdb 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -3492,6 +3492,9 @@ void *__kmem_cache_alloc_lru(struct kmem_cache *cachep, struct list_lru *lru,

What about kmem_cache_alloc_node()?

>  {
>         void *ret = slab_alloc(cachep, lru, flags, cachep->object_size, _RET_IP_);
>
> +       if (cachep->flags & SLAB_ACCOUNT)

Should this 'if' be unlikely() or should we trace cachep->flags
explicitly to avoid this branch altogether?

> +               flags |= __GFP_ACCOUNT;
> +
>         trace_kmem_cache_alloc(_RET_IP_, ret,
>                                cachep->object_size, cachep->size, flags);
>
> diff --git a/mm/slub.c b/mm/slub.c
> index ed5c2c03a47a..670bbfef9e49 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3231,6 +3231,9 @@ void *__kmem_cache_alloc_lru(struct kmem_cache *s, struct list_lru *lru,
>  {
>         void *ret = slab_alloc(s, lru, gfpflags, _RET_IP_, s->object_size);
>
> +       if (s->flags & SLAB_ACCOUNT)
> +               gfpflags |= __GFP_ACCOUNT;
> +
>         trace_kmem_cache_alloc(_RET_IP_, ret, s->object_size,
>                                 s->size, gfpflags);
>
> --
> 2.25.1
>
