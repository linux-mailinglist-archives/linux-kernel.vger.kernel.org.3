Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30B2A46A92A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 22:10:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350150AbhLFVNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 16:13:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350145AbhLFVNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 16:13:35 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C56CC061746
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 13:10:06 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id p23so14541698iod.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 13:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vPzV3+wkeUfRoOQi+Ln3ww49AQZvsG1boIOkNO2vCs4=;
        b=gxZcfGvIArjbWnFtr6tjBtX/HZnpf8uwu1b5Q9uJHJ0TYjJS7WM/2R52fluaRJULUM
         ECtYP9CsxKQvfEQA1Yo5UXhKoDzJ+nqbCgVoCLSJY4sT7Goyz+dxjSzRfXTTFxTNgzXG
         nHnJzssFp53tZI4A4sYt2kXbuCKPj7rUTg1bU/1FbVTf6ScI/k4gDg9vHxiO/WydAV+w
         pEtb6Tff5zup9ann3xb0Ek/QJe308UT4sHKExgsVGeh3K77J85/N35Jz5WZcqH1ZI9Gn
         1TwmlYl5GiZPY7+Qddv3YNiHiYXfZROo/xjSfbXLjm45UEvTH2oTfTovQxZ/IXN3Q7Xj
         ALxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vPzV3+wkeUfRoOQi+Ln3ww49AQZvsG1boIOkNO2vCs4=;
        b=iXvZn4FLFaHwIMREqWl7/1p574+ONRPWBwpXBigRoDBMOnuTRchOkUE0O6uPttsaHC
         Kcdfthf/kuMZu4m2tVa1OAqBmV4aJHlF87QSOkLL4DBxcrJsKWNwMw+L5HYQby4OWTpf
         OoqbKkl2bUkQufRYDB1D36rmGDj/4uLZ/f2L5uBbTIEBTeu74+rSRTD6Go+2Y8O62uqx
         9Sxgi+61DKpDKrBk+fkE/7zbYYoKgPK20XDVTf3V+vbPLfMXNzTfAmVwQMqb9s5hEulR
         2ONYSKYOpQ6Ozzw4sBVYgq+abcVJ7NCyIk/skD0MfkZWjOSFqPvfpA439azRLevkJkFd
         uWlg==
X-Gm-Message-State: AOAM533v+eBLXy8srNAxha62RSW8rmOsVDagNzeBcFsb7ARr4L2qsQjr
        XSEu35dz/zH0FryslbFaZpFRwA19WyH1a8+AjPI=
X-Google-Smtp-Source: ABdhPJzDaKRH0rrEq+qtUFRiNPVT3Pn/hqQWooiMUJ/VfBlgtiETibDWKKL+AObO7DhzBRSLag1bTHrXvgxOFlGVPH8=
X-Received: by 2002:a05:6602:45d:: with SMTP id e29mr37042616iov.202.1638825006153;
 Mon, 06 Dec 2021 13:10:06 -0800 (PST)
MIME-Version: 1.0
References: <cover.1638308023.git.andreyknvl@google.com> <b82fe56af4aa45a0895eb31f8e611f24512cf85b.1638308023.git.andreyknvl@google.com>
 <YaoI6qgQEmzNU/In@elver.google.com>
In-Reply-To: <YaoI6qgQEmzNU/In@elver.google.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Mon, 6 Dec 2021 22:09:55 +0100
Message-ID: <CA+fCnZfE-6zwuPySgMH6r4A=j151uBZvFP3wzOKvAD6JNLgLkQ@mail.gmail.com>
Subject: Re: [PATCH 28/31] kasan: add kasan.vmalloc command line flag
To:     Marco Elver <elver@google.com>
Cc:     andrey.konovalov@linux.dev,
        Alexander Potapenko <glider@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Evgenii Stepanov <eugenis@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 3, 2021 at 1:09 PM Marco Elver <elver@google.com> wrote:
>
> On Tue, Nov 30, 2021 at 11:08PM +0100, andrey.konovalov@linux.dev wrote:
> [...]
> >  enum kasan_arg_stacktrace {
> >       KASAN_ARG_STACKTRACE_DEFAULT,
> >       KASAN_ARG_STACKTRACE_OFF,
> > @@ -40,6 +46,7 @@ enum kasan_arg_stacktrace {
> >
> >  static enum kasan_arg kasan_arg __ro_after_init;
> >  static enum kasan_arg_mode kasan_arg_mode __ro_after_init;
> > +static enum kasan_arg_vmalloc kasan_arg_vmalloc __ro_after_init;
> >  static enum kasan_arg_stacktrace kasan_arg_stacktrace __ro_after_init;
>
> It just occurred to me that all of these (except kasan_arg_mode) are
> only used by __init functions, so they could actually be marked
> __initdata instead of __ro_after_init to free up some bytes after init.

*Except kasan_arg_mode and kasan_arg. Both are accessed by
kasan_init_hw_tags_cpu(), which is not __init to support hot-plugged
CPUs.

However, kasan_arg_stacktrace and kasan_arg_vmalloc can indeed be
marked as __initdata, will do in v2.

> [...]
> > +     switch (kasan_arg_vmalloc) {
> > +     case KASAN_ARG_VMALLOC_DEFAULT:
> > +             /* Default to enabling vmalloc tagging. */
> > +             static_branch_enable(&kasan_flag_vmalloc);
> > +             break;
> > +     case KASAN_ARG_VMALLOC_OFF:
> > +             /* Do nothing, kasan_flag_vmalloc keeps its default value. */
> > +             break;
> > +     case KASAN_ARG_VMALLOC_ON:
> > +             static_branch_enable(&kasan_flag_vmalloc);
> > +             break;
> > +     }
>
> The KASAN_ARG_STACKTRACE_DEFAULT and KASAN_ARG_VMALLOC_ON cases can be
> combined.

Will do in v2.

Thanks!
