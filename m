Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 932104DD108
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 00:04:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbiCQXFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 19:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbiCQXFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 19:05:40 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD582C77BB
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 16:04:23 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id u103so12927967ybi.9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 16:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VGYk8110mxEIfZb97hjNSOmSSAM9U3Ysh5enZGGhhu8=;
        b=UiJxJlc4/xpUFMOyYI60SdngqCq0itChQDoI227vzhkyaBmHb9JeQGsE/YMnQrHGag
         DkHB7CFzQLIr0i38uhyRbunBatMWQR/RB5qV7YfA2Cfb7wDBHu8GuIKJIN4ObfYuMtGm
         wHrcS6QEL6E62FcC69vnga/S0aE/b/qKfDP+R2WPFUyfZYYiMxWwVS9ijl63S/ArikBk
         Q1S5eoR7Lqjx5pbNHzb69iokOtUB/NVhZIpLboRq84aN3oz5i11pNEyhLOZG3TfHsv9X
         +PKfBzwwU70sDh45fCJGG3jw29X/LoPxKDK97gFfRTuFHa4UcMKgsZX2PDN8u7NogtWQ
         xN7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VGYk8110mxEIfZb97hjNSOmSSAM9U3Ysh5enZGGhhu8=;
        b=JhJlhoyd1DY49Gxt9nVNLosZkEsRmJeuABJyjW5om6Zk+XOGjbnWFv3ABogJp++zzx
         cZuaX9TAYnRIzwvfqRH+CNEx/XGe84veFTELTaFcPSkq+xGTcnzE5/dd9FNYNv6deFx5
         RWl9SjtfTjtS6SVCJ8NdPriisj7j+1S2ZUK6xHoSwlRoDKMrg69PwIgm/rAVt4xSEeOO
         PQxIVcqQt+sJsGBV7bq3WF8+tT9w6FKUJzqZCITvlydGT67Uf/Ft2LucebC76YoxI3gd
         zjndsQ9AGm9JfnDnjc2GwHZEZL7GecaY0kmp5J34bIS+nc2fnlDIQK068H+/KESKtPEC
         oq9g==
X-Gm-Message-State: AOAM530oRu8jGhqlVpAPAOt4T2hz4Drng8Q+xmOEQU/GeKHDT9XZa7XB
        DGGBwXtIO45aqx0b7bBEiqcxkFUg0KUIEgL8tTOPZw==
X-Google-Smtp-Source: ABdhPJwPczS+6WCYnnhcITlCGDk3THAAaV4Jc7NXiOhLRFH1Y2B7Em3vO9MiZ6aLM2JmJGpm22pOvfhVqCZ16YWK0xQ=
X-Received: by 2002:a25:e749:0:b0:633:93d4:4b66 with SMTP id
 e70-20020a25e749000000b0063393d44b66mr7378064ybh.553.1647558262082; Thu, 17
 Mar 2022 16:04:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220225012819.1807147-1-surenb@google.com> <YiY7K4ftAI3t6km8@dhcp22.suse.cz>
 <CAJuCfpEt6V+v_FcLsYWpGLA1vwCK01vv0PqNernfKM2GTzNqKg@mail.gmail.com>
In-Reply-To: <CAJuCfpEt6V+v_FcLsYWpGLA1vwCK01vv0PqNernfKM2GTzNqKg@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 17 Mar 2022 16:04:11 -0700
Message-ID: <CAJuCfpHgTb5Uvd7yfwSHnPx7gf2wXDfRa0U+XOwr=qHm+JJTNA@mail.gmail.com>
Subject: Re: [RFC 1/1] mm: page_alloc: replace mm_percpu_wq with kthreads in drain_all_pages
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Petr Mladek <pmladek@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Tim Murray <timmurray@google.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
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

On Mon, Mar 7, 2022 at 9:24 AM Suren Baghdasaryan <surenb@google.com> wrote:
>
> On Mon, Mar 7, 2022 at 9:04 AM 'Michal Hocko' via kernel-team
> <kernel-team@android.com> wrote:
> >
> > On Thu 24-02-22 17:28:19, Suren Baghdasaryan wrote:
> > > Sending as an RFC to confirm if this is the right direction and to
> > > clarify if other tasks currently executed on mm_percpu_wq should be
> > > also moved to kthreads. The patch seems stable in testing but I want
> > > to collect more performance data before submitting a non-RFC version.
> > >
> > >
> > > Currently drain_all_pages uses mm_percpu_wq to drain pages from pcp
> > > list during direct reclaim. The tasks on a workqueue can be delayed
> > > by other tasks in the workqueues using the same per-cpu worker pool.
> > > This results in sizable delays in drain_all_pages when cpus are highly
> > > contended.
> >
> > This is not about cpus being highly contended. It is about too much work
> > on the WQ context.
>
> Ack.
>
> >
> > > Memory management operations designed to relieve memory pressure should
> > > not be allowed to block by other tasks, especially if the task in direct
> > > reclaim has higher priority than the blocking tasks.
> >
> > Agreed here.
> >
> > > Replace the usage of mm_percpu_wq with per-cpu low priority FIFO
> > > kthreads to execute draining tasks.
> >
> > This looks like a natural thing to do when WQ context is not suitable
> > but I am not sure the additional resources is really justified. Large
> > machines with a lot of cpus would create a lot of kernel threads. Can we
> > do better than that?
> >
> > Would it be possible to have fewer workers (e.g. 1 or one per numa node)
> > and it would perform the work on a dedicated cpu by changing its
> > affinity? Or would that introduce an unacceptable overhead?
>
> Not sure but I can try implementing per-node kthreads and measure the
> performance of the reclaim path, comparing with the current and with
> per-cpu approach.

Just to update on this RFC. In my testing I don't see a meaningful
improvement from using the kthreads yet. This might be due to my test
setup, so I'll keep exploring. Will post the next version only if I
get demonstrable improvements.
Thanks!

>
> >
> > Or would it be possible to update the existing WQ code to use rescuer
> > well before the WQ is completely clogged?
> > --
> > Michal Hocko
> > SUSE Labs
> >
> > --
> > To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
> >
