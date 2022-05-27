Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC88536937
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 01:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355186AbiE0XpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 19:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232365AbiE0XpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 19:45:04 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE8065D23
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 16:45:02 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id j10so8886863lfe.12
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 16:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=IALt29wlC4JKslLVMsLFRhR5StYJLg09Im2CzgSWtjU=;
        b=BSKfdkBpBFTf6f+PiPWq/EXSKA9i8id4uv80ipDYcRnsAuJgnz/nDzvg02VDbWclCK
         1TAP2co9doBzOdEdmkdVHP8qaNrTPtRuT7tuB4UXYWjHiP/oWai5WXRAVAtk8lZJeJik
         zzPZ5AQ/Epvcm6XRPzH+jWa0V+SFaFv+OGLsrS5r+m8oB253MVhhyqZL447hADuQyV/y
         0Nw031lvGm96EZhNUMbUaK4GF3vPSZO4tONyWX2dqdmllE0icr1nUcfAF1zNjNLeSSkl
         zCA+TmnbcOmXugIUnJ8to7IfOB1iJr1RLAiQPDxiXgFXwZMeedcnL2Mva5gSpKT5gaWg
         qJJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=IALt29wlC4JKslLVMsLFRhR5StYJLg09Im2CzgSWtjU=;
        b=EfZZNQzbXFHSgDV/g3PBFuG06PHaGPz4SBSmkDylWxoUdLBZox1u62ku/pRjH01+fP
         3LVZN20q6cADpHK8bRaHNpPkcC7SB/SGiU+9Rpl8PCZCgl6PLrRN71fOb8uiNSG+yXR+
         j1MepJ8YxHjz7m0U1oT4Bo5nyPkvxJ2D7b2JWq+t+e6c2pH1YvJtgQAnE5j1ThBmb7Jb
         +DhQg3JM6asZKZsX/xSWGp7JhKSVw3DVgG1AdXm/M90QROPGkOdCUzhPq/CtQJhlPdza
         wE2TeGdloXmqgUmNp2c5b2dJHJ0L5bCyWeeLkKaI3muUc13HFIpz1iDZqGnAR34KnlQA
         NYmg==
X-Gm-Message-State: AOAM530zzR6syPVTP7ucvMJuf1byvmh5JUnC1MB62ExoDPfHmQU9/ULX
        55lINVjAwPMDhxMOnVqfhk0fUw==
X-Google-Smtp-Source: ABdhPJztWwtE94iIyLx6oVtYfG/pmmvgHHVHI/8vyuAAuATDZ9rdARTLukXZNRS229FkwcWe0iv5VQ==
X-Received: by 2002:a05:6512:130a:b0:477:b632:27eb with SMTP id x10-20020a056512130a00b00477b63227ebmr31008546lfu.131.1653695100867;
        Fri, 27 May 2022 16:45:00 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id q20-20020a05651232b400b00473c87152bcsm1061360lfe.127.2022.05.27.16.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 16:45:00 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 783451094B9; Sat, 28 May 2022 02:46:57 +0300 (+03)
Date:   Sat, 28 May 2022 02:46:57 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Jakub =?utf-8?Q?Mat=C4=9Bna?= <matenajakub@gmail.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        vbabka@suse.cz, mhocko@kernel.org, mgorman@techsingularity.net,
        willy@infradead.org, liam.howlett@oracle.com, hughd@google.com,
        riel@surriel.com, rostedt@goodmis.org, peterz@infradead.org
Subject: Re: [PATCH 2/2] [PATCH 2/2] mm: add merging after mremap resize
Message-ID: <20220527234657.nsn6e7jjwttblzyi@box.shutemov.name>
References: <20220527104810.24736-1-matenajakub@gmail.com>
 <20220527104810.24736-3-matenajakub@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220527104810.24736-3-matenajakub@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27, 2022 at 12:48:10PM +0200, Jakub Matěna wrote:
> When mremap call results in expansion, it might be possible to merge the
> VMA with the next VMA which might become adjacent. This patch adds
> vma_merge call after the expansion is done to try and merge.
> 
> Signed-off-by: Jakub Matěna <matenajakub@gmail.com>
> ---
>  mm/mremap.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/mremap.c b/mm/mremap.c
> index 303d3290b938..c41237e62156 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -9,6 +9,7 @@
>   */
>  
>  #include <linux/mm.h>
> +#include <linux/mm_inline.h>
>  #include <linux/hugetlb.h>
>  #include <linux/shm.h>
>  #include <linux/ksm.h>
> @@ -1022,8 +1023,11 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
>  				}
>  			}
>  
> -			if (vma_adjust(vma, vma->vm_start, addr + new_len,
> -				       vma->vm_pgoff, NULL)) {
> +			vma = vma_merge(mm, vma, addr + old_len, addr + new_len,
> +					vma->vm_flags, vma->anon_vma, vma->vm_file,
> +					vma->vm_pgoff + (old_len >> PAGE_SHIFT), vma_policy(vma),
> +					vma->vm_userfaultfd_ctx, anon_vma_name(vma));

The arguement list gets busy. Maybe some variables would help.
Calculation around vm_pgoff is not obvious and requires some explanation.

> +			if (!vma) {
>  				vm_unacct_memory(pages);
>  				ret = -ENOMEM;
>  				goto out;
> -- 
> 2.35.1
> 

-- 
 Kirill A. Shutemov
