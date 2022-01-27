Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 103EA49EA60
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 19:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239096AbiA0SbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 13:31:02 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:39532 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236760AbiA0SbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 13:31:01 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DC4841F387;
        Thu, 27 Jan 2022 18:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643308259; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3Arc4M++PherX4BsPPBRluYQqgtbEkO4SPBNsLBP7JM=;
        b=DPiQdoMJriwXpyO92BccfGSy5Z49kF1v4C6sCtI8NSNJLlXAsViF1CcjZmfaRjmtZsXe9b
        Mz7lHF3CRkt09PLh7yB81S1WN8f6GtyMbVk8+OIxXes/9FOtmW3VOna3mHlzMQJIAM7gYg
        /In3WKGbGusbHLMSYp0W+eVgMAh0a3k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643308259;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3Arc4M++PherX4BsPPBRluYQqgtbEkO4SPBNsLBP7JM=;
        b=LVhdUWN2KD0MgkPf4p6NXSR7xlPCJyIZTVaqo1dCFRuVpD5b4sYleddiB1J/K1I9Ke7XA1
        hNNN1a+xQkZ7BfAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8EDF413D4F;
        Thu, 27 Jan 2022 18:30:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id M4k1IuPk8mH3OgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 27 Jan 2022 18:30:59 +0000
Message-ID: <72cae3c0-e06e-4fe5-24d5-a2c94d99780f@suse.cz>
Date:   Thu, 27 Jan 2022 19:30:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 1/9] mm: add overflow and underflow checks for
 page->_refcount
Content-Language: en-US
To:     Pasha Tatashin <pasha.tatashin@soleen.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-m68k@lists.linux-m68k.org, anshuman.khandual@arm.com,
        willy@infradead.org, akpm@linux-foundation.org,
        william.kucharski@oracle.com, mike.kravetz@oracle.com,
        geert@linux-m68k.org, schmitzmic@gmail.com, rostedt@goodmis.org,
        mingo@redhat.com, hannes@cmpxchg.org, guro@fb.com,
        songmuchun@bytedance.com, weixugc@google.com, gthelen@google.com,
        rientjes@google.com, pjt@google.com, hughd@google.com
References: <20220126183429.1840447-1-pasha.tatashin@soleen.com>
 <20220126183429.1840447-2-pasha.tatashin@soleen.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220126183429.1840447-2-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/26/22 19:34, Pasha Tatashin wrote:
> The problems with page->_refcount are hard to debug, because usually
> when they are detected, the damage has occurred a long time ago. Yet,
> the problems with invalid page refcount may be catastrophic and lead to
> memory corruptions.
> 
> Reduce the scope of when the _refcount problems manifest themselves by
> adding checks for underflows and overflows into functions that modify
> _refcount.
> 
> Use atomic_fetch_* functions to get the old values of the _refcount,
> and use it to check for overflow/underflow.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>  include/linux/page_ref.h | 59 +++++++++++++++++++++++++++++-----------
>  1 file changed, 43 insertions(+), 16 deletions(-)
> 
> diff --git a/include/linux/page_ref.h b/include/linux/page_ref.h
> index 2e677e6ad09f..fe4864f7f69c 100644
> --- a/include/linux/page_ref.h
> +++ b/include/linux/page_ref.h
> @@ -117,7 +117,10 @@ static inline void init_page_count(struct page *page)
>  
>  static inline void page_ref_add(struct page *page, int nr)
>  {
> -	atomic_add(nr, &page->_refcount);
> +	int old_val = atomic_fetch_add(nr, &page->_refcount);
> +	int new_val = old_val + nr;
> +
> +	VM_BUG_ON_PAGE((unsigned int)new_val < (unsigned int)old_val, page);

This seems somewhat weird, as it will trigger not just on overflow, but also
if nr is negative. Which I think is valid usage, even though the function
has 'add' in name, because 'nr' is signed?

