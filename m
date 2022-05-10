Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9C1F52148D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 14:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241348AbiEJMCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 08:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241516AbiEJMCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 08:02:30 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 833C12B8D39
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 04:58:09 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id m62so10034418wme.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 04:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fGBBzJMSY58ZqJQmQlHeFlOhEyr8JQc2d5kb0lSfqro=;
        b=R6G+qM4kBuKqVaT1XytJvW3yEUzzXtSj5dKK6loIx1swrFZ/Tj0+pWoIpY2dA/Zz65
         JPm1P357XPMzFFro5TKbBVY1rKOiMgQSEmE8CbpivobX5BL9+/16kpeu5dxX4TWgho6l
         fPfoJB4OzQcJfZysMQVsSGZbybyfdA5Uc5NJezzzRzTGb1uM8T1PM+9rYpnSv/Q9DI0o
         2gDuUqP03JK95S0ZWWiyhzSsTkYdqElWzkg7KeAG7KbOHaPdoC6uSYJRKgYg/3sx1V9j
         sg4MY1JVGl047E6fth1W2e2iAOUg0xwnc8iIUKDqv2/xRMYDqNHedDOl2Wo6eVj/DzBL
         YklQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fGBBzJMSY58ZqJQmQlHeFlOhEyr8JQc2d5kb0lSfqro=;
        b=PURspAHhy5XeetOeAd/vhJVxKzUHEOJmojaNEoecnp8JRY5Vtw4xxZHKZm1x7XAXJQ
         SOLw+h8ROy6aaKBkHOV2C5SOX90p+UMiBN6tGWf8YHa0dtExFx9o2Bn48GdJ+2RnKsYy
         xRvJOgEcd70AjL2RJ2U8DoGmgeqh7nPCiAJZbew5kQMBlcI3VouOudLH2XLm/lYllTqu
         B20LYbxft+cBfKvX9UXv9L8FCoveoDJCm77mC9Zl/WQ6saY0HAm0rBR/Mw226d+dvW0P
         3kM67eJC2A00NQu9K+DKaKquRykgwONTnXgKeN6pQQUQFUMZP+4K7hrjhLTsxt3nBGm3
         qfsQ==
X-Gm-Message-State: AOAM530ZyIByD6Emu/3bhayky9Kl6zarhUlCHhYAbNGL/f5fGaircVt6
        C4bILGh9XI5JKZZhpNbBDV80lg==
X-Google-Smtp-Source: ABdhPJxaot0xxKsppG574C+OJUI7+QbwDO9wD7GpaSgIuhTnvgsz2bfmx0Zyc+cT6zXhVbQfrvfafw==
X-Received: by 2002:a05:600c:220e:b0:394:2695:ce9b with SMTP id z14-20020a05600c220e00b003942695ce9bmr21325260wml.64.1652183887631;
        Tue, 10 May 2022 04:58:07 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:15:13:640f:aa66:3ec8:cbb6])
        by smtp.gmail.com with ESMTPSA id o23-20020a5d58d7000000b0020c635ca28bsm13557898wrf.87.2022.05.10.04.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 04:58:07 -0700 (PDT)
Date:   Tue, 10 May 2022 13:58:01 +0200
From:   Marco Elver <elver@google.com>
To:     andrey.konovalov@linux.dev
Cc:     Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH 2/3] kasan: move boot parameters section in documentation
Message-ID: <YnpTSS3JTR4e9G0b@elver.google.com>
References: <5bd58ebebf066593ce0e1d265d60278b5f5a1874.1652123204.git.andreyknvl@google.com>
 <ec9c923f35e7c5312836c4624a7f317dc1ee2c1c.1652123204.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec9c923f35e7c5312836c4624a7f317dc1ee2c1c.1652123204.git.andreyknvl@google.com>
User-Agent: Mutt/2.1.4 (2021-12-11)
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2022 at 09:07PM +0200, andrey.konovalov@linux.dev wrote:
> From: Andrey Konovalov <andreyknvl@google.com>
> 
> Move the "Boot parameters" section in KASAN documentation next to the
> section that describes KASAN build options.
> 
> No content changes.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Reviewed-by: Marco Elver <elver@google.com>

