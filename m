Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4AF4CF0E1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 06:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235293AbiCGFWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 00:22:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235113AbiCGFWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 00:22:45 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E61FA4F454
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 21:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646630510; x=1678166510;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=nENgkNrXPp9CG8WF2N13y7IyQBK8xft0YApUuFADoXQ=;
  b=Jhvp3+dxe+iWWXqCSCQDr3cYHEtPtpY8PShOHIjswO3zRxNEWMQUa2+c
   rFDXEGDYVXXZUbCNy6thqg2/Wcf0ma0feemxtZ50DvbuJ/Jvcwxn/AABj
   KwqTDRT/YPZgKb0cZkKkp2uCvNB3Xxem9oBNeNNYgZmd/z5L3syViAm4t
   CWsTTUMdfYynEWHW7ftRY6ZfnwHFxBPRXtDVfY/phY1asai4FgPEJxcrb
   LSY/8ekDp7w7CC5YvSb5+52BQF/+YEjJuoWEi69xUNCPtk9Bw2liVhb1B
   kJW2On5UafDyAfatNbnPzCOOJAVTpdvd4qXP+5Jh6FvwHmYewGU1iUcBZ
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10278"; a="315017980"
X-IronPort-AV: E=Sophos;i="5.90,160,1643702400"; 
   d="scan'208";a="315017980"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2022 21:21:50 -0800
X-IronPort-AV: E=Sophos;i="5.90,160,1643702400"; 
   d="scan'208";a="643100514"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.94])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2022 21:21:45 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     <akpm@linux-foundation.org>, <mike.kravetz@oracle.com>,
        <shy828301@gmail.com>, <willy@infradead.org>, <ziy@nvidia.com>,
        <minchan@kernel.org>, <apopple@nvidia.com>,
        <ave.hansen@linux.intel.com>, <o451686892@gmail.com>,
        <almasrymina@google.com>, <jhubbard@nvidia.com>,
        <rcampbell@nvidia.com>, <peterx@redhat.com>,
        <naoya.horiguchi@nec.com>, <mhocko@suse.com>, <riel@redhat.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 15/16] mm/migration: fix possible do_pages_stat_array
 racing with memory offline
References: <20220304093409.25829-1-linmiaohe@huawei.com>
        <20220304093409.25829-16-linmiaohe@huawei.com>
Date:   Mon, 07 Mar 2022 13:21:43 +0800
In-Reply-To: <20220304093409.25829-16-linmiaohe@huawei.com> (Miaohe Lin's
        message of "Fri, 4 Mar 2022 17:34:08 +0800")
Message-ID: <875yoq5od4.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miaohe Lin <linmiaohe@huawei.com> writes:

> When follow_page peeks a page, the page could be reclaimed under heavy
> memory pressure

I don't think that memory pressure and reclaiming will be an issue.

> and thus be offlined while it's still being used by the
> do_pages_stat_array().

"offline" seems a possible problem.

Best Regards,
Huang, Ying

> Use FOLL_GET to hold the page refcnt to fix this
> potential issue.
>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/migrate.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 7b1c0b988234..98a968e6f465 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1788,13 +1788,18 @@ static void do_pages_stat_array(struct mm_struct *mm, unsigned long nr_pages,
>  			goto set_status;
>  
>  		/* FOLL_DUMP to ignore special (like zero) pages */
> -		page = follow_page(vma, addr, FOLL_DUMP);
> +		page = follow_page(vma, addr, FOLL_GET | FOLL_DUMP);
>  
>  		err = PTR_ERR(page);
>  		if (IS_ERR(page))
>  			goto set_status;
>  
> -		err = page ? page_to_nid(page) : -ENOENT;
> +		if (page) {
> +			err = page_to_nid(page);
> +			put_page(page);
> +		} else {
> +			err = -ENOENT;
> +		}
>  set_status:
>  		*status = err;
