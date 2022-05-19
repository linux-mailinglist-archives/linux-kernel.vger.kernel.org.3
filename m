Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFCAD52CD0B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 09:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234102AbiESH3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 03:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234931AbiESH2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 03:28:51 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09330BA568
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 00:28:29 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-2ff39b44b06so47662937b3.13
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 00:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vjrnyjH3grgZKamLmHEN1KL7rfPLrD16boC4fdyQroo=;
        b=SPYyprvCRKlbgbZYDL2uYcVaMS9qw4163EA7uGOJJlp1o0m71n1NiEVJUGII3dD5fw
         eEVJwzMvYKJ7jdAVxq8v2MOuubpg7t8BNvH5mfO3PnEVr9mtJ/Q6md8ddPlorm5ei/IZ
         NTxOVQ5cwG5CwMqWq5MMuSAWKqkIEYW3Xl/OQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vjrnyjH3grgZKamLmHEN1KL7rfPLrD16boC4fdyQroo=;
        b=eh4rxxmxH7aW0jjCDoSkas8FpXpUYInZb6Ibnc/ARpCWYIUVH9MMXmjsXXLbsgm/Rp
         ctPgv0bplXT9Y3thWndQ4Ns6y54+B0yBZJh/NmZS0mySEEgrCVU5aft3TXoMgCohD3EZ
         gapuy85dOLxWca/IgoGrY81eK8XpqQZs2dxkWsKLABBpFyQneCM/BWJnhDpEJk3OxCj/
         vo/qTYI6/79P37bY27V/YnbPHIxJpoiFKkKN6TWZXHRVVv3v8i10sWWk1bn80NhwsBkg
         V/3tew3m0eeRGuViMacK3hhbKxkPl3J6jcuM9Xu/1GZatGKnoc+Bg0YBaVk2bDZkqRHQ
         CgSg==
X-Gm-Message-State: AOAM532MBO0pvn8T5pQMYiyEbyMVc0vXu0Qa2UnJcbXygwakHuP8znFq
        xBzZSQ4BTjnCkFQPbLOh0HhK4DKbLrRbn99F13JrCw==
X-Google-Smtp-Source: ABdhPJxs6fgYri+Sc08URKOJAqF6QQWmBnRI7Z26Nami2epmmEqaJ3tPicOT2ZtL5pgm4VePzBYnFZ46qdBkqXMCIEI=
X-Received: by 2002:a81:260a:0:b0:2f4:ca82:a42f with SMTP id
 m10-20020a81260a000000b002f4ca82a42fmr3300277ywm.149.1652945309090; Thu, 19
 May 2022 00:28:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220429064051.61552-1-linmiaohe@huawei.com> <20220429064051.61552-10-linmiaohe@huawei.com>
In-Reply-To: <20220429064051.61552-10-linmiaohe@huawei.com>
From:   Vitaly Wool <vitaly.wool@konsulko.com>
Date:   Thu, 19 May 2022 09:28:18 +0200
Message-ID: <CAM4kBBJmvbmQ6fZZqPytT7=RG1aquh+hodyWbdtfKRs8kD-woA@mail.gmail.com>
Subject: Re: [PATCH 9/9] mm/z3fold: fix z3fold_page_migrate races with z3fold_map
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
> Think about the below scene:
> CPU1                            CPU2
>  z3fold_page_migrate            z3fold_map
>   z3fold_page_trylock
>   ...
>   z3fold_page_unlock
>   /* slots still points to old zhdr*/
>                                  get_z3fold_header
>                                   get slots from handle
>                                   get old zhdr from slots
>                                   z3fold_page_trylock
>                                   return *old* zhdr
>   encode_handle(new_zhdr, FIRST|LAST|MIDDLE)
>   put_page(page) /* zhdr is freed! */
>                                  but zhdr is still used by caller!
>
> z3fold_map can map freed z3fold page and lead to use-after-free bug.
> To fix it, we add PAGE_MIGRATED to indicate z3fold page is migrated
> and soon to be released. So get_z3fold_header won't return such page.
>
> Fixes: 1f862989b04a ("mm/z3fold.c: support page migration")
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/z3fold.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/mm/z3fold.c b/mm/z3fold.c
> index a7769befd74e..f41f8b0d9e9a 100644
> --- a/mm/z3fold.c
> +++ b/mm/z3fold.c
> @@ -181,6 +181,7 @@ enum z3fold_page_flags {
>         NEEDS_COMPACTING,
>         PAGE_STALE,
>         PAGE_CLAIMED, /* by either reclaim or free */
> +       PAGE_MIGRATED, /* page is migrated and soon to be released */
>  };
>
>  /*
> @@ -270,8 +271,13 @@ static inline struct z3fold_header *get_z3fold_header(unsigned long handle)
>                         zhdr = (struct z3fold_header *)(addr & PAGE_MASK);
>                         locked = z3fold_page_trylock(zhdr);
>                         read_unlock(&slots->lock);
> -                       if (locked)
> -                               break;
> +                       if (locked) {
> +                               struct page *page = virt_to_page(zhdr);
> +
> +                               if (!test_bit(PAGE_MIGRATED, &page->private))
> +                                       break;
> +                               z3fold_page_unlock(zhdr);
> +                       }
>                         cpu_relax();
>                 } while (true);
>         } else {
> @@ -389,6 +395,7 @@ static struct z3fold_header *init_z3fold_page(struct page *page, bool headless,
>         clear_bit(NEEDS_COMPACTING, &page->private);
>         clear_bit(PAGE_STALE, &page->private);
>         clear_bit(PAGE_CLAIMED, &page->private);
> +       clear_bit(PAGE_MIGRATED, &page->private);
>         if (headless)
>                 return zhdr;
>
> @@ -1576,7 +1583,7 @@ static int z3fold_page_migrate(struct address_space *mapping, struct page *newpa
>         new_zhdr = page_address(newpage);
>         memcpy(new_zhdr, zhdr, PAGE_SIZE);
>         newpage->private = page->private;
> -       page->private = 0;
> +       set_bit(PAGE_MIGRATED, &page->private);
>         z3fold_page_unlock(zhdr);
>         spin_lock_init(&new_zhdr->page_lock);
>         INIT_WORK(&new_zhdr->work, compact_page_work);
> @@ -1606,7 +1613,8 @@ static int z3fold_page_migrate(struct address_space *mapping, struct page *newpa
>
>         queue_work_on(new_zhdr->cpu, pool->compact_wq, &new_zhdr->work);
>
> -       clear_bit(PAGE_CLAIMED, &page->private);
> +       /* PAGE_CLAIMED and PAGE_MIGRATED are cleared now. */
> +       page->private = 0;
>         put_page(page);
>         return 0;
>  }

Reviewed-by: Vitaly Wool <vitaly.wool@konsulko.com>
> --
> 2.23.0
>
