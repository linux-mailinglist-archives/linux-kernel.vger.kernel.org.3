Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2FB8522084
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 18:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346709AbiEJQED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 12:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347557AbiEJQBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 12:01:48 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0641B2A249
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 08:55:40 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id x18so17120946plg.6
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 08:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uzcCgVmhU+wESri3om0ZJezhJTbuZg70xEa5Aqfd+Kk=;
        b=j/4xO85+1iXeH6xPw7ga+S3tLZMTM08tKdS6+/P2WQoPLZQM3bma31auNvCGgMI7Ar
         XO54JRbZ5BtLRTQg9/0nD+wbZZ/55C/zxqc/YAIJJJTmE7iJm3kNHNbP9yBeloVN8Zry
         uc/GfhYhqfU6uvbPNHL1W6I3MnTtamWPUcml19joeVb3pcEE9qHUkwkGiymZbtR/EUbw
         7zM3U6UcRRiqqxkbrNMb0yPIE4AZfU+p+ZP8jTC6T8+mEeCfPiKx59vtN21407Yfg/el
         O70YHEfHrJATZ8c9AdE6A5yPOFTwxIhhzAxHsq3X0laMczaHf3YHRcMS0o6j/IYotzTh
         prfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uzcCgVmhU+wESri3om0ZJezhJTbuZg70xEa5Aqfd+Kk=;
        b=rqrRN1kbPdkKnKSSz7pUipGFKOR8Qg7bINsrA+rksQ4IsfSFF+hd49/8fmleY8VFbZ
         8VnYk9p7kowJYJrR17O1MoXlZYe0FC6MS2xM2l+8Yv9tWt0m0CGhYm6DA5+BLeL0B8Yo
         1i3BRx5I0xbDra8WeH3nTCIDfSnlPj+3lLeo4EA8NP3KF1esXxoiyq59hpgzN9gLfDS5
         hQloxSXoilBmeKyfcUMDv67qdX7sBJdGNjHn2zvLdbOnFkJvC+4Idm5+ledlSkUH36qr
         9x0hvuBIcbLop5CRMHhb2gm/C8oJ35AHIjT2s4Fc+07aUWmfdJ+q/eDRSXGHt3TqlJA2
         KXeA==
X-Gm-Message-State: AOAM5321LT6USUPsdO0NkNdkr7tHC5IFnXRKBozst7Lqz0clhXLuzUQO
        /e+fZa6uwfSRrsM0qrHBFAB5eA==
X-Google-Smtp-Source: ABdhPJzDPZtZKtrakyoFjvKdG06+B3/wtrOXa/yfusBAvuf8/HUplk+3U/L9l/GLUCHmXlz3bAN82w==
X-Received: by 2002:a17:90b:1e04:b0:1dc:9252:efbc with SMTP id pg4-20020a17090b1e0400b001dc9252efbcmr621215pjb.39.1652198139513;
        Tue, 10 May 2022 08:55:39 -0700 (PDT)
Received: from localhost ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id x62-20020a623141000000b0050dc762819fsm10934700pfx.121.2022.05.10.08.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 08:55:39 -0700 (PDT)
Date:   Tue, 10 May 2022 23:55:36 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, mike.kravetz@oracle.com,
        akpm@linux-foundation.org, willy@infradead.org,
        anshuman.khandual@arm.com, christophe.leroy@csgroup.eu,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 1/2] arm64/hugetlb: Use ptep_get() to get the pte value
 of a huge page
Message-ID: <YnqK+Hah0wzMvT1p@FVFYT0MHHV2J.usts.net>
References: <cover.1652180088.git.baolin.wang@linux.alibaba.com>
 <6aabddaf4cae5ae2205c3a7df9b9e15dbd61b641.1652180088.git.baolin.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6aabddaf4cae5ae2205c3a7df9b9e15dbd61b641.1652180088.git.baolin.wang@linux.alibaba.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 07:12:52PM +0800, Baolin Wang wrote:
> The original huge_ptep_get() on ARM64 is just a wrapper of ptep_get(),
> which will not take into account any contig-PTEs dirty and access bits.
> Meanwhile we will implement a new ARM64-specific huge_ptep_get()
> interface in following patch, which will take into account any contig-PTEs
> dirty and access bits and only be allowed to pass the head pte of
> a contig-PTE/PMD size page.

IIUC, the huge_ptep_get() you have implemented in patch 2 could
handle non-head pte. It'll return the original pte without potential
AD bit. I admit it is more efficeent to use ptep_get() directly,
but the judgement here should be updated.

With this update.

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
 
> Thus change to use ptep_get() to get the pte value of a huge page as
> a preparation.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  arch/arm64/mm/hugetlbpage.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
> index ca8e65c..be5e2f3 100644
> --- a/arch/arm64/mm/hugetlbpage.c
> +++ b/arch/arm64/mm/hugetlbpage.c
> @@ -172,7 +172,7 @@ static pte_t get_clear_flush(struct mm_struct *mm,
>  			     unsigned long pgsize,
>  			     unsigned long ncontig)
>  {
> -	pte_t orig_pte = huge_ptep_get(ptep);
> +	pte_t orig_pte = ptep_get(ptep);
>  	bool valid = pte_valid(orig_pte);
>  	unsigned long i, saddr = addr;
>  
> @@ -385,7 +385,7 @@ pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
>  {
>  	int ncontig;
>  	size_t pgsize;
> -	pte_t orig_pte = huge_ptep_get(ptep);
> +	pte_t orig_pte = ptep_get(ptep);
>  
>  	if (!pte_cont(orig_pte))
>  		return ptep_get_and_clear(mm, addr, ptep);
> @@ -408,11 +408,11 @@ static int __cont_access_flags_changed(pte_t *ptep, pte_t pte, int ncontig)
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
> -- 
> 1.8.3.1
> 
> 
