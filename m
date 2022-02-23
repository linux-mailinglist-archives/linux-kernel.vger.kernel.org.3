Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2874C18F1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 17:45:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242975AbiBWQp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 11:45:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237792AbiBWQpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 11:45:53 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3920F8EB5F
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 08:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OZnbt00zUnS8m67NiJ13USs9kJgohLQZFhnBYLNvjWA=; b=t1hv85IizsOcqi6ScA1osGJdhK
        C6T3qQUf4HaqeHhLFp0kdn1ZhElva1yJ37TUA70l21Xfxoj2OCyr4OyoZ8jwvaooeUzIcBH0Z3rc9
        aoxZfCuHWwjZGoBx9soiJXVHsNEIgQCt/w4O0fij7MtB+vszov3WveCOCXXeEsMXet7T+TWahh3wV
        15thF9YS0I8dkpfQ0jNZtMFC7YnqUQR+SpjLyw7X4pXat596haEGKgzBj/1NgOUUwKR0vizkQa1I5
        KhR6dZD1S4rvd2XsLrkq8iyf+vyfS4eLvUEyaEhxofPZ0/i35bVrpDGhmscA0bvUWrnAfhE2tq6Vl
        GRanFDog==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nMulL-003vdN-GX; Wed, 23 Feb 2022 16:45:11 +0000
Date:   Wed, 23 Feb 2022 16:45:11 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 00/71] Introducing the Maple Tree
Message-ID: <YhZklyIzNWK9eUO3@casper.infradead.org>
References: <20220215143728.3810954-1-Liam.Howlett@oracle.com>
 <20220216114700.f9473d88144dc59fc4d764fb@linux-foundation.org>
 <Yg1dgkrrImvQ1GXM@casper.infradead.org>
 <20220223163509.GH4423@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220223163509.GH4423@techsingularity.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2022 at 04:35:09PM +0000, Mel Gorman wrote:
> On Wed, Feb 16, 2022 at 08:24:34PM +0000, Matthew Wilcox wrote:
> > On Wed, Feb 16, 2022 at 11:47:00AM -0800, Andrew Morton wrote:
> > > On Tue, 15 Feb 2022 14:37:44 +0000 Liam Howlett <liam.howlett@oracle.com> wrote:
> > > 
> > > > The maple tree is an RCU-safe range based B-tree designed to use modern
> > > > processor cache efficiently.  There are a number of places in the kernel
> > > > that a non-overlapping range-based tree would be beneficial, especially
> > > > one with a simple interface.  The first user that is covered in this
> > > > patch set is the vm_area_struct, where three data structures are
> > > > replaced by the maple tree: the augmented rbtree, the vma cache, and the
> > > > linked list of VMAs in the mm_struct.  The long term goal is to reduce
> > > > or remove the mmap_sem contention.
> > > 
> > > Has a path been chosen which gets us from here to significant reduction
> > > in mmap_lock overhead?
> > > 
> > > If so, what's the plan and what must be done?
> > 
> > I would say there are still competing ideas for how that is to be done.
> > 
> > First, the Maple Tree is independent (to a certain extent) of all the
> > approaches to reducing mmap_lock overhead.  It's a better data structure
> > for VMA lookup than the rbtree.  Set against that, it has higher overhead
> > for modifications.  That means that benchmarks which primarily measure
> > modification overhead see worse performance.  We believe this is not
> > representative of real workloads, and indeed we see ~parity on workloads
> > like git and make -jN.
> 
> I'm way behind and only got around to looking at SPF properly today. Maple
> is working its way up my list and I need to gather new data but I did
> have old data queued from a time when I thought I would get around to
> maple tree soon.  The big result that stood was was brk performance from
> will-it-scale but for processes specifically

Yup, we know about the brk1 regression.  It's a really unrealistic
benchmark, which is why we added brk2.  To quote the commit message:

    Linux has this horrendously complicated anon_vma structure that you don't
    care about, but the upshot is that after calling fork(), each process
    that calls brk() gets a _new_ VMA created.  That is, after calling brk()
    the first time, the process address space looks like this:

    557777fab000-557777ff0000 rw-p 00000000 00:00 0                          [heap]
    557777ff0000-557777ff1000 rw-p 00000000 00:00 0                          [heap]

    so what brk1 is actually testing is how long it takes to create & destroy
    a new VMA.  This does not match what most programs do -- most will call
    exec() which resets the anon_vma structures and starts each program off
    with its own heap.  And if you do have a multi-process program which
    uses brk(), chances are it doesn't just oscillate betwee zero and one
    extra pages of heap compared to its parent.

    A better test starts out by allocating one page on the heap and then
    throbs between one and two pages instead of throbbing between zero and
    one page.  That means we're actually testing expanding and contracting
    the heap instead of creating and destroying a new heap.

    For realism, I wanted to add actually accessing the memory in the new
    heap, but that doesn't work for the threaded case -- another thread
    might remove the memory you just allocated while you're allocating it.
    Threaded programs give each thread its own heap anyway, so this is
    kind of a pointless syscall to ask about its threaded scalability.
    
    Anyway, here's brk2.c.  It is not very different from brk1.c, but the
    performance results are quite different (actually worse by about 10-15%).

