Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C729494E22
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 13:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243013AbiATMqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 07:46:07 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:48036 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241792AbiATMqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 07:46:06 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 35312218E8;
        Thu, 20 Jan 2022 12:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1642682765; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uDxHAmIgZRfOrZZ7G8d/IzuEHF8OI5iVQORd+3hPf0M=;
        b=jw3uTkYIljr03VsllR2n/LQizTKqcwoT10wxfyT1ja6m+H+DLXXZYVnJzuFqDApHxRb7uA
        6ahPT1H6vM5vwk20yrbHCM54mdXQLyHj7/Uy6U9HIsjmkc8ovEf5tCKucO7qKi6wRjjfmo
        yxz/Jx9T1l1oTgtr2T3Jtb0h/CiXGLs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1642682765;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uDxHAmIgZRfOrZZ7G8d/IzuEHF8OI5iVQORd+3hPf0M=;
        b=d66As84i5rNF+Y+4UEObXqNZUl6kTm93oAAmWPhT/sy87NIPb1/34bjpF968MqMPCwSQMX
        VkbQAP7KWlnIJ1Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CE8A513E9E;
        Thu, 20 Jan 2022 12:46:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fsmaMYxZ6WGvZwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 20 Jan 2022 12:46:04 +0000
Message-ID: <0f62ab3b-eee8-7465-bd5a-470e7e579ded@suse.cz>
Date:   Thu, 20 Jan 2022 13:46:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 62/66] mm/swapfile: Use maple tree iterator instead of
 vma linked list
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
 <20211201142918.921493-63-Liam.Howlett@oracle.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20211201142918.921493-63-Liam.Howlett@oracle.com>
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
>  mm/swapfile.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index e59e08ef46e1..21c88b0944f9 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -2103,15 +2103,18 @@ static int unuse_mm(struct mm_struct *mm, unsigned int type,
>  {
>  	struct vm_area_struct *vma;
>  	int ret = 0;
> +	MA_STATE(mas, &mm->mm_mt, 0, 0);
>  
>  	mmap_read_lock(mm);
> -	for (vma = mm->mmap; vma; vma = vma->vm_next) {
> +	mas_for_each(&mas, vma, ULONG_MAX) {
>  		if (vma->anon_vma) {
>  			ret = unuse_vma(vma, type, frontswap,
>  					fs_pages_to_unuse);
>  			if (ret)
>  				break;
>  		}
> +
> +		mas_pause(&mas);

AFAIU unnecessary for the resched as we don't drop anything and keep the
mmap_lock?
(and without that it could be VMA_ITERATOR?)

>  		cond_resched();
>  	}
>  	mmap_read_unlock(mm);

