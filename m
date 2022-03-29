Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E67804EAED5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 15:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237553AbiC2Nx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 09:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237697AbiC2Nw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 09:52:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C20381959C2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 06:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=57/4y/ohZjXaSPqFsFf+MEyeDJA1H5R3F1dc2TLdTvQ=; b=J+WxSsdP5WbMw6G0tUtNCsUaPs
        PwFa58iCP2s/bAtVgD95gOUEVStNvwoJ3MCKvME/CJLVs8Ohzi87+zVtjZ2+CZKiG0YSb5W7LUxay
        bviJEvD69mcdDeirE2f0Uydrbib/NqA5+UwlW3urkofgJziMT1j0useFfDtqwCUHXngiDA1A9l/VP
        JZIsigSM6fYx7WmS0ldjwqqjpPdikzRWh7qO9DGgU1UYdkjOitJyoDVh8GmN+pgKq4hcRBuh/ui4p
        bXUEUZXlfLUvJj72RaMLPVy11Oeu2U7Kg9qg+MCUFze4vVayNN1c5fKqV294c3AC7VSojYGVIsi6G
        V+BcgDzw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nZCF4-000KZD-AM; Tue, 29 Mar 2022 13:50:38 +0000
Date:   Tue, 29 Mar 2022 14:50:38 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] mm/vmscan: introduce helper function
 reclaim_page_list()
Message-ID: <YkMOrjhxkqMx45Es@casper.infradead.org>
References: <20220329132619.18689-1-linmiaohe@huawei.com>
 <20220329132619.18689-4-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220329132619.18689-4-linmiaohe@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2022 at 09:26:14PM +0800, Miaohe Lin wrote:
> -unsigned long reclaim_pages(struct list_head *page_list)
> +static inline unsigned int reclaim_page_list(struct list_head *page_list, struct pglist_data *pgdat)
>  {
> -	int nid = NUMA_NO_NODE;
> -	unsigned int nr_reclaimed = 0;
> -	LIST_HEAD(node_page_list);
>  	struct reclaim_stat dummy_stat;
> +	unsigned int nr_reclaimed;
>  	struct page *page;
> -	unsigned int noreclaim_flag;
>  	struct scan_control sc = {
>  		.gfp_mask = GFP_KERNEL,
>  		.may_writepage = 1,
> @@ -2529,6 +2526,24 @@ unsigned long reclaim_pages(struct list_head *page_list)
>  		.no_demotion = 1,
>  	};
>  
> +	nr_reclaimed = shrink_page_list(page_list, pgdat, &sc, &dummy_stat, false);
> +	while (!list_empty(page_list)) {
> +		page = lru_to_page(page_list);
> +		list_del(&page->lru);
> +		putback_lru_page(page);

Why wouldn't you use a folio here?

