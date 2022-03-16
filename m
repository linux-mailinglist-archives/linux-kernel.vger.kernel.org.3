Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 684C94DAAD1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 07:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240221AbiCPGoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 02:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236005AbiCPGoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 02:44:19 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D04AA3298C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 23:43:04 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A73C31515;
        Tue, 15 Mar 2022 23:43:03 -0700 (PDT)
Received: from [10.163.34.65] (unknown [10.163.34.65])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1E4323F766;
        Tue, 15 Mar 2022 23:43:01 -0700 (PDT)
Message-ID: <93302a47-9fda-25c7-4212-41b8dd027696@arm.com>
Date:   Wed, 16 Mar 2022 12:13:07 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] mm: add access/dirty bit on numa page fault
Content-Language: en-US
To:     Bibo Mao <maobibo@loongson.cn>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220316010836.1137084-1-maobibo@loongson.cn>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20220316010836.1137084-1-maobibo@loongson.cn>
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



On 3/16/22 06:38, Bibo Mao wrote:
> During numa page fault, dirty bit can be added for old pte if
> fail to migrate on write fault. And if it succeeds to migrate,
> access bit can be added for migrated new pte, also dirty bit
> can be added for write fault.

The current code does not set the access and dirty bits when ever
applicable i.e on FAULT_FLAG_WRITE, on the pte (old if migration
fails, new if migration succeeds) ? Did not this cause any problem
earlier ? I am wondering how this might have gone unnoticed.

> 
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
