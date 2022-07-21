Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53A3557C99A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 13:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233089AbiGULLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 07:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233081AbiGULLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 07:11:15 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB4C8212A
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 04:11:14 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id gn24so1280586pjb.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 04:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fSRR3HUXQa8gWXcppph++5GrWO2AjYfQ7CTEOhYqZCs=;
        b=e1KxmNq+nkt9EMDqm9MSD7YlCobWK7GJiAdyH47Cid7CVB6C2g24iaaa9/1sxh68hq
         m73d3Q0Ii3QdA61/fvJeIej48pHf4VU4nvxYaBaXNR+TS+xfI5F4OdgANqv5MPBTzZ1v
         kujapR8ydKhiJVvUAfosEqcnr0NnL8fLgfaTf0yndIqSZMkBF8HUuk/pQx049BXF0PXl
         BLSQKdLvRT70HPh2t19xpdNm4GfRYIt3s+huyd4Wex9Ee2WL+lnQRu6deg+GvMd0dwky
         2sy1K+2PG9ZdDyTQxOTcnUwwQI+cpc5NKGJXpjA8JTTiw7x9FMy2CengOHOLM7wtIAjP
         K44g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fSRR3HUXQa8gWXcppph++5GrWO2AjYfQ7CTEOhYqZCs=;
        b=JApejhoeJB1VWcfemFb1X8cm4AS6H9chRlzrU/A4DcvuFNwHWG1FGI3i1EPJVFpwJR
         g0Ot8b71qV2C7PnKHMOryXowQM0W0zQxNg0GZeKsiD439HybKCnkg+MpalFYHDZQXK1g
         6cXF8nrZQfWn2Syn/aOMvs/pZk+AT4aP59cCz9OUXF0IoIIQTplJ8RVb0Sbm6FNvzssR
         u5nxjA1BhiBY1yXbF5F0Iy0sy3gBhk51RtpFCdaQefLVDVqpH+3nTuX8TIv/jg9pJ55w
         DEBnJ/RgyWbPdGAPlmIQ/+/RShatT7L00godW2BlMP8RlTQmwPBzy0wmqg3K+CcoontY
         lSkQ==
X-Gm-Message-State: AJIora+ePjuMPIZux2YKWSAs5cDxm19VaoyxoJDIxMunix1TogPBvYdb
        lW9U3I0NjtQ5ocFF+Y/1hFsgUQ==
X-Google-Smtp-Source: AGRyM1t2THWinUPnu4nkTqMoyVO7eZT1sVq3d+M6VWwMpADOY86vFWzYzKL9d2DB9eZDNy+2tWmxNQ==
X-Received: by 2002:a17:902:ecca:b0:16c:569:47d8 with SMTP id a10-20020a170902ecca00b0016c056947d8mr44453227plh.97.1658401873670;
        Thu, 21 Jul 2022 04:11:13 -0700 (PDT)
Received: from google.com (55.212.185.35.bc.googleusercontent.com. [35.185.212.55])
        by smtp.gmail.com with ESMTPSA id n1-20020a170902d2c100b0016a565f3f34sm1425865plc.168.2022.07.21.04.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 04:11:12 -0700 (PDT)
Date:   Thu, 21 Jul 2022 04:11:09 -0700
From:   Zach O'Keefe <zokeefe@google.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Yang Shi <shy828301@gmail.com>
Subject: Re: linux-next: build warning after merge of the mm tree
Message-ID: <Ytk0TQO9khUQgjxT@google.com>
References: <20220721195508.15f1e07a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721195508.15f1e07a@canb.auug.org.au>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 21 19:55, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the mm tree, today's linux-next build (powerpc
> ppc64_defconfig) produced this warning:
> 
> In file included from arch/powerpc/include/asm/book3s/64/mmu-hash.h:20,
>                  from arch/powerpc/include/asm/book3s/64/mmu.h:32,
>                  from arch/powerpc/include/asm/mmu.h:393,
>                  from arch/powerpc/include/asm/lppaca.h:46,
>                  from arch/powerpc/include/asm/paca.h:18,
>                  from arch/powerpc/include/asm/current.h:13,
>                  from include/linux/thread_info.h:23,
>                  from include/asm-generic/preempt.h:5,
>                  from ./arch/powerpc/include/generated/asm/preempt.h:1,
>                  from include/linux/preempt.h:78,
>                  from include/linux/spinlock.h:55,
>                  from include/linux/mmzone.h:8,
>                  from include/linux/gfp.h:7,
>                  from include/linux/mm.h:7,
>                  from mm/khugepaged.c:4:
> arch/powerpc/include/asm/book3s/64/pgtable.h:190:25: warning: "__pte_index_size" is not defined, evaluates to 0 [-Wundef]
>   190 | #define PTE_INDEX_SIZE  __pte_index_size
>       |                         ^~~~~~~~~~~~~~~~
> arch/powerpc/include/asm/book3s/64/pgtable.h:241:39: note: in expansion of macro 'PTE_INDEX_SIZE'
>   241 | #define PMD_SHIFT       (PAGE_SHIFT + PTE_INDEX_SIZE)
>       |                                       ^~~~~~~~~~~~~~
> include/linux/huge_mm.h:109:25: note: in expansion of macro 'PMD_SHIFT'
>   109 | #define HPAGE_PMD_SHIFT PMD_SHIFT
>       |                         ^~~~~~~~~
> include/linux/huge_mm.h:105:26: note: in expansion of macro 'HPAGE_PMD_SHIFT'
>   105 | #define HPAGE_PMD_ORDER (HPAGE_PMD_SHIFT-PAGE_SHIFT)
>       |                          ^~~~~~~~~~~~~~~
> mm/khugepaged.c:95:5: note: in expansion of macro 'HPAGE_PMD_ORDER'
>    95 | #if HPAGE_PMD_ORDER < 16
>       |     ^~~~~~~~~~~~~~~
> 
> Introduced by commit
> 
>   adcc4e193b6b ("mm/khugepaged: use minimal bits to store num page < HPAGE_PMD_NR")
> 
> So HPAGE_PMD_ORDER is not a constant on ppc64 ...
> 
> I applied this hack for today (which makes it build without warning and
> puts things more or less back as they were for ppo64).
> 
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Thu, 21 Jul 2022 19:49:40 +1000
> Subject: [PATCH] fix up for "mm/khugepaged: use minimal bits to store num page < HPAGE_PMD_NR"
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  mm/khugepaged.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 28cb8429dad4..d8e388106322 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -92,7 +92,9 @@ struct collapse_control {
>  	bool is_khugepaged;
>  
>  	/* Num pages scanned per node */
> -#if HPAGE_PMD_ORDER < 16
> +#if defined(CONFIG_PPC64)
> +	u32 node_load[MAX_NUMNODES];
> +#elif HPAGE_PMD_ORDER < 16
>  	u16 node_load[MAX_NUMNODES];
>  #else
>  	u32 node_load[MAX_NUMNODES];
> -- 
> 2.35.1
> 
> -- 
> Cheers,
> Stephen Rothwell

Thanks Stephen, and apologies here. I thought I had taken a look at all archs
(just inspection, I didn't attempt to build them all) - but seems like I missed
this one..

I'm fine with the change, though I could see the argument that this is getting a
little complicated to save what is likely a few bits in the common case.
Appreciate the fix.

Reviewed-by: Zach O'Keefe <zokeefe@google.com>

Best,
Zach


