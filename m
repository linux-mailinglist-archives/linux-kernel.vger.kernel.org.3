Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23F0A50BC9F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 18:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355650AbiDVQMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 12:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiDVQMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 12:12:09 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 582C45E161
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 09:09:16 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id q22so9095224iod.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 09:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7ywngeaPOxck8z+da0Rb5cHl7IWBnc+HuyghQxZLcVk=;
        b=oG1haJS5hmczkwWbyWqWbIQaUylnKJJUnzf14PdQs7QjktBBhU9YQSVIFpfGm8F1RJ
         A3p1lsqVP5QDbT7NEnVUml3TwvhnPfRRU+pq8FwWMksiYbc7BXjHZQhVLz71LSIKH7DF
         xeDLcInX5J6paNdMWEqpbYQg/JX/BdrznAnRH4TB20PgkpDWy3N5AaxLehVf/qY/Qxa/
         1GI5+1Eq6ZsSznd6mrEWnsgZGHzos/iR+voO3zTbfBArFy9D0r9uhbe6x/YeYFS6qk2+
         FY0QedT2lpEcnbhin5BCJMx3i/ot7yBiZbNx5G1qvaD7V3m+CMqlhRCwjoh8hIVuoYRn
         NJTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7ywngeaPOxck8z+da0Rb5cHl7IWBnc+HuyghQxZLcVk=;
        b=dcQjlsgNjX9PXNRjKmwgHcVgyuonZYNCqdl+39kMGTVNj7Z84aqmUjOP/0q4QwRiTj
         JnZLRuj4woXjf2qmucKgP1nXLDPC4hCubBq1R0rrdaoxGvAmGRA/qPOCgKeg/acjLhAW
         lKOO9DcrCtW2UZ1fE5Bm/DYML85I++d/DJpyUb2uvUS1UctrFakpWWMxCnnYELlNsUNd
         C91ARboBJmDfLnYJTTZzKwX8JIylmqfLbLvF779T6hicAlGcn8X9b+cLbSahXNl45dQm
         tyF+mflKampneir5edZU+UM9tIifPjy43Ukksswzl7aZgWEC4fjoZnmIw8Sh2GbuEBIZ
         6BjQ==
X-Gm-Message-State: AOAM5333dJ7xpP7/3ZMqC+DaM9uth/5vGA11hYwHoRwpQoCfqSWoRawT
        NGQpTFMeUrOMedwzG2BiencDXIpz41ebEZvcExk=
X-Google-Smtp-Source: ABdhPJytqgoKB/LhjwjdWDKbDXz5rBm+JEhsXjBZkk1xtyNUNvug+BnxZy8qyRlmSnBYP4X43IatfCoxx82hSJwBO+E=
X-Received: by 2002:a05:6638:dd3:b0:32a:7bdd:799b with SMTP id
 m19-20020a0566380dd300b0032a7bdd799bmr2474463jaj.117.1650643755556; Fri, 22
 Apr 2022 09:09:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220421031738.3168157-1-pcc@google.com> <YmFORWyMAVacycu5@hyeyoo>
 <CAMn1gO5xHZvFSSsW5sTVaUBN_gS-cYYNMG3PnpgCmh7kk_Zx7Q@mail.gmail.com> <YmKiDt12Xb/KXX3z@hyeyoo>
In-Reply-To: <YmKiDt12Xb/KXX3z@hyeyoo>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Fri, 22 Apr 2022 18:09:04 +0200
Message-ID: <CA+fCnZdTPiH_jeiiHCqdTcUdcJ0qajQ0MvqHWTJ1er7w6ABq5A@mail.gmail.com>
Subject: Re: [PATCH] mm: make minimum slab alignment a runtime property
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Peter Collingbourne <pcc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pekka Enberg <penberg@kernel.org>, cl@linux.org,
        roman.gushchin@linux.dev, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>
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

On Fri, Apr 22, 2022 at 2:39 PM Hyeonggon Yoo <42.hyeyoo@gmail.com> wrote:
>
> > > kasan_hw_tags_enabled() is also false when kasan is just not initialized yet.
> > > What about writing a new helper something like kasan_is_disabled()
> > > instead?
> >
> > The decision of whether to enable KASAN is made early, before the slab
> > allocator is initialized (start_kernel -> smp_prepare_boot_cpu ->
> > kasan_init_hw_tags vs start_kernel -> mm_init -> kmem_cache_init). If
> > you think about it, this needs to be the case for KASAN to operate
> > correctly because it influences the behavior of the slab allocator via
> > the kasan_*poison* hooks. So I don't think we can end up calling this
> > function before then.
>
> Sounds not bad. I wanted to make sure the value of arch_slab_minaligned()
> is not changed during its execution.
>
> Just some part of me thought something like this would be more
> intuitive/robust.
>
> if (systems_supports_mte() && kasan_arg != KASAN_ARG_OFF)
>         return MTE_GRANULE_SIZE;
> else
>         return __alignof__(unsigned long long);

Hi Hyeonggon,

We could add and use kasan_hw_rags_requested(), which would return
(systems_supports_mte() && kasan_arg != KASAN_ARG_OFF).

However, I'm not sure we will get a fully static behavior:
systems_supports_mte() also only starts returning proper result at
some point during CPU bring-up if I'm not mistaken.

Thanks!
