Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A77D5ADCCC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 03:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233064AbiIFBHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 21:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiIFBHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 21:07:21 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE9952460
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 18:07:19 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MM6Z05knLzZchG;
        Tue,  6 Sep 2022 09:02:48 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 6 Sep 2022 09:07:17 +0800
Subject: Re: [PATCH 2/6] mm, hwpoison: use __PageMovable() to detect non-lru
 movable pages
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBICjloIDlj6Mg55u05LmfKQ==?= 
        <naoya.horiguchi@nec.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220830123604.25763-1-linmiaohe@huawei.com>
 <20220830123604.25763-3-linmiaohe@huawei.com>
 <20220905052243.GA1355682@hori.linux.bs1.fc.nec.co.jp>
 <1f7ee86e-7d28-0d8c-e0de-b7a5a94519e8@huawei.com>
 <20220905071542.GA1364147@hori.linux.bs1.fc.nec.co.jp>
 <f2a52dd2-5792-0c45-3ae6-c1bcf547762c@huawei.com>
 <20220905145322.42d218d0d7d32d3c5f515027@linux-foundation.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <5a4fd4a3-da5c-5e83-c36b-4de0d9dce903@huawei.com>
Date:   Tue, 6 Sep 2022 09:07:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220905145322.42d218d0d7d32d3c5f515027@linux-foundation.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/9/6 5:53, Andrew Morton wrote:
> On Mon, 5 Sep 2022 15:29:34 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:
> 
>> The above code change could be applied to the mm-tree directly. Or should I resend
>> the v2 series? Which one is more convenient for you? They're all fine to me. ;)
> 
> I got it, thanks.

Many thanks for doing this. That's very kind of you.

Thanks,
Miaohe Lin


> 
> From: Miaohe Lin <linmiaohe@huawei.com>
> Subject: mm-hwpoison-use-__pagemovable-to-detect-non-lru-movable-pages-fix
> Date: Mon, 5 Sep 2022 14:53:41 +0800
> 
> fixes per Naoya Horiguchi
> 
> Link: https://lkml.kernel.org/r/1f7ee86e-7d28-0d8c-e0de-b7a5a94519e8@huawei.com
> Cc: Naoya Horiguchi <naoya.horiguchi@nec.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  mm/memory-failure.c |   16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> --- a/mm/memory-failure.c~mm-hwpoison-use-__pagemovable-to-detect-non-lru-movable-pages-fix
> +++ a/mm/memory-failure.c
> @@ -2404,24 +2404,26 @@ EXPORT_SYMBOL(unpoison_memory);
>  static bool isolate_page(struct page *page, struct list_head *pagelist)
>  {
>  	bool isolated = false;
> -	bool lru = !__PageMovable(page);
>  
>  	if (PageHuge(page)) {
>  		isolated = !isolate_hugetlb(page, pagelist);
>  	} else {
> +		bool lru = !__PageMovable(page);
> +
>  		if (lru)
>  			isolated = !isolate_lru_page(page);
>  		else
> -			isolated = !isolate_movable_page(page, ISOLATE_UNEVICTABLE);
> +			isolated = !isolate_movable_page(page,
> +							 ISOLATE_UNEVICTABLE);
>  
> -		if (isolated)
> +		if (isolated) {
>  			list_add(&page->lru, pagelist);
> +			if (lru)
> +				inc_node_page_state(page, NR_ISOLATED_ANON +
> +						    page_is_file_lru(page));
> +		}
>  	}
>  
> -	if (isolated && lru)
> -		inc_node_page_state(page, NR_ISOLATED_ANON +
> -				    page_is_file_lru(page));
> -
>  	/*
>  	 * If we succeed to isolate the page, we grabbed another refcount on
>  	 * the page, so we can safely drop the one we got from get_any_pages().
> _
> 
> .
> 

