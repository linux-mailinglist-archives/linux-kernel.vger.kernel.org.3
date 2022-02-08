Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5A444AD6AE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 12:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238890AbiBHL20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 06:28:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243943AbiBHKfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 05:35:47 -0500
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C86DC03FEC0;
        Tue,  8 Feb 2022 02:35:46 -0800 (PST)
Received: by mail-vk1-f175.google.com with SMTP id l14so9464848vko.12;
        Tue, 08 Feb 2022 02:35:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mQCnieYTAMPEclL2frn3xkAlJaOGccBzHxec4vAosRY=;
        b=A+5F1kJtFxegZxyohp6kSvs3FBQZM17ZNZXUH9/cYOxfN2OxcgNLeAzb2EHodp7r8h
         GK9IA1v75pW0OPXksB21vxXcU84PmnRqnyEsa/winrFyMXOvae9u8L7CSeVRgxybBbqi
         gb3MIpEeThTSg9e3U72QfhUaZ9+vGrm2rjSrubli5nb+dzTl+htrCA6khYGTubH7Vosn
         Xv4+TfwxO+Lccb0fXYWJEfvQ300PDEQSlb3Ylu0mwtqEDJV+jRtFHw4a7SJGitweLuJb
         8PeJYFpuJ7AvUYk5upGoBt6bSe7xWlify73Nm1XEvPd8GrEI4lJIGc1ChdPl1rAYNyk3
         KRwA==
X-Gm-Message-State: AOAM531iDYlIPtMIHN0LI9QW6UiOskhduRCc4isQK/gDrEvvqBJ13pv5
        +C32lHszJ/iOdPv2ExCdMa6LoFJG0KT7bg==
X-Google-Smtp-Source: ABdhPJzM1P4dsJuDJGkXrZGp+EirQ4+TATuxUtO0HtCjV6AlDqM2LBEIKoC7N3DAXTdx8g036BUkRA==
X-Received: by 2002:a05:6122:50d:: with SMTP id x13mr1494642vko.40.1644316545569;
        Tue, 08 Feb 2022 02:35:45 -0800 (PST)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com. [209.85.217.51])
        by smtp.gmail.com with ESMTPSA id j8sm2762854vki.48.2022.02.08.02.35.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Feb 2022 02:35:45 -0800 (PST)
Received: by mail-vs1-f51.google.com with SMTP id m24so2830682vsp.7;
        Tue, 08 Feb 2022 02:35:45 -0800 (PST)
X-Received: by 2002:a67:c198:: with SMTP id h24mr1221464vsj.5.1644316545025;
 Tue, 08 Feb 2022 02:35:45 -0800 (PST)
MIME-Version: 1.0
References: <20220204161806.3126321-1-jjhiblot@traphandler.com>
 <20220204161806.3126321-2-jjhiblot@traphandler.com> <CAMuHMdUsWSXqQ6oOP8c0XBJpAoMUg74kTJN1rU8uiq7UXRiKkw@mail.gmail.com>
 <89c0a032-3124-fc56-607c-5aeaac73fdc4@traphandler.com>
In-Reply-To: <89c0a032-3124-fc56-607c-5aeaac73fdc4@traphandler.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 8 Feb 2022 11:35:33 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVvrs-p4Tz2m7R8g7gXJRetTGKJNaQPEO_DYKDzu5u64A@mail.gmail.com>
Message-ID: <CAMuHMdVvrs-p4Tz2m7R8g7gXJRetTGKJNaQPEO_DYKDzu5u64A@mail.gmail.com>
Subject: Re: [PATCH 1/6] clk: renesas: r9a06g032: Enable the watchdog reset sources
To:     Jean-Jacques Hiblot <jjhiblot@traphandler.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean-Jacques,

On Tue, Feb 8, 2022 at 11:25 AM Jean-Jacques Hiblot
<jjhiblot@traphandler.com> wrote:
> On 07/02/2022 16:34, Geert Uytterhoeven wrote:
> > On Fri, Feb 4, 2022 at 5:18 PM Jean-Jacques Hiblot
> > <jjhiblot@traphandler.com> wrote:
> >> The watchdog reset sources are not enabled by default.
> >> Enabling them here to make sure that the system resets when the watchdog
> >> timers expire.
> >>
> >> Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
> > Thanks for your patch!
> >
> > R-Car Gen3 and RZ/G2 SoCs have a similar mechanism.
> > On these SoCs, the boot loader takes care of the configuration, as this
> > is a system policy that goes beyond the Linux realm.
> > Perhaps the RZ/N1 boot loader can do the same?
> >
> > Gr{oetje,eeting}s,
>
> Thanks for you reviews and comments.
>
> I'm not conformable with the idea that the safety induced by the
> watchdog is removed because the bootloader didn't set the register.

What if the CM33 is the master, and the CM33 just wants to receive an
interrupt when one of the CA7 watchdog timers times out?

> I'd rather that the kernel is able to enable the watchdog reset source.
> If it is acceptable, we could use a new DTS entry to force the policy.

DT describes hardware. not software policy.
Although I agree e.g. the watchdog timeout value is software policy.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
