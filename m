Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A02264E3A54
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 09:14:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbiCVIPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 04:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbiCVIPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 04:15:44 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B68833A13
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 01:14:17 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id 2so10265213vse.4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 01:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ejYqrEpcN+YIapqTaek6UuldGWcXdxvGA3dM/VeJRBw=;
        b=BUFmL4heEnQlaoWLUylgiBVgyrJVVkojiCMeAXJFkN+klvf/L4GwYq1ryCISPtRUGS
         si+JBR7yCvBp7J4j0vIyULINRl51j4D2xaSkm1tVlpAqr9ogkF+C20iqQWzgRJKDf6xi
         1M1mqaHI6o7a5+6Yz7jK1F1rJL5JiJwjft7xaB1CBGWFhb62E9R6oyLDzXkkzC3kDjcn
         ZRn5V0IZBgmPnaC5K5gxyqsWjQoKO32xo7oY4B415L1eK0tIF9nzSwNhbzEasO4BBShX
         VTjugLCAiW2YsPV+ybWh1e1Uw+wun1LOiGG/FxAAD80r/3EsiSoGEhgcnIbXMnNCJNGK
         M2eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ejYqrEpcN+YIapqTaek6UuldGWcXdxvGA3dM/VeJRBw=;
        b=R8CmRJpVsPDkgP327aYi/JqbCBZqjP4Tp2dlVmswHrN3PwhEn9fDXQkyXXK9rpyYu0
         rfJP9eASxMx1Lk0M/pFnxjsY4bdJoPcAZmda7eJdUZvilJDOKXdP6vLAXSLQceQU0i/q
         UyY0lBYylt9/iesCeprXX7/dSRRlCGDRXy/XJRkRSnr2hVUR1lnQN5BMAhoKaxKvlWbs
         HTpfdJZQ7sgHUDTkiSg6BeCiwGHQkUb1QoXG7eSph1Qp8+AU4bquNLl0aFBh9+IjhTCF
         4Xejg+2K1VCotvKwYidqjxuh4uRcT8GqYVkSxv1TIWUJ8G1gthwYQ3LYsID+5v1Vf8hn
         HMsw==
X-Gm-Message-State: AOAM533Ehm19ErIHCLaqxtN52aeSI87jomSF9ZgYnClg5rCFnvmflQ/h
        10nZdjn021YzPk1kW+h+U8J8JYOFeRoeNoCgCnvXqA==
X-Google-Smtp-Source: ABdhPJyS4rjE3E91EMtptKGTaCGpsQomyOoF1sxK53qyi6zy6Jm6Br78Kyg19z+h1BvSAwQv9ZiyDuNmYhVUsBl/EOw=
X-Received: by 2002:a67:f956:0:b0:324:eb38:52fb with SMTP id
 u22-20020a67f956000000b00324eb3852fbmr5339929vsq.22.1647936855962; Tue, 22
 Mar 2022 01:14:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220309021230.721028-1-yuzhao@google.com> <20220309021230.721028-12-yuzhao@google.com>
 <CAGsJ_4wMrUnRzdM_qssRtm=bb3oY08=DkZoiuxMt1PezxR4HWQ@mail.gmail.com>
In-Reply-To: <CAGsJ_4wMrUnRzdM_qssRtm=bb3oY08=DkZoiuxMt1PezxR4HWQ@mail.gmail.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Tue, 22 Mar 2022 02:14:04 -0600
Message-ID: <CAOUHufb1eDugu9Jgb4rn+nZfy5hchOqmaTSBhsuqqOTxp9YQmw@mail.gmail.com>
Subject: Re: [PATCH v9 11/14] mm: multi-gen LRU: thrashing prevention
To:     Barry Song <21cnbao@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Jesse Barnes <jsbarnes@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Ying Huang <ying.huang@intel.com>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Kernel Page Reclaim v2 <page-reclaim@google.com>,
        x86 <x86@kernel.org>, Brian Geffon <bgeffon@google.com>,
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 1:23 AM Barry Song <21cnbao@gmail.com> wrote:
>
> On Wed, Mar 9, 2022 at 3:48 PM Yu Zhao <yuzhao@google.com> wrote:
> >
> > Add /sys/kernel/mm/lru_gen/min_ttl_ms for thrashing prevention, as
> > requested by many desktop users [1].
> >
> > When set to value N, it prevents the working set of N milliseconds
> > from getting evicted. The OOM killer is triggered if this working set
> > cannot be kept in memory. Based on the average human detectable lag
> > (~100ms), N=1000 usually eliminates intolerable lags due to thrashing.
> > Larger values like N=3000 make lags less noticeable at the risk of
> > premature OOM kills.
> >
> > Compared with the size-based approach, e.g., [2], this time-based
> > approach has the following advantages:
> > 1. It is easier to configure because it is agnostic to applications
> >    and memory sizes.
> > 2. It is more reliable because it is directly wired to the OOM killer.
> >
>
> how are userspace oom daemons like android lmkd, systemd-oomd supposed
> to work with this time-based oom killer?
> only one of min_ttl_ms and userspace daemon should be enabled? or both
> should be enabled at the same time?

Generally we just need one. lmkd and oomd are more flexible but 1)
they need customizations 2) not all distros have them 3) they might be
stuck in direct reclaim as well.

The last remark is not just a theoretical problem:
a) we had many servers under extremely heavy (global) memory pressure,
that 200+ direct reclaimers on each CPU competed for resources and
userspace livelocked for 2 hours. Eventually hardware watchdogs kicked
in.
b) on Chromebooks we have something similar to lmkd, and we still
frequently observe crashes due to heavy memory pressure, meaning some
Chrome tabs were stuck in direct reclaim for 120 seconds
(hung_task_timeout_secs=120).
