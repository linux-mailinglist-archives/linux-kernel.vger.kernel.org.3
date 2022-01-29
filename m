Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E52514A317A
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 20:06:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344059AbiA2TGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 14:06:10 -0500
Received: from mail-ua1-f52.google.com ([209.85.222.52]:38747 "EHLO
        mail-ua1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbiA2TGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 14:06:07 -0500
Received: by mail-ua1-f52.google.com with SMTP id n15so9536623uaq.5;
        Sat, 29 Jan 2022 11:06:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CnXV1lP4jRXDruwr+VLx538/6skJLP0U1y/ooujqmiU=;
        b=fgK90gmnH0+X5mNiIKLwGJmKLU30iAM9RSi5NUt1wD0tcd+pZMqVoPlWmlEsR2zB4t
         +FeL2RuX6a/Z6m41allR89Q4SjvL7JIWLqM41/GzqcoTlEgKjoGEAHJD8Rq4KLqbGpuD
         2cspUEWUCo+mlBiRzPbGFkt1pXnkn5GRXkCJn/I2nxOptc/Ta1c/bMyAj9rMCU3Am80+
         KEZw42R/CNnE2H2aXIkbKGzVFSof6KwDkGhMXVxhdef5YEW0QJZN4NzqDU3x796okvbB
         60X9lpvrHRFdvOK8Dd2QM982ifEv3Vn281mgdvi1jqqAWoy6H/SRU6uoySLs2e02+7g/
         TLVw==
X-Gm-Message-State: AOAM530RAkRGRasQ63SKJ9q0tV59HKOJXGgaNefackuoGu31TYjUt6/B
        I4PKca2t++GtuRbpRr5UlgTPkGbCnI+QaQ==
X-Google-Smtp-Source: ABdhPJwLOjN1/8TMl+vPbLOiihicoIqklkAlbEL7mAzlT2Bb9QvYww/v/sIfih7saYz3mPQTh5zxQA==
X-Received: by 2002:ab0:338b:: with SMTP id y11mr5922101uap.21.1643483166765;
        Sat, 29 Jan 2022 11:06:06 -0800 (PST)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com. [209.85.222.50])
        by smtp.gmail.com with ESMTPSA id x20sm2239673vsr.17.2022.01.29.11.06.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Jan 2022 11:06:06 -0800 (PST)
Received: by mail-ua1-f50.google.com with SMTP id n15so9536563uaq.5;
        Sat, 29 Jan 2022 11:06:05 -0800 (PST)
X-Received: by 2002:ab0:6f0d:: with SMTP id r13mr2305849uah.114.1643483165476;
 Sat, 29 Jan 2022 11:06:05 -0800 (PST)
MIME-Version: 1.0
References: <20220129184225.407100-1-laurent@vivier.eu> <20220129184225.407100-2-laurent@vivier.eu>
In-Reply-To: <20220129184225.407100-2-laurent@vivier.eu>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sat, 29 Jan 2022 20:05:54 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVmCV4v=LhGRB3d3hbyL4Etv_Wbb2VPhK5G9a2xB1Pm2A@mail.gmail.com>
Message-ID: <CAMuHMdVmCV4v=LhGRB3d3hbyL4Etv_Wbb2VPhK5G9a2xB1Pm2A@mail.gmail.com>
Subject: Re: [PATCH v13 1/5] m68k: add asm/config.h
To:     Laurent Vivier <laurent@vivier.eu>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        linux-rtc@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        John Stultz <john.stultz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On Sat, Jan 29, 2022 at 7:42 PM Laurent Vivier <laurent@vivier.eu> wrote:
> To avoid 'warning: no previous prototype for' error, declare all
> the parse_bootinfo and config functions prototypes into asm/config.h
> and include it in arch/m68k/kernel/setup_mm.c and arch/m68k/*/config.c
>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

I have already queued v12.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
