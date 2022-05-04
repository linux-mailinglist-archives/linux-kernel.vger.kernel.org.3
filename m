Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F38A51AA67
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 19:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357834AbiEDRZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 13:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355338AbiEDRER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 13:04:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193EA4ECC6
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 09:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Wrv4ckpmdc6hcosmcP/WgGLNgUcSbkfbftqqeOhaNJw=; b=uTm6BCN1kLGurDPc9rj8bkHeA/
        Q4eInIJmIAdSjPAHw/GWYzLhyOZIENEpYg34wIT/hmQJdY+qqyxWoyJfeAcktb/blbmNvNkvwG2hq
        1IORJp2CSyFUwYxho/OIzACTLric3nwrGpTt/4cSDTbvnEA4LJIlULCfKG5KSo+A1oz0N96CLwVOi
        JP0oiY5fpQ4P8WVsK7KNYYtVqlazxLUyI9FAJSTgUbiDDshdwklGf50WXqXuCvev0GTHC+Y2Qk44U
        uvBydUBAE9H7HvtSbyZ1iRkMz4vEjwJdAz8VinC+IijQ7OLfe2+nGVrTughwicrE0TtsQmSnr274N
        ufLkZTlA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nmIEu-00GkUC-Uc; Wed, 04 May 2022 16:52:36 +0000
Date:   Wed, 4 May 2022 17:52:36 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Michel Lespinasse <walken.cr@gmail.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Liam Howlett <liam.howlett@oracle.com>, hannes@cmpxchg.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>, David <david@redhat.com>
Subject: Re: Memory allocation on speculative fastpaths
Message-ID: <YnKvVFWY8+WGIMf0@casper.infradead.org>
References: <20220503155913.GA1187610@paulmck-ThinkPad-P17-Gen-1>
 <YnFSfc8BR8CadOtw@dhcp22.suse.cz>
 <20220503163905.GM1790663@paulmck-ThinkPad-P17-Gen-1>
 <YnF0RyBaBSC1mdKo@casper.infradead.org>
 <CAL36u31s_4TYPRtAzbGUpQVw2ButNv3vtKLhBkfJAhFSfcNDSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL36u31s_4TYPRtAzbGUpQVw2ButNv3vtKLhBkfJAhFSfcNDSg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 04, 2022 at 01:20:39AM -0700, Michel Lespinasse wrote:
> (for context, this came up during a discussion of speculative page
> faults implementation details)
> 
> On Tue, May 3, 2022 at 11:28 AM Matthew Wilcox <willy@infradead.org> wrote:
> > Johannes (I think it was?) made the point to me that if we have another
> > task very slowly freeing memory, a task in this path can take advantage
> > of that other task's hard work and never go into reclaim.  So the
> > approach we should take is:
> >
> > p4d_alloc(GFP_NOWAIT | __GFP_NOMEMALLOC | __GFP_NOWARN);
> > pud_alloc(GFP_NOWAIT | __GFP_NOMEMALLOC | __GFP_NOWARN);
> > pmd_alloc(GFP_NOWAIT | __GFP_NOMEMALLOC | __GFP_NOWARN);
> >
> > if (failure) {
> >   rcu_read_unlock();
> >   do_reclaim();
> >   return FAULT_FLAG_RETRY;
> > }
> 
> I don't think this works. The problem with allocating page tables is
> not just that it may break an rcu-locked code section; you also need
> the code inserting the new page tables into the mm's page table tree
> to synchronize with any munmap() that may be concurrently running. RCU
> isn't sufficient here, and we would need a proper lock when wiring new
> page tables (current code relies on mmap lock for this).

Hmm, so what you're saying is that we could see:

CPU 0					CPU 1

rcu_read_lock()
p4d_alloc()
pud_alloc()
					mmap_write_lock
					pmd_free
					pud_free
					p4d_free
					mmap_write_unlock
pmd_alloc()

... and now CPU 0 has stored a newly allocated PMD into a PUD that will
be freed by RCU.

Good catch, but fortunately we don't have to solve it right now because
we decided on Monday to not pursue this approach.

> > ... but all this is now moot since the approach we agreed to yesterday
> > is:
> >
> > rcu_read_lock();
> > vma = vma_lookup();
> > if (down_read_trylock(&vma->sem)) {
> >         rcu_read_unlock();
> > } else {
> >         rcu_read_unlock();
> >         mmap_read_lock(mm);
> >         vma = vma_lookup();
> >         down_read(&vma->sem);
> > }
> >
> > ... and we then execute the page table allocation under the protection of
> > the vma->sem.
> >
> > At least, that's what I think we agreed to yesterday.
> 
> I don't remember discussing any of this yesterday. As I remember it,
> the discussion was about having one large RCU section vs several small
> ones linked by sequence count checks to verify the validity of the vma
> at the start of each RCU section.

That was indeed what we started out discussing, but Michal and others
wanted to explore locking the VMA as a first step.  This approach
doesn't suffer from the same problem as the write side is:

	mmap_write_lock()
	vma = vma_lookup();
	down_write(&vma->sem);
	... tear down page tables ...
	up_write(&vma->sem);
	rcu_free(vma);
	mmap_write_unlock();

So when tearing down the page tables, if the fault is on this VMA, it
will block until the fault has released the VMA read lock.  If it's on
another VMA, the page table teardown will not tear down any page tables
which are partially covered by any VMA.

Or have I missed something else?
