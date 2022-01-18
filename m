Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2896492D91
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 19:41:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348197AbiARSlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 13:41:12 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:36520 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244842AbiARSlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 13:41:06 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C8DCD1F387;
        Tue, 18 Jan 2022 18:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1642531264; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WiZAbaUkkCR9DayrtrxsPPYnEDgf/ehZEdWU1oBVmnI=;
        b=VhtRtjhw3V/Uen9YPv1C3r+/2bCCHw1rN0VYEFIJij3WpiSW2h/Ju6ws3iT8t+CEqfzvjx
        uZ8LNm42GhKcE+ZWpr8IhWkx7PtVyKtDauf2qhPptbRDAGrBN1RRaL8J85qJZUOeFMweS7
        goLSDhGYYTviCMeJ2mbpRcPv3j1xFu4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1642531264;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WiZAbaUkkCR9DayrtrxsPPYnEDgf/ehZEdWU1oBVmnI=;
        b=zH4Mud/ppkYuTOyWk1SWDfaKsV/EpEg+UL4lVqU48S/YjTwERsClLNQjj2idMEMqGDSzeK
        4W8B5jx2FTpKtJAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7926B13DD4;
        Tue, 18 Jan 2022 18:41:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xjlfHMAJ52FTRAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 18 Jan 2022 18:41:04 +0000
Message-ID: <c7801c49-1eef-6363-079e-a810d4125e84@suse.cz>
Date:   Tue, 18 Jan 2022 19:41:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 36/66] um: Remove vma linked list walk
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
 <20211201142918.921493-37-Liam.Howlett@oracle.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20211201142918.921493-37-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/21 15:30, Liam Howlett wrote:
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> 
> Use the VMA iterator instead.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> ---
>  arch/um/kernel/tlb.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/um/kernel/tlb.c b/arch/um/kernel/tlb.c
> index bc38f79ca3a3..25f043037d76 100644
> --- a/arch/um/kernel/tlb.c
> +++ b/arch/um/kernel/tlb.c
> @@ -584,21 +584,19 @@ void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
>  
>  void flush_tlb_mm(struct mm_struct *mm)
>  {
> -	struct vm_area_struct *vma = mm->mmap;
> +	struct vm_area_struct *vma;
> +	VMA_ITERATOR(vmi, mm, 0);
>  
> -	while (vma != NULL) {
> +	for_each_vma(vmi, vma)
>  		fix_range(mm, vma->vm_start, vma->vm_end, 0);
> -		vma = vma->vm_next;
> -	}
>  }
>  
>  void force_flush_all(void)
>  {
>  	struct mm_struct *mm = current->mm;
> -	struct vm_area_struct *vma = mm->mmap;
> +	struct vm_area_struct *vma;
> +	MA_STATE(mas, &mm->mm_mt, 0, 0);
>  
> -	while (vma != NULL) {
> +	mas_for_each(&mas, vma, ULONG_MAX)

Is there a reason to use the iterator in one case and mas_for_each in the other?

>  		fix_range(mm, vma->vm_start, vma->vm_end, 1);
> -		vma = vma->vm_next;
> -	}
>  }

