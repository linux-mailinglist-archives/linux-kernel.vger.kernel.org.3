Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4C9358888A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 10:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232671AbiHCIPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 04:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbiHCIPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 04:15:35 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0BFE60D0
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 01:15:33 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 558AD1FED9;
        Wed,  3 Aug 2022 08:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1659514532; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aluuMVa/fjoydrBodCTg8q62SCW5RTs+YXF3mxxkRS4=;
        b=cWT3eTB9Y9vn1CONW64FqYinNeGYVTE3BryGQqVng0wVg7LOBtK03YpuqkkN8HZAw/3667
        jprj3Ljl8tKOupGlPzHVrMY0LMnWiwfMCLoFPf309N/9TC6ToIFULSiejDj/eniZLu7KuF
        7lcrYa47rNBVzvonJ52a00iF2b+4Ruk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1659514532;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aluuMVa/fjoydrBodCTg8q62SCW5RTs+YXF3mxxkRS4=;
        b=DdGJA6e9cbQxNXTW+KT0sh0zqj4KZeC6CM9LshXwnB8bWDN6FDxhZx/sbp0Vd39gLm4awp
        1lF/UJPTnbyY0pAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 373D813AD8;
        Wed,  3 Aug 2022 08:15:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yvjIDKQu6mIYYwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 03 Aug 2022 08:15:32 +0000
Message-ID: <6ac42cd6-9f93-e80c-0bd3-d0c9439cf327@suse.cz>
Date:   Wed, 3 Aug 2022 10:15:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] mm/page_alloc: only search higher order when fallback
Content-Language: en-US
To:     Abel Wu <wuyun.abel@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Muchun Song <songmuchun@bytedance.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220803025121.47018-1-wuyun.abel@bytedance.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220803025121.47018-1-wuyun.abel@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/3/22 04:51, Abel Wu wrote:
> It seems unnecessary to search pages with order < alloc_order in
> fallback allocation.

This can currently happen with ALLOC_NOFRAGMENT and alloc_order >
pageblock_order, so add a test to prevent it.

> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/page_alloc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index e008a3df0485..0abafc2fc3e0 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -2934,7 +2934,7 @@ __rmqueue_fallback(struct zone *zone, int order, int start_migratetype,
>  	 * i.e. orders < pageblock_order. If there are no local zones free,
>  	 * the zonelists will be reiterated without ALLOC_NOFRAGMENT.
>  	 */
> -	if (alloc_flags & ALLOC_NOFRAGMENT)
> +	if (order < pageblock_order && alloc_flags & ALLOC_NOFRAGMENT)
>  		min_order = pageblock_order;
>  
>  	/*

