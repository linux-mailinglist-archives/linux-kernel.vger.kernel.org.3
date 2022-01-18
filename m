Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A04C94925AC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 13:24:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240048AbiARMX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 07:23:57 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:54434 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234413AbiARMXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 07:23:52 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5D40C1F3B5;
        Tue, 18 Jan 2022 12:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1642508630; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c2B9KKsJn7oOo7jGQCOwOyWoEN/ZY+AiAjhSRRVU+n0=;
        b=CUCJLb/E3Xw86ur1WZwNAMdN0t7VedxvIIWp9YVdwpW4paxW3c2gqitWhfd60lMPPQichd
        tUCRvBgYo3VkJnHBKGy3CWJnvC1ONzLRYx8KPbJNVljKet7HNkjvz0i4eQEd2EcSIwd1lx
        NK1dtY8CcADUeTxnkzlw0Euq+/nOpeg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1642508630;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c2B9KKsJn7oOo7jGQCOwOyWoEN/ZY+AiAjhSRRVU+n0=;
        b=ByVWsNnRpY/QKTq7naBB/xuz2wpZCB7j3uXN1RqlrTISJvJAqcFmWUu3hCcMFLAW1OA3aW
        kzYkNdRUnuEk0mCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 12E9913B26;
        Tue, 18 Jan 2022 12:23:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7F6kA1ax5mGbbwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 18 Jan 2022 12:23:50 +0000
Message-ID: <c4c90bfb-5e94-84fb-aec8-cc0edb9b7efb@suse.cz>
Date:   Tue, 18 Jan 2022 13:23:49 +0100
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
 <20211201142918.921493-34-Liam.Howlett@oracle.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v4 33/66] xtensa: Remove vma linked list walks
In-Reply-To: <20211201142918.921493-34-Liam.Howlett@oracle.com>
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
>  arch/xtensa/kernel/syscall.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/xtensa/kernel/syscall.c b/arch/xtensa/kernel/syscall.c
> index 201356faa7e6..20ec9534e01f 100644
> --- a/arch/xtensa/kernel/syscall.c
> +++ b/arch/xtensa/kernel/syscall.c
> @@ -58,6 +58,7 @@ unsigned long arch_get_unmapped_area(struct file *filp, unsigned long addr,
>  		unsigned long len, unsigned long pgoff, unsigned long flags)
>  {
>  	struct vm_area_struct *vmm;
> +	VMA_ITERATOR(vmi, mm, addr)

Need to use current->mm or it won't compile, AFAICS.

;
>  
>  	if (flags & MAP_FIXED) {
>  		/* We do not accept a shared mapping if it would violate
> @@ -79,7 +80,7 @@ unsigned long arch_get_unmapped_area(struct file *filp, unsigned long addr,
>  	else
>  		addr = PAGE_ALIGN(addr);
>  
> -	for (vmm = find_vma(current->mm, addr); ; vmm = vmm->vm_next) {
> +	for_each_vma(vmi, vmm) {
>  		/* At this point:  (!vmm || addr < vmm->vm_end). */

Well if at this point !vmm then we are no longer here due to for_each_vma().

>  		if (TASK_SIZE - len < addr)
>  			return -ENOMEM;

Thus we can miss this? But maybe it could be moved above the for loop and
checked just once, as addr only grows inside the for loop?

However, the loop body continues:

>                 if (!vmm || addr + len <= vm_start_gap(vmm))
>                         return addr;

So after your patch we fail to return the unmapped area after the last vma.
