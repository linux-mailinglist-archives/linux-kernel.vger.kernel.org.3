Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 721B44CEF49
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 03:01:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234649AbiCGCB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 21:01:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbiCGCBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 21:01:55 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC1239160
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 18:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646618454; x=1678154454;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=jVs09bTLbXhsTTwGzakM/Z2R4eSw3z2LVMnMqDFhc1E=;
  b=ixT1hztrOju6K9RdYDsUGIkgrGKPo7UkJOjOszCydggU97lw+BRA6Zng
   +lKvLK5xhZ0i+ruMHfZ68366j8TZ/j22UDX0WWoUPA3IdJrEUu0Hcpmkm
   Xb8AQSI/ERCGZpgm1g57FTQlipAQsai5nbJq4N3KIsPhS0UwqKjVhD5CB
   4ug+VTEm8/oR6ANwWr56nOz8Bhg468Ack9e42JSPSObcegBHaaB7v3dn/
   Al/tZrslAw0xCOkPdEOFYfkleTf1H2lyhr2iPC2LwqL3h7Jyr4IzCe7YK
   c9PGHWqk7mTONJtcJSVpJwN1E6pE5G09t0poG2+bO8G9Why9U9lb144KF
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10278"; a="241710433"
X-IronPort-AV: E=Sophos;i="5.90,160,1643702400"; 
   d="scan'208";a="241710433"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2022 18:00:54 -0800
X-IronPort-AV: E=Sophos;i="5.90,160,1643702400"; 
   d="scan'208";a="536920364"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.94])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2022 18:00:50 -0800
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
Subject: Re: [PATCH 01/16] mm/migration: remove unneeded local variable
 mapping_locked
References: <20220304093409.25829-1-linmiaohe@huawei.com>
        <20220304093409.25829-2-linmiaohe@huawei.com>
Date:   Mon, 07 Mar 2022 10:00:48 +0800
In-Reply-To: <20220304093409.25829-2-linmiaohe@huawei.com> (Miaohe Lin's
        message of "Fri, 4 Mar 2022 17:33:54 +0800")
Message-ID: <87bkyi7c8f.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miaohe Lin <linmiaohe@huawei.com> writes:

> When mapping_locked is true, TTU_RMAP_LOCKED is always set to ttu. We can
> check ttu instead so mapping_locked can be removed. And ttu is either 0
> or TTU_RMAP_LOCKED now. Change '|=' to '=' to reflect this.
>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/migrate.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 42e3a944f35c..50bc62d85eaf 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1230,7 +1230,6 @@ static int unmap_and_move_huge_page(new_page_t get_new_page,
>  		goto put_anon;
>  
>  	if (page_mapped(hpage)) {
> -		bool mapping_locked = false;
>  		enum ttu_flags ttu = 0;
>  
>  		if (!PageAnon(hpage)) {
> @@ -1244,14 +1243,13 @@ static int unmap_and_move_huge_page(new_page_t get_new_page,
>  			if (unlikely(!mapping))
>  				goto unlock_put_anon;
>  
> -			mapping_locked = true;
> -			ttu |= TTU_RMAP_LOCKED;
> +			ttu = TTU_RMAP_LOCKED;
>  		}
>  
>  		try_to_migrate(src, ttu);
>  		page_was_mapped = 1;
>  
> -		if (mapping_locked)
> +		if (ttu & TTU_RMAP_LOCKED)
>  			i_mmap_unlock_write(mapping);
>  	}

I think this is a code style issue.  The original code looks more
readable for me.

Best Regards,
Huang, Ying
