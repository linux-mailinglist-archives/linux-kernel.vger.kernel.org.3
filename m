Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5600E52CC54
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 09:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbiESHAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 03:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiESHAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 03:00:49 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DDE9D136
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 00:00:47 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id o80so7500178ybg.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 00:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NUpiriXioR9HKJDqESG1pLTNmVTqJQ+hACDCjyaXJbk=;
        b=KHhq/M/Lqpe7c6sxtrWJ6eCnVsP9BUpMJ3q6qR+JCwkJinKyUwQ7Iin6Gn01xD/anx
         cBDs7IKCIIip1ZRfnRV/iaDeoEBK70Kn5MC2xFDn7Xv3KUU7sUOlTFxpZy6YdYobr+Jq
         KqEl6yC9hnAyNFOzIC05q1GyZa5ZTCBJ+1Dfo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NUpiriXioR9HKJDqESG1pLTNmVTqJQ+hACDCjyaXJbk=;
        b=oUM+0S/kaqxMZdMn6KKDb9rsEqK7dSQ2qIEydoOD+wWJ8zSx9ikA8H7YvkpRJy44Ze
         f9BhPE0Oplt+pqQzMAujo8BOwM79akK3Gw75CnH5w89MPRupLO6SzfvD3gd71U/eJanR
         rCvPZoECw/WvyOYpM5z29YI/S4erw0cIQu7554gYi8v8AGMVVoFGu/9ngx6SMQwtpuzb
         FlGz76+Jr5h9O37mjLffZtaEBM83LOnW9va9RJrNBTy4AqfMnK0MpGlLvZ8/Bzd60FUQ
         kz32LJ08YmlMWALKDwXp2jl1E6GTdtEACMwfpfm6uCpZu9VkJNPCcNXUqqoSmJgKezey
         fAxg==
X-Gm-Message-State: AOAM531RKMyywDBemgAOMVsQfYhLe6Fe6XGyai71Yf9qQ8bWMa3OEpIk
        1OyxdUK8yQ6K+KwfbjOcwvxNB5dngfkrAQl3G12abvCOFn8=
X-Google-Smtp-Source: ABdhPJxPCG2ZJHqlB3IB82UVO0pEBaziFwIZZcvzkrIW+EwBzbI7In98uO5XmVYKJyu4fDh0MjLJqiJOprto/2X/GgI=
X-Received: by 2002:a25:b197:0:b0:64e:ae59:e2d0 with SMTP id
 h23-20020a25b197000000b0064eae59e2d0mr2977308ybj.523.1652943646360; Thu, 19
 May 2022 00:00:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220429064051.61552-1-linmiaohe@huawei.com> <20220429064051.61552-2-linmiaohe@huawei.com>
In-Reply-To: <20220429064051.61552-2-linmiaohe@huawei.com>
From:   Vitaly Wool <vitaly.wool@konsulko.com>
Date:   Thu, 19 May 2022 09:00:34 +0200
Message-ID: <CAM4kBBJofCkdQ+MuxCNo4B+Og0yFdRdtsPQzNnWAAHMsuKourg@mail.gmail.com>
Subject: Re: [PATCH 1/9] mm/z3fold: fix sheduling while atomic
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
> z3fold's page_lock is always held when calling alloc_slots. So gfp should
> be GFP_ATOMIC to avoid "scheduling while atomic" bug.
>
> Fixes: fc5488651c7d ("z3fold: simplify freeing slots")
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/z3fold.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/mm/z3fold.c b/mm/z3fold.c
> index 83b5a3514427..c2260f5a5885 100644
> --- a/mm/z3fold.c
> +++ b/mm/z3fold.c
> @@ -941,8 +941,7 @@ static inline struct z3fold_header *__z3fold_alloc(struct z3fold_pool *pool,
>         }
>
>         if (zhdr && !zhdr->slots)
> -               zhdr->slots = alloc_slots(pool,
> -                                       can_sleep ? GFP_NOIO : GFP_ATOMIC);
> +               zhdr->slots = alloc_slots(pool, GFP_ATOMIC);
>         return zhdr;
>  }

Reviewed-by: Vitaly Wool <vitaly.wool@konsulko.com>
> --
> 2.23.0
>
