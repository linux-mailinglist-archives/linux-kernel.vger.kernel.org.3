Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2FED54319A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 15:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240487AbiFHNlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 09:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240463AbiFHNk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 09:40:59 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6ED1DA091;
        Wed,  8 Jun 2022 06:40:53 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id b7so10252490ljr.6;
        Wed, 08 Jun 2022 06:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NLRKDXz6zzjLAXhhR5Ifc+M4GbQQ1QD0rqcPZbvw9Lg=;
        b=KUMMzEbWouoo5v1rnAw4ROesaaZ+ihQIjVRHapqwGv1U/mRgsb4bSx8YPFiSdGfnjb
         gJVaOXOmbBBSk9VpwqB0gZ9qitVJP8PiUJw3rBvWsklM808py+k7J2BFcr1ATsofOwth
         Zb2XhtDiW/MlgwEbzuTnXamBhEEWiSoSKHeyGq7tbTJPBteBAJjWKr/XxtAQf1Hc3ph+
         foP2AmYGydN0Kiz8fW+cHhsRMcoaMUJNJJQ0ZZGn45AbtigbxMt6N9E6vBft+qHlr20t
         vRrYwAW71h8h7EwyprxpLLaFRe2yZhcDZSajpDvVJPhAGdegARHe/Sf8XLhYpTDlc86/
         CSdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NLRKDXz6zzjLAXhhR5Ifc+M4GbQQ1QD0rqcPZbvw9Lg=;
        b=J/Q8KNvddD/mu2ePrX61tICStRbpdtK3HgQiDEWR0JctAh3Rzd+d5b07lUc0F1BuOU
         X+6pgtpR6y16ff1cg2hgWo7/KlbNT9/GXTdjy3vv/g5ebVLTTW5ubckYIuhVHUImZOxB
         GCgegXIep3JBKHvX0pNYg9C5ZAVD14zVQlqGzZmFtEGQNS2Ad8iEf2JkLUXErlHkim+Q
         nDJEJ7JXxTAg55DcWnuXeDeyaWEaNFqcAhrafaF+nCQIBOKkv4tQ3x7k5qN8zGBkoTOp
         ssLW00EfcjBvV+t882Zp6hh9YocL+Y3EmiGBjTX9dxGyTgUgJqch7uD0zrrvqS4Cnryo
         JVGg==
X-Gm-Message-State: AOAM533f25fH3tmjmWglBTdf1pWGH8ub+AL7JEfCo1vpcPUtPuuFChhe
        r/mYrzU8N/XQ/aZxz825ROx82LMtFKSEzZv0t20=
X-Google-Smtp-Source: ABdhPJwY1wyBrMPjLKOD5RHB0u0JbXxcpqguVu5NkKhRMtLnvkKbCkxsvPZdyQLyuzU+FGHvCR8t/ArR3jt2flq+iTk=
X-Received: by 2002:a2e:81ca:0:b0:255:78c0:cb21 with SMTP id
 s10-20020a2e81ca000000b0025578c0cb21mr16542734ljg.240.1654695651152; Wed, 08
 Jun 2022 06:40:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220608095623.22327-1-tmaimon77@gmail.com> <20220608095623.22327-4-tmaimon77@gmail.com>
 <CAK8P3a1fDDk2kWMoxFjxoZT6dD5vfNzmNO+sMhV-GrZkpGkPow@mail.gmail.com>
In-Reply-To: <CAK8P3a1fDDk2kWMoxFjxoZT6dD5vfNzmNO+sMhV-GrZkpGkPow@mail.gmail.com>
From:   Tomer Maimon <tmaimon77@gmail.com>
Date:   Wed, 8 Jun 2022 16:40:39 +0300
Message-ID: <CAP6Zq1hxjDvzkwt3Jf7DVM_iB4EeYBdb3RzjjAjyr5mhD9==Lw@mail.gmail.com>
Subject: Re: [PATCH v2 03/20] tty: serial: 8250: Add NPCM845 UART support
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Avi Fishman <avifishman70@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Joel Stanley <joel@jms.id.au>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        gregkh <gregkh@linuxfoundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Olof Johansson <olof@lixom.net>,
        Jiri Slaby <jirislaby@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Vinod Koul <vkoul@kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Robert Hancock <robert.hancock@calian.com>,
        "nathan=20Neusch=C3=A4fer?=" <j.neuschaefer@gmx.net>,
        Lubomir Rintel <lkundrak@v3.sk>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

Sorry but Just to clarify, This patch should not be applied and the
NPCM8XX UART should use nuvoton,npcm750-uart compatible in the device
tree?

Because I thought that in your comment a few weeks ago
https://www.spinics.net/lists/linux-serial/msg48179.html

We need only to modify the compatible string in the device tree as we
did in V2 patchset
https://www.spinics.net/lists/arm-kernel/msg986480.html

On Wed, 8 Jun 2022 at 15:01, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Wed, Jun 8, 2022 at 11:56 AM Tomer Maimon <tmaimon77@gmail.com> wrote:
> >
> > Add Nuvoton BMC NPCM845 UART support.
> > The NPCM845 uses the same UART as the NPCM750.
> >
> > Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
>
>
> This one should no longer be needed if the timers are compatible with the
> old ones and correctly described in the DT.
>
>       Arnd

Thanks,

Tomer
