Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1F855733E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 08:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbiFWGmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 02:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiFWGmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 02:42:49 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE1D3FD9E
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 23:42:48 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id h34-20020a17090a29a500b001eb01527d9eso1641158pjd.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 23:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=N3ow0jtBMSvR3R34hcnXm0q43de+Gwul4lTzzrZTcJY=;
        b=rlwEtMsxo+oU8UIJmenkkg+4D3jPsqrDZooGmwn2WODx+SmhSuUWLckmk75rZa+Tx4
         Kv9aCR0T3VE2PwY1RIjVyavr9Qhwko5DO0D6CwuLvoREZO8TfSmvnqpQBgn514FxvDG9
         8amCnf1k8Q/XJfcb8YE10NJqfkzKOyaEoQqCwsYMkG8UhF++ufFTbZw3lx4DLUedd1z8
         +xxWT4Gq97cYxM3Oc9u0W9WWziF17seNE9Xvqzu/ul78dfjWEXomcM6fkSRU8bwZu4OI
         zr8iCkn5e3crcuj/Kf8UnrssYxAfZaGTPN6prvbMuvKY/nn0TDpkKu+Pi3XNzWMG1DpB
         LiOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=N3ow0jtBMSvR3R34hcnXm0q43de+Gwul4lTzzrZTcJY=;
        b=70c29iiDcdu7PcnS9WD+KOO9GgUpqQ/RIAzdpMrMSqQxNDjJvr4vFe1al1MV1Xgsah
         0B4AZMtMm/GTHhPquo+pRyJQrLWNsxgCrqgF1qsbnLbVpZYHjSgYsqC5lSIP0i+BSp1L
         DMe11rIOim/SGOUVW5tLgfNnLxBu35iMlaJ/IXdEGob4RnaG/y90Asnwe2WkCIbpGYTK
         rfnYQom7YIsG82xvXwOOvqaCWqeno0M3ob8a6XbHtYhqA74/hx7EP5O4HMs1YyvbgEq9
         2je220agzOZtVkawAvkSNb94D3wDSMQNNfLLbm2wOzckZqDqaRLsEydjwTqeGe6bL5SS
         zuvg==
X-Gm-Message-State: AJIora9zBLpmEjWTsotYsyT/64U1RfYMHgbC4pYXVohZpjl4lFScG8Ga
        86LUeQEHAp3BK8ollVzAYklKXA==
X-Google-Smtp-Source: AGRyM1smMJdtzur3J3fWQHD8V8DVUbiuPVwNyia43HDDD58JdeVt4HmJEpFrt9aOh076iY8FZT3Ihg==
X-Received: by 2002:a17:90b:1d90:b0:1e8:5a98:d591 with SMTP id pf16-20020a17090b1d9000b001e85a98d591mr2448827pjb.126.1655966568198;
        Wed, 22 Jun 2022 23:42:48 -0700 (PDT)
Received: from localhost ([139.177.225.231])
        by smtp.gmail.com with ESMTPSA id a2-20020a631a02000000b0040d548ab090sm566560pga.32.2022.06.22.23.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 23:42:47 -0700 (PDT)
Date:   Thu, 23 Jun 2022 14:42:43 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, shy828301@gmail.com,
        willy@infradead.org, zokeefe@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/16] mm/huge_memory: use helper touch_pud in
 huge_pud_set_accessed
Message-ID: <YrQLY7WzgXPM/LqJ@FVFYT0MHHV2J.usts.net>
References: <20220622170627.19786-1-linmiaohe@huawei.com>
 <20220622170627.19786-5-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622170627.19786-5-linmiaohe@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2022 at 01:06:15AM +0800, Miaohe Lin wrote:
> Use helper touch_pud to set pud accessed to simplify the code and improve
> the readability. No functional change intended.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/huge_memory.c | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index a26580da8011..a0c0e4bf9c1e 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1281,21 +1281,15 @@ int copy_huge_pud(struct mm_struct *dst_mm, struct mm_struct *src_mm,
>  
>  void huge_pud_set_accessed(struct vm_fault *vmf, pud_t orig_pud)
>  {
> -	pud_t entry;
> -	unsigned long haddr;
> -	bool write = vmf->flags & FAULT_FLAG_WRITE;
> +	int flags = 0;
>  
>  	vmf->ptl = pud_lock(vmf->vma->vm_mm, vmf->pud);
>  	if (unlikely(!pud_same(*vmf->pud, orig_pud)))
>  		goto unlock;
>  
> -	entry = pud_mkyoung(orig_pud);
> -	if (write)
> -		entry = pud_mkdirty(entry);
> -	haddr = vmf->address & HPAGE_PUD_MASK;
> -	if (pudp_set_access_flags(vmf->vma, haddr, vmf->pud, entry, write))
> -		update_mmu_cache_pud(vmf->vma, vmf->address, vmf->pud);
> -
> +	if (vmf->flags & FAULT_FLAG_WRITE)
> +		flags = FOLL_WRITE;

FOLL_* flags are used for follow_page(). But huge_pud_set_accessed() is used in mm fault
path. It is a little weird to me to use FOLL_WRITE here. I suggest replace the last
parameter of touch_pud() to "bool writable", then passing "vmf->flags & FAULT_FLAG_WRITE"
to it instead of converting from FAULT_FLAG* flag to FOLL* flag.

Thanks.

> +	touch_pud(vmf->vma, vmf->address, vmf->pud, flags);
>  unlock:
>  	spin_unlock(vmf->ptl);
>  }
> -- 
> 2.23.0
> 
> 
