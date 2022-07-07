Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 845FA569F45
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 12:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235240AbiGGKN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 06:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235161AbiGGKNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 06:13:55 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE1B4F1B4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 03:13:53 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-31cf1adbf92so38384157b3.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 03:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kPWo2TmGl+9OHVe70g4XsibJyi/n5Q+LOKMuqK03HYA=;
        b=NQ9bRvc9vYE+J89XD7PO1q7mkA13sA71QpWW5mmA90B7A5ldxeO5Pue7F+raM4qwVK
         7PTHolsnOA/QyktohmZhPj4QG3UIvIpNp6w9MLNizTeJjag2aCzvouMmjQ9Dozewakdc
         p4i/vm4y5Nmon2hCM/O7ALNrjqnKceKFdes1VyKc/SalQalLTfdWnmAh7Vwzs1r7ruCh
         OUfVLilKCmffj87sOoCilovelYVOLN3BusHLwHcUPsRgZhy97AzywVaFtQwi1DidwQIA
         X12W1N7SYNR1CXBtk3ROP3Pi0XB9JcdnT6cLBwsgEJdcJY7RXrVrnlkBNVXz8wM9DCz5
         jhBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kPWo2TmGl+9OHVe70g4XsibJyi/n5Q+LOKMuqK03HYA=;
        b=4fOTzNoi38PANYOyNodk3mngh0tcgsXSEU4/Siol6s4+m0LiYSvN7dGC7tud+vgrsr
         teP95TC7NddKSpSamCbjbTV4CdrbOl60Gy4ljFMG3mwwfLf8MuWH2fktkRoDpTuhSktV
         WswI01Gre69FFtOt5uwj+hWmNYjqaLz0cpx/+R9S/1a669mk7Iw3LmpvNnDTGXD2HWqA
         aGRe5ithVk3QVApMojkeUbdVUiWjgxl6YjlSFpz1JEh0QwagFvsxqbfD+8w1i5vMQEv0
         /4ELyFPeOSohhI9EQLdAOG+PNX8jmI02YB0kXBeBmZ6Nt8Rq41g2qM9TcKMu4GaBOTol
         zjSQ==
X-Gm-Message-State: AJIora8O+YJZyPBV5JmL6cGL7iwP2/sn53sI4sgklPr3JSu6QfVDiF8D
        6SrABCz08z4f8G3FHd07n+3MNGF+xhk84DMFT5IjMA==
X-Google-Smtp-Source: AGRyM1vadqM77gQ/U73N1rxYJChYky+4QRezCslan02cQ8qsw+iLZ89lKnRN4bUYz8lDps/Q7HOvTFEAYhyq8/bzdD0=
X-Received: by 2002:a81:e17:0:b0:31c:a24c:9ee6 with SMTP id
 23-20020a810e17000000b0031ca24c9ee6mr21067667ywo.362.1657188832898; Thu, 07
 Jul 2022 03:13:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220701142310.2188015-1-glider@google.com> <20220701142310.2188015-5-glider@google.com>
In-Reply-To: <20220701142310.2188015-5-glider@google.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 7 Jul 2022 12:13:17 +0200
Message-ID: <CANpmjNN28k3B1-nX=gtdJxZ4MS=bF+CuPG1EFp5fC2TDQUU=4Q@mail.gmail.com>
Subject: Re: [PATCH v4 04/45] x86: asm: instrument usercopy in get_user() and __put_user_size()
To:     Alexander Potapenko <glider@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Jul 2022 at 16:23, Alexander Potapenko <glider@google.com> wrote:
>
> Use hooks from instrumented.h to notify bug detection tools about
> usercopy events in get_user() and put_user_size().
>
> It's still unclear how to instrument put_user(), which assumes that
> instrumentation code doesn't clobber RAX.

do_put_user_call() has a comment about KASAN clobbering %ax, doesn't
this also apply to KMSAN? If not, could we have a <asm/instrumented.h>
that provides helpers to push registers on the stack and pop them back
on return?

Also it seems the test robot complained about this patch.

> Signed-off-by: Alexander Potapenko <glider@google.com>
> ---
> Link: https://linux-review.googlesource.com/id/Ia9f12bfe5832623250e20f1859fdf5cc485a2fce
> ---
>  arch/x86/include/asm/uaccess.h | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
> index 913e593a3b45f..1a8b5a234474f 100644
> --- a/arch/x86/include/asm/uaccess.h
> +++ b/arch/x86/include/asm/uaccess.h
> @@ -5,6 +5,7 @@
>   * User space memory access functions
>   */
>  #include <linux/compiler.h>
> +#include <linux/instrumented.h>
>  #include <linux/kasan-checks.h>
>  #include <linux/string.h>
>  #include <asm/asm.h>
> @@ -99,11 +100,13 @@ extern int __get_user_bad(void);
>         int __ret_gu;                                                   \
>         register __inttype(*(ptr)) __val_gu asm("%"_ASM_DX);            \
>         __chk_user_ptr(ptr);                                            \
> +       instrument_copy_from_user_before((void *)&(x), ptr, sizeof(*(ptr))); \
>         asm volatile("call __" #fn "_%P4"                               \
>                      : "=a" (__ret_gu), "=r" (__val_gu),                \
>                         ASM_CALL_CONSTRAINT                             \
>                      : "0" (ptr), "i" (sizeof(*(ptr))));                \
>         (x) = (__force __typeof__(*(ptr))) __val_gu;                    \
> +       instrument_copy_from_user_after((void *)&(x), ptr, sizeof(*(ptr)), 0); \
>         __builtin_expect(__ret_gu, 0);                                  \
>  })
>
> @@ -248,7 +251,9 @@ extern void __put_user_nocheck_8(void);
>
>  #define __put_user_size(x, ptr, size, label)                           \
>  do {                                                                   \
> +       __typeof__(*(ptr)) __pus_val = x;                               \
>         __chk_user_ptr(ptr);                                            \
> +       instrument_copy_to_user(ptr, &(__pus_val), size);               \
>         switch (size) {                                                 \
>         case 1:                                                         \
>                 __put_user_goto(x, ptr, "b", "iq", label);              \
> @@ -286,6 +291,7 @@ do {                                                                        \
>  #define __get_user_size(x, ptr, size, label)                           \
>  do {                                                                   \
>         __chk_user_ptr(ptr);                                            \
> +       instrument_copy_from_user_before((void *)&(x), ptr, size);      \
>         switch (size) {                                                 \
>         case 1: {                                                       \
>                 unsigned char x_u8__;                                   \
> @@ -305,6 +311,7 @@ do {                                                                        \
>         default:                                                        \
>                 (x) = __get_user_bad();                                 \
>         }                                                               \
> +       instrument_copy_from_user_after((void *)&(x), ptr, size, 0);    \
>  } while (0)
>
>  #define __get_user_asm(x, addr, itype, ltype, label)                   \
> --
> 2.37.0.rc0.161.g10f37bed90-goog
>
