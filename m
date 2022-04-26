Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D146510BDF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 00:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355854AbiDZWT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 18:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355713AbiDZWTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 18:19:34 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B2D443CE
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 15:16:05 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id j16so139148vsv.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 15:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6zGXmfev2fZGrOwPRRRskiATCBJI4+jYm998S3ATC8Q=;
        b=SspT/Gc1YeBYxd3CDjgccU2KIlthHvbpi3ELpC1/z6AtxsRSGcDqwaIGXTajqWv35R
         U60ZsfoDh1/7M4TIEPZB6asL2txtS5ml4OIggIpTnfg+6k72xgPyg8qlqtC3uIn63Sc/
         4YzjlF0Z54wBRglXo5yjakB8gPaoRQFvWL76oA5kdOQJ+eVZg2eGyFwCrwCvW2yJZD1b
         IPYK9K59RGTw+qyLe8gQvRFAcHt47psGBWruCznn4BB9YGpIVHNQ886qej50GZAN/4Ly
         na8F3eaEjgkDsk2VBWT/Oggkhho04df+tjjUZCswqQ/sqs0022L0tNQmX8FdAAINcDF+
         Yhrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6zGXmfev2fZGrOwPRRRskiATCBJI4+jYm998S3ATC8Q=;
        b=b7XJLq39BhOaFBzOVdvGXC4Ve3UgIYettfz7N196Abso7xCTX+LkUUnbpj2BwyzbuO
         mYX+nbWhCdR5kc6hiy9/5HJBEBcDItn0yv5AthkyPFMYAXNxqqtGd16FKgd0aIb+lGOY
         XbpHeGeYF4vfjoN4V4EQMta7ENxqomcxSE/hWkPgmAuUDWICP5jjJg7YDzO/cBYsMRpB
         VArg1+VNQ6u1s39RbZnqngG39DNLxAnKTkvyJ2Vs+eAfg5yVoEa0naSF9B6iPCGte6Cn
         KN6yevMrpYDaRM91Zka9GPhZMPruBWZm6EPy6byHenAKcFL29W0XLt8Usc/ziLYDMLXE
         chvA==
X-Gm-Message-State: AOAM531y7RKEBTrHE1usCUhX6nssQto17/YjFP/IXT3UiIp7KyR040/+
        kUElzHBJWaVhBvr36K3kyqRmzgYX64AkRCTvbpJpxQ==
X-Google-Smtp-Source: ABdhPJwtXIjGlv7qMVkp8DMl5ITZo9rPEtcBPeYIWRka13ZludUdH/JfX3XZPzMGGhjISchzL8DHf+KslyvYgkO1+v8=
X-Received: by 2002:a67:cfc5:0:b0:32c:d143:d8e9 with SMTP id
 h5-20020a67cfc5000000b0032cd143d8e9mr3404761vsm.22.1651011363983; Tue, 26 Apr
 2022 15:16:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220407031525.2368067-1-yuzhao@google.com> <20220407031525.2368067-13-yuzhao@google.com>
 <20220411191634.674554d3de2ba37b3db40ca2@linux-foundation.org>
 <CAOUHufYhhCPFqoRbtn+=OFxZxNWS9yxW9Re_s-2TYGqCEaMXVw@mail.gmail.com>
 <20220415212024.c682ac000e3e91572d8d6d2b@linux-foundation.org>
 <CAOUHufa60CVZcXJ937=P4GVtV_Cn76mYCWwcyBNjMAADmyWEwQ@mail.gmail.com> <20220426143034.f520c062830f9e3405c890d0@linux-foundation.org>
