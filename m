Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 547624B53B4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 15:48:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355314AbiBNOsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 09:48:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355349AbiBNOsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 09:48:40 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E1584C7BA
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 06:48:33 -0800 (PST)
Date:   Mon, 14 Feb 2022 23:48:26 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1644850111;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rXhKcwEx+FM0PjLnfOPxubSvhcDYX2y3m+/ZLrbv5o0=;
        b=Bcw7vJE4e7zEujOM/++xPnH9knA5vx1sTK9jeLc2aYH1nyjEKmJ4Az4kK9cVKCmVNElbDR
        8UqShcUTzol075oVj/oO7w5EaFvxYmrQyRySpvdvFKSf8C+UolhcwdUki4+uh1IKIEXAvL
        uPD9eIRfvQNFRgWFEKo7cXNXUoWRvBg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, naoya.horiguchi@nec.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/8] mm/memory-failure.c: avoid walking page table when
 vma_address() return -EFAULT
Message-ID: <20220214144826.GB2624914@u2004>
References: <20220210141733.1908-1-linmiaohe@huawei.com>
 <20220210141733.1908-3-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220210141733.1908-3-linmiaohe@huawei.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2022 at 10:17:27PM +0800, Miaohe Lin wrote:
> It's unnecessary to walk the page table when vma_address() return -EFAULT.
> Return early if so to save some cpu cycles.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>

Does this patch fix the real problem rather than just saving cpu cycles?
Without this patch, "address == -EFAULT" seems to make pgd_offset() return
invalid pointer and result in some serious result like general protection fault.
If that's the case, this patch might be worth sending to stable.

Thanks,
Naoya Horiguchi

> ---
>  mm/memory-failure.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index b3ff7e99a421..f86819145ea8 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -315,6 +315,8 @@ static unsigned long dev_pagemap_mapping_shift(struct page *page,
>  	pmd_t *pmd;
>  	pte_t *pte;
> 
> +	if (address == -EFAULT)
> +		return 0;
>  	pgd = pgd_offset(vma->vm_mm, address);
>  	if (!pgd_present(*pgd))
>  		return 0;
> ---
> 2.23.0
> 
