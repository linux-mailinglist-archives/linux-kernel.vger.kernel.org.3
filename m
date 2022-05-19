Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4E0752D26D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 14:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbiESM0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 08:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237909AbiESM0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 08:26:13 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A05163BA70
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 05:26:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1535F1FA1F;
        Thu, 19 May 2022 12:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1652963170; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=St4z8AfblGmvqzbUxJh1IMUZIs7c2S6glVT6K7wgV4Y=;
        b=RjJKfoRagOlZSNpaiRvHF5ajP1C1v5f0dHqiQQl3CtxeyUeMpfazEqgeuMbyTevJUO/EHx
        Ojbjf/18KOESz5qkLkrSruIJvnRQTbR2RxZ/vtWhcdrju1QXzFhByFvz4Yzq8QiORYftbk
        4pBlCbNcSU1AEH2yrtZczn4d/+ATFV0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1652963170;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=St4z8AfblGmvqzbUxJh1IMUZIs7c2S6glVT6K7wgV4Y=;
        b=51harBtCuZH/JcSw6uOuRESvg0/5o13Bes9SXTjVcPgFPS8vIU0vQgBB0Wv34UJ4uTeKUC
        ewbR+s9FsPZQ+UAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DD63613456;
        Thu, 19 May 2022 12:26:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xcHeNGE3hmJYBwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 19 May 2022 12:26:09 +0000
Message-ID: <1b478a71-7de1-2097-7006-634d51f3fda1@suse.cz>
Date:   Thu, 19 May 2022 14:26:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 4/6] mm/page_alloc: Remove unnecessary page == NULL check
 in rmqueue
Content-Language: en-US
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
References: <20220512085043.5234-1-mgorman@techsingularity.net>
 <20220512085043.5234-5-mgorman@techsingularity.net>
 <5a0c9b7c-3620-3e0f-7510-d0fc3fa6ceda@suse.cz>
 <20220519121341.GV3441@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220519121341.GV3441@techsingularity.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/19/22 14:13, Mel Gorman wrote:
> On Thu, May 19, 2022 at 12:57:01PM +0200, Vlastimil Babka wrote:
>> On 5/12/22 10:50, Mel Gorman wrote:
>>> The VM_BUG_ON check for a valid page can be avoided with a simple
>>> change in the flow. The ZONE_BOOSTED_WATERMARK is unlikely in general
>>> and even more unlikely if the page allocation failed so mark the
>>> branch unlikely.
>>
>> Hm, so that makes a DEBUG_VM config avoid the check. On the other hand,
>> it puts it on the path returning from rmqueue_pcplist() for all configs,
>> and that should be the fast path. So unless things further change in the
>> following patches, it doesn't seem that useful?
>>
> 
> You're right -- the fast path ends up with both a if
> (page) and if (!page) checks. Andrew, can you drop the patch
> mm-page_alloc-remove-unnecessary-page-==-null-check-in-rmqueue.patch from
> your tree please?
> 
> Originally the flow was important when I was writing the patch and later
> became unnecessary. However, it reminded me of another problem I thought
> of when writing this and then forgotten to note it in the changelog. If
> the page allocation fails then ZONE_BOOSTED_WATERMARK should still be
> tested and cleared before waking kswapd. It could happen if an allocation
> attempt tried to fallback to another migratetype and still fail to find
> a suitable page. This is true whether going through the PCP lists or not.
> 
> So what do you think of me adding this patch to a follow-up series?

LGTM.

> 
> --8<--
> mm/page_alloc: Remove mistaken page == NULL check in rmqueue
> 
> If a page allocation fails, the ZONE_BOOSTER_WATERMARK should be tested,
> cleared and kswapd woken whether the allocation attempt was via the PCP
> or directly via the buddy list.
> 
> Remove the page == NULL so the ZONE_BOOSTED_WATERMARK bit is checked
> unconditionally. As it is unlikely that ZONE_BOOSTED_WATERMARK is set,
> mark the branch accordingly.
> 
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/page_alloc.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 1c4c54503a5d..61d5bc2efffe 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -3765,12 +3765,10 @@ struct page *rmqueue(struct zone *preferred_zone,
>  
>  	page = rmqueue_buddy(preferred_zone, zone, order, alloc_flags,
>  							migratetype);
> -	if (unlikely(!page))
> -		return NULL;
>  
>  out:
>  	/* Separate test+clear to avoid unnecessary atomics */
> -	if (test_bit(ZONE_BOOSTED_WATERMARK, &zone->flags)) {
> +	if (unlikely(test_bit(ZONE_BOOSTED_WATERMARK, &zone->flags))) {
>  		clear_bit(ZONE_BOOSTED_WATERMARK, &zone->flags);
>  		wakeup_kswapd(zone, 0, 0, zone_idx(zone));
>  	}
> 

