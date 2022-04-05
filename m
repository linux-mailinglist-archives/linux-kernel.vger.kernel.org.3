Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96B7B4F5061
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1841590AbiDFBY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 21:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1455105AbiDEP7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:59:37 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80CF51ED05F
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 08:10:05 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id r2so15462451iod.9
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 08:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=odjTcYZDlQIoWSkHe17VwGaSSDqsAiUMG/3xJUCUusY=;
        b=BIrJnLaJlobJRELofbUGfFGoIys4VbYWUyOHKM6yPYsEcaU68cPexoPGB+FF75wT0l
         nTLBpmNWQH9/4qlaY0IAqmQ99mQpeHL5s+1WZFh0J7WoAX7+equKRVWQIefnQJGxuh/d
         12Uk/NDYJwyFUL3HMR+IHHm9e1DqLhSp1oAk5dW6A9KBz/M3GH2qfDskfkemdyJNjOfZ
         zklDlMXUPCraZit01xyTMy4mXPhfA6rQp9D9ILWlKYTlfAySHdHSrPXE36e/9K358+yp
         2FY/pAh3O3L/Cdc9+eHFv8jK5bnXsezX/to0L2uZ8nOAf+9AnR8YjKHodr+zV3g6F846
         Wspw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=odjTcYZDlQIoWSkHe17VwGaSSDqsAiUMG/3xJUCUusY=;
        b=AcWoWsVKzma/ACKsNdaYHVZ/VcsqlUeCsOCHccPU9Te7MI4L9koX5fwOcr5gUQxdv4
         YIq2/F3p8pOVaB7BsYtIwDNlqEO5RDVGjWlu9PKk2IQnBYwJ3aXS3jEST2g0NEEnho8d
         TGgFbLSUXHhIY5HnIMHWm0m7v74lfJCAkxaVIL9aKR61Dt3YohrHSNn3n5Y5mc92mEsi
         sQjGnOPar20LlnTpeWSh43xLxNik6YFBKK1F4K64jpXZhst6u4tbIUTQwT0pVCvDvWOF
         bIhVj2n30cittgqEWUP2aq0aeGGHPdO2v99oIjoW8c/et6csb+XJe5YVRI0Dcb/rpaUR
         MsKg==
X-Gm-Message-State: AOAM5311z+ZQBsu30jc39xNU7NYxmlR4r1hmx79Z77qz5/TONAMhAhSD
        WInWVrOvMkNI9VoBuSlczXH4AtC2M8pvFQN+FzA=
X-Google-Smtp-Source: ABdhPJxAaHeUeJtc2U3f+/5L8fy3AA56uR4U1tXUh2cgSLnkKbaFje6hcmqnAosZq0GKK0ddS4eVRltN814HgJgzkfI=
X-Received: by 2002:a02:c89a:0:b0:321:25b2:4b52 with SMTP id
 m26-20020a02c89a000000b0032125b24b52mr2152926jao.218.1649171404854; Tue, 05
 Apr 2022 08:10:04 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1648049113.git.andreyknvl@google.com> <YkV6QG+VtO7b0H7g@FVFF77S0Q05N>
In-Reply-To: <YkV6QG+VtO7b0H7g@FVFF77S0Q05N>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Tue, 5 Apr 2022 17:09:54 +0200
Message-ID: <CA+fCnZfU+Jj3Of+d0d6b3=fJC0F+SfcUHV1p0Gs95exoNsqvmA@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] kasan, arm64, scs, stacktrace: collect stack
 traces from Shadow Call Stack
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

On Thu, Mar 31, 2022 at 11:54 AM Mark Rutland <mark.rutland@arm.com> wrote:
>
> That is an impressive number. TBH, I'm shocked that this has *that* much of an
> improvement, and I suspect this means we're doing something unnecssarily
> expensive in the regular unwinder.
>
> I've given some specific comments on patches, but a a high-level, I don't want
> to add yet another unwind mechanism. For maintenance and correctness reasons,
> we've spent the last few years consolidating various unwinders, which this
> unfortunately goes against.
>
> I see that there are number of cases this unwinder will fall afoul of (e.g.
> kretprobes and ftrace graph trampolines), and making those work correctly will
> require changes elsewhere (e.g. as we rely upon a snapshot of the FP to
> disambiguate cases today).

Do I understand correctly that kretprobes and ftrace modify frames
saved on SCS? So, if either is enabled, SCS frames might contain their
addresses instead of actual PCs?

If so, this is good enough for our use case. Having kretprobes or
ftrace enabled is an unusual setting and there's no requirement to
support it.

The goal is to have stack trace collection working in most cases
during a normal usage of an Android device. Being not feature-complete
and not covering all possible peculiar cases is fine.

> I'm also very much not keen on having to stash things in the entry assembly for
> this distinct unwinder.

I'll drop these changes, I'll respond on that patch.

> Going forward, I'm also planning on making changes to the way we unwind across
> exception boundaries (e.g. to report the LR and FP), and as that depends on
> finding the pt_regs based on the FP, that's not going to work with SCS.
>
> So at a high level, I don't want to add an SCS based unwinder.
>
> However, I'm very much open to how we could improve the standard unwinder to be
> faster, which would be more generally beneficial. I can see that there are some
> things we could reasonably do with simple refactoring.

The intention of adding an SCS-based unwinder it to use in production
together with MTE-based KASAN. Thus, it needs to be as fast as
possible. I doubt even a very optimized FP-based unwinder will compare
with a simple loop over SCS frames.

It seems a pity to let the kernel maintain the current call trace via
SCS and then not to use it to collect stack traces.

Would it be acceptable if we keep the SCS unwinder code in mm/kasan
and not integrate with the common stacktrace machanisms?

Thanks!
