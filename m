Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0843503409
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 07:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbiDPCnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 22:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbiDPCnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 22:43:45 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F626DEA9
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 19:41:14 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KgFPl2pQPzgYdp;
        Sat, 16 Apr 2022 09:06:03 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 16 Apr 2022 09:06:04 +0800
Subject: Re: [PATCH 4/3] mm, hugetlb, hwpoison: separate branch for free and
 in-use hugepage
To:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Yang Shi <shy828301@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        <naoya.horiguchi@nec.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
References: <20220408135323.1559401-1-naoya.horiguchi@linux.dev>
 <20220408135323.1559401-2-naoya.horiguchi@linux.dev>
 <5b665bcd-57f8-85ae-b0c4-c055875dbfff@oracle.com>
 <20e677e5-01aa-f8c0-0ce1-bf33da58b7ec@huawei.com>
 <20220415021233.GA3357039@hori.linux.bs1.fc.nec.co.jp>
 <20220415041848.GA3034499@ik1-406-35019.vs.sakura.ne.jp>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <a26624a2-937d-435b-b866-97c1bedb4894@huawei.com>
Date:   Sat, 16 Apr 2022 09:06:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220415041848.GA3034499@ik1-406-35019.vs.sakura.ne.jp>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/15 12:18, Naoya Horiguchi wrote:
> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
> 
> We know that HPageFreed pages should have page refcount 0, so
> get_page_unless_zero() always fails and returns 0.  So explicitly separate
> the branch based on page state for minor optimization and better readability.
> 
> Suggested-by: Mike Kravetz <mike.kravetz@oracle.com>
> Suggested-by: Miaohe Lin <linmiaohe@huawei.com>
> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> ---
>  mm/hugetlb.c        | 4 +++-
>  mm/memory-failure.c | 4 +++-
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 

Thanks!

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index e38cbfdf3e61..3638f166e554 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -6786,7 +6786,9 @@ int get_hwpoison_huge_page(struct page *page, bool *hugetlb)
>  	spin_lock_irq(&hugetlb_lock);
>  	if (PageHeadHuge(page)) {
>  		*hugetlb = true;
> -		if (HPageFreed(page) || HPageMigratable(page))
> +		if (HPageFreed(page))
> +			ret = 0;
> +		else if (HPageMigratable(page))
>  			ret = get_page_unless_zero(page);
>  		else
>  			ret = -EBUSY;
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 5e3ad640f5bb..661079a37f29 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1517,7 +1517,9 @@ int __get_huge_page_for_hwpoison(unsigned long pfn, int flags)
>  	if (flags & MF_COUNT_INCREASED) {
>  		ret = 1;
>  		count_increased = true;
> -	} else if (HPageFreed(head) || HPageMigratable(head)) {
> +	} else if (HPageFreed(head)) {
> +		ret = 0;
> +	} else if (HPageMigratable(head)) {
>  		ret = get_page_unless_zero(head);
>  		if (ret)
>  			count_increased = true;
> 

