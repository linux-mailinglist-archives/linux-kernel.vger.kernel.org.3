Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6472D49D0E7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 18:38:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243815AbiAZRiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 12:38:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237187AbiAZRh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 12:37:59 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0096C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 09:37:59 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id p203so933725oih.10
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 09:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iIrTw8i7dKztJOX/sYlGyAZ9lt8KfEmb4oiF+8tim90=;
        b=GXosuorlsbZSTIoLqTJ4aqraR5B8WtUPyB5p87RdoBP61dZzQKC0zJr3OMeiK5szNj
         lXN9+e5GHcxYywns2WP460nGiiedXxfwSVbhPBBN0eRpMUaEa1BOJY5wEfMLLp34Cu4h
         Dr50+YRbX5x1caRr39l1cBDuwN5MZ7y3mXEPfdErU0NALB6zakq+WFlF5IHr6aOk2ZhE
         l9ywokSaDxf28UoytCSXCV8+VK0P9YI/a+6XLMWJR9jot31ZYtlDuC8H+agXxYTaVE8t
         1QNSvrG7uYWzMaTLnsjPjOhXX5TwO6/vS+daX9fc+ONDxzGsgJvan+Kgq7OrmCRWODzb
         Slaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iIrTw8i7dKztJOX/sYlGyAZ9lt8KfEmb4oiF+8tim90=;
        b=AyKd5UcnqTL5XsWYdng+cz7wVjt+RTJcJ5uvhzt7CyuJTpVS5u7xuemAyw3xp7nsdv
         hPynUQopJ+IhRl9xkcJNufje/Ou56buKsEuzOM1Hvs23PuWFXmJVOvZ5bsCEY3t47V0O
         SNtsL3GqNGQx1b+t23eXJR3C0egS2EG5wUGgASH7T53jfDtWJ2xn+iBo7DL5UDS+7k8B
         gSHvCOrkqEDnL1IKO8PWfwwtMhONHZ0UK4J/C80nw5t8j8Zmr48ccT1o0YRBaDZVPIxa
         lyC4mfCrtnSe1umg8rMj9kKgzHwwO7xxm2dxDhlXEAM7czGhU//gM8TJ3uOVLcJgaqYD
         mZ2g==
X-Gm-Message-State: AOAM530JtMaj4stLod5xD8rirn6uI4KC/uc4/ZQzaMUQ0DqIjLftVHTb
        jQtiQDmksjMENXdXyf/p+cXYZGOZq8s7aSOMy4WN7A==
X-Google-Smtp-Source: ABdhPJxL+s8xP2UB0OAaXblsCrk/yP27ckjHdQwsZR2/KTe5QuygQoesjEJtKZVX544PWYOZPkucv33XqgqlhO63lFY=
X-Received: by 2002:a05:6808:152b:: with SMTP id u43mr4233444oiw.307.1643218678694;
 Wed, 26 Jan 2022 09:37:58 -0800 (PST)
MIME-Version: 1.0
References: <20220126171232.2599547-1-jannh@google.com>
In-Reply-To: <20220126171232.2599547-1-jannh@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 26 Jan 2022 18:37:47 +0100
Message-ID: <CACT4Y+b8ty07hAANzktksbbe5HdDM=jm6TSYLKawctpBmPfatw@mail.gmail.com>
Subject: Re: [PATCH] x86/csum: Add KASAN/KCSAN instrumentation
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

On Wed, 26 Jan 2022 at 18:13, Jann Horn <jannh@google.com> wrote:
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

Nice!

Can these potentially be called with KERNEL_DS as in some compat
syscalls? If so it's better to use instrument_copy_to/from_user.
Or probably it's better to use them anyway b/c we also want to know
about user accesses for uaccess logging and maybe other things.



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
