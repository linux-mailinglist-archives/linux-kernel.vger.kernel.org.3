Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D72649AD43
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 08:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442598AbiAYHPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 02:15:01 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:17802 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1326948AbiAYDnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 22:43:40 -0500
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JjXjM0MBdz9sNL;
        Tue, 25 Jan 2022 11:42:15 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 25 Jan 2022 11:43:33 +0800
Subject: Re: [PATCH v2] mm/damon: Remove redundant page validation
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
References: <6d32f7d201b8970d53f51b6c5717d472aed2987c.1642386715.git.baolin.wang@linux.alibaba.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <3db0e468-8713-b87b-1579-b79481e2c110@huawei.com>
Date:   Tue, 25 Jan 2022 11:43:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <6d32f7d201b8970d53f51b6c5717d472aed2987c.1642386715.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/1/17 10:34, Baolin Wang wrote:
> It will never get a NULL page by pte_page() as discussed in thread [1],
> thus remove the redundant page validation to fix below Smatch static
> checker warning.
> 
>     mm/damon/vaddr.c:405 damon_hugetlb_mkold()
>     warn: 'page' can't be NULL.
> 
> [1] https://lore.kernel.org/linux-mm/20220106091200.GA14564@kili/
> 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Reviewed-by: SeongJae Park <sj@kernel.org>

LGTM. Thanks.

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

> ---
> Changes from v1:
>  - Improve the commit message suggested by SeongJae.
>  - Add reviewed-by tag from SeongJae.
> ---
>  mm/damon/vaddr.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> index 89b6468d..8a52e00 100644
> --- a/mm/damon/vaddr.c
> +++ b/mm/damon/vaddr.c
> @@ -402,9 +402,6 @@ static void damon_hugetlb_mkold(pte_t *pte, struct mm_struct *mm,
>  	pte_t entry = huge_ptep_get(pte);
>  	struct page *page = pte_page(entry);
>  
> -	if (!page)
> -		return;
> -
>  	get_page(page);
>  
>  	if (pte_young(entry)) {
> @@ -564,9 +561,6 @@ static int damon_young_hugetlb_entry(pte_t *pte, unsigned long hmask,
>  		goto out;
>  
>  	page = pte_page(entry);
> -	if (!page)
> -		goto out;
> -
>  	get_page(page);
>  
>  	if (pte_young(entry) || !page_is_idle(page) ||
> 

