Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B228B49F3CA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 07:45:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346565AbiA1GpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 01:45:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233328AbiA1GpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 01:45:03 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C6FBC061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 22:45:03 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id g15-20020a9d6b0f000000b005a062b0dc12so4873264otp.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 22:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9Xk+4cliWQ8pKs4/H9QbNIvJzjxoe0JvtSnu86eAs+0=;
        b=sIvai0pLLwJ9w4NB1MoADJyrAGiPV0/20B6pBBp7Ff+aX15M7nHLfTxFwVhjhtonYU
         TbNxZSQ8CZJ1+YdNgCmymBIKbdZcJsXjpnLPRJ/pIzo0BsnIw4C0L8SGuJufIL3ln6xv
         IkXdIfatAe6ivIBV2fmOvyXTz7BRUSHKSbiHx4Pu4y2kH3DU32t2jIhJjgAvxdpvMt7s
         7gPJnjKmZA9hTSIWopMqc84wJzJEnMbTjqVrgCjfNULZ5qws0UHG9gfueX/MSbbqUjkB
         N39srS8ePQl44gORjhNbPhj6Twgwb46yJj1UwrFJkT2in4B8xN/YsGmfau3La1aL7dCH
         Vx3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9Xk+4cliWQ8pKs4/H9QbNIvJzjxoe0JvtSnu86eAs+0=;
        b=XX2y32Zgipb/KRyU4yk/DEZnITDmr0PoscWYTJlQwtCc5mkyhHvdcaIhLWIw26QiqF
         9L9xeHhkMgQ8J5M/Y2mhguRVFRZO3OVfjpXeH46ePDy6OCDcYh+132HG7GE3ZrBLYaPL
         ASnB6bpZ5Wf9UczaeyhSE7/OJYloNcZlrLJezlU8lIBToET7lPT3N44LH+7bGt00BWzN
         Xr8/C9+rXnHctJpwueHkiYMZOtJQmxVXBZnnp3rmcan9ZRR2Df7jB4yuTw4d2b5VD6Qz
         /pKs6NbCz5uiu1XXaHezPCADbTZem5qMNlx0vQVvzV0ANeYhWavlDjwQpw37irFl/h6N
         S88g==
X-Gm-Message-State: AOAM530AKsJMArMYVpfz7STkjHmWIv8e9umvkyg3ILlf01/sweQbWe0A
        KKjWCjzSrNL6BETnDHrnduwgdNXPCwMc1EwUwdILkQ==
X-Google-Smtp-Source: ABdhPJxhCLiJ7LbyK5GGviBZBgWC0bU3tqekXzNeyiuQJzIua7JBV+3R5GRhCZz+4IIwXzMzdThiZYwhgLoYI0niSfs=
X-Received: by 2002:a9d:6319:: with SMTP id q25mr3982948otk.137.1643352302180;
 Thu, 27 Jan 2022 22:45:02 -0800 (PST)
MIME-Version: 1.0
References: <20220128000752.2322591-1-jannh@google.com>
In-Reply-To: <20220128000752.2322591-1-jannh@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 28 Jan 2022 07:44:50 +0100
Message-ID: <CACT4Y+aF7xQiPCxN8YsqsYWwotyWr+hy-F+OiBPSFDJ0EswN1A@mail.gmail.com>
Subject: Re: [PATCH v2] x86/csum: Add KASAN/KCSAN instrumentation
To:     Jann Horn <jannh@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        kasan-dev@googlegroups.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jan 2022 at 01:08, Jann Horn <jannh@google.com> wrote:
>
> In the optimized X86 version of the copy-with-checksum helpers, use
> instrument_*() before accessing buffers from assembly code so that KASAN
> and KCSAN don't have blind spots there.
>
> Signed-off-by: Jann Horn <jannh@google.com>

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>

Thanks

> ---
>
> Notes:
>     v2: use instrument_copy_{from,to}_user instead of instrument_{read,write}
>         where appropriate (dvyukov)
>
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
> index 189344924a2b..c44973b8f255 100644
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
> +       instrument_copy_from_user(dst, src, len);
>         if (!user_access_begin(src, len))
>                 return 0;
>         sum = csum_partial_copy_generic((__force const void *)src, dst, len);
> @@ -51,6 +54,7 @@ csum_and_copy_to_user(const void *src, void __user *dst, int len)
>         __wsum sum;
>
>         might_sleep();
> +       instrument_copy_to_user(dst, src, len);
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
