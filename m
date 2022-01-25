Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC44149B98F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 18:04:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378774AbiAYREP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 12:04:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382695AbiAYRBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 12:01:21 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B61C0613E7
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 09:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Rbj8jfMOl7g1VD9rbNUyWdz7qydnYWIP3fpQ2esLHiM=; b=qBvPmYf7ynWtg4Tp2kzg6JjfBb
        rXb1MqyXHsZaXGTWE03Vamp/t57pUhgh4hgeBGyO3UND32T80XujdYLU0HJ5l94X+1X13fJY+Q9kR
        cNgLZgcX0eyK7VgK8yuoHN1yk5FQg2i5prylcQG2y4rmTfgjRP3Te339WKz7LxPs5/XqR8nTEoCjE
        gGyqISTQZfMhUqXknQ78wQt//t1yW2J9LC8xwCxbPID/b6C6d0EzIx7NReexlL81c54yt9IlhcmlI
        XhKRVLAvc6/T/Z/SzGpX55rDtGPsUhYmyg8laR6vG3W/AogFJE57D42MNi3Fnw6/YTzyxcFcl79Gm
        GOISGdMA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nCPBk-0036WV-0T; Tue, 25 Jan 2022 17:01:00 +0000
Date:   Tue, 25 Jan 2022 17:00:59 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Liam Howlett <liam.howlett@oracle.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Song Liu <songliubraving@fb.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Rik van Riel <riel@surriel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michel Lespinasse <walken.cr@gmail.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Minchan Kim <minchan@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Rom Lemarchand <romlem@google.com>
Subject: Re: [PATCH v4 38/66] coredump: Remove vma linked list walk
Message-ID: <YfAsy7I7IeMO0p/e@casper.infradead.org>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
 <20211201142918.921493-39-Liam.Howlett@oracle.com>
 <381fab01-322a-a48a-0b27-ef7c95c3269f@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <381fab01-322a-a48a-0b27-ef7c95c3269f@suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2022 at 11:31:45AM +0100, Vlastimil Babka wrote:
> On 12/1/21 15:30, Liam Howlett wrote:
> > From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> > 
> > Use the Maple Tree iterator instead.  This is too complicated for the
> > VMA iterator to handle, so let's open-code it for now.  If this turns
> > out to be a common pattern, we can migrate it to common code.
> > 
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> > ---
> >  fs/coredump.c | 33 ++++++++++++---------------------
> >  1 file changed, 12 insertions(+), 21 deletions(-)
> > 
> > diff --git a/fs/coredump.c b/fs/coredump.c
> > index a6b3c196cdef..59347e42048d 100644
> > --- a/fs/coredump.c
> > +++ b/fs/coredump.c
> > @@ -997,30 +997,20 @@ static unsigned long vma_dump_size(struct vm_area_struct *vma,
> >  	return vma->vm_end - vma->vm_start;
> >  }
> >  
> > -static struct vm_area_struct *first_vma(struct task_struct *tsk,
> > -					struct vm_area_struct *gate_vma)
> > -{
> > -	struct vm_area_struct *ret = tsk->mm->mmap;
> > -
> > -	if (ret)
> > -		return ret;
> > -	return gate_vma;
> > -}
> > -
> >  /*
> >   * Helper function for iterating across a vma list.  It ensures that the caller
> >   * will visit `gate_vma' prior to terminating the search.
> >   */
> > -static struct vm_area_struct *next_vma(struct vm_area_struct *this_vma,
> > +static struct vm_area_struct *coredump_next_vma(struct ma_state *mas,
> > +				       struct vm_area_struct *vma,
> >  				       struct vm_area_struct *gate_vma)
> >  {
> > -	struct vm_area_struct *ret;
> > -
> > -	ret = this_vma->vm_next;
> > -	if (ret)
> > -		return ret;
> > -	if (this_vma == gate_vma)
> > +	if (vma == gate_vma)
> >  		return NULL;
> > +
> > +	vma = mas_next(mas, ULONG_MAX);
> > +	if (vma)
> > +		return vma;
> 
> This looks suspicious. Before this patch if gate_vma was part of the linked
> list, it was returned. Even more than once if it was not the last vma in the
> list. After this patch, if it's part of the maple tree, it will not be
> returned and the iteration will stop.
> 
> But I don't know what are the rules for gate_vma being part of linked
> list/maple tree, thus whether this is a bug.

As I understand it, and let's be clear that I'm tampering with things
that I do not fully understand, the gate VMA is not part of the linked
list today, and will not be part of the maple tree in future (*).  I
don't think it can be part of the linked list because there's one
gate VMA that's part of every process, so it can't be part of any
MM's linked list.

Code before my patch:
 - If the current VMA has a next VMA, return it
 - If the current VMA is the gate VMA, we're done, return NULL.
 - Return the gate VMA (after walking all the other VMAs)

Code after my patch:
 - If the current VMA is the gate VMA, we're done, return NULL.
 - If the next VMA is not NULL, return it.
 - Return the gate VMA (after walking all the other VMAs)

ie, I've switched the order of the two tests.
I think the linked list code could be rewritten to be in this order
too, but that seems like an unnecessary additional patch?

(*) Although it could be added to the maple tree; that's one of the
nice things about using external storage; you can simply point to
things; there's no restrictions on "must be part of exactly one list".
We have not made that change as part of this patch set, and I believe it
should be a future patch set that's evaluated on its own merits.

> >  	return gate_vma;
> >  }
> >  
> > @@ -1032,9 +1022,10 @@ int dump_vma_snapshot(struct coredump_params *cprm, int *vma_count,
> >  		      struct core_vma_metadata **vma_meta,
> >  		      size_t *vma_data_size_ptr)
> >  {
> > -	struct vm_area_struct *vma, *gate_vma;
> > +	struct vm_area_struct *gate_vma, *vma = NULL;
> >  	struct mm_struct *mm = current->mm;
> > -	int i;
> > +	MA_STATE(mas, &mm->mm_mt, 0, 0);
> > +	int i = 0;
> >  	size_t vma_data_size = 0;
> >  
> >  	/*
> > @@ -1054,8 +1045,7 @@ int dump_vma_snapshot(struct coredump_params *cprm, int *vma_count,
> >  		return -ENOMEM;
> >  	}
> >  
> > -	for (i = 0, vma = first_vma(current, gate_vma); vma != NULL;
> > -			vma = next_vma(vma, gate_vma), i++) {
> > +	while ((vma = coredump_next_vma(&mas, vma, gate_vma)) != NULL) {
> >  		struct core_vma_metadata *m = (*vma_meta) + i;
> >  
> >  		m->start = vma->vm_start;
> > @@ -1064,6 +1054,7 @@ int dump_vma_snapshot(struct coredump_params *cprm, int *vma_count,
> >  		m->dump_size = vma_dump_size(vma, cprm->mm_flags);
> >  
> >  		vma_data_size += m->dump_size;
> > +		i++;
> >  	}
> >  
> >  	mmap_write_unlock(mm);
> 
