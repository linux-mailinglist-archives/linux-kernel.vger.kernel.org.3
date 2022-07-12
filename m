Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13E125719C8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 14:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232520AbiGLMV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 08:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232278AbiGLMVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 08:21:22 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70BEF6D549
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 05:21:21 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-31d7db3e6e5so48327207b3.11
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 05:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UaSHri8uX8QzRonJXk/9Ev1ksxotFizg9AxbyPG4jRk=;
        b=AdA9qT8whnij0+KR+xYBYzsjojFQe6acCMTqkTici9ybil/uXKlgNpGU4ccpVCEIhz
         9lstl2oAgiyy3zfDj8omvZMXE2HfC9BztuasX9rV3FAtelrWEST4nMElNJrEIUbHg6xz
         vLBb8YSGSfV6wwGP//JqkXtQWBzWnS6IQnt0H/AhukwKmCy+De2sO+LsQj6CPfc47DEP
         GPy1Qc9iOVk/8rq20s4g9LqjTdYELDMJmbd3WnYzVj9FTIda6MtL0VuZXtIj4K0Lxzhq
         mXgFDNw0qg6K2V5/KOq8itfFBvS3GWdiVr7JMEdKlZRGv/i9f+m7rMBo/pDfaPsFN5yP
         NkQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UaSHri8uX8QzRonJXk/9Ev1ksxotFizg9AxbyPG4jRk=;
        b=HkCqm5owuBKLUCAbb4kngmnvV4P9IiVXVGFkX1Br6d0Fqc8ORrEOk6LjfIn4AW2BFI
         DwS0F2phDx6fIMvwQIL1gRPI9pF984OnU5Bee8RWncZj9j9O+wDZVc3RB+/6sMQtOQsZ
         nURzFzvfBjcApf/NifrPioMcUL/VU01KHKMYx0KQ7Vjv8qc4zxeU/akQrAMBZGckmPba
         DdaJaGha1oqEWF3lSYgKYpmu/nvgltRotSsDeTiytpwM0UiMB1kDeef3o7eRYoOQvtam
         7+aqXquqgyBCiwVvR3Hcvl1FIlUL60066W0X4T464K9kStFsabA7NhP6BrSSu39u6haG
         yMMQ==
X-Gm-Message-State: AJIora/46TzrRTbIC6bE+BiyDqtPGwY86LJulYNypDGpp8vJnE6CMoHz
        ytvwUe+ClLedocRBQ+nQ+UwvK6Yf5M4BZJLSb+uwQg==
X-Google-Smtp-Source: AGRyM1tNTqqD1WJS4VX6QxCOJmIA4NZigO0ohBTbUAMEjXFjLnHlS2MHRgJF6cAyN0c2yj/38K4PnLL3yJAEs4Jhs+g=
X-Received: by 2002:a81:1492:0:b0:31c:a1ff:9ec with SMTP id
 140-20020a811492000000b0031ca1ff09ecmr23857082ywu.327.1657628480468; Tue, 12
 Jul 2022 05:21:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220701142310.2188015-1-glider@google.com> <20220701142310.2188015-15-glider@google.com>
In-Reply-To: <20220701142310.2188015-15-glider@google.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 12 Jul 2022 14:20:44 +0200
Message-ID: <CANpmjNP8kmZYRsdpHCni33W-Yjgy-ajCAuTE94zwUniyYt7WQw@mail.gmail.com>
Subject: Re: [PATCH v4 14/45] mm: kmsan: maintain KMSAN metadata for page operations
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
> Insert KMSAN hooks that make the necessary bookkeeping changes:
>  - poison page shadow and origins in alloc_pages()/free_page();
>  - clear page shadow and origins in clear_page(), copy_user_highpage();
>  - copy page metadata in copy_highpage(), wp_page_copy();
>  - handle vmap()/vunmap()/iounmap();
>
> Signed-off-by: Alexander Potapenko <glider@google.com>
> ---
> v2:
>  -- move page metadata hooks implementation here
>  -- remove call to kmsan_memblock_free_pages()
>
> v3:
>  -- use PAGE_SHIFT in kmsan_ioremap_page_range()
>
> v4:
>  -- change sizeof(type) to sizeof(*ptr)
>  -- replace occurrences of |var| with @var
>  -- swap mm: and kmsan: in the subject
>  -- drop __no_sanitize_memory from clear_page()
>
> Link: https://linux-review.googlesource.com/id/I6d4f53a0e7eab46fa29f0348f3095d9f2e326850
> ---
>  arch/x86/include/asm/page_64.h |  12 ++++
>  arch/x86/mm/ioremap.c          |   3 +
>  include/linux/highmem.h        |   3 +
>  include/linux/kmsan.h          | 123 +++++++++++++++++++++++++++++++++
>  mm/internal.h                  |   6 ++
>  mm/kmsan/hooks.c               |  87 +++++++++++++++++++++++
>  mm/kmsan/shadow.c              | 114 ++++++++++++++++++++++++++++++
>  mm/memory.c                    |   2 +
>  mm/page_alloc.c                |  11 +++
>  mm/vmalloc.c                   |  20 +++++-
>  10 files changed, 379 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/include/asm/page_64.h b/arch/x86/include/asm/page_64.h
> index baa70451b8df5..227dd33eb4efb 100644
> --- a/arch/x86/include/asm/page_64.h
> +++ b/arch/x86/include/asm/page_64.h
> @@ -45,14 +45,26 @@ void clear_page_orig(void *page);
>  void clear_page_rep(void *page);
>  void clear_page_erms(void *page);
>
> +/* This is an assembly header, avoid including too much of kmsan.h */

All of this code is under an "#ifndef __ASSEMBLY__" guard, does it matter?

> +#ifdef CONFIG_KMSAN
> +void kmsan_unpoison_memory(const void *addr, size_t size);
> +#endif
>  static inline void clear_page(void *page)
>  {
> +#ifdef CONFIG_KMSAN
> +       /* alternative_call_2() changes @page. */
> +       void *page_copy = page;
> +#endif
>         alternative_call_2(clear_page_orig,
>                            clear_page_rep, X86_FEATURE_REP_GOOD,
>                            clear_page_erms, X86_FEATURE_ERMS,
>                            "=D" (page),
>                            "0" (page)
>                            : "cc", "memory", "rax", "rcx");
> +#ifdef CONFIG_KMSAN
> +       /* Clear KMSAN shadow for the pages that have it. */
> +       kmsan_unpoison_memory(page_copy, PAGE_SIZE);

What happens if this is called before the alternative-call? Could this
(in the interest of simplicity) be moved above it? And if you used the
kmsan-checks.h header, it also doesn't need any "ifdef CONFIG_KMSAN"
anymore.

> +#endif
>  }
