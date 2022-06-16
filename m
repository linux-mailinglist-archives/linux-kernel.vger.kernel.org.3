Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53DAE54D601
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 02:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346613AbiFPAUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 20:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239840AbiFPAUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 20:20:23 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05606393EA
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 17:20:22 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id gc3-20020a17090b310300b001e33092c737so53587pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 17:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SkJoPGJXt4nE3myYQRLsJH7aIpj3qWs/Wi2vTnmnVyk=;
        b=FloPuQqtwiyreiEB0Vnz4e4crk4w0dEhNOtGAoaJ0KAXOExNkpOfZcLU3OzZZBo9FY
         ZbZ/qPQ7sCOFnGetw/3kLKDBxLJw8veccTwIW8CB/D/AuFUV6e6o/BNuSH/zXJFwQBZs
         FWMeRtXfFXAe32Vv04joUz/r25S9A2M22nDK+Cnbwr2MjgY4G4kV0lp3s//C39+qsPEx
         o6OE5MhLaA8F1zgGPgX+ivtQMtWhTA6nQzalCLROaKQ0Ha1Vw8ZV1si+/M855LY2rcbD
         EaBwvA2p3NqYoWruBjfTchE1IJSEj/RRf+RyHEigAYsEBN3X6ipSMwZl16fl+fLLjCpN
         F95g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SkJoPGJXt4nE3myYQRLsJH7aIpj3qWs/Wi2vTnmnVyk=;
        b=YdchtCqgPvUYSzdFkHXfWaDl8c7Y1tsSS0hy5b2Bn5aWKWQAb3ca8dTwJ+z+1ji6Af
         jlbpF+LRspr2mevmJ5k6Rm7CUdwOv0EiKjKyB8/ozeqtwqxwc9v4CFlDLxAG7y8ufNW6
         dtt07zlndBuhBskMfL/i4mYm4bGb4n1zLqomld2j0lxpExmRnsbdegyqc4o8K+lbQsw4
         wpGx7pgUpqw3nsPUsMNa5pfVLNoTr7ddu3bzbtOyl0Kw3rlpl9qnFBBr59l/gXF9oa2p
         CiuM1Sislmns8ldR5cXXqE+MnVFfn6rqeKz3ThD8F/Z91bM30C61vPziuT0sjlj86uTz
         odkA==
X-Gm-Message-State: AJIora/8wsP47KJCtmm9N5q0C49r/pMd597lFNfd0FHi/GMk3hlzW6xL
        Mfeh1vI3UVHKaalp5Ztm6d41eQ==
X-Google-Smtp-Source: AGRyM1scTZKWEcSf4G9Ym4l+MAXkk+0KSertyrXy5iHECB05ChW0eNrZNFZpkvGxTCt6onI5rdRwjA==
X-Received: by 2002:a17:903:1252:b0:168:d68e:8bd9 with SMTP id u18-20020a170903125200b00168d68e8bd9mr1992368plh.141.1655338821217;
        Wed, 15 Jun 2022 17:20:21 -0700 (PDT)
Received: from google.com (55.212.185.35.bc.googleusercontent.com. [35.185.212.55])
        by smtp.gmail.com with ESMTPSA id t20-20020a17090a951400b001d903861194sm2413778pjo.30.2022.06.15.17.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 17:20:20 -0700 (PDT)
Date:   Wed, 15 Jun 2022 17:20:17 -0700
From:   Zach O'Keefe <zokeefe@google.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     vbabka@suse.cz, kirill.shutemov@linux.intel.com,
        willy@infradead.org, linmiaohe@huawei.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v4 PATCH 7/7] doc: proc: fix the description to THPeligible
Message-ID: <Yqp3QbJKqo/+xdKS@google.com>
References: <20220615172926.546974-1-shy828301@gmail.com>
 <20220615172926.546974-8-shy828301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615172926.546974-8-shy828301@gmail.com>
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
> The THPeligible bit shows 1 if and only if the VMA is eligible for
> allocating THP and the THP is also PMD mappable.  Some misaligned file
> VMAs may be eligible for allocating THP but the THP can't be mapped by
> PMD.  Make this more explictly to avoid ambiguity.
> 
> Signed-off-by: Yang Shi <shy828301@gmail.com>
> ---
>  Documentation/filesystems/proc.rst | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> index 1bc91fb8c321..a5e41e636a1a 100644
> --- a/Documentation/filesystems/proc.rst
> +++ b/Documentation/filesystems/proc.rst
> @@ -514,8 +514,10 @@ replaced by copy-on-write) part of the underlying shmem object out on swap.
>  "SwapPss" shows proportional swap share of this mapping. Unlike "Swap", this
>  does not take into account swapped out page of underlying shmem objects.
>  "Locked" indicates whether the mapping is locked in memory or not.
> +
>  "THPeligible" indicates whether the mapping is eligible for allocating THP
> -pages - 1 if true, 0 otherwise. It just shows the current status.
> +pages as well as the THP is PMD mappable or not - 1 if true, 0 otherwise.
> +It just shows the current status.
>  
>  "VmFlags" field deserves a separate description. This member represents the
>  kernel flags associated with the particular virtual memory area in two letter
> -- 
> 2.26.3
> 

Thanks for updating this!

Reviewed-by: Zach O'Keefe <zokeefe@google.com>
