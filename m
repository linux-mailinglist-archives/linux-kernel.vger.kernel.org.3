Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7769534255
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 19:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242741AbiEYRnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 13:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbiEYRn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 13:43:29 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A479D06A
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 10:43:28 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id 2so2616389ilg.13
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 10:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9Y1ppk7B46JVKK7NkaOrpQ5493dk2qksQrupKiexSz0=;
        b=Lz+Il6ThJJatz8Ur6i5iU0ceuVC5VFUAZpYN1elm5YYuqfTkQEOKa0EySEnREG2MZT
         4pu5E5+TM9kOKMH27rA1UGkf+EfhhucDE/6hKaO41QOJXiTJyRh6OFKozsgeUQjVJW/l
         GAuYsrXl6F+mt+SSgVXvCPj+xipn+/dVXoB+QSyoRcAJ1/FQYyzs9gqR00UNrkz9uWEK
         31vYtGQovUIWTwpMptXgaSxwUHSkehWRIHWrJ4fPTm3gUqm10Ru2R2YyglBLmwh30atk
         f36RboKM/w9WhKkHz9kggxr2qm3IajSI7sRJMeKldeA2f+qgswGR4CHgCEHVnEPuY4zM
         JdyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9Y1ppk7B46JVKK7NkaOrpQ5493dk2qksQrupKiexSz0=;
        b=JCbVnS6T+byXCXNkXAkV7bZn3B7FF+d0NnPtQQeAdFrVxCJCrWRq+IMckXmdw6ihNx
         ZU5fldQPM+QOlsMo5xdSp/YNk7rDXzPJOw0xSfLMVxQSF0+k7szhjj0MWEirdYuz2jbL
         Qp8iTmG0/Ba/5nDkVBP3JoUbHYOw7sRzhBdrjU7vMNvQpk/5I94oAYeA9H+OZ2XJfGNw
         2ACefOorQLSLN78QQfouFTyt+/FvOuOdBt6nhXkdTKSPLUTBhcsRygWFndGo0HdfFiZl
         TVi9RbADgyIrh49qdAzURjBvEKX2UKbjfXf0wqazQmlNBgKHW5pm+iINiWTCr1A2bLHc
         GrtA==
X-Gm-Message-State: AOAM533s0zY5QxYXv55+ToZoVX/s6f/iXxGutrjP2KM1cqH2qf1R+eEK
        QE9fvjhIfbLty97qZegJAqC8oa6FmWFaxig7taA=
X-Google-Smtp-Source: ABdhPJwCZm28XqJGp5fTvbYI6LME8/48+6CYtKjsPdgnXp2pOicpNbew0hzH6nlz5DM54/lnJeEi7kh2+sMcZqIDc1g=
X-Received: by 2002:a05:6e02:1be2:b0:2d1:5818:a454 with SMTP id
 y2-20020a056e021be200b002d15818a454mr18036546ilv.248.1653500608130; Wed, 25
 May 2022 10:43:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220525120804.38155-1-wangkefeng.wang@huawei.com>
In-Reply-To: <20220525120804.38155-1-wangkefeng.wang@huawei.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Wed, 25 May 2022 19:43:17 +0200
Message-ID: <CA+fCnZf_Aphbje1aJCyp0Sarz3DgbfGLXHLisiHjT=ttS6pjWg@mail.gmail.com>
Subject: Re: [PATCH] mm: kasan: Fix input of vmalloc_to_page()
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2022 at 1:58 PM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>
> When print virtual mapping info for vmalloc address, it should pass
> the addr not page, fix it.
>
> Fixes: c056a364e954 ("kasan: print virtual mapping info in reports")
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  mm/kasan/report.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> index 199d77cce21a..b341a191651d 100644
> --- a/mm/kasan/report.c
> +++ b/mm/kasan/report.c
> @@ -347,7 +347,7 @@ static void print_address_description(void *addr, u8 tag)
>                                va->addr, va->addr + va->size, va->caller);
>                         pr_err("\n");
>
> -                       page = vmalloc_to_page(page);
> +                       page = vmalloc_to_page(addr);
>                 }
>         }
>
> --
> 2.35.3
>

Nice catch, thanks!

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
