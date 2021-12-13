Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88E6C47371E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 22:57:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243454AbhLMV5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 16:57:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243443AbhLMV5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 16:57:44 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66398C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 13:57:44 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id e128so20651329iof.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 13:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Izx2PBJI6AWPZSxP/szrg017GVN03v7urPWV5485xFY=;
        b=AF0AV2ARAAX4APaDSLFpoXDSN+2gbml2KM50iiimiShWMpDclC0ji249wqsMZcz9gG
         yrsUAKuqyZ0HVQfRchx9GVT/61lOdPcnMff+SltKucwZKQTywULdAvowtFP9wEaVZfQE
         Jq6QQge1/gnEZlkpY0Id6VsK02GcIz6mJoVMe5llq7woRBqI2nlDwdnCcItq9cc+Izfr
         jrwaN4L8/Z/8k5qiOh/g+cPtxcNiNMhvW4h75m6vhP5jMIDdDnXn1SUmc7DRkgl/liwf
         MaH1Fg5rRMi10oWWoo0zm+DGtedNeukotuLllo5MQiaD+9efPOeH2gwSFU6sF3ebOBz3
         PcBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Izx2PBJI6AWPZSxP/szrg017GVN03v7urPWV5485xFY=;
        b=ILYHs6J/4Y33OLxda7qEldYs6bys7MTC2TnC84WF9M/pRx4zCH53WJQOiNQ25iATtf
         M87HunFVNfiGejIIrV3mLcr9V3KUC5F16+WwYi5shgTU4GkQnak/D6gj2i+6S03WQzqJ
         XYEfsag0FoqX99r7etJQ54VW1Nn21CxfpCB0CV/isnj2wIzLbOvlzX4DDudfzOrHmOCh
         +n5w2vJHwBz/I2oB6fgicxvxGKHCTxqSDn4GjePK3B4xAdGjSjPW9PKGqvLpBHD7iQ4z
         Nw/w2CnAO7EHtOot7pD/4n7b0zle/dsxMdTkXi3GEKm1m+KuiabUWIExZiv93UpOBhur
         GnJg==
X-Gm-Message-State: AOAM533CPi0Iuxp939q/famnzxoBVE/siJp+0tUKXeoTt5oN4WOGHDNO
        O5HvN8joAWKtVHUo0YyycW0mKUasDy2NGkAwcpA=
X-Google-Smtp-Source: ABdhPJxla1h1vaFnm/AGV4DYwa7tRTYS9fOoUcuMbKzgf64wEEeaJZyHVIz7RlfdxOEbl+9pEXMr7xrOdUyXB+D5was=
X-Received: by 2002:a05:6602:2d04:: with SMTP id c4mr1017624iow.56.1639432663912;
 Mon, 13 Dec 2021 13:57:43 -0800 (PST)
MIME-Version: 1.0
References: <cover.1638825394.git.andreyknvl@google.com> <72a8a7aa09eb279d7eabf7ea1101556d13360950.1638825394.git.andreyknvl@google.com>
 <b777d2d2-421c-8854-e895-988ddc4ff9a6@arm.com>
In-Reply-To: <b777d2d2-421c-8854-e895-988ddc4ff9a6@arm.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Mon, 13 Dec 2021 22:57:33 +0100
Message-ID: <CA+fCnZcSAzQ8Lk8ZqH0bv0K=Ern8aZr+=cTSzFJeE0uYMVTxmw@mail.gmail.com>
Subject: Re: [PATCH v2 28/34] kasan, vmalloc: add vmalloc support to HW_TAGS
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     andrey.konovalov@linux.dev, Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Evgenii Stepanov <eugenis@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 4:34 PM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
>
> Hi Andrey,
>
> On 12/6/21 9:44 PM, andrey.konovalov@linux.dev wrote:
> > From: Andrey Konovalov <andreyknvl@google.com>
> >
> > This patch adds vmalloc tagging support to HW_TAGS KASAN.
> >
>
> Can we reorganize the patch description in line with what I commented on patch 24?

Hi Vincenzo,

Done in v3.

> >  void * __must_check __kasan_unpoison_vmalloc(const void *start,
> > -                                          unsigned long size);
> > +                                          unsigned long size,
> > +                                          bool vm_alloc, bool init);
> >  static __always_inline void * __must_check kasan_unpoison_vmalloc(
> > -                                     const void *start, unsigned long size)
> > +                                     const void *start, unsigned long size,
> > +                                     bool vm_alloc, bool init)
>
> Can we replace booleans with enumerations? It should make the code clearer on
> the calling site.

I think we can add a single argument for named flags to improve
readability. Done in v3.

> With these changes:
>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

Thanks!
