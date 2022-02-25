Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B831B4C3D0A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 05:23:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237332AbiBYEYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 23:24:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiBYEYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 23:24:14 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF41D7DAAB
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 20:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rFcwgc0Y0FAbw6iDHxZlvv3kdev4RadFXvYJQwj9LlU=; b=gbSU6YfhHZwluXm/82MA9uQBPp
        pZYkpLtrlXbmSITGWtHG07g4IaSQMQcL0LAZ0y/AguCIRKBTCagCr5fDMeHtavg+it5VFKdYkroRP
        B9+L8LGl7v0mZjBTD3a7XBuGv9WGZkEFQFFYRUS1MLYHSexN3mmWa7K6o7feI+kEsS4zWhC84jaIT
        6JBoy3ME02rKspj/mcvKIiAnfd6WngqPq+PjG6dc1HJq0fxAskofRqsTDsfDzNvFt5hBojNYzAeiF
        F4B4yZzhVm2gTDVAU0DTe82CR9WbbclPbPHTHLV/uicgN5pJ58wCxtDrNh4JnDRY4aRv2/EO5zbLT
        fQ3AKOfw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nNS8Q-005SlC-Nw; Fri, 25 Feb 2022 04:23:14 +0000
Date:   Fri, 25 Feb 2022 04:23:14 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Suren Baghdasaryan <surenb@google.com>, mhocko@kernel.org,
        mhocko@suse.com, shy828301@gmail.com, rientjes@google.com,
        hannes@cmpxchg.org, guro@fb.com, riel@surriel.com,
        minchan@kernel.org, kirill@shutemov.name, aarcange@redhat.com,
        brauner@kernel.org, christian@brauner.io, hch@infradead.org,
        oleg@redhat.com, david@redhat.com, jannh@google.com,
        shakeelb@google.com, luto@kernel.org, christian.brauner@ubuntu.com,
        fweimer@redhat.com, jengelh@inai.de, timmurray@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com,
        syzbot+2ccf63a4bd07cf39cab0@syzkaller.appspotmail.com,
        Liam Howlett <liam.howlett@oracle.com>
Subject: Re: [PATCH 1/1] mm: fix use-after-free bug when mm->mmap is reused
 after being freed
Message-ID: <YhhZsv+czqQPKvvN@casper.infradead.org>
References: <20220215201922.1908156-1-surenb@google.com>
 <20220224201859.a38299b6c9d52cb51e6738ea@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220224201859.a38299b6c9d52cb51e6738ea@linux-foundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 08:18:59PM -0800, Andrew Morton wrote:
> On Tue, 15 Feb 2022 12:19:22 -0800 Suren Baghdasaryan <surenb@google.com> wrote:
> 
> > After exit_mmap frees all vmas in the mm, mm->mmap needs to be reset,
> > otherwise it points to a vma that was freed and when reused leads to
> > a use-after-free bug.
> > 
> > ...
> >
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -3186,6 +3186,7 @@ void exit_mmap(struct mm_struct *mm)
> >  		vma = remove_vma(vma);
> >  		cond_resched();
> >  	}
> > +	mm->mmap = NULL;
> >  	mmap_write_unlock(mm);
> >  	vm_unacct_memory(nr_accounted);
> >  }
> 
> After the Maple tree patches, mm_struct.mmap doesn't exist.  So I'll
> revert this fix as part of merging the maple-tree parts of linux-next.
> I'll be sending this fix to Linus this week.
> 
> All of which means that the thusly-resolved Maple tree patches might
> reintroduce this use-after-free bug.

I don't think so?  The problem is that VMAs are (currently) part of
two data structures -- the rbtree and the linked list.  remove_vma()
only removes VMAs from the rbtree; it doesn't set mm->mmap to NULL.

With maple tree, the linked list goes away.  remove_vma() removes VMAs
from the maple tree.  So anyone looking to iterate over all VMAs has to
go and look in the maple tree for them ... and there's nothing there.

But maybe I misunderstood the bug that's being solved here.
