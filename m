Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78F4E490C95
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 17:39:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241108AbiAQQi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 11:38:59 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:38554 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240955AbiAQQi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 11:38:58 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DF10021128;
        Mon, 17 Jan 2022 16:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1642437536; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=46+aTYyORS42IEh3fuIrSiQpTrbZxIhHkbdtfpF5rr8=;
        b=SgGcyCqz70+ak+69wdrKJ8N4Mk//ON1ygriSE4RPO8ifMGEjyaWy+Gbe/TFZ+sV3MjhXTy
        JjObYt/cHRQjm2iuULSsS26rr2eML4CsfHaLMsNcyfnOaKkb+iHHvioaXoPKEJ+kBfqogf
        u9pKl+w5BGocnKd1OSOIeCLxaYyCBkU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1642437536;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=46+aTYyORS42IEh3fuIrSiQpTrbZxIhHkbdtfpF5rr8=;
        b=H2YJQNCjNpQnCidTAhsemTwTerFsEWE7n5xRtcIiciWvCQUy6AseSHTcSxayMG/IWvpdBE
        QteCQi4JenSdXWCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5821613DB5;
        Mon, 17 Jan 2022 16:38:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8sDAE6Cb5WHAZwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 17 Jan 2022 16:38:56 +0000
Message-ID: <d2520b56-953b-2552-149b-41f232a7fc0b@suse.cz>
Date:   Mon, 17 Jan 2022 17:38:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
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
 <20211201142918.921493-24-Liam.Howlett@oracle.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v4 23/66] mm/mmap: Use advanced maple tree API for
 mmap_region()
In-Reply-To: <20211201142918.921493-24-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/21 15:30, Liam Howlett wrote:
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> 
> Changing mmap_region() to use the maple tree state and the advanced
> maple tree interface allows for a lot less tree walking.
> 
> This change removes the last caller of munmap_vma_range(), so drop this
> unused function.
> 
> Add vma_expand() to expand a VMA if possible by doing the necessary
> hugepage check, uprobe_munmap of files, dcache flush, modifications then
> undoing the detaches, etc.
> 
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> ---
>  mm/mmap.c | 227 +++++++++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 175 insertions(+), 52 deletions(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index c06c5b850e1e..b0b7e327bf8b 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -496,29 +496,6 @@ static inline struct vm_area_struct *__vma_next(struct mm_struct *mm,
>  	return vma->vm_next;
>  }
>  
> -/*
> - * munmap_vma_range() - munmap VMAs that overlap a range.
> - * @mm: The mm struct
> - * @start: The start of the range.
> - * @len: The length of the range.
> - * @pprev: pointer to the pointer that will be set to previous vm_area_struct
> - *
> - * Find all the vm_area_struct that overlap from @start to
> - * @end and munmap them.  Set @pprev to the previous vm_area_struct.
> - *
> - * Returns: -ENOMEM on munmap failure or 0 on success.
> - */
> -static inline int
> -munmap_vma_range(struct mm_struct *mm, unsigned long start, unsigned long len,
> -		 struct vm_area_struct **pprev, struct list_head *uf)
> -{
> -	// Needs optimization.
> -	while (range_has_overlap(mm, start, start + len, pprev))
> -		if (do_munmap(mm, start, len, uf))
> -			return -ENOMEM;
> -	return 0;
> -}
> -
>  static unsigned long count_vma_pages_range(struct mm_struct *mm,
>  		unsigned long addr, unsigned long end)
>  {
> @@ -619,6 +596,101 @@ static void __insert_vm_struct(struct mm_struct *mm, struct vm_area_struct *vma)
>  	mm->map_count++;
>  }
>  
> +/*
> + * vma_expand - Expand an existing VMA
> + * @mas: The maple state
> + * @vma: The vma to expand
> + * @start: The start of the vma
> + * @end: The exclusive end of the vma
> + */

Looks like this, similarly to the brk case, replaces one path calling
vma_merge->__vma_adjust() with something else. But this one is better
encapsulated and visible, so less likely to be forgotten in case something
changes. Would be even better if the brk case used it too :) seems like it
doesn't, at least as of this patch.

But it would be great to improve the documentation here - some params are
not documented, notably 'next', and I would explicitly state which scenarios
it does cover - i.e. vma_merge() lists 8 scenarios and I assume this can
handlea subset of those?
And scenarios not covered could be VM_WARN_ON'd?
Without such stated assumptions, it's hard/impossible to review both the
implementation against them and, and the callers against them.

> +inline int vma_expand(struct ma_state *mas, struct vm_area_struct *vma,
> +		      unsigned long start, unsigned long end, pgoff_t pgoff,
> +		      struct vm_area_struct *next)
> +{
> +	struct mm_struct *mm = vma->vm_mm;
> +	struct address_space *mapping = NULL;
> +	struct rb_root_cached *root = NULL;
> +	struct anon_vma *anon_vma = vma->anon_vma;
> +	struct file *file = vma->vm_file;
> +	bool remove_next = false;
> +	int error;
> +
> +	if (next && (vma != next) && (end == next->vm_end)) {

For example here this suggests that a case of 'end > next->vm_end' case is
not covered? How do I know whether it's intended or a bug?

