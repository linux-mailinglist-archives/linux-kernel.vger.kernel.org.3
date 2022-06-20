Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F231E550F82
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 06:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233440AbiFTEtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 00:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbiFTEs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 00:48:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE7928A
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 21:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OWtEjGnDXMqHCzyuteqvu4muriObYgLh/nz12B7kppM=; b=YBu3qKIxX5PkuZIFEAPlrHgEZw
        knTtNcBQKD4aHmdqF8POgZRwKprTVVenaZfaQxqTEydkvJw99i/dj0yFgcdQ/rNsJnlM+lYEFdXj1
        J+RkSjehV9mFk6Tsq00Um+wRNMA/1ta8ysMftb5X5YpkuzspyPfMtGI9uv+wJN+ANIUXz4hluU+We
        Vw/Mzx77HLW1s17VO8GC0FNpXPOeefBtonY5wNgcCOtkVuAd1KRp7vf7I4uKlJ6EYX5pporKQUiDP
        HkfKlYSMYngq8y+SMPpJtlZb6t76vejXtiUxliVt1pgTR4jk5YhXOSrFS7u4peFi24HHy7E4owBBE
        251EkkfQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o39LK-004s34-P6; Mon, 20 Jun 2022 04:48:54 +0000
Date:   Mon, 20 Jun 2022 05:48:54 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: stricter check on THP migration entry
Message-ID: <Yq/8NonqNmMGAeJ2@casper.infradead.org>
References: <20220618073243.9423-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220618073243.9423-1-linmiaohe@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 18, 2022 at 03:32:43PM +0800, Miaohe Lin wrote:
> When VM_BUG_ON check for THP migration entry, the existing code only check
> thp_migration_supported case, but not for !thp_migration_supported case.
> If !thp_migration_supported() and !pmd_present(), the original code may
> dead loop in theory.  To make the VM_BUG_ON check more consistent, we need
> to catch both cases.

This patch makes no sense to me.

> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/memory.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index fee2884481f2..6a9a17c7f58a 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -5043,10 +5043,9 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
>  
>  		barrier();
>  		if (unlikely(is_swap_pmd(vmf.orig_pmd))) {
> -			VM_BUG_ON(thp_migration_supported() &&
> -					  !is_pmd_migration_entry(vmf.orig_pmd));
> -			if (is_pmd_migration_entry(vmf.orig_pmd))
> -				pmd_migration_entry_wait(mm, vmf.pmd);
> +			VM_BUG_ON(!thp_migration_supported() ||
> +				  !is_pmd_migration_entry(vmf.orig_pmd));
> +			pmd_migration_entry_wait(mm, vmf.pmd);
>  			return 0;
>  		}
>  		if (pmd_trans_huge(vmf.orig_pmd) || pmd_devmap(vmf.orig_pmd)) {
> -- 
> 2.23.0
> 
> 
