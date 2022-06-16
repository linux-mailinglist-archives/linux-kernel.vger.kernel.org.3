Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19C4954EC1B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 23:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379111AbiFPVHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 17:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379084AbiFPVHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 17:07:12 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC7E61291;
        Thu, 16 Jun 2022 14:06:52 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id h23so4007521lfe.4;
        Thu, 16 Jun 2022 14:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tXQDZ/38qZYh6K2LSUfy/ZlT8ca4F2f6CeQBxW8J2Rw=;
        b=YDDhbkaybl0y166vNMC1zU/AMyxZSa1wcvpawfckZDS+0veCRECtb+eHxdFvjVPT7P
         wO1LRRPLOuoTjxwgD5VEXxLr+NZ+EgeUi9NDjZRH01fXPmipDyk7/uF1wJN3kvtwk3/U
         JfrA6OSvZfqAbZVajthuEb2rpTZia9iycWK7jiahkz0avp1ktbYECFxKartVglBoZgh1
         0BHOZuj9t8wzYpytbCSWWNGDp036jHPTc1BBUjwa2vf1WDBcrD8kU3us7vSCzA4N+joz
         1uysTJkCI43qnFz7mpV0Wqkai0Kz9yNHLfyqhrfzf/ymN3sVDjRqF1KRLJsSyvfovGZd
         iZAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tXQDZ/38qZYh6K2LSUfy/ZlT8ca4F2f6CeQBxW8J2Rw=;
        b=z5VRDKCIk3GcVX4bXobZi1Atvby7AnMZQ0nNl8eyT4WWINdO3Bl65BQrGaBuFwcaGe
         B/Cg82udQgMFanOl6kL3zb/Cz31eRx6bQN9Gk+PNS6+wXPSG7RXm2BCwnW7YBe6cRyGN
         vgtUYI5P46TxVEE8uPo++QdvgB2o5fR/OVkYtyzU9/N7NU2JlykD2i3NAzV2mT8feiCK
         u8477DM11j8tuTqcxIZwnb5xyrarOCVNM1DX7Ho/GdgS3yivWJTefDdH0q1XrBa/Kapr
         OgJFk6MRL3N+TufGVz3Xkelk05EWflm80Vviy+g2L4yWl+WyXrzZ1ENrL5uLBQW7WyYN
         KPTg==
X-Gm-Message-State: AJIora9wnR9leR0QSRS6zu/Xa3TgxN7uzsxYoX/A7GaW8z7Nhw4DjPlx
        OFduCXY7s2fqexwuW6yORBQhYa27nOxWJhuPEuU=
X-Google-Smtp-Source: AGRyM1tunwARBCrCvdwXIujxrW/QSjMvLQ9m2XGDJxT+oiqV5+SW8+0Z9kjKeE1FSlj8rczzvaUAiVUFzlL41fLDXk0=
X-Received: by 2002:a05:6512:1052:b0:479:1f92:13b4 with SMTP id
 c18-20020a056512105200b004791f9213b4mr3606425lfb.200.1655413610945; Thu, 16
 Jun 2022 14:06:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220608095623.22327-1-tmaimon77@gmail.com> <20220608095623.22327-6-tmaimon77@gmail.com>
 <CAK8P3a2CNxijmy0AO6NEfg=hxQZn5WxgQij4JgkTjDTfZZSScA@mail.gmail.com>
In-Reply-To: <CAK8P3a2CNxijmy0AO6NEfg=hxQZn5WxgQij4JgkTjDTfZZSScA@mail.gmail.com>
From:   Tomer Maimon <tmaimon77@gmail.com>
Date:   Fri, 17 Jun 2022 00:06:40 +0300
Message-ID: <CAP6Zq1h+PzkD1vjx787F_tbk30rAZHEkZp9uNUOmrFSd4gLO=g@mail.gmail.com>
Subject: Re: [PATCH v2 05/20] watchdog: npcm_wdt: Add NPCM845 watchdog support
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

On Wed, 8 Jun 2022 at 16:05, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Wed, Jun 8, 2022 at 11:56 AM Tomer Maimon <tmaimon77@gmail.com> wrote:
> >
> > Add Nuvoton BMC NPCM845 watchdog support.
> > The NPCM845 uses the same watchdog as the NPCM750.
> >
> > Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
>
> This one should no longer be needed if the timers are compatible with the
> old ones and correctly described in the DT.
by timers do you mean clocks?
>
>       Arnd

Best regards,

Tomer
