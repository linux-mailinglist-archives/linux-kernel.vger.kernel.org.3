Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 664444B32D6
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 04:20:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbiBLDLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 22:11:00 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:60550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiBLDKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 22:10:54 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E12082E09F
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 19:10:50 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Jwb3r2CK9zZcDl;
        Sat, 12 Feb 2022 11:06:32 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Sat, 12 Feb 2022 11:10:48 +0800
Subject: Re: [PATCH] mm: clean up hwpoison page cache page in fault path
To:     Rik van Riel <riel@surriel.com>
CC:     <kernel-team@fb.com>, <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20220211170557.7964a301@imladris.surriel.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <c7c7f497-0f08-8bcd-c603-321b56c6cf5e@huawei.com>
Date:   Sat, 12 Feb 2022 11:10:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220211170557.7964a301@imladris.surriel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/2/12 6:05, Rik van Riel wrote:
> Sometimes the page offlining code can leave behind a hwpoisoned clean
> page cache page. This can lead to programs being killed over and over

Yep, __soft_offline_page tries to invalidate_inode_page in a lightway.

> and over again as they fault in the hwpoisoned page, get killed, and
> then get re-spawned by whatever wanted to run them.
>     
> This is particularly embarrassing when the page was offlined due to
> having too many corrected memory errors. Now we are killing tasks
> due to them trying to access memory that probably isn't even corrupted.
>     
> This problem can be avoided by invalidating the page from the page
> fault handler, which already has a branch for dealing with these
> kinds of pages. With this patch we simply pretend the page fault
> was successful if the page was invalidated, return to userspace,
> incur another page fault, read in the file from disk (to a new
> memory page), and then everything works again.
>     
> Signed-off-by: Rik van Riel <riel@surriel.com>

Good catch! This looks good to me. Thanks.

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

> 
> diff --git a/mm/memory.c b/mm/memory.c
> index c125c4969913..2300358e268c 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3871,11 +3871,16 @@ static vm_fault_t __do_fault(struct vm_fault *vmf)
>  		return ret;
>  
>  	if (unlikely(PageHWPoison(vmf->page))) {
> -		if (ret & VM_FAULT_LOCKED)
> +		int poisonret = VM_FAULT_HWPOISON;
> +		if (ret & VM_FAULT_LOCKED) {
> +			/* Retry if a clean page was removed from the cache. */
> +			if (invalidate_inode_page(vmf->page))
> +				poisonret = 0;
>  			unlock_page(vmf->page);
> +		}
>  		put_page(vmf->page);
>  		vmf->page = NULL;
> -		return VM_FAULT_HWPOISON;
> +		return poisonret;
>  	}
>  
>  	if (unlikely(!(ret & VM_FAULT_LOCKED)))
> 
> 