> ---
>  Documentation/dev-tools/kasan.rst | 82 +++++++++++++++----------------
>  1 file changed, 41 insertions(+), 41 deletions(-)
> 
> diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
> index aca219ed1198..7f103e975ac2 100644
> --- a/Documentation/dev-tools/kasan.rst
> +++ b/Documentation/dev-tools/kasan.rst
> @@ -94,6 +94,47 @@ To include alloc and free stack traces of affected slab objects into reports,
>  enable ``CONFIG_STACKTRACE``. To include alloc and free stack traces of affected
>  physical pages, enable ``CONFIG_PAGE_OWNER`` and boot with ``page_owner=on``.
>  
> +Boot parameters
> +~~~~~~~~~~~~~~~
> +
> +KASAN is affected by the generic ``panic_on_warn`` command line parameter.
> +When it is enabled, KASAN panics the kernel after printing a bug report.
> +
> +By default, KASAN prints a bug report only for the first invalid memory access.
> +With ``kasan_multi_shot``, KASAN prints a report on every invalid access. This
> +effectively disables ``panic_on_warn`` for KASAN reports.
> +
> +Alternatively, independent of ``panic_on_warn``, the ``kasan.fault=`` boot
> +parameter can be used to control panic and reporting behaviour:
> +
> +- ``kasan.fault=report`` or ``=panic`` controls whether to only print a KASAN
> +  report or also panic the kernel (default: ``report``). The panic happens even
> +  if ``kasan_multi_shot`` is enabled.
> +
> +Hardware Tag-Based KASAN mode (see the section about various modes below) is
> +intended for use in production as a security mitigation. Therefore, it supports
> +additional boot parameters that allow disabling KASAN or controlling features:
> +
> +- ``kasan=off`` or ``=on`` controls whether KASAN is enabled (default: ``on``).
> +
> +- ``kasan.mode=sync``, ``=async`` or ``=asymm`` controls whether KASAN
> +  is configured in synchronous, asynchronous or asymmetric mode of
> +  execution (default: ``sync``).
> +  Synchronous mode: a bad access is detected immediately when a tag
> +  check fault occurs.
> +  Asynchronous mode: a bad access detection is delayed. When a tag check
> +  fault occurs, the information is stored in hardware (in the TFSR_EL1
> +  register for arm64). The kernel periodically checks the hardware and
> +  only reports tag faults during these checks.
> +  Asymmetric mode: a bad access is detected synchronously on reads and
> +  asynchronously on writes.
> +
> +- ``kasan.vmalloc=off`` or ``=on`` disables or enables tagging of vmalloc
> +  allocations (default: ``on``).
> +
> +- ``kasan.stacktrace=off`` or ``=on`` disables or enables alloc and free stack
> +  traces collection (default: ``on``).
> +
>  Error reports
>  ~~~~~~~~~~~~~
>  
> @@ -208,47 +249,6 @@ traces point to places in code that interacted with the object but that are not
>  directly present in the bad access stack trace. Currently, this includes
>  call_rcu() and workqueue queuing.
>  
> -Boot parameters
> -~~~~~~~~~~~~~~~
> -
> -KASAN is affected by the generic ``panic_on_warn`` command line parameter.
> -When it is enabled, KASAN panics the kernel after printing a bug report.
> -
> -By default, KASAN prints a bug report only for the first invalid memory access.
> -With ``kasan_multi_shot``, KASAN prints a report on every invalid access. This
> -effectively disables ``panic_on_warn`` for KASAN reports.
> -
> -Alternatively, independent of ``panic_on_warn``, the ``kasan.fault=`` boot
> -parameter can be used to control panic and reporting behaviour:
> -
> -- ``kasan.fault=report`` or ``=panic`` controls whether to only print a KASAN
> -  report or also panic the kernel (default: ``report``). The panic happens even
> -  if ``kasan_multi_shot`` is enabled.
> -
> -Hardware Tag-Based KASAN mode (see the section about various modes below) is
> -intended for use in production as a security mitigation. Therefore, it supports
> -additional boot parameters that allow disabling KASAN or controlling features:
> -
> -- ``kasan=off`` or ``=on`` controls whether KASAN is enabled (default: ``on``).
> -
> -- ``kasan.mode=sync``, ``=async`` or ``=asymm`` controls whether KASAN
> -  is configured in synchronous, asynchronous or asymmetric mode of
> -  execution (default: ``sync``).
> -  Synchronous mode: a bad access is detected immediately when a tag
> -  check fault occurs.
> -  Asynchronous mode: a bad access detection is delayed. When a tag check
> -  fault occurs, the information is stored in hardware (in the TFSR_EL1
> -  register for arm64). The kernel periodically checks the hardware and
> -  only reports tag faults during these checks.
> -  Asymmetric mode: a bad access is detected synchronously on reads and
> -  asynchronously on writes.
> -
> -- ``kasan.vmalloc=off`` or ``=on`` disables or enables tagging of vmalloc
> -  allocations (default: ``on``).
> -
> -- ``kasan.stacktrace=off`` or ``=on`` disables or enables alloc and free stack
> -  traces collection (default: ``on``).
> -
>  Implementation details
>  ----------------------
>  
> -- 
> 2.25.1
> 
> -- 
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/ec9c923f35e7c5312836c4624a7f317dc1ee2c1c.1652123204.git.andreyknvl%40google.com.
