Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB07578DAA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 00:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235566AbiGRWle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 18:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234596AbiGRWlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 18:41:32 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B492DA9C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 15:41:31 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id n2so8566890qkk.8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 15:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ISQEQ+fIU3xAcRWcqutk61dQJfgUByc+o/p0/o9VaqQ=;
        b=IH/FZ8SrUXP2dDYcRxYo5hHvEHRDVPafx35U/9ZnUzKdYONMPijudkIJgyNp/P1eqS
         Vz+6KL7fWpehsS1cZaRejfGyFWa9vLodhJW54WnzQEK190wK7fzCpe4PgSrQWHAWy7LD
         7P0Jn3c54BPUPIYPFib731YYvXf1TFuRIGIS/T7kyWo5aD/jaGyK+zZC7wKvmgenhRkO
         V1YUIwQj5br4kxCvuQZPcJDR4aEDHWvE+ePOZLsmgkHnzwZjCXOvCQ/99BF64hkTG7qd
         eJEAXPCtQMqIXm1OH4M7jazorAiFE6SEzkdjAGKvnw7iGZ69My6Qo5IOfomFGWEVisqU
         vo6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ISQEQ+fIU3xAcRWcqutk61dQJfgUByc+o/p0/o9VaqQ=;
        b=1L9c6rmXXKt8U+1hSCaOqFjpz6VhgY8lw7yEWUbEHWSfK++sDtGdHbhpwX9lFDdvti
         9agKRrs+S0eb6+6a51842OiNVZBgdkVWFFA8jkV3yMTBiGtpHvLuquZ7AmT3XAXBbaLW
         0wZ8XPUIrnz5s1VQOB01rtXS7t+09KXbbB0r5JJEvXCgvEPET7oB9HXDTKhBv5AApkIe
         TBOrDewdHJiPQ6WCyp+Mfrp5SXmb++aoMBOANzZMH1FT9q25HJuZcV9bdykjPreo8ank
         /lkeG+5DBdfJsfq0kcE/RLflf6U3iUy0Fc/P5EnVlHCkPM9gHxmyGHqnXzhCZXPwDb4b
         In1g==
X-Gm-Message-State: AJIora+2Fe0rtnCOB+7mScSXWblTys4dIRWDE+3bLsve+rDF++InwYIY
        8vh9DWoI8uG1/0D1FN6wXUvaZ0iKpHbV+snPuBY=
X-Google-Smtp-Source: AGRyM1tSoqflDUr5Mg2xHUPRTTAzjNKYxv+S53Qbj3gS0KL0JvYKrrffyaAXoiFit8+UmyC/nTzU38aOfUyQ4tXScMQ=
X-Received: by 2002:a05:620a:2807:b0:6a6:6ef1:fb9d with SMTP id
 f7-20020a05620a280700b006a66ef1fb9dmr19234367qkp.146.1658184090436; Mon, 18
 Jul 2022 15:41:30 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1655150842.git.andreyknvl@google.com> <11a7bfb5ed5de141b50db8c08e9c6ad37ef3febc.1655150842.git.andreyknvl@google.com>
 <CANpmjNMTb4cxizfb5Xzy979jCA2_BMio6W4k1wZivKnu77RKVw@mail.gmail.com>
In-Reply-To: <CANpmjNMTb4cxizfb5Xzy979jCA2_BMio6W4k1wZivKnu77RKVw@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Tue, 19 Jul 2022 00:41:19 +0200
Message-ID: <CA+fCnZeq8bWKcQ5fCYuXCvReDJjv+SKcaFu-DPO==W3XPRUm3w@mail.gmail.com>
Subject: Re: [PATCH 06/32] kasan: introduce kasan_print_aux_stacks
To:     Marco Elver <elver@google.com>
Cc:     andrey.konovalov@linux.dev,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Florian Mayer <fmayer@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2022 at 1:35 PM Marco Elver <elver@google.com> wrote:
>
> > diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> > index aa6b43936f8d..bcea5ed15631 100644
> > --- a/mm/kasan/kasan.h
> > +++ b/mm/kasan/kasan.h
> > @@ -265,6 +265,12 @@ void kasan_print_address_stack_frame(const void *addr);
> >  static inline void kasan_print_address_stack_frame(const void *addr) { }
> >  #endif
> >
> > +#ifdef CONFIG_KASAN_GENERIC
> > +void kasan_print_aux_stacks(struct kmem_cache *cache, const void *object);
> > +#else
> > +static inline void kasan_print_aux_stacks(struct kmem_cache *cache, const void *object) { }
> > +#endif
>
> Why not put this into one of the existing "#ifdef
> CONFIG_KASAN_GENERIC" blocks? There are several; probably the one 10
> lines down might be ok?

The idea was to group functions based on their purpose, not on which
mode uses them. Here, kasan_print_aux_stacks() is related to printing
reports, so it goes next to other such functions. We could rework the
order of functions in this file, but I'd rather keep it as is in this
change. Thanks!
