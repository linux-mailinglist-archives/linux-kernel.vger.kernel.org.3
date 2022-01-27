Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17EE849E917
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 18:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238259AbiA0Rdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 12:33:41 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:56924 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238078AbiA0Rdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 12:33:39 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A5329218B0;
        Thu, 27 Jan 2022 17:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643304818; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DNVZZ8sxz6PZX0hCDHOK6Gcobf083HehUDqLl9+Rksg=;
        b=XMU7P0JfIlcDalrwZsFfKxP7IPZWBqGSXpmRQBjcGhsrDAhUlWrcbn4CyXbX1dd43nRtCq
        qvMV2wL05FsJZYG6Xg8GYedzYYGM4zAc5/1hSeoBRVHwl8gxXwhH+BKuYRQ//jfkyhWGyH
        oOX5ROj6WW5GbIqG101hohnMJCDsjsg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643304818;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DNVZZ8sxz6PZX0hCDHOK6Gcobf083HehUDqLl9+Rksg=;
        b=0kKwYK0WXw+jSIadR30eLnysmgogtc8fYCsjS+PvzEsQYZGthkLvY/rwSTBjBs+KY4e2Xw
        EP3kC2EA5WPby7Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5D2D213C25;
        Thu, 27 Jan 2022 17:33:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id nH79FXLX8mHfIgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 27 Jan 2022 17:33:38 +0000
Message-ID: <1bf686e4-6c22-47d9-d6e3-fd33faf59037@suse.cz>
Date:   Thu, 27 Jan 2022 18:33:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 55/66] mm/mempolicy: Use maple tree iterators instead
 of vma linked list
Content-Language: en-US
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Song Liu <songliubraving@fb.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
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
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
 <20211201142918.921493-56-Liam.Howlett@oracle.com>
 <10798a7d-e157-03c2-abf4-f005a3507cae@suse.cz>
 <20220126024819.i35wd6uxh463wkps@revolver>
 <3dc23bc9-2b0f-00af-f85b-22c270356e96@suse.cz>
 <20220127172516.dj7mditbishetlxv@revolver>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220127172516.dj7mditbishetlxv@revolver>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/27/22 18:25, Liam Howlett wrote:
