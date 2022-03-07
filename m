Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6025A4CF0CF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 06:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234389AbiCGFIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 00:08:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbiCGFI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 00:08:28 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B393010E9
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 21:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646629653; x=1678165653;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=Dp9grBEsh9qgvv8Wpxg4ToQAypx/TtvNKWPX6UIX9cc=;
  b=hQ/5CMXoCW4ESju1Llc3WmnpuJ83NKHnre/zPLSb67w5ZXVbBlsXxvXj
   L19i8ZR4eYwOIv3klLqOCY1EyVtuBufG29gM9/UShVoCSxvQSEO2CwlbP
   OQ0k0WIiCREzDLLeagQTiitPkH1d4s9i3PWzwcPRvuvKXFdGDkR7ctpkh
   IVHz3lTE+SUsWMKYEBEMnq6ctn9M9OtnvqY0YwTpgE+p70xsu7HRioMZU
   Za0VUCVdhmmO+MYFece2vBaQvzv4uc4VIDeujjI+b9crON8H8fRrB8yJU
   WOMkiT1lsBa8nMnhhsTPFmmgVktQXnttOpu3vRC/4+TQxx5PTPd1/jUoC
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10278"; a="251875220"
X-IronPort-AV: E=Sophos;i="5.90,160,1643702400"; 
   d="scan'208";a="251875220"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2022 21:07:33 -0800
X-IronPort-AV: E=Sophos;i="5.90,160,1643702400"; 
   d="scan'208";a="536962197"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.94])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2022 21:07:28 -0800
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
Subject: Re: [PATCH 13/16] mm/migration: return errno when isolate_huge_page
 failed
References: <20220304093409.25829-1-linmiaohe@huawei.com>
        <20220304093409.25829-14-linmiaohe@huawei.com>
Date:   Mon, 07 Mar 2022 13:07:26 +0800
In-Reply-To: <20220304093409.25829-14-linmiaohe@huawei.com> (Miaohe Lin's
        message of "Fri, 4 Mar 2022 17:34:06 +0800")
Message-ID: <87ilsq5p0x.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miaohe Lin <linmiaohe@huawei.com> writes:

> We should return errno (-EBUSY here) when failed to isolate the huge page
> rather than always return 1 which could confuse the user.
>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/migrate.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 6c2dfed2ddb8..279940c0c064 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1618,10 +1618,8 @@ static int add_page_for_migration(struct mm_struct *mm, unsigned long addr,
>  		goto out_putpage;
>  
>  	if (PageHuge(page)) {
> -		if (PageHead(page)) {
> -			isolate_huge_page(page, pagelist);
> -			err = 1;
> -		}
> +		if (PageHead(page))
> +			err = isolate_huge_page(page, pagelist) ? 1 : -EBUSY;

IMHO, it's better to determine the proper errno inside
isolate_huge_page() instead of in the caller.  If you think it's
necessary to get errno here.  How about change isolate_huge_page()
instead?

Best Regards,
Huang, Ying

>  	} else {
>  		struct page *head;
