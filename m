Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2A055ACFEE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 12:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236344AbiIEKWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 06:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237330AbiIEKWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 06:22:09 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47AE42DC1
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 03:21:30 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id t3so3030060ply.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 03:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=WOiQyNrs1be4WayrMavedXF8G5KASrWmWSypKhmVsIU=;
        b=hFivwXjCJgNMTE0WKvMzT5WXMBkAIJt6CXI1uU+pYsutcunyv4eOdClS1rnDdJfIUJ
         JfIWgE1craEdhAv4qmADejmOiU7u9LJeONE/Yr3LsLPBwyJ5wH+Q5Tb+ur3H369in4JP
         T/DNHfOAE/UbkKZFBtVZEDlJL1Y/8dImJkvXb+KcjW/DNdooHos2MbZD/4dVoOOZSrij
         fjjsU1FG8eddTxJH1h4qcROGXq7906yrGQZcry+fuPWRJ2DYOVEN1X5oXlR9CHMDwkwH
         Osc8B94EhgUbxKIAqLpFX2eNUJ+99LuVu39rjBvi2EM1Kjr5LAcywTtmMcYvlJ2Tw1IT
         SLIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=WOiQyNrs1be4WayrMavedXF8G5KASrWmWSypKhmVsIU=;
        b=C6ZuzB8SlM7IQPIDRAnoN8aOVAdU8RPlJsOvDQhebeanzUhwRezo/pkhqgteS0LGqv
         ldoWMDa81wWa0iF86IwOspIYfnQ+CNq7S8SA5o1yV6S4DEYvXcwTNqzBrpkMu//UX4wx
         boUqV6hEgZfdHyaIb2iRP6pleIvIIzAyPX2yXO2OvSTEh00aMhQwIl5DEuxAC4KgSSFt
         0w4Gucqfk2q7FcYt/wOzLxu+VarMoZRpuzIXCd5394fzOAILTGkcCVhHwwApoemvLnPo
         hcUUDMKJm/MnEe7Dx3b3olum+qVE40/c043mnStxrM5whrvyztx8I8+sY7DevbKLJibf
         UjLg==
X-Gm-Message-State: ACgBeo1sHLXq29uLcZhhJY0HHbMX+No8bEOb2SrWl9AO44ud3URVl1n6
        jiknYdhC39cdxaKgpt0rmvA=
X-Google-Smtp-Source: AA6agR7LIPqTF9y5KMw44brYpz00x4KtHrMLzckeENRVkFHugvHjNVUGpZGbBHlt5s41DmP5uDLinA==
X-Received: by 2002:a17:903:189:b0:176:861a:d4d1 with SMTP id z9-20020a170903018900b00176861ad4d1mr10195220plg.154.1662373289692;
        Mon, 05 Sep 2022 03:21:29 -0700 (PDT)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id d14-20020a170903230e00b00174849e6914sm7095326plh.191.2022.09.05.03.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 03:21:29 -0700 (PDT)
Date:   Mon, 5 Sep 2022 19:21:24 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Jeungwoo Yoo <casionwoo@gmail.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        Sangyun Kim <sangyun.kim@snu.ac.kr>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: Remove d-cache clean operation at
 preserve_boot_args().
Message-ID: <YxXNpJlWdDvZqJKQ@hyeyoo>
References: <20220904193020.65556-1-casionwoo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220904193020.65556-1-casionwoo@gmail.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

note that I am not an expert on arm64 so I may be wrong,
and I'll be happy to be proven wrong ;)

On Sun, Sep 04, 2022 at 09:30:19PM +0200, Jeungwoo Yoo wrote:
> Kernel expects only the clean operation as a booting requirement in
> arm64 architecture [1], therefore, the kernel has to invalidate any
> cache entries after accessing a memory in the booting time (before
> enabling D-cache and MMU) not to overwrite the memory with the stale
> cache entry.

Yes.

> Same applied in preserve_boot_args(), kernel saves boot arguments into
> 'boot_args' and invalidates the corresponding cache entry. However,
> according to the 'dcache_inval_poc()' implementation, the cache entry
> will be not only invalidated but also cleaned.

Yeah, that's when @start or @end passed to dcache_inval_poc() is not aligned to
cache line size. and @end may not be aligned if cache line size is not 32.
(@start is always aligned)


> That means if there is a
> stale cache entry corresponding to the address of the 'boot_args', the
> saved boot arguments in 'boot_args' will be overwritten by the stale
> cache entry.

To clarify, "If existing cache entry became stale after writing to memory..."

> Therefore, it uses 'dv ivac' instruction directly instead
> of calling 'dcache_inval_poc()'.
> 
> The address of the 'boot_args' is aligned to the cache line size and the
> size of 'boot_args' is 32 byte (8 byte * 4), therefore, a single
> invalidate operation is enough to invalidate the cache line belonging to
> the 'boot_args'.

Is the cache line size always >= 32 bytes? 
If I'm not mistaken, the minimum size is 16 bytes.

> Sometimes clean operation is required not to lose any contents in the
> cache entry but not the target of the invalidation. However, in this
> case, there is no valid cache entries at a very early booting stage and
> preserve_boot_args() is not called by any other (non-primary) CPUs.
> Therefore, this invalidation operation will not introduce any problems.

I think this patch makes sense. Losing data in invalidation
operation is not a concern for booting process. And it may lead to writing
stale data to memory if:

	- a boot loader only cleans address range corresponding to
	  kernel image (and not invalidate) according to booting.rst

Thanks!

> [1] in Documentation/arm64/booting.rst:
> The address range corresponding to the loaded kernel image must be
> cleaned to the PoC.
> 
> Co-developed-by: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
> Signed-off-by: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
> 
> Co-developed-by: Sangyun Kim <sangyun.kim@snu.ac.kr>
> Signed-off-by: Sangyun Kim <sangyun.kim@snu.ac.kr>
> 
> Signed-off-by: Jeungwoo Yoo <casionwoo@gmail.com>
> ---

there should be no newlines between tags :)

>  arch/arm64/kernel/head.S | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> index cefe6a73ee54..916227666b07 100644
> --- a/arch/arm64/kernel/head.S
> +++ b/arch/arm64/kernel/head.S
> @@ -121,9 +121,7 @@ SYM_CODE_START_LOCAL(preserve_boot_args)
>  
>  	dmb	sy				// needed before dc ivac with
>  						// MMU off
> -
> -	add	x1, x0, #0x20			// 4 x 8 bytes
> -	b	dcache_inval_poc		// tail call
> +	dc	ivac, x0			// Invalidate potentially stale cache line
>  SYM_CODE_END(preserve_boot_args)
>  
>  SYM_FUNC_START_LOCAL(clear_page_tables)
> -- 
> 2.34.3
> 

-- 
Thanks,
Hyeonggon
