Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41F0F4B7EC9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 04:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344264AbiBPDWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 22:22:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344256AbiBPDWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 22:22:31 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F976674ED
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 19:22:17 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id w7so822321ioj.5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 19:22:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pC+CQP5X8/WBY/xYLNskVxmp5h3d1UBhUppWThc6zcU=;
        b=JjHYxwuhg8eU+0FsJ4cbBFmZCmqA53fU2f9F6kotYxiXToxiJUNSyjfwP83rdcpdSm
         47XXk41juhHZsyak1Pw53y932BX59s9FRfGUrsDZQwRVB3yxsxbDKyNjewbCuyNlFC3u
         czn1vbpNWkprv7EoRa7tckSkUURyKh01lzbIKhhS834iGgl1H/GGbRBjy9mjbQES+WoL
         Pd+PqDlOVy26h96FYWL83RXtPX9h8pSJp8twZ97itYQY/w+SWQqSDB4ebt3MZg7FfQbZ
         faEXPMmdiaVL9LJc4+CQ7p0DEnu4+DZ1VYR/vctO4rXPhcjLVNso8NhzFblg7BasRd1Z
         COOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pC+CQP5X8/WBY/xYLNskVxmp5h3d1UBhUppWThc6zcU=;
        b=SfORk0ItcMYZWFKl+jFQmDTZuMV+BDb7ViflGLuV6KY1s0AzX/g0Xdfv65Y3/qumRX
         X8pv6CDp/4KAJjP5iMBfckVt1GOxdIaqkvfJD0oq2DZvnoEWGTKyzcZvKucr0g8dJVKL
         Og6AoxKHG+ZX32Wq3YvMEQ9+ocevKqjY/hhN8JK2NI+O8j94+WFrlDFH7UNGDne5PNcU
         lXtckDrEzi/bl75A2A4PTv44F8I6fkwoy5Akm1nzVGR6XEwRvpzStnggxeQT55QJwAbs
         eS5p2JssPo8gTCJ61wzjtAZO/nqBs+8Qd0JiBBqY47jxU8ewHyEBLy5fN5WA+/tuOc6M
         PehQ==
X-Gm-Message-State: AOAM531WUK/T1OCse0LwOoQsSyaeJt/w3YWR3unjjVKOEOE0SAsYojqg
        wSASN4HnICIuVDKwl6JmecpgWQ==
X-Google-Smtp-Source: ABdhPJy5rdhqytpZ3v2zTdrmze3vfJ5giIn3PmnJT8l9HA15NYywXtFHUxaBc+uTT+/oN6duu62B6g==
X-Received: by 2002:a05:6638:379b:b0:310:bb27:6c28 with SMTP id w27-20020a056638379b00b00310bb276c28mr470358jal.71.1644981736174;
        Tue, 15 Feb 2022 19:22:16 -0800 (PST)
Received: from google.com ([2620:15c:183:200:5929:5114:bf56:ccb6])
        by smtp.gmail.com with ESMTPSA id u15sm7547237ill.75.2022.02.15.19.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 19:22:15 -0800 (PST)
Date:   Tue, 15 Feb 2022 20:22:10 -0700
From:   Yu Zhao <yuzhao@google.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Barry Song <21cnbao@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Jesse Barnes <jsbarnes@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Larabel <Michael@michaellarabel.com>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Ying Huang <ying.huang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        page-reclaim@google.com, x86@kernel.org,
        Brian Geffon <bgeffon@google.com>,
        Jan Alexander Steffens <heftig@archlinux.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Steven Barrett <steven@liquorix.net>,
        Suleiman Souhlal <suleiman@google.com>,
        Daniel Byrne <djbyrne@mtu.edu>,
        Donald Carr <d@chaos-reins.com>,
        Holger =?iso-8859-1?Q?Hoffst=E4tte?= 
        <holger@applied-asynchrony.com>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>,
        Shuang Zhai <szhai2@cs.rochester.edu>,
        Sofia Trinh <sofia.trinh@edi.works>
Subject: Re: [PATCH v7 12/12] mm: multigenerational LRU: documentation
Message-ID: <Ygxt4iR9ZMYEbV78@google.com>
References: <20220208081902.3550911-1-yuzhao@google.com>
 <20220208081902.3550911-13-yuzhao@google.com>
 <Ygou6Gq79XY3mFK7@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ygou6Gq79XY3mFK7@kernel.org>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2022 at 12:28:56PM +0200, Mike Rapoport wrote:

Thanks for reviewing.

> >  Documentation/admin-guide/mm/index.rst        |   1 +
> >  Documentation/admin-guide/mm/multigen_lru.rst | 121 ++++++++++++++
> >  Documentation/vm/index.rst                    |   1 +
> >  Documentation/vm/multigen_lru.rst             | 152 ++++++++++++++++++
> 
> Please consider splitting this patch into Documentation/admin-guide and
> Documentation/vm parts.

Will do.

> > +=====================
> > +Multigenerational LRU
> > +=====================
> +
> > +Quick start
> > +===========
> 
> There is no explanation why one would want to use multigenerational LRU
> until the next section.
> 
> I think there should be an overview that explains why users would want to
> enable multigenerational LRU. 

Will do.

> > +Build configurations
> > +--------------------
> > +:Required: Set ``CONFIG_LRU_GEN=y``.
> 
> Maybe 
> 
> 	Set ``CONFIG_LRU_GEN=y`` to build kernel with multigenerational LRU

Will do.

