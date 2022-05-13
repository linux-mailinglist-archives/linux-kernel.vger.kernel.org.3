Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D87852603A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 12:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379620AbiEMKt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 06:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379607AbiEMKt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 06:49:28 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3BC03285EF5
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 03:49:26 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 08F44143D;
        Fri, 13 May 2022 03:49:26 -0700 (PDT)
Received: from [10.163.33.229] (unknown [10.163.33.229])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7EC813F5A1;
        Fri, 13 May 2022 03:49:21 -0700 (PDT)
Message-ID: <88e02de3-c87e-2728-d980-da0e70a58102@arm.com>
Date:   Fri, 13 May 2022 16:20:35 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 1/2] arm64/hugetlb: Use ptep_get() to get the pte value
 of a huge page
Content-Language: en-US
To:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        catalin.marinas@arm.com, will@kernel.org
Cc:     mike.kravetz@oracle.com, akpm@linux-foundation.org,
        songmuchun@bytedance.com, willy@infradead.org,
        christophe.leroy@csgroup.eu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <cover.1652411252.git.baolin.wang@linux.alibaba.com>
 <d3d60680508486ecb48ae639cfd3911009275710.1652411252.git.baolin.wang@linux.alibaba.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <d3d60680508486ecb48ae639cfd3911009275710.1652411252.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/13/22 09:07, Baolin Wang wrote:
> The original huge_ptep_get() on ARM64 is just a wrapper of ptep_get(),

Right, as arm64 does not enable __HAVE_ARCH_HUGE_PTEP_GET.

> which will not take into account any contig-PTEs dirty and access bits.

As expected being operating on a single table entry.

> Meanwhile we will implement a new ARM64-specific huge_ptep_get()
> interface in following patch, which will take into account any contig-PTEs
> dirty and access bits. To keep the same efficient logics to get the pte

s/logics/logic

> value, change to use ptep_get() as a preparation.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Reviewed-by: Muchun Song <songmuchun@bytedance.com>

LGTM

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

> ---
>  arch/arm64/mm/hugetlbpage.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
> index 30f5b76..9553851 100644
> --- a/arch/arm64/mm/hugetlbpage.c
> +++ b/arch/arm64/mm/hugetlbpage.c
> @@ -172,7 +172,7 @@ static pte_t get_clear_contig(struct mm_struct *mm,
>  			     unsigned long pgsize,
>  			     unsigned long ncontig)
>  {
> -	pte_t orig_pte = huge_ptep_get(ptep);
> +	pte_t orig_pte = ptep_get(ptep);
>  	unsigned long i;
>  
>  	for (i = 0; i < ncontig; i++, addr += pgsize, ptep++) {
> @@ -379,7 +379,7 @@ pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
>  {
>  	int ncontig;
>  	size_t pgsize;
> -	pte_t orig_pte = huge_ptep_get(ptep);
> +	pte_t orig_pte = ptep_get(ptep);
>  
>  	if (!pte_cont(orig_pte))
>  		return ptep_get_and_clear(mm, addr, ptep);
> @@ -402,11 +402,11 @@ static int __cont_access_flags_changed(pte_t *ptep, pte_t pte, int ncontig)
>  {
>  	int i;
>  
> -	if (pte_write(pte) != pte_write(huge_ptep_get(ptep)))
> +	if (pte_write(pte) != pte_write(ptep_get(ptep)))
>  		return 1;
>  
>  	for (i = 0; i < ncontig; i++) {
> -		pte_t orig_pte = huge_ptep_get(ptep + i);
> +		pte_t orig_pte = ptep_get(ptep + i);
>  
>  		if (pte_dirty(pte) != pte_dirty(orig_pte))
>  			return 1;
