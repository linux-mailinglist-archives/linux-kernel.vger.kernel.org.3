Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 782025A9236
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 10:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233454AbiIAIji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 04:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232194AbiIAIjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 04:39:35 -0400
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E04130625;
        Thu,  1 Sep 2022 01:39:33 -0700 (PDT)
Received: by mail-qt1-f176.google.com with SMTP id a22so10166588qtw.10;
        Thu, 01 Sep 2022 01:39:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=TCjv5cLgcap9q7CifTkI5Z9/slzjTacUXMDHDANqD+c=;
        b=JVyvZvW2rF/r2gOJRHRwg5s3MhHRvrkSbQEwzOwG0iwvUfr5GrEy9iX54EWCM8v4K/
         wdcDKmbfBPpFcQYTO3Bo0fIm02l6YaORweLMKpAJ9R9f1hqxkeIS1A7y1wwLNvNfPcKt
         H35n2PcRMbvag6RxpTs9PeMth3zoDbY1+HvvrYoPEr/o5//9NwtV+RyBjL83T0LRdOwG
         2C03yxLMnxlW+8rXPJq9xYY1X3sXG4B1mL3rUVmbBcE+icIdIr/YnQ/LOymrsK8cuyCX
         6eFT7BHciVuAOH4K3pj/VU3Xik5S6t293dH6fVJrSPPr2qxvLaMenvL1u0dpUYqeIURT
         N2Pg==
X-Gm-Message-State: ACgBeo2sNgWDWv40Ty07okDYt/Jgf583JSUxEx3pSnAwvFk8FKtz7x+o
        sgcumyCiZhpNx/kmR3+zdX7WEwc2bEh7JQ==
X-Google-Smtp-Source: AA6agR7vfnWuCPVtegsimxQChi0eY5S3Uhb1n3q4Eo6eTBVOKzqV+NWJSr74VOLYk2+t00NEyuroOQ==
X-Received: by 2002:ac8:4e85:0:b0:344:88de:992b with SMTP id 5-20020ac84e85000000b0034488de992bmr22625890qtp.293.1662021571622;
        Thu, 01 Sep 2022 01:39:31 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id o17-20020a05620a2a1100b006b942ae928bsm12222333qkp.71.2022.09.01.01.39.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 01:39:31 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id e71so7634977ybh.9;
        Thu, 01 Sep 2022 01:39:30 -0700 (PDT)
X-Received: by 2002:a25:415:0:b0:696:814:7c77 with SMTP id 21-20020a250415000000b0069608147c77mr18467239ybe.36.1662021570696;
 Thu, 01 Sep 2022 01:39:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220831230006.1016236-1-keescook@chromium.org>
In-Reply-To: <20220831230006.1016236-1-keescook@chromium.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 1 Sep 2022 10:39:19 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX1H_ssPDJH47kcXhmoAZzYEgJC2zaMp-d_2+VriZYAoA@mail.gmail.com>
Message-ID: <CAMuHMdX1H_ssPDJH47kcXhmoAZzYEgJC2zaMp-d_2+VriZYAoA@mail.gmail.com>
Subject: Re: [PATCH] string: Introduce strtomem() and strtomem_pad()
To:     Kees Cook <keescook@chromium.org>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Paolo Abeni <pabeni@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees,

CC torvalds

Thanks for your patch!

On Thu, Sep 1, 2022 at 1:00 AM Kees Cook <keescook@chromium.org> wrote:
> One of the "legitimate" uses of strncpy() is copying a NUL-terminated
> string into a fixed-size non-NUL-terminated character array. To avoid
> the weaknesses and ambiguity of intent when using strncpy(), provide
> replacement functions that explicitly distinguish between trailing
> padding and not, and require the destination buffer size be discoverable
> by the compiler.
>
> For example:
>
> struct obj {
>         int foo;
>         char small[4] __nonstring;
>         char big[8] __nonstring;
>         int bar;
> };
>
> struct obj p;
>
> /* This will truncate to 4 chars with no trailing NUL */
> strncpy(p.small, "hello", sizeof(p.small));
> /* p.small contains 'h', 'e', 'l', 'l' */
>
> /* This will NUL pad to 8 chars. */
> strncpy(p.big, "hello", sizeof(p.big));
> /* p.big contains 'h', 'e', 'l', 'l', 'o', '\0', '\0', '\0' */
>
> When the "__nonstring" attributes are missing, the intent of the
> programmer becomes ambiguous for whether the lack of a trailing NUL
> in the p.small copy is a bug. Additionally, it's not clear whether
> the trailing padding in the p.big copy is _needed_. Both cases
> become unambiguous with:
>
> strtomem(p.small, "hello");
> strtomem_pad(p.big, "hello");

strtomem_pad(p.big, "hello", 0);

> See also https://github.com/KSPP/linux/issues/90
>
> Expand the memcpy KUnit tests to include these functions.
>
> Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Kees Cook <keescook@chromium.org>

The idea looks good to me, but I guess Linus has something to
say, too.

> --- a/include/linux/string.h
> +++ b/include/linux/string.h
> @@ -260,6 +260,49 @@ static inline const char *kbasename(const char *path)
>  void memcpy_and_pad(void *dest, size_t dest_len, const void *src, size_t count,
>                     int pad);
>
> +/**
> + * strtomem_pad - Copy NUL-terminated string to non-NUL-terminated buffer
> + *
> + * @dest: Pointer of destination character array (marked as __nonstring)
> + * @src: Pointer to NUL-terminated string
> + * @pad: Padding character to fill any remaining bytes of @dest after copy
> + *
> + * This is a replacement for strncpy() uses where the destination is not
> + * a NUL-terminated string, but with bounds checking on the source size, and
> + * an explicit padding character. If padding is not required, use strtomem().
> + *
> + * Note that the size of @dest is not an argument, as the length of @dest
> + * must be discoverable by the compiler.
> + */
> +#define strtomem_pad(dest, src, pad)   do {                            \
> +       const size_t _dest_len = __builtin_object_size(dest, 1);        \
> +                                                                       \
> +       BUILD_BUG_ON(!__builtin_constant_p(_dest_len) ||                \
> +                    _dest_len == (size_t)-1);                          \

