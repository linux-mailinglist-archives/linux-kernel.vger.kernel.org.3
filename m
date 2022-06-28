Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9965A55E8D3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345723AbiF1O7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 10:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231997AbiF1O7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 10:59:33 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8502B1B8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 07:59:32 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id a15so12217510pfv.13
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 07:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QGQSSYQX10LNSqyvqRv+smUAZqnB+eZ8I09EE8BQPHc=;
        b=PobbbbzgJSQqZlq6zR24jX++8aI9boMYE/I6rpgYFZBGikOgLgeOype3+LCQFDCZgs
         NfVgdo0vn8M4RJt1oFBjZ6umNPNfoibA8/K1lAz5WQ1FPTwFETxC3cKLiIcGHtmr0Z4L
         i/Xsw7iMXWYI8TkB9SC06p5sZEh1xU+gjb/a5KrJFEA0nvyQuu3W8yQhGmUDMkXWclxs
         JSHrC5TJp89CGuiafwf7AFVKC44qCb/ulvWGkOyfbNPobFQu/CuRfB3ikOfSjWYdjfY1
         YpX13TM35aqmgB342YXQbTiq4idrNENHhFKWdxb26sIARInWbWHp73AI8NLfz9BlrEh/
         n6ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QGQSSYQX10LNSqyvqRv+smUAZqnB+eZ8I09EE8BQPHc=;
        b=YQxlBvXfSaXXssQN7KjBUk8mB5u+LrqakQPKPWDIlYHtvj3uKjCAo65I0L8IQnCokN
         CyrX3y22CSGKgCFd3PsB5HICm390l0+G21Ufl7F/nQJ0sDQ7Ldtovt/1gqGVd1x2xV/n
         BYLczxmntiK/xHvsduP59reHn06kiizbiaYOU40eHe8k1Ft4LOWY7XHFibNhEtHKEOGS
         IrlZ8FuazAQdYykFthZXCcNAKPCsQLyX7mjqHBJsRCkIxvrBmFevM5DAfXzX7Lntyue9
         +AMVoz/AqMqzAkyscMnLdtjWigoB68R4c+WzOF+9mHlK6cC8tTd02TaMntsU8t8mO9Qw
         GR7A==
X-Gm-Message-State: AJIora8hehPqO7ZYW0bALgW2MoPtNUaQ3h+S5p2bSreFiRWFF8hN3Ab/
        OMSn6xcIcM65tK2b3wILHq2DQw==
X-Google-Smtp-Source: AGRyM1vERWFgmHaTBD7rBeqykB1fv4baPNjmA2gRpPKZnB723Y/Vv8hdfTsEMQ8qMiw5Pg4MhxACvA==
X-Received: by 2002:a05:6a00:1305:b0:512:ebab:3b20 with SMTP id j5-20020a056a00130500b00512ebab3b20mr5250523pfu.82.1656428371845;
        Tue, 28 Jun 2022 07:59:31 -0700 (PDT)
Received: from localhost ([2408:8207:18da:2310:e153:cfbc:e790:5935])
        by smtp.gmail.com with ESMTPSA id n67-20020a622746000000b005254eb7627fsm9557142pfn.203.2022.06.28.07.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 07:59:31 -0700 (PDT)
Date:   Tue, 28 Jun 2022 22:59:24 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, shy828301@gmail.com,
        willy@infradead.org, zokeefe@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/16] mm/huge_memory: use helper touch_pud in
 huge_pud_set_accessed
Message-ID: <YrsXTMKqXcuMzRpF@FVFYT0MHHV2J.googleapis.com>
References: <20220628132835.8925-1-linmiaohe@huawei.com>
 <20220628132835.8925-5-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220628132835.8925-5-linmiaohe@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 09:28:23PM +0800, Miaohe Lin wrote:
> Use helper touch_pud to set pud accessed to simplify the code and improve
> the readability. No functional change intended.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/huge_memory.c | 16 ++++------------
>  1 file changed, 4 insertions(+), 12 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index f7164ef8b6e3..d55d5efa06c8 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1284,15 +1284,15 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
>  
>  #ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
>  static void touch_pud(struct vm_area_struct *vma, unsigned long addr,
> -		pud_t *pud, int flags)
> +		      pud_t *pud, bool write)

You have change the last parameter. Have you forgotten to update its user
of follow_devmap_pud()?

Thanks.

>  {
>  	pud_t _pud;
>  
>  	_pud = pud_mkyoung(*pud);
> -	if (flags & FOLL_WRITE)
> +	if (write)
>  		_pud = pud_mkdirty(_pud);
>  	if (pudp_set_access_flags(vma, addr & HPAGE_PUD_MASK,
> -				pud, _pud, flags & FOLL_WRITE))
> +				  pud, _pud, write))
>  		update_mmu_cache_pud(vma, addr, pud);
>  }
>  
> @@ -1384,21 +1384,13 @@ int copy_huge_pud(struct mm_struct *dst_mm, struct mm_struct *src_mm,
>  
>  void huge_pud_set_accessed(struct vm_fault *vmf, pud_t orig_pud)
>  {
> -	pud_t entry;
> -	unsigned long haddr;
>  	bool write = vmf->flags & FAULT_FLAG_WRITE;
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
> +	touch_pud(vmf->vma, vmf->address, vmf->pud, write);
>  unlock:
>  	spin_unlock(vmf->ptl);
>  }
> -- 
> 2.23.0
> 
> 
