Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBC784950FA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 16:06:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376428AbiATPGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 10:06:24 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:34358 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376370AbiATPGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 10:06:23 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1AF5721903;
        Thu, 20 Jan 2022 15:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1642691182; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lIQAhEYERRJvCJA0WULnuFIcDRHsWaZaKgSKd7biLeQ=;
        b=U/oKPjg5TRw57PV4L4Nb8FFsP/xemlMdlo5n6feiEyFPDNuVbogMdtQPS6S5RkFcdPhLCZ
        IhrrEjxa3AgDMVhe5kRVo8z/Jtd3kjaolsixrtVZBqVD/6FdRQuQ3xHGvKz0ionngimnNQ
        YsFT67JLXvkuxl/WaN16VXCGg+G37Eo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1642691182;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lIQAhEYERRJvCJA0WULnuFIcDRHsWaZaKgSKd7biLeQ=;
        b=qUpzpbkE9GFA1IMvxSS/FN0mlqanl9NYTTOeKZjqOMk8+hfEdz/tdo4kPsdH9xafR36aVs
        so+Gdx0A3GhtK5Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B1AFE13BD2;
        Thu, 20 Jan 2022 15:06:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id lSuhKm166WGVMAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 20 Jan 2022 15:06:21 +0000
Message-ID: <3709289f-fe78-3e7a-649a-a38fb1b3329e@suse.cz>
Date:   Thu, 20 Jan 2022 16:06:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 64/66] nommu: Remove uses of VMA linked list
Content-Language: en-US
To:     Liam Howlett <liam.howlett@oracle.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Song Liu <songliubraving@fb.com>,
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
 <20211201142918.921493-65-Liam.Howlett@oracle.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20211201142918.921493-65-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/21 15:30, Liam Howlett wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> Use the maple tree or VMA iterator instead.  This is faster and will
> allow us to shrink the VMA.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

But I think some fixup needed:

> @@ -1456,12 +1458,14 @@ void exit_mmap(struct mm_struct *mm)
>  
>  	mm->total_vm = 0;
>  
> -	while ((vma = mm->mmap)) {
> -		mm->mmap = vma->vm_next;
> +	mmap_write_lock(mm);

If locking was missing, should have been added sooner than now?

> +	for_each_vma(vmi, vma) {
>  		delete_vma_from_mm(vma);
>  		delete_vma(mm, vma);
>  		cond_resched();
>  	}
> +	__mt_destroy(&mm->mm_mt);

And this at the point mm_mt was added?

> +	mmap_write_unlock(mm);
>  }
>  
>  int vm_brk(unsigned long addr, unsigned long len)

