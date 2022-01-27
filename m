Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 881F849E48C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 15:25:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242326AbiA0OZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 09:25:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiA0OY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 09:24:58 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F498C061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 06:24:58 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id r144so3712547iod.9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 06:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FezwsF5GfO3GymnMg24LAESoR1ooXl9Ccmmz2bdgDaY=;
        b=FntJC53E59MKXehwHhvBH+9gMa3AyjxalX3AT/ymzAl3WeCs4DBshyitp7f8X2XITs
         6CO0VKCHc+y+URuhWArND5Ze9Y7OByCTgKLaTFhvyl1/fXeeE8oXXSr2jS0XDGJbbkSm
         dp4Njst26m0S4InAq1Qgy5/omzTCanLtoUmH2zMKhZcg0GTueW41ibwtILk5ygR/shA4
         cpqPrMserJhekLz1TVi3APAIuUzZYCriHFIbTm4GwOp25saaRvMRsFRKtO0f+VojxUs+
         m0rkVyqJRYm3nLmAyPaux9a474uVFv8wu+Dd29ZX4ZL5u+cWRoa6J/nHsfGhAItcJE9f
         lM8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FezwsF5GfO3GymnMg24LAESoR1ooXl9Ccmmz2bdgDaY=;
        b=P8RpWr1PhIcUMxJUxrMea8fempxe8p/BilH/q2uba7Z00uHK6d+y17EALXTsmx1g0u
         bCTtj64huWc5W3qvXNyuM2Nc4gEX8hZUjPQokUa0Rm/c+LCRJbJmmOP3z3P2SnrmpJrX
         kuxqrE9COZAqWuNhb2y7qg4opCICVZzQT2Ksf2Z/pIU9b/yVz9PaQz5snQkWQD/ro00e
         1kHRonnm5f9YDrtjF9Tl7VB6D5iYnXqSboRZm6lrSS9eYETiTNDIo0d828bSvwmZYsIG
         LQbUsw1vS2kF9/kyHErvcPPrx/63milhCxBsKArUa6cTgX5GWb8bDw0M+DZcHPFIMfQ5
         FvmA==
X-Gm-Message-State: AOAM532czMSMEGb0dIcenVo4X+rtz0g17hE1Ajo/EnKwSTGyXzzXMI7B
        HceDKqb6wST6A5WktW+5hNxAPt0iPB85QQXPP3c=
X-Google-Smtp-Source: ABdhPJzgVwy+jmScS6ur51rzrE90GjlhJRrTxtHub4EtS788kr2mgYJXA2wI5wEdS9X/rAuA9Pbb63O3vtRBYYEDvJ0=
X-Received: by 2002:a05:6638:102c:: with SMTP id n12mr1859068jan.218.1643293497579;
 Thu, 27 Jan 2022 06:24:57 -0800 (PST)
MIME-Version: 1.0
References: <20220126171232.2599547-1-jannh@google.com>
In-Reply-To: <20220126171232.2599547-1-jannh@google.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Thu, 27 Jan 2022 15:24:46 +0100
Message-ID: <CA+fCnZf0=RNkR0JnMSq-0xYUDf=rcUk0oMs_ySed6LaZtPAQjQ@mail.gmail.com>
Subject: Re: [PATCH] x86/csum: Add KASAN/KCSAN instrumentation
To:     Jann Horn <jannh@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 6:13 PM Jann Horn <jannh@google.com> wrote:
>
> In the optimized X86 version of the copy-with-checksum helpers, use
> instrument_*() before accessing buffers from assembly code so that KASAN
> and KCSAN don't have blind spots there.
>
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
>  arch/x86/lib/csum-partial_64.c  | 3 +++
>  arch/x86/lib/csum-wrappers_64.c | 9 +++++++++
>  2 files changed, 12 insertions(+)
>
> diff --git a/arch/x86/lib/csum-partial_64.c b/arch/x86/lib/csum-partial_64.c
> index 1f8a8f895173..8b0c353cd212 100644
> --- a/arch/x86/lib/csum-partial_64.c
> +++ b/arch/x86/lib/csum-partial_64.c
> @@ -8,6 +8,7 @@
>
>  #include <linux/compiler.h>
>  #include <linux/export.h>
> +#include <linux/instrumented.h>
>  #include <asm/checksum.h>
>  #include <asm/word-at-a-time.h>
>
> @@ -37,6 +38,8 @@ __wsum csum_partial(const void *buff, int len, __wsum sum)
>         u64 temp64 = (__force u64)sum;
>         unsigned odd, result;
>
> +       instrument_read(buff, len);
> +
>         odd = 1 & (unsigned long) buff;
>         if (unlikely(odd)) {
>                 if (unlikely(len == 0))
> diff --git a/arch/x86/lib/csum-wrappers_64.c b/arch/x86/lib/csum-wrappers_64.c
> index 189344924a2b..087f3c4cb89f 100644
> --- a/arch/x86/lib/csum-wrappers_64.c
> +++ b/arch/x86/lib/csum-wrappers_64.c
> @@ -6,6 +6,8 @@
>   */
>  #include <asm/checksum.h>
>  #include <linux/export.h>
> +#include <linux/in6.h>
> +#include <linux/instrumented.h>
>  #include <linux/uaccess.h>
>  #include <asm/smap.h>
>
> @@ -26,6 +28,7 @@ csum_and_copy_from_user(const void __user *src, void *dst, int len)
>         __wsum sum;
>
>         might_sleep();
> +       instrument_write(dst, len);
>         if (!user_access_begin(src, len))
>                 return 0;
>         sum = csum_partial_copy_generic((__force const void *)src, dst, len);
> @@ -51,6 +54,7 @@ csum_and_copy_to_user(const void *src, void __user *dst, int len)
>         __wsum sum;
>
>         might_sleep();
> +       instrument_read(src, len);
>         if (!user_access_begin(dst, len))
>                 return 0;
>         sum = csum_partial_copy_generic(src, (void __force *)dst, len);
> @@ -71,6 +75,8 @@ EXPORT_SYMBOL(csum_and_copy_to_user);
>  __wsum
>  csum_partial_copy_nocheck(const void *src, void *dst, int len)
>  {
> +       instrument_write(dst, len);
> +       instrument_read(src, len);
>         return csum_partial_copy_generic(src, dst, len);
>  }
>  EXPORT_SYMBOL(csum_partial_copy_nocheck);
> @@ -81,6 +87,9 @@ __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
>  {
>         __u64 rest, sum64;
>
> +       instrument_read(saddr, sizeof(*saddr));
> +       instrument_read(daddr, sizeof(*daddr));
> +
>         rest = (__force __u64)htonl(len) + (__force __u64)htons(proto) +
>                 (__force __u64)sum;
>
>
> base-commit: 0280e3c58f92b2fe0e8fbbdf8d386449168de4a8
> --
> 2.35.0.rc0.227.g00780c9af4-goog
>

Acked-by: Andrey Konovalov <andreyknvl@gmail.com>

It would also be nice to add tests to check these, but since we still
don't have tests that check atomics [1], csum tests can be added
together with them once someone gets to doing that.

Thanks!

[1] https://bugzilla.kernel.org/show_bug.cgi?id=214055
