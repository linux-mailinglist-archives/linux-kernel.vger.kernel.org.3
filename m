Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 348964FA188
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 04:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240543AbiDICHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 22:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235359AbiDICHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 22:07:06 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E3311140
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 19:04:59 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KZz236mNczdZq6;
        Sat,  9 Apr 2022 10:04:11 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 9 Apr 2022 10:04:41 +0800
Subject: Re: [PATCH v8 2/3] mm/hwpoison: put page in already hwpoisoned case
 with MF_COUNT_INCREASED
To:     Naoya Horiguchi <naoya.horiguchi@linux.dev>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Yang Shi <shy828301@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>
References: <20220408135323.1559401-1-naoya.horiguchi@linux.dev>
 <20220408135323.1559401-3-naoya.horiguchi@linux.dev>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <84062e94-8356-a2b2-1074-e0143297223e@huawei.com>
Date:   Sat, 9 Apr 2022 10:04:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220408135323.1559401-3-naoya.horiguchi@linux.dev>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/8 21:53, Naoya Horiguchi wrote:
> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
> 
> In already hwpoisoned case, memory_failure() is supposed to return with
> releasing the page refcount taken for error handling. But currently the
> refcount is not released when called with MF_COUNT_INCREASED, which
> makes page refcount inconsistent.  This should be rare and non-critical,
> but it might be inconvenient in testing (unpoison doesn't work).

IMHO, this issue will lead to memoryleak as page isn't freed even owner process
is killed. So we might need a Fixes tag?

Anyway, this patch looks good to me. Thanks!
Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

> 
> Suggested-by: Miaohe Lin <linmiaohe@huawei.com>
> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> ---
>  mm/memory-failure.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 2020944398c9..b2e32cdc3823 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1811,6 +1811,8 @@ int memory_failure(unsigned long pfn, int flags)
>  		res = -EHWPOISON;
>  		if (flags & MF_ACTION_REQUIRED)
>  			res = kill_accessing_process(current, pfn, flags);
> +		if (flags & MF_COUNT_INCREASED)
> +			put_page(p);
>  		goto unlock_mutex;
>  	}
>  
> 

