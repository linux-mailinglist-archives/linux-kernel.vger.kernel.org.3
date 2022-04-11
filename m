Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8809E4FBEE9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 16:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236656AbiDKOWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 10:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347254AbiDKOVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 10:21:44 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5AD632ECE
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 07:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=I/ZtqvD3xK3kfPk+73YTWW3kCWtR0aNVp8BTmJwEmOQ=; b=BkJMAp5B+oF01w97YWBr28PJby
        5Ldv/lPhedaO45v1JjAhAC5FZ5lkCA0W46PaVpZKi6lcpMwApAtmXwP7EHg8ulyC3acHcnm63yHXj
        MRMkeMK/YWsCUX4bCDawdy26eMIXjT8gCIMV4uIprZ1F6QRdeqqG8ybjQROty59vEpLYCLNUUNTbe
        3NGgUdfBBYB2mBg40gA2TPZ/sxApCLdr4gMw0dfpqpinXCY0pok60BBIWLhvbPuWC5ptPdssQ2zau
        OHCaTJEfQEQIFdd+Or7PaUshqxdnsk7t/Zp9W55JRuNMLsVqnZupsKErII+tF27Vmc+pbKd7zDjIm
        6nBx5o4g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ndusN-009MLx-T8; Mon, 11 Apr 2022 14:18:43 +0000
Date:   Mon, 11 Apr 2022 07:18:43 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, ying.huang@intel.com,
        songmuchun@bytedance.com, hch@infradead.org, willy@infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/9] mm/vmscan: remove unneeded can_split_huge_page
 check
Message-ID: <YlQ4w907eRUrBabJ@infradead.org>
References: <20220409093500.10329-1-linmiaohe@huawei.com>
 <20220409093500.10329-3-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220409093500.10329-3-linmiaohe@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 09, 2022 at 05:34:53PM +0800, Miaohe Lin wrote:
> We don't need to check can_split_folio() because folio_maybe_dma_pinned()
> is checked before. It will avoid the long term pinned pages to be swapped
> out. And we can live with short term pinned pages. Without can_split_folio
> checking we can simplify the code. Also activate_locked can be changed to
> keep_locked as it's just short term pinning.
> 
> Suggested-by: Huang, Ying <ying.huang@intel.com>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/vmscan.c | 22 ++++++++--------------
>  1 file changed, 8 insertions(+), 14 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 4a76be47bed1..01f5db75a507 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1711,20 +1711,14 @@ static unsigned int shrink_page_list(struct list_head *page_list,
>  					goto keep_locked;
>  				if (folio_maybe_dma_pinned(folio))
>  					goto keep_locked;
> -				if (PageTransHuge(page)) {
> -					/* cannot split THP, skip it */
> -					if (!can_split_folio(folio, NULL))
> -						goto activate_locked;
> -					/*
> -					 * Split pages without a PMD map right
> -					 * away. Chances are some or all of the
> -					 * tail pages can be freed without IO.
> -					 */
> -					if (!folio_entire_mapcount(folio) &&
> -					    split_folio_to_list(folio,
> -								page_list))
> -						goto activate_locked;
> -				}
> +				/*
> +				 * Split pages without a PMD map right
> +				 * away. Chances are some or all of the
> +				 * tail pages can be freed without IO.
> +				 */

This could use more of the line length and be more readable:

				/*
				 * Split pages without a PMD map right away.
				 * Chances are some or all of the tail pages
				 * can be freed without IO.
				 */

> +				if (PageTransHuge(page) && !folio_entire_mapcount(folio) &&

Please put the folio_entire_mapcoun ont a separate line to make this a
bit more redable.
