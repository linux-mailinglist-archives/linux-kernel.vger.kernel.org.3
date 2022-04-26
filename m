Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81CB5510B45
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 23:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355442AbiDZVdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 17:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351728AbiDZVdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 17:33:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 727B2167D1;
        Tue, 26 Apr 2022 14:30:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0864661768;
        Tue, 26 Apr 2022 21:30:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B698C385A0;
        Tue, 26 Apr 2022 21:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1651008636;
        bh=hRBN2iGUWntk6rFDQClPrjJSN1u3Plq5R5MkMdlntzA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=2AgeVAJdYeuPtwz5M/eqMKQsJKokdP1kIZVf0URVWM3SGYun4iiEJslJB0++i7lv+
         G29Uwsy2kwANU1AUg4BAnaWWNz9Q1s5uGgVhQoLMY6hwbuitH9tHnUinZbWz/b/lia
         ThO4ZAVemknNsB+RzsmXUH8bOCELau56862WiyuQ=
Date:   Tue, 26 Apr 2022 14:30:34 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Yu Zhao <yuzhao@google.com>
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
        Holger =?ISO-8859-1?Q?Hoffst=E4tte?= 
        <holger@applied-asynchrony.com>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>,
        Shuang Zhai <szhai2@cs.rochester.edu>,
        Sofia Trinh <sofia.trinh@edi.works>,
        Vaibhav Jain <vaibhav@linux.ibm.com>
Subject: Re: [PATCH v10 12/14] mm: multi-gen LRU: debugfs interface
Message-Id: <20220426143034.f520c062830f9e3405c890d0@linux-foundation.org>
In-Reply-To: <CAOUHufa60CVZcXJ937=P4GVtV_Cn76mYCWwcyBNjMAADmyWEwQ@mail.gmail.com>
References: <20220407031525.2368067-1-yuzhao@google.com>
        <20220407031525.2368067-13-yuzhao@google.com>
        <20220411191634.674554d3de2ba37b3db40ca2@linux-foundation.org>
        <CAOUHufYhhCPFqoRbtn+=OFxZxNWS9yxW9Re_s-2TYGqCEaMXVw@mail.gmail.com>
        <20220415212024.c682ac000e3e91572d8d6d2b@linux-foundation.org>
        <CAOUHufa60CVZcXJ937=P4GVtV_Cn76mYCWwcyBNjMAADmyWEwQ@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Apr 2022 00:59:37 -0600 Yu Zhao <yuzhao@google.com> wrote:

> On Fri, Apr 15, 2022 at 10:20 PM Andrew Morton
> <akpm@linux-foundation.org> wrote:
> >
> > On Fri, 15 Apr 2022 18:03:16 -0600 Yu Zhao <yuzhao@google.com> wrote:
> >
> > > > Presumably sysfs is the place.  Fully documented and with usage
> > > > examples in the changelog so we can carefully review the proposed
> > > > extensions to Linux's ABI.  Extensions which must be maintained
> > > > unchanged for all time.
> > >
> > > Eventually, yes. There still is a long way to go. Rest assured, this
> > > is something Google will keep investing resources on.
> >
> > So.  The plan is to put these interfaces in debugfs for now, with a
> > view to migrating stabilized interfaces into sysfs (or procfs or
> > whatever) once end-user requirements and use cases are better
> > understood?
> 
> The requirements are well understood and the use cases are proven,
> e.g., Google [1], Meta [2] and Alibaba [3].
> 
> [1] https://dl.acm.org/doi/10.1145/3297858.3304053
> [2] https://dl.acm.org/doi/10.1145/3503222.3507731
> [3] https://gitee.com/anolis/cloud-kernel/blob/release-5.10/mm/kidled.c

So will these interfaces be moved into sysfs?

> > If so, that sounds totally great to me.  But it should have been in
> > the darn changelog!  This is the sort of thing which we care about most
> > keenly.
> >
> > It would be helpful for reviewers to understand the proposed timeline
> > for this process, because the entire feature isn't really real until
> > this is completed, is it?  I do think we should get this nailed down
> > relatively rapidly, otherwise people will be reluctant to invest much
> > into a moving target.
> >
> > And I must say, I see dissonance between the overall maturity of the
> > feature as described in these emails versus the immaturity of these
> > userspace control interfaces.  What's happening there?
> 
> Very observant. To answer both of the questions above: each iteration
> of the entire stack is a multi-year effort.
> 
> Given its ROI, companies I know of constantly pour money into this
> area. Given its scale, this debugfs is the least of their concerns. A
> good example is the proactive reclaim sysfs interface [4]. It's been
> used at Google for many years and at Meta for a few years. We only
> started finalizing it recently.
> 
> [4] https://lore.kernel.org/r/20220425190040.2475377-1-yosryahmed@google.com/

Sure, if one organization is involved in both the userspace code and
the kernel interfaces then the alteration of kernel interfaces can be
handled in a coordinated fashion.

But releasing interfaces to the whole world is a different deal.  It's
acceptable to say "this is in debugfs for now because it's a work
in progress" but it sounds like mglru's interfaces are beyond that
stage?

