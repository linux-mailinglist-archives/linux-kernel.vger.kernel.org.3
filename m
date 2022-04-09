Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0EA4FA18A
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 04:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235359AbiDICJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 22:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbiDICJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 22:09:40 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0962A1092
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 19:07:35 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KZz5M0CffzdZLW;
        Sat,  9 Apr 2022 10:07:03 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 9 Apr 2022 10:07:33 +0800
Subject: Re: [PATCH v8 3/3] Revert "mm/memory-failure.c: fix race with
 changing page compound again"
To:     Naoya Horiguchi <naoya.horiguchi@linux.dev>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Yang Shi <shy828301@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>
References: <20220408135323.1559401-1-naoya.horiguchi@linux.dev>
 <20220408135323.1559401-4-naoya.horiguchi@linux.dev>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <51ef18d1-284f-5a0b-fd3f-73bb99ec05bb@huawei.com>
Date:   Sat, 9 Apr 2022 10:07:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220408135323.1559401-4-naoya.horiguchi@linux.dev>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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
> Reverts commit 888af2701db7 ("mm/memory-failure.c: fix race with
> changing page compound again") because now we fetch the page refcount
> under hugetlb_lock in try_memory_failure_hugetlb() so that the race
> check is no longer necessary.
> 

Thanks a lot.
Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

> Suggested-by: Miaohe Lin <linmiaohe@huawei.com>
> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> ---
>  include/linux/mm.h      |  1 -
>  include/ras/ras_event.h |  1 -
>  mm/memory-failure.c     | 11 -----------
>  3 files changed, 13 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 9f44254af8ce..d446e834a3e5 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3251,7 +3251,6 @@ enum mf_action_page_type {
>  	MF_MSG_BUDDY,
>  	MF_MSG_DAX,
>  	MF_MSG_UNSPLIT_THP,
> -	MF_MSG_DIFFERENT_PAGE_SIZE,
>  	MF_MSG_UNKNOWN,
>  };
>  
> diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
> index 1e694fd239b9..d0337a41141c 100644
> --- a/include/ras/ras_event.h
> +++ b/include/ras/ras_event.h
> @@ -374,7 +374,6 @@ TRACE_EVENT(aer_event,
>  	EM ( MF_MSG_BUDDY, "free buddy page" )				\
>  	EM ( MF_MSG_DAX, "dax page" )					\
>  	EM ( MF_MSG_UNSPLIT_THP, "unsplit thp" )			\
> -	EM ( MF_MSG_DIFFERENT_PAGE_SIZE, "different page size" )	\
>  	EMe ( MF_MSG_UNKNOWN, "unknown page" )
>  
>  /*
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index b2e32cdc3823..e2674532678b 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -733,7 +733,6 @@ static const char * const action_page_types[] = {
>  	[MF_MSG_BUDDY]			= "free buddy page",
>  	[MF_MSG_DAX]			= "dax page",
>  	[MF_MSG_UNSPLIT_THP]		= "unsplit thp",
> -	[MF_MSG_DIFFERENT_PAGE_SIZE]	= "different page size",
>  	[MF_MSG_UNKNOWN]		= "unknown page",
>  };
>  
> @@ -1605,16 +1604,6 @@ static int try_memory_failure_hugetlb(unsigned long pfn, int flags, int *hugetlb
>  		return res == MF_RECOVERED ? 0 : -EBUSY;
>  	}
>  
> -	/*
> -	 * The page could have changed compound pages due to race window.
> -	 * If this happens just bail out.
> -	 */
> -	if (!PageHuge(p) || compound_head(p) != head) {
> -		action_result(pfn, MF_MSG_DIFFERENT_PAGE_SIZE, MF_IGNORED);
> -		res = -EBUSY;
> -		goto out;
> -	}
> -
>  	page_flags = head->flags;
>  
>  	/*
> 

