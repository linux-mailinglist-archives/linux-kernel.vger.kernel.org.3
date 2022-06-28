Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3575255E662
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347364AbiF1PBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 11:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346312AbiF1PBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 11:01:41 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A0CA3337A
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 08:01:40 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id n12so12321338pfq.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 08:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=anQ27xOQvEX+Td238fWqiSq/k4JFfrd9qwDUWfXBswY=;
        b=pN+cBhSszTlUkwollR+maUGR17eDKbdWuZXiPaxMadT+7domXFQ/U9qvjmFHV2KcJR
         2mlQ9X/e5RizmM56f2d1J0SyAF+sZMdlj9vrp38VZf/un9gw9w9TdlJJ+eyGozM55kjX
         Ni+dMtXxkjP7LKNhQ/VPXHGOUjrnOEnAR9lVPvPuKMZKjeYx8Z5rN3b4ltUuSf5tYwaP
         szqudDmvN59Z52cIAVu2JaH25aVltFy+OTp9yl20Zkv9zJTVr0y0BeE1HeKk2B0u04cr
         FoNjpcASq8t3PvOdKq+pcaSRtqHW9thomXiTHVyo4Hv3I1ghFtyEGBuBYTv6VRlcIZgI
         F5pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=anQ27xOQvEX+Td238fWqiSq/k4JFfrd9qwDUWfXBswY=;
        b=brsLx9vhzkOidu4wp3OmKQ0luecxH1C1SXjo4ALl+77GcKEFlvMIZjY3YuGKX0YyQv
         mOTHh98xoRZPh5NE7K5ji/SSIWvdFxEj6Jn7ySv9BBazbS9/1NGE0H9BzVzjaEFJViqx
         HC8R7MvL98em6zyYQye2y7+feTUQ0X1b2vQwui+8Z5aieXrTFGykGm35e1YBMHan2rsw
         Vd5/j7BM36JmhvAhR2P+Fx4Gr4DCz+7DjlX3JMjJTR8ntX6GuNqtW/niCYeUv+i+MOnN
         sja+bT88fjTMaXeI6TeMliQiMTWvU+GdT2NNtpek80PPDCLslH48fwqbMMaxhaO9LcvJ
         uj4w==
X-Gm-Message-State: AJIora+6hwMgNNY9u2bvRjFomfrdT3vE7crsCwGJiYJGxM8xROim4K/y
        ZVbE8eRCLUiODoj2n9jbxr2qBQ==
X-Google-Smtp-Source: AGRyM1uw8AEKAAkQ7VZZ0u/DQBpg8EZi4a78W86U5RZMo9OdkrA7cftvvhfepOTV1K7E40Vyk8a0Qg==
X-Received: by 2002:a63:145e:0:b0:405:70e2:1d04 with SMTP id 30-20020a63145e000000b0040570e21d04mr17313720pgu.487.1656428499924;
        Tue, 28 Jun 2022 08:01:39 -0700 (PDT)
Received: from localhost ([2408:8207:18da:2310:e153:cfbc:e790:5935])
        by smtp.gmail.com with ESMTPSA id jh5-20020a170903328500b0015e8d4eb2b4sm9402296plb.254.2022.06.28.08.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 08:01:39 -0700 (PDT)
Date:   Tue, 28 Jun 2022 23:01:30 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, shy828301@gmail.com,
        willy@infradead.org, zokeefe@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 05/16] mm/huge_memory: use helper touch_pmd in
 huge_pmd_set_accessed
Message-ID: <YrsXygOe4dLaVn2t@FVFYT0MHHV2J.googleapis.com>
References: <20220628132835.8925-1-linmiaohe@huawei.com>
 <20220628132835.8925-6-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220628132835.8925-6-linmiaohe@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 09:28:24PM +0800, Miaohe Lin wrote:
> Use helper touch_pmd to set pmd accessed to simplify the code and improve
> the readability. No functional change intended.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/huge_memory.c | 18 +++++-------------
>  1 file changed, 5 insertions(+), 13 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index d55d5efa06c8..d9fe9b034783 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1120,15 +1120,15 @@ EXPORT_SYMBOL_GPL(vmf_insert_pfn_pud_prot);
>  #endif /* CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD */
>  
>  static void touch_pmd(struct vm_area_struct *vma, unsigned long addr,
> -		pmd_t *pmd, int flags)
> +		      pmd_t *pmd, bool write)

The same as comments as mentioned in previous thread. E.g. follow_devmap_pmd()
and follow_trans_huge_pmd().

Thanks.

>  {
>  	pmd_t _pmd;
>  
>  	_pmd = pmd_mkyoung(*pmd);
> -	if (flags & FOLL_WRITE)
> +	if (write)
>  		_pmd = pmd_mkdirty(_pmd);
>  	if (pmdp_set_access_flags(vma, addr & HPAGE_PMD_MASK,
> -				pmd, _pmd, flags & FOLL_WRITE))
> +				  pmd, _pmd, write))
>  		update_mmu_cache_pmd(vma, addr, pmd);
>  }
>  
> @@ -1398,21 +1398,13 @@ void huge_pud_set_accessed(struct vm_fault *vmf, pud_t orig_pud)
>  
>  void huge_pmd_set_accessed(struct vm_fault *vmf)
>  {
> -	pmd_t entry;
> -	unsigned long haddr;
>  	bool write = vmf->flags & FAULT_FLAG_WRITE;
> -	pmd_t orig_pmd = vmf->orig_pmd;
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
> +	touch_pmd(vmf->vma, vmf->address, vmf->pmd, write);
>  
>  unlock:
>  	spin_unlock(vmf->ptl);
> -- 
> 2.23.0
> 
> 
