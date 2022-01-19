Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA532493EC2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 18:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356308AbiASRE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 12:04:58 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:36568 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243725AbiASREs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 12:04:48 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 89F6A212B8;
        Wed, 19 Jan 2022 17:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1642611887; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g9GPJtSRBrxq0XYoAYj2t+6J2AVPeRhCP1E2uDPVjzg=;
        b=UopGHcxfj4rTt7fNB2JNb9xB9tyW4x6PLiBZ/42NX/N67wr4yMmgFBBodCSacQ1VgaSht+
        gwkHfJukxrCpkReeQZMv16q4QKj4bJWI9c+oty0G7QW7IdplaCq4b9gE7lHuvUf35luuDG
        X5SQRWtl3oyUNDwgdPcrFDNrvxmZH+U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1642611887;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g9GPJtSRBrxq0XYoAYj2t+6J2AVPeRhCP1E2uDPVjzg=;
        b=MH7XWizwNzW9L4onstNWZn1HWbzqhjU02iD3nlyuL0nBmiOi5Bd9d6i/2sFRUGMGz8CRV7
        /74lFjeuxUg1T1BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3A46313E15;
        Wed, 19 Jan 2022 17:04:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fMW8DK9E6GFqNgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 19 Jan 2022 17:04:47 +0000
Message-ID: <57e33b08-f578-b84d-664b-939d9100d54d@suse.cz>
Date:   Wed, 19 Jan 2022 18:04:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 49/66] bpf: Remove VMA linked list
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
 <20211201142918.921493-50-Liam.Howlett@oracle.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20211201142918.921493-50-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/21 15:30, Liam Howlett wrote:
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> 
> Use vma_next() and remove reference to the start of the linked list
> 
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> ---
>  kernel/bpf/task_iter.c | 21 ++++-----------------
>  1 file changed, 4 insertions(+), 17 deletions(-)
> 
> diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
> index b48750bfba5a..2d964743f1e6 100644
> --- a/kernel/bpf/task_iter.c
> +++ b/kernel/bpf/task_iter.c
> @@ -299,8 +299,8 @@ struct bpf_iter_seq_task_vma_info {
>  };
>  
>  enum bpf_task_vma_iter_find_op {
> -	task_vma_iter_first_vma,   /* use mm->mmap */
> -	task_vma_iter_next_vma,    /* use curr_vma->vm_next */
> +	task_vma_iter_first_vma,   /* use find_vma() with addr 0 */
> +	task_vma_iter_next_vma,    /* use vma_next() with curr_vma */
>  	task_vma_iter_find_vma,    /* use find_vma() to find next vma */
>  };
>  
> @@ -400,24 +400,11 @@ task_vma_seq_get_next(struct bpf_iter_seq_task_vma_info *info)
>  
>  	switch (op) {
>  	case task_vma_iter_first_vma:
> -		curr_vma = curr_task->mm->mmap;
> +		curr_vma = find_vma(curr_task->mm, 0);
>  		break;
>  	case task_vma_iter_next_vma:
> -		curr_vma = curr_vma->vm_next;
> -		break;
>  	case task_vma_iter_find_vma:
> -		/* We dropped mmap_lock so it is necessary to use find_vma
> -		 * to find the next vma. This is similar to the  mechanism
> -		 * in show_smaps_rollup().
> -		 */
> -		curr_vma = find_vma(curr_task->mm, info->prev_vm_end - 1);
> -		/* case 1) and 4.2) above just use curr_vma */
> -
> -		/* check for case 2) or case 4.1) above */
> -		if (curr_vma &&
> -		    curr_vma->vm_start == info->prev_vm_start &&
> -		    curr_vma->vm_end == info->prev_vm_end)
> -			curr_vma = curr_vma->vm_next;
> +		curr_vma = find_vma(curr_task->mm, curr_vma->vm_end);

Are you sure curr_vma is valid here and we can read its vm_end? Because I
have no idea, but lots of doubts.

>  		break;
>  	}
>  	if (!curr_vma) {

