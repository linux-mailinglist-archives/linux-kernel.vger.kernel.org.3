Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 463C6572762
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 22:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbiGLUgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 16:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiGLUgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 16:36:52 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96710A58D8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 13:36:51 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id n7so9045998ioo.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 13:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y/kf7WpiJhpV7S8Lv6B6nSloUE3ZIK760tIURsCB2pw=;
        b=HK+0DWTz7CWIFl+SYCiY0c1eT23V1rfCJ2QRHvfA8bSUNlP5B7cbxj+fSAo0QWdQZF
         L4916vyqIJ6hBECNHpwM9VpomRkI9oU7ux781zK8Ag6wUNbvi0zH1theP+ClUZe+WfHY
         bB29E+meNCNUo/BX9CrmNicvZbvo7Dsb1noCwXeeg8uBLkIOTzOd2JFGDmLPi5Fxrwdh
         pVPnnhlFhQXWdSntoI9CvaNMVywddCOqtSosLlEXuaU9ngzuYPqFAR4H3H3Z9UHakffi
         K5w8ACxyuEOxAhWUkNEfCxymzEHp020sUAC2tCxdWfJj6r37lwRMsOlfEC07Le2qsU6U
         hBRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y/kf7WpiJhpV7S8Lv6B6nSloUE3ZIK760tIURsCB2pw=;
        b=ZACTWIqoIrGxxCXnE5CO38vmbknvpXVDBoEi7nJNYgOIz8eotO6Q7LbMkdZNgQnhxs
         T8QxO/g95gtjXfCt2cp3UhlSIw0HW7sb3WVEAbibaWn/AWgEWhCiDQhW1suc22XmZwjq
         axGx0j71JXaOp5yrAjk3bnQXfe6g9Hf7FpBYKKd42a8hh+dkhHy3Q8TMOo9MGG/JSpEL
         k19vlZ7FBQwb3TAqzJ4QyK5YDG1alsO8EwrGefKSIwPdYWuFhWhg3n3ac8BUKKiF/Hzk
         ULwEn1uz75vOs4drtjyIBv/jR+TZdZl41Gw1ToqwKCXW+lH63K9g8MFZBJmMTY1FOKbu
         EN5w==
X-Gm-Message-State: AJIora8vGGxaxGLLMCrWzU2NaW4WoYRMtMBYkUdIN2fqR88I3ldPf90Y
        8KthZMgBwyuGJ55BR2djyc689eP9xV+hatYtHYwUfV/R
X-Google-Smtp-Source: AGRyM1vcVt7E6J7CXFHWcDWieOMzcW12/B3aaLXom2LHjUZJ7rjCMBYmaxd73fcDTKZ0bf0NWkgwf+myIsxTC/h2scA=
X-Received: by 2002:a05:6638:3812:b0:33f:4a06:ad48 with SMTP id
 i18-20020a056638381200b0033f4a06ad48mr9488946jav.71.1657658210925; Tue, 12
 Jul 2022 13:36:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220615062219.22618-1-Kuan-Ying.Lee@mediatek.com>
In-Reply-To: <20220615062219.22618-1-Kuan-Ying.Lee@mediatek.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Tue, 12 Jul 2022 22:36:40 +0200
Message-ID: <CA+fCnZc_sqfp4NOZPMWig9t01-yz2HOswoesTVfzGubrvqECDw@mail.gmail.com>
Subject: Re: [PATCH] kasan: separate double free case from invalid free
To:     Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
Cc:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chinwen Chang <chinwen.chang@mediatek.com>,
        =?UTF-8?B?WWVlIExlZSAo5p2O5bu66Kq8KQ==?= <yee.lee@mediatek.com>,
        casper.li@mediatek.com, Andrew Yang <andrew.yang@mediatek.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
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

