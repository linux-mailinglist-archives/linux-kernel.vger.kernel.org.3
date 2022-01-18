Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBEFD4925CD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 13:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235912AbiARMhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 07:37:14 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:34004 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232927AbiARMhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 07:37:09 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0EA12212B6;
        Tue, 18 Jan 2022 12:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1642509428; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SNEC58rS3aMpa5aQF+lNjVQ2rcNGlXwF3hhx9FJryDM=;
        b=BxL46myvrZ8jINs0+F0VZO+cnWh4fKPgN/9huBOjLjX7dA3a3aKyebm/ya+CYLHWO6Rytk
        Ec381z810Xz8qosYFsA8KpV5yogj4pk84bxqW7gCUxV5qlZnK/fwpqg9xpoly2/6huqcAe
        ZcJFtEbqsCxgcJqJPt6RGZN+co8FISg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1642509428;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SNEC58rS3aMpa5aQF+lNjVQ2rcNGlXwF3hhx9FJryDM=;
        b=1Qed5gZFgSOc74RinDFazJxFOX+8yarq8ET6Iq4MWushzm7RBuKIo7FR3uQC8HXBmEncuz
        ZcyUrCEHC9WwGaBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AD8D413B26;
        Tue, 18 Jan 2022 12:37:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NAMyKXO05mEzdwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 18 Jan 2022 12:37:07 +0000
Message-ID: <d2f2fa1e-6f95-b49d-a358-c8f01d08b346@suse.cz>
Date:   Tue, 18 Jan 2022 13:37:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 34/66] cxl: Remove vma linked list walk
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
 <20211201142918.921493-35-Liam.Howlett@oracle.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20211201142918.921493-35-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/21 15:30, Liam Howlett wrote:
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> 
> Use the VMA iterator instead.  This requires a little restructuring
> of the surrounding code to hoist the mm to the caller.  That turns
> cxl_prefault_one() into a trivial function, so call cxl_fault_segment()
> directly.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> ---
>  drivers/misc/cxl/fault.c | 43 +++++++++++++---------------------------
>  1 file changed, 14 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/misc/cxl/fault.c b/drivers/misc/cxl/fault.c
> index 60c829113299..504522a126b5 100644
> --- a/drivers/misc/cxl/fault.c
> +++ b/drivers/misc/cxl/fault.c
> @@ -280,22 +280,6 @@ void cxl_handle_fault(struct work_struct *fault_work)
>  		mmput(mm);
>  }
>  
> -static void cxl_prefault_one(struct cxl_context *ctx, u64 ea)
> -{
> -	struct mm_struct *mm;
> -
> -	mm = get_mem_context(ctx);
> -	if (mm == NULL) {
> -		pr_devel("cxl_prefault_one unable to get mm %i\n",
> -			 pid_nr(ctx->pid));
> -		return;
> -	}
> -
> -	cxl_fault_segment(ctx, mm, ea);
> -
> -	mmput(mm);
> -}
> -
>  static u64 next_segment(u64 ea, u64 vsid)
>  {
>  	if (vsid & SLB_VSID_B_1T)
> @@ -306,23 +290,16 @@ static u64 next_segment(u64 ea, u64 vsid)
>  	return ea + 1;
>  }
>  
> -static void cxl_prefault_vma(struct cxl_context *ctx)
> +static void cxl_prefault_vma(struct cxl_context *ctx, struct mm_struct *mm)
>  {
>  	u64 ea, last_esid = 0;
>  	struct copro_slb slb;
> +	VMA_ITERATOR(vmi, mm, 0);
>  	struct vm_area_struct *vma;
>  	int rc;
> -	struct mm_struct *mm;
> -
> -	mm = get_mem_context(ctx);
> -	if (mm == NULL) {
> -		pr_devel("cxl_prefault_vm unable to get mm %i\n",
> -			 pid_nr(ctx->pid));
> -		return;
> -	}
>  
>  	mmap_read_lock(mm);
> -	for (vma = mm->mmap; vma; vma = vma->vm_next) {
> +	for_each_vma(vmi, vma) {
>  		for (ea = vma->vm_start; ea < vma->vm_end;
>  				ea = next_segment(ea, slb.vsid)) {
>  			rc = copro_calculate_slb(mm, ea, &slb);
> @@ -337,15 +314,21 @@ static void cxl_prefault_vma(struct cxl_context *ctx)
>  		}
>  	}
>  	mmap_read_unlock(mm);
> -
> -	mmput(mm);
>  }
>  
>  void cxl_prefault(struct cxl_context *ctx, u64 wed)
>  {
> +	struct mm_struct *mm = get_mem_context(ctx);
> +
> +	if (mm == NULL) {
> +		pr_devel("cxl_prefault unable to get mm %i\n",
> +			 pid_nr(ctx->pid));
> +		return;
> +	}
> +
>  	switch (ctx->afu->prefault_mode) {
>  	case CXL_PREFAULT_WED:
> -		cxl_prefault_one(ctx, wed);
> +		cxl_fault_segment(ctx, mm, wed);
>  		break;
>  	case CXL_PREFAULT_ALL:
>  		cxl_prefault_vma(ctx);

Need to pass mm here, compile tested much? :)

After fixup
Acked-by: Vlastimil Babka <vbabka@suse.cz>

> @@ -353,4 +336,6 @@ void cxl_prefault(struct cxl_context *ctx, u64 wed)
>  	default:
>  		break;
>  	}
> +
> +	mmput(mm);
>  }

