Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F32047B079
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 16:40:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236341AbhLTPkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 10:40:02 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:49347 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbhLTPkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 10:40:01 -0500
Received: from mail-wr1-f54.google.com ([209.85.221.54]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1M8hMt-1n41bK3RBJ-004jkf; Mon, 20 Dec 2021 16:39:59 +0100
Received: by mail-wr1-f54.google.com with SMTP id j18so21002597wrd.2;
        Mon, 20 Dec 2021 07:39:59 -0800 (PST)
X-Gm-Message-State: AOAM531K4tCtk58OTys5yK8vogqrbO3YF9GlwaxJz8YbT2J8+Idw7LlE
        JeHE46iDXibwkbbEEd1qG7PMYr6Gob5e2RunbN8=
X-Google-Smtp-Source: ABdhPJwyf1gl42e1+1ii3zT0maFx9sw6pqM+dmpJrc6Cp5f8QnUR5djHD7r/X/OWPoyaJf/hbjF5DreC2K3feE7WjvE=
X-Received: by 2002:adf:f051:: with SMTP id t17mr13408714wro.192.1640014799482;
 Mon, 20 Dec 2021 07:39:59 -0800 (PST)
MIME-Version: 1.0
References: <20211218085843.212497-1-cuigaosheng1@huawei.com>
In-Reply-To: <20211218085843.212497-1-cuigaosheng1@huawei.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 20 Dec 2021 16:39:43 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1-0u4VCCfgc7tjmnANM0yr7oUrQX2y-ZSVvZHDN191BQ@mail.gmail.com>
Message-ID: <CAK8P3a1-0u4VCCfgc7tjmnANM0yr7oUrQX2y-ZSVvZHDN191BQ@mail.gmail.com>
Subject: Re: [PATCH -next 0/3] replace open coded VA->PA calculation
To:     Gaosheng Cui <cuigaosheng1@huawei.com>
Cc:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>,
        SoC Team <soc@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES" 
        <linux-samsung-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        gongruiqi1@huawei.com, wangweiyang2@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:0gArGAU/6xkyPS/OO+lrntkvNVVGNM1vGVCTqQ7uZnBtlqSoIE6
 VjFtW3tUIEw5Sq6L5XGRHwtl7142fPoTYCgVGL5oV3uCiZks1xXVL6sN2OqRYZM79KLCdrX
 NjM9D8Rfz0wdgxQF3w9uowT7ilSXe8U3BWlOtU/v6qoR+bxjK6f9K2tIVKLyZ7BZBgNw/pG
 391KbQxz6cw4WMQV92lrA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:/cmRBXKXLEc=:RfvIVqDBoEDZIaNLseXoCB
 o8z1MEJkl6yTEeOHwy2MfKsNo3+1EzdiyWtA3LpYO+ItCYqvQhMYfkrp6IuWunYijaqZui7Yz
 Qtg7hbgSolFRbwvuuOp+gyTYEgJHSlOuS+jpIXCzG3mOyrLl2fYHEjwuL418qjKJEdSmqippp
 SFBLewJ+A88DkJKJ/nSTtQbNwqdzftA9lvT6PwYTswmV3h3oJ5NMQ+4X3cywoxN+FaCtvfgu0
 35DUh4bnEsci2KsCojmb+LbIpHJITABjlbdc150+iHUMYt7V3NZiZtncNrRZ4YEGY3OXnSVhJ
 mDQwIpgoTkJa8D3TDml85JfuKIUv8pJVHayv8cvIY72EHD58likXt2w56UnOBzScQ8aZdjwHD
 Qe5Dpb0VkfqVgn8BviVUIwofLYYHdjZ4o3iD2ZLuLc4ulhM2/+oDh+ndnJE38REUJTP0mlg5c
 u4qstfFA0MA94+obUgOhgsqCdVOHZIJcY6Sylsja1JZYC1blpnejai0PBtpHORkmnhdoIWLgT
 bIVeBiim7qVimcPRaTv/hLUKCjBjib/xXAWCeo9lvldmUR2njk3aKgqME4aMIKsW2Od56r0k9
 XPWNqn/h5rVvePNNAsRB1Wrer+hFa3LyBMl+O67KyFyHryO7e7qVvvbCwZKbiDv2kQ7PbbmCj
 fb1tMNrK/YeFlgB9GxV6eEhpEuu3n0SwysfvJxAAyn8x4ikbiBQYVeJagatQSIYGDMUB7gz+i
 gJQc+3y9K3Tg59YVfQheiCW701FwVoQ7K0jJbwzXNI5cvqmFqr7D9HFI06FznJNle1SvCSpBW
 4L/zKGD4zw14LHgj68837WDkZKQhEaOfeQIFgK98blhzCgeV04=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 18, 2021 at 9:58 AM Gaosheng Cui <cuigaosheng1@huawei.com> wrote:
>
> These patches replace an open coded calculation to obtain the physical
> address of a far symbol with a call to the new ldr_l etc macro, and they
> belong to the kaslr patch set of arm32.
>
> Reference: https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/?h=arm-kaslr-latest
>
> Ard Biesheuvel (3):
>   arm-soc: exynos: replace open coded VA->PA conversions
>   arm-soc: mvebu: replace open coded VA->PA conversion
>   arm-soc: various: replace open coded VA->PA calculation

Usually these patches should go through the respective platform
maintainer trees,
and from there into the soc tree, but time is a little short here.

I could apply them directly with the maintainer Acks, but I don't understand
the significance of you sending them now. Is something broken without the
three patches? Are these the only ones missing from Ard's original series,
or is this preparation? Would you expect the patches to get backported to
stable kernels?

       Arnd
