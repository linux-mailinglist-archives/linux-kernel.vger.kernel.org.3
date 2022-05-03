Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E087E518C51
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 20:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241338AbiECScP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 14:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235501AbiECScK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 14:32:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149CA3CA46
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 11:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wjXE0SIpZd7eh/s+NoP34A161Jqj7oErQimubPGebCU=; b=ZgLPanOhTu3Nx2h0oL6bG0ARDX
        KQpJntnmzSTK8FBe2UY+sc8fjvU+4SLQBnLy9G3zvaUhvTW47f+p931JbiFP2ozIKbBswbDlbT6jp
        MbNpk5wkHPggNwOzr6oS0xHFWuhyZxxVKrJ7SW3Yd3OVV34SEB7P3+dntEEPBPcL0Fht4GrqXPQWv
        QoO1TBODd2vEjlCepXhgUBpYQTCR5lBO+3AtlGCqUuJb7pfoU4LPLVWTi2Dq5NkAKTjNi+uPl6xT2
        QJ0+lEUO0wsN5o9ZhYmNgAHEyyTKdf0wzBo3gI9FEW+8k2yBF2i8QxW72MgMX3xhE96PY/4/ls2Wy
        y6qW4IWw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nlxG3-00Fs21-LU; Tue, 03 May 2022 18:28:23 +0000
Date:   Tue, 3 May 2022 19:28:23 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Michal Hocko <mhocko@suse.com>, liam.howlett@oracle.com,
        walken.cr@gmail.com, hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: Memory allocation on speculative fastpaths
Message-ID: <YnF0RyBaBSC1mdKo@casper.infradead.org>
References: <20220503155913.GA1187610@paulmck-ThinkPad-P17-Gen-1>
 <YnFSfc8BR8CadOtw@dhcp22.suse.cz>
 <20220503163905.GM1790663@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220503163905.GM1790663@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 03, 2022 at 09:39:05AM -0700, Paul E. McKenney wrote:
> On Tue, May 03, 2022 at 06:04:13PM +0200, Michal Hocko wrote:
> > On Tue 03-05-22 08:59:13, Paul E. McKenney wrote:
> > > Hello!
> > > 
> > > Just following up from off-list discussions yesterday.
> > > 
> > > The requirements to allocate on an RCU-protected speculative fastpath
> > > seem to be as follows:
> > > 
> > > 1.	Never sleep.
> > > 2.	Never reclaim.
> > > 3.	Leave emergency pools alone.
> > > 
> > > Any others?
> > > 
> > > If those rules suffice, and if my understanding of the GFP flags is
> > > correct (ha!!!), then the following GFP flags should cover this:
> > > 
> > > 	__GFP_NOMEMALLOC | __GFP_NOWARN
> > 
> > GFP_NOWAIT | __GFP_NOMEMALLOC | __GFP_NOWARN
> 
> Ah, good point on GFP_NOWAIT, thank you!

Johannes (I think it was?) made the point to me that if we have another
task very slowly freeing memory, a task in this path can take advantage
of that other task's hard work and never go into reclaim.  So the
approach we should take is:

p4d_alloc(GFP_NOWAIT | __GFP_NOMEMALLOC | __GFP_NOWARN);
pud_alloc(GFP_NOWAIT | __GFP_NOMEMALLOC | __GFP_NOWARN);
pmd_alloc(GFP_NOWAIT | __GFP_NOMEMALLOC | __GFP_NOWARN);

if (failure) {
  rcu_read_unlock();
  do_reclaim();
  return FAULT_FLAG_RETRY;
}

... but all this is now moot since the approach we agreed to yesterday
is:

rcu_read_lock();
vma = vma_lookup();
if (down_read_trylock(&vma->sem)) {
	rcu_read_unlock();
} else {
	rcu_read_unlock();
	mmap_read_lock(mm);
	vma = vma_lookup();
	down_read(&vma->sem);
}

... and we then execute the page table allocation under the protection of
the vma->sem.

At least, that's what I think we agreed to yesterday.
