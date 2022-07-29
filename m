Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0407A5849A0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 04:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232261AbiG2CLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 22:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232133AbiG2CLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 22:11:16 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B706779EE7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 19:11:15 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id o4so3251117vsc.12
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 19:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2WcddWcFdt7fAP9+AWjH8FT0p8wf4uBGYcr1CKODSic=;
        b=T87Qq00pcI1Wcz7YeyyoSQI07uEY91bTIhm50/q8dPnHemS2oTTLFpbS85qVQgfzKe
         oicMFDhqSGTIbnAnayOGQyNCNhkGqjAv6PFH12UEl4ZuRohXz3PvapyBpZFhCgY4QvW7
         bqSTNKEe6n/k7+jOvRnH6+szE6ERYA/DHdLiw2n3W0V3SM30a6R9wEGF65wOujiPFrEe
         f4gNbnnMreOzzlMTj5ir4EKYG0bUssrXLQxfjgGRuDh9iV4zsJ2Gy14ftM/cvG9JT0vB
         IlBJnLf3XXtwt8peVFTqoBY3zji4PHoNc0V7GLImLhHPH1n8VSvW6Sf2vTyLisGD+o2f
         U+zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2WcddWcFdt7fAP9+AWjH8FT0p8wf4uBGYcr1CKODSic=;
        b=xo7Vt9pr9gAB+8koFHSJ9GDE7Rzz6STSeRfNo38UxRUj0IslNXAbgxsiXZZ8mNN4Zp
         9p7BiFHLvGmposwDmhIL/o6eSSLtJ5XlmqdA5h7qllH1S2xyZyD9jLrMOSvRrC1lEfqP
         UPlaIbWTGpJkpF6YUSqujxXvXzBVWwXJ0eGZ2MePwCAui9FpFVGq4YTAAllrgcvpakcC
         tw4iw13UDkokHV5zuV3L/B9mdLYQvl5mO9uPQgI9f9sqHDIsoGdUF999IBW57s9+YI60
         4ZtFMSnbfsaQEH0Vr4hNMY02Dy8e8nvJtDLwbwmZJU0eVcm/pFO+IT146OxyGIX6ZAC4
         6pGw==
X-Gm-Message-State: AJIora8jMwFQOgXiqOU7629m/kPZwCByWTY7SLAjT2FuIp6H6OHKRl3/
        cBp6e/5JvKfm8JKFbSULkWdLcKrfKqBTURkXfgb5Rw==
X-Google-Smtp-Source: AGRyM1ubhYZ7kSrnERbL6wT+pDfjGCL3qN7xOpT8+q6L3xJutPXRsQP+/EEE+PL99SJ4h4DhxzWVgAqLh4lWywl0CFY=
X-Received: by 2002:a05:6102:a30:b0:358:58ed:3d2 with SMTP id
 16-20020a0561020a3000b0035858ed03d2mr549619vsb.32.1659060674829; Thu, 28 Jul
 2022 19:11:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220728091341.20820-1-tujinjiang@bytedance.com> <YuJ2UeYVpSe+21Xs@dhcp22.suse.cz>
In-Reply-To: <YuJ2UeYVpSe+21Xs@dhcp22.suse.cz>
From:   Jinjiang Tu <tujinjiang@bytedance.com>
Date:   Fri, 29 Jul 2022 10:11:04 +0800
Message-ID: <CAF77dw_j+4ziV+wuXw0WWSTHqs0Usy-TDzC91skPxcPfKT66-Q@mail.gmail.com>
Subject: Re: Re: [PATCH v2] vmscan: Do not free nr_deferred for memcg aware shrinkers
To:     Michal Hocko <mhocko@suse.com>
Cc:     Yang Shi <shy828301@gmail.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2022 at 7:43 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Thu 28-07-22 17:13:41, tujinjiang@bytedance.com wrote:
> > From: Jinjiang Tu <tujinjiang@bytedance.com>
> >
> > When a memcg aware shrinker is registered by register_shrinker(),
> > shrinker->nr_deferred will not be initialized. But when the shrinker
> > is unregistered by unregister_shrinker(), shrinker->nr_deferred
> > will be freed.
> >
> > Luckily, the memcg aware shrinkers in the current kernel are pre-zeroed.
> > But a new memcg aware shrinker may be added in the future, and we should
> > not assume the shrinker is pre-zeroed.
> >
> > Another unregister API free_prealloced_shrinker() does not assume the
> > shrinker is pre-zered and free shrinker->nr_deferred only if it is
> > not memcg aware. So unregister_shrinker() should do like
> > free_prealloced_shrinker().
> >
> > Signed-off-by: Jinjiang Tu <tujinjiang@bytedance.com>
> > ---
> >  mm/vmscan.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index f7d9a683e3a7..f8a9a5349b6e 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -675,8 +675,11 @@ void unregister_shrinker(struct shrinker *shrinker)
> >       down_write(&shrinker_rwsem);
> >       list_del(&shrinker->list);
> >       shrinker->flags &= ~SHRINKER_REGISTERED;
> > -     if (shrinker->flags & SHRINKER_MEMCG_AWARE)
> > +     if (shrinker->flags & SHRINKER_MEMCG_AWARE) {
> >               unregister_memcg_shrinker(shrinker);
> > +             up_write(&shrinker_rwsem);
> > +             return;
> > +     }
> >       up_write(&shrinker_rwsem);
> >
> >       kfree(shrinker->nr_deferred);
>
> Can we get rid of the code duplication?
> ---
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index f7d9a683e3a7..308279414fe8 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -632,12 +632,10 @@ int prealloc_shrinker(struct shrinker *shrinker)
>         return 0;
>  }
>
> -void free_prealloced_shrinker(struct shrinker *shrinker)
> +static void __free_shrinker(struct shrinker *shrinker)
>  {
>         if (shrinker->flags & SHRINKER_MEMCG_AWARE) {
> -               down_write(&shrinker_rwsem);
>                 unregister_memcg_shrinker(shrinker);
> -               up_write(&shrinker_rwsem);
>                 return;
>         }
>
> @@ -645,6 +643,13 @@ void free_prealloced_shrinker(struct shrinker *shrinker)
>         shrinker->nr_deferred = NULL;
>  }
>
> +void free_prealloced_shrinker(struct shrinker *shrinker)
> +{
> +       down_write(&shrinker_rwsem);
> +       __free_shrinker(shrinker);
> +       up_write(&shrinker_rwsem);
> +}
> +
>  void register_shrinker_prepared(struct shrinker *shrinker)
>  {
>         down_write(&shrinker_rwsem);
> @@ -675,12 +680,9 @@ void unregister_shrinker(struct shrinker *shrinker)
>         down_write(&shrinker_rwsem);
>         list_del(&shrinker->list);
>         shrinker->flags &= ~SHRINKER_REGISTERED;
> -       if (shrinker->flags & SHRINKER_MEMCG_AWARE)
> -               unregister_memcg_shrinker(shrinker);
> -       up_write(&shrinker_rwsem);
>
> -       kfree(shrinker->nr_deferred);
> -       shrinker->nr_deferred = NULL;
> +       __free_shrinker(shrinker);
> +       up_write(&shrinker_rwsem);
>  }
>  EXPORT_SYMBOL(unregister_shrinker);
>
> --
> Michal Hocko
> SUSE Labs
Yes, the code is clearer.