I think you want to include __must_be_array(dest) here.

> +       memcpy_and_pad(dest, _dest_len, src, strnlen(src, _dest_len), pad); \
> +} while (0)
> +
> +/**
> + * strtomem - Copy NUL-terminated string to non-NUL-terminated buffer
> + *
> + * @dest: Pointer of destination character array (marked as __nonstring)
> + * @src: Pointer to NUL-terminated string
> + *
> + * This is a replacement for strncpy() uses where the destination is not
> + * a NUL-terminated string, but with bounds checking on the source size, and
> + * without trailing padding. If padding is required, use strtomem_pad().
> + *
> + * Note that the size of @dest is not an argument, as the length of @dest
> + * must be discoverable by the compiler.
> + */
> +#define strtomem(dest, src)    do {                                    \
> +       const size_t _dest_len = __builtin_object_size(dest, 1);        \
> +                                                                       \
> +       BUILD_BUG_ON(!__builtin_constant_p(_dest_len) ||                \
> +                    _dest_len == (size_t)-1);                          \

I think you want to include __must_be_array(dest) here.

> +       memcpy(dest, src, min(_dest_len, strnlen(src, _dest_len)));     \
> +} while (0)
> +
>  /**
>   * memset_after - Set a value after a struct member to the end of a struct
>   *
> diff --git a/lib/memcpy_kunit.c b/lib/memcpy_kunit.c
> index 62f8ffcbbaa3..2aeb8643e1b0 100644
> --- a/lib/memcpy_kunit.c
> +++ b/lib/memcpy_kunit.c
> @@ -272,10 +272,63 @@ static void memset_test(struct kunit *test)
>  #undef TEST_OP
>  }
>
> +static void strtomem_test(struct kunit *test)
> +{
> +       static const char input[] = "hi";
> +       static const char truncate[] = "this is too long";
> +       struct {
> +               unsigned long canary1;
> +               unsigned char output[sizeof(unsigned long)] __nonstring;
> +               unsigned long canary2;
> +       } wrap;
> +
> +       memset(&wrap, 0xFF, sizeof(wrap));
> +       KUNIT_EXPECT_EQ_MSG(test, wrap.canary1, -1UL,

-1L or ULONG_MAX (everywhere)

> +                           "bad initial canary value");
> +       KUNIT_EXPECT_EQ_MSG(test, wrap.canary2, -1UL,
> +                           "bad initial canary value");
> +
> +       /* Check unpadded copy leaves surroundings untouched. */
> +       strtomem(wrap.output, input);
> +       KUNIT_EXPECT_EQ(test, wrap.canary1, -1UL);
> +       KUNIT_EXPECT_EQ(test, wrap.output[0], input[0]);
> +       KUNIT_EXPECT_EQ(test, wrap.output[1], input[1]);
> +       for (int i = 2; i < sizeof(wrap.output); i++)

unsigned int i (everywhere)

> +               KUNIT_EXPECT_EQ(test, wrap.output[i], 0xFF);
> +       KUNIT_EXPECT_EQ(test, wrap.canary2, -1UL);
> +
> +       /* Check truncated copy leaves surroundings untouched. */
> +       memset(&wrap, 0xFF, sizeof(wrap));
> +       strtomem(wrap.output, truncate);
> +       KUNIT_EXPECT_EQ(test, wrap.canary1, -1UL);
> +       for (int i = 0; i < sizeof(wrap.output); i++)
> +               KUNIT_EXPECT_EQ(test, wrap.output[i], truncate[i]);
> +       KUNIT_EXPECT_EQ(test, wrap.canary2, -1UL);
> +
> +       /* Check padded copy leaves only string padded. */
> +       memset(&wrap, 0xFF, sizeof(wrap));
> +       strtomem_pad(wrap.output, input, 0xAA);
> +       KUNIT_EXPECT_EQ(test, wrap.canary1, -1UL);
> +       KUNIT_EXPECT_EQ(test, wrap.output[0], input[0]);
> +       KUNIT_EXPECT_EQ(test, wrap.output[1], input[1]);
> +       for (int i = 2; i < sizeof(wrap.output); i++)
> +               KUNIT_EXPECT_EQ(test, wrap.output[i], 0xAA);
> +       KUNIT_EXPECT_EQ(test, wrap.canary2, -1UL);
> +
> +       /* Check truncated padded copy has no padding. */
> +       memset(&wrap, 0xFF, sizeof(wrap));
> +       strtomem(wrap.output, truncate);
> +       KUNIT_EXPECT_EQ(test, wrap.canary1, -1UL);
> +       for (int i = 0; i < sizeof(wrap.output); i++)
> +               KUNIT_EXPECT_EQ(test, wrap.output[i], truncate[i]);
> +       KUNIT_EXPECT_EQ(test, wrap.canary2, -1UL);
> +}
> +
>  static struct kunit_case memcpy_test_cases[] = {
>         KUNIT_CASE(memset_test),
>         KUNIT_CASE(memcpy_test),
>         KUNIT_CASE(memmove_test),
> +       KUNIT_CASE(strtomem_test),
>         {}
>  };

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
