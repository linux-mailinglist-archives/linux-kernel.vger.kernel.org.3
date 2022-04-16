Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96A46503306
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 07:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbiDPC0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 22:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiDPCZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 22:25:52 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 630B048388
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 19:23:20 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id z139so2884684vsz.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 19:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wQoyQFv+DR+j7fh3LRsGpz2vueHCeVQWzUanchbUatQ=;
        b=YfZhReGfuSfjixzN1iUSULLfspq+EGZIgRMn8VXbc68flA1D/N7dwBKQfs/xC0p5yg
         BgGmeJmziqzKEfW2f1qWhonkGaD4X++4IDEbom7B23DXnAGvBARF+Hx0L+xcXhRHLRUQ
         E6VC2+zFnZz9n1JvcpvskO2IDJMJD8shaQWPMhW8VnmThGBVZAo1yNVFeDPkiqGVqiHQ
         tNa96/gupiv5vdSM+D15htH5OWPQEmvn0NPsCokDJTlI+27gB3/z8nc1SMaLpgGODnhN
         VkY4dGw5Y1CR15/Z2dpvvseYqGD2OtOCAFGP1+oF3mAmZWSjWmZAlhNrNJJ4KBegHTbq
         AumQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wQoyQFv+DR+j7fh3LRsGpz2vueHCeVQWzUanchbUatQ=;
        b=T+zqxSJtUqnA3GB4Vqyt2vBrJS5US1xDKMkovVvQTeGLLeDO8/uPk+OlD++zUqHMu5
         W6A6/+lq/TNu3z5uiq1bTljebPvgeELXqXlm07Cm+3SOrR5uz/Ocvburw9gTp2OXoS9F
         CsjmpDOmGlhndChJT47H9pwgTjZILQDZj94O2wy8Rcf+Herbpry6RAQprqSSq4ASDgYT
         K45mN9nR6lchsnXrskK0jhXhqpNqFhI3cRN36o2Yf5FuFclLJXpCEbRnj6xXNCWUNBy8
         Fl0o4PTMKWs6Z6iga/3X89Pvst5Mkp2I4yZJhmBWkSh4cTTTYI6HG5pIlzCelTJAGUUY
         13Xg==
X-Gm-Message-State: AOAM5303FsnT8qCg/8p5LDbN2o4oxXKVYFCvisS6jBWur023VYrNlumE
        dmMRb5IyAmYJ0qYQgQssRahE2Ft15WLeADKXLf/Mcg==
X-Google-Smtp-Source: ABdhPJz2RupV69wuUiP6W5/87we/n4sQFTTip7chnuEWLhQ2xLI53Oru7ERzQVELUJpxwreO5H3ZWGtU1Fh+7xHkjc4=
X-Received: by 2002:a67:de17:0:b0:32a:4007:cd86 with SMTP id
 q23-20020a67de17000000b0032a4007cd86mr479002vsk.22.1650075799347; Fri, 15 Apr
 2022 19:23:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220407031525.2368067-1-yuzhao@google.com> <20220407031525.2368067-14-yuzhao@google.com>
 <20220411191639.52c62959489a6c27cb7d251e@linux-foundation.org>
In-Reply-To: <20220411191639.52c62959489a6c27cb7d251e@linux-foundation.org>
From:   Yu Zhao <yuzhao@google.com>
Date:   Fri, 15 Apr 2022 20:22:42 -0600
Message-ID: <CAOUHufacnY6zMzkMvgHD9_DAwDcnpq7a9YdYT3SKUV8dAi=Fmw@mail.gmail.com>
Subject: Re: [PATCH v10 13/14] mm: multi-gen LRU: admin guide
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Stephen Rothwell <sfr@rothwell.id.au>,
        Linux-MM <linux-mm@kvack.org>, Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Barry Song <21cnbao@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Jesse Barnes <jsbarnes@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Ying Huang <ying.huang@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Page Reclaim v2 <page-reclaim@google.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Brian Geffon <bgeffon@google.com>,
        Jan Alexander Steffens <heftig@archlinux.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Steven Barrett <steven@liquorix.net>,
        Suleiman Souhlal <suleiman@google.com>,
        Daniel Byrne <djbyrne@mtu.edu>,
        Donald Carr <d@chaos-reins.com>,
        =?UTF-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>,
        Shuang Zhai <szhai2@cs.rochester.edu>,
        Sofia Trinh <sofia.trinh@edi.works>,
        Vaibhav Jain <vaibhav@linux.ibm.com>
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

