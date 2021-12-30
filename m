Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D72E481F70
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 20:11:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241784AbhL3TLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 14:11:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241775AbhL3TLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 14:11:47 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E85C06173E
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 11:11:46 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id p65so30685348iof.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 11:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0fiv6RL03GYq28gBLTG+oAUxzJLFmuBgFQ32/iqru78=;
        b=fHvkh4VbM8vMN4jMQ0x3mlFVPT+dqyKP7tPF3+OIdnJfSfsSr5rPuCpvTs23Gmt5c9
         hrkw9T2uMFs0NK0MGguQg3+QGr4xZv+AmIq649MWpbTWQo25cFMIiRUB6YG0XcyCFBZB
         5lQnW6wzFPQM/mt9O7JVJ9Q3oZ51NyrMTrYbzT7dbvn371+8vONU+iV04J6N8I6itBw/
         pQwJhEaMjSqaB3a6hE4reQSK9HdMFt2BNqbvZOL4YlTje+bsZWCCfAvMPuy5hR+6brzl
         0Q52yE3uK2SW6xQ1m7sjZu8HU2NZTrFadwhwRnO8ng0u5Rzd26POu0O4bo8AtPSSYxb5
         mrIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0fiv6RL03GYq28gBLTG+oAUxzJLFmuBgFQ32/iqru78=;
        b=HCLjcSMyCmEw2V1JXEVZi/7gT2xl3xvDE1Q9TrvUhNQ40nRsKdmlrhd6wcQKg7ggWK
         sBHtZA3NB9SAWD8ga1nBd4f/GGwQcMh0GliN6ualXuNAeZm782lgrkau+MehN2ezor+I
         i7Og/exjKNo5nn/50Iw0euI+6in1xxaJwgGMHhaEwSEC+bgMylr1KuC58atrr5Iw+H1/
         Uvkj3jKh5+fJ0LsjeDezu/aC5lUsJPkBTeK8jJRcghxHAFI2GCE7y1BoAQ85v4a3HuLE
         5k3aTsrhev0TqSyjtxg05w133nAXTfs0J3MYv5MKpyxh7J/H9NprKt5dYBrVMUITlJzF
         Lelg==
X-Gm-Message-State: AOAM530aSkMFz0fjfs/i0P004yfslUku/9Iv00nscYnDEdfQhIuubzOS
        3gxgpwZEITPRxaywprYiL5EHj0e8gyx9twZ17mA=
X-Google-Smtp-Source: ABdhPJy0XlHoc6IPNyedHtl279SyfKStumMeOkCGBsJTLPIBAlT3ptpCJGmDcw2JSzuhMXJuV5WnoFlyCg9SpNnDMi0=
X-Received: by 2002:a6b:7e03:: with SMTP id i3mr14544209iom.202.1640891506249;
 Thu, 30 Dec 2021 11:11:46 -0800 (PST)
MIME-Version: 1.0
References: <cover.1640036051.git.andreyknvl@google.com> <dea9eb126793544650ff433612016016070ceb52.1640036051.git.andreyknvl@google.com>
 <YcHEjERoiqJTKmsZ@elver.google.com>
In-Reply-To: <YcHEjERoiqJTKmsZ@elver.google.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Thu, 30 Dec 2021 20:11:35 +0100
Message-ID: <CA+fCnZdk1gksiMMJVMe-fb56_4ZFUaaOLa4EZx0RCSR-3xd4AQ@mail.gmail.com>
Subject: Re: [PATCH mm v4 29/39] kasan, page_alloc: allow skipping memory init
 for HW_TAGS
To:     Marco Elver <elver@google.com>
Cc:     andrey.konovalov@linux.dev,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2021 at 1:12 PM Marco Elver <elver@google.com> wrote:
>
> On Mon, Dec 20, 2021 at 11:02PM +0100, andrey.konovalov@linux.dev wrote:
> > From: Andrey Konovalov <andreyknvl@google.com>
> [...]
> > +static inline bool should_skip_init(gfp_t flags)
> > +{
> > +     /* Don't skip if a software KASAN mode is enabled. */
> > +     if (IS_ENABLED(CONFIG_KASAN_GENERIC) ||
> > +         IS_ENABLED(CONFIG_KASAN_SW_TAGS))
> > +             return false;
> > +
> > +     /* Don't skip, if hardware tag-based KASAN is not enabled. */
> > +     if (!kasan_hw_tags_enabled())
> > +             return false;
>
> Why is the IS_ENABLED(CONFIG_KASAN_{GENERIC,SW_TAGS}) check above
> required? Isn't kasan_hw_tags_enabled() always false if one of those is
> configured?

It is. I wanted to include those checks for completeness, but maybe
they just cause confusion instead. Will drop them in v5. Thanks!
