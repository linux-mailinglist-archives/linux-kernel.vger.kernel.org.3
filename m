Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 810AE564EF5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 09:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbiGDHqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 03:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbiGDHqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 03:46:19 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF31E65DA
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 00:46:17 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id f39so14378472lfv.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 00:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EpLsmKlpKCiUIDe9SFr1Z71rXe3WR1MDQEjPMDRMDOU=;
        b=c9TZYYVaWzhGJ6mrcpbLMY00AjoFY9dgMyjx9bilb0BXIcId4yURXxfKA6oYWGtz01
         PmSJnerb5jj8N+cjnRHPAfsGOfnvxBLsgTFG4mwnDA08+SCbtBP5UTHhUmDhmDewMW2Q
         RwSxPmhBuD8ddkrqYE3qsB6tbUwY0tApCJPYVt0YAFbEq/X1bSmmtnNN0PoHFXuunqbP
         VQ/ViDAAdiHFJAEPv+XrjEuyEVptRid+WTjiJPbvs37NRDavJsP3dNJPuz4nn1fs4Xbe
         qVMm4ryWBxq8puAt3JzaqirpqsKT3M/Zu/d6u0FPyfLvPbNNNN0Hhx4hj01mlz118RCv
         Qofw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EpLsmKlpKCiUIDe9SFr1Z71rXe3WR1MDQEjPMDRMDOU=;
        b=e2nTW7K0bIdM9xxfZqU0QbZODu67yxJIOT1Fne6cdXVtMETNn0zaR+WVIqaPvcst3V
         V3w5AHMvJ4HQCoql2bxyGbHzVCqcQgabmp3is/0+HdjamhgvI6wZRJZ3SzC0PoK8eQ/c
         uBoDfZRJQaOjgRERm6RhzfUsifYlxDU0QQG55cQIYYpDMN4SSLA6838QUNv8QigqXKYs
         kHD536iFyt7Q1PVXVkCzpjpm/rCcohg6TJ2/1Eodfcanc4fLofOPGQ/Hc35vXiYsGd0P
         poffAkBrqmJOlvzw15L2HrvEy+zBwM3WnVIp42+TA+XX7cchiymLtArU43zZlT9tGdUz
         Ab7g==
X-Gm-Message-State: AJIora+qo2tsF0/CULR9yEYLVEYSvvytsIqSf/4d5TVBac/1nwqnELtv
        8UzxEwR9ekSbh+Jpf5z/LhWs2MqdKzcmOBLmMJM5uA==
X-Google-Smtp-Source: AGRyM1sjAUAcmtkyEiJeoit5ySGBOChyexenC3PN4u7CokwqIER+Wu9ppdrapofaMzf3YdE/UQWvXY+yHr2Ir3aRi4Q=
X-Received: by 2002:a19:f006:0:b0:47f:ae73:abe5 with SMTP id
 p6-20020a19f006000000b0047fae73abe5mr17682143lfc.206.1656920775975; Mon, 04
 Jul 2022 00:46:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220615062219.22618-1-Kuan-Ying.Lee@mediatek.com> <20220703161552.6a3304c8d316e4fdcce42caa@linux-foundation.org>
In-Reply-To: <20220703161552.6a3304c8d316e4fdcce42caa@linux-foundation.org>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 4 Jul 2022 09:46:04 +0200
Message-ID: <CACT4Y+Y3we9jdc1gJ_rhJZg7YWXm7F6F245ZQQFMknrxXRuo7Q@mail.gmail.com>
Subject: Re: [PATCH] kasan: separate double free case from invalid free
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        chinwen.chang@mediatek.com, yee.lee@mediatek.com,
        casper.li@mediatek.com, andrew.yang@mediatek.com,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
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

On Mon, 4 Jul 2022 at 01:15, Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Wed, 15 Jun 2022 14:22:18 +0800 Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com> wrote:
>
> > Currently, KASAN describes all invalid-free/double-free bugs as
> > "double-free or invalid-free". This is ambiguous.
> >
> > KASAN should report "double-free" when a double-free is a more
> > likely cause (the address points to the start of an object) and
> > report "invalid-free" otherwise [1].
> >
> > [1] https://bugzilla.kernel.org/show_bug.cgi?id=212193
> >
> > ...
>
> Could we please have some review of this?


Looks reasonable to me.
Looking through git log it seems the only reason to combine them was
laziness/didn't seem important enough.

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>

I will update syzkaller parsing of bug messages to not produce
duplicates for existing double-frees.
Not sure if anything needs to be done for other kernel testing systems.


> > diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> > index c40c0e7b3b5f..707c3a527fcb 100644
> > --- a/mm/kasan/common.c
> > +++ b/mm/kasan/common.c
> > @@ -343,7 +343,7 @@ static inline bool ____kasan_slab_free(struct kmem_cache *cache, void *object,
> >
> >       if (unlikely(nearest_obj(cache, virt_to_slab(object), object) !=
> >           object)) {
> > -             kasan_report_invalid_free(tagged_object, ip);
> > +             kasan_report_invalid_free(tagged_object, ip, KASAN_REPORT_INVALID_FREE);
> >               return true;
> >       }
> >
> > @@ -352,7 +352,7 @@ static inline bool ____kasan_slab_free(struct kmem_cache *cache, void *object,
> >               return false;
> >
> >       if (!kasan_byte_accessible(tagged_object)) {
> > -             kasan_report_invalid_free(tagged_object, ip);
> > +             kasan_report_invalid_free(tagged_object, ip, KASAN_REPORT_DOUBLE_FREE);
> >               return true;
> >       }
> >
> > @@ -377,12 +377,12 @@ bool __kasan_slab_free(struct kmem_cache *cache, void *object,
> >  static inline bool ____kasan_kfree_large(void *ptr, unsigned long ip)
> >  {
> >       if (ptr != page_address(virt_to_head_page(ptr))) {
> > -             kasan_report_invalid_free(ptr, ip);
> > +             kasan_report_invalid_free(ptr, ip, KASAN_REPORT_INVALID_FREE);
> >               return true;
> >       }
> >
> >       if (!kasan_byte_accessible(ptr)) {
> > -             kasan_report_invalid_free(ptr, ip);
> > +             kasan_report_invalid_free(ptr, ip, KASAN_REPORT_DOUBLE_FREE);
> >               return true;
> >       }
> >
> > diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> > index 610d60d6e5b8..01c03e45acd4 100644
> > --- a/mm/kasan/kasan.h
> > +++ b/mm/kasan/kasan.h
> > @@ -125,6 +125,7 @@ static inline bool kasan_sync_fault_possible(void)
> >  enum kasan_report_type {
> >       KASAN_REPORT_ACCESS,
> >       KASAN_REPORT_INVALID_FREE,
> > +     KASAN_REPORT_DOUBLE_FREE,
> >  };
> >
> >  struct kasan_report_info {
> > @@ -277,7 +278,7 @@ static inline void kasan_print_address_stack_frame(const void *addr) { }
> >
> >  bool kasan_report(unsigned long addr, size_t size,
> >               bool is_write, unsigned long ip);
> > -void kasan_report_invalid_free(void *object, unsigned long ip);
> > +void kasan_report_invalid_free(void *object, unsigned long ip, enum kasan_report_type type);
> >
> >  struct page *kasan_addr_to_page(const void *addr);
> >  struct slab *kasan_addr_to_slab(const void *addr);
> > diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> > index b341a191651d..fe3f606b3a98 100644
> > --- a/mm/kasan/report.c
> > +++ b/mm/kasan/report.c
> > @@ -176,8 +176,12 @@ static void end_report(unsigned long *flags, void *addr)
> >  static void print_error_description(struct kasan_report_info *info)
> >  {
> >       if (info->type == KASAN_REPORT_INVALID_FREE) {
> > -             pr_err("BUG: KASAN: double-free or invalid-free in %pS\n",
> > -                    (void *)info->ip);
> > +             pr_err("BUG: KASAN: invalid-free in %pS\n", (void *)info->ip);
> > +             return;
> > +     }
> > +
> > +     if (info->type == KASAN_REPORT_DOUBLE_FREE) {
> > +             pr_err("BUG: KASAN: double-free in %pS\n", (void *)info->ip);
> >               return;
> >       }
> >
> > @@ -433,7 +437,7 @@ static void print_report(struct kasan_report_info *info)
> >       }
> >  }
> >
> > -void kasan_report_invalid_free(void *ptr, unsigned long ip)
> > +void kasan_report_invalid_free(void *ptr, unsigned long ip, enum kasan_report_type type)
> >  {
> >       unsigned long flags;
> >       struct kasan_report_info info;
> > @@ -448,7 +452,7 @@ void kasan_report_invalid_free(void *ptr, unsigned long ip)
> >
> >       start_report(&flags, true);
> >
> > -     info.type = KASAN_REPORT_INVALID_FREE;
> > +     info.type = type;
> >       info.access_addr = ptr;
> >       info.first_bad_addr = kasan_reset_tag(ptr);
> >       info.access_size = 0;
> > --
> > 2.18.0
> >
