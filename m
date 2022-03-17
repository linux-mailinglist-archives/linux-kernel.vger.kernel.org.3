Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79BDE4DC5BE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 13:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233519AbiCQMYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 08:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233509AbiCQMYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 08:24:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 254E8B6E4F
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 05:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CkpD4U/xBZ2hqIizdz+6oXRWCbbpVMQAvu/URGqBeZU=; b=O5AkkI4N/RTC4Vnr506hKSvr5Y
        xG45CjXBIjc7ftOYxJDcYa5oRcVUKOHrQbEMoYappkB9NFDLbFLb3hla8SZsDDptflu4BaxbqnBqj
        g7AQd2t0nuaNbva1wIpk213yzZ9P6kUzLqgKXOq52++NQ5eTDRS4WdUwoWaYEHGsmk4ZEprgsA5WB
        szmSM2+uI+r+4CWJi7bizSkEtlygBJwgCYHuFvQwB0t3V5Gg3bRgaH0fnqOP1ULoJWMqCCgxJx5cr
        94vgn5luapm6S56oVmFoV+41LRmRzb1ILW/Q0V1OF5A1h7cSYkeZpPRiR/H9x0pCu4I0NdceoThZs
        EI7DLlbA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nUp9t-006wtu-Va; Thu, 17 Mar 2022 12:23:14 +0000
Date:   Thu, 17 Mar 2022 12:23:13 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Bibo Mao <maobibo@loongson.cn>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH v2] mm: add access/dirty bit on numa page fault
Message-ID: <YjMoMVWXoJH9cmuf@casper.infradead.org>
References: <20220317065033.2635123-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220317065033.2635123-1-maobibo@loongson.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 02:50:33AM -0400, Bibo Mao wrote:
> On platforms like x86/arm which supports hw page walking, access
> and dirty bit is set by hw, however on some platforms without
> such hw functions, access and dirty bit is set by software in
> next trap.
> 
> During numa page fault, dirty bit can be added for old pte if
> fail to migrate on write fault. And if it succeeds to migrate,
> access bit can be added for migrated new pte, also dirty bit
> can be added for write fault.

Is this a correctness problem, in which case this will need to be
backported, or is this a performance problem, in which case can you
share some numbers?

> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>  mm/memory.c | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index c125c4969913..65813bec9c06 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4404,6 +4404,22 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
>  	if (migrate_misplaced_page(page, vma, target_nid)) {
>  		page_nid = target_nid;
>  		flags |= TNF_MIGRATED;
> +
> +		/*
> +		 * update pte entry with access bit, and dirty bit for
> +		 * write fault
> +		 */
> +		spin_lock(vmf->ptl);
> +		pte = *vmf->pte;
> +		pte = pte_mkyoung(pte);
> +		if (was_writable) {
> +			pte = pte_mkwrite(pte);
> +			if (vmf->flags & FAULT_FLAG_WRITE)
> +				pte = pte_mkdirty(pte);
> +		}
> +		set_pte_at(vma->vm_mm, vmf->address, vmf->pte, pte);
> +		update_mmu_cache(vma, vmf->address, vmf->pte);
> +		pte_unmap_unlock(vmf->pte, vmf->ptl);
>  	} else {
>  		flags |= TNF_MIGRATE_FAIL;
>  		vmf->pte = pte_offset_map(vmf->pmd, vmf->address);
> @@ -4427,8 +4443,11 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
>  	old_pte = ptep_modify_prot_start(vma, vmf->address, vmf->pte);
>  	pte = pte_modify(old_pte, vma->vm_page_prot);
>  	pte = pte_mkyoung(pte);
> -	if (was_writable)
> +	if (was_writable) {
>  		pte = pte_mkwrite(pte);
> +		if (vmf->flags & FAULT_FLAG_WRITE)
> +			pte = pte_mkdirty(pte);
> +	}
>  	ptep_modify_prot_commit(vma, vmf->address, vmf->pte, old_pte, pte);
>  	update_mmu_cache(vma, vmf->address, vmf->pte);
>  	pte_unmap_unlock(vmf->pte, vmf->ptl);
> -- 
> 2.31.1
> 
> 
