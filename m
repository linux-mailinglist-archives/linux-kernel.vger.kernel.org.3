Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CCD453D917
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 03:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243263AbiFEBhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 21:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233802AbiFEBhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 21:37:36 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC0E1F61C
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 18:37:34 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id y15so8291466qtx.4
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jun 2022 18:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=jWDrrOLl2EZyoh/ovhCu5FFdvKuZyrni45da+0YMjWA=;
        b=rWCNTJELpwwDenzihOmOGfVi9ACnEEF9ujR1JfnBx/7hfrPrEaIEqDvuJ+oi1GOdVG
         Ie4keEJmW5Ql4Mye9Qfco/EZ/qgcuQxksdn/6IXUuDoPLzis0Erx3lcC3oyrWAE4wjnr
         dwJ3G3rHos4YeMui9LytI0yASIdQezPpAt2RvgMlFAAvGBuKryKQTfQrLo1Wcx+24Tzv
         2K6JmULWP+YPeni3Mt8AebSbvQrlk7tSwC0urdMiU9HYv/1g0KkgQE1J7YwL+GHQgEwn
         qjV6skucZRi2OpKJqiBnqYivlubxW3BBHuVgjKBCYQui9cC8xE/MXUeUXvNw2cRsu3/D
         wsYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=jWDrrOLl2EZyoh/ovhCu5FFdvKuZyrni45da+0YMjWA=;
        b=Zr939EdMve2jrgTVvwuYslwD++QCvF+b64T1vIPdhoOuFc9t4z+bXJ89qRBcH0wx4p
         JEeo9n5wjY+Xn1qq4yV5F36CGXKxZg2HcvRZ0N1HkBETlXKukPbq28jDgw9FZ3jh/KZy
         PUlXwalo/J50kTzgia0v/fO/uPrepdPDNyHm1cyKV+hOql0vjYBF2QpVM2nvsT8McfPh
         Me8hcTLc9CgHi099g3+Y9VBjX+6DE9j1v/4xerwki2ehU8EuUo2g8vXi9C1CFyJ9LpYD
         1YcLvBWlz5rtAKLEPTCiHl9lrxAPJhH0rTryfLl7dadfcSrC07F91Yahxt6qGYz2PHvF
         lPHA==
X-Gm-Message-State: AOAM530cOZA93dFW8EatVeTr3b8Zi+tx8+gqCJNI+88bSz+PuBGYwbqj
        YIm4auAlm7z3P/bFy4+934JKLg==
X-Google-Smtp-Source: ABdhPJwPYAhWq2x9goD/zXPaA2zuifl2cNIABizKdgTYleJS43dQnHaWkJv1vxERld71KUWWPY6hVw==
X-Received: by 2002:ac8:7246:0:b0:304:c6a4:cf59 with SMTP id l6-20020ac87246000000b00304c6a4cf59mr13876659qtp.342.1654393053571;
        Sat, 04 Jun 2022 18:37:33 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id v21-20020a05620a441500b006a6a8ef9f79sm3006777qkp.119.2022.06.04.18.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jun 2022 18:37:32 -0700 (PDT)
Date:   Sat, 4 Jun 2022 18:37:20 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Axel Rasmussen <axelrasmussen@google.com>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>, Hugh Dickins <hughd@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: userfaultfd: fix UFFDIO_CONTINUE on fallocated shmem
 pages
In-Reply-To: <20220603205741.12888-1-axelrasmussen@google.com>
Message-ID: <d9a90df-53e3-6ab7-16ef-7882d9f9f93@google.com>
References: <20220603205741.12888-1-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Fri, 3 Jun 2022, Axel Rasmussen wrote:

> When fallocate() is used on a shmem file, the pages we allocate can end
> up with !PageUptodate.
> 
> Since UFFDIO_CONTINUE tries to find the existing page the user wants to
> map with SGP_READ, we would fail to find such a page, since
> shmem_getpage_gfp returns with a "NULL" pagep for SGP_READ if it
> discovers !PageUptodate. As a result, UFFDIO_CONTINUE returns -EFAULT,
> as it would do if the page wasn't found in the page cache at all.
> 
> This isn't the intended behavior. UFFDIO_CONTINUE is just trying to find
> if a page exists, and doesn't care whether it still needs to be cleared
> or not. So, instead of SGP_READ, pass in SGP_NOALLOC. This is the same,
> except for one critical difference: in the !PageUptodate case,
> SGP_NOALLOC will clear the page and then return it. With this change,
> UFFDIO_CONTINUE works properly (succeeds) on a shmem file which has been
> fallocated, but otherwise not modified.
> 
> Fixes: 153132571f02 ("userfaultfd/shmem: support UFFDIO_CONTINUE for shmem")
> Cc: stable@vger.kernel.org
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>

Acked-by: Hugh Dickins <hughd@google.com>

Yes, that looks like a good improvement, and okay to call it a fix for
stable.  But note that your original choice of SGP_READ was not wrong:
there was no SGP_NOALLOC in v5.14, which arrived in v5.15 (and this
is not the first time that it's turned out to be useful since then).
Since v5.14-stable reached end-of-life some time ago, marking this
patch for stable should not result in any untoward build errors.

> ---
>  mm/userfaultfd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index 4f4892a5f767..c156f7f5b854 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -246,7 +246,7 @@ static int mcontinue_atomic_pte(struct mm_struct *dst_mm,
>  	struct page *page;
>  	int ret;
>  
> -	ret = shmem_getpage(inode, pgoff, &page, SGP_READ);
> +	ret = shmem_getpage(inode, pgoff, &page, SGP_NOALLOC);
>  	if (ret)
>  		goto out;
>  	if (!page) {
> -- 
> 2.36.1.255.ge46751e96f-goog
