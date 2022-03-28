Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5A084E96FC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 14:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242628AbiC1Mvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 08:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234249AbiC1Mvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 08:51:32 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5380B33A07
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 05:49:52 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id j2so25861613ybu.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 05:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KUChceqjpLh79J1JQFAPdmmRt16+9BpF6Er6lqRNHnM=;
        b=maVnbV2w40X+zie6c69eqLTkE3mwOUCUKhLqXBM5TBtY9izg4Mq9EndXyXXEQDihlh
         ZkHfQxiXaMnhMMdwDip1XvXuXZ7ScmQWwvW/WZQeLwjDehz04SIA0Ts+EVjB4nTnD9zY
         7qeGSbRUBvHUdRHrzr8HhPZS/KY/7z1Z4aJuEZk+h1bMGQI2ZfeNP62Tnf+mP1RdkNZI
         VYV4ZO4V7TaAtGhl6djHJPtYZdb1sPVykMZJnfQdgxzWJOnKYF2FqcxBzsvKOcBy6XT4
         YATWrrE48W/6FFVW6LvoILUNa6ehaETUCpNtc9VYgS0vVTZ8K6cpbZ/zWsU59pvw5j67
         zS8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KUChceqjpLh79J1JQFAPdmmRt16+9BpF6Er6lqRNHnM=;
        b=l0JvC2zitdSUqBqko00ENXsNKu1RZxKyrCgF60VvbLt28Z0PuSYiz2sBJmJqtcjrRk
         0CBy+OND/8gwJHBO7gAPATWImlEsejbqP4Y6t+FlTNFzMyoVG1flWIP7OBWiqIrbGWcI
         TtcsaNWbY6/w81zfrn5Q6QxkD68VgCDKjACjkeq4zBlQK0+HNZBdcZSozcNAT9kHb2kN
         cwKBnvwbZCr44eyJsSbTNDLsH3w47IPKIGmsNJC50Vn7Uxt2MRBdQQj1qlkHiTsbN79U
         X1Jo9MSIMhScsL6RsSjkTfrBsUfmDEh3bhKw9l4v5mljRdV4tmcVtbBOUmPmYGtiniTv
         Z5xQ==
X-Gm-Message-State: AOAM531ntKRP+w9wD6djGaSKaqNqEndy9if/Z34ez/HB/twlgls7MGkk
        ZMdzidTCrkY+Olib5O04BZG7paVzQ7NnAG6QzbK96g==
X-Google-Smtp-Source: ABdhPJz/nC8Q3dmMv0pTY0Bqml7jS4vWoZHU6q7UKQKSEbGR6IHs4zmkgJSlmMqGUOmtHm2Y9W1Xg3JOt85G5SRnmEo=
X-Received: by 2002:a05:6902:24f:b0:62d:69d:c9fc with SMTP id
 k15-20020a056902024f00b0062d069dc9fcmr21590325ybs.87.1648471791406; Mon, 28
 Mar 2022 05:49:51 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1648049113.git.andreyknvl@google.com> <7027b9b6b0cae2921ff65739582ae499bf61470c.1648049113.git.andreyknvl@google.com>
In-Reply-To: <7027b9b6b0cae2921ff65739582ae499bf61470c.1648049113.git.andreyknvl@google.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 28 Mar 2022 14:49:15 +0200
Message-ID: <CANpmjNPJkFOMn1pL-=gx+x_YHgg72QH5iqe561+Geiy3JoOg1w@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] kasan: use stack_trace_save_shadow
To:     andrey.konovalov@linux.dev
Cc:     Alexander Potapenko <glider@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, Mark Rutland <mark.rutland@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Florian Mayer <fmayer@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
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

On Wed, 23 Mar 2022 at 16:33, <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@google.com>
>
> Now that stack_trace_save_shadow() is implemented by arm64, use it
> whenever CONFIG_HAVE_SHADOW_STACKTRACE is enabled. This improves the
> boot time of a defconfig build by ~30% for all KASAN modes.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---
>  mm/kasan/common.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index d9079ec11f31..8d9d35c6562b 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -33,10 +33,13 @@
>  depot_stack_handle_t kasan_save_stack(gfp_t flags, bool can_alloc)
>  {
>         unsigned long entries[KASAN_STACK_DEPTH];
> -       unsigned int nr_entries;
> +       unsigned int size;

Why did this variable name change?

> -       nr_entries = stack_trace_save(entries, ARRAY_SIZE(entries), 0);
> -       return __stack_depot_save(entries, nr_entries, flags, can_alloc);
> +       if (IS_ENABLED(CONFIG_HAVE_SHADOW_STACKTRACE))

Would it be more reliable to check the return-code? I.e. do:

  int size;

  size = stack_trace_save_shadow(...)
  if (size < 0)
    size = stack_trace_save(...);

> +               size = stack_trace_save_shadow(entries, ARRAY_SIZE(entries), 0);
> +       else
> +               size = stack_trace_save(entries, ARRAY_SIZE(entries), 0);
> +       return __stack_depot_save(entries, size, flags, can_alloc);
>  }
>
>  void kasan_set_track(struct kasan_track *track, gfp_t flags)
> --
> 2.25.1
