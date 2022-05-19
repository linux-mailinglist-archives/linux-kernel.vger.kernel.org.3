Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32FF052CCA4
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 09:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbiESHNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 03:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiESHNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 03:13:25 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE666323
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 00:13:24 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id o80so7546082ybg.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 00:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KnZR57TsP1OGT1oafFJVuDdDBH3vRCYaCcimYp/NokI=;
        b=mMNJALnl1pAUfzyvxoarnlKnjyecYA8pRlQJKd8VfWfDYV2KKMrosdN8WdbA7nCUhi
         nzNA1Z8hP4TVxSkZ1nqjVD8GwTsjSAiFeMJ7EeYjNMjXl37Nv3MC4wHvfcTjA4jxnM3G
         /uLeqYImYR77yCasmTw6rt2erIwmeiT+t8aDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KnZR57TsP1OGT1oafFJVuDdDBH3vRCYaCcimYp/NokI=;
        b=EIc6R28NBDltWVwuHqWew674n2nDyVDprfMo34tEIPM7JsgnoDAb2BTSxgYyWzU5gQ
         W1bdFoSpzDYgQr82lludYA8nczax5w1JSTDM8b+B6jDd5aVZvv2X1n6xM+ub6CVOqAGa
         vBF5z3e9TGxAyyLxzCCQcZav71kbI/dfPab8yo8sR16/7TGvcyPpojYnNH9eMSebX0ok
         YqEOH9UiekELlT3p46hc+AjcGxLeI9hSkcc2SOhnYGFfIFlDV74RBvFp9238aq2YiTYm
         2WagOyXSWWXCiJMeyKCr25Ip0ppvRLSqS4SM44eQrQR2+ZN9549T09LJJlYk6JcIzi6w
         WDxQ==
X-Gm-Message-State: AOAM533E63Lm4C22bVqVQ2B1rN4hWKg7medOnsGegPrwsl189vmHMBS1
        +XDcAAx6OlsVQkaXvcR2R7FgPnj9yBYfkuElHyGZkQ==
X-Google-Smtp-Source: ABdhPJybWvmH109bDClPmZi30A+KVrxSLEU3X6ZNIoKlBYkRES5SsYP4QENhyiggw10pRTpKvJ6Pr+mtH/MHa58UysM=
X-Received: by 2002:a25:b197:0:b0:64e:ae59:e2d0 with SMTP id
 h23-20020a25b197000000b0064eae59e2d0mr3019071ybj.523.1652944403511; Thu, 19
 May 2022 00:13:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220429064051.61552-1-linmiaohe@huawei.com> <20220429064051.61552-7-linmiaohe@huawei.com>
In-Reply-To: <20220429064051.61552-7-linmiaohe@huawei.com>
From:   Vitaly Wool <vitaly.wool@konsulko.com>
Date:   Thu, 19 May 2022 09:13:12 +0200
Message-ID: <CAM4kBBLsbKrLgx1VtEikMGW7rCq5XF5pGVJF2hm_6NUPU6OBAQ@mail.gmail.com>
Subject: Re: [PATCH 6/9] mm/z3fold: put z3fold page back into unbuddied list
 when reclaim or migration fails
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

On Fri, Apr 29, 2022 at 8:40 AM Miaohe Lin <linmiaohe@huawei.com> wrote:
>
> When doing z3fold page reclaim or migration, the page is removed from
> unbuddied list. If reclaim or migration succeeds, it's fine as page is
> released. But in case it fails, the page is not put back into unbuddied
> list now. The page will be leaked until next compaction work, reclaim
> or migration is done.
>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/z3fold.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/mm/z3fold.c b/mm/z3fold.c
> index 5f5d5f1556be..a1c150fc8def 100644
> --- a/mm/z3fold.c
> +++ b/mm/z3fold.c
> @@ -1422,6 +1422,8 @@ static int z3fold_reclaim_page(struct z3fold_pool *pool, unsigned int retries)
>                         spin_lock(&pool->lock);
>                         list_add(&page->lru, &pool->lru);
>                         spin_unlock(&pool->lock);
> +                       if (list_empty(&zhdr->buddy))
> +                               add_to_unbuddied(pool, zhdr);
>                         z3fold_page_unlock(zhdr);
>                         clear_bit(PAGE_CLAIMED, &page->private);
>                 }
> @@ -1638,6 +1640,8 @@ static void z3fold_page_putback(struct page *page)
>         spin_lock(&pool->lock);
>         list_add(&page->lru, &pool->lru);
>         spin_unlock(&pool->lock);
> +       if (list_empty(&zhdr->buddy))
> +               add_to_unbuddied(pool, zhdr);
>         clear_bit(PAGE_CLAIMED, &page->private);
>         z3fold_page_unlock(zhdr);
>  }

Reviewed-by: Vitaly Wool <vitaly.wool@konsulko.com>
> --
> 2.23.0
>
