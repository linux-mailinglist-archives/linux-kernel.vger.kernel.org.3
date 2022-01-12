Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09B5948C3A9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 13:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353042AbiALMCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 07:02:53 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:46750 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238445AbiALMCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 07:02:52 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 621D6212B9;
        Wed, 12 Jan 2022 12:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1641988971; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n+59rJBwctDoSj/i+J2rIOGwlUS0RjFt7ifzYzr3zkY=;
        b=Pm4vqpxNdY6fIT08ycXx4weQM4/Cn8Qd2+iD3pq9j8aWRR8J9TYqjNlGVonO5j8i3hHkmB
        GzT8DU2U9h11/gAvEeqs+92xcTt3owflRErGGe19vc6bxZgT/9Vi5kE/DFimv/TZq0Q+S9
        OoKiH4T6oJPQTNhSOB2GT1T/jZE5Bes=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1641988971;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n+59rJBwctDoSj/i+J2rIOGwlUS0RjFt7ifzYzr3zkY=;
        b=5rgszTlOr88ppCNjI6I68viCe/ir49l1mluBTezyO5lNk+A9YW8siKkPBWc1J3vzHJ87RX
        2XMFNR7fzUKeXlBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 16C6E13B42;
        Wed, 12 Jan 2022 12:02:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id StndBGvD3mFhJwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 12 Jan 2022 12:02:51 +0000
Message-ID: <77fc73e7-f6c4-27ea-66ef-63f61e0929eb@suse.cz>
Date:   Wed, 12 Jan 2022 13:02:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v4 16/66] mm: Remove rb tree.
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
 <20211201142918.921493-17-Liam.Howlett@oracle.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20211201142918.921493-17-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/21 15:29, Liam Howlett wrote:
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> 
> Remove the RB tree and start using the maple tree for vm_area_struct
> tracking.
> 
> Drop validate_mm() calls in expand_upwards() and expand_downwards() as
> the lock is not held.
> 
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  arch/x86/kernel/tboot.c    |   1 -
>  drivers/firmware/efi/efi.c |   1 -
>  include/linux/mm.h         |   2 -
>  include/linux/mm_types.h   |  14 --
>  kernel/fork.c              |   8 -
>  mm/init-mm.c               |   2 -
>  mm/mmap.c                  | 496 ++++++++-----------------------------
>  mm/nommu.c                 |  88 ++-----
>  mm/util.c                  |   8 +
>  9 files changed, 136 insertions(+), 484 deletions(-)

Nice stats.

Wanted to suggest splitting out the swith to range_has_overlap() but I think
I see how it's not feasible.

> diff --git a/mm/util.c b/mm/util.c
> index e58151a61255..ab02382c2d57 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -287,6 +287,8 @@ void __vma_link_list(struct mm_struct *mm, struct vm_area_struct *vma,
>  	vma->vm_next = next;
>  	if (next)
>  		next->vm_prev = vma;
> +	else
> +		mm->highest_vm_end = vm_end_gap(vma);
>  }
>  
>  void __vma_unlink_list(struct mm_struct *mm, struct vm_area_struct *vma)
> @@ -301,6 +303,12 @@ void __vma_unlink_list(struct mm_struct *mm, struct vm_area_struct *vma)
>  		mm->mmap = next;
>  	if (next)
>  		next->vm_prev = prev;
> +	else {

Nit: style suggests that once else is { } block then if block should be too,
even though it remains a single line.

> +		if (prev)
> +			mm->highest_vm_end = vm_end_gap(prev);
> +		else
> +			mm->highest_vm_end = 0;
> +	}
>  }
>  
>  /* Check if the vma is being used as a stack by this task */

