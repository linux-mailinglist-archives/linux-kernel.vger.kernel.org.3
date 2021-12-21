Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4F4D47BF96
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 13:20:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234699AbhLUMT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 07:19:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbhLUMT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 07:19:57 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B9CC061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 04:19:57 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id 7so20568618oip.12
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 04:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BaXR+Sf/o4pHq2K7zFqOPHm0HQk54kBEfN6/GC5fgeM=;
        b=DOY8PDnOLcMR8fY8k4rMeFeCw7xBBFK3OPAE/n+xtb8qDFv9JkNk3LZbYjMxSp9Kr/
         LN+Kgfkxy81v9dusGxkmzUFNm8E70Ly1GdWreagXAuCygdufarJbRI0BYaGpKjyNtKVm
         fcs6Nr4Dx4+k2Ft9cxJL8HkFmQSBrjkGt7mRlv+ODuxymPHHSAKkyo+d65Q5ur8dZtuR
         c5pim4OMXxIgsJJmBOFqJJe6VYugNfMHha7zuSla8xEq1khHiCctmEw6R2vpPUfoR/0z
         MLWB1XzrewUW/h8hIweXJDtWOqIalVXR+sc4Ky4KTcKSYKVVmRi3Oio8WbCCUpw3w2xb
         5VRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BaXR+Sf/o4pHq2K7zFqOPHm0HQk54kBEfN6/GC5fgeM=;
        b=N8o5ESfOvpq1R+T/2QFymKAs+CSsLB/qmDYylB8/sGJoeqhmwBVzwfvfCvYFi2Cbmy
         wOrqk1nIep/B0hpPUwz48supzb+8gMzzU4NtIDztlfVyqGpjWWJSUD5auUeFPiDhZB4U
         8KuMEwB7DxAd+sycZYECHmn5eS9e/LGXPincorCE5QL4Rx6MkAlVXS5j/ILq3pmt6yEY
         DG5M0e1RveHMnPptU9mRQ7JlCv8owM/EzlYAAIIGy//mq16kaojoy2zOvVVZgIAnPjR/
         kgA2qsMng0J763huZk4HpjQDOWj2QG9ezKPrSGchJb2psxlzXHHtf8bC5qMwKyCOEFyI
         3iPQ==
X-Gm-Message-State: AOAM530ywTLKVqAaIYOez/A3dGQNc5B8u8L93uoyyC2GxObXD42B5QWL
        hKgkobK6pcItXhtcTOkTr7ILm7EnTBFkOuUWFEh8qQ==
X-Google-Smtp-Source: ABdhPJxBX/Gkn5yNgs1quOEw+mGlZ7jRH4P8oW8i+xSqTHpBDQPz/PzlNjgclCi6wHGOYn03vA+wj3XaqwTIXkiJN/g=
X-Received: by 2002:a05:6808:1903:: with SMTP id bf3mr2240565oib.7.1640089196762;
 Tue, 21 Dec 2021 04:19:56 -0800 (PST)
MIME-Version: 1.0
References: <cover.1640036051.git.andreyknvl@google.com> <73a0b47ec72a9c29e0efc18a9941237b3b3ad736.1640036051.git.andreyknvl@google.com>
 <YcHFKSNDI8KJKR7y@elver.google.com>
In-Reply-To: <YcHFKSNDI8KJKR7y@elver.google.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 21 Dec 2021 13:19:45 +0100
Message-ID: <CANpmjNPDsr36JQ4y_nkBVgaEXp+oqxuG3th8Ftr5rXMNX7V6JQ@mail.gmail.com>
Subject: Re: [PATCH mm v4 28/39] kasan, page_alloc: allow skipping unpoisoning
 for HW_TAGS
To:     andrey.konovalov@linux.dev
Cc:     Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Dec 2021 at 13:14, Marco Elver <elver@google.com> wrote:
>
> On Mon, Dec 20, 2021 at 11:02PM +0100, andrey.konovalov@linux.dev wrote:
> [...]
> > +static inline bool should_skip_kasan_unpoison(gfp_t flags, bool init_tags)
> > +{
> > +     /* Don't skip if a software KASAN mode is enabled. */
> > +     if (IS_ENABLED(CONFIG_KASAN_GENERIC) ||
> > +         IS_ENABLED(CONFIG_KASAN_SW_TAGS))
> > +             return false;
> > +
> > +     /* Skip, if hardware tag-based KASAN is not enabled. */
> > +     if (!kasan_hw_tags_enabled())
> > +             return true;
>
> Same question here: why is IS_ENABLED(CONFIG_KASAN_{GENERIC,SW_TAGS})
> check required if kasan_hw_tags_enabled() is always false if one of
> those is configured?

Hmm, I pattern-matched too quickly. In this case there's probably no
way around it because the return value is different, so not exactly
like the should_skip_init().
