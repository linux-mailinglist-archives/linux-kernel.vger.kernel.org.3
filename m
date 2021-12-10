Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23B0F47037D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 16:08:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242657AbhLJPMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 10:12:12 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:52720 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235073AbhLJPMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 10:12:10 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0E4AC210EC;
        Fri, 10 Dec 2021 15:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1639148914; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0J7C1DVuH6G9lkb9rEQNhK4iMKMidG0Qk/+x4tQVgfI=;
        b=jFr/yWX+Qniqvd+EagbZZJwoyuuoco53BKcW+WpJUdfIXzKnJF//7Ld+W678W9HH98xh6h
        EpMh4Buf2G1CpN5kk1fYl+BYHJN8J4wW5Cripfb2by1/WcePHwp4pB5nkjebg38Ehwi31W
        uc1qI/UvxCOe9REM6GJK8JE87l3lT8o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1639148914;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0J7C1DVuH6G9lkb9rEQNhK4iMKMidG0Qk/+x4tQVgfI=;
        b=k234DM0WzzxRxESAxeUxkto2hjmJK/qqMy2J1Uz/Rxf+WMomz2uCJ82BR+RqoLstJlMw85
        Jwtny7BGDX22JpBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AE9FA13E32;
        Fri, 10 Dec 2021 15:08:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sDLEKXFts2EQWQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 10 Dec 2021 15:08:33 +0000
Message-ID: <1d0b51de-59d0-c3f1-3136-4dabc2a873d1@suse.cz>
Date:   Fri, 10 Dec 2021 16:08:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
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
 <20211201142918.921493-8-Liam.Howlett@oracle.com>
 <f68de664-434b-d8f4-44a2-cbb0090abb87@suse.cz>
 <20211210020243.jciodseey2ckf2sk@revolver>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v4 07/66] mm: Add VMA iterator
In-Reply-To: <20211210020243.jciodseey2ckf2sk@revolver>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/21 03:02, Liam Howlett wrote:
> 
> vma_find() uses mas_find() which was created to implement find_vma().
> As a replacement, the search looks for an entry at the address and if
> nothing exists, it will continue the search upwards.  The result is that
> the first entry can be found at the address passed.  Every subsequent
> call to vma_find() would search from the end of the previous range - as
> saved in the maple state, or the vma iterator in this case.
> 
> mas_next(), however is more of a traditional linked list operation that
> finds the next entry _after_ the one containing the index in the maple
> state.  The only difference is on the start when the maple state is not
> currently pointing at an entry at all (the node is set to MAS_START).
> 
> mas_find() can be thought of as:
> 
> entry = mas_walk();
> if (!entry)
> 	entry = mas_next_entry();
> 
> return entry;
> 
> 
> mas_next can be though to as:
> 
> if (mas_is_start())
> 	mas_walk();
> 
> return mas_next_entry();
> 
> 
> Matthew uses mas_find() for his implementation of the vma iterator so
> that the first entry is not skipped.

Yeah, but if vma_next() is going to replace the cases where we already have
a vma and use vma->vm_next to get the next one, then mas_next() would be a
better fit?

Do I understand correctly that e.g. after a mas_pause(), vma_next() done via
max_next() might return the same vma again, while vma_prev() will not, and
vma_next() implemented by mas_next() also wouldn't? Isn't that unexpected
semantics?

>> 
>> > +}
>> > +
>> > +static inline struct vm_area_struct *vma_prev(struct vma_iterator *vmi)
>> > +{
>> > +	return mas_prev(&vmi->mas, 0);
>> > +}
>> > +
>> > +static inline unsigned long vma_iter_addr(struct vma_iterator *vmi)
>> > +{
>> > +	return vmi->mas.index;
>> > +}
>> > +
>> > +#define for_each_vma(vmi, vma)		while ((vma = vma_next(&vmi)) != NULL)
>> > +

