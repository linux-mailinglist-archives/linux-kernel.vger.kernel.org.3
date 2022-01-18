Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB9DC492D12
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 19:15:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347865AbiARSPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 13:15:34 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:40090 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236648AbiARSPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 13:15:32 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E04F9212B8;
        Tue, 18 Jan 2022 18:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1642529730; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1ceYZmzAXYnHxSVUqh34MAPVnCq8FmQFJc0WiDhWpRc=;
        b=cQ7eWAx75L/YMSsO46wZHaf8GIhzeSQi2QFfciCkf+9GlmBIXCPvSJbBAHamKzETaKBV89
        xN8VULsjuh/8bUgBtXnLziO8oImK0LEfez8+J6Q42kFi+4GlvTw+u6pd7UOeFJpiRJ3zJe
        3xgBV+fSEW13mIAhBGv2H4Inhlb1b0s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1642529730;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1ceYZmzAXYnHxSVUqh34MAPVnCq8FmQFJc0WiDhWpRc=;
        b=5OH1NygMNTFTyuet+4ok0/7KndOPzudsgQaCizPBgStLRv76bwXN6DW3FiVqA8OVTQvJ5F
        J7pSB1pubN4qEwBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 91E6013AC9;
        Tue, 18 Jan 2022 18:15:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id DoHKIsID52G+OQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 18 Jan 2022 18:15:30 +0000
Message-ID: <412d2736-8a51-2360-431c-26978af1ecf7@suse.cz>
Date:   Tue, 18 Jan 2022 19:15:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 35/66] optee: Remove vma linked list walk
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
 <20211201142918.921493-36-Liam.Howlett@oracle.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20211201142918.921493-36-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/21 15:30, Liam Howlett wrote:
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> 
> Use the VMA iterator instead.  Change the calling convention of
> __check_mem_type() to pass in the mm instead of the first vma in the
> range.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  drivers/tee/optee/call.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
> index b25cc1fac945..177575c445de 100644
> --- a/drivers/tee/optee/call.c
> +++ b/drivers/tee/optee/call.c
> @@ -342,15 +342,18 @@ static bool is_normal_memory(pgprot_t p)
>  #endif
>  }
>  
> -static int __check_mem_type(struct vm_area_struct *vma, unsigned long end)
> +static int __check_mem_type(struct mm_struct *mm, unsigned long start,
> +				unsigned long end)
>  {
> -	while (vma && is_normal_memory(vma->vm_page_prot)) {
> -		if (vma->vm_end >= end)
> -			return 0;
> -		vma = vma->vm_next;
> +	struct vm_area_struct *vma;
> +	VMA_ITERATOR(vmi, mm, start);
> +
> +	for_each_vma_range(vmi, vma, end) {
> +		if (!is_normal_memory(vma->vm_page_prot))
> +			return -EINVAL;
>  	}
>  
> -	return -EINVAL;
> +	return 0;
>  }
>  
>  int optee_check_mem_type(unsigned long start, size_t num_pages)
> @@ -366,8 +369,7 @@ int optee_check_mem_type(unsigned long start, size_t num_pages)
>  		return 0;
>  
>  	mmap_read_lock(mm);
> -	rc = __check_mem_type(find_vma(mm, start),
> -			      start + num_pages * PAGE_SIZE);
> +	rc = __check_mem_type(mm, start, start + num_pages * PAGE_SIZE);
>  	mmap_read_unlock(mm);
>  
>  	return rc;

