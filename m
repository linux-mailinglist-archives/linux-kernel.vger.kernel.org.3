Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0483647F9F1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 04:19:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbhL0DTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 22:19:39 -0500
Received: from mga04.intel.com ([192.55.52.120]:54990 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230347AbhL0DTi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 22:19:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640575178; x=1672111178;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=NdIek6kTYtbS5/oPywVshmnuMKBVwGh80PHZlhTHNHk=;
  b=kRLj59WI6NdgW5QEdMQ6kb9DBIFZ6hK3I62BOOL52NDG5JY6Nu30hYP6
   9L7hYLyfocPtUC1tLttcYfEZJgp0zxNRmK5WbN4Yk/+MzRIvKxKr7X+k3
   LtyQ6Q1ojsG1PMmL63xm3sllpnM95sUA11nhjqRRk9rDbZF/JsKZbml1f
   j4chu3CcneDr/ELTnk9SYauywnpWBCdosYM3u+yjLbcOnBX68wqB/1Pqk
   zqDjYaxr+p0pAQ9iWu1huWF5+4QCkcGj6FBruUczOJ6oIXTv6mkqwBkSG
   195JXpLiOTfm3YHWVrV9eYUgeUCFglBoJWDTZqesiRX9qjwZmmuyIrgZd
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10209"; a="239939037"
X-IronPort-AV: E=Sophos;i="5.88,238,1635231600"; 
   d="scan'208";a="239939037"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2021 19:19:37 -0800
X-IronPort-AV: E=Sophos;i="5.88,238,1635231600"; 
   d="scan'208";a="469604497"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.11])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2021 19:19:34 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     cgel.zte@gmail.com
Cc:     akpm@linux-foundation.org, yang.shi@linux.alibaba.com,
        dave.hansen@linux.intel.com, yang.yang29@zte.com.cn,
        minchan@kernel.org, saravanand@fb.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm/vmstat: add events for THP max_ptes_* exceeds
References: <20211225094036.574157-1-yang.yang29@zte.com.cn>
Date:   Mon, 27 Dec 2021 11:19:32 +0800
In-Reply-To: <20211225094036.574157-1-yang.yang29@zte.com.cn> (cgel zte's
        message of "Sat, 25 Dec 2021 09:40:37 +0000")
Message-ID: <87k0fq7n0b.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cgel.zte@gmail.com writes:

> From: Yang Yang <yang.yang29@zte.com.cn>
>
> There are interfaces to adjust max_ptes_none, max_ptes_swap,
> max_ptes_shared values, see
> /sys/kernel/mm/transparent_hugepage/khugepaged/.
>
> But system administrator maynot know which value is the best. So
> Add those events to support adjusting max_ptes_* to suitable values.
>
> For example, if default max_ptes_swap value causes too much failures,
> and system uses zram whose IO is fast, administrator could increase
> max_ptes_swap until THP_SCAN_EXCEED_SWAP_PTE not increase anymore.
>
> Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
> ---
>  include/linux/vm_event_item.h | 3 +++
>  mm/khugepaged.c               | 7 +++++++
>  mm/vmstat.c                   | 3 +++
>  3 files changed, 13 insertions(+)
>
> diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
> index a185cc75ff52..7b2363388bfa 100644
> --- a/include/linux/vm_event_item.h
> +++ b/include/linux/vm_event_item.h
> @@ -98,6 +98,9 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
>  		THP_SPLIT_PAGE_FAILED,
>  		THP_DEFERRED_SPLIT_PAGE,
>  		THP_SPLIT_PMD,
> +		THP_SCAN_EXCEED_NONE_PTE,
> +		THP_SCAN_EXCEED_SWAP_PTE,
> +		THP_SCAN_EXCEED_SHARED_PTE,

"SCAN" appears too general, how about

  THP_COLLAPSE_EXCEED_SWAP_PTE

?

Best Regards,
Huang, Ying

[snip]
