Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFC63461B8C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 17:09:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344018AbhK2QMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 11:12:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344117AbhK2QKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 11:10:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B6DC08EA74
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 06:11:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 77A89B8111B
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 14:11:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 411B6C53FCE
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 14:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638195083;
        bh=x7gANHXCj9D2jHArSELv0y5uHzyFEQHNRCPsvkTF7Ig=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iNUsntFyxDfkFs/HGTqojPv+3tLdNcEC6oBQRPlXoTB0CVQRJHniOMQeocKDGbXez
         z9Kohzcm3ftOZyq3oRq0RZyVqSrwR1v3ou7PwWIayS/KGeuLASLNyz4LyVWhHV6fZ3
         SDhocSeSec8g+jR3FuQb+zPyG0HKsoWvxg6IZ0bDU+8HPjKfOSpK3666oQazAX5+rf
         caj7GS2Q3UTzyy1DhQmh25AOzdaoF+qC6wQoTjf/s7aMyUolupsQ3V8SYsHh7xsDS0
         Q95zfpdOIv6fyH6fBt2lR70PKnjGdWJjK13izpyWbWcxyP6qpr63haYXwnRGWH0lMB
         q6jmDDVZ14xGQ==
Received: by mail-ot1-f54.google.com with SMTP id 98-20020a9d086b000000b0057a403bbd4eso1037954oty.13
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 06:11:23 -0800 (PST)
X-Gm-Message-State: AOAM5307u4E/zXQ3+OawqU86QU49eiTaMmBhMx00GtNyBMQmR5un3ijv
        G7QqDiKR1XqSbixnrCe7jclzAnbf/YQgpSnIyJM=
X-Google-Smtp-Source: ABdhPJy+sCJisvcqc004QkFyRiHpYJFr+ExQOffMyO3CNLI9sMiM9JhpV7VLeTt4wPEZ2Wa4UwdsXjGAF7oyGrkMt9Q=
X-Received: by 2002:a05:6830:1514:: with SMTP id k20mr43746692otp.147.1638195082500;
 Mon, 29 Nov 2021 06:11:22 -0800 (PST)
MIME-Version: 1.0
References: <CANiq72kGS0JzFkuUS9oN2_HU9f_stm1gA8v79o2pUCb7bNSe0A@mail.gmail.com>
 <CACT4Y+Z7bD62SkYGQH2tXV0Zx2MFojYoZzA2R+4J-CrXa6siMw@mail.gmail.com> <CA+fCnZcUEVDWZTUvD+mbe2OrnrpJCC_OB66YMvbZYak8sKg7cw@mail.gmail.com>
In-Reply-To: <CA+fCnZcUEVDWZTUvD+mbe2OrnrpJCC_OB66YMvbZYak8sKg7cw@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 29 Nov 2021 15:11:11 +0100
X-Gmail-Original-Message-ID: <CAMj1kXH7D-0bhv79cRPergquC8-ryCi7YvTokHSaJ14ZHd_F8w@mail.gmail.com>
Message-ID: <CAMj1kXH7D-0bhv79cRPergquC8-ryCi7YvTokHSaJ14ZHd_F8w@mail.gmail.com>
Subject: Re: KASAN Arm: global-out-of-bounds in load_module
To:     Andrey Konovalov <andreyknvl@gmail.com>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Nov 2021 at 13:56, Andrey Konovalov <andreyknvl@gmail.com> wrote:
>
> On Mon, Nov 29, 2021 at 7:37 AM 'Dmitry Vyukov' via kasan-dev
> <kasan-dev@googlegroups.com> wrote:
> >
> > On Sun, 28 Nov 2021 at 01:43, Miguel Ojeda
> > <miguel.ojeda.sandonis@gmail.com> wrote:
> > >
> > > Hi KASAN / Arm folks,
> > >
> > > I noticed in our CI that inserting and removing a module, and then
> > > inserting it again, e.g.:
> > >
> > >     insmod bcm2835_thermal.ko
> > >     rmmod bcm2835_thermal.ko
> > >     insmod bcm2835_thermal.ko
> > >
> > > deterministically triggers the report below in v5.16-rc2. I also tried
> > > it on v5.12 to see if it was a recent thing, but same story.
> > >
> > > I could find this other report from May, which may be related:
> > > https://lore.kernel.org/lkml/20210510202653.gjvqsxacw3hcxfvr@pengutronix.de/
> > >
> > > Cheers,
> > > Miguel
> >
> > HI Miguel,
> >
> > 0xf9 is redzone for global variables:
> > #define KASAN_GLOBAL_REDZONE    0xF9  /* redzone for global variable */
> >
> > I would assume this is caused by not clearing shadow of unloaded
> > modules, so that the next module loaded hits these leftover redzones.
>
> Hi Miguel,
>
> Adding to what Dmitry mentioned:
>
> The code that's responsible for allocating&clearing/freeing shadow for
> modules is at the very end of mm/kasan/shadow.c. It's only required
> when CONFIG_KASAN_VMALLOC is not supported/enabled.
>
> As 32-bit arm doesn't select HAVE_ARCH_KASAN_VMALLOC, perhaps it needs
> something along the lines of what kasan_module_alloc() does with
> regards to clearing shadow? I assume arm doesn't call that function
> directly due to a different shadow allocation scheme.
>

Side note: vmap'ed stacks support is being added to ARM,  so it would
be worth it to investigate whether we can support
HAVE_ARCH_KASAN_VMALLOC on ARM as well, otherwise we cannot enable
vmap'ed stacks and KASAN at the same time.
