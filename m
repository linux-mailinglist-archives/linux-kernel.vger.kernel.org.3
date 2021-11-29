Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1405C4617D8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 15:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243757AbhK2OVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 09:21:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244340AbhK2OTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 09:19:10 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEFE2C08EAFC
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 04:56:36 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id z18so21320070iof.5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 04:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CKtqbicwgTdzcfDDVJ9s3/qtMRbUgp3KQEuBry1DrH0=;
        b=BPmA997oheI0tE7nHCG5PwmGspFGrUsXVCpyn8D8CtPKr+F5e9+xwlnaqLvM0rJU4f
         Ckk8pnztz7hPZSgGcQhBpbjtFlcmH0pNWGeFh+zZatoqU6AnWPh/ghPD1bE6EGM3O2C4
         FnH2KyEEJvZn4hC0kc6NVhQuuNU0iPZPFPVnwl4l7V+Msk3wCPxsp3LleKtGX22RR8c1
         PprsBE3zfb0Z+hFX0y/CIvUXORIrpSzA7EiJyBUzsOUtpJEVf62Do9aW4INNOncJDGx5
         ePypANBqmKdP4N849jIBJoiIezlK90la72j2mbFaT1oxE5veAGnZcI+Hz136x9WtVio7
         bdIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CKtqbicwgTdzcfDDVJ9s3/qtMRbUgp3KQEuBry1DrH0=;
        b=ZQWWsXmYJVgVFvloNjGl9NmShinbcJQJvZ+a5kCftuTDMAXyPPv2y6YTGC9yEqQaB6
         7USzCjvYB0a8IxRrqk6v2RMHLsA16cO54yriqojIJDp+Z6u4vGWWnN0AicR/Xkc159bI
         UgI+wZ5N2FS3sesCpyQWxjPf+yURp8ytf/GZU0tEWwFLXbouXEvgQ3B0cJGQgmhBavjm
         WxHMopzAas8dmlR+e6fWxEljXQAMFTcTqZZtTFsRP3JVeJztaKfKN4vRprs7/JlusNwi
         YWM1xbwi+ZtrZJEufPs3iJsPTWCcTu4t+tDLdam9wII3jONzpR/bPYfaXqUttzjh64Ju
         VBgg==
X-Gm-Message-State: AOAM533zOFksSRvXTHKeXv8YGEYW9g+gRLB6RHpKkEg8Gtdy/8AbKY6i
        Hhf6xQlcz+6pObVbj5vo6Nk1Pg5EgNigMJe8xoo=
X-Google-Smtp-Source: ABdhPJz7yZAFjWS5SVbcrm3cGqLW78HumxClnBHVEWpGf9HWaajytm8B78/wqo9qOBZcQKb+qHQjV2oYVaHMpPgRqC0=
X-Received: by 2002:a5e:9b0e:: with SMTP id j14mr59665497iok.127.1638190595204;
 Mon, 29 Nov 2021 04:56:35 -0800 (PST)
MIME-Version: 1.0
References: <CANiq72kGS0JzFkuUS9oN2_HU9f_stm1gA8v79o2pUCb7bNSe0A@mail.gmail.com>
 <CACT4Y+Z7bD62SkYGQH2tXV0Zx2MFojYoZzA2R+4J-CrXa6siMw@mail.gmail.com>
In-Reply-To: <CACT4Y+Z7bD62SkYGQH2tXV0Zx2MFojYoZzA2R+4J-CrXa6siMw@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Mon, 29 Nov 2021 13:56:24 +0100
Message-ID: <CA+fCnZcUEVDWZTUvD+mbe2OrnrpJCC_OB66YMvbZYak8sKg7cw@mail.gmail.com>
Subject: Re: KASAN Arm: global-out-of-bounds in load_module
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2021 at 7:37 AM 'Dmitry Vyukov' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
>
> On Sun, 28 Nov 2021 at 01:43, Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
> >
> > Hi KASAN / Arm folks,
> >
> > I noticed in our CI that inserting and removing a module, and then
> > inserting it again, e.g.:
> >
> >     insmod bcm2835_thermal.ko
> >     rmmod bcm2835_thermal.ko
> >     insmod bcm2835_thermal.ko
> >
> > deterministically triggers the report below in v5.16-rc2. I also tried
> > it on v5.12 to see if it was a recent thing, but same story.
> >
> > I could find this other report from May, which may be related:
> > https://lore.kernel.org/lkml/20210510202653.gjvqsxacw3hcxfvr@pengutronix.de/
> >
> > Cheers,
> > Miguel
>
> HI Miguel,
>
> 0xf9 is redzone for global variables:
> #define KASAN_GLOBAL_REDZONE    0xF9  /* redzone for global variable */
>
> I would assume this is caused by not clearing shadow of unloaded
> modules, so that the next module loaded hits these leftover redzones.

Hi Miguel,

Adding to what Dmitry mentioned:

The code that's responsible for allocating&clearing/freeing shadow for
modules is at the very end of mm/kasan/shadow.c. It's only required
when CONFIG_KASAN_VMALLOC is not supported/enabled.

As 32-bit arm doesn't select HAVE_ARCH_KASAN_VMALLOC, perhaps it needs
something along the lines of what kasan_module_alloc() does with
regards to clearing shadow? I assume arm doesn't call that function
directly due to a different shadow allocation scheme.

Just a guess.

Thanks!
