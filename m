Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5E050946F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 02:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352074AbiDUAr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 20:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231931AbiDUAr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 20:47:27 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED39329813
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 17:44:39 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id s14so3322443plk.8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 17:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ESUxm4cSJyIm60549ToiEcMf0F7V0X1uPD4V4iCHr1g=;
        b=iCLZwnUrJlXXS94NHeOiMqZdbp79cqEIAIkcxS3f1QhYmIU4Rn72icr+yGFMXL7sJq
         wgPHBQcOdAxXOBEeXSWFmZ5+2+zhjQ3yYKyOCdd+LxjNIetmHSlz804tJPwbjm2t3CVd
         i0t77FIu70AC9aRHobJ3ZLFq5TlHMCcTw2lxEXzjLpQ15yj7ycOSvanS6K0fwndiEz0m
         fSlFP1OiPDmc80jD/DnJ4kPukwewQQPrzxhPUvTYAn+nTvjAwv6Sn/2ylRCR90Hn7gD3
         FkxAg8MQH+lKjgDSJjoGIuqOfCZdVn7DMkDD9l2BZCVW6MgZZuzAX2gBwXuMwb1mNkau
         LLow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ESUxm4cSJyIm60549ToiEcMf0F7V0X1uPD4V4iCHr1g=;
        b=fa2nZpHgSDujhfyLvr7fdwwcwEL/AOzzXHr+ly9XuH6xzDKd2Z9M5w1GKEh1Lq7EPs
         MbCFHqZcoFGhbv6Qnf129REFU1elmo0b+Zyb4KTkMLAHs3yWf7WQTd9u5hieKJd1aDIo
         4I8H1ehuiGcFzR0Yuswu6i1sIyxNnFMczLDX7FQC232soXngUT67c++9/LQT1D0UqBSr
         MzQ4JFYcA54GmT05abBepSC8wkDu3OZQHCgEHcdL+c9RZefgtU7CMK9nRMCq+FYbxHdU
         g+VTiasd+P6joLLDKjAIYp9tNTNShjCpLeaZZqmmCFbhgtRlrNjvDecDeIprKQcSobNE
         PWAg==
X-Gm-Message-State: AOAM532zlHLkk0UJpgQKlG4G5NcMUYX/iUYkh5oKaN62v4p90pd/HvSR
        YmuBstlRxWZWD10Z2oV07PI2PacNV84M3J2wr74OF3tV
X-Google-Smtp-Source: ABdhPJziSwrhCSrYNTJmBFaWn3ITBCiVgMnq0qlf+ROQeo46KkFucBE9DDNvi7wGYLxJk3HuGVoiZKZmDBQxznThA90=
X-Received: by 2002:a17:90b:4b10:b0:1d2:c235:6c8e with SMTP id
 lx16-20020a17090b4b1000b001d2c2356c8emr7292583pjb.21.1650501879483; Wed, 20
 Apr 2022 17:44:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220419122234.45083-1-linmiaohe@huawei.com>
In-Reply-To: <20220419122234.45083-1-linmiaohe@huawei.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 20 Apr 2022 17:44:27 -0700
Message-ID: <CAHbLzkp0Ok0ZKZvKXGaAEVGCQ3gU9zXxAV1eudpPaCZqqpcdpQ@mail.gmail.com>
Subject: Re: [PATCH] mm/mempolicy: clean up the code logic in queue_pages_pte_range
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 5:22 AM Miaohe Lin <linmiaohe@huawei.com> wrote:
>
> Since commit e5947d23edd8 ("mm: mempolicy: don't have to split pmd for
> huge zero page"), THP is never splited in queue_pages_pmd. Thus 2 is
> never returned now. We can remove such unnecessary ret != 2 check and
> clean up the relevant comment. Minor improvements in readability.

Nice catch. Yeah, it was missed when I worked on that commit.

Reviewed-by: Yang Shi <shy828301@gmail.com>

>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/mempolicy.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
>
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 75a8b247f631..3934476fb708 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -441,12 +441,11 @@ static inline bool queue_pages_required(struct page *page,
>  }
>
>  /*
> - * queue_pages_pmd() has four possible return values:
> + * queue_pages_pmd() has three possible return values:
>   * 0 - pages are placed on the right node or queued successfully, or
>   *     special page is met, i.e. huge zero page.
>   * 1 - there is unmovable page, and MPOL_MF_MOVE* & MPOL_MF_STRICT were
>   *     specified.
> - * 2 - THP was split.
>   * -EIO - is migration entry or only MPOL_MF_STRICT was specified and an
>   *        existing page was already on a node that does not follow the
>   *        policy.
> @@ -508,18 +507,13 @@ static int queue_pages_pte_range(pmd_t *pmd, unsigned long addr,
>         struct page *page;
>         struct queue_pages *qp = walk->private;
>         unsigned long flags = qp->flags;
> -       int ret;
>         bool has_unmovable = false;
>         pte_t *pte, *mapped_pte;
>         spinlock_t *ptl;
>
>         ptl = pmd_trans_huge_lock(pmd, vma);
> -       if (ptl) {
> -               ret = queue_pages_pmd(pmd, ptl, addr, end, walk);
> -               if (ret != 2)
> -                       return ret;
> -       }
> -       /* THP was split, fall through to pte walk */
> +       if (ptl)
> +               return queue_pages_pmd(pmd, ptl, addr, end, walk);
>
>         if (pmd_trans_unstable(pmd))
>                 return 0;
> --
> 2.23.0
>
>
