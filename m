Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CDEE493B18
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 14:28:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354812AbiASN2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 08:28:23 -0500
Received: from foss.arm.com ([217.140.110.172]:56514 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350345AbiASN2V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 08:28:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 00E38ED1;
        Wed, 19 Jan 2022 05:28:21 -0800 (PST)
Received: from [10.57.67.190] (unknown [10.57.67.190])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1F94E3F73D;
        Wed, 19 Jan 2022 05:28:18 -0800 (PST)
Message-ID: <f85b3cac-29e7-4179-e078-fd859040c294@arm.com>
Date:   Wed, 19 Jan 2022 13:28:14 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] vmap(): don't allow invalid pages
Content-Language: en-GB
To:     Yury Norov <yury.norov@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Ding Tianhong <dingtianhong@huawei.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alexey Klimov <aklimov@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20220118235244.540103-1-yury.norov@gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220118235244.540103-1-yury.norov@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-01-18 23:52, Yury Norov wrote:
> vmap() takes struct page *pages as one of arguments, and user may provide
> an invalid pointer which would lead to DABT at address translation later.
> 
> Currently, kernel checks the pages against NULL. In my case, however, the
> address was not NULL, and was big enough so that the hardware generated
> Address Size Abort on arm64.
> 
> Interestingly, this abort happens even if copy_from_kernel_nofault() is
> used, which is quite inconvenient for debugging purposes.
> 
> This patch adds a pfn_valid() check into vmap() path, so that invalid
> mapping will not be created.
> 
> RFC: https://lkml.org/lkml/2022/1/18/815
> v1: use pfn_valid() instead of adding an arch-specific
>      arch_vmap_page_valid(). Thanks to Matthew Wilcox for the hint.
> 
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> ---
>   mm/vmalloc.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index d2a00ad4e1dd..a4134ee56b10 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -477,6 +477,8 @@ static int vmap_pages_pte_range(pmd_t *pmd, unsigned long addr,
>   			return -EBUSY;
>   		if (WARN_ON(!page))
>   			return -ENOMEM;
> +		if (WARN_ON(!pfn_valid(page_to_pfn(page))))

Is it page_to_pfn() guaranteed to work without blowing up if page is 
invalid in the first place? Looking at the CONFIG_SPARSEMEM case I'm not 
sure that's true...

Robin.

> +			return -EINVAL;
>   		set_pte_at(&init_mm, addr, pte, mk_pte(page, prot));
>   		(*nr)++;
>   	} while (pte++, addr += PAGE_SIZE, addr != end);
