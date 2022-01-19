Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5A749368E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 09:49:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352591AbiASItq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 03:49:46 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:43209 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352570AbiASItn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 03:49:43 -0500
Received: from mail-wm1-f51.google.com ([209.85.128.51]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MDy54-1n0FHu0eto-009uaz; Wed, 19 Jan 2022 09:49:42 +0100
Received: by mail-wm1-f51.google.com with SMTP id q141-20020a1ca793000000b00347b48dfb53so4445691wme.0;
        Wed, 19 Jan 2022 00:49:42 -0800 (PST)
X-Gm-Message-State: AOAM531HpSMBtNzwKTRQ8WcxXAoH8J/QkIosXqJDLL07moPbMkSZACiR
        lIAKMN2q9UJX4gfm9PhTtPULXNAVQCPyyQRDZEg=
X-Google-Smtp-Source: ABdhPJxf3RtweRtU+CatTOtSpLEk3AYaK311IymBkfKp4ZAtysVZK4i4XHZhQpD0dg01dfcz9lpKSApJdra8Z56WbAg=
X-Received: by 2002:a1c:2784:: with SMTP id n126mr162213wmn.1.1642582181746;
 Wed, 19 Jan 2022 00:49:41 -0800 (PST)
MIME-Version: 1.0
References: <20220119000506.1299843-1-laurent@vivier.eu> <20220119000506.1299843-3-laurent@vivier.eu>
 <CAMuHMdXSFU4N+FLYkCLJCJcWJ74g=8Vr23Rx0cka-kDTBs6Z4Q@mail.gmail.com>
In-Reply-To: <CAMuHMdXSFU4N+FLYkCLJCJcWJ74g=8Vr23Rx0cka-kDTBs6Z4Q@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 19 Jan 2022 09:49:25 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2fjbet+nNAVt_WUxedUDWdRwb880KEa+MY1cFwYNC4SA@mail.gmail.com>
Message-ID: <CAK8P3a2fjbet+nNAVt_WUxedUDWdRwb880KEa+MY1cFwYNC4SA@mail.gmail.com>
Subject: Re: [PATCH v10 2/5] rtc: goldfish: introduce goldfish_ioread32()/goldfish_iowrite32()
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Laurent Vivier <laurent@vivier.eu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        John Stultz <john.stultz@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-rtc@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:v6OniHMlZ2asXvsuvt5xjGOjmnpN2NziXswL6PV4E5EO0BjikRy
 nBP0rrJpGswFUFl8kCQWx1pLn4tPpgeLLqqN8IrCLKrqVTLSqPrd+FoU/Uhf44ar+Lbg71L
 FUIRwQyu0K11kOGvK3stquu+xIYC0wvj1rIa/uqUGFvYBdapQHf5IXda7eBlYuLP/K/AX/r
 CB14/zRDy5mymMZIah1IA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:I0+iep35erY=:H+hrOWw6j1pjB69vROamaW
 jcp9SWBBJR8Gl0uPZzyeAsQmEPPvCwOEdeAetL6wF6g8qDCKYg9GLWN4+o6cOOx53GXciX65/
 JfIy6KPE9j1LQmjQc5lyggZvspPIqJJg51tyUeKLJMdgDBwIDFLRKRZAUPvipFJ3cQwR13ppy
 /I5MlPGgHjx184IpZmjsrkfI6Vh1Pk38dxD0F6VAL4AzzIoW+aZvAuA8m3L38UTgUkjCM2Wzx
 qII+LhOkLH+qrt1qOKcfd44IlYQzaQZB1Wiv+8Joa+bIGZXVzCdmM3aajy959wz/K0qBQepZO
 MCWSBXJpjyevKHZa1Dp8V++4geuh94McU7BZwr9w1fKrH1vHrXCyB9RDzutnytGU7LkfwhY7b
 /Qm5vIYvmWOjkuSlIljZyxNKPsroGs8tZbOGWkfTb637IzGKqjIzE7WZjdrsfEQwgK3vePZqP
 0pxJ5HZy4xuYN4Iq3fDMG7SuJWElpj1cBwxMgFdNHrO4jcenKF/U9qAkMlqeZfQxRGIaxYgdr
 ZYZwRPBvCplavKHWabgOUwTLUPXlWQtqJr4/Kan9sbCerSNK0xrWj8MAfAvhfMqJ/sIXc61Na
 64vAl4WWzIKoLkzj7QkmrHhGikLXQgyOKrL1VEYaVBmQlQC298Dt+IzMW851uE9WJlpCzGyhN
 lRX9R60faA0fe90yfUUISfFuV+RGBB8AWHcSmUTW4w8lQfqMuH9T+s/ONq3DOl5ar6xI=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2022 at 9:21 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Wed, Jan 19, 2022 at 1:05 AM Laurent Vivier <laurent@vivier.eu> wrote:
>
> I've just discovered include/linux/goldfish.h, which already has gf_*()
> accessors for 64-bit, so it'd make sense to move the above there,
> and adjust the names.

Yes, good idea.

>
> Arnd: note that the existing ones do use __raw_writel().

It looks like Laurent introduced that bug in da31de35cd2f ("tty: goldfish: use
__raw_writel()/__raw_readl()") and could fix it up here. Laurent, was the intent
of this earlier patch also to make the driver usabel for m68k, or are there
any other targets you looked at that had mixed up endianness?

       Arnd
