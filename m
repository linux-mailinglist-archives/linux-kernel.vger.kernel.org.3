Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A61E74D0481
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 17:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244281AbiCGQuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 11:50:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232809AbiCGQt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 11:49:59 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF4B220ED
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 08:49:05 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id f38so32226731ybi.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 08:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wOaEmSLT8Hs8VbykY7UZSpJotv9MXZiDNybb91mB0/A=;
        b=tkjRQRTQjIx8Brz4GulR3BnbRaCpEJmULkorenyHZmon6Eu1SEIeV38HFh3LGAKi5+
         juJvYGVmuC/0a/kntYr1BjDzZKQ10Fr+ESwqmkd++wkKI77bD3c1ztQHm5t3GU0p/1/c
         Z3V+RGoyxvJxXbxDygUsntM2raFKNCS1/cryvUkXbqPJ3zfEOCGiQT9zGoSbV6BSKMod
         14Q5rea9Q+Ju2Xgm0RPTicufRonSNumVfaIjKCO+52jYo/ZtHPIj/pZ+q2fDw1qrtbUP
         yrIabyYVpPfMdBbMp8IhTAMwylN6tujsMC/Xixdt4uh0aAu5uTBw5aWWG5pV7TdXZgua
         hvoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wOaEmSLT8Hs8VbykY7UZSpJotv9MXZiDNybb91mB0/A=;
        b=307LH/sLN6j2oVtUYSuln4fyZNu1aYWAiMRHCDu+YUYldh286hhp504LbBbF+cIr4o
         stMsD8dtAL+xbfS/ns7ng9OuEyzkvGQiglBAj07LnEdgjVDi8e6Y6cA1DyWp2f06G48m
         7wQiu8YgmLeINof1tSqfCHYh4p8RMxATk9YGrHNvx84DdBZ0sW8rsL7VkLME8+1PahTC
         vrQNw2nrKBR3cHONy0PYp73PW20s/mQ58dXCWtQtGxHzOUpUGeKkDpqS2Xqg2d5gV3dz
         753uuA3TKJGLVl4cL94cuqOCtISpwikknNfGOm24e0Yn84WtkzfCc38vmsTORd24JwdU
         lRAQ==
X-Gm-Message-State: AOAM531d+Xbi270DctVlIkWCmjOHYZw/jG263FQlkBiYoaZDU0c5nAJx
        sMwitZ5x3qnf5+8ecaqxdhsPuoS+OMJ6DEvnFAHX0w==
X-Google-Smtp-Source: ABdhPJxz/CwlVLg/63PDH3wr31b34EO7lwt0G6vNhxIH2XU6AVZ/PzAYFFsFGdG+2+FCNpMRQGhrpokwxBOtzZfCbNQ=
X-Received: by 2002:a25:1906:0:b0:61d:9576:754e with SMTP id
 6-20020a251906000000b0061d9576754emr8661270ybz.426.1646671744163; Mon, 07 Mar
 2022 08:49:04 -0800 (PST)
MIME-Version: 1.0
References: <20220225012819.1807147-1-surenb@google.com> <20220302002150.2113-1-hdanton@sina.com>
 <CAJuCfpG3TRgs8fA5kpkhrFRcDF=C9VyqLTCz42sxOyKZ0pRaNQ@mail.gmail.com> <YiY0Zf9XH/m/IqcR@alley>
In-Reply-To: <YiY0Zf9XH/m/IqcR@alley>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 7 Mar 2022 08:48:53 -0800
Message-ID: <CAJuCfpGU3uimENmBP=J8OrfxCrFQtOsPMqU_JD5DyW46aW1M2g@mail.gmail.com>
Subject: Re: [RFC 1/1] mm: page_alloc: replace mm_percpu_wq with kthreads in drain_all_pages
To:     Petr Mladek <pmladek@suse.com>
Cc:     Hillf Danton <hdanton@sina.com>, linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@suse.com>,
        Tim Murray <timmurray@google.com>,
        Minchan Kim <minchan@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>
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

