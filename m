Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2DF74F3F5B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 22:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384451AbiDEUFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 16:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457297AbiDEQDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 12:03:04 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 742F024F39
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 08:37:18 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id h63so15561021iof.12
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 08:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FtaEgz69DQ819AKh/JUIG3OQ4Q+fmie3I0z6sDwsCCk=;
        b=dFZM9Jrm29mfxGpXaOsvIRZmFBKbc0AgfvSqpX3EioHJtIEsvWDD/GYPxV+38Ss6kK
         aSi5BlXbacPVXocOH787r6+R/vBk3hUUaZKk6t1gUvTV1szQ4wil+I9AUrXlJushPlL0
         AUBAoWK2P/GkBgUjPd2KTB1I+cGHLXiYQLVf8QiRIZP2IuJwEOOq9A221Zbju6o70rWR
         Ti+4hXQ5CukVYwGcjeurbmjEzT6ndHMrkpAgA3Zx+OtFytIL3FcUgvGTIxPJLyKTB9SS
         SGZ37SJm00UTH/TDwyQGs9OOhfNB8HHKRQ33tHsCsm2Iybrwo2AwkIFF07Y/u09MzsvZ
         3s4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FtaEgz69DQ819AKh/JUIG3OQ4Q+fmie3I0z6sDwsCCk=;
        b=ZmjCWbDpxNhMGGoIiRiPpx73h8U/15RQMx9aEr8js1UjwXdGzLMAvOztUmeikQRi6z
         1FsNo9WqRy+K0q+EF2j5FpS8R94wpcenDqeA9RLxUjpRqGEcvHekPK7ueG+S/boPMLOT
         grirEILVTMVbhaJe+odL72ct5nRY+fUos8bofZ26gw2BEOH1xE5oA6iwiFU6Z4YROH4c
         M7wn9W8Da2onVcCPxmgVfbZhcMGRUfeg0wmxG6fkssePOj/HyfZnbwPvwOqP5vm+4YJ8
         MC2i9lPq2wiGJWNP4ING8HfLAHNCCjbpHF3gMGFGBuUkG6H6TvAcA6FRuO9kSM7EeNXb
         35/g==
X-Gm-Message-State: AOAM5331OTjvyDgRbiQRJu1EN6SVjQwRZNZ9PgJtdcPCTvwKIqPbDDxG
        IlzoGNvFs2e0oPwPI7JNbsaR9onzeP9dX0Qpslk=
X-Google-Smtp-Source: ABdhPJzKvUXA4HEqXhmBIGdqKNw+wxPo77cFowOrT7xA9Lsny2Cp5v64TzdBY34Vz1GLSofqMqmZ5tQubR2ncnnPI8M=
X-Received: by 2002:a02:b687:0:b0:323:60e7:121a with SMTP id
 i7-20020a02b687000000b0032360e7121amr2473005jam.22.1649173037888; Tue, 05 Apr
 2022 08:37:17 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1648049113.git.andreyknvl@google.com> <21e3e20ea58e242e3c82c19abbfe65b579e0e4b8.1648049113.git.andreyknvl@google.com>
 <YkVyGdniIBXf4t8/@FVFF77S0Q05N>
In-Reply-To: <YkVyGdniIBXf4t8/@FVFF77S0Q05N>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Tue, 5 Apr 2022 17:37:06 +0200
Message-ID: <CA+fCnZeVKv9iJknyHiKWF0QA3vx+SznJCDJ10Q_HmnzHmnpt=w@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] stacktrace: add interface based on shadow call stack
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     andrey.konovalov@linux.dev, Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Florian Mayer <fmayer@google.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>
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

On Thu, Mar 31, 2022 at 11:19 AM Mark Rutland <mark.rutland@arm.com> wrote:
>
> > Collecting stack traces this way is significantly faster: boot time
> > of a defconfig build with KASAN enabled gets descreased by ~30%.
>
> Hmm... just to check, do ou know if that's just because of hte linear copy, or
> because we're skipping other work we have to do in the regular stacktrace?

No, I haven't looked into this.

> > The implementation of the added interface is not meant to use
> > stack_trace_consume_fn to avoid making a function call for each
> > collected frame to further improve performance.
>
> ... because we could easily provide an inline-optimized stack copy *without*
> having to write a distinct unwinder, and I'd *really* like to avoid having a
> bunch of distinct unwinders for arm64, as it really hinders maintenance. We're
> working on fixing/improving the arm64 unwinder for things like
> RELIABLE_STACKTRACE, and I know that some of that work is non-trivial to make
> work with an SCS-based unwind rather than an FP-based unwind, and/or will
> undermine the saving anyway.

Responded on the cover letter wrt this.

> > +int stack_trace_save_shadow(unsigned long *store, unsigned int size,
> > +                         unsigned int skipnr)
> > +{
> > +     /*
> > +      * Do not use stack_trace_consume_fn to avoid making a function
> > +      * call for each collected frame to improve performance.
> > +      * Skip + 1 frame to skip stack_trace_save_shadow.
> > +      */
> > +     return arch_stack_walk_shadow(store, size, skipnr + 1);
> > +}
> > +#endif
>
> If we really need this, can we make it an __always_inline in a header so that
> we can avoid the skip? Generally the skipping is problematic due to
> inlining/outlining and LTO, and I'd like to avoid adding more of it
> unnecessarily.

Yes, I think this should work.

However, if we keep the implementation in mm/kasan, this integration
will not be required.

Thanks!
