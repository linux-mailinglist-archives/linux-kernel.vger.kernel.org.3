Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 267D346F8E6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 03:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235682AbhLJCGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 21:06:01 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:32898 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbhLJCGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 21:06:00 -0500
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4J9Dg73QbRzcdh1;
        Fri, 10 Dec 2021 10:02:11 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 10 Dec 2021 10:02:24 +0800
Subject: Re: [PATCH] mm/madvise: pageout under plugging
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Jens Axboe <axboe@kernel.dk>, linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        John Dias <joaodias@google.com>
References: <20211210003019.1481269-1-minchan@kernel.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <6d844eda-a55a-d90c-d8bc-364ac8b17690@huawei.com>
Date:   Fri, 10 Dec 2021 10:02:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20211210003019.1481269-1-minchan@kernel.org>
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
On 2021/12/10 8:30, Minchan Kim wrote:
> Likewise shrink_lruvec[1], madvise_pageout could get the benefit
> from per-task block plug.
> 
> [1] 3da367c3e5fc, vmscan: add block plug for page reclaim

It seems there is a block plug in the caller do_madvise already. This one
might not be necessary for madvise.

Many thanks.

> Signed-off-by: Minchan Kim <minchan@kernel.org>
> ---
>  mm/vmscan.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index fb9584641ac7..cf11113f6adb 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2556,6 +2556,7 @@ unsigned long reclaim_pages(struct list_head *page_list)
>  	struct reclaim_stat dummy_stat;
>  	struct page *page;
>  	unsigned int noreclaim_flag;
> +	struct blk_plug plug;
>  	struct scan_control sc = {
>  		.gfp_mask = GFP_KERNEL,
>  		.may_writepage = 1,
> @@ -2564,6 +2565,7 @@ unsigned long reclaim_pages(struct list_head *page_list)
>  		.no_demotion = 1,
>  	};
>  
> +	blk_start_plug(&plug);
>  	noreclaim_flag = memalloc_noreclaim_save();
>  
>  	while (!list_empty(page_list)) {
> @@ -2603,6 +2605,8 @@ unsigned long reclaim_pages(struct list_head *page_list)
>  	}
>  
>  	memalloc_noreclaim_restore(noreclaim_flag);
> +	blk_finish_plug(&plug);
> +
>  
>  	return nr_reclaimed;
>  }
> 

