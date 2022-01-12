Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4F0E48C7C9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 17:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354906AbiALQBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 11:01:10 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:45046 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354904AbiALQBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 11:01:06 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3048F218E7;
        Wed, 12 Jan 2022 16:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1642003265; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EQmq30EueErdT4273jGK5qYGu6Nc+PXgleFJQRKvmq0=;
        b=1XSqxQ93aR70hxul495A+TGZEf/C3xyfSAb9x5naKKcRGq9xnU/EZkYoaSYSWbY1qLbw4Z
        2iXj1A23pwzc/AyH+G9DaqB5K8WXzdM1zhy3N9MAmr8iBcTFcpRLAxtQjCI6ZOkjxw81H0
        7rSgoX9KtTtJvZrEc4hmM3mdkcupvdM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1642003265;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EQmq30EueErdT4273jGK5qYGu6Nc+PXgleFJQRKvmq0=;
        b=SaxcYLFICPWhub+W3LKCHEWc0uMXedb2Yhg47pSjtirkJerwlhBB4ztrM7QrLl0Hm1+ijQ
        806dQfKa2ZqZflBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DBC5113B77;
        Wed, 12 Jan 2022 16:01:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id XRW7NED73mE7NwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 12 Jan 2022 16:01:04 +0000
Message-ID: <705ac4ab-34fb-e60f-aceb-d46e1913a28e@suse.cz>
Date:   Wed, 12 Jan 2022 17:01:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v4 18/66] xen: Use vma_lookup() in privcmd_ioctl_mmap()
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
 <20211201142918.921493-19-Liam.Howlett@oracle.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20211201142918.921493-19-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/21 15:29, Liam Howlett wrote:
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> 
> vma_lookup() walks the VMA tree for a specific value, find_vma() will
> search the tree after walking to a specific value.  It is more efficient
> to only walk to the requested value as this case requires the address to
> equal the vm_start.

By that you mean the privcmd_ioctl_mmap() code checks msg->va !=
vma->vm_start and thus we know it's never interested the next vma, that
find_vma() can return if no vma covers the address?

> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  drivers/xen/privcmd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
> index 3369734108af..ad17166b0ef6 100644
> --- a/drivers/xen/privcmd.c
> +++ b/drivers/xen/privcmd.c
> @@ -282,7 +282,7 @@ static long privcmd_ioctl_mmap(struct file *file, void __user *udata)
>  						     struct page, lru);
>  		struct privcmd_mmap_entry *msg = page_address(page);
>  
> -		vma = find_vma(mm, msg->va);
> +		vma = vma_lookup(mm, msg->va);
>  		rc = -EINVAL;
>  
>  		if (!vma || (msg->va != vma->vm_start) || vma->vm_private_data)

