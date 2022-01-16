Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D361548FDCF
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 17:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235589AbiAPQUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 11:20:03 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:53869 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232279AbiAPQUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 11:20:01 -0500
Received: from mail-wm1-f44.google.com ([209.85.128.44]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MK5BG-1mt7ZZ2yII-00LVJU; Sun, 16 Jan 2022 17:19:59 +0100
Received: by mail-wm1-f44.google.com with SMTP id d187-20020a1c1dc4000000b003474b4b7ebcso17092231wmd.5;
        Sun, 16 Jan 2022 08:19:59 -0800 (PST)
X-Gm-Message-State: AOAM531RozIZHsAFI5VdAvCW2ptj0agn0wZcVzCK8YSxvBeFsChcXmx2
        kTg6pHuMpx7PWTwCt6WYuivJYap0LTMxNSvbK5U=
X-Google-Smtp-Source: ABdhPJwLndypdoZqcgVySXUrUaTHtCgNSa0LHq+rQ0wsbDBGYparskmUw5otmdG9JKYAHAXXiKO0Lvzj6vDV3ZLvoZo=
X-Received: by 2002:a05:600c:5c1:: with SMTP id p1mr23740237wmd.1.1642349999360;
 Sun, 16 Jan 2022 08:19:59 -0800 (PST)
MIME-Version: 1.0
References: <20220115193245.3777833-1-laurent@vivier.eu> <20220115193245.3777833-4-laurent@vivier.eu>
 <CAK8P3a13g_o4mTsOO-4b=WU6TGRHubY7HCt1x1FdXpVmjy6-Sg@mail.gmail.com> <77e747de-c7d6-314d-e0b0-58852d463326@vivier.eu>
In-Reply-To: <77e747de-c7d6-314d-e0b0-58852d463326@vivier.eu>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sun, 16 Jan 2022 17:19:43 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1i_ngEaqhsy4xNrQV8=d1jY=JTxGNNUqOZ0g0to5bw8Q@mail.gmail.com>
Message-ID: <CAK8P3a1i_ngEaqhsy4xNrQV8=d1jY=JTxGNNUqOZ0g0to5bw8Q@mail.gmail.com>
Subject: Re: [PATCH v8 3/4] clocksource/drivers: Add a goldfish-timer clocksource
To:     Laurent Vivier <laurent@vivier.eu>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        linux-rtc@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:bThAav2QClU2G8a4VqvDbdC7de32a8IVLrelQESCHmeQjbSLhUj
 pgzKAzKuhznJp4iR70zztH7hqKuLV4WG2pbQB+KyMhjbvGIRkh33vdizgGaFQU/LFgJNhTJ
 RHGZetorKATZCv865TdUJZoAPz10ZxbwXIf1UOjDOIUjjmXKTRq1MZUjjxmxJxT9YB558cU
 pGO4H7hvHDQ4In3U6SQOg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:GsuQMbQxaAQ=:6+LJzRMiLXZF0auSsX8SEM
 MLG9fkQZT+uzptLgd27Z6+Tk6POLO144shBEmlig0IaK+982IGiD/vTBgRYEeIYL1X9cGoDZ7
 /T1uHAHO2z8OdTEDPumbealgUyGPudLt/SBhDSMn5S7RggfbW/k9kiAzir1kuFDCRLMUmAZlK
 1ZdP1S3qMCDCQRo4sAmRMtuDgMIF7mF8ekho1ujiMuAcDsKtB8RsVtLEe2alRYTDuUAEEW3B+
 Og90QGYSXJGSDiPSS+AzGArG8vHds1rcwz6BbKVDUg8mA/AdQZfpZ8VLVw0WnjbeZOKF+0ypj
 JgP0pI6yAlZSwA9t6ZeF/cQrmPgrenk++eCnlK+CD/ZJhX9ZaMijCnVZ1Ly9Q6nU/VCJ4vMro
 /zdhzKEzGDsDO/zsY90bcDVHzJl0ctPZvajREIgUUxKC3tVgXN+kG0UDvdLjsCrH4Lz8K6LQG
 6eo0vDnGXAEMT3q2+LjEhLVLas6T8ESv1PkrSYo/ciX3IuHmI7wASI4dsqUTfJVBmGO7Qf2dh
 qS8eCGzYdEULU4s2tbfADKP8YILsGw2UH/tj6bSvTXuqu/ZZnyVUUsGwjQDieQelfyFrHH9fM
 eMRolJMPuzyRLe/zTvI09FoGV51Hw7tfjRSbcwyi64BegguroYZ2zu0nT43q2avq8shy3806Z
 6F5TbM5qrlfePvjRfsWe9QDeEC6Xai0dfqgJLOSgevwye1kC363JL76OQohsjjz3RbtdhAMPZ
 czQhkH4diTUNQ9D/v5ITwPWKeWwWOYoyiRNRzBsvZjdc2mN+ROo5HTjbvKSbUJex+IjWV8zcK
 CCrm/tZhCjd2J3sxyKdQGn/yj4UiiHLsoKPdK+OTDNOeCmxt1k=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 16, 2022 at 12:54 PM Laurent Vivier <laurent@vivier.eu> wrote:
>
> Virtio has exactly the same problem in the past (prio to v1.0), and it uses __LITTLE_ENDIAN in
> virtio_legacy_is_little_endian() to know the endianness of the device.

Right, that was my point, let's not duplicate the bug from pre-standard virtio.

> So the code can become:
>
> #ifdef __LITTLE_ENDIAN
> #define goldfish_ioread32 ioread32
> #define goldfish_iowrite32 iowrite32
> #else
> #define goldfish_ioread32 ioread32be
> #define goldfish_iowrite32 iowrite32be
> #endif

This is exactly the same as what you had before, it continues to break when
host and guest disagree on the endianess.

> What do you prefer: CONFIG_M68K or __LITTLE_ENDIAN?

Checking for CONFIG_M68K at least has a chance of working, provided
that all existing qemu implementations agree on the semantics here.

       Arnd
