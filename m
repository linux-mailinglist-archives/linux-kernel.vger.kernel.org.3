Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B127A571C30
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 16:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233537AbiGLOSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 10:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiGLORr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 10:17:47 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF599D519
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 07:17:46 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id g4so14149768ybg.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 07:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0beGq21p9DMXHd5s7bgYgiKqbqbtLOLYpdLEVtFVxzo=;
        b=KBfwn0NWRdjlAlnm78kQy8tetaYreiz77Y8pUuEWWPugZUbjxhRgenJK2m1SIRjBig
         WMpwQ5rhXusyEyDymAjbbkawtqCvFm7xCLlF24E/B+FQliXAm1mJ77+1o4i237SN+NMN
         Hx5kOvVfRfNj30L4FQMs8HZogW1F2ihS9IueY+v3NX5G9p0aa44btudBP14q3xqsSzph
         IOrltwO6HwRBj4o/XG4KdQQ2/LOdOyG8sjW56dapWE/365fz6RBtrO1aaLpIiNRs7Gif
         BBkEQanbqIrKeVJSno+7AsR2RNBYnu+6Mhg+P7/4kVSIt9CQuQnT5CAXTAx/Y5e5kKGN
         abpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0beGq21p9DMXHd5s7bgYgiKqbqbtLOLYpdLEVtFVxzo=;
        b=aQ+UIUCmVN+M9yLaOGHAwFYiFwq8yc2XXz8WRr/sg8gwIyc2kpA1tOOk5P091pCHFX
         QFCQPGyXYORdhRXBg17RISQeD8TXIuLIyT3ANsuPmwJrKZQ9BZvThspvPgY8TAtee2zd
         i/GHxKbCtGichz1Q9AhTvTtCwrdrIp36t0YoBvpafaHa0kCUL+BB1lfLjUpBtvCtTkRO
         A8/7iH9AvEcvjgAWNXoS4SpUYVr6+1+OYI76NZQadkmjlCQMB/F5IyiD4IslBdE1VhBX
         0YOKeoR6AI6x5+Q1ctBFNIi1hI+49ym/j9HNwzkbh1O2wCp32S+3ZKT4d365/MnHIJnW
         qHsg==
X-Gm-Message-State: AJIora9SJFiUB8Hq3X3RZfxJ9O73KvOQij2rx1IYDjUxB+/GAux5B/jU
        nz3IvC1lFOGoxTtcQsmf9DwqrJgO/fFyzMjxzgN87g==
X-Google-Smtp-Source: AGRyM1uNJbYAzJEiHCz+WeojPCu0/5uwt/JdhiaRhEpRyhDjN0kKwSV2YWGVhXee1UxvoNMcsabuiAL8+o0CcFARhhk=
X-Received: by 2002:a25:2d59:0:b0:66e:32d3:7653 with SMTP id
 s25-20020a252d59000000b0066e32d37653mr22600223ybe.625.1657635465536; Tue, 12
 Jul 2022 07:17:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220701142310.2188015-1-glider@google.com> <20220701142310.2188015-6-glider@google.com>
In-Reply-To: <20220701142310.2188015-6-glider@google.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 12 Jul 2022 16:17:09 +0200
Message-ID: <CANpmjNM-hotpgDZqHvutHedoEbyeuuNeoPQ5UR4Op8rs6itr3g@mail.gmail.com>
Subject: Re: [PATCH v4 05/45] asm-generic: instrument usercopy in cacheflush.h
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Jul 2022 at 16:23, Alexander Potapenko <glider@google.com> wrote:
>
> Notify memory tools about usercopy events in copy_to_user_page() and
> copy_from_user_page().
>
> Signed-off-by: Alexander Potapenko <glider@google.com>

Reviewed-by: Marco Elver <elver@google.com>


> ---
> Link: https://linux-review.googlesource.com/id/Ic1ee8da1886325f46ad67f52176f48c2c836c48f
> ---
>  include/asm-generic/cacheflush.h | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/include/asm-generic/cacheflush.h b/include/asm-generic/cacheflush.h
> index 4f07afacbc239..0f63eb325025f 100644
> --- a/include/asm-generic/cacheflush.h
> +++ b/include/asm-generic/cacheflush.h
> @@ -2,6 +2,8 @@
>  #ifndef _ASM_GENERIC_CACHEFLUSH_H
>  #define _ASM_GENERIC_CACHEFLUSH_H
>
> +#include <linux/instrumented.h>
> +
>  struct mm_struct;
>  struct vm_area_struct;
>  struct page;
> @@ -105,6 +107,7 @@ static inline void flush_cache_vunmap(unsigned long start, unsigned long end)
>  #ifndef copy_to_user_page
>  #define copy_to_user_page(vma, page, vaddr, dst, src, len)     \
>         do { \
> +               instrument_copy_to_user(dst, src, len); \
>                 memcpy(dst, src, len); \
>                 flush_icache_user_page(vma, page, vaddr, len); \
>         } while (0)
> @@ -112,7 +115,11 @@ static inline void flush_cache_vunmap(unsigned long start, unsigned long end)
>
>  #ifndef copy_from_user_page
>  #define copy_from_user_page(vma, page, vaddr, dst, src, len) \
> -       memcpy(dst, src, len)
> +       do { \
> +               instrument_copy_from_user_before(dst, src, len); \
> +               memcpy(dst, src, len); \
> +               instrument_copy_from_user_after(dst, src, len, 0); \
> +       } while (0)
>  #endif
>
>  #endif /* _ASM_GENERIC_CACHEFLUSH_H */
> --
> 2.37.0.rc0.161.g10f37bed90-goog
>
