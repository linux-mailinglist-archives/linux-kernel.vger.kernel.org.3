Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06BB04A5534
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 03:20:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232457AbiBACUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 21:20:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231473AbiBACUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 21:20:50 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC2FDC061714
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 18:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VaPv9in0Q0d5pY9Lnm4deq3TesKVG1iF4M3HxW9oxdw=; b=WYtch715pZRcNyhxCmmdPdqfVb
        ZvvzOSmL6yGAJhSSWvAdGVvVB1OriraaS+j9USYyk+pMBM+YqSWlBoiBtyeG7WBNz4Z5Nw5lCtATu
        QoZAjplgw10FePVkMNpbtvXDsPRt2KuJBeVx5dPhmaRF4Q//CcDaNdOzYoSbuPp+lNDcRahqY0zC5
        NtPxbajxz6VZpkKhnhDnWIrsXMs+16AMG4Aq2IOPyB6n8smHjhS9qEoeHNV9ybp8QM0b4/FvjFoQE
        cEWpvX8JQabphnnZ1rQU3z3xTgKsuSCiUcDOAz590YawBuzwJLiZ2ZkkBC4M4HZblty6nPWAy4CAx
        gnVGx/2A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nEimd-00BCwX-CU; Tue, 01 Feb 2022 02:20:39 +0000
Date:   Tue, 1 Feb 2022 02:20:39 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michel Lespinasse <michel@lespinasse.org>,
        Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, Laurent Dufour <ldufour@linux.ibm.com>,
        Jerome Glisse <jglisse@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Liam Howlett <liam.howlett@oracle.com>,
        Rik van Riel <riel@surriel.com>,
        Paul McKenney <paulmck@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Minchan Kim <minchan@google.com>,
        Joel Fernandes <joelaf@google.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v2 00/35] Speculative page faults
Message-ID: <YfiY9zRm8BhSp7eA@casper.infradead.org>
References: <20220128131006.67712-1-michel@lespinasse.org>
 <20220131171434.89870a8f1ae294912e7ff19e@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220131171434.89870a8f1ae294912e7ff19e@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 05:14:34PM -0800, Andrew Morton wrote:
> On Fri, 28 Jan 2022 05:09:31 -0800 Michel Lespinasse <michel@lespinasse.org> wrote:
> > The first step of a speculative page fault is to look up the vma and
> > read its contents (currently by making a copy of the vma, though in
> > principle it would be sufficient to only read the vma attributes that
> > are used in page faults). The mmap sequence count is used to verify
> > that there were no mmap writers concurrent to the lookup and copy steps.
> > Note that walking rbtrees while there may potentially be concurrent
> > writers is not an entirely new idea in linux, as latched rbtrees
> > are already doing this. This is safe as long as the lookup is
> > followed by a sequence check to verify that concurrency did not
> > actually occur (and abort the speculative fault if it did).
> 
> I'm surprised that descending the rbtree locklessly doesn't flat-out
> oops the kernel.  How are we assured that every pointer which is
> encountered actually points at the right thing?  Against things
> which tear that tree down?

It doesn't necessarily point at the _right_ thing.  You may get
entirely the wrong node in the tree if you race with a modification,
but, as Michel says, you check the seqcount before you even look at
the VMA (and if the seqcount indicates a modification, you throw away
the result and fall back to the locked version).  The rbtree always
points to other rbtree nodes, so you aren't going to walk into some
completely wrong data structure.

> > The next step is to walk down the existing page table tree to find the
> > current pte entry. This is done with interrupts disabled to avoid
> > races with munmap().
> 
> Sebastian, could you please comment on this from the CONFIG_PREEMPT_RT
> point of view?

I am not a fan of this approach.  For other reasons, I think we want to
switch to RCU-freed page tables, and then we can walk the page tables
with the RCU lock held.  Some architectures already RCU-free the page
tables, so I think it's just a matter of converting the rest.