On Wed, Jun 15, 2022 at 8:22 AM 'Kuan-Ying Lee' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
>
> Currently, KASAN describes all invalid-free/double-free bugs as
> "double-free or invalid-free". This is ambiguous.
>
> KASAN should report "double-free" when a double-free is a more
> likely cause (the address points to the start of an object) and
> report "invalid-free" otherwise [1].
>
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=212193
>
> Signed-off-by: Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
> ---
>  mm/kasan/common.c |  8 ++++----
>  mm/kasan/kasan.h  |  3 ++-
>  mm/kasan/report.c | 12 ++++++++----
>  3 files changed, 14 insertions(+), 9 deletions(-)
>
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index c40c0e7b3b5f..707c3a527fcb 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -343,7 +343,7 @@ static inline bool ____kasan_slab_free(struct kmem_cache *cache, void *object,
>
>         if (unlikely(nearest_obj(cache, virt_to_slab(object), object) !=
>             object)) {
> -               kasan_report_invalid_free(tagged_object, ip);
> +               kasan_report_invalid_free(tagged_object, ip, KASAN_REPORT_INVALID_FREE);
>                 return true;
>         }
>
> @@ -352,7 +352,7 @@ static inline bool ____kasan_slab_free(struct kmem_cache *cache, void *object,
>                 return false;
>
>         if (!kasan_byte_accessible(tagged_object)) {
> -               kasan_report_invalid_free(tagged_object, ip);
> +               kasan_report_invalid_free(tagged_object, ip, KASAN_REPORT_DOUBLE_FREE);
>                 return true;
>         }
>
> @@ -377,12 +377,12 @@ bool __kasan_slab_free(struct kmem_cache *cache, void *object,
>  static inline bool ____kasan_kfree_large(void *ptr, unsigned long ip)
>  {
>         if (ptr != page_address(virt_to_head_page(ptr))) {
> -               kasan_report_invalid_free(ptr, ip);
> +               kasan_report_invalid_free(ptr, ip, KASAN_REPORT_INVALID_FREE);
>                 return true;
>         }
>
>         if (!kasan_byte_accessible(ptr)) {
> -               kasan_report_invalid_free(ptr, ip);
> +               kasan_report_invalid_free(ptr, ip, KASAN_REPORT_DOUBLE_FREE);
>                 return true;
>         }
>
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index 610d60d6e5b8..01c03e45acd4 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -125,6 +125,7 @@ static inline bool kasan_sync_fault_possible(void)
>  enum kasan_report_type {
>         KASAN_REPORT_ACCESS,
>         KASAN_REPORT_INVALID_FREE,
> +       KASAN_REPORT_DOUBLE_FREE,
>  };
>
>  struct kasan_report_info {
> @@ -277,7 +278,7 @@ static inline void kasan_print_address_stack_frame(const void *addr) { }
>
>  bool kasan_report(unsigned long addr, size_t size,
>                 bool is_write, unsigned long ip);
> -void kasan_report_invalid_free(void *object, unsigned long ip);
> +void kasan_report_invalid_free(void *object, unsigned long ip, enum kasan_report_type type);
>
>  struct page *kasan_addr_to_page(const void *addr);
>  struct slab *kasan_addr_to_slab(const void *addr);
> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> index b341a191651d..fe3f606b3a98 100644
> --- a/mm/kasan/report.c
> +++ b/mm/kasan/report.c
> @@ -176,8 +176,12 @@ static void end_report(unsigned long *flags, void *addr)
>  static void print_error_description(struct kasan_report_info *info)
>  {
>         if (info->type == KASAN_REPORT_INVALID_FREE) {
> -               pr_err("BUG: KASAN: double-free or invalid-free in %pS\n",
> -                      (void *)info->ip);
> +               pr_err("BUG: KASAN: invalid-free in %pS\n", (void *)info->ip);
> +               return;
> +       }
> +
> +       if (info->type == KASAN_REPORT_DOUBLE_FREE) {
> +               pr_err("BUG: KASAN: double-free in %pS\n", (void *)info->ip);
>                 return;
>         }
>
> @@ -433,7 +437,7 @@ static void print_report(struct kasan_report_info *info)
>         }
>  }
>
> -void kasan_report_invalid_free(void *ptr, unsigned long ip)
> +void kasan_report_invalid_free(void *ptr, unsigned long ip, enum kasan_report_type type)
>  {
>         unsigned long flags;
>         struct kasan_report_info info;
> @@ -448,7 +452,7 @@ void kasan_report_invalid_free(void *ptr, unsigned long ip)
>
>         start_report(&flags, true);
>
> -       info.type = KASAN_REPORT_INVALID_FREE;
> +       info.type = type;
>         info.access_addr = ptr;
>         info.first_bad_addr = kasan_reset_tag(ptr);
>         info.access_size = 0;
> --
> 2.18.0

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>

Thanks for the patch!
