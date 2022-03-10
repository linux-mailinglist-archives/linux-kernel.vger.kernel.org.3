Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC0134D53EC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 22:52:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244736AbiCJVvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 16:51:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344103AbiCJVvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 16:51:16 -0500
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F274919417D
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 13:50:13 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-2dbd97f9bfcso73849697b3.9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 13:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RugAVh3UxY4wxouftMk7HSkCKZXxSMxitrpzMJUbDGw=;
        b=yumWmESADJuFPPmH+EtMDxkbnBz3MrLfSXwMRNgdxayrVqgqXQjF+dFfpG09SB8AgZ
         Vt2seFJlz7xwGqzYUlfnyY09fgqq2EqR4V0HqvkvxQKQT8tD4FWh+pBf3odrlgvCIwcY
         dayBgw0BltAr1ix3kX0FiKz9v92+vM77KpWar3Jne6OJxNSR/2NvyPHjJ8VhbFXQYY8n
         rkh9DcU+fIx9EiFqffBVlKtQMoXQc0CNPbH/qSzX+yl7S8TMaDSZw4+sp5tk1Xxxxr1z
         2MRxRyl6Ib0CCQrWM46LdlUUrgLAF4JYHEuiIEAwbvwPx5Yu8SyUzTB7nFGeZnDciiIO
         n3NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RugAVh3UxY4wxouftMk7HSkCKZXxSMxitrpzMJUbDGw=;
        b=QYHIbxcN8PV44m7w7wnc85+nr4N0WFbZo0GAl45/EoUQMlE5zy/PvGLJtozyH+OTb6
         xEEd90Skcnlgq3oUo8B7KnvjEWYZjCzhD2AlhfeNNnIj003+ybSDNYcCAk8BNKywlbf5
         Ea1SkGk37uyTf0JGmAK9FsSvlBTuhhnvUve1MwzcY1ih0SAyZ2VPzWwAVAjvHOAdOGVU
         wuiPMsDWV76Ll84xPPaH8Wbz2vjMMWQjjYT5nPJqJ1EnA3X7YOrGQMA0sTrJY04r0J4F
         Rr2VwSXXT05q5aMc0urDGZ/JeZiPebHtZQ1Xx+1Uxo6yNRjVxpNryFOaSBpMqbNpncsF
         c0eg==
X-Gm-Message-State: AOAM533k8sLy4XTVYbMf008vhaWs07THVlvkq04woAvTOzLmPZ5/+kL8
        0YxXR1WKcY8VR4PFEv+NfUddhyoiDnB8IHZS+zBo5le4C3E0Zfe3
X-Google-Smtp-Source: ABdhPJy+ZRYKSMj0R6GUYoyQw0PK9dinkwFaI6DzHdB9OxXJb0bgmX5v2PdS8AZp7tYTIlZYBPGLeMwmY8a9EeZwX64=
X-Received: by 2002:a81:2f12:0:b0:2d7:d366:164a with SMTP id
 v18-20020a812f12000000b002d7d366164amr5982945ywv.265.1646949013038; Thu, 10
 Mar 2022 13:50:13 -0800 (PST)
MIME-Version: 1.0
References: <CAMj1kXEFZVeWLaRQJmwO+Nn6uW4q6vXJOaNNTVKju1p2bMQksA@mail.gmail.com>
 <YijCkHHhpleeADAO@shell.armlinux.org.uk> <CA+G9fYtjrAMg8TykZdRyZEfRthyqom_73x87F-60C_QFeEL8Bg@mail.gmail.com>
 <YijfzAhWAgfGGqCO@shell.armlinux.org.uk> <CAMj1kXFvjawvOzeTb2m1H=P-_aXgW-ozvaOK1FtjBv7G0sCDFA@mail.gmail.com>
 <Yij2cZVKwPexGsTf@shell.armlinux.org.uk> <CAMj1kXE02HH7vRUjF3iKAL+1idKTy-oOYyGnBd3g90m6eObBxg@mail.gmail.com>
 <YikByJteDEtKi4Xv@shell.armlinux.org.uk> <CAMj1kXGnwbe=YYWaRxaXioEfTJOdXg9JYcNddO8iifpWLRZCWg@mail.gmail.com>
 <Yinwq3Z9l0selLLS@shell.armlinux.org.uk> <Yin2jQqW+pUWJZ7E@shell.armlinux.org.uk>
 <CAMj1kXGkUJ=-4oA4GvBZNK94A1MrZ7UwKDN_tJRgwq8KF06VmA@mail.gmail.com>
 <CA+G9fYvEANOMekjvtu7agdVYQ_b8OMtxQdyAV2JT_vMdBU3VRA@mail.gmail.com> <CAMj1kXEVVZTKX_86bbTfLpFuDriV0-uwCMgSKDP+dzcD1L4XCw@mail.gmail.com>
In-Reply-To: <CAMj1kXEVVZTKX_86bbTfLpFuDriV0-uwCMgSKDP+dzcD1L4XCw@mail.gmail.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 11 Mar 2022 03:20:02 +0530
Message-ID: <CA+G9fYuO-sy+sZnhSz=A7Xm0LdSp2AT+7jCKLB33tZzK4izj3g@mail.gmail.com>
Subject: Re: [next] arm: Internal error: Oops: 5 PC is at __read_once_word_nocheck
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Mar 2022 at 02:55, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Thu, 10 Mar 2022 at 22:18, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> >
> > Hi Ard and Russell,
> >
> > The boot test pass on linux next-20220310 tag with  KASAN=y on BeagleBoard x15
> > device. but LTP cve tests reproduced the reported kernel crash  [1].
> > From the available historical data I can confirm that this is an
> > intermittent issue on
> > BeagleBoard x15 devices.
> >
> > OTOH, the kernel crash is always reproducible on qemu-arm with KASAN=y
> > while booting which has been known to fail for a long time.
> >
> > From the Ardb tree I have boot tested qemu-arm with KASAN=y the reported
> > kernel crash is always reproducible.
> >
> > The build steps [3] and extra Kconfigs.
> >
> > - Naresh
> > [1] https://lkft.validation.linaro.org/scheduler/job/4701310
> > [2] https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/
> > [3] https://builds.tuxbuild.com/2661dIAPUjE2DMJvye91He2gus0/tuxmake_reproducer.sh
>
> Thanks Naresh. I'm having trouble to make sense of this, though. The
> linked output log appears to be from a build that lacks my 'ARM:
> entry: fix unwinder problems caused by IRQ stacks' patch, as it
> doesn't show any occurrences of call_with_stack() on any of the call
> stacks.
>
> Do you have a link to the vmlinux and zImage files for this build?

Yes.

vmlinux.xz:  https://builds.tuxbuild.com/26BmIasJnAyCii0SkgbKarkF369/vmlinux.xz
zImage: https://builds.tuxbuild.com/26BmIasJnAyCii0SkgbKarkF369/zImage
System.map: https://builds.tuxbuild.com/26BmIasJnAyCii0SkgbKarkF369/System.map
Build log: https://builds.tuxbuild.com/26BmIasJnAyCii0SkgbKarkF369/

- Naresh
