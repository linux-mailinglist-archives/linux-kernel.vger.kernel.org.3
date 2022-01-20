Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDAB24951C9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 16:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376781AbiATPuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 10:50:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346240AbiATPuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 10:50:13 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8536BC061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 07:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+OqexFoNCw32h57DcgoxO/vo70BrOjYwfG6rLAmWBFk=; b=hpYJa8iURpESRfETFsBuVnmNao
        5TNej4O57CGbRr8rVRkuB1yNHsu02X5/nl/cpjO/VIHtqaNXy/cfO4VXXpw0lHkRlYPW9IGNt+Mwl
        wi/QPhzbw5zP5kQwPWvBBcthI5gUG0Ub0e7/afSo3swET/a7d94V5/S0Lj18ekylHxfyIvn8UdT/R
        GIbnv/mxwdb4Kw2MOl//pKSTL4Pfi8eQsBueheUVHLpuYaEYLNX2y/+WPa5498YYhJPhLzkCChv90
        pexyEMGXpqJE5vQrDGwtKJ/RW11j56Q6vu/cnJHwNHFTtqbFueGtipqGz5O+UYh0GWcCEj8MEvEHk
        xHpZBd+A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nAZhJ-00EOay-4L; Thu, 20 Jan 2022 15:50:01 +0000
Date:   Thu, 20 Jan 2022 15:50:01 +0000
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
Subject: Re: [PATCH v4 63/66] i915: Use the VMA iterator
Message-ID: <YemEqYFu1xdaTeHd@casper.infradead.org>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
 <20211201142918.921493-64-Liam.Howlett@oracle.com>
 <807fa53c-6492-52ca-abf3-ce58cc84ca08@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <807fa53c-6492-52ca-abf3-ce58cc84ca08@suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 03:59:11PM +0100, Vlastimil Babka wrote:
> On 12/1/21 15:30, Liam Howlett wrote:
> > From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> > 
> > Replace the O(n.log(n)) loop with an O(n) loop.
> 
> Not true?

Oh, right, that should have been just the linked-list walk.
I misread it as calling find_vma() for each iteration instead
of just the first one.  Liam, do you mind updating the changelog
here?

I wonder whether we want a "for_each_contiguous_vma()" that
will stop on a hole.  It seems like a relatively sensible thing
to do -- walk across a contiguous range of memory and stop if
there's no VMA mapping a page.  Like gup(), for example.

> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> 
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> 
> > ---
> >  drivers/gpu/drm/i915/gem/i915_gem_userptr.c | 14 +++++---------
> >  1 file changed, 5 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/i915/gem/i915_gem_userptr.c b/drivers/gpu/drm/i915/gem/i915_gem_userptr.c
> > index 3173c9f9a040..39960973c130 100644
> > --- a/drivers/gpu/drm/i915/gem/i915_gem_userptr.c
> > +++ b/drivers/gpu/drm/i915/gem/i915_gem_userptr.c
> > @@ -425,12 +425,11 @@ static const struct drm_i915_gem_object_ops i915_gem_userptr_ops = {
> >  static int
> >  probe_range(struct mm_struct *mm, unsigned long addr, unsigned long len)
> >  {
> > -	const unsigned long end = addr + len;
> > +	VMA_ITERATOR(vmi, mm, addr);
> >  	struct vm_area_struct *vma;
> > -	int ret = -EFAULT;
> >  
> >  	mmap_read_lock(mm);
> > -	for (vma = find_vma(mm, addr); vma; vma = vma->vm_next) {
> > +	for_each_vma_range(vmi, vma, addr + len) {
> >  		/* Check for holes, note that we also update the addr below */
> >  		if (vma->vm_start > addr)
> >  			break;
> > @@ -438,16 +437,13 @@ probe_range(struct mm_struct *mm, unsigned long addr, unsigned long len)
> >  		if (vma->vm_flags & (VM_PFNMAP | VM_MIXEDMAP))
> >  			break;
> >  
> > -		if (vma->vm_end >= end) {
> > -			ret = 0;
> > -			break;
> > -		}
> > -
> >  		addr = vma->vm_end;
> >  	}
> >  	mmap_read_unlock(mm);
> >  
> > -	return ret;
> > +	if (vma)
> > +		return -EFAULT;
> > +	return 0;
> >  }
> >  
> >  /*
> 
