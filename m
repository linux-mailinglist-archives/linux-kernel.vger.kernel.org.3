Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E65C55A1B9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 21:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbiFXS4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 14:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiFXS43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 14:56:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CAF781A17
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 11:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IJWx2O/gmqaXm/KHDxJAx7Pdl9sf3SuElrBNoQy/NqY=; b=viKKZmozvsXsG1laaCednKCV4+
        +hPw4Kmns2e6bQxXJCk6bJbWgiB3FEs9IeQfsLbJ9s9DYubApl6+GYn080MugUicleTzyKx4Ya5Uk
        llAqpbMiSNWErYRpFmg7d/OYy/elbElBmlwqu7iJDxaWlHe/pkMTofnnlpxaU6HhNhgdTzkRbR5v/
        y3pYu0kX+Nh0jPwnxp3uNGyXmKqilsdBwIkecKYmNaqCaHYsc+I2XE9oIl+9BAO21Nc8MpGk186f3
        c5MPlYgy/x3CEtUB/2SIrbyj9XSf7srJvdaXQU5rzXyJigDkMGmVybJPm/NCGYhWzqT3s2QsxoPJJ
        t8qWP47A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o4oTc-009AGp-TB; Fri, 24 Jun 2022 18:56:21 +0000
Date:   Fri, 24 Jun 2022 19:56:20 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, shy828301@gmail.com, zokeefe@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/16] mm/huge_memory: fix comment of
 __pud_trans_huge_lock
Message-ID: <YrYI1Dxk7lhZqEVp@casper.infradead.org>
References: <20220622170627.19786-1-linmiaohe@huawei.com>
 <20220622170627.19786-4-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622170627.19786-4-linmiaohe@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2022 at 01:06:14AM +0800, Miaohe Lin wrote:
> __pud_trans_huge_lock returns page table lock pointer if a given pud maps
> a thp instead of 'true' since introduced. Fix corresponding comments.

I think the comments here are rather wasted.  I think this comment
should be moved to pud_trans_huge_lock() and turned into kernel-doc
format.

> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/huge_memory.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 83fb6c3442ff..a26580da8011 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1903,10 +1903,10 @@ spinlock_t *__pmd_trans_huge_lock(pmd_t *pmd, struct vm_area_struct *vma)
>  }
>  
>  /*
> - * Returns true if a given pud maps a thp, false otherwise.
> + * Returns page table lock pointer if a given pud maps a thp, NULL otherwise.
>   *
> - * Note that if it returns true, this routine returns without unlocking page
> - * table lock. So callers must unlock it.
> + * Note that if it returns page table lock pointe, this routine returns without
> + * unlocking page table lock. So callers must unlock it.
>   */
>  spinlock_t *__pud_trans_huge_lock(pud_t *pud, struct vm_area_struct *vma)
>  {
> -- 
> 2.23.0
> 
