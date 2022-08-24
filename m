Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93FB259F617
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 11:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236235AbiHXJTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 05:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235131AbiHXJTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 05:19:44 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E19C9832D7
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 02:19:42 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id f14so12220371qkm.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 02:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=QZ1Zdo4TymduSekJHO/MM7un0W7AuCiIMfSsAxw8LuI=;
        b=dfZv3as1V10XwuRX11EVQjEcQQrIDSswFB7Bisf64q5BNi3QYdfMFQMEIrqOxXWkCa
         h53O+cReCVuv4GnCbB+lDB4qtLlJRtZPdD5tW5httZDdB5G4x5nZVt4IsLi2T86fkTFa
         b9AJxPmhFqjVMvNaxZfzcDQbW13m5YvxFqQ3y8tWbWRyrOA7p7KXU0C14hBAB3Jr0YLu
         tK91yiilbhzY0hrHtb5Dy5aC4w6Vf4LJXsto/E0hrS/4NjHbb5iYaLzMe+pMxoiB/msQ
         apPPJRaZwmjoG89JgROSJFIsT63QgBXkE5JQoM++yOaN9L61AkYd7K9QXYbeZChdlYD+
         BCjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=QZ1Zdo4TymduSekJHO/MM7un0W7AuCiIMfSsAxw8LuI=;
        b=XaM28WqWTTQpzREsleKkiGN3fnTVyTGrH6KFzYYghJh5wuFrWNqAXQdU5DpcgsDRsD
         54cff9AjyVFmt0Fm68IBxjeZozpnHHsOPSNMuetcCH9zQHaOkh7Hp+ZpiFhfatyKrKCC
         T+cIHLOFDlUv4gIpYoUCyZJylW+DYOR4usKnJ+HthA/Q0XHvvrR73/kYGN9yqkooJTX8
         eVQMnNlSbS+o409LOXmK4Xw3cY7B3NiGRwNd+qlM5hPvKp6z3KDJTluAFWSjMjb7EK2/
         66msSjSX7e7MilZ3PGsEPw9+W33NrOyA7EKxE1nrgId9AfV7XKvgSVzzqNWTGekjuQAU
         NI+A==
X-Gm-Message-State: ACgBeo3WAXV73LkFKbe5BSZ8j1ALLFaVgoSZ0JZzqKJXwRmnNiWzzBJN
        sFdiuuNOxw1c8Jp+fj9wZ9nTbn4GrYTE2oVOMRo=
X-Google-Smtp-Source: AA6agR6MTk0hE5I5asyFmVNcsj40GrGLGjdh6R6zk/gJT8MBp9e5ZD8FTVpHeIE3SBaKCD8VdybST1o056dS1SUCXzI=
X-Received: by 2002:a05:620a:410e:b0:6bc:5cdc:88ec with SMTP id
 j14-20020a05620a410e00b006bc5cdc88ecmr605306qko.734.1661332781985; Wed, 24
 Aug 2022 02:19:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220824012624.2826445-1-yury.norov@gmail.com> <20220824012624.2826445-4-yury.norov@gmail.com>
In-Reply-To: <20220824012624.2826445-4-yury.norov@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 24 Aug 2022 12:19:05 +0300
Message-ID: <CAHp75Ve4QTSs_mSB7uMqOK4q+A-z-O1tc2k5=2qaRHTdAC3yog@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] lib/find_bit: optimize find_next_bit() functions
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Dennis Zhou <dennis@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alexey Klimov <aklimov@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Whitcroft <apw@canonical.com>
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

On Wed, Aug 24, 2022 at 4:56 AM Yury Norov <yury.norov@gmail.com> wrote:
>
> Over the past couple years, the function _find_next_bit() was extended
> with parameters that modify its behavior to implement and- zero- and le-
> flavors. The parameters are passed at compile time, but current design
> prevents a compiler from optimizing out the conditionals.
>
> As find_next_bit() API grows, I expect that more parameterss will be added.

parameters

> Current designs would require more conditional code in _find_next_bit(),
> which would bloat the helper even more and make it barely readable.
>
> This patch replaces _find_next_bit() with a macro FIND_NEXT_BIT, and adds
> a set of wrappers, so that the compile-time optimization becomes possible.
>
> The common logic is moved to the new macro, and all flavors may be
> generated by providing an EXPRESSION macro parameter, like in this example:
>
>   #define FIND_NEXT_BIT(EXPRESSION, size, start) ...
>
>   find_next_xornot_and_bit(addr1, addr2, addr3, size, start)
>   {
>         return FIND_NEXT_BIT(addr1[idx] ^ ~addr2[idx] & addr3[idx], size, start);
>   }
>
> The EXPRESSION may be of any complexity, as soon as it only refers
> the bitmap(s) and an iterator idx.

...

> +#define FIND_NEXT_BIT(EXPRESSION, size, start)                                 \
> +({                                                                             \
> +       unsigned long mask, idx, tmp, sz = (size), __start = (start);           \
> +                                                                               \
> +       if (unlikely(__start >= sz))                                            \
> +               goto out;                                                       \
> +                                                                               \
> +       mask = word_op(BITMAP_FIRST_WORD_MASK(__start));                        \
> +       idx = __start / BITS_PER_LONG;                                          \
> +                                                                               \
> +       for (tmp = (EXPRESSION) & mask; !tmp; tmp = (EXPRESSION)) {             \

for (unsigned long tmp ...;
But hey, why not loop over idx (which probably should be named as
offset) as I proposed in the first patch? You will drop a lot of
divisions / multiplications, no?

> +               if (idx > sz / BITS_PER_LONG)                                   \
> +                       goto out;                                               \
> +               idx++;                                                          \
> +       }                                                                       \
> +                                                                               \
> +       sz = min(idx * BITS_PER_LONG + __ffs(word_op(tmp)), sz);                \
> +out:                                                                           \
> +       sz;                                                                     \
> +})

-- 
With Best Regards,
Andy Shevchenko
