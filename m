Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB3853756F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 09:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233459AbiE3HcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 03:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231839AbiE3HcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 03:32:06 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7832E117D
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 00:32:04 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id r82so7727779ybc.13
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 00:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DO7pNgSmpx/Kvj/5lzN/3ULLjRJsEMomxVlAVcR8VTQ=;
        b=WM9WVNOMfTZExjLAP8DLain6e/baspDiCVNDCYANby4nAeRgxJoroCntR9nWyY+UaH
         y/uBMieZOVj1EWQl0mnJkA9w8F702PSpJ2mNzAONjsqUl4qPsTSVUTyXssHU9cuoQ7Sk
         FLrJRK6qyv3abkeV9LEWqvNm8aV+tcu3bxKnqyyq4GwesDUUxjGa5TjLbyOZxCJPGon3
         1Uoos/rO7aTGQLCUgST4R7je5dYMgAXZ86sVnkKgvp4ql5+MDiUONKkWUstU0qTS4l+v
         VRCA0PQyih0awA8KnpSg8mwuU1HybgmYEZ6FWewqUp5uvehJSFKc1e4eG7eV+XKSYowr
         cZTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DO7pNgSmpx/Kvj/5lzN/3ULLjRJsEMomxVlAVcR8VTQ=;
        b=Qvzf8KVqbVC23V78OWicGRVSO6ZYfjpEw2R4Widtpx5CjGkTfA/6RcUFWfP4HqLElT
         a32uRRr7euUXGt1yPaFmVLMsz0WHw3gGuj1Xl8ACqJiZ1wOCMWSgAFRk7lMNCblIeWQf
         vuMCc4OsjRaAbj/BpoB4Q93UM48E0iD3ETBh+Xs+17tS4NLgXg+EJzRa+8CKj0AXVX/J
         r+CN4oAMEGiMrVnBV3nYNylrkR6FwXa8pRdIjaymKMlFbQF1WNE+C30VAt9+KKxKgCkP
         bnChZO5IdBhAh7zHhHxNfnMinsSoeusEpjIln5u0e3qUYk7fx/A/mbsF7UVArxaw8bza
         uD8Q==
X-Gm-Message-State: AOAM531xDu51O9/p9oPtDK5sbDX0YPuV+ngGU5wkHcl7txWv2TS/DbKk
        81NsDjWtdQgoo0T8DwqKrH8fQd0XXEcm/VtQ+YztAg==
X-Google-Smtp-Source: ABdhPJzZpsSGBdihXdj6VD9hfyZ2/I5LHVU66WMeGQC4OCDjnZZ44BMcbUrLEau5RRoA1lJ81t4wZ1vgkLJtNOfMzQE=
X-Received: by 2002:a25:824a:0:b0:65c:bf2a:265 with SMTP id
 d10-20020a25824a000000b0065cbf2a0265mr5524950ybn.225.1653895923489; Mon, 30
 May 2022 00:32:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220526103929.14976-1-zhouchengming@bytedance.com> <20220526103929.14976-2-zhouchengming@bytedance.com>
In-Reply-To: <20220526103929.14976-2-zhouchengming@bytedance.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 30 May 2022 09:31:52 +0200
Message-ID: <CAKfTPtCD-bh=CdsLVnzEm4HgLdjUQn1YbvpY=6Cv158p77E8yw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] sched/fair: fix propagate during synchronous attach/detach
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        odin@uged.al, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, songmuchun@bytedance.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 May 2022 at 12:39, Chengming Zhou
<zhouchengming@bytedance.com> wrote:
>
> When a task moves from/to a cfs_rq, we first detach/attach the load_avg
> of se from/to that cfs_rq, then propagate the changes across the tg tree
> to make it visible to the root, which did in update_load_avg().
>
> But the current code will break when encountering a on_list cfs_rq,

It breaks only when the cfs is throttled and the full branch is on the
list because is this case, we only want to make sure that the branch
is correctly ordered in the list

> can't propagate up to the root cfs_rq, that also mismatch with the
> comment of propagate_entity_cfs_rq(), which says "Propagate the changes
> of the sched_entity across the tg tree to make it visible to the root".
>
> The second problem is that it won't update_load_avg() for throttled
> cfs_rq, cause the load changes can't be propagated upwards.

If the cfs is throttled, its sched_entity has been dequeued and its
load is not accounted in the parent so there is nothing to propagate

>
>     A
>     |
>     B  --> throttled cfs_rq
>    /
>   C
>
> The prop_runnable_sum of C won't be propagated to B, so won't be
> propagated to A.
>
> Fixes: 0258bdfaff5b ("sched/fair: Fix unfairness caused by missing load decay")
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> ---
>  kernel/sched/fair.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 906b2c7c48d1..c6da204f3068 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -11267,14 +11267,8 @@ static void propagate_entity_cfs_rq(struct sched_entity *se)
>         for_each_sched_entity(se) {
>                 cfs_rq = cfs_rq_of(se);
>
> -               if (!cfs_rq_throttled(cfs_rq)){
> -                       update_load_avg(cfs_rq, se, UPDATE_TG);
> -                       list_add_leaf_cfs_rq(cfs_rq);
> -                       continue;
> -               }
> -
> -               if (list_add_leaf_cfs_rq(cfs_rq))
> -                       break;
> +               update_load_avg(cfs_rq, se, UPDATE_TG);
> +               list_add_leaf_cfs_rq(cfs_rq);
>         }
>  }
>  #else
> --
> 2.36.1
>
