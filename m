Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 387FF493F2C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 18:39:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356436AbiASRjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 12:39:20 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:36822 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356397AbiASRjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 12:39:18 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 628531F3BB;
        Wed, 19 Jan 2022 17:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1642613957; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7Qro480AA4cZI77Tk3jaiJ1tQjLMVKSsBsFc+NketX4=;
        b=nuViXcdglk4sy3cQXfASyPJJ0EiEKAulHnFl7H9iegiLT8IZrcLLIyIn9lkhpjozMU1brh
        IVAzVtqEitfYx4SJW19Q4vk3Ied0ewoe0Go9CANxGFiSTg8JUkORWvfBw32JntEWnvvfb4
        aAicAR1vJZfdczEInsNKAuZEPMLcr/U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1642613957;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7Qro480AA4cZI77Tk3jaiJ1tQjLMVKSsBsFc+NketX4=;
        b=Df4Cskz2BNBpSVEvVy5TQq506nWGmGF2EsOGwJ2P+jwC94jpiV+IoK9Wwu+n1mcCcwWX5L
        TtRZrARflli7bdAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1845213E15;
        Wed, 19 Jan 2022 17:39:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kIwiBcVM6GHGRgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 19 Jan 2022 17:39:17 +0000
Message-ID: <d81af37a-0ce7-c226-6ea1-e4ae6a15243b@suse.cz>
Date:   Wed, 19 Jan 2022 18:39:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 50/66] mm/gup: Use maple tree navigation instead of
 linked list
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
 <20211201142918.921493-51-Liam.Howlett@oracle.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20211201142918.921493-51-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/21 15:30, Liam Howlett wrote:
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Empty message.

> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> ---
>  mm/gup.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index 2c51e9748a6a..60892e5df6a2 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -1570,7 +1570,6 @@ int __mm_populate(unsigned long start, unsigned long len, int ignore_errors)
>  	long ret = 0;
>  
>  	end = start + len;
> -
>  	for (nstart = start; nstart < end; nstart = nend) {
>  		/*
>  		 * We want to fault in pages for [nstart; end) address range.
> @@ -1579,10 +1578,10 @@ int __mm_populate(unsigned long start, unsigned long len, int ignore_errors)
>  		if (!locked) {
>  			locked = 1;
>  			mmap_read_lock(mm);
> -			vma = find_vma(mm, nstart);
> +			vma = find_vma_intersection(mm, start, end);

Is it ok to use start instead of nstart? At least theoretically,
populate_vma_page_range() called later can reset locked to 0, so !locked
doesn't guarantee we are in the first iteration?

>  		} else if (nstart >= vma->vm_end)
> -			vma = vma->vm_next;
> -		if (!vma || vma->vm_start >= end)
> +			vma = find_vma(mm, vma->vm_end);
> +		if (!vma)
>  			break;
>  		/*
>  		 * Set [nstart; nend) to intersection of desired address

