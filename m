Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43C6E59E9CD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 19:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbiHWReR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 13:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232404AbiHWRdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 13:33:13 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20BEA72FC0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 08:12:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C13811F8C0;
        Tue, 23 Aug 2022 15:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661267521; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=swl0ArwDJ9fYdGl9+sc2cIn33V7qnlspcwq64fzCXA4=;
        b=dZBF3VTSSiCBUwQ7srJtI4g56FuCHLt9c0BREgY+JUIqQpRGoPb4NZJpICbulz0m25lA0D
        8BJM4N8BQlgIav4zdMz8kknukd3Y6BRtrks+J7AdxKzgMZsAxx6bokpALMXF6eA3znXHOw
        iYvUnwMo7RAogjslO/VZf6WjOPZEJxs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661267521;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=swl0ArwDJ9fYdGl9+sc2cIn33V7qnlspcwq64fzCXA4=;
        b=b14Y4p1UIoZYqGPFtWZ1sDYjp//mkgulkjKpJqcY92E0Izppe/Dx1wGK3VNFLg9cy4jgHT
        g4euHe2F1fAWC6AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8AC9F13A89;
        Tue, 23 Aug 2022 15:12:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iQqwIEHuBGMjFgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 23 Aug 2022 15:12:01 +0000
Message-ID: <66e25026-a86a-0157-3671-cf66eb53964c@suse.cz>
Date:   Tue, 23 Aug 2022 17:12:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v4 17/17] mm/sl[au]b: check if large object is valid in
 __ksize()
Content-Language: en-US
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Marco Elver <elver@google.com>
References: <20220817101826.236819-1-42.hyeyoo@gmail.com>
 <20220817101826.236819-18-42.hyeyoo@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220817101826.236819-18-42.hyeyoo@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/17/22 12:18, Hyeonggon Yoo wrote:
> If address of large object is not beginning of folio or size of
> the folio is too small, it must be invalid. BUG() in such cases.
> 
> Cc: Marco Elver <elver@google.com>
> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/slab_common.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 9c273a5fb0d7..98d029212682 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -984,8 +984,11 @@ size_t __ksize(const void *object)
>  
>  	folio = virt_to_folio(object);
>  
> -	if (unlikely(!folio_test_slab(folio)))
> +	if (unlikely(!folio_test_slab(folio))) {
> +		BUG_ON(folio_size(folio) <= KMALLOC_MAX_CACHE_SIZE);
> +		BUG_ON(object != folio_address(folio));
>  		return folio_size(folio);
> +	}
>  
>  	return slab_ksize(folio_slab(folio)->slab_cache);
>  }

In light of latest Linus' rant on BUG_ON() [1] I'm changing it to WARN_ON
and return 0, as it was in v3.

[1] https://lore.kernel.org/all/CAHk-=wiEAH+ojSpAgx_Ep=NKPWHU8AdO3V56BXcCsU97oYJ1EA@mail.gmail.com/


diff --git a/mm/slab_common.c b/mm/slab_common.c
index 98d029212682..a80c3a5e194d 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -985,8 +985,10 @@ size_t __ksize(const void *object)
 	folio = virt_to_folio(object);
 
 	if (unlikely(!folio_test_slab(folio))) {
-		BUG_ON(folio_size(folio) <= KMALLOC_MAX_CACHE_SIZE);
-		BUG_ON(object != folio_address(folio));
+		if (WARN_ON(folio_size(folio) <= KMALLOC_MAX_CACHE_SIZE))
+			return 0;
+		if (WARN_ON(object != folio_address(folio)))
+			return 0;
 		return folio_size(folio);
 	}
 

