Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 186E854D595
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 01:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347869AbiFOX5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 19:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238604AbiFOX5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 19:57:46 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB3E0DF6F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 16:57:45 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id hv24-20020a17090ae41800b001e33eebdb5dso4479091pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 16:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ogTieaFqi6CNOTX3+q0iK+76j2aYotKQRzqOleB5Sgo=;
        b=MbATXkKayIK3jtaXf7FFj7hMDbsDmZNluuRpWCQTBCAtUaMKLwy36mTr2OhTZGv2Vz
         ksKW1th55SbzG1rf0Ht5GJSU2gK5BVClFDNwsHFuTjsqzNFCTB4BAU371VaQZlSsg4xq
         BaQI5dACSxwUHvyxY/k+3NU1RYTXmblT+vCw+X6sH3obsOTcbKGhX3itBuh70WquUD7g
         g3aT9Yy1mcBvg80dHB7GY1VhkgRr+3ufvMpVlOVcAqMWDfZskla6UTpbct7/fMXwAG0f
         UCS0IiO2RMZTkK+Yso2JBZN3MehQJpe3tPSxj0wj0CLL0zkVvQ1I/jDOgM9WPaqjbAJk
         B/dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ogTieaFqi6CNOTX3+q0iK+76j2aYotKQRzqOleB5Sgo=;
        b=K/pCRBj/kXCy4LiYVxMdayAfFvzJLPSBVf0anEsH82lOttsyvNL0Whi/c/mxoVKxoq
         i3Lj4qKeAh/lpp0CyjVccC+f4tp64CC+5LSWyRNAyTW8qMc6ShK8krh13+iZZ6PRa+hV
         Uwr47FamhvyO78SkXoN3WShzQjxWXoca0SCnGtbspXuRcTDaTKKBA60a8h8sIC5eVLY3
         o5ajXBsBVG97XxiyBVDrCw3IHgwywr2HXlSRO0WAGRjU6Fl4IvAHMopPgOzB9rC0F02j
         RAhqx2y2uvewzmFbwU1ipBz2ERPT9Qokbu99+upOtU4HpOqOOQTn5zXs6pEXtasQ+r1m
         Scbw==
X-Gm-Message-State: AJIora9kXZ0YQu5oNI+PHERjaiBGgek1Sehoa1KlmnG1qn573LTUbBUO
        oYHEDOZcwzNTW4w8aVHhrrCZVJ095sYXCMdf
X-Google-Smtp-Source: AGRyM1vMKwU5cbMs69vbFx1BXgBv8oNQR+IcWe+vYc8ooIejYyS6Q4MnouC1XzURuXko6WkekW38sQ==
X-Received: by 2002:a17:902:ea0f:b0:164:1a71:bef1 with SMTP id s15-20020a170902ea0f00b001641a71bef1mr1800234plg.52.1655337465130;
        Wed, 15 Jun 2022 16:57:45 -0700 (PDT)
Received: from google.com (55.212.185.35.bc.googleusercontent.com. [35.185.212.55])
        by smtp.gmail.com with ESMTPSA id x13-20020a170902a38d00b00163f183ab76sm195015pla.152.2022.06.15.16.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 16:57:44 -0700 (PDT)
Date:   Wed, 15 Jun 2022 16:57:40 -0700
From:   Zach O'Keefe <zokeefe@google.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     vbabka@suse.cz, kirill.shutemov@linux.intel.com,
        willy@infradead.org, linmiaohe@huawei.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v4 PATCH 3/7] mm: khugepaged: better comments for anon vma
 check in hugepage_vma_revalidate
Message-ID: <Yqpx9D6blRSuIL2K@google.com>
References: <20220615172926.546974-1-shy828301@gmail.com>
 <20220615172926.546974-4-shy828301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615172926.546974-4-shy828301@gmail.com>
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
> The hugepage_vma_revalidate() needs to check if the vma is still
> anonymous vma or not since the address may be unmapped then remapped to
> file before khugepaged reaquired the mmap_lock.
> 
> The old comment is not quite helpful, elaborate this with better
> comment.
> 
> Signed-off-by: Yang Shi <shy828301@gmail.com>
> ---
>  mm/khugepaged.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index db0b334a7d1f..5baa394e34c8 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -960,7 +960,13 @@ static int hugepage_vma_revalidate(struct mm_struct *mm, unsigned long address,
>  		return SCAN_ADDRESS_RANGE;
>  	if (!hugepage_vma_check(vma, vma->vm_flags))
>  		return SCAN_VMA_CHECK;
> -	/* Anon VMA expected */
> +	/*
> +	 * Anon VMA expected, the address may be unmapped then
> +	 * remapped to file after khugepaged reaquired the mmap_lock.
> +	 *
> +	 * hugepage_vma_check may return true for qualified file
> +	 * vmas.
> +	 */
>  	if (!vma->anon_vma || !vma_is_anonymous(vma))
>  		return SCAN_VMA_CHECK;
>  	return 0;
> -- 
> 2.26.3
> 

Reviewed-by: Zach O'Keefe <zokeefe@google.com>
