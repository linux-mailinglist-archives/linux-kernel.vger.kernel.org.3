Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5B7150B663
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 13:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447136AbiDVLu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 07:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380235AbiDVLu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 07:50:58 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E9D41FAA
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 04:48:04 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 4D8EB1F388;
        Fri, 22 Apr 2022 11:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650628083; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NgFv0sENXvVUOYbTHjKFVYGjlYg+9hQjDCMXuvJ5JfM=;
        b=DwpVMrBR1w5g+T+TbhLjBoR3qPund5PzP/4AYuuLA6MgeeU5LvmArftpPqGysD33WsvxUS
        eMx5ACD1yTmnJq5WFlmqcQEUa6jjb8AXvjjlUzbU2xGmOyax5Dxest9GcvrDttW5KV5Rfc
        JsfqvZCHLNOSJBrnYTX3bJWJRGcftzs=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E74642C145;
        Fri, 22 Apr 2022 11:48:01 +0000 (UTC)
Date:   Fri, 22 Apr 2022 13:48:00 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/mempolicy: clean up the code logic in
 queue_pages_pte_range
Message-ID: <YmKV8ESXIPFBR2mj@dhcp22.suse.cz>
References: <20220419122234.45083-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220419122234.45083-1-linmiaohe@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 19-04-22 20:22:34, Miaohe Lin wrote:
> Since commit e5947d23edd8 ("mm: mempolicy: don't have to split pmd for
> huge zero page"), THP is never splited in queue_pages_pmd. Thus 2 is
> never returned now. We can remove such unnecessary ret != 2 check and
> clean up the relevant comment. Minor improvements in readability.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Acked-by: Michal Hocko <mhocko@suse.com>
Thanks!

> ---
>  mm/mempolicy.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 75a8b247f631..3934476fb708 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -441,12 +441,11 @@ static inline bool queue_pages_required(struct page *page,
>  }
>  
>  /*
> - * queue_pages_pmd() has four possible return values:
> + * queue_pages_pmd() has three possible return values:
>   * 0 - pages are placed on the right node or queued successfully, or
>   *     special page is met, i.e. huge zero page.
>   * 1 - there is unmovable page, and MPOL_MF_MOVE* & MPOL_MF_STRICT were
>   *     specified.
> - * 2 - THP was split.
>   * -EIO - is migration entry or only MPOL_MF_STRICT was specified and an
>   *        existing page was already on a node that does not follow the
>   *        policy.
> @@ -508,18 +507,13 @@ static int queue_pages_pte_range(pmd_t *pmd, unsigned long addr,
>  	struct page *page;
>  	struct queue_pages *qp = walk->private;
>  	unsigned long flags = qp->flags;
> -	int ret;
>  	bool has_unmovable = false;
>  	pte_t *pte, *mapped_pte;
>  	spinlock_t *ptl;
>  
>  	ptl = pmd_trans_huge_lock(pmd, vma);
> -	if (ptl) {
> -		ret = queue_pages_pmd(pmd, ptl, addr, end, walk);
> -		if (ret != 2)
> -			return ret;
> -	}
> -	/* THP was split, fall through to pte walk */
> +	if (ptl)
> +		return queue_pages_pmd(pmd, ptl, addr, end, walk);
>  
>  	if (pmd_trans_unstable(pmd))
>  		return 0;
> -- 
> 2.23.0

-- 
Michal Hocko
SUSE Labs
