Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE8A94FBE69
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 16:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346977AbiDKONZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 10:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346961AbiDKONW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 10:13:22 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35CF1BE03
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 07:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nzg4iE1+vDnobxL+x/8BGospZE26iFX69h+xdGnSEJQ=; b=DaawSJGn0Xk4L9uUaRoIE2f2Ed
        kYFvwL2L61aKJblxMt6UbsV/mr9PdaRqA2kABIayXFjk+qb5OxxLWndAtd7vRxR8/hn9T51yHnL2P
        N7F+UGOjY7P7WnY3Sja164ZbV5JuB5mr11vexOz0EUvwLyzXAhZj7IxpRzp3Ds+IQ+wdtzCCFStb3
        RhDm8AczOzESjdEQ2MzljewU76Hgz+wFYcF0Ncrc9G8vi020Ro34/UBDG2U0jaAkJIIIVzCOZ6NZL
        3LhH5+Ounv1yTOvJhxJtzItzgcYS+QE2ZvCqJSc1IlKqiQEcf8LpkqEZG/xnrpyn0FHAvaOaYeLL/
        iAqRxzlA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ndukk-009JZ3-EY; Mon, 11 Apr 2022 14:10:50 +0000
Date:   Mon, 11 Apr 2022 07:10:50 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, mike.kravetz@oracle.com,
        shy828301@gmail.com, willy@infradead.org, ying.huang@intel.com,
        ziy@nvidia.com, minchan@kernel.org, apopple@nvidia.com,
        dave.hansen@linux.intel.com, o451686892@gmail.com,
        jhubbard@nvidia.com, peterx@redhat.com, naoya.horiguchi@nec.com,
        mhocko@suse.com, riel@redhat.com, osalvador@suse.de,
        david@redhat.com, sfr@canb.auug.org.au, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] mm/migration: return errno when isolate_huge_page
 failed
Message-ID: <YlQ26kP8zpCLWqwW@infradead.org>
References: <20220409073846.22286-1-linmiaohe@huawei.com>
 <20220409073846.22286-4-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220409073846.22286-4-linmiaohe@huawei.com>
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

On Sat, Apr 09, 2022 at 03:38:45PM +0800, Miaohe Lin wrote:
> We might fail to isolate huge page due to e.g. the page is under migration
> which cleared HPageMigratable. So we should return -EBUSY in this case
> rather than always return 1 which could confuse the user.
> 
> Fixes: e8db67eb0ded ("mm: migrate: move_pages() supports thp migration")
> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/migrate.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 381963231a62..044656a14ae2 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1632,10 +1632,8 @@ static int add_page_for_migration(struct mm_struct *mm, unsigned long addr,
>  		goto out_putpage;
>  
>  	if (PageHuge(page)) {
> -		if (PageHead(page)) {
> -			isolate_huge_page(page, pagelist);
> -			err = 1;
> -		}
> +		if (PageHead(page))
> +			err = isolate_huge_page(page, pagelist) ? 1 : -EBUSY;

I think a:

			err = isolate_huge_page(page, pagelist);
			if (!err)
				err = 1;

would be a lot more readable here.

