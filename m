Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DDE3573B5F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 18:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237243AbiGMQjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 12:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbiGMQje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 12:39:34 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB6452E6A4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 09:39:31 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id w185so10715947pfb.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 09:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ma77Mvvn5WCi7OoVCzQsf7qhxKePUdI/Bw8DTgElBPw=;
        b=dYFmTfA7Vht3EefVm6hz8JJ2mPp5TilswGfxMA9F81Dq9oMeqo6s05ElZzeGVx1TiY
         KryobChKkROmJPgr5PuVYTGhmpZepfhMgG0X2be1AaQ3MWzi19v/sGEG6HaJGZEYUKx4
         zqdnF4SSkM+lCO+ISj7ue39xX1ZBd2KpqHKjgoSzUW7qr/RNyOj9kkjiXOcj89IpCDNv
         PX5D08K9piuhozPdHbd3bMVVhtCMhKo4MzwLJaSQ3XhwGP8NeBol56JfCLemwTsOvx1A
         LZHOcjN82r7+1OftFgXjsSio4LFsg3cyA72Zpy8NxkPDG3+debmeK4QmF+MAeT5INQ1t
         cPdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ma77Mvvn5WCi7OoVCzQsf7qhxKePUdI/Bw8DTgElBPw=;
        b=GS10MHuTqFnf+QADV/m9TSKNOhjUs7bTNsr2pgt6MqeVM1kZXOoiJTJY+xW9I6W3FE
         DowRhhFdAKhn7lMr+5xVuMXFxLVTj8CjYfRQBm09270fSFFg78pVwJxzHy+ZYbN99+aS
         hx8FPk++vsnkLOE4teBLfw9XQYeN4LPQvjjdD0/z7936ZaGlS00PLiVJ4Pq9U4wdzxTx
         Sfg7tdRbD4tkKQiKKtQuTxVN9vHgiQSuBSp7HMzPOSOD18zy9UmlPrGibzcpjMCFrTpk
         X/KJJ5mFM8/9v+/QPWZ2i6iscbp1/heaBPsXyDSNUykGD38osY9FUvkWI7czBv2ZixtR
         XUJQ==
X-Gm-Message-State: AJIora/YVEGrQcOXU+IpKZIIkHlO0SrHznOcXtaE3LnA+iWL9kZFb1TQ
        qolcpRhJgUYcoylHvYGNqbdjzEVpHhSRYvMA
X-Google-Smtp-Source: AGRyM1vIBuaA9rk+Ok0vODvSS5OGBaYbjHWm7s5P4R06wKNiz80eCF1FM7hE6S6UMjjvlpIa86nycQ==
X-Received: by 2002:a62:542:0:b0:525:a313:fe28 with SMTP id 63-20020a620542000000b00525a313fe28mr3866498pff.73.1657730371126;
        Wed, 13 Jul 2022 09:39:31 -0700 (PDT)
Received: from google.com (55.212.185.35.bc.googleusercontent.com. [35.185.212.55])
        by smtp.gmail.com with ESMTPSA id f6-20020a62db06000000b005255f5d8f9fsm9025582pfg.112.2022.07.13.09.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 09:39:30 -0700 (PDT)
Date:   Wed, 13 Jul 2022 09:39:27 -0700
From:   Zach O'Keefe <zokeefe@google.com>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] mm/khugepaged: Avoid possible memory leak in failure path
Message-ID: <Ys71P4AsGkzmoRQh@google.com>
References: <20220713024109.62810-1-jrdr.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220713024109.62810-1-jrdr.linux@gmail.com>
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

On Jul 13 08:11, Souptick Joarder wrote:
> From: "Souptick Joarder (HPE)" <jrdr.linux@gmail.com>
> 
> smatch warnings:
> mm/khugepaged.c:2409 madvise_collapse() warn: possible memory
> leak of 'cc'
> 
> Avoiding possible memory leak.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Souptick Joarder (HPE) <jrdr.linux@gmail.com>
> ---
>  mm/khugepaged.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 0207fc0a5b2a..8da9e7467543 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -2397,12 +2397,6 @@ int madvise_collapse(struct vm_area_struct *vma, struct vm_area_struct **prev,
>  	BUG_ON(vma->vm_start > start);
>  	BUG_ON(vma->vm_end < end);
>  
> -	cc = kmalloc(sizeof(*cc), GFP_KERNEL);
> -	if (!cc)
> -		return -ENOMEM;
> -	cc->is_khugepaged = false;
> -	cc->last_target_node = NUMA_NO_NODE;
> -
>  	*prev = vma;
>  
>  	/* TODO: Support file/shmem */
> @@ -2415,6 +2409,12 @@ int madvise_collapse(struct vm_area_struct *vma, struct vm_area_struct **prev,
>  	if (!hugepage_vma_check(vma, vma->vm_flags, false, false, false))
>  		return -EINVAL;
>  
> +	cc = kmalloc(sizeof(*cc), GFP_KERNEL);
> +	if (!cc)
> +		return -ENOMEM;
> +	cc->is_khugepaged = false;
> +	cc->last_target_node = NUMA_NO_NODE;
> +
>  	mmgrab(mm);
>  	lru_add_drain_all();
>  
> -- 
> 2.25.1
> 
> 

Thanks for the fix!

I've also sent out another patch on top which addresses the actual missing
kfree()

