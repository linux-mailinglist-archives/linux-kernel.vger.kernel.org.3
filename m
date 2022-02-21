Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7D14BDD39
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357276AbiBUMGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 07:06:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357266AbiBUMGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 07:06:01 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 122E3201A7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 04:05:37 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4K2LZJ3bDKzcfrY;
        Mon, 21 Feb 2022 20:04:24 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 21 Feb 2022 20:05:28 +0800
Subject: Re: [PATCH v4 2/2] mm/hwpoison: Add in-use hugepage hwpoison filter
 judgement
To:     luofei <luofei@unicloud.com>, <naoya.horiguchi@nec.com>,
        <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20220221021521.2329075-1-luofei@unicloud.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <8d4e62ad-1084-6fb6-0b56-6149ee44a960@huawei.com>
Date:   Mon, 21 Feb 2022 20:05:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220221021521.2329075-1-luofei@unicloud.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/2/21 10:15, luofei wrote:
> After successfully obtaining the reference count of the huge
> page, it is still necessary to call hwpoison_filter() to make a
> filter judgement, otherwise the filter hugepage will be unmaped
> and the related process may be killed.
> 

LGTM. Thanks.

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

BTW: It seems there is also another missing call to hwpoison_filter() when we
encounter free_buddy_page in memory_failure(). But I'am not sure.

> Signed-off-by: luofei <luofei@unicloud.com>
> ---
>  mm/memory-failure.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 59d6d939a752..17a7b0a94ab9 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1548,6 +1548,17 @@ static int memory_failure_hugetlb(unsigned long pfn, int flags)
>  	lock_page(head);
>  	page_flags = head->flags;
>  
> +	if (hwpoison_filter(p)) {
> +		if (TestClearPageHWPoison(head))
> +			num_poisoned_pages_dec();
> +		put_page(p);
> +		if (flags & MF_MCE_HANDLE)
> +			res = -EHWPOISON;
> +		else
> +			res = 0;
> +		goto out;
> +	}
> +
>  	/*
>  	 * TODO: hwpoison for pud-sized hugetlb doesn't work right now, so
>  	 * simply disable it. In order to make it work properly, we need
> 

