Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D43D854D611
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 02:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345541AbiFPA1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 20:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245677AbiFPA1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 20:27:45 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E6B27B08
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 17:27:43 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id g10-20020a17090a708a00b001ea8aadd42bso99265pjk.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 17:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=v5EJlJC3fYMCJ96mwekJ8a2ISDsHOgu0y3JtizGSuls=;
        b=hsI/+WnqCF8zQPF/liunNLONAK1FPW0Nx6lgXU5U/glAxi3VvfNO3n+tovX2nJRaSu
         Jn3ic+Uf7LCk+iMH2pTxeLOq9wBtJUfEO/rE1Ck2UUiKEU1tkXzMgUZXSWfdCIODcqM7
         13dYIig66mvBCX8XBH7EUEbl5FKTcwSXQvKpnvCyMBwSicp4E4Ehiag/Ae6rTlZGo58Y
         6AxRYX8blgEYav6lzmPwzQQ+6MpsmE4yMe0B23P5lXkPJR2nZc6yCknHAvJ4KP9b7AFt
         LQ2OCi1Ff76Zwpb+SbzVkzv7BgKE9/4ueTc+T6MbxPtWAr0chI+nEkvYDC7Jff41xgPB
         FXsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=v5EJlJC3fYMCJ96mwekJ8a2ISDsHOgu0y3JtizGSuls=;
        b=hSHe9TpYLQF3Duk9sY30fQ5IZZsQ2nXBW1vOIxlNWdlklRS6lTXMPszPm2uzZOKa62
         sNtRsOU8Pc0PgG5IDzN3kFcW+1UXqW/qKe0nzXJPBxBdhbsJsYvBK5yz5WklGCMUPv1j
         yz4ujU2GBAVIcuTE4HhdUjoBQuX3NtHwMXhUu1s5UKgsea9numaPnFM21OoyhdlUrT57
         0RrP0srV5OwPAI/KkVBeHIbGrgOvX3aEBDf5Rpxa5IPMn1l/U6H+DF2MeXh7v+1IizVV
         qaoI1VpN+DzmCiRU54nmKdxhSy/oMOKnOWFU9mMS9JHnSTEXGzNrTLryfu9FLRpdR1EJ
         cuJA==
X-Gm-Message-State: AJIora8MyXhQQ+2Owej/zuY6AxQRPcgDURIG+llm0ty5bJVVifOo5Cmc
        VL4utBSIbaVlrS+gXkUZQIm/nw==
X-Google-Smtp-Source: AGRyM1vSFqBmHWhi9P2WtAhphZrB3VnujgFpbtV/3TxwIwIE+xiZXy7eqzshUIglByRyFVy+arRKOw==
X-Received: by 2002:a17:90a:f30d:b0:1ea:8070:ffba with SMTP id ca13-20020a17090af30d00b001ea8070ffbamr12930909pjb.169.1655339263102;
        Wed, 15 Jun 2022 17:27:43 -0700 (PDT)
Received: from google.com (55.212.185.35.bc.googleusercontent.com. [35.185.212.55])
        by smtp.gmail.com with ESMTPSA id nm4-20020a17090b19c400b001df93c8e737sm172162pjb.39.2022.06.15.17.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 17:27:42 -0700 (PDT)
Date:   Wed, 15 Jun 2022 17:27:38 -0700
From:   Zach O'Keefe <zokeefe@google.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     vbabka@suse.cz, kirill.shutemov@linux.intel.com,
        willy@infradead.org, linmiaohe@huawei.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v4 PATCH 6/7] mm: khugepaged: reorg some khugepaged helpers
Message-ID: <Yqp4+qiRNTgMqTML@google.com>
References: <20220615172926.546974-1-shy828301@gmail.com>
 <20220615172926.546974-7-shy828301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615172926.546974-7-shy828301@gmail.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 Jun 10:29, Yang Shi wrote:
