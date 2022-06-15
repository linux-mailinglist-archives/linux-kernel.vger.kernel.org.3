Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3C6654CD96
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 17:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345955AbiFOPzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 11:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346021AbiFOPy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 11:54:57 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021632FFF6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 08:54:56 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id i15so10792208plr.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 08:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mreepqnLlPZFVd8ASkU0Ah/jZvsfiVvVvF1zUpWRDWE=;
        b=JIbS8nIuSpRIHU9HEZsMsxG7Z9HpGeMR+yEAX7PcKh1qcZUZJgrABhPr7cNjSPWBAo
         zkZEFqL87RspX0bf4C2GtOJqzslKAtf9wMVKrq1OahdWXuOnbJlOO0dyUiaWQ12UFlE2
         vfgJUmrj/frlTbhNf275MjeH0dqVYGt4rRph69QzliWw1BB43Dp4C3ZmhjcxW6mmr3J8
         jF4QQRfUxa4WtQRikKKYjDfh3dBeAr8gDfQv9LUlfo5tRIYym9bHTJbA4AVtFr6wbeP/
         7PHOs1bbn9TlZYYEp91Y6aqC/s9wEsr/aRebszXSM1Sj9Mjb7XezngLrKsszMjNNo+Rs
         z4bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mreepqnLlPZFVd8ASkU0Ah/jZvsfiVvVvF1zUpWRDWE=;
        b=NeG9R/sPSNOGlAkPXD7Pkg8cRa0QOQKGcLamvKl0WBVVQI8M+sGBOAuyhwZSsyF7bF
         f6qSxSw8jtrKyY/qikQEOagd5KbiVB7HnrXzDtmpf+ght3RYSIp2G5i0o3ss1mRl3Fv9
         lgCkq5LwzXu42wEQPL6/75zRYVFIu/ZL+nT/hFK6CG5VRetJ2bNz1tEQfphfEJoLLuz2
         jAI3NzxQ+bDrkzG+P2KcFj+HBrkQCwefqAl4oNqogFgNA24ImMO2leiXMBKfj7Lce15r
         wBGrH2SsUJozjB/jQZL7FyeyiFOfKI6Z6PwZv9aCrIHVmbeOxg/gkE63ktELq3dKh/yq
         Ey3A==
X-Gm-Message-State: AJIora/UNQdni19jKrL5+IbVoQTRuYNwcghqKqfiI00TDUuJ76eiMGeL
        57Q1Lc7I2yXKg0NeRvkYFC+5tQ==
X-Google-Smtp-Source: AGRyM1vQqRMnufvqMyDdXnDthwID1ZqRrTeVfioKLhTf97yBKB0/HBAXmIsWBSBAL2cB5rQ8vyymvg==
X-Received: by 2002:a17:902:d64a:b0:168:fc10:7f5f with SMTP id y10-20020a170902d64a00b00168fc107f5fmr297189plh.123.1655308495831;
        Wed, 15 Jun 2022 08:54:55 -0700 (PDT)
Received: from google.com (55.212.185.35.bc.googleusercontent.com. [35.185.212.55])
        by smtp.gmail.com with ESMTPSA id f187-20020a636ac4000000b00405306de2c2sm8522756pgc.65.2022.06.15.08.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 08:54:55 -0700 (PDT)
Date:   Wed, 15 Jun 2022 08:54:49 -0700
From:   Zach O'Keefe <zokeefe@google.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, aarcange@redhat.com,
        willy@infradead.org, vbabka@suse.cz, dhowells@redhat.com,
        neilb@suse.de, apopple@nvidia.com, david@redhat.com,
        surenb@google.com, peterx@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] mm/khugepaged: minor cleanup for collapse_file
Message-ID: <YqoAydWk/IcMp5d2@google.com>
References: <20220611084731.55155-1-linmiaohe@huawei.com>
 <20220611084731.55155-5-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220611084731.55155-5-linmiaohe@huawei.com>
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

On 11 Jun 16:47, Miaohe Lin wrote:
> nr_none is always 0 for non-shmem case because the page can be read from
> the backend store. So when nr_none ! = 0, it must be in is_shmem case.
> Also only adjust the nrpages and uncharge shmem when nr_none != 0 to save
> cpu cycles.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/khugepaged.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 1b5dd3820eac..8e6fad7c7bd9 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1885,8 +1885,7 @@ static void collapse_file(struct mm_struct *mm,
>  
>  	if (nr_none) {
>  		__mod_lruvec_page_state(new_page, NR_FILE_PAGES, nr_none);
> -		if (is_shmem)
> -			__mod_lruvec_page_state(new_page, NR_SHMEM, nr_none);
> +		__mod_lruvec_page_state(new_page, NR_SHMEM, nr_none);
>  	}


Might be worth a small comment here - even though folks can see in above code
that this is only incremented in shmem path, might be nice to say why it's
always 0 for non-shmem (or conversely, why it's only possible to be non 0 on
shmem).

>  
>  	/* Join all the small entries into a single multi-index entry */
> @@ -1950,10 +1949,10 @@ static void collapse_file(struct mm_struct *mm,
>  
>  		/* Something went wrong: roll back page cache changes */
>  		xas_lock_irq(&xas);
> -		mapping->nrpages -= nr_none;
> -
> -		if (is_shmem)
> +		if (nr_none) {
> +			mapping->nrpages -= nr_none;
>  			shmem_uncharge(mapping->host, nr_none);
> +		}
>  
>  		xas_set(&xas, start);
>  		xas_for_each(&xas, page, end - 1) {
> -- 
> 2.23.0
> 
> 

Otherwise,

Reviewed-by: Zach O'Keefe <zokeefe@google.com>
