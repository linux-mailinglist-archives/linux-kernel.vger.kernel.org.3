Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75DC54952DD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 18:06:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377214AbiATRG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 12:06:27 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:47138 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243979AbiATRG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 12:06:26 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A705F21923;
        Thu, 20 Jan 2022 17:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1642698385; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cXz02UyD8cIbOQQZPbROB09tychDefhAh9aq7UM2Y7A=;
        b=EM7y7490Ebku75fSgL/AyiRihLakefHh0s8/9SF/gILgFDQYiUf5WJzZl3sUnqKtNs23kA
        w7O9oHwnHCrFYdPAhIvYLB7T8YYAFRbgkOYcna3jXG1sS3Ma+sdNi21Eh7MDYbVFMMxVDF
        KyvbjBDikiKyAPcJ21lK0MtMRDLRsCk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1642698385;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cXz02UyD8cIbOQQZPbROB09tychDefhAh9aq7UM2Y7A=;
        b=8xS5qDSj7H5Tj8bs8AsZ7/rK9TyIAj0DqmSf7ysyom3C1Yyngixsf5aB9X66iVTz8MLy0S
        f2KM6/oypCnlWgAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5E7B513E8A;
        Thu, 20 Jan 2022 17:06:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 3lhEFpGW6WGSbAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 20 Jan 2022 17:06:25 +0000
Message-ID: <56968b52-8629-2751-6a95-3bffa84a2326@suse.cz>
Date:   Thu, 20 Jan 2022 18:06:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 64/66] nommu: Remove uses of VMA linked list
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
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
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
 <20211201142918.921493-65-Liam.Howlett@oracle.com>
 <3709289f-fe78-3e7a-649a-a38fb1b3329e@suse.cz>
 <YemFpinGspNII+hl@casper.infradead.org>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <YemFpinGspNII+hl@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/20/22 16:54, Matthew Wilcox wrote:
> On Thu, Jan 20, 2022 at 04:06:21PM +0100, Vlastimil Babka wrote:
>> On 12/1/21 15:30, Liam Howlett wrote:
>> > From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
>> > 
>> > Use the maple tree or VMA iterator instead.  This is faster and will
>> > allow us to shrink the VMA.
>> > 
>> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
>> > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
>> 
>> Acked-by: Vlastimil Babka <vbabka@suse.cz>
>> 
>> But I think some fixup needed:
>> 
>> > @@ -1456,12 +1458,14 @@ void exit_mmap(struct mm_struct *mm)
>> >  
>> >  	mm->total_vm = 0;
>> >  
>> > -	while ((vma = mm->mmap)) {
>> > -		mm->mmap = vma->vm_next;
>> > +	mmap_write_lock(mm);
>> 
>> If locking was missing, should have been added sooner than now?
> 
> I don't think so?  This is the exit_mmap() path, so we know nobody
> has access to the mm.  We didn't need to hold the lock at this point
> before, but now for_each_vma() will check we're holding the mmap_lock.

It has crossed my mind that it is there to make asserts happy, in which case
a clarifying comment would be useful.

>> > +	for_each_vma(vmi, vma) {
>> >  		delete_vma_from_mm(vma);
>> >  		delete_vma(mm, vma);
>> >  		cond_resched();
>> >  	}
>> > +	__mt_destroy(&mm->mm_mt);
>> 
>> And this at the point mm_mt was added?
> 
> You mean we should have been calling __mt_destroy() earlier in the
> patch series?

Yeah.

> Umm ... I'll defer to Liam on that one.



