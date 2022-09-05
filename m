Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2E385ADA4C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 22:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232558AbiIEUfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 16:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232355AbiIEUfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 16:35:17 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35CB41C10B
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 13:35:12 -0700 (PDT)
Date:   Mon, 5 Sep 2022 16:35:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1662410110;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OpP1uXm6ca6XBc1ONEJL5gkifMHj5fs70rHCFRmvOy8=;
        b=UY/kLXhSCop8V5EbyM6Vo2PNPn4IQk8/GFRnAap21SYUxPj2i6gjs8KI50f80Fsp8Xa6FE
        uuVJigYWXX7+vuoCs4T9565L2O1YZd4x8iWg9nweGuKJUkJg7Zaus5YpeaFA7mCLzRdbg2
        1pMuKrhGTAly+U+OkQj6pwMjKTI/v3w=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michel Lespinasse <michel@lespinasse.org>,
        Jerome Glisse <jglisse@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@suse.de>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Matthew Wilcox <willy@infradead.org>,
        "Liam R. Howlett" <liam.howlett@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Laurent Dufour <laurent.dufour@fr.ibm.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Song Liu <songliubraving@fb.com>, Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>, dhowells@redhat.com,
        Hugh Dickins <hughd@google.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Minchan Kim <minchan@google.com>,
        kernel-team <kernel-team@android.com>,
        linux-mm <linux-mm@kvack.org>,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH RESEND 00/28] per-VMA locks proposal
Message-ID: <20220905203503.tqtr36fsfg4guk4j@moria.home.lan>
References: <20220901173516.702122-1-surenb@google.com>
 <YxXsQKoQ0URIRuKi@dhcp22.suse.cz>
 <CAJuCfpG3bMLzNhP5wt8my8j7_9wW=darLegd6WPV6tddtCKGAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpG3bMLzNhP5wt8my8j7_9wW=darLegd6WPV6tddtCKGAA@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 05, 2022 at 11:32:48AM -0700, Suren Baghdasaryan wrote:
> On Mon, Sep 5, 2022 at 5:32 AM 'Michal Hocko' via kernel-team
> <kernel-team@android.com> wrote:
> >
> > Unless I am missing something, this is not based on the Maple tree
> > rewrite, right? Does the change in the data structure makes any
> > difference to the approach? I remember discussions at LSFMM where it has
> > been pointed out that some issues with the vma tree are considerably
> > simpler to handle with the maple tree.
> 
> Correct, this does not use the Maple tree yet but once Maple tree
> transition happens and it supports RCU-safe lookups, my code in
> find_vma_under_rcu() becomes really simple.
> 
> >
> > On Thu 01-09-22 10:34:48, Suren Baghdasaryan wrote:
> > [...]
> > > One notable way the implementation deviates from the proposal is the way
> > > VMAs are marked as locked. Because during some of mm updates multiple
> > > VMAs need to be locked until the end of the update (e.g. vma_merge,
> > > split_vma, etc).
> >
> > I think it would be really helpful to spell out those issues in a greater
> > detail. Not everybody is aware of those vma related subtleties.
> 
> Ack. I'll expand the description of the cases when multiple VMAs need
> to be locked in the same update. The main difficulties are:
> 1. Multiple VMAs might need to be locked within one
> mmap_write_lock/mmap_write_unlock session (will call it an update
> transaction).
> 2. Figuring out when it's safe to unlock a previously locked VMA is
> tricky because that might be happening in different functions and at
> different call levels.
> 
> So, instead of the usual lock/unlock pattern, the proposed solution
> marks a VMA as locked and provides an efficient way to:
> 1. Identify locked VMAs.
> 2. Unlock all locked VMAs in bulk.
> 
> We also postpone unlocking the locked VMAs until the end of the update
> transaction, when we do mmap_write_unlock. Potentially this keeps a
> VMA locked for longer than is absolutely necessary but it results in a
> big reduction of code complexity.

Correct me if I'm wrong, but it looks like any time multiple VMAs need to be
locked we need mmap_lock anyways, which is what makes your approach so sweet.

If however we ever want to lock multiple VMAs without taking mmap_lock, then
deadlock avoidance algorithms aren't that bad - there's the ww_mutex approach,
which is simple and works well when there isn't much expected contention (the
advantage of the ww_mutex approach is that it doesn't have to track all held
locks). I've also written full cycle detection; that approcah gets you fewer
restarts, at the cost of needing a list of all currently held locks.
