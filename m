Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB61557342
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 08:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbiFWGnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 02:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiFWGnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 02:43:41 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A22419B0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 23:43:39 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id f65so18250880pgc.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 23:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3UJEMTPzICNyXJBehr6tcsfAkHd0uy9Otb6Hy7fSQ2Y=;
        b=FDEIVzEhQN053Y0VryB4nr6XSAhB+0gOt1XsRAGHLt0l/Pcc/ww/n2lTSCbzxLPjuL
         d/D8ZtZql76W58xHMIVifgqqEteewDrFyu/YkE7D1TzLtutyqetmeDynhe791vKraHCO
         5XC8m6RoWEelQFzveoi5Yli4C1mCLapGXcmI4v+6YxvuW1QMnXF7U66V1VAqVrAmqOHH
         G+clEZTAA4PZLwG702YD0jaWJW+ejbg4Nts12Vy4oU4etVg/zBadbi7gz0hPh01m1gKA
         hD7ry2zhPXIC6FlLyOwTyZILDlO+7CQEaKwHiABkvSUqr9u+EvMkAXJiokfl0ZParnUP
         a86A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3UJEMTPzICNyXJBehr6tcsfAkHd0uy9Otb6Hy7fSQ2Y=;
        b=Qd+xh1zeOcw7pLYLBc2+BotgrVHpN6wxzY14QQy8ri8AVoSVLR/LG+6YrLXcezXG1R
         b0YQajObiafmozA+hIxyCMV1NUNH8vhZbwdfEJNtc3+uoAsrYAl8TVGK2VBjygil121X
         0tr6ulViIkwALyoREZ2vaaKsD9GdWjfO5wjAc3X0yfjKYVcHHH+Dmoyw9xqMds2zRWg7
         QoWQfg4z0XwIpR50uqvgELGUnG6yl71TUElNgqRxKb2xjUezhD9UsElWEzAesUahf2Tm
         1TFDSRc3TUN4O1UMw3hd2Q15q1D8LNml/BU6l4gDWBkiCV19REN8USHKmc99PsVB/G0s
         lNqg==
X-Gm-Message-State: AJIora9x/brQRCS8W0syV/xiAv6nAjw5dDca4jX5dW7n3vN/kBLU7d+Q
        s4a1txIPMHKfLF7mYVgEkR8AJg==
X-Google-Smtp-Source: AGRyM1vyV9N2CWpKeg83xNnRcJDfQQjNlH8Emh1YmXsVLwSuJNvyUOkwX2CDOA2UyCBgZtdDlwdgHw==
X-Received: by 2002:a05:6a00:10d4:b0:522:8c31:ec23 with SMTP id d20-20020a056a0010d400b005228c31ec23mr39708842pfu.67.1655966619110;
        Wed, 22 Jun 2022 23:43:39 -0700 (PDT)
Received: from localhost ([139.177.225.231])
        by smtp.gmail.com with ESMTPSA id n2-20020a63b442000000b003c265b7d4f6sm14489743pgu.44.2022.06.22.23.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 23:43:38 -0700 (PDT)
Date:   Thu, 23 Jun 2022 14:43:35 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, shy828301@gmail.com,
        willy@infradead.org, zokeefe@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/16] mm/huge_memory: use helper touch_pmd in
 huge_pmd_set_accessed
Message-ID: <YrQLl8KzSzAkGpJa@FVFYT0MHHV2J.usts.net>
References: <20220622170627.19786-1-linmiaohe@huawei.com>
 <20220622170627.19786-6-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622170627.19786-6-linmiaohe@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2022 at 01:06:16AM +0800, Miaohe Lin wrote:
> Use helper touch_pmd to set pmd accessed to simplify the code and improve
> the readability. No functional change intended.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/huge_memory.c | 16 +++++-----------
>  1 file changed, 5 insertions(+), 11 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index a0c0e4bf9c1e..c6302fe6704b 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1297,21 +1297,15 @@ void huge_pud_set_accessed(struct vm_fault *vmf, pud_t orig_pud)
>  
>  void huge_pmd_set_accessed(struct vm_fault *vmf)
>  {
> -	pmd_t entry;
> -	unsigned long haddr;
> -	bool write = vmf->flags & FAULT_FLAG_WRITE;
> -	pmd_t orig_pmd = vmf->orig_pmd;
> +	int flags = 0;
>  
>  	vmf->ptl = pmd_lock(vmf->vma->vm_mm, vmf->pmd);
> -	if (unlikely(!pmd_same(*vmf->pmd, orig_pmd)))
> +	if (unlikely(!pmd_same(*vmf->pmd, vmf->orig_pmd)))
>  		goto unlock;
>  
> -	entry = pmd_mkyoung(orig_pmd);
> -	if (write)
> -		entry = pmd_mkdirty(entry);
> -	haddr = vmf->address & HPAGE_PMD_MASK;
> -	if (pmdp_set_access_flags(vmf->vma, haddr, vmf->pmd, entry, write))
> -		update_mmu_cache_pmd(vmf->vma, vmf->address, vmf->pmd);
> +	if (vmf->flags & FAULT_FLAG_WRITE)
> +		flags = FOLL_WRITE;

Same suggestion as mentioned in previous thread.

Thanks.

> +	touch_pmd(vmf->vma, vmf->address, vmf->pmd, flags);
>  
>  unlock:
>  	spin_unlock(vmf->ptl);
> -- 
> 2.23.0
> 
> 
