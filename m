Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8CB51EB4C
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 05:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbiEHDja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 23:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbiEHDj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 23:39:26 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA0B5F4F;
        Sat,  7 May 2022 20:35:38 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id js14so8236775qvb.12;
        Sat, 07 May 2022 20:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FxE4XGjmI8HG99YFnDDGRLArlyf58TuZbfYeq8IqEUI=;
        b=bbgICBSZWrjAQcZYAXA9zbbNY2KUX+3qeGALBg7ivtS6tUcMlxSdm8NpJ63Y+KyMV9
         JlFk/pJGB1BmJYN/iqzPn7ueSRBgMLRJKiIB5RaXXVlumFoKDowcBMlf5ebLwy/gZd8b
         SXz7klpZIItw/UzTjkwvfCea7ZnNUpTVM+bdxFGK4Fv6rK/PVgEEzrQAmE4k3VqsRtfj
         30OdQo30SJxM1aWgYTk8i1up08nfVJCCKRVECDpXYaapwmQY7T9QDWrVuHqhjYp5WM4M
         DFoMnZNbjMEiPupH/cS20g6hGgT8DEY2bJBbWvUoM0RqjdJ4eUiXvci4gIPDb6/PNG1n
         u0pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FxE4XGjmI8HG99YFnDDGRLArlyf58TuZbfYeq8IqEUI=;
        b=Tuo6xPEYXEYezORdHiiumj0KuMPB50OaSWg4gHmNJI37Y1WPdlHpS3wPXYMVQTiGuA
         59DcZ0wOyAtuSM6xioNxmSFix8630nFmoA/OY4wwRbgD9pIN7/64yPydmfJNYG4Uor+1
         9VRUI+1UwycVyfHBzdXm81oySghl8vfjNNSFLJQzrA46AacURJ7zzTkR5JPvZf7L4occ
         QEBXpxubqJFCdZwsACh0SpoD0CGTvso79sNeRHzax8/kqtwuNc98iK6fMSezF9fsKMhI
         ZSRlBk8K85d9jpp1K9TJ2CInfyVueQ2E9tO77zfaUUaNT+RDtUvfSotsHZPBf3ptyDMi
         2F/g==
X-Gm-Message-State: AOAM530HibnX/JCgZeksrThZwvGQUShj7bKeGZBjncRnw1IIpD4t5lAf
        UhbRoU6516cMp+p2FEufsxQ=
X-Google-Smtp-Source: ABdhPJzc6oMswYoHHjVB4iP2lxH5pbHY832BCcQzgTr77rQRZJ1hv68wot+Vh5HxSfLmoFwZLBIlvg==
X-Received: by 2002:a05:6214:19c2:b0:45a:8d3e:8efc with SMTP id j2-20020a05621419c200b0045a8d3e8efcmr8471733qvc.30.1651980937156;
        Sat, 07 May 2022 20:35:37 -0700 (PDT)
Received: from localhost ([98.242.65.50])
        by smtp.gmail.com with ESMTPSA id a1-20020a376601000000b0069fc13ce1d3sm4828397qkc.4.2022.05.07.20.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 May 2022 20:35:36 -0700 (PDT)
Date:   Sat, 7 May 2022 20:35:35 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Jason Wang <wangborong@cdjrlc.com>
Cc:     akpm@linux-foundation.org, Julia.Lawall@inria.fr,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: Re: [PATCH] arch/ia64: no need to initialise statics to 0
Message-ID: <Ync6h0QsjZa1jMFX@yury-laptop>
References: <20220508022628.96501-1-wangborong@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220508022628.96501-1-wangborong@cdjrlc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Fenghua Yu <fenghua.yu@intel.com>

On Sun, May 08, 2022 at 10:26:28AM +0800, Jason Wang wrote:
> Static variables do not need to be initialised to 0, because compiler
> will initialise all uninitialised statics to 0. Thus, remove the
> unneeded initializations.
> 
> Signed-off-by: Jason Wang <wangborong@cdjrlc.com>

Not sure why checkpatch picked me to be a reviewer for this.
Nevertheless...

> ---
>  arch/ia64/mm/tlb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/ia64/mm/tlb.c b/arch/ia64/mm/tlb.c
> index 7a2d608fba74..854e90c4e7eb 100644
> --- a/arch/ia64/mm/tlb.c
> +++ b/arch/ia64/mm/tlb.c
> @@ -84,7 +84,7 @@ wrap_mmu_context (struct mm_struct *mm)
>  		flush_bit = xchg(&ia64_ctx.flushmap[i], 0);
>  		ia64_ctx.bitmap[i] ^= flush_bit;
>  	}
> - 
> +

This one is unrelated to the patch description. Can you split the
patch, or add a couple words about this cleanup?

>  	/* use offset at 300 to skip daemons */
>  	ia64_ctx.next = find_next_zero_bit(ia64_ctx.bitmap,
>  				ia64_ctx.max_ctx, 300);
> @@ -144,7 +144,7 @@ static inline void up_spin(struct spinaphore *ss)
>  static struct spinaphore ptcg_sem;
>  static u16 nptcg = 1;
>  static int need_ptcg_sem = 1;
> -static int toolatetochangeptcgsem = 0;
> +static int toolatetochangeptcgsem;

There are at least 460 global static variables initialized explicitly.

yury:linux$ git grep "^static" | grep "= 0;" | wc -l
460

Are you going to fix them all? If not why this one is so special?

Before applying this, let's ask Fenghua - maybe it was his intention
to underline that the variable is initialized as 0.  

Thanks,
Yury

>  /*
>   * Kernel parameter "nptcg=" overrides max number of concurrent global TLB
> -- 
> 2.35.1
