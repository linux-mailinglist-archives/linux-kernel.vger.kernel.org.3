Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF7164B8C5C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 16:27:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233982AbiBPP1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 10:27:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbiBPP1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 10:27:10 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C1B13E8B;
        Wed, 16 Feb 2022 07:26:57 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id e79so3858iof.13;
        Wed, 16 Feb 2022 07:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RX1MiZpwQpJ0b3L1gArX38pH7r/Ihc4JwK8Scpn15pk=;
        b=auojpY6RZCoHWJ/4x2YOYeUUljS7wYk8WlNj5MCi2Yk/KzSIFHoNm/87wPuSd0oqbe
         iJhtQiMeFb+7xvUz0w4kI4PqXtGvU9htbgYVPND8XCCyezl9w0x85UyIHLEBlZCl9KJw
         iWG2+M44RCTTaJvE7+4tO7lINSWQKYgcDSDFv7g7WlQ+yIWdcsU65tExMMc7VK7JqTbg
         ZTWvPF3f6lMqbvSlee1fpte4I9BFlwlUiq7IsVzjYxOdzJwIbYhh6vgT/Np0nXvfjxeB
         cF+WXuLW1ExDd2N28sxc/dUQXc+AmGd1F2lQysPP2VdwiuyuZpSvKEoDLO742sa0jeAj
         vpFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RX1MiZpwQpJ0b3L1gArX38pH7r/Ihc4JwK8Scpn15pk=;
        b=dgocvxsfOOcWOjl5bEHxk64tpMEHFWyB3TMjt21D1493eFiCerSVoPDHRLYt6EbPZl
         mNSWAjiIFYJ1oh47b7YrvrwvHbhepmusv8h7YrxJJTsWA73txhSQ3X8hEEv2PAiVvWVQ
         MdUDbrqlEavmcCClrRer/27j6UbvB++rxPmIUrvlI1HjrvjT43QsPJ/nDd+gs0ITQVwQ
         DJr/DLXWBZ/PnY3sRJrvirDoJ/Zfzsi5vwaaWX4bmwmhL3SQtA45x7EYLAqJB6rpM02l
         1t9Jt50VFAhz+FOxvBWv00cX9WiQ1SPuVxdDzs0ohS6k9aemaJjlXsm4ydVNmisHBHk5
         W9Gg==
X-Gm-Message-State: AOAM531qrF8Y+RR7GfyFgWnrKNC6xHButljM57LW1EBOliCrMeEtXVEl
        0EahX2BQoN//+UC5r8dRukqXQOSgUNo6zgSafPU=
X-Google-Smtp-Source: ABdhPJw+9fZm9qNxljGG9zsbhu6zOBtPWpIZEpXZRzeZ1wqFjj2zXh4SO7a76KP8unPEklvkMMs95vCD5qO3yRiFseQ=
X-Received: by 2002:a05:6638:3799:b0:30f:cc82:ebc4 with SMTP id
 w25-20020a056638379900b0030fcc82ebc4mr2090155jal.117.1645025216948; Wed, 16
 Feb 2022 07:26:56 -0800 (PST)
MIME-Version: 1.0
References: <20220213183232.4038718-1-keescook@chromium.org>
In-Reply-To: <20220213183232.4038718-1-keescook@chromium.org>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Wed, 16 Feb 2022 16:26:46 +0100
Message-ID: <CA+fCnZfOSD56Uvetqd=ofv-Wxw6LOOZv3sUDcEuX2F3u-MgL9Q@mail.gmail.com>
Subject: Re: [PATCH] kasan: test: Silence allocation warnings from GCC 12
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
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

On Sun, Feb 13, 2022 at 7:32 PM Kees Cook <keescook@chromium.org> wrote:
>
> GCC 12 is able to see more problems with allocation sizes at compile
> time, so these must be silenced so the runtime checks will still be
> available. Use OPTIMIZER_HIDE_VAR() to silence the new warnings:
>
> lib/test_kasan.c: In function 'ksize_uaf':

Hm, the warning mentions ksize_uaf, but none of the changes touch it.

> lib/test_kasan.c:781:61: warning: array subscript 120 is outside array bounds of 'void[120]' [-Warray-bounds]
>   781 |         KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)ptr)[size]);
>       |                                       ~~~~~~~~~~~~~~~~~~~~~~^~~~~~
> lib/test_kasan.c:96:9: note: in definition of macro 'KUNIT_EXPECT_KASAN_FAIL'
>    96 |         expression;                                                     \
>       |         ^~~~~~~~~~
> In function 'kmalloc',
>     inlined from 'ksize_uaf' at lib/test_kasan.c:775:8:
> ./include/linux/slab.h:581:24: note: at offset 120 into object of size 120 allocated by 'kmem_cache_alloc_trace'
>   581 |                 return kmem_cache_alloc_trace(
>       |                        ^~~~~~~~~~~~~~~~~~~~~~~
>   582 |                                 kmalloc_caches[kmalloc_type(flags)][index],
>       |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   583 |                                 flags, size);
>       |                                 ~~~~~~~~~~~~
>
> Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Andrey Konovalov <andreyknvl@gmail.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: kasan-dev@googlegroups.com
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  lib/test_kasan.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> index 26a5c9007653..a19b3d608e3e 100644
> --- a/lib/test_kasan.c
> +++ b/lib/test_kasan.c
> @@ -124,6 +124,7 @@ static void kmalloc_oob_right(struct kunit *test)
>
>         ptr = kmalloc(size, GFP_KERNEL);
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
> +       OPTIMIZER_HIDE_VAR(ptr);
>
>         /*
>          * An unaligned access past the requested kmalloc size.
> @@ -185,6 +186,7 @@ static void kmalloc_pagealloc_oob_right(struct kunit *test)
>         ptr = kmalloc(size, GFP_KERNEL);
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
>
> +       OPTIMIZER_HIDE_VAR(ptr);
>         KUNIT_EXPECT_KASAN_FAIL(test, ptr[size + OOB_TAG_OFF] = 0);
>
>         kfree(ptr);
> @@ -265,6 +267,7 @@ static void kmalloc_large_oob_right(struct kunit *test)
>         ptr = kmalloc(size, GFP_KERNEL);
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
>
> +       OPTIMIZER_HIDE_VAR(ptr);
>         KUNIT_EXPECT_KASAN_FAIL(test, ptr[size] = 0);
>         kfree(ptr);
>  }
> @@ -748,6 +751,7 @@ static void ksize_unpoisons_memory(struct kunit *test)
>
>         ptr = kmalloc(size, GFP_KERNEL);
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
> +       OPTIMIZER_HIDE_VAR(ptr);
>         real_size = ksize(ptr);
>
>         /* This access shouldn't trigger a KASAN report. */
> --
> 2.30.2
>
