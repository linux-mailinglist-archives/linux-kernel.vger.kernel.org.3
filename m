Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E53E47EAC5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 04:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351101AbhLXDOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 22:14:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351076AbhLXDOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 22:14:02 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE78EC061401
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 19:14:01 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id i9so3549310oih.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 19:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i+p7JMtxiJhKbk+HUedbmrpIzQr2u83bgpY8rPoMJJA=;
        b=pskhFOzCnGEdju9s5EhQoo+ZNY1bCn5Wr/ci04PuSe0X1TX6IJKJq+Qb0hy3m3gmev
         Y8AKXJMkspitxSXNVhTA6pD26Pr49RNvYAztpYZKEEf3xvZFzFviCBka9lL8wEhRSXZA
         71LJ0oDHrHycvWhQZKzm7X9MVf4qS+Oau3gFtpWF/AawX93Ushill2r3/Fx8/u/Cb6nj
         zIallqUZkUXHOBwHpNUIaAoJ1uSrL665NfYHbtTLBCXeqFtk8HFG7Y/ZnlDv1WvJvJwS
         XDECikXEj4ofg5S5eBAG2yoJvHxxi2EfCENYWPuNmHrdwZTGA891CVoXpD3YBG3XIGbe
         3d+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i+p7JMtxiJhKbk+HUedbmrpIzQr2u83bgpY8rPoMJJA=;
        b=iwYe42sMI1Fi+DBndussPzicrKEENyj59OQ+eKVVaPHl8ebPzIgXe7GUXjT80n60ja
         bouPrz6VqIKlxGemlqzOJnM7s3Xz+UczWqwRQsIq5VVAks/8/FFKALGRwM4o42zGeIoC
         mj6BM+AQXaq9gQCu6LJHkOQYIXAEGv3l1MR3RSd08+jo+ai8tIunXTqw2m+23F0N8Muh
         sAQUP96ny2mJOR8Pu3CpKxLccwbPKcvM929Wu8yHbR1JTxmVhVeyU2kY5UeGFleXCM+2
         AuibJuQfzff8olH4qwGEMBJ3o5VK5t8pP0fjbxTcD8xwjiopFLVNtV49SaDmM9EKOyRv
         hEXg==
X-Gm-Message-State: AOAM532n5S2mCUXcwylRfeZ7kvJS9lcRi56R7FJf90N/H8djvVXsJ1Ur
        /GTy31kdSZ330GZ1ZwWQnTCaMiBWddzwYvmksDAAtg==
X-Google-Smtp-Source: ABdhPJxHSnVNs3ApHjh2RKvlFsUpUtEw5fQs/N7STxMDeXGWX6Yj0Aa4HW5EWu9ZNUowT0Dj4Q0Pc5ojVlEHJei3IDM=
X-Received: by 2002:a54:4613:: with SMTP id p19mr3571744oip.162.1640315641099;
 Thu, 23 Dec 2021 19:14:01 -0800 (PST)
MIME-Version: 1.0
References: <20211223101551.19991-1-lecopzer.chen@mediatek.com> <CAMj1kXGL++stjcuryn8zVwMgH4F05mONoU3Kca9Ch8N2dW-_bg@mail.gmail.com>
In-Reply-To: <CAMj1kXGL++stjcuryn8zVwMgH4F05mONoU3Kca9Ch8N2dW-_bg@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 24 Dec 2021 04:13:49 +0100
Message-ID: <CACRpkda_42LSWcaq0Q8aGB+12bo2494snk1Tua62UTLjVE1fQA@mail.gmail.com>
Subject: Re: [PATCH] ARM: module: fix MODULE_PLTS not work for KASAN
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Abbott Liu <liuwenliang@huawei.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>, yj.chiang@mediatek.com,
        "# 3.4.x" <stable@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 23, 2021 at 12:01 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> On Thu, 23 Dec 2021 at 11:16, Lecopzer Chen <lecopzer.chen@mediatek.com> wrote:
> >
> > When we run out of module space address with ko insertion,
> > and with MODULE_PLTS, module would turn to try to find memory
> > from VMALLOC address space.
> >
> > Unfortunately, with KASAN enabled, VMALLOC doesn't work without
> > VMALLOC_KASAN which is unimplemented in ARM.
(...)
> This is not the right place to fix this. If module PLTs are
> incompatible with KAsan, they should not be selectable in Kconfig at
> the same time.
>
> But ideally, we should implement KASAN_VMALLOC for ARM as well - we
> also need this for the vmap'ed stacks.

I also need it for my kernel-in-vmalloc patch, I guess it's the
reason why I can't seem to get it to work. So a lot depends on
this.

Yours,
Linus Walleij
