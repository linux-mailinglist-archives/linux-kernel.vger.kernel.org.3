Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 046484951D2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 16:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376718AbiATPyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 10:54:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiATPyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 10:54:20 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B6CC061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 07:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kIXpdsh41zq3qV5zSU+6YaFVVe/5lMdBHdT7s/njr3M=; b=b3VoM5L2H0yyRU/sq6U28sPPB+
        WyqdiZMLOfGkC4aBu1atF0VThkYJkgJXPgIlj1Th5vGBypFd/73s0q/VrZ7H9aQMZ0ZbLCd+/uaEa
        H7nk1N/2bSLUkz2RKQiymgiSJVrgSjiSSnHH+7SfSvkMv5DsQZwPgWZojw9p4TY0dYkV6humnkPBK
        /Gguq3ldz7g3IYBKpcwqsJyFgQGRLPdYo7zoUy6NtwgVKE+faX4plUenNNU+5gB7mFo2RLM1vLYQ2
        YR3uR+Fmgi9SiQAvNHdFdLE3NzdgjzmjzYb1zJp9AopY+TvcXZ8FkLKnoFKRmaJObVorUiW87hlUq
        C8Hgc2Jw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nAZlO-00EOxj-8l; Thu, 20 Jan 2022 15:54:14 +0000
Date:   Thu, 20 Jan 2022 15:54:14 +0000
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
Subject: Re: [PATCH v4 64/66] nommu: Remove uses of VMA linked list
Message-ID: <YemFpinGspNII+hl@casper.infradead.org>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
 <20211201142918.921493-65-Liam.Howlett@oracle.com>
 <3709289f-fe78-3e7a-649a-a38fb1b3329e@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3709289f-fe78-3e7a-649a-a38fb1b3329e@suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 04:06:21PM +0100, Vlastimil Babka wrote:
> On 12/1/21 15:30, Liam Howlett wrote:
> > From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> > 
> > Use the maple tree or VMA iterator instead.  This is faster and will
> > allow us to shrink the VMA.
> > 
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> 
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> 
> But I think some fixup needed:
> 
> > @@ -1456,12 +1458,14 @@ void exit_mmap(struct mm_struct *mm)
> >  
> >  	mm->total_vm = 0;
> >  
> > -	while ((vma = mm->mmap)) {
> > -		mm->mmap = vma->vm_next;
> > +	mmap_write_lock(mm);
> 
> If locking was missing, should have been added sooner than now?

I don't think so?  This is the exit_mmap() path, so we know nobody
has access to the mm.  We didn't need to hold the lock at this point
before, but now for_each_vma() will check we're holding the mmap_lock.

> > +	for_each_vma(vmi, vma) {
> >  		delete_vma_from_mm(vma);
> >  		delete_vma(mm, vma);
> >  		cond_resched();
> >  	}
> > +	__mt_destroy(&mm->mm_mt);
> 
> And this at the point mm_mt was added?

You mean we should have been calling __mt_destroy() earlier in the
patch series?  Umm ... I'll defer to Liam on that one.
