Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16FD64C9F72
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 09:38:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240144AbiCBIjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 03:39:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240155AbiCBIjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 03:39:13 -0500
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF215883D
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 00:38:30 -0800 (PST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-2d62593ad9bso8640287b3.8
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 00:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GlU4TXYlkTTCcgX0TmwwrU9v30UNuB5Nx7hIbvCH79w=;
        b=Jc66LOst6QR8VL/b95HK7zFdKQGbi3a9Rsgb8DN8HPLYEFm9yQjI6AxDCxDFaSoj6o
         LHn6vQcwPaw4J6Eja+hMkL4mQaXtZd6l0rKqk3RoLthCBCfFisxtE08wxG4ELRnbIcto
         Jl6ys1bWQcjvQT75z5urAoFx6XeqJnts1rJBw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GlU4TXYlkTTCcgX0TmwwrU9v30UNuB5Nx7hIbvCH79w=;
        b=FtX9KgzKrFnxnaBzg8XJgPtRcB8oA+1Zaej7miE8ZujT7YDge9RpKl1p6l5JJD4OJy
         lH6pKRr3lisdvUr4bKZ397tUzkmI0Cb+L6McjCTZ03q5MFOBEY6YLzeh9TF1he7xh9V1
         jN3MZN7WvUC2CPRpyEMc3H2pPKLdF6UisFp+3My7R3L+CL1LLKSQx/e0isFeoyBUU0ij
         +KYet2jNtBkzL4TRKru6wvpdIDSgz2ID4apxOgqLsNPw3/koqRA4VyXb4WfWz7vmNFFS
         yGcsnbOjbIYHOP8TFX8Rf+GO+odJ/MB+dtJt5pwaCvvHxWinvwXTYWHC/SaeX2d9yxYd
         +Rvg==
X-Gm-Message-State: AOAM530jKLAy9Z00UwttdUwyOFqvKzM3FHljBp/bb4PLA697H+xVSqpH
        NIhfXd1HHyANJLGpaGuFkr31suWphqKmd4hEAXXv4g==
X-Google-Smtp-Source: ABdhPJzYP+esyqhcv/ZQDdGRUAX4qeihGVbzL6ECMljI6IwMc5NLcqqq/4HKvuvzf4G1nwtaSJF6gXScMe7WPzTdZEA=
X-Received: by 2002:a81:1143:0:b0:2db:ccb4:b0a1 with SMTP id
 64-20020a811143000000b002dbccb4b0a1mr9445925ywr.499.1646210309769; Wed, 02
 Mar 2022 00:38:29 -0800 (PST)
MIME-Version: 1.0
References: <20220219092533.12596-1-linmiaohe@huawei.com> <20220219092533.12596-8-linmiaohe@huawei.com>
In-Reply-To: <20220219092533.12596-8-linmiaohe@huawei.com>
From:   Vitaly Wool <vitaly.wool@konsulko.com>
Date:   Wed, 2 Mar 2022 09:38:18 +0100
Message-ID: <CAM4kBBJ79OQDbetD20rLNRESE0ncYix5RMeuHvPSLHxyxxB3Dg@mail.gmail.com>
Subject: Re: [PATCH 7/9] mm/z3fold: remove redundant list_del_init of
 zhdr->buddy in z3fold_free
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 19, 2022 at 10:26 AM Miaohe Lin <linmiaohe@huawei.com> wrote:
>
> The do_compact_page will do list_del_init(&zhdr->buddy) for us. Remove this
> extra one to save some possible cpu cycles.
>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: Vitaly Wool <vitaly.wool@konsulko.com>

> ---
>  mm/z3fold.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/mm/z3fold.c b/mm/z3fold.c
> index 18a697f6fe32..867c590df027 100644
> --- a/mm/z3fold.c
> +++ b/mm/z3fold.c
> @@ -1244,9 +1244,6 @@ static void z3fold_free(struct z3fold_pool *pool, unsigned long handle)
>                 return;
>         }
>         if (zhdr->cpu < 0 || !cpu_online(zhdr->cpu)) {
> -               spin_lock(&pool->lock);
> -               list_del_init(&zhdr->buddy);
> -               spin_unlock(&pool->lock);
>                 zhdr->cpu = -1;
>                 kref_get(&zhdr->refcount);
>                 clear_bit(PAGE_CLAIMED, &page->private);
> --
> 2.23.0
>
