Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1479A4D5A1C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 05:53:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245200AbiCKEwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 23:52:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242743AbiCKEwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 23:52:39 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F3F57D31F4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 20:51:36 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D93814BF;
        Thu, 10 Mar 2022 20:51:36 -0800 (PST)
Received: from [10.163.34.78] (unknown [10.163.34.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BD3C83F99C;
        Thu, 10 Mar 2022 20:51:34 -0800 (PST)
Message-ID: <90246c21-94e9-e64e-dd83-fce45de89f72@arm.com>
Date:   Fri, 11 Mar 2022 10:21:34 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] mm/huge_memory: remove unneeded local variable follflags
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220310131253.30970-1-linmiaohe@huawei.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20220310131253.30970-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miaohe,

On 3/10/22 18:42, Miaohe Lin wrote:
> We can pass FOLL_GET | FOLL_DUMP to follow_page directly to simplify
> the code a bit.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/huge_memory.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 3557aabe86fe..418d077da246 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2838,7 +2838,6 @@ static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
>  	 */
>  	for (addr = vaddr_start; addr < vaddr_end; addr += PAGE_SIZE) {
>  		struct vm_area_struct *vma = find_vma(mm, addr);
> -		unsigned int follflags;
>  		struct page *page;
>  
>  		if (!vma || addr < vma->vm_start)
> @@ -2851,8 +2850,7 @@ static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
>  		}
>  
>  		/* FOLL_DUMP to ignore special (like zero) pages */
> -		follflags = FOLL_GET | FOLL_DUMP;
> -		page = follow_page(vma, addr, follflags);
> +		page = follow_page(vma, addr, FOLL_GET | FOLL_DUMP);
>  
>  		if (IS_ERR(page))
>  			continue;

LGTM, but there is another similar instance in add_page_for_migration()
inside mm/migrate.c, requiring this exact clean up.

Hence with that change in place.

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
