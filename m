Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D59552CFA2
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 11:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236228AbiESJpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 05:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbiESJpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 05:45:38 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F319170904
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 02:45:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B04081F7AB;
        Thu, 19 May 2022 09:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1652953535; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iT9kRUwiyxxUSpnNf8Ny1b4Sc9C5VIYIhqK0/GwAUAI=;
        b=TGyFepsYj68kJ9HulgzE3EwIoy6sDCdr46aZu8LoBwMzdYsjFraX0PBtazePpMl7qlpOIs
        jGdArDfcNvtFjG+nwAjbY/O9hrMz0sTDx/Zn1TC4D+s6p4we257SKgTM4KrSQzvs2U/ZYK
        Yspgj/2LYR4LtIAF996fnD/sSBOIFi0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1652953535;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iT9kRUwiyxxUSpnNf8Ny1b4Sc9C5VIYIhqK0/GwAUAI=;
        b=UnytVQjSWvwo6TxK+6C4QbpQ0d+Ay+lTReNp0NlF/n0Kz22PGQLsX2T9XtmgZC6wrA3loQ
        F5WWZ6cHh3CdFoDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 877A713456;
        Thu, 19 May 2022 09:45:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9ND2H78RhmLFNQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 19 May 2022 09:45:35 +0000
Message-ID: <80c89ad9-17ec-8d64-3774-821451e147c4@suse.cz>
Date:   Thu, 19 May 2022 11:45:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 2/6] mm/page_alloc: Use only one PCP list for THP-sized
 allocations
Content-Language: en-US
To:     Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
References: <20220512085043.5234-1-mgorman@techsingularity.net>
 <20220512085043.5234-3-mgorman@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220512085043.5234-3-mgorman@techsingularity.net>
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

On 5/12/22 10:50, Mel Gorman wrote:
> The per_cpu_pages is cache-aligned on a standard x86-64 distribution
> configuration but a later patch will add a new field which would push
> the structure into the next cache line. Use only one list to store
> THP-sized pages on the per-cpu list. This assumes that the vast majority
> of THP-sized allocations are GFP_MOVABLE but even if it was another type,
> it would not contribute to serious fragmentation that potentially causes
> a later THP allocation failure. Align per_cpu_pages on the cacheline
> boundary to ensure there is no false cache sharing.
> 
> After this patch, the structure sizing is;
> 
> struct per_cpu_pages {
>         int                        count;                /*     0     4 */
>         int                        high;                 /*     4     4 */
>         int                        batch;                /*     8     4 */
>         short int                  free_factor;          /*    12     2 */
>         short int                  expire;               /*    14     2 */
>         struct list_head           lists[13];            /*    16   208 */
> 
>         /* size: 256, cachelines: 4, members: 6 */
>         /* padding: 32 */
> } __attribute__((__aligned__(64)));
> 
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> Tested-by: Minchan Kim <minchan@kernel.org>
> Acked-by: Minchan Kim <minchan@kernel.org>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  include/linux/mmzone.h | 11 +++++++----
>  mm/page_alloc.c        |  4 ++--
>  2 files changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 962b14d403e8..abe530748de6 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -358,15 +358,18 @@ enum zone_watermarks {
>  };
>  
>  /*
> - * One per migratetype for each PAGE_ALLOC_COSTLY_ORDER plus one additional
> - * for pageblock size for THP if configured.
> + * One per migratetype for each PAGE_ALLOC_COSTLY_ORDER. One additional list
> + * for THP which will usually be GFP_MOVABLE. Even if it is another type,
> + * it should not contribute to serious fragmentation causing THP allocation
> + * failures.
>   */
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  #define NR_PCP_THP 1
>  #else
>  #define NR_PCP_THP 0
>  #endif
> -#define NR_PCP_LISTS (MIGRATE_PCPTYPES * (PAGE_ALLOC_COSTLY_ORDER + 1 + NR_PCP_THP))
> +#define NR_LOWORDER_PCP_LISTS (MIGRATE_PCPTYPES * (PAGE_ALLOC_COSTLY_ORDER + 1))
> +#define NR_PCP_LISTS (NR_LOWORDER_PCP_LISTS + NR_PCP_THP)
>  
>  /*
>   * Shift to encode migratetype and order in the same integer, with order
> @@ -392,7 +395,7 @@ struct per_cpu_pages {
>  
>  	/* Lists of pages, one per migrate type stored on the pcp-lists */
>  	struct list_head lists[NR_PCP_LISTS];
> -};
> +} ____cacheline_aligned_in_smp;
>  
>  struct per_cpu_zonestat {
>  #ifdef CONFIG_SMP
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index f58f85fdb05f..5851ee88a89c 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -648,7 +648,7 @@ static inline unsigned int order_to_pindex(int migratetype, int order)
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  	if (order > PAGE_ALLOC_COSTLY_ORDER) {
>  		VM_BUG_ON(order != pageblock_order);
> -		base = PAGE_ALLOC_COSTLY_ORDER + 1;
> +		return NR_LOWORDER_PCP_LISTS;
>  	}
>  #else
>  	VM_BUG_ON(order > PAGE_ALLOC_COSTLY_ORDER);
> @@ -662,7 +662,7 @@ static inline int pindex_to_order(unsigned int pindex)
>  	int order = pindex / MIGRATE_PCPTYPES;
>  
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> -	if (order > PAGE_ALLOC_COSTLY_ORDER)
> +	if (pindex == NR_LOWORDER_PCP_LISTS)
>  		order = pageblock_order;
>  #else
>  	VM_BUG_ON(order > PAGE_ALLOC_COSTLY_ORDER);

