Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87FEA537436
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 07:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232499AbiE3FEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 01:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231760AbiE3FED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 01:04:03 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC30E42EF6
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 22:04:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E03C01F37E;
        Mon, 30 May 2022 05:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1653887038; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mt9ESQWdPN4Qvqe8W55b+0vSvSQfocvj6KdXxFfUoE0=;
        b=Cd4Vh7W9R5ntByBgZZmfCVHvoF9xBlkF6KpFzmgOqQjV7Gm5OE9GaBhOhSqDxMjyWWsYqM
        NpabE9eqC8Xrqj1gD4mmH6VGnK/1wyFV/sldmhRmoolMMzVIesfiFcIuEAhwp2jW+Lr+FC
        WZzWDBpDMw/s+dmowJdU7uS46RQB5t0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1653887038;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mt9ESQWdPN4Qvqe8W55b+0vSvSQfocvj6KdXxFfUoE0=;
        b=LIbDLIsHm2WcJYc0l1/LbDi7GTk6CowrHQguo2whaNDTIOC9Og9Hb6lhUUAuH2kR9UeXxi
        jfFx6Ef3h2Y++2Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8859813A84;
        Mon, 30 May 2022 05:03:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id oq35HD5QlGKcPwAAMHmgww
        (envelope-from <osalvador@suse.de>); Mon, 30 May 2022 05:03:58 +0000
Date:   Mon, 30 May 2022 07:03:56 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] mm/memory_hotplug: Drop 'reason' argument from
 check_pfn_span()
Message-ID: <YpRQPL7JKNGs63m+@localhost.localdomain>
References: <20220526021258.4030749-1-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220526021258.4030749-1-anshuman.khandual@arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 26, 2022 at 07:42:58AM +0530, Anshuman Khandual wrote:
> In check_pfn_span(), a 'reason' string is being used to recreate the caller
> function name, while printing the warning message. It is really unnecessary
> as the warning message could just be printed inside the caller depending on
> the return code. Currently there are just two callers for check_pfn_span()
> i.e  __add_pages() and __remove_pages(). Let's clean this up.
> 
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Acked-by: Oscar Salvador <osalvador@suse.de>

> ---
> Changes in V2:
> 
> - Fixed typo in commit message
> - Dropped using 'ret' to capture check_pfn_span() return value in __add_pages()
> 
> Changes in V1:
> 
> https://lore.kernel.org/all/20220525033910.3781764-1-anshuman.khandual@arm.com/
> 
>  mm/memory_hotplug.c | 20 +++++++++-----------
>  1 file changed, 9 insertions(+), 11 deletions(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 416b38ca8def..3b24386e9276 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -220,8 +220,7 @@ static void release_memory_resource(struct resource *res)
>  	kfree(res);
>  }
>  
> -static int check_pfn_span(unsigned long pfn, unsigned long nr_pages,
> -		const char *reason)
> +static int check_pfn_span(unsigned long pfn, unsigned long nr_pages)
>  {
>  	/*
>  	 * Disallow all operations smaller than a sub-section and only
> @@ -238,12 +237,8 @@ static int check_pfn_span(unsigned long pfn, unsigned long nr_pages,
>  		min_align = PAGES_PER_SUBSECTION;
>  	else
>  		min_align = PAGES_PER_SECTION;
> -	if (!IS_ALIGNED(pfn, min_align)
> -			|| !IS_ALIGNED(nr_pages, min_align)) {
> -		WARN(1, "Misaligned __%s_pages start: %#lx end: #%lx\n",
> -				reason, pfn, pfn + nr_pages - 1);
> +	if (!IS_ALIGNED(pfn, min_align) || !IS_ALIGNED(nr_pages, min_align))
>  		return -EINVAL;
> -	}
>  	return 0;
>  }
>  
> @@ -320,9 +315,10 @@ int __ref __add_pages(int nid, unsigned long pfn, unsigned long nr_pages,
>  		altmap->alloc = 0;
>  	}
>  
> -	err = check_pfn_span(pfn, nr_pages, "add");
> -	if (err)
> -		return err;
> +	if (check_pfn_span(pfn, nr_pages)) {
> +		WARN(1, "Misaligned %s start: %#lx end: #%lx\n", __func__, pfn, pfn + nr_pages - 1);
> +		return -EINVAL;
> +	}
>  
>  	for (; pfn < end_pfn; pfn += cur_nr_pages) {
>  		/* Select all remaining pages up to the next section boundary */
> @@ -518,8 +514,10 @@ void __remove_pages(unsigned long pfn, unsigned long nr_pages,
>  
>  	map_offset = vmem_altmap_offset(altmap);
>  
> -	if (check_pfn_span(pfn, nr_pages, "remove"))
> +	if (check_pfn_span(pfn, nr_pages)) {
> +		WARN(1, "Misaligned %s start: %#lx end: #%lx\n", __func__, pfn, pfn + nr_pages - 1);
>  		return;
> +	}
>  
>  	for (; pfn < end_pfn; pfn += cur_nr_pages) {
>  		cond_resched();
> -- 
> 2.20.1
> 

-- 
Oscar Salvador
SUSE Labs
