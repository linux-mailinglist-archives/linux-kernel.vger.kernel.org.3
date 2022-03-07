Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F13994CF0D7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 06:14:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235256AbiCGFPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 00:15:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbiCGFPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 00:15:38 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD3F3A19B
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 21:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646630084; x=1678166084;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=UMP7lv683/qTxlg+vOYWPsU7kqxuJTPwb+RKjmZ6+Tc=;
  b=PygntL65OFGuR6rEr2HOCAhx4rIddwDlnbkWx3ibsm63pjHGuPIQNzQp
   3ThK+h88YfL8ROnQa838Rysqr99sCMn15l7HqJ8wcUf4NjGQRZIP2UZx/
   D4r0cirCFTJSBVWZx2ag7m2xROrwI4+m5WXscVBbNKzhCJpKy5SRp++Bb
   165Cc1XX0Kzkrf3Zc58ir91/+HwC3suwTejSYLKgAVgmO4Uw7ga7otgjs
   jRZacbGlYaRX5+ojmCa5gj/Mf8X2xQAx3UFqNHTVaUF0dhHqGHOzt2kPB
   DKRb+GZBoFoHsilN+wFmH4wrVVIoVLNVIIroWgw4cg1rP0ODWXXCOsWbJ
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10278"; a="251876384"
X-IronPort-AV: E=Sophos;i="5.90,160,1643702400"; 
   d="scan'208";a="251876384"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2022 21:14:44 -0800
X-IronPort-AV: E=Sophos;i="5.90,160,1643702400"; 
   d="scan'208";a="512538262"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.94])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2022 21:14:39 -0800
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
Subject: Re: [PATCH 14/16] mm/migration: fix potential invalid node access
 for reclaim-based migration
References: <20220304093409.25829-1-linmiaohe@huawei.com>
        <20220304093409.25829-15-linmiaohe@huawei.com>
Date:   Mon, 07 Mar 2022 13:14:37 +0800
In-Reply-To: <20220304093409.25829-15-linmiaohe@huawei.com> (Miaohe Lin's
        message of "Fri, 4 Mar 2022 17:34:07 +0800")
Message-ID: <87a6e25ooy.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

> If we failed to setup hotplug state callbacks for mm/demotion:online in
> some corner cases, node_demotion will be left uninitialized. Invalid node
> might be returned from the next_demotion_node() when doing reclaim-based
> migration. Use kcalloc to allocate node_demotion to fix the issue.
>
> Fixes: ac16ec835314 ("mm: migrate: support multiple target nodes demotion")
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

LGTM!  Thanks!

Reviewed-by: "Huang, Ying" <ying.huang@intel.com>

Best Regards,
Huang, Ying

> ---
>  mm/migrate.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 279940c0c064..7b1c0b988234 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -2516,9 +2516,9 @@ static int __init migrate_on_reclaim_init(void)
>  {
>  	int ret;
>  
> -	node_demotion = kmalloc_array(nr_node_ids,
> -				      sizeof(struct demotion_nodes),
> -				      GFP_KERNEL);
> +	node_demotion = kcalloc(nr_node_ids,
> +				sizeof(struct demotion_nodes),
> +				GFP_KERNEL);
>  	WARN_ON(!node_demotion);
>  
>  	ret = cpuhp_setup_state_nocalls(CPUHP_MM_DEMOTION_DEAD, "mm/demotion:offline",