In-Reply-To: <20220426143034.f520c062830f9e3405c890d0@linux-foundation.org>
From:   Yu Zhao <yuzhao@google.com>
Date:   Tue, 26 Apr 2022 16:15:26 -0600
Message-ID: <CAOUHufY1FmZGnAvpRYtTvXQ2cYTisxUauD0MzSXDesQ-T6GvQg@mail.gmail.com>
Subject: Re: [PATCH v10 12/14] mm: multi-gen LRU: debugfs interface
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
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 3:30 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Tue, 26 Apr 2022 00:59:37 -0600 Yu Zhao <yuzhao@google.com> wrote:
>
> > On Fri, Apr 15, 2022 at 10:20 PM Andrew Morton
> > <akpm@linux-foundation.org> wrote:
> > >
> > > On Fri, 15 Apr 2022 18:03:16 -0600 Yu Zhao <yuzhao@google.com> wrote:
> > >
> > > > > Presumably sysfs is the place.  Fully documented and with usage
> > > > > examples in the changelog so we can carefully review the proposed
> > > > > extensions to Linux's ABI.  Extensions which must be maintained
> > > > > unchanged for all time.
> > > >
> > > > Eventually, yes. There still is a long way to go. Rest assured, this
> > > > is something Google will keep investing resources on.
> > >
> > > So.  The plan is to put these interfaces in debugfs for now, with a
> > > view to migrating stabilized interfaces into sysfs (or procfs or
> > > whatever) once end-user requirements and use cases are better
> > > understood?
> >
> > The requirements are well understood and the use cases are proven,
> > e.g., Google [1], Meta [2] and Alibaba [3].
> >
> > [1] https://dl.acm.org/doi/10.1145/3297858.3304053
> > [2] https://dl.acm.org/doi/10.1145/3503222.3507731
> > [3] https://gitee.com/anolis/cloud-kernel/blob/release-5.10/mm/kidled.c
>
> So will these interfaces be moved into sysfs?

So the debugfs interface from this patch provides:
1. proactive reclaim,
2. working set estimation.

The sysfs interface for item 1 is being finalized by [4], and it's a
subset of this debugfs interface because we want it to be more
general. The sysfs interface for item 2 will be eventually proposed as
well, with the same approach. It will look like a histogram in which
the active/inactive LRU has two bins whereas MGLRU has more bins. Bins
contain pages and multiple bins represent different hotness/coldness.
Since [4] took about two years, I'd say this histogram-like interface
would take no less than a couple of years as well.

This debugfs interface stays even after that, and it will serve its
true purpose (debugging), not a substitute for the sysfs interfaces.

> > > If so, that sounds totally great to me.  But it should have been in
> > > the darn changelog!  This is the sort of thing which we care about most
> > > keenly.
> > >
> > > It would be helpful for reviewers to understand the proposed timeline
> > > for this process, because the entire feature isn't really real until
> > > this is completed, is it?  I do think we should get this nailed down
> > > relatively rapidly, otherwise people will be reluctant to invest much
> > > into a moving target.
> > >
> > > And I must say, I see dissonance between the overall maturity of the
> > > feature as described in these emails versus the immaturity of these
> > > userspace control interfaces.  What's happening there?
> >
> > Very observant. To answer both of the questions above: each iteration
> > of the entire stack is a multi-year effort.
> >
> > Given its ROI, companies I know of constantly pour money into this
> > area. Given its scale, this debugfs is the least of their concerns. A
> > good example is the proactive reclaim sysfs interface [4]. It's been
> > used at Google for many years and at Meta for a few years. We only
> > started finalizing it recently.
> >
> > [4] https://lore.kernel.org/r/20220425190040.2475377-1-yosryahmed@google.com/
>
> Sure, if one organization is involved in both the userspace code and
> the kernel interfaces then the alteration of kernel interfaces can be
> handled in a coordinated fashion.
>
> But releasing interfaces to the whole world is a different deal.  It's
> acceptable to say "this is in debugfs for now because it's a work
> in progress" but it sounds like mglru's interfaces are beyond that
> stage?

Correct. It's a WIP in the sense of "know what needs to be done but
can't get it done immediately", not "don't know what's next; try this
for now".