On Mon, Apr 11, 2022 at 8:16 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Wed,  6 Apr 2022 21:15:25 -0600 Yu Zhao <yuzhao@google.com> wrote:
>
> > +Kill switch
> > +-----------
> > +``enable`` accepts different values to enable or disable the following
>
> It's actually called "enabled".

Good catch. Thanks!

> And I suggest that the file name be
> included right there in the title.  ie.
>
> "enabled": Kill Switch
> ======================

Will do.

> > +Experimental features
> > +=====================
> > +``/sys/kernel/debug/lru_gen`` accepts commands described in the
> > +following subsections. Multiple command lines are supported, so does
> > +concatenation with delimiters ``,`` and ``;``.
> > +
> > +``/sys/kernel/debug/lru_gen_full`` provides additional stats for
> > +debugging. ``CONFIG_LRU_GEN_STATS=y`` keeps historical stats from
> > +evicted generations in this file.
> > +
> > +Working set estimation
> > +----------------------
> > +Working set estimation measures how much memory an application
> > +requires in a given time interval, and it is usually done with little
> > +impact on the performance of the application. E.g., data centers want
> > +to optimize job scheduling (bin packing) to improve memory
> > +utilizations. When a new job comes in, the job scheduler needs to find
> > +out whether each server it manages can allocate a certain amount of
> > +memory for this new job before it can pick a candidate. To do so, this
> > +job scheduler needs to estimate the working sets of the existing jobs.
>
> These various sysfs interfaces are a big deal.  Because they are so
> hard to change once released.

Debugfs, not sysfs. The title is "Experimental features" :)

> btw, what is this "job scheduler" of which you speak?

Basically it's part of cluster management software. Many jobs
(programs + data) can run concurrently in the same cluster and the job
scheduler of this cluster does the bin packing. To improve resource
utilization, the job scheduler needs to know the (memory) size of each
job it packs, hence the working set estimation (how much memory a job
uses within a given time interval). The job scheduler also takes
memory from some jobs so that those jobs can better fit into a single
machine (proactive reclaim).

> Is there an open
> source implementation upon which we hope the world will converge?

There are many [1], e.g., Kubernetes (k8s). Personally, I don't think
they'll ever converge.

At the moment, all open source implementations I know of rely on users
manually specifying the size of each job (job spec), e.g., [2]. Users
overprovision memory to avoid OOM kills. The average memory
utilization generally is surprisingly low. What we can hope for is
that eventually some of the open source implementations will use the
working set estimation and proactive reclaim features provided here.

[1] https://en.wikipedia.org/wiki/List_of_cluster_management_software
[2] https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/

> > +Proactive reclaim
> > +-----------------
> > +Proactive reclaim induces memory reclaim when there is no memory
> > +pressure and usually targets cold memory only. E.g., when a new job
> > +comes in, the job scheduler wants to proactively reclaim memory on the
> > +server it has selected to improve the chance of successfully landing
> > +this new job.
> > +
> > +Users can write ``- memcg_id node_id min_gen_nr [swappiness
> > +[nr_to_reclaim]]`` to ``lru_gen`` to evict generations less than or
> > +equal to ``min_gen_nr``. Note that ``min_gen_nr`` should be less than
> > +``max_gen_nr-1`` as ``max_gen_nr`` and ``max_gen_nr-1`` are not fully
> > +aged and therefore cannot be evicted. ``swappiness`` overrides the
> > +default value in ``/proc/sys/vm/swappiness``. ``nr_to_reclaim`` limits
> > +the number of pages to evict.
> > +
> > +A typical use case is that a job scheduler writes to ``lru_gen``
> > +before it tries to land a new job on a server, and if it fails to
> > +materialize the cold memory without impacting the existing jobs on
> > +this server, it retries on the next server according to the ranking
> > +result obtained from the working set estimation step described
> > +earlier.
>
> It sounds to me that these interfaces were developed in response to
> ongoing development and use of a particular job scheduler.

I did borrow some of my previous experience with Google's data
centers. But I'm a Chrome OS developer now, so I designed them to be
job scheduler agnostic :)

> This is a very good thing, but has thought been given to the potential
> needs of other job schedulers?

Yes, basically I'm trying to help everybody replicate the success
stories at Google and Meta [3][4].

[3] https://dl.acm.org/doi/10.1145/3297858.3304053
[4] https://dl.acm.org/doi/10.1145/3503222.3507731
