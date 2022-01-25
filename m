Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B23D49ABF8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 06:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239134AbiAYFqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 00:46:52 -0500
Received: from foss.arm.com ([217.140.110.172]:45810 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236107AbiAYFoM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 00:44:12 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5C9071FB;
        Mon, 24 Jan 2022 21:44:06 -0800 (PST)
Received: from [10.163.42.113] (unknown [10.163.42.113])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A17F73F7D8;
        Mon, 24 Jan 2022 21:44:03 -0800 (PST)
Subject: Re: [PATCH v1] mm, hwpoison: remove obsolete comment
To:     Naoya Horiguchi <naoya.horiguchi@linux.dev>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Tony Luck <tony.luck@intel.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
References: <20220125025601.3054511-1-naoya.horiguchi@linux.dev>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <a2b71789-5072-9b40-1839-a662d9f64064@arm.com>
Date:   Tue, 25 Jan 2022 11:14:09 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220125025601.3054511-1-naoya.horiguchi@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/25/22 8:26 AM, Naoya Horiguchi wrote:
> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
> 
> With the introduction of mf_mutex, most of memory error handling
> process is mutually exclusive, so the in-line comment about
> subtlety about double-checking PageHWPoison is no more correct.
> So remove it.
> 
> Suggested-by: Mike Kravetz <mike.kravetz@oracle.com>
> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> ---
>  mm/memory-failure.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 4c9bd1d37301..a6a1e02759e7 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -2146,12 +2146,6 @@ static int __soft_offline_page(struct page *page)
>  		.gfp_mask = GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL,
>  	};
>  
> -	/*
> -	 * Check PageHWPoison again inside page lock because PageHWPoison
> -	 * is set by memory_failure() outside page lock. Note that
> -	 * memory_failure() also double-checks PageHWPoison inside page lock,
> -	 * so there's no race between soft_offline_page() and memory_failure().
> -	 */
>  	lock_page(page);
>  	if (!PageHuge(page))
>  		wait_on_page_writeback(page);
> 

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
