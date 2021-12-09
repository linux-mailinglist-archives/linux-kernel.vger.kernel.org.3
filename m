Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A70146EB1D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 16:26:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239483AbhLIPaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 10:30:09 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:57434 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236184AbhLIPaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 10:30:08 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 44084210FD;
        Thu,  9 Dec 2021 15:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1639063594; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/VlSP1skdj+sAAa5O9Ry2NezQRyqLlQFjUyMBZbONA0=;
        b=o81hRcfHyTPjWYhYrrYl39hEtO7vz40SrOg6M2DWfm/3/p7kYLZ8afVguWly9X3Mjx+LHI
        dklamRhRCA3WdWzEGVnMHILZAlZVz+qc0YCXNt80hEFA5F3THEL6R5pXQfs1VUU+dOIZCD
        dkXKY3N3ZSdVjtFddYxrR1u4hOyC2zk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1639063594;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/VlSP1skdj+sAAa5O9Ry2NezQRyqLlQFjUyMBZbONA0=;
        b=+wWyReEM6eATLVcSJaIsJUBCuXRaDlHOfS0UoHG+6bidiqgJibZ3/mD2Eiv4KalVhvBEH2
        EerisIuoCh62ZVBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E7CFC13343;
        Thu,  9 Dec 2021 15:26:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id J5fONykgsmEZRAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 09 Dec 2021 15:26:33 +0000
Message-ID: <f68de664-434b-d8f4-44a2-cbb0090abb87@suse.cz>
Date:   Thu, 9 Dec 2021 16:26:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v4 07/66] mm: Add VMA iterator
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
 <20211201142918.921493-8-Liam.Howlett@oracle.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20211201142918.921493-8-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/21 15:29, Liam Howlett wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> This thin layer of abstraction over the maple tree state is for
> iterating over VMAs.  You can go forwards, go backwards or ask where
> the iterator is.  Rename the existing vma_next() to __vma_next() --
> it will be removed by the end of this series.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

With a question below.

> ---
>  include/linux/mm.h       | 27 +++++++++++++++++++++++++++
>  include/linux/mm_types.h | 21 +++++++++++++++++++++
>  mm/mmap.c                | 10 +++++-----
>  3 files changed, 53 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 9eae78a155be..acdccbe9b96b 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -696,6 +696,33 @@ static inline bool vma_is_accessible(struct vm_area_struct *vma)
>  	return vma->vm_flags & VM_ACCESS_FLAGS;
>  }
>  
> +static inline
> +struct vm_area_struct *vma_find(struct vma_iterator *vmi, unsigned long max)
> +{
> +	return mas_find(&vmi->mas, max);
> +}
> +
> +static inline struct vm_area_struct *vma_next(struct vma_iterator *vmi)
> +{
> +	return vma_find(vmi, ULONG_MAX);

Why not mas_next()?

> +}
> +
> +static inline struct vm_area_struct *vma_prev(struct vma_iterator *vmi)
> +{
> +	return mas_prev(&vmi->mas, 0);
> +}
> +
> +static inline unsigned long vma_iter_addr(struct vma_iterator *vmi)
> +{
> +	return vmi->mas.index;
> +}
> +
> +#define for_each_vma(vmi, vma)		while ((vma = vma_next(&vmi)) != NULL)
> +
