Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C595494DE2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 13:27:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242137AbiATM1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 07:27:45 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:37016 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232146AbiATM1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 07:27:44 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 36B0A1F3AA;
        Thu, 20 Jan 2022 12:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1642681663; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NymTDre5i6YMhXOHXf85vTj6gDABODo1HKBgVHkUdOk=;
        b=ajovI1EnlRa84W/90koDqKORZNc8O/cduxa3xdES8kiiAHnS6SS+atUBbEjs/fwsQ7S5hV
        6Xcpj6R2Nak73l4VDC/R88ULyTpRllitT97cMGqSYa7R9JK4Iv6Jc750/qX2DS49EsQlbR
        NamtxQcksSPuhORsoE51noKfycXka0c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1642681663;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NymTDre5i6YMhXOHXf85vTj6gDABODo1HKBgVHkUdOk=;
        b=Vkti1i+Pe0vqpsTrtNOb708/kkCDTmVkbqsX5/oxi2BGh79/bHI4yxKzRJuocVnlmc+8qU
        yiml9ZRLdryFPMBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E462F13B51;
        Thu, 20 Jan 2022 12:27:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id g+ENNz5V6WHrXgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 20 Jan 2022 12:27:42 +0000
Message-ID: <60a15c8b-c70b-0fd5-287e-d37d2107bf04@suse.cz>
Date:   Thu, 20 Jan 2022 13:27:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 58/66] mm/mremap: Use vma_find() instead of vma linked
 list
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
 <20211201142918.921493-59-Liam.Howlett@oracle.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20211201142918.921493-59-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/21 15:30, Liam Howlett wrote:
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> 
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/mremap.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/mremap.c b/mm/mremap.c
> index b09e107cd18b..4ad39c985d04 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -713,7 +713,7 @@ static unsigned long move_vma(struct vm_area_struct *vma,
>  	if (excess) {
>  		vma->vm_flags |= VM_ACCOUNT;
>  		if (split)
> -			vma->vm_next->vm_flags |= VM_ACCOUNT;
> +			find_vma(mm, vma->vm_end)->vm_flags |= VM_ACCOUNT;
>  	}
>  
>  	return new_addr;
> @@ -869,9 +869,11 @@ static unsigned long mremap_to(unsigned long addr, unsigned long old_len,
>  static int vma_expandable(struct vm_area_struct *vma, unsigned long delta)
>  {
>  	unsigned long end = vma->vm_end + delta;
> +	struct vm_area_struct *next;
>  	if (end < vma->vm_end) /* overflow */
>  		return 0;
> -	if (vma->vm_next && vma->vm_next->vm_start < end) /* intersection */
> +	next = find_vma(vma->vm_mm, vma->vm_end);
> +	if (next && next->vm_start < end) /* intersection */

Could just use find_vma_intersection()?

>  		return 0;
>  	if (get_unmapped_area(NULL, vma->vm_start, end - vma->vm_start,
>  			      0, MAP_FIXED) & ~PAGE_MASK)

