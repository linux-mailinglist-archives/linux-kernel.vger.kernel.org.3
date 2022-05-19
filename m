Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E108F52CC6F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 09:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbiESHEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 03:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234531AbiESHEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 03:04:42 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F7A275
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 00:04:42 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id a3so7482883ybg.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 00:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fc8tx8B8HfNQ1l1jjhdoD4plxA/Mrx/XvW+L13brVus=;
        b=OVbIXEp4LDWZhS9JtVf8+9LrzsRrquTuAaIVHI0Tvf+qd/KzNiny8CfMZWKXzM8bB3
         GwJazaHbbQfGY8ROu6MUDqKuJqX0Gt4nuU+KBv4CL3tMBWXOJfCp+spStEC1lseAfySS
         UsPqslO0oS3U84Ihvm7lln6MQ5jRHZ9pCgneA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fc8tx8B8HfNQ1l1jjhdoD4plxA/Mrx/XvW+L13brVus=;
        b=6OB6wfAhKR/MOfVR2vVVZSaW+BZU7ZYXBUO5vGidu17fPwaofy6/eEzPv3cY3h5Guu
         yf7jETap7qujNAUSsPCCPAWX8bsC900RJjLBH1Q6gEc+DlVJ3fHpJF5ZBfOEIGo0EpWo
         Q4gmF6jWsy2HQ8TJGZh9Qmtxm3cYaBf/jAscubECuLMKGUr+aef237WhOVa/4gcFUry4
         RzS3bh46o2FbmxFBQpaeZiZwmHwZbmyORX4LhzBdOy4Oxb+Of1OW6DR0rXlp5rtk/HWb
         ypsAjoTEBqOZbNjjZYDd8MFGfmfMFFEBIpJgw+iXOv/UVdCb7+WiHJy0XXAaTWNOPUxu
         //Yg==
X-Gm-Message-State: AOAM5315rNWDwh/UbiyGnnoFO58OV2cyc1w7q+6xKKFL8o1thkvqDFAv
        Eq5GgTwN8Yqvly9GcDZ7AgXGCcgVN28WlOqXsfTmJQ==
X-Google-Smtp-Source: ABdhPJycFlYgfb+SIPDy91Jfmqy2IL+CDEpjazRmRFKNpPzXxbfyx4jSPtk+Mv8H8mt0U8126z1V2fGBr85yxPRj5ak=
X-Received: by 2002:a25:b197:0:b0:64e:ae59:e2d0 with SMTP id
 h23-20020a25b197000000b0064eae59e2d0mr2993856ybj.523.1652943881364; Thu, 19
 May 2022 00:04:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220429064051.61552-1-linmiaohe@huawei.com> <20220429064051.61552-3-linmiaohe@huawei.com>
In-Reply-To: <20220429064051.61552-3-linmiaohe@huawei.com>
From:   Vitaly Wool <vitaly.wool@konsulko.com>
Date:   Thu, 19 May 2022 09:04:30 +0200
Message-ID: <CAM4kBBLrKwDTsoD2nZMqge=qczf-iB7xtSTj8gydj+9KEYwu7g@mail.gmail.com>
Subject: Re: [PATCH 2/9] mm/z3fold: fix possible null pointer dereferencing
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
> alloc_slots could fail to allocate memory under heavy memory pressure. So
> we should check zhdr->slots against NULL to avoid future null pointer
> dereferencing.
>
> Fixes: fc5488651c7d ("z3fold: simplify freeing slots")
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/z3fold.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/mm/z3fold.c b/mm/z3fold.c
> index c2260f5a5885..5d8c21f2bc59 100644
> --- a/mm/z3fold.c
> +++ b/mm/z3fold.c
> @@ -940,9 +940,19 @@ static inline struct z3fold_header *__z3fold_alloc(struct z3fold_pool *pool,
>                 }
>         }
>
> -       if (zhdr && !zhdr->slots)
> +       if (zhdr && !zhdr->slots) {
>                 zhdr->slots = alloc_slots(pool, GFP_ATOMIC);
> +               if (!zhdr->slots)
> +                       goto out_fail;
> +       }
>         return zhdr;
> +
> +out_fail:
> +       if (!kref_put(&zhdr->refcount, release_z3fold_page_locked)) {
> +               add_to_unbuddied(pool, zhdr);
> +               z3fold_page_unlock(zhdr);
> +       }
> +       return NULL;
>  }

Reviewed-by: Vitaly Wool <vitaly.wool@konsulko.com>
>  /*
> --
> 2.23.0
>
