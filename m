Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7E9B4F95A6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 14:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235640AbiDHM2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 08:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232419AbiDHM2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 08:28:21 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C632610CF2A
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 05:26:18 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id p135so4460083iod.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 05:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=14DprhKsqJXStRxJvQBVCHfnfpx5IJV0lotlrHWmtH8=;
        b=esQabPT8PgOCXCKowwR7iPuL6EBprRhLQCJjiCPpqKT+zo2s7AX5jsuWkcll++agNI
         qfC0Ucv4sMoOuy6eyYoReKeUYoC9QGxNYsXavCGAuAXC/hroV6BeaIyRhjX/n7HYhIdw
         XC0dYlDw+wOvgy/iXFPETMJ3T0oEmnrsTNCD3An6UIfMWZ0oiOW6YCLt8u4+aSbkdntI
         wq/wGdvao4gProp39oOBDaT/EIqF3VTEnDP3nl/2nfoh/TXFXu2tAssMMra8SUy8j5/j
         Pso54AqWlK8SW1LJxhGEMHqkvEAVIIlWkBbKHswvwFUE33WyPhGWj3vP7Eh3BEAIqyfK
         RqWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=14DprhKsqJXStRxJvQBVCHfnfpx5IJV0lotlrHWmtH8=;
        b=Y9MQJczj9LQHCvZwT3aoirTV8LER1u9i7iB8+bMCy/sxH8ic5/vOar1WJyJbfdZBqe
         ltoV4kr7iyKd6pGpxzia7VbfVisWzsjMMwE0Kp4EEQubxcru7FIVSxgofD7pKegOneLt
         cxOPZAjcCwFX5ogIeyFIUJ0yhvBRK7z4+gUckbTvYUY9sqBJONCge6oTodnvyP1K5zQf
         pW3+40EpcaI3/Z1eWUKRowY4DZWnD8dhkZLYSD4ygcvQnYM+hn6y3Mjvm7f9cyCtRiYm
         nq8X0Y+DActMJBkop9jDzgSGdlPDNI9lH898EZAg4MXeugYWYyoDXgpcI4flCL2kidwV
         uIew==
X-Gm-Message-State: AOAM5323JPZr8U3MyJxJ9R30irA8ne81jXlBeicd4ePCt7UoJuVEPVJl
        T8aPnu23RzCYFDaBtf5tWIErWglsa+CA1uRtbUM=
X-Google-Smtp-Source: ABdhPJwYxj9qTajeRNS0LUW6oTSTCIMHlweqyq8T5dvsb9mYLzdzzWROD6lYFfz4r3yy3eTAJ5SM+MzM3jeZJ3hAo9Q=
X-Received: by 2002:a05:6602:490:b0:638:c8ed:1e38 with SMTP id
 y16-20020a056602049000b00638c8ed1e38mr8279012iov.202.1649420778200; Fri, 08
 Apr 2022 05:26:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220408100340.43620-1-vincenzo.frascino@arm.com>
In-Reply-To: <20220408100340.43620-1-vincenzo.frascino@arm.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Fri, 8 Apr 2022 14:26:07 +0200
Message-ID: <CA+fCnZcoFWXyhjfKSxPh2djiTWjYCh2xmirPehyJS94DaoJC9w@mail.gmail.com>
Subject: Re: [PATCH] kasan: Fix hw tags enablement when KUNIT tests are disabled
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
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

On Fri, Apr 8, 2022 at 12:04 PM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
>
> Kasan enables hw tags via kasan_enable_tagging() which based on the mode
> passed via kernel command line selects the correct hw backend.
> kasan_enable_tagging() is meant to be invoked indirectly via the cpu features
> framework of the architectures that support these backends.
> Currently the invocation of this function is guarded by CONFIG_KASAN_KUNIT_TEST
> which allows the enablement of the correct backend only when KUNIT tests are
> enabled in the kernel.

> ... and prevents to enable MTE on arm64 when KUNIT tests for kasan hw_tags are
> disabled.

Oh, indeed. Thanks for finding this!

> This inconsistency was introduced in commit:
>
>   f05842cfb9ae2 ("kasan, arm64: allow using KUnit tests with HW_TAGS mode")

No, that commit is fine. The issue was introduced recently in
ed6d74446cbf ("kasan: test: support async (again) and asymm modes for
HW_TAGS"), where I changed kasan_init_hw_tags_cpu() to call
kasan_enable_tagging() instead of hw_enable_tagging_*().

> Fix the issue making sure that the CONFIG_KASAN_KUNIT_TEST guard does not
> prevent the correct invocation of kasan_enable_tagging().
>
> Fixes: f05842cfb9ae2 ("kasan, arm64: allow using KUnit tests with HW_TAGS mode")
> Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Andrey Konovalov <andreyknvl@gmail.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>  mm/kasan/hw_tags.c |  4 ++--
>  mm/kasan/kasan.h   | 10 ++++++----
>  2 files changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
> index 07a76c46daa5..e2677501c36e 100644
> --- a/mm/kasan/hw_tags.c
> +++ b/mm/kasan/hw_tags.c
> @@ -336,8 +336,6 @@ void __kasan_poison_vmalloc(const void *start, unsigned long size)
>
>  #endif
>
> -#if IS_ENABLED(CONFIG_KASAN_KUNIT_TEST)
> -
>  void kasan_enable_tagging(void)
>  {
>         if (kasan_arg_mode == KASAN_ARG_MODE_ASYNC)
> @@ -349,6 +347,8 @@ void kasan_enable_tagging(void)
>  }
>  EXPORT_SYMBOL_GPL(kasan_enable_tagging);

Please keep this EXPORT_SYMBOL_GPL under CONFIG_KASAN_KUNIT_TEST.

>
> +#if IS_ENABLED(CONFIG_KASAN_KUNIT_TEST)
> +
>  void kasan_force_async_fault(void)
>  {
>         hw_force_async_tag_fault();
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index d79b83d673b1..b01b4bbe0409 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -355,25 +355,27 @@ static inline const void *arch_kasan_set_tag(const void *addr, u8 tag)
>  #define hw_set_mem_tag_range(addr, size, tag, init) \
>                         arch_set_mem_tag_range((addr), (size), (tag), (init))
>
> +void kasan_enable_tagging(void);
> +
>  #else /* CONFIG_KASAN_HW_TAGS */
>
>  #define hw_enable_tagging_sync()
>  #define hw_enable_tagging_async()
>  #define hw_enable_tagging_asymm()
>
> +static inline void kasan_enable_tagging(void) { }
> +
>  #endif /* CONFIG_KASAN_HW_TAGS */
>
>  #if defined(CONFIG_KASAN_HW_TAGS) && IS_ENABLED(CONFIG_KASAN_KUNIT_TEST)
>
> -void kasan_enable_tagging(void);
>  void kasan_force_async_fault(void);
>
> -#else /* CONFIG_KASAN_HW_TAGS || CONFIG_KASAN_KUNIT_TEST */
> +#else /* CONFIG_KASAN_HW_TAGS && CONFIG_KASAN_KUNIT_TEST */
>
> -static inline void kasan_enable_tagging(void) { }
>  static inline void kasan_force_async_fault(void) { }
>
> -#endif /* CONFIG_KASAN_HW_TAGS || CONFIG_KASAN_KUNIT_TEST */
> +#endif /* CONFIG_KASAN_HW_TAGS && CONFIG_KASAN_KUNIT_TEST */
>
>  #ifdef CONFIG_KASAN_SW_TAGS
>  u8 kasan_random_tag(void);
> --
> 2.35.1
>

Thank you, Vincenzo!
