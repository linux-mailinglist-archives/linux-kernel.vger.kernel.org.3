Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E600A478AAF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 12:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235949AbhLQL7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 06:59:08 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:47108 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235775AbhLQL7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 06:59:04 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6FB3B1F38A;
        Fri, 17 Dec 2021 11:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1639742342; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J0cZk/cuSPPU0AOymt5bcNioPCxRuI3L8/dpHnBNMXs=;
        b=AsnSrhfsEbHks1s9tLQYprozuEBMvcBt3Z0NEH6W5WYdztBTkXqsZfuZNfLp1XZrdGY2g8
        rQKpInv1Fk38hWzb0K+1oaMfZhBebSZLp5ZJEZxly5OtAa1kijSNid85p+DrTqzY5XE/kb
        inB/cCgboYMdcbdzeIhADGMn2GLiNmo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1639742342;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J0cZk/cuSPPU0AOymt5bcNioPCxRuI3L8/dpHnBNMXs=;
        b=fQGE5C6jAnWwLG3PxfhAWRiCUDZMmCLXss5Kh+UldWCMZhiGtup7MobQZQV3cns9jNV7BO
        AniCVrUPFDFqw4DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 27CD913C6F;
        Fri, 17 Dec 2021 11:59:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HwbgCIZ7vGGRWQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 17 Dec 2021 11:59:02 +0000
Message-ID: <1347d8f0-671f-35cf-e49d-9aa666c61eaf@suse.cz>
Date:   Fri, 17 Dec 2021 12:59:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v4 15/66] mm: Convert vma_lookup() to use the Maple Tree
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
 <20211201142918.921493-16-Liam.Howlett@oracle.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20211201142918.921493-16-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Re: subject. It already uses the Maple Tree via find_vma(). So more accurate
would be e.g. "to use mtree_load()"?

Note there's also the side-effect of not using vmacache anymore (which is
still used in find_vma()), thus again potentially biasing results of later
vmacache removal. But seems like vma_lookup() is not used from hotpaths, so
it should be fine.

On 12/1/21 15:29, Liam Howlett wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> Unlike the rbtree, the Maple Tree will return a NULL if there's
> nothing at a particular address.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  include/linux/mm.h | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 4d5ab70b1f6d..c28bd97a4ecd 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2845,12 +2845,7 @@ struct vm_area_struct *find_vma_intersection(struct mm_struct *mm,
>  static inline
>  struct vm_area_struct *vma_lookup(struct mm_struct *mm, unsigned long addr)
>  {
> -	struct vm_area_struct *vma = find_vma(mm, addr);
> -
> -	if (vma && addr < vma->vm_start)
> -		vma = NULL;
> -
> -	return vma;
> +	return mtree_load(&mm->mm_mt, addr);
>  }
>  
>  static inline unsigned long vm_start_gap(struct vm_area_struct *vma)

