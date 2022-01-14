Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F89248E49B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 07:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239422AbiANG5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 01:57:48 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:55947 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239408AbiANG5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 01:57:46 -0500
Received: from mail-wm1-f53.google.com ([209.85.128.53]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MnaY1-1mRGGb1eKr-00jcWt; Fri, 14 Jan 2022 07:57:44 +0100
Received: by mail-wm1-f53.google.com with SMTP id c126-20020a1c9a84000000b00346f9ebee43so5051962wme.4;
        Thu, 13 Jan 2022 22:57:44 -0800 (PST)
X-Gm-Message-State: AOAM531Th2sMFHwb2/hxVNdC6Gg8x5+6Quk0UDxckvBoVdC2qoLQCDTk
        m/5lM+SgpJ/M3B1oqYe16VD8y04zjwv/yefUm8s=
X-Google-Smtp-Source: ABdhPJwwQhITLnWsKboPk0/GB6llV0E9xXAfPiCmzUJOvXgqzfiwsoK69qPL6kniPU2RdMPLej4odQ7iw1aqRAhtEyo=
X-Received: by 2002:a05:600c:5c1:: with SMTP id p1mr14161704wmd.1.1642143464069;
 Thu, 13 Jan 2022 22:57:44 -0800 (PST)
MIME-Version: 1.0
References: <20220113201920.3201760-1-laurent@vivier.eu> <20220113201920.3201760-3-laurent@vivier.eu>
In-Reply-To: <20220113201920.3201760-3-laurent@vivier.eu>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 14 Jan 2022 07:57:27 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1H6-sd_+FqnOq0Zhj=L51EWuW5VCcYeTENcp3+PkTC4Q@mail.gmail.com>
Message-ID: <CAK8P3a1H6-sd_+FqnOq0Zhj=L51EWuW5VCcYeTENcp3+PkTC4Q@mail.gmail.com>
Subject: Re: [PATCH v6 2/4] rtc: goldfish: use __raw_writel()/__raw_readl()
To:     Laurent Vivier <laurent@vivier.eu>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        John Stultz <john.stultz@linaro.org>,
        linux-rtc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:CKcd6D42JC/5gSKbPK/ekaSQVq+Jk+wk09ytaypJ68IosfXhLPT
 V3IhT0Bkq9RUg5o2gPV1iMl1PiPJqxmskYvBNq9T1chZV29RuCPg6DUkfjwWwfLU5cNROKv
 Pks8tPYWIbVYR4Z9SPUSXU+l+GiF/JYpdeuOsokNIAOYdDilyg4VUk4q9I2uz1Mb2MnqViS
 vIGmfvX/2QQzsSPuPpDHw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:LPFayMPwSQs=:9VFd7+3KUClzVkTo0VsIvr
 UkzioUsBzFerJBzcsrMitM7PERfOx1aW7Q7eirg6ZNr2qIQbX+Wjeo16Hl7Ez2AjfOf19TZrw
 LUaHNjISuM+jCAobun6olH0xFF2GBrs+mUWO8s2I2ipiCnDq4SGYHm1RZ+qvdSZnHNeMtxflY
 10XnkSo0iP9J2jBreaAdE3kRr2GW4jgLQ+uTrOgG6vakYPH5YP5MjT60FokFYqwrMVBQJtUvS
 U1YcpCMQIsFY7pW+mHHvihr25/U7ma9nOIoiiiCCXxfVLWkJHC+Zvmt1L/Mb0GLiszJyL11k5
 4DxBgEci/hu6XhF4tkHaj+cKrRzARWxvHcTmVmEnFhQ/subMlWPi76avuInOC5KTTTUDOZYVq
 TlnZpGHV7tKopqcYpWdGORGc7YiJRHGMhAcA8nU5aY+OrHpXRbq54YXyIvvavqEL+6Q5xspu+
 NACAu547Vl6oHZ6mJlbV9rYBpQNvX4HIFDo1EnkZcIaq/VuSX6VjQbr5XVqntD1CRVBf4DEH9
 cyUiPDEW9bKdGaYrIBR8yiXrG0EO7r+HI9GufFy2/oBLC286x7weTf/s87vHfWNrLdA4ecO0/
 sGpXKVos9Z3bFsSC0yJyy6FJK2F1YCvXRF0eFLndTofVf/LyX1r2uxmj7PjCom3kYPnToWCQf
 gdTqSsM+Qqx7voVIviQO1DDC2T4fK19pAar/zPEIW6/HOFRkGWuFgEQf5Vce4fMHZPUo=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2022 at 9:19 PM Laurent Vivier <laurent@vivier.eu> wrote:
>
> As android implementation defines the endianness of the device is the one
> of the architecture replace all writel()/readl() by
> __raw_writel()/__raw_readl()
>
> https://android.googlesource.com/platform/external/qemu/+/refs/heads/emu-master-dev/hw/timer/goldfish_timer.c#177
>
> The same change has been done for goldfish-tty:
>
>   commit da31de35cd2f ("tty: goldfish: use __raw_writel()/__raw_readl()")
>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>

__raw_readl() isn't really the correct interface though, this is not
well-defined to have
a particular meaning at all, and doesn't guarantee atomicity or a
particular endianess
across architectures.

I'd suggest defining a set of goldfish specific accessors per
architecture that turn
into either readl() or swabl(readl()), to allow future architectures
to define this
properly in qemu.

         Arnd
