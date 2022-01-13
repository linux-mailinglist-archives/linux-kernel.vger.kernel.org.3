Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 555EE48DAB0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 16:28:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236122AbiAMP2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 10:28:24 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:41658 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236108AbiAMP2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 10:28:23 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DED76210EC;
        Thu, 13 Jan 2022 15:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1642087702; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7cqrnRdh2pgxD32R7R/h/b7vRu6FcKgviKLP+6X2OXI=;
        b=sJ0Ijb4QKHeneUym0npkgsYuC6txsT4uz3G41uUp7KRSvjiCcOzTi8Iu8FY7knE+NUSvoE
        7dmfVva7qUfhdPWvYIh42oR1WpP1/flORLUsR0vNueBMhcU7dhJWgllUqoruQToyLUsGQE
        DFmoJmIUzLk+zoMf5de/GejzslNt1Sg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1642087702;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7cqrnRdh2pgxD32R7R/h/b7vRu6FcKgviKLP+6X2OXI=;
        b=8IRnTqIrOSlnvbWHgFXQfiwdJtMWSSOxvqd3/xVIOst406XIi1iV37xx0KwUEjDsK00wsW
        eALC398I+NF3d3Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 91F4C13B55;
        Thu, 13 Jan 2022 15:28:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SAKlIhZF4GFbGAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 13 Jan 2022 15:28:22 +0000
Message-ID: <d979a786-65da-11d6-8d81-14859f2c7d4d@suse.cz>
Date:   Thu, 13 Jan 2022 16:28:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v4 21/66] mm/mmap: Change do_brk_flags() to expand
 existing VMA and add do_brk_munmap()
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
 <20211201142918.921493-22-Liam.Howlett@oracle.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20211201142918.921493-22-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/21 15:29, Liam Howlett wrote:
> @@ -1989,6 +2013,7 @@ EXPORT_SYMBOL(get_unmapped_area);
>  struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long addr)
>  {
>  	struct vm_area_struct *vma;
> +	MA_STATE(mas, &mm->mm_mt, addr, addr);
>  
>  	mmap_assert_locked(mm);
>  	/* Check the cache first. */
> @@ -1996,7 +2021,7 @@ struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long addr)
>  	if (likely(vma))
>  		return vma;
>  
> -	vma = mt_find(&mm->mm_mt, &addr, ULONG_MAX);
> +	vma = mas_find(&mas, -1);
>  	if (vma)
>  		vmacache_update(addr, vma);
>  	return vma;

Oh and this change to find_vma() was supposed to go to the next patch, no?
