Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B237D4937D9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 10:59:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353363AbiASJ6v convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 19 Jan 2022 04:58:51 -0500
Received: from mail-ua1-f43.google.com ([209.85.222.43]:35654 "EHLO
        mail-ua1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243186AbiASJ6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 04:58:46 -0500
Received: by mail-ua1-f43.google.com with SMTP id m90so3529537uam.2;
        Wed, 19 Jan 2022 01:58:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=e8QRIwDey7YYITBsuH1RwLEavOxMt4TqPLNn4dY2EeQ=;
        b=F4YdqZHhrwOsG+jv+6ae1f2T/wSJ8ipvXMqaQ+qDn6lHIPCDqkavbKueWCOaBHS0A/
         mrWKptNvplS2oqYor9REO/KDvaehb1QuAOyhemNTBDQ8CFc1Vu7zHym1Ry27UGxpOQJJ
         y0SrX+XNOVO29VDVGiEamFSsK5delvqA1eTVAkGtj6lLzITJ549hBIQHYdMzcyr4OgLi
         hX5bCOtqy+rLE8+Y3BRZSDnXzNBnfBwzJMCtbb5ZQ9wiNI6mSihksEx/VYWBZL/hXAAW
         MKJnns+YNIJ5PFopXMTVBiiGm7SJ2uaj0Lwg7d0GTO2hEaBRvD7v7yYcQbo0TzNukFGB
         TiNw==
X-Gm-Message-State: AOAM531NpESG05seHncd+vJFgP4kwwnzu5QChqMtbJ3AM+U8xeaklB0h
        8hU2mYvNYgTQNouS1Fs2gTO41hOG47+ZXzZo
X-Google-Smtp-Source: ABdhPJx/RDK4NHBZcqx4fO744ByCnu/ubtQFFVrM98Oaok6cIyVSPCeXA7vcx75hDMp1mrpwaWNTnw==
X-Received: by 2002:a67:cb0d:: with SMTP id b13mr11105188vsl.81.1642586325373;
        Wed, 19 Jan 2022 01:58:45 -0800 (PST)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id w126sm2135824vka.25.2022.01.19.01.58.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jan 2022 01:58:44 -0800 (PST)
Received: by mail-ua1-f52.google.com with SMTP id n15so1987279uaq.5;
        Wed, 19 Jan 2022 01:58:44 -0800 (PST)
X-Received: by 2002:a67:e95a:: with SMTP id p26mr7058311vso.38.1642586324355;
 Wed, 19 Jan 2022 01:58:44 -0800 (PST)
MIME-Version: 1.0
References: <20220119000506.1299843-1-laurent@vivier.eu> <20220119000506.1299843-3-laurent@vivier.eu>
 <CAMuHMdXSFU4N+FLYkCLJCJcWJ74g=8Vr23Rx0cka-kDTBs6Z4Q@mail.gmail.com>
 <CAK8P3a2fjbet+nNAVt_WUxedUDWdRwb880KEa+MY1cFwYNC4SA@mail.gmail.com> <64d4b52f-cb5b-2024-e7f9-7a5babc62170@vivier.eu>
In-Reply-To: <64d4b52f-cb5b-2024-e7f9-7a5babc62170@vivier.eu>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 19 Jan 2022 10:58:33 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVfK9gsXphDepvQCdMpLjROiR9OKwdb28eCfVdDrQRVjQ@mail.gmail.com>
Message-ID: <CAMuHMdVfK9gsXphDepvQCdMpLjROiR9OKwdb28eCfVdDrQRVjQ@mail.gmail.com>
Subject: Re: [PATCH v10 2/5] rtc: goldfish: introduce goldfish_ioread32()/goldfish_iowrite32()
To:     Laurent Vivier <laurent@vivier.eu>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        John Stultz <john.stultz@linaro.org>,
        linux-rtc@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On Wed, Jan 19, 2022 at 10:11 AM Laurent Vivier <laurent@vivier.eu> wrote:
> Le 19/01/2022 à 09:49, Arnd Bergmann a écrit :
> > On Wed, Jan 19, 2022 at 9:21 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >> On Wed, Jan 19, 2022 at 1:05 AM Laurent Vivier <laurent@vivier.eu> wrote:
> >>
> >> I've just discovered include/linux/goldfish.h, which already has gf_*()
> >> accessors for 64-bit, so it'd make sense to move the above there,
> >> and adjust the names.
> >
> > Yes, good idea.
>
> So the idea is to put goldfish accessors inside a "#ifdef CONFIG_M68K ... #else ... #endif" in
> include/linux/goldfish.h and not in generic-asm/io.h for the generic version and
> m68k/include/ams/io.h for the m68k version?

No, just move

+#ifndef goldfish_ioread32
+#define goldfish_ioread32 ioread32
+#endif
+#ifndef goldfish_iowrite32
+#define goldfish_iowrite32 iowrite32
+#endif

to <linux/goldfish.h>, and rename them to gf_*().

Architectures can still override them in their own <asm/io.h>
(<linux/goldfish.h> includes <linux/io.h>).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
