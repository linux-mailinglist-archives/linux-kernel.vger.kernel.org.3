Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D637B54F6C4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 13:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381791AbiFQLfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 07:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380246AbiFQLfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 07:35:31 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55BA3522CA
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 04:35:26 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-3177e60d980so17946687b3.12
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 04:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x5bwvKPWoiAdNfsl0rpPiOJbLUCKa6eFsFkR7Dl/GBw=;
        b=PENmBcxuKfoFRDHda84GkCq+WJODrnGWd1BRRAYSLp6UWmG1E5r4fVQr3JlCQYWR2z
         Qergd8Q6YnMXN+pMYTsBxlrOigKyDtcdwAkd6Fu22A9ts3hO0XNAJA6xPzya4pYHDrUP
         2j04UJ1lxfaS/nfX9aIIcWdVfQqb+t5HJ9a0tRlgtD7WGdewEjwEB/mxpuAP5Cz5Euh7
         KwJ25dhBw8FvfWESdwfhtqZWRSvXLdaCek5fo8yrPOBi+uuAD+JUiTov9IONiWiwMl5j
         sBZgKiR/22QfjoIbF0VcBhHwo21dUvctTQ9K/3xAPyBfKfNXqf0FMg2lK4whTouF4FEB
         qBHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x5bwvKPWoiAdNfsl0rpPiOJbLUCKa6eFsFkR7Dl/GBw=;
        b=Tlg3U/iozPTXrlEHIuAyzRcVVmZ/oAkWMzFMhBrars5jH/PVKZn2p+PZj6XmURZmWx
         P0pFJEOaf6+8u08QR1o69glRHk35zNrsMxf8S+EB99N1RDLlUMf8mxLthhs5eg97G/98
         hfyN0lZ5E+Ee0I61i9XX3D+hb7FVrPcY2FfEase9AJddHwDgHtW/DJ13yjKx2g+R4aXi
         EnnHbkDv76dgJWK1EvgBYaI5vBDN0Y77+ltjopmjmj1raKwJJrtIi0zGTPwN7kRlFY3r
         ubOE7X2E0abwc4y4t9LHiBkVD+/48IAm8eJNEmnpIDuMh2q79heCqVDudky3TD95MBUK
         O6vQ==
X-Gm-Message-State: AJIora9ZUnRh+qjrpbgdaG+8LSRhOO2mKbjOlOJwNUhbmHR2TaAtgtsz
        xSmwHuVn6ufV+JWuVsb4kRd0Ajub1u34WwwI+pDRkA==
X-Google-Smtp-Source: AGRyM1sPWp60NI6GDHzc4UkssfaxItU18eWBZCQxcAan3JOuUbMEgrM9UAlZ3+93QWh1rqFj6ljJADuu4vENZMP6q78=
X-Received: by 2002:a81:18c1:0:b0:317:648e:eec8 with SMTP id
 184-20020a8118c1000000b00317648eeec8mr10552299ywy.327.1655465725193; Fri, 17
 Jun 2022 04:35:25 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1655150842.git.andreyknvl@google.com> <11a7bfb5ed5de141b50db8c08e9c6ad37ef3febc.1655150842.git.andreyknvl@google.com>
In-Reply-To: <11a7bfb5ed5de141b50db8c08e9c6ad37ef3febc.1655150842.git.andreyknvl@google.com>
From:   Marco Elver <elver@google.com>
Date:   Fri, 17 Jun 2022 13:34:49 +0200
Message-ID: <CANpmjNMTb4cxizfb5Xzy979jCA2_BMio6W4k1wZivKnu77RKVw@mail.gmail.com>
Subject: Re: [PATCH 06/32] kasan: introduce kasan_print_aux_stacks
To:     andrey.konovalov@linux.dev
Cc:     Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Florian Mayer <fmayer@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
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

On Mon, 13 Jun 2022 at 22:16, <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@google.com>
>
> Add a kasan_print_aux_stacks() helper that prints the auxiliary stack
> traces for the Generic mode.
>
> This change hides references to alloc_meta from the common reporting code.
> This is desired as only the Generic mode will be using per-object metadata
> after this series.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---
>  mm/kasan/kasan.h          |  6 ++++++
>  mm/kasan/report.c         | 15 +--------------
>  mm/kasan/report_generic.c | 20 ++++++++++++++++++++
>  3 files changed, 27 insertions(+), 14 deletions(-)
>
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index aa6b43936f8d..bcea5ed15631 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -265,6 +265,12 @@ void kasan_print_address_stack_frame(const void *addr);
>  static inline void kasan_print_address_stack_frame(const void *addr) { }
>  #endif
>
> +#ifdef CONFIG_KASAN_GENERIC
> +void kasan_print_aux_stacks(struct kmem_cache *cache, const void *object);
> +#else
> +static inline void kasan_print_aux_stacks(struct kmem_cache *cache, const void *object) { }
> +#endif

Why not put this into one of the existing "#ifdef
CONFIG_KASAN_GENERIC" blocks? There are several; probably the one 10
lines down might be ok?
