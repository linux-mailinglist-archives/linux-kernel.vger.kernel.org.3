Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9B449A92D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:19:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1322257AbiAYDVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 22:21:30 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:17801 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1319315AbiAYDIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 22:08:30 -0500
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JjWwr6Wz7z9rwC;
        Tue, 25 Jan 2022 11:07:08 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 25 Jan 2022 11:08:27 +0800
Subject: Re: [PATCH v1] mm, hwpoison: remove obsolete comment
To:     Naoya Horiguchi <naoya.horiguchi@linux.dev>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Tony Luck <tony.luck@intel.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>
References: <20220125025601.3054511-1-naoya.horiguchi@linux.dev>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <4ee2ff7b-4aaf-437d-6827-ebf95bcf6db5@huawei.com>
Date:   Tue, 25 Jan 2022 11:08:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220125025601.3054511-1-naoya.horiguchi@linux.dev>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:
On 2022/1/25 10:56, Naoya Horiguchi wrote:
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

Looks good to me. Thanks for the patch.

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
