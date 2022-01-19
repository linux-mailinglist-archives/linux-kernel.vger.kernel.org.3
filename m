Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A641493873
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 11:31:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353734AbiASKbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 05:31:49 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:39078 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353717AbiASKbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 05:31:47 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 51C50212C5;
        Wed, 19 Jan 2022 10:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1642588306; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X9qRWH+x26Qr4u/Aa2LMbQyTGFT6n1/mH2BEEh9FOqg=;
        b=HoStwcSgLsublhBPtczgpImjMbXlE20cbFON5N3Tj2AtyKgDWRZTCiBlDqXzi/Si02jNqd
        6L+C+sa7O8D8n25a1S0WptGfp81SoDTRVDJDdmhnUJIvTCFg/GIr4wgiY00SwxVixfZvAl
        Zns/wjbl16KE8KA0lqSEbpQ95MURbWQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1642588306;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X9qRWH+x26Qr4u/Aa2LMbQyTGFT6n1/mH2BEEh9FOqg=;
        b=8TNgaCECyqe9pGDTpnk2f8H2flmFYqzscLzpyTw2VdpafTgZUXwi9m8he1KEI4VkNp2q0M
        W7h0tXQrTRcT4GAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 098F113B3D;
        Wed, 19 Jan 2022 10:31:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id dfmyAZLo52EaSwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 19 Jan 2022 10:31:46 +0000
Message-ID: <381fab01-322a-a48a-0b27-ef7c95c3269f@suse.cz>
Date:   Wed, 19 Jan 2022 11:31:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
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
 <20211201142918.921493-39-Liam.Howlett@oracle.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v4 38/66] coredump: Remove vma linked list walk
In-Reply-To: <20211201142918.921493-39-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/21 15:30, Liam Howlett wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> Use the Maple Tree iterator instead.  This is too complicated for the
> VMA iterator to handle, so let's open-code it for now.  If this turns
> out to be a common pattern, we can migrate it to common code.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> ---
>  fs/coredump.c | 33 ++++++++++++---------------------
>  1 file changed, 12 insertions(+), 21 deletions(-)
> 
> diff --git a/fs/coredump.c b/fs/coredump.c
> index a6b3c196cdef..59347e42048d 100644
> --- a/fs/coredump.c
> +++ b/fs/coredump.c
> @@ -997,30 +997,20 @@ static unsigned long vma_dump_size(struct vm_area_struct *vma,
>  	return vma->vm_end - vma->vm_start;
>  }
>  
> -static struct vm_area_struct *first_vma(struct task_struct *tsk,
> -					struct vm_area_struct *gate_vma)
> -{
> -	struct vm_area_struct *ret = tsk->mm->mmap;
> -
> -	if (ret)
> -		return ret;
> -	return gate_vma;
> -}
> -
>  /*
>   * Helper function for iterating across a vma list.  It ensures that the caller
>   * will visit `gate_vma' prior to terminating the search.
>   */
> -static struct vm_area_struct *next_vma(struct vm_area_struct *this_vma,
> +static struct vm_area_struct *coredump_next_vma(struct ma_state *mas,
> +				       struct vm_area_struct *vma,
>  				       struct vm_area_struct *gate_vma)
>  {
> -	struct vm_area_struct *ret;
> -
> -	ret = this_vma->vm_next;
> -	if (ret)
> -		return ret;
> -	if (this_vma == gate_vma)
> +	if (vma == gate_vma)
>  		return NULL;
> +
> +	vma = mas_next(mas, ULONG_MAX);
> +	if (vma)
> +		return vma;

This looks suspicious. Before this patch if gate_vma was part of the linked
list, it was returned. Even more than once if it was not the last vma in the
list. After this patch, if it's part of the maple tree, it will not be
returned and the iteration will stop.

But I don't know what are the rules for gate_vma being part of linked
list/maple tree, thus whether this is a bug.

>  	return gate_vma;
>  }
>  
> @@ -1032,9 +1022,10 @@ int dump_vma_snapshot(struct coredump_params *cprm, int *vma_count,
>  		      struct core_vma_metadata **vma_meta,
>  		      size_t *vma_data_size_ptr)
>  {
> -	struct vm_area_struct *vma, *gate_vma;
> +	struct vm_area_struct *gate_vma, *vma = NULL;
>  	struct mm_struct *mm = current->mm;
> -	int i;
> +	MA_STATE(mas, &mm->mm_mt, 0, 0);
> +	int i = 0;
>  	size_t vma_data_size = 0;
>  
>  	/*
> @@ -1054,8 +1045,7 @@ int dump_vma_snapshot(struct coredump_params *cprm, int *vma_count,
>  		return -ENOMEM;
>  	}
>  
> -	for (i = 0, vma = first_vma(current, gate_vma); vma != NULL;
> -			vma = next_vma(vma, gate_vma), i++) {
> +	while ((vma = coredump_next_vma(&mas, vma, gate_vma)) != NULL) {
>  		struct core_vma_metadata *m = (*vma_meta) + i;
>  
>  		m->start = vma->vm_start;
> @@ -1064,6 +1054,7 @@ int dump_vma_snapshot(struct coredump_params *cprm, int *vma_count,
>  		m->dump_size = vma_dump_size(vma, cprm->mm_flags);
>  
>  		vma_data_size += m->dump_size;
> +		i++;
>  	}
>  
>  	mmap_write_unlock(mm);

