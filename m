Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEF0A52CCA1
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 09:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbiESHL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 03:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234770AbiESHLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 03:11:11 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D2DEBC6C6
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 00:10:15 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id i11so7477818ybq.9
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 00:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9PYUOJAahsitVbIpvNcD/gQehbdmdTLlZnbyHBi5Wk8=;
        b=DixNg2iwHsCb87oTKd00gG4y4PtOei2M0rvk2ZvAAiKWoUUH64dI1lLowWxpzxyFVS
         qpS8Mdw81N+tnEXF0tPRGmVnxvnA0BQvav60mCgPyiIs2YQV83LuCNQVWZpnqzCzzPse
         QowLhwdTloLQR877oY2q9xQiq4DyhiMG6tSWY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9PYUOJAahsitVbIpvNcD/gQehbdmdTLlZnbyHBi5Wk8=;
        b=PgD43q/f/nLdXSVMQc7MMtIM19DYeTxeaEUP/EI06VdHCQKpp+YbB6jcMIEMZpZg0O
         mH/dbXfjImy7CxCNHMucOXcvSMWeHF07XuIDrDexub9/SECDAv7uzl3bcOnFLG5AecX1
         kPfkBRr9yPD1oVlOhaWW8rZuHPgzBlEzF1K+97auBH+F4zjq69tZn4dq4WCCtR3LMM6I
         80KN2XpJ0kUa7vgrYt9oLwaW63bs1qKjw+ItVCNeyIF4unuuk8D5Lkyv8HC6MHAaXtRO
         onw5psEGOD2wkdu/KbS6a0tfF53gkkvOJXhF57d30hA6hopSdPkz3BsScDpXZbxHPgR9
         lPtg==
X-Gm-Message-State: AOAM530+IEEN7zJ2eSgh/ZsEOjN/JElah7GxmK6wDDUkIEUURm+POdnk
        SFiAKlxgUzB22p9yUVdIYPQ4C0KBzEVhkDmVm0TcJA==
X-Google-Smtp-Source: ABdhPJwWutBdsJKd70SSTJQfb7qJen0UtR3se0WON605rlfXnbYysBkzw7c/nIy6U/FdwQFpm1DzXGo8E6dGdShBVbM=
X-Received: by 2002:a05:6902:1407:b0:64a:ecc7:aa2 with SMTP id
 z7-20020a056902140700b0064aecc70aa2mr3051875ybu.645.1652944214392; Thu, 19
 May 2022 00:10:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220429064051.61552-1-linmiaohe@huawei.com> <20220429064051.61552-5-linmiaohe@huawei.com>
In-Reply-To: <20220429064051.61552-5-linmiaohe@huawei.com>
From:   Vitaly Wool <vitaly.wool@konsulko.com>
Date:   Thu, 19 May 2022 09:10:03 +0200
Message-ID: <CAM4kBB+SKzaFDCodVBZ4UbiFNrqJxAjEjaZCr=7FyW-rd4f39w@mail.gmail.com>
Subject: Re: [PATCH 4/9] mm/z3fold: throw warning on failure of trylock_page
 in z3fold_alloc
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
> If trylock_page fails, the page won't be non-lru movable page. When this
> page is freed via free_z3fold_page, it will trigger bug on PageMovable
> check in __ClearPageMovable. Throw warning on failure of trylock_page to
> guard against such rare case just as what zsmalloc does.

I don't see how this is better than what we currently have. We can
check if a page is movable before calling __ClearPageMovable instead.

~Vitaly

> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/z3fold.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/mm/z3fold.c b/mm/z3fold.c
> index 4e6814c5694f..b3b4e65c107f 100644
> --- a/mm/z3fold.c
> +++ b/mm/z3fold.c
> @@ -1122,10 +1122,9 @@ static int z3fold_alloc(struct z3fold_pool *pool, size_t size, gfp_t gfp,
>                 __SetPageMovable(page, pool->inode->i_mapping);
>                 unlock_page(page);
>         } else {
> -               if (trylock_page(page)) {
> -                       __SetPageMovable(page, pool->inode->i_mapping);
> -                       unlock_page(page);
> -               }
> +               WARN_ON(!trylock_page(page));
> +               __SetPageMovable(page, pool->inode->i_mapping);
> +               unlock_page(page);
>         }
>         z3fold_page_lock(zhdr);
>
> --
> 2.23.0
>