> * Vlastimil Babka <vbabka@suse.cz> [220126 04:23]:
>> On 1/26/22 03:48, Liam Howlett wrote:
>> > * Vlastimil Babka <vbabka@suse.cz> [220120 06:58]:
>> >> On 12/1/21 15:30, Liam Howlett wrote:
>> >> > From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
>> >> > 
>> >> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
>> >> > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
>> >> > ---
>> >> >  mm/mempolicy.c | 53 ++++++++++++++++++++++++++------------------------
>> >> >  1 file changed, 28 insertions(+), 25 deletions(-)
>> >> > 
>> >> > diff --git a/mm/mempolicy.c b/mm/mempolicy.c
>> >> > index 10e9c87260ed..0e2d918f4f30 100644
>> >> > --- a/mm/mempolicy.c
>> >> > +++ b/mm/mempolicy.c
>> >> > @@ -377,9 +377,10 @@ void mpol_rebind_task(struct task_struct *tsk, const nodemask_t *new)
>> >> >  void mpol_rebind_mm(struct mm_struct *mm, nodemask_t *new)
>> >> >  {
>> >> >  	struct vm_area_struct *vma;
>> >> > +	MA_STATE(mas, &mm->mm_mt, 0, 0);
>> >> 
>> >> VMA_ITERATOR?
>> > 
>> > Yes, I will make this change.  Thanks.
>> > 
>> >> 
>> >> >  
>> >> >  	mmap_write_lock(mm);
>> >> > -	for (vma = mm->mmap; vma; vma = vma->vm_next)
>> >> > +	mas_for_each(&mas, vma, ULONG_MAX)
>> >> >  		mpol_rebind_policy(vma->vm_policy, new);
>> >> >  	mmap_write_unlock(mm);
>> >> >  }
>> >> > @@ -652,7 +653,7 @@ static unsigned long change_prot_numa(struct vm_area_struct *vma,
>> >> >  static int queue_pages_test_walk(unsigned long start, unsigned long end,
>> >> >  				struct mm_walk *walk)
>> >> >  {
>> >> > -	struct vm_area_struct *vma = walk->vma;
>> >> > +	struct vm_area_struct *next, *vma = walk->vma;
>> >> >  	struct queue_pages *qp = walk->private;
>> >> >  	unsigned long endvma = vma->vm_end;
>> >> >  	unsigned long flags = qp->flags;
>> >> > @@ -667,9 +668,10 @@ static int queue_pages_test_walk(unsigned long start, unsigned long end,
>> >> >  			/* hole at head side of range */
>> >> >  			return -EFAULT;
>> >> >  	}
>> >> > +	next = find_vma(vma->vm_mm, vma->vm_end);
>> >> >  	if (!(flags & MPOL_MF_DISCONTIG_OK) &&
>> >> >  		((vma->vm_end < qp->end) &&
>> >> > -		(!vma->vm_next || vma->vm_end < vma->vm_next->vm_start)))
>> >> > +		(!next || vma->vm_end < next->vm_start)))
>> >> >  		/* hole at middle or tail of range */
>> >> >  		return -EFAULT;
>> >> >  
>> >> > @@ -783,28 +785,24 @@ static int vma_replace_policy(struct vm_area_struct *vma,
>> >> >  static int mbind_range(struct mm_struct *mm, unsigned long start,
>> >> >  		       unsigned long end, struct mempolicy *new_pol)
>> >> >  {
>> >> > -	struct vm_area_struct *next;
>> >> > +	MA_STATE(mas, &mm->mm_mt, start - 1, start - 1);
>> >> >  	struct vm_area_struct *prev;
>> >> >  	struct vm_area_struct *vma;
>> >> >  	int err = 0;
>> >> >  	pgoff_t pgoff;
>> >> > -	unsigned long vmstart;
>> >> > -	unsigned long vmend;
>> >> > -
>> >> > -	vma = find_vma(mm, start);
>> >> > -	VM_BUG_ON(!vma);
>> >> >  
>> >> > -	prev = vma->vm_prev;
>> >> > -	if (start > vma->vm_start)
>> >> > -		prev = vma;
>> >> > +	prev = mas_find_rev(&mas, 0);
>> >> > +	if (prev && (start < prev->vm_end))
>> >> > +		vma = prev;
>> >> > +	else
>> >> > +		vma = mas_next(&mas, end - 1);
>> >> >  
>> >> > -	for (; vma && vma->vm_start < end; prev = vma, vma = next) {
>> >> > -		next = vma->vm_next;
>> >> > -		vmstart = max(start, vma->vm_start);
>> >> > -		vmend   = min(end, vma->vm_end);
>> >> > +	do {
>> >> > +		unsigned long vmstart = max(start, vma->vm_start);
>> >> > +		unsigned long vmend = min(end, vma->vm_end);
>> >> 
>> >> What if vma is null? Shouldn't this rather be a "for (; vma; vma =
>> >> mas_next(...)"
>> > 
>> > We have already found the vma above.
>> 
>> AFAICS if the range intersects no vmas, we might have found a 'prev', but
>> 'vma' might be NULL after the "vma = mas_next(&mas, end - 1);"?
> 
> Yes, I agree.  I was going to restore VM_BUG_ON(!vma) after mas_next(),
> but that's not the same as the existing code.  The VM_BUG_ON(!vma)
> only catches if we search for 'start' above any VMA.  It seems
> mbind_range() would have returned without error if there were no VMAs
> within the range but would error if the 'start' was sufficiently large.

Ah I missed there was a VM_BUG_ON(!vma) previously and that the callers seem
to only call mbind_range() if there's an actual vma in the range, so I guess
my suggestion was misguided.

> I think it is better to write it as you suggested to restore the
> functionality of not failing on an empty list.  I don't see a decent
> way of checking if we searched for an address above any VMA to restore
> the VM_BUG_ON() which existed - although I see little value in it to
> begin with.  I will mention this in the commit message.

