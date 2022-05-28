Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 246FB536DC0
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 18:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238415AbiE1Q1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 12:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238380AbiE1Q12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 12:27:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4378140EB
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 09:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YTEqwGZRFNtxwUVIHGKs3ZV8xkp5O0m4kBntoOiZZ5o=; b=UoeecDCn63hZqFXDKKu7wml7az
        aDkNJDVHKkIbDz8zPADZEFb1GVkC1iDSW/wo/oVZVfKPaeL5U8zf3LLVvPIV976inQkhlPGwWjWIz
        Vyi8oJ5PnQrmx03jNiZz9XrRMd7rKu9eTJDoSu1/v4MdHy52iXnNUvkn4M07+kmwWjnhrxUXr3Wab
        H6crFaO+FEyTxl+NUvcDe2CZwvn/Q2MrILFQF0b1K9h6udPL7zyzJAX9aykBFoBUfLu26YTLwPr/r
        Kvi43yU6VV/nosb6HooM/lQa2dP8IUh6YE8SHkm7mE4YlaufDp0nraysMwsmQkf+NTGl8VaE8obkv
        AYTjZpmg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nuzHT-002yuE-Gc; Sat, 28 May 2022 16:27:11 +0000
Date:   Sat, 28 May 2022 17:27:11 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     bh1scw@gmail.com
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH] mm/slub: replace alloc_pages with folio_alloc
Message-ID: <YpJNX7PN8hAFgVwj@casper.infradead.org>
References: <20220528161157.3934825-1-bh1scw@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220528161157.3934825-1-bh1scw@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 29, 2022 at 12:11:58AM +0800, bh1scw@gmail.com wrote:
> From: Fanjun Kong <bh1scw@gmail.com>
> 
> This patch will use folio allocation functions for allocating pages.

That's not actually a good idea.  folio_alloc() will do the
prep_transhuge_page() step which isn't needed for slab.

> Signed-off-by: Fanjun Kong <bh1scw@gmail.com>
> ---
>  mm/slub.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index e5535020e0fd..00c4049a17d6 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -1794,9 +1794,9 @@ static inline struct slab *alloc_slab_page(gfp_t flags, int node,
>  	unsigned int order = oo_order(oo);
>  
>  	if (node == NUMA_NO_NODE)
> -		folio = (struct folio *)alloc_pages(flags, order);
> +		folio = (struct folio *)folio_alloc(flags, order);
>  	else
> -		folio = (struct folio *)__alloc_pages_node(node, flags, order);
> +		folio = (struct folio *)__folio_alloc_node(node, flags, order);
>  
>  	if (!folio)
>  		return NULL;
> -- 
> 2.36.0
> 
> 