> > +:Optional: Set ``CONFIG_LRU_GEN_ENABLED=y`` to enable the
> > + multigenerational LRU by default.
> > +
> > +Runtime configurations
> > +----------------------
> > +:Required: Write ``y`` to ``/sys/kernel/mm/lru_gen/enable`` if
> > + ``CONFIG_LRU_GEN_ENABLED=n``.
> > +
> > +This file accepts different values to enabled or disabled the
> > +following features:
> 
> Maybe
> 
>   After multigenerational LRU is enabled, this file accepts different
>   values to enable or disable the following feaures:

Will do.

> > +====== ========
> > +Values Features
> > +====== ========
> > +0x0001 the multigenerational LRU
> 
> The multigenerational LRU what?

Itself? This depends on the POV, and I'm trying to determine what would
be the natural way to present it.

MGLRU itself could be seen as an add-on atop the existing page reclaim
or an alternative in parallel. The latter would be similar to sl[aou]b,
and that's how I personally see it.

But here I presented it more like the former because I feel this way is
more natural to users because they are like switches on a single panel.

> What will happen if I write 0x2 to this file?

Just like turning on a branch breaker while leaving the main breaker
off in a circuit breaker box. This is how I see it, and I'm totally
fine with changing it to whatever you'd recommend.

> Please consider splitting "enable" and "features" attributes.

How about s/Features/Components/?

> > +0x0002 clear the accessed bit in leaf page table entries **in large
> > +       batches**, when MMU sets it (e.g., on x86)
> 
> Is extra markup really needed here...
> 
> > +0x0004 clear the accessed bit in non-leaf page table entries **as
> > +       well**, when MMU sets it (e.g., on x86)
> 
> ... and here?

Will do.

> As for the descriptions, what is the user-visible effect of these features?
> How different modes of clearing the access bit are reflected in, say, GUI
> responsiveness, database TPS, or probability of OOM?

These remain to be seen :) I just added these switches in v7, per Mel's
request from the meeting we had. These were never tested in the field.

> > +[yYnN] apply to all the features above
> > +====== ========
> > +
> > +E.g.,
> > +::
> > +
> > +    echo y >/sys/kernel/mm/lru_gen/enabled
> > +    cat /sys/kernel/mm/lru_gen/enabled
> > +    0x0007
> > +    echo 5 >/sys/kernel/mm/lru_gen/enabled
> > +    cat /sys/kernel/mm/lru_gen/enabled
> > +    0x0005
> > +
> > +Most users should enable or disable all the features unless some of
> > +them have unforeseen side effects.
> > +
> > +Recipes
> > +=======
> > +Personal computers
> > +------------------
> > +Personal computers are more sensitive to thrashing because it can
> > +cause janks (lags when rendering UI) and negatively impact user
> > +experience. The multigenerational LRU offers thrashing prevention to
> > +the majority of laptop and desktop users who don't have oomd.
> 
> I'd expect something like this paragraph in overview.
> 
> > +
> > +:Thrashing prevention: Write ``N`` to
> > + ``/sys/kernel/mm/lru_gen/min_ttl_ms`` to prevent the working set of
> > + ``N`` milliseconds from getting evicted. The OOM killer is triggered
> > + if this working set can't be kept in memory. Based on the average
> > + human detectable lag (~100ms), ``N=1000`` usually eliminates
> > + intolerable janks due to thrashing. Larger values like ``N=3000``
> > + make janks less noticeable at the risk of premature OOM kills.
> 
> > +
> > +Data centers
> > +------------
> > +Data centers want to optimize job scheduling (bin packing) to improve
> > +memory utilizations. Job schedulers need to estimate whether a server
> > +can allocate a certain amount of memory for a new job, and this step
> > +is known as working set estimation, which doesn't impact the existing
> > +jobs running on this server. They also want to attempt freeing some
> > +cold memory from the existing jobs, and this step is known as proactive
> > +reclaim, which improves the chance of landing a new job successfully.
> 
> This paragraph also fits overview.

Will do.

> > +:Optional: Increase ``CONFIG_NR_LRU_GENS`` to support more generations
> > + for working set estimation and proactive reclaim.
> 
> Please add a note that this is build time option.

Will do.

> > +:Debugfs interface: ``/sys/kernel/debug/lru_gen`` has the following
> 
> Is debugfs interface relevant only for datacenters? 

For the moment, yes.

> > + format:
> > + ::
> > +
> > +   memcg  memcg_id  memcg_path
> > +     node  node_id
> > +       min_gen  birth_time  anon_size  file_size
> > +       ...
> > +       max_gen  birth_time  anon_size  file_size
> > +
> > + ``min_gen`` is the oldest generation number and ``max_gen`` is the
> > + youngest generation number. ``birth_time`` is in milliseconds.
> 
> It's unclear what is birth_time reference point. Is it milliseconds from
> the system start or it is measured some other way?

Good point. Will clarify.

> > + ``anon_size`` and ``file_size`` are in pages. The youngest generation
> > + represents the group of the MRU pages and the oldest generation
> > + represents the group of the LRU pages. For working set estimation, a
> 
> Please spell out MRU and LRU fully.

Will do.

> > + job scheduler writes to this file at a certain time interval to
> > + create new generations, and it ranks available servers based on the
> > + sizes of their cold memory defined by this time interval. For
> > + proactive reclaim, a job scheduler writes to this file before it
> > + tries to land a new job, and if it fails to materialize the cold
> > + memory without impacting the existing jobs, it retries on the next
> > + server according to the ranking result.
> 
> Is this knob only relevant for a job scheduler? Or it can be used in other
> use-cases as well?

There are other concrete use cases but I'm not ready to discuss them
yet.

> > + This file accepts commands in the following subsections. Multiple
> 
>                               ^ described

Will do.
