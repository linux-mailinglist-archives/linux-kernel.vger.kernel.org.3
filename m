Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11708473447
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 19:45:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241976AbhLMSp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 13:45:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234611AbhLMSp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 13:45:26 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F39AC06173F
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 10:45:26 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id d10so40739295ybn.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 10:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cz/oV6rucbFXxpVSl31hZc9OC3uLAvr6D9l8ggAwmMM=;
        b=g0s4+FNsRzHTIFMgfuac332mUINiKCGVCRW75S/B9HApUnl7HQvHB5fezY8zOE2JFi
         Oj106DoyqWG5jcPhpxbKZQvZ+o7TBuTIJyHTewsQw8A4DcVUrURhF82qDxKfQV5JrytE
         vJFgIrWjOk88LG6r7UOnZj/jM3Vw4+D4ltN7rDoR94ejEmi82Ihqk+RQTa26n91RQPSA
         3t5Uuxb+Q/qE42HGXvuntmAQfHTlso8gANDwEz8D9YitQb138N4jwxxCQTZWmaSaxNpw
         j3USbsUREPCbmoai4VhuyTpunyFz+eTZ3SGX0AZEG/w+cStqpxwjSAGYa2NcpLAqwMwH
         IkGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cz/oV6rucbFXxpVSl31hZc9OC3uLAvr6D9l8ggAwmMM=;
        b=Cf//SDfAH1FCahMK+CxhPccBi1BxdEKJi9DpX5Indygb7tf4xb9aIac+/7NBMDZar7
         rMbYlXmX9jvt/TwNzEc/pHLV7ec/9E2aL31oqJKVmcA8rC/1ZxeSqmLRq0wxSoXJJGyg
         E8fW721JAat6vt1YtubaSB7flzOVNoeW534Z9kQ/AUCFKS9sFsSVuuwidz2P6EtaMffD
         v7mj/telBlTFh2Y+J6jqMQCg65hJtxKmlTC0JM/MR7o8I01hVl0LeGbfodJ39bK4clDt
         vlobTeuu5ZXtYo+LTB0PVn1aD8bo2/N+SmGzeQV1fSbonomPBVS24hjbg37tuXMUQWnq
         24yw==
X-Gm-Message-State: AOAM532qDuSBglgRwFsgp4MMc0vcxjoZ1OGWFsGjUtVxK4lKcU3TIhNC
        Ig21ImvxWA9/7IInK/cWIf+5mPLLqNv/peRJSu/m8A==
X-Google-Smtp-Source: ABdhPJwjCXDEoY7SsfAHxNtNDcS3iz7wdnHdybiyBTgskB0tF4HTH1L9nNXr+l8tERRSjW16SIf8IVVjE2IzldK3F9M=
X-Received: by 2002:a05:6902:1025:: with SMTP id x5mr361655ybt.156.1639421125202;
 Mon, 13 Dec 2021 10:45:25 -0800 (PST)
MIME-Version: 1.0
References: <f1cd1a19878248f09e2e7cffe88c8191@AcuMS.aculab.com>
In-Reply-To: <f1cd1a19878248f09e2e7cffe88c8191@AcuMS.aculab.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Mon, 13 Dec 2021 10:45:13 -0800
Message-ID: <CANn89i+FCddAJSAY1pj3kEDcP5wMnuQFVCa5ZbJwi1GqJ89Hkg@mail.gmail.com>
Subject: Re: [PATCH] lib/x86: Optimise csum_partial of buffers that are not
 multiples of 8 bytes.
To:     David Laight <David.Laight@aculab.com>
Cc:     Noah Goldstein <goldstein.w.n@gmail.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "alexanderduyck@fb.com" <alexanderduyck@fb.com>,
        open list <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 10:00 AM David Laight <David.Laight@aculab.com> wrote:
>
>
> Add in the trailing bytes first so that there is no need to worry
> about the sum exceeding 64 bits.
>
> Signed-off-by: David Laight <david.laight@aculab.com>
> ---
>
> This ought to be faster - because of all the removed 'adc $0'.
> Guessing how fast x86 code will run is hard!
> There are other ways of handing buffers that are shorter than 8 bytes,
> but I'd rather hope they don't happen in any hot paths.
>
> Note - I've not even compile tested it.
> (But have tested an equivalent change before.)
>
>  arch/x86/lib/csum-partial_64.c | 55 ++++++++++++----------------------
>  1 file changed, 19 insertions(+), 36 deletions(-)
>
> diff --git a/arch/x86/lib/csum-partial_64.c b/arch/x86/lib/csum-partial_64.c
> index abf819dd8525..fbcc073fc2b5 100644
> --- a/arch/x86/lib/csum-partial_64.c
> +++ b/arch/x86/lib/csum-partial_64.c
> @@ -37,6 +37,24 @@ __wsum csum_partial(const void *buff, int len, __wsum sum)
>         u64 temp64 = (__force u64)sum;
>         unsigned result;
>
> +       if (len & 7) {
> +               if (unlikely(len < 8)) {
> +                       /* Avoid falling off the start of the buffer */
> +                       if (len & 4) {
> +                               temp64 += *(u32 *)buff;
> +                               buff += 4;
> +                       }
> +                       if (len & 2) {
> +                               temp64 += *(u16 *)buff;
> +                               buff += 2;
> +                       }
> +                       if (len & 1)
> +                               temp64 += *(u8 *)buff;
> +                       goto reduce_to32;
> +               }
> +               temp64 += *(u64 *)(buff + len - 8) << (8 - (len & 7)) * 8;

This is reading far away (end of buffer).

Maybe instead read the first bytes and adjust @buff, to allow for
better hardware prefetching ?



> +       }
> +
>         while (unlikely(len >= 64)) {
>                 asm("addq 0*8(%[src]),%[res]\n\t"
>                     "adcq 1*8(%[src]),%[res]\n\t"
> @@ -82,43 +100,8 @@ __wsum csum_partial(const void *buff, int len, __wsum sum)
>                         : "memory");
>                 buff += 8;
>         }
> -       if (len & 7) {
> -#ifdef CONFIG_DCACHE_WORD_ACCESS
> -               unsigned int shift = (8 - (len & 7)) * 8;
> -               unsigned long trail;
> -
> -               trail = (load_unaligned_zeropad(buff) << shift) >> shift;
>
> -               asm("addq %[trail],%[res]\n\t"
> -                   "adcq $0,%[res]"
> -                       : [res] "+r" (temp64)
> -                       : [trail] "r" (trail));
> -#else
> -               if (len & 4) {
> -                       asm("addq %[val],%[res]\n\t"
> -                           "adcq $0,%[res]"
> -                               : [res] "+r" (temp64)
> -                               : [val] "r" ((u64)*(u32 *)buff)
> -                               : "memory");
> -                       buff += 4;
> -               }
> -               if (len & 2) {
> -                       asm("addq %[val],%[res]\n\t"
> -                           "adcq $0,%[res]"
> -                               : [res] "+r" (temp64)
> -                               : [val] "r" ((u64)*(u16 *)buff)
> -                               : "memory");
> -                       buff += 2;
> -               }
> -               if (len & 1) {
> -                       asm("addq %[val],%[res]\n\t"
> -                           "adcq $0,%[res]"
> -                               : [res] "+r" (temp64)
> -                               : [val] "r" ((u64)*(u8 *)buff)
> -                               : "memory");
> -               }
> -#endif
> -       }
> +reduce_to32:
>         result = add32_with_carry(temp64 >> 32, temp64 & 0xffffffff);
>         return (__force __wsum)result;
>  }
> --
> 2.17.1
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
