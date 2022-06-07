Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 615BF54017C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 16:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245570AbiFGOeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 10:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245179AbiFGOeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 10:34:13 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 0A305B714D
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 07:34:10 -0700 (PDT)
Received: (qmail 405325 invoked by uid 1000); 7 Jun 2022 10:34:08 -0400
Date:   Tue, 7 Jun 2022 10:34:08 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Will Deacon <will@kernel.org>
Cc:     Akira Yokosawa <akiyks@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [RFC PATCH -lkmm] docs/memory-barriers: Fix inconsistent name of
 'data dependency barrier'
Message-ID: <Yp9h4Cmo0UNZp6xD@rowland.harvard.edu>
References: <cc2c7885-ac75-24f3-e18a-e77f97c91b4c@gmail.com>
 <20220607133432.GA32701@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607133432.GA32701@willie-the-truck>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2022 at 02:34:33PM +0100, Will Deacon wrote:
> On Sat, May 28, 2022 at 01:15:30PM +0900, Akira Yokosawa wrote:
> > The term "data dependency barrier", which has been in
> > memory-barriers.txt ever since it was first authored by David Howells,
> > has become confusing due to the fact that in LKMM's explanations.txt
> > and elsewhere, "data dependency" is used mostly for load-to-store data
> > dependency.
> > 
> > To prevent further confusions, do the following changes:
> > 
> >   - substitute "address-dependency barrier" for "data dependency barrier";
> >   - add note on the removal of kernel APIs for explicit address-
> >     dependency barriers in kernel release v5.9;
> >   - add note on the section title rename;
> >   - use READ_ONCE_OLD() for READ_ONCE() of pre-4.15 (no address-
> >     dependency implication) in code snippets;
> >   - fix number of CPU memory barrier APIs;
> >   - and a few more context adjustments.

> I suppose this isn't really a comment on your patch, as I much prefer the
> updated terminology, but the way this section is now worded really makes it
> sounds like address dependencies only order load -> load, whereas they
> equally order load -> store. Saying that "An address-dependency barrier...
> is not required to have any effect on stores" is really confusing to me: the
> barrier should only ever be used in conjunction with an address-dependency
> _anyway_ so whether or not it's the barrier or the dependency giving the
> order is an implementation detail.

It would be more accurate to say that address-dependency barriers are 
not _needed_ for load->store ordering because the dependencies 
themselves already provide this ordering (even on Alpha).

> Perhaps the barrier should be called a "Read-read-address-dependency
> barrier", an "Address-dependency read barrier" or even a "Consume barrier"
> (:p) instead? Dunno, Alan is normally much better at naming these things
> than I am.

Well, "load-load-address-dependency barrier" would be okay as a generic 
name, albeit unwieldy.  Note however that on Alpha -- the only 
architecture to need these barriers -- they aren't anything special; the 
actual instruction is the equivalent of an ordinary smp_rmb().  (Please 
correct me if my memory about this is wrong.)

So in principle you could simply call them "read memory barriers" while 
pointing out the need for special use on demented architectures where 
address dependencies do not guarantee load->load ordering.

> Alternatively, maybe we should be removing the historical stuff from the
> document altogether if it's no longer needed. We don't have any occurrences
> of read_barrier_depends() anymore, so why confuse people with it?

How about relegating discussion of these barriers to a special 
"historical" or "niche architecture" section of the document?  In a 
separate patch, of course.

Alan


