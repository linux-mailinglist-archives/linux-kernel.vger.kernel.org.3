Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58B4B533858
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 10:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232665AbiEYIZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 04:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiEYIZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 04:25:28 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 057717091F
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 01:25:27 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B2FDE218E5;
        Wed, 25 May 2022 08:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1653467125; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J8Z+G+PO5+Yg0Oo0eCVoS7RwcLsrpDjw672Ypw5MmRY=;
        b=bpN+BmT6Dai8KMk/Y06lwncNzHG9JGYPx7I5kCJuQ7o4a6shAls8i9nBx43Qq23zHtDXLy
        DszaGd06RgMqoHB3JNWerp3KF33XsgB3mqgwAQ64dLvAhkKodWk+7rLwG79y2t3t4Tx68X
        HpyonLK0ZjdKcrS94u1hnTplN6/X1rw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1653467125;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J8Z+G+PO5+Yg0Oo0eCVoS7RwcLsrpDjw672Ypw5MmRY=;
        b=JqpYoCuEgi5bDroGS3p3ROsKLUh8JvZrQZ4FadLQ+qgjCTV0dcyrDXUjQRHkTYb1EFcvGZ
        OguORljHIxf2FSDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2E5DF13ADF;
        Wed, 25 May 2022 08:25:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id axUvJPTnjWLiMwAAMHmgww
        (envelope-from <osalvador@suse.de>); Wed, 25 May 2022 08:25:24 +0000
Date:   Wed, 25 May 2022 10:25:21 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/memory_hotplug: Drop 'reason' argument from
 check_pfn_span()
Message-ID: <Yo3n8Zagb68zuMqa@localhost.localdomain>
References: <20220525033910.3781764-1-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220525033910.3781764-1-anshuman.khandual@arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2022 at 09:09:09AM +0530, Anshuman Khandual wrote:
> In check_pfn_span(), a 'reason' string is being used to recreate the caller
> function name, while printing the warning message. It is really unnecessary
> as the warning message could just be printed inside the caller depending on
> the return code. Currentlyy there are just two callers for check_pfn_span()
                   Currently
> i.e  __add_pages() and __remove_pages(). Let's clean this up.
> 
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

One could argue if this is really a cleanup.
I kind of agree that the "reason" thingy is a bit shaky, but instead of having a
single place where we call WARN(), we now do have two.

> ---
>  mm/memory_hotplug.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 416b38ca8def..9b3d7295ef93 100644
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
> @@ -320,9 +315,11 @@ int __ref __add_pages(int nid, unsigned long pfn, unsigned long nr_pages,
>  		altmap->alloc = 0;
>  	}
>  
> -	err = check_pfn_span(pfn, nr_pages, "add");
> -	if (err)
> +	err = check_pfn_span(pfn, nr_pages);
> +	if (err) {
> +		WARN(1, "Misaligned %s start: %#lx end: #%lx\n", __func__, pfn, pfn + nr_pages - 1);
>  		return err;
> +	}

If you want to further clean this up, I would just do 

 if (check_pfn_span()) {
         WARN(....)
         return -EINVAL;
 }

here as we do in __remove_pages(). check_pfn_span() can either return 0 or -EINVAL,
so I think it is fine.


-- 
Oscar Salvador
SUSE Labs
