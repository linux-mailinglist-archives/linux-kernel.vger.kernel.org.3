Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF8F5538D47
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 10:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244991AbiEaI4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 04:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233830AbiEaI4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 04:56:38 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D87938FFB6
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 01:56:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 86D2C1F975;
        Tue, 31 May 2022 08:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1653987394; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9Holi8WFcRRs2SBumcgZOpppBJDzx0jCIMI4rlCkjmY=;
        b=oY0WVqHGEUGdSpZh8ADVsO97wS/tQ1QCcyzbZEedjjQBJrQ1kE+xvyqQciIgCeSl/Tvf2e
        R7KXu9YZNaHIcF/w/iLIR5K6prHInRH1xT2/KnIUSpIb3RIdobCQT51JVrSAgCw3SrBa2X
        6Q6N1BITChk+32ujBPFPDwbGM33jxbU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1653987394;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9Holi8WFcRRs2SBumcgZOpppBJDzx0jCIMI4rlCkjmY=;
        b=SP3kEsYuGUsw8sbI7sgdD++c7pUR9sMzWN2FQ/cUS6Oj+2E6nI5YSaZaFCgA4h93RPEDc/
        Hy4y+YO8bQGbH4AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 935C513AA2;
        Tue, 31 May 2022 08:56:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RuIyIUHYlWLOfwAAMHmgww
        (envelope-from <osalvador@suse.de>); Tue, 31 May 2022 08:56:33 +0000
Date:   Tue, 31 May 2022 10:56:31 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Zi Yan <ziy@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Qian Cai <quic_qiancai@quicinc.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Eric Ren <renzhengeek@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH] mm: page_isolation: use compound_nr() correctly in
 isolate_single_pageblock()
Message-ID: <YpXYP9cJJo7dj12E@localhost.localdomain>
References: <20220531024450.2498431-1-zi.yan@sent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220531024450.2498431-1-zi.yan@sent.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 30, 2022 at 10:44:50PM -0400, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> When compound_nr(page) was used, page was not guaranteed to be the head
> of the compound page and it could cause an infinite loop. Fix it by calling
> it on the head page.
> 
> Fixes: b2c9e2fbba32 ("mm: make alloc_contig_range work at pageblock granularity")
> Reported-by: Anshuman Khandual <anshuman.khandual@arm.com>
> Link: https://lore.kernel.org/linux-mm/20220530115027.123341-1-anshuman.khandual@arm.com/
> Signed-off-by: Zi Yan <ziy@nvidia.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

> ---
>  mm/page_isolation.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
> index 6021f8444b5a..d200d41ad0d3 100644
> --- a/mm/page_isolation.c
> +++ b/mm/page_isolation.c
> @@ -385,9 +385,9 @@ static int isolate_single_pageblock(unsigned long boundary_pfn, int flags,
>  		 * above do the rest. If migration is not possible, just fail.
>  		 */
>  		if (PageCompound(page)) {
> -			unsigned long nr_pages = compound_nr(page);
>  			struct page *head = compound_head(page);
>  			unsigned long head_pfn = page_to_pfn(head);
> +			unsigned long nr_pages = compound_nr(head);
>  
>  			if (head_pfn + nr_pages <= boundary_pfn) {
>  				pfn = head_pfn + nr_pages;
> -- 
> 2.35.1
> 

-- 
Oscar Salvador
SUSE Labs
