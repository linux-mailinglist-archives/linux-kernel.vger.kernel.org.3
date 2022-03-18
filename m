Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 029434DD4D0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 07:41:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232759AbiCRGmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 02:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231674AbiCRGl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 02:41:59 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60731D3728
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 23:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647585641; x=1679121641;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=59ehILCdsEIgUfsRNpzm4hT+4CUyYxmwDaIHVsIX8s0=;
  b=ex6s/IMg1SglsCUGT5ty9XqWmdLbJC+il8egIlBq83u4P8b2U8AqhAJF
   Dq4a3AEBIk+4yWcPV5cm++RioK511aSFxJpiIrC6lMRM2iKL0kmw6DoB4
   MoYUjxfdaxK72RQvqjjWJhCwyM3VWtdOMQmJGIF4kHh8fzS3wBa3pjoX6
   rT1B2h9JR9U7xYC7rL5+tcInOimaeiEPFRvbOOBeAsjyRusYtu+JSu28J
   IIdFtqBkhm2/dfa8ZkWDAK1nvugw9RT47AzTsTo7u+nxKAjIv8Mzgm/Zr
   lUqb8YztmdShXBBv2c8BBlOZ17OdfRJTKNO0DO7YoPMymDfhLzQTv3ORT
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="257017900"
X-IronPort-AV: E=Sophos;i="5.90,191,1643702400"; 
   d="scan'208";a="257017900"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 23:40:41 -0700
X-IronPort-AV: E=Sophos;i="5.90,191,1643702400"; 
   d="scan'208";a="558280308"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.94])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 23:40:38 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     <akpm@linux-foundation.org>, <ziy@nvidia.com>,
        <baolin.wang@linux.alibaba.com>, <songmuchun@bytedance.com>,
        <apopple@nvidia.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 11/11] mm/migration: fix possible do_pages_stat_array
 racing with memory offline
References: <20220318111709.60311-1-linmiaohe@huawei.com>
        <20220318111709.60311-12-linmiaohe@huawei.com>
Date:   Fri, 18 Mar 2022 14:40:36 +0800
In-Reply-To: <20220318111709.60311-12-linmiaohe@huawei.com> (Miaohe Lin's
        message of "Fri, 18 Mar 2022 19:17:09 +0800")
Message-ID: <878rt7oja3.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miaohe Lin <linmiaohe@huawei.com> writes:

> When follow_page peeks a page, the page could be migrated and then be
> offlined while it's still being used by the do_pages_stat_array().
> Use FOLL_GET to hold the page refcnt to fix this potential race.
>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Acked-by: "Huang, Ying" <ying.huang@intel.com>

> ---
>  mm/migrate.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index dbd91fbdb127..cd85ba0ab592 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1807,13 +1807,18 @@ static void do_pages_stat_array(struct mm_struct *mm, unsigned long nr_pages,
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