> The khugepaged_{enabled|always|req_madv} are not khugepaged only
> anymore, move them to huge_mm.h and rename to hugepage_flags_xxx, and
> remove khugepaged_req_madv due to no users.
> 
> Also move khugepaged_defrag to khugepaged.c since its only caller is in
> that file, it doesn't have to be in a header file.
> 
> Signed-off-by: Yang Shi <shy828301@gmail.com>
> ---
>  include/linux/huge_mm.h    |  8 ++++++++
>  include/linux/khugepaged.h | 14 --------------
>  mm/huge_memory.c           |  4 ++--
>  mm/khugepaged.c            | 18 +++++++++++-------
>  4 files changed, 21 insertions(+), 23 deletions(-)
> 
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 9d97d7ee6234..4cf546af7d97 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -116,6 +116,14 @@ extern struct kobj_attribute shmem_enabled_attr;
>  
>  extern unsigned long transparent_hugepage_flags;
>  
> +#define hugepage_flags_enabled()					       \
> +	(transparent_hugepage_flags &				       \
> +	 ((1<<TRANSPARENT_HUGEPAGE_FLAG) |		       \
> +	  (1<<TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG)))
> +#define hugepage_flags_always()				\
> +	(transparent_hugepage_flags &			\
> +	 (1<<TRANSPARENT_HUGEPAGE_FLAG))
> +
>  /*
>   * Do the below checks:
>   *   - For file vma, check if the linear page offset of vma is
> diff --git a/include/linux/khugepaged.h b/include/linux/khugepaged.h
> index ea5fd4c398f7..384f034ae947 100644
> --- a/include/linux/khugepaged.h
> +++ b/include/linux/khugepaged.h
> @@ -24,20 +24,6 @@ static inline void collapse_pte_mapped_thp(struct mm_struct *mm,
>  }
>  #endif
>  
> -#define khugepaged_enabled()					       \
> -	(transparent_hugepage_flags &				       \
> -	 ((1<<TRANSPARENT_HUGEPAGE_FLAG) |		       \
> -	  (1<<TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG)))
> -#define khugepaged_always()				\
> -	(transparent_hugepage_flags &			\
> -	 (1<<TRANSPARENT_HUGEPAGE_FLAG))
> -#define khugepaged_req_madv()					\
> -	(transparent_hugepage_flags &				\
> -	 (1<<TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG))
> -#define khugepaged_defrag()					\
> -	(transparent_hugepage_flags &				\
> -	 (1<<TRANSPARENT_HUGEPAGE_DEFRAG_KHUGEPAGED_FLAG))
> -
>  static inline void khugepaged_fork(struct mm_struct *mm, struct mm_struct *oldmm)
>  {
>  	if (test_bit(MMF_VM_HUGEPAGE, &oldmm->flags))
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index d0c37d99917b..0f2cce2d7041 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -117,11 +117,11 @@ bool hugepage_vma_check(struct vm_area_struct *vma,
>  	if (!in_pf && shmem_file(vma->vm_file))
>  		return shmem_huge_enabled(vma);
>  
> -	if (!khugepaged_enabled())
> +	if (!hugepage_flags_enabled())
>  		return false;
>  
>  	/* THP settings require madvise. */
> -	if (!(vm_flags & VM_HUGEPAGE) && !khugepaged_always())
> +	if (!(vm_flags & VM_HUGEPAGE) && !hugepage_flags_always())
>  		return false;
>  
>  	/* Only regular file is valid */
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 2a676f37c921..d8ebb60aae36 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -472,7 +472,7 @@ void khugepaged_enter_vma(struct vm_area_struct *vma,
>  			  unsigned long vm_flags)
>  {
>  	if (!test_bit(MMF_VM_HUGEPAGE, &vma->vm_mm->flags) &&
> -	    khugepaged_enabled()) {
> +	    hugepage_flags_enabled()) {
>  		if (hugepage_vma_check(vma, vm_flags, false, false))
>  			__khugepaged_enter(vma->vm_mm);
>  	}
> @@ -763,6 +763,10 @@ static bool khugepaged_scan_abort(int nid)
>  	return false;
>  }
>  
> +#define khugepaged_defrag()					\
> +	(transparent_hugepage_flags &				\
> +	 (1<<TRANSPARENT_HUGEPAGE_DEFRAG_KHUGEPAGED_FLAG))
> +
>  /* Defrag for khugepaged will enter direct reclaim/compaction if necessary */
>  static inline gfp_t alloc_hugepage_khugepaged_gfpmask(void)
>  {
> @@ -860,7 +864,7 @@ static struct page *khugepaged_alloc_hugepage(bool *wait)
>  			khugepaged_alloc_sleep();
>  		} else
>  			count_vm_event(THP_COLLAPSE_ALLOC);
> -	} while (unlikely(!hpage) && likely(khugepaged_enabled()));
> +	} while (unlikely(!hpage) && likely(hugepage_flags_enabled()));
>  
>  	return hpage;
>  }
> @@ -2186,7 +2190,7 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages,
>  static int khugepaged_has_work(void)
>  {
>  	return !list_empty(&khugepaged_scan.mm_head) &&
> -		khugepaged_enabled();
> +		hugepage_flags_enabled();
>  }
>  
>  static int khugepaged_wait_event(void)
> @@ -2251,7 +2255,7 @@ static void khugepaged_wait_work(void)
>  		return;
>  	}
>  
> -	if (khugepaged_enabled())
> +	if (hugepage_flags_enabled())
>  		wait_event_freezable(khugepaged_wait, khugepaged_wait_event());
>  }
>  
> @@ -2282,7 +2286,7 @@ static void set_recommended_min_free_kbytes(void)
>  	int nr_zones = 0;
>  	unsigned long recommended_min;
>  
> -	if (!khugepaged_enabled()) {
> +	if (!hugepage_flags_enabled()) {
>  		calculate_min_free_kbytes();
>  		goto update_wmarks;
>  	}
> @@ -2332,7 +2336,7 @@ int start_stop_khugepaged(void)
>  	int err = 0;
>  
>  	mutex_lock(&khugepaged_mutex);
> -	if (khugepaged_enabled()) {
> +	if (hugepage_flags_enabled()) {
>  		if (!khugepaged_thread)
>  			khugepaged_thread = kthread_run(khugepaged, NULL,
>  							"khugepaged");
> @@ -2358,7 +2362,7 @@ int start_stop_khugepaged(void)
>  void khugepaged_min_free_kbytes_update(void)
>  {
>  	mutex_lock(&khugepaged_mutex);
> -	if (khugepaged_enabled() && khugepaged_thread)
> +	if (hugepage_flags_enabled() && khugepaged_thread)
>  		set_recommended_min_free_kbytes();
>  	mutex_unlock(&khugepaged_mutex);
>  }
> -- 
> 2.26.3
> 

Reviewed-by: Zach O'Keefe <zokeefe@google.com>