On Mon, Mar 7, 2022 at 8:35 AM Petr Mladek <pmladek@suse.com> wrote:
>
> On Wed 2022-03-02 15:06:24, Suren Baghdasaryan wrote:
> > On Tue, Mar 1, 2022 at 4:22 PM Hillf Danton <hdanton@sina.com> wrote:
> > >
> > > On Thu, 24 Feb 2022 17:28:19 -0800 Suren Baghdasaryan wrote:
> > > > Sending as an RFC to confirm if this is the right direction and to
> > > > clarify if other tasks currently executed on mm_percpu_wq should be
> > > > also moved to kthreads. The patch seems stable in testing but I want
> > > > to collect more performance data before submitting a non-RFC version.
> > > >
> > > >
> > > > Currently drain_all_pages uses mm_percpu_wq to drain pages from pcp
> > > > list during direct reclaim. The tasks on a workqueue can be delayed
> > > > by other tasks in the workqueues using the same per-cpu worker pool.
> > >
> > > The pending works may be freeing a couple of slabs/pages each. Who knows?
> >
> > If we are talking about work specifically scheduled on mm_percpu_wq
> > then apart from drain_all_pages, mm_percpu_wq is used to execute
> > vmstat_update and lru_add_drain_cpu for drainig pagevecs. If OTOH what
> > you mean is that the work might be blocked by say kswapd, which is
> > freeing memory, then sure, who knows...
>
> Note that the same worker pool is used by many workqueues. And
> work items in per-cpu workqueues are serialized on a single worker.
> Another worker is used only when a work goes into a sleeping wait.
>
> I want to say that "drain_all_pages" are not blocked only by other
> works using "mm_percpu_wq" but also by works from many other
> workqueues, including "system_wq".
>
> These works might do anything, including memory allocation, freeing.

Ah, I didn't know this (I think you mentioned it in one of your
previous replies but I missed it). Thank you for clarifying!

>
> > >
> > > > This results in sizable delays in drain_all_pages when cpus are highly
> > > > contended.
> > > > Memory management operations designed to relieve memory pressure should
> > > > not be allowed to block by other tasks, especially if the task in direct
> > > > reclaim has higher priority than the blocking tasks.
> > >
> > > Wonder why priority is the right cure to tight memory - otherwise it was
> > > not a problem given a direct reclaimer of higher priority.
> > >
> > > Off topic question - why is it making sense from begining for a task of
> > > lower priority to peel pages off from another of higher priority if
> > > priority is considered in direct reclaim?
> >
> > The way I understood your question is that you are asking why we have
> > to use workqueues of potentially lower priority to drain pages for a
> > potentially higher priority process in direct reclaim (which is
> > blocked waiting for workqueues to complete draining)?
> > If so, IIUC this mechanism was introduced in
> > https://lore.kernel.org/all/20170117092954.15413-4-mgorman@techsingularity.net
> > to avoid draining from IPI context (CC'ing Mel Gorman to correct me if
> > I'm wrong).
> > I think the issue here is that in the process we are losing
> > information about the priority of the process in direct reclaim, which
> > might lead to priority inversion.
>
> Note that priority of workqueue workers is static. It is defined
> by the workqueue parameters.
>
> kthread_worker API allows to create custom kthreads. The user could
> modify the priority as needed. It allows to prevent priority
> inversion. It can hardly be achieved by workques where the workers
> are heavily shared by unrelated tasks.

Yes but I suspect we would not want to dynamically change the priority
of the kthreads performing drain_all_pages? I guess we could adjust it
based on the highest priority among the tasks waiting for
drain_all_pages and that would eliminate priority inversion. However
I'm not sure about the possible overhead associated with such dynamic
priority adjustments.
My RFC sets up the kthreads to be low priority FIFO threads. It's a
simplification and I'm not sure that is the right approach here...

>
> Best Regards,
> Petr
