Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D08FF4BEA79
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 20:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232678AbiBUTJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 14:09:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232658AbiBUTJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 14:09:43 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F79B1A80D
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 11:09:20 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id p19so36328317ybc.6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 11:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l8g4mPJl7yZGMKdsJ14ySAI3dRSwtq6Uc9uUcvHHcIM=;
        b=bKvDNDqCla7cG6jmlE79n26yt7VBFgTq07oPlomZLdsroY6TS5IGyuT/IcQ2ayfXTn
         Go9k1mSfIBy1hgtRK55S5L9TAkHBcRMnlmhTZvkbA5YdUYqKdFLHNgUkukVhZ50xiKPk
         rQtDph8c8NQB5ryJxa5ydXWfdE2QyknvArecnL8drb4HIiYysKDov4BXvWlcgptvX1uY
         oXWn5Wkogwgjf3FHS0RF5WbolDFy7Hard9j+gOvp1DnC+1uY8xb4nidGGKgOVChn9Cu1
         SUMjf6fTlgxLV5yNp+zCCH6LKDYGu6MCSypdlGGh0IZpJadSKQ6/Q3s3HSpAte8cTA62
         5faQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l8g4mPJl7yZGMKdsJ14ySAI3dRSwtq6Uc9uUcvHHcIM=;
        b=zHpAboPilEkGGXH7/CrRfJrRmHaZ6yqnAUumclSxkBwUVZOrMJNxulEPaTesj8l+nW
         6yqzbsWjMQMR5CIA27iwxKZQIaS0WiWU0MhgB81zOuuH/NRBTcCCfCdEGpu+6OTq9g1k
         yJTLt55NLKI9g2FLgbReDzxxr/fi2Z2Y/P45V/6MG07VXW6IG/hOopWVKKTmz38oIN5F
         rawdSqv+xHDOO+i4tvZ9O5cq5CmPboA9P0lf3WkpL+Kpc/99yf+tLjKG9zib9GhZ66YN
         5xfF2x/faC/yIf4uApkMZ4IxCeTmwUCzQv96sWk4zZuBQjG1sjKVoKLKNxub9qBqoc2B
         ezWw==
X-Gm-Message-State: AOAM532iXNWmOU2NyyYOdDqhJiE/DvdjKZojk/2RxXLgRibFju03+iu4
        RTsCyz1PZZdzTCWYGiYTODC8xmnSnPyJzpAVLoZO+A==
X-Google-Smtp-Source: ABdhPJzMmNojJwJ8uebXW/vVelS+B7jNWLNzMD4tT1J8g0Z4pCv5rF1XWL7oeDFC+y7XYdBvhRZNk/fY9WEEpiziI5o=
X-Received: by 2002:a25:1906:0:b0:61d:9576:754e with SMTP id
 6-20020a251906000000b0061d9576754emr19357895ybz.426.1645470558324; Mon, 21
 Feb 2022 11:09:18 -0800 (PST)
MIME-Version: 1.0
References: <20220219174940.2570901-1-surenb@google.com> <YhNTcM9XtqA1zUUi@dhcp22.suse.cz>
In-Reply-To: <YhNTcM9XtqA1zUUi@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 21 Feb 2022 11:09:07 -0800
Message-ID: <CAJuCfpE9KWdCczCjfT2zD4co4vxZ8SeMFU8nFQ2J1VBP5xubBw@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm: count time in drain_all_pages during direct
 reclaim as memory pressure
To:     Michal Hocko <mhocko@suse.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org,
        peterz@infradead.org, guro@fb.com, shakeelb@google.com,
        minchan@kernel.org, timmurray@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
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

On Mon, Feb 21, 2022 at 12:55 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Sat 19-02-22 09:49:40, Suren Baghdasaryan wrote:
> > When page allocation in direct reclaim path fails, the system will
> > make one attempt to shrink per-cpu page lists and free pages from
> > high alloc reserves. Draining per-cpu pages into buddy allocator can
> > be a very slow operation because it's done using workqueues and the
> > task in direct reclaim waits for all of them to finish before
> > proceeding. Currently this time is not accounted as psi memory stall.
> >
> > While testing mobile devices under extreme memory pressure, when
> > allocations are failing during direct reclaim, we notices that psi
> > events which would be expected in such conditions were not triggered.
> > After profiling these cases it was determined that the reason for
> > missing psi events was that a big chunk of time spent in direct
> > reclaim is not accounted as memory stall, therefore psi would not
> > reach the levels at which an event is generated. Further investigation
> > revealed that the bulk of that unaccounted time was spent inside
> > drain_all_pages call.
>
> It would be cool to have some numbers here.

A typical case I was able to record when drain_all_pages path gets activated:

__alloc_pages_slowpath took 44.644.613ns
    __perform_reclaim 751.668ns (1.7%)
    drain_all_pages took 43.887.167ns (98.3%)

PSI in this case records the time spent in __perform_reclaim but
ignores drain_all_pages, IOW it misses 98.3% of the time spent in
__alloc_pages_slowpath. Sure, normally it's not often that this path
is activated, but when it is, we miss reporting most of the stall.

>
> > Annotate drain_all_pages and unreserve_highatomic_pageblock during
> > page allocation failure in the direct reclaim path so that delays
> > caused by these calls are accounted as memory stall.
>
> If the draining is too slow and dependent on the current CPU/WQ
> contention then we should address that. The original intention was that
> having a dedicated WQ with WQ_MEM_RECLAIM would help to isolate the
> operation from the rest of WQ activity. Maybe we need to fine tune
> mm_percpu_wq. If that doesn't help then we should revise the WQ model
> and use something else. Memory reclaim shouldn't really get stuck behind
> other unrelated work.

Agree. However even after improving this I think we should record the
time spent in drain_all_pages as psi memstall. So, this patch I
believe is still relevant.
Thanks,
Suren.

> --
> Michal Hocko
> SUSE Labs
