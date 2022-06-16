Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A52E354EC46
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 23:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378805AbiFPVM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 17:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiFPVMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 17:12:24 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF70A60BB4;
        Thu, 16 Jun 2022 14:12:23 -0700 (PDT)
Received: from mail-ot1-f51.google.com ([209.85.210.51]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1N7Qt9-1neVfk3JaH-017mEH; Thu, 16 Jun 2022 23:12:22 +0200
Received: by mail-ot1-f51.google.com with SMTP id a21-20020a9d4715000000b0060bfaac6899so1823021otf.12;
        Thu, 16 Jun 2022 14:12:21 -0700 (PDT)
X-Gm-Message-State: AJIora9TjP0a00PBsQURWsgXb12WAwMMa6UXwrIP5I9R8OXtoZqSBBre
        ADDz3gCl6bvUvzLaH5L5C1dJ3NolVWe2KQxeYQY=
X-Google-Smtp-Source: AGRyM1vsIgc89v9FEfZY2hXw+qDDKYDoyj4lZ95Az7j+neXL1rj/frpwyBwmT3KawTqhGlZqV+2aaoMOxNa7NrGaWtQ=
X-Received: by 2002:a0d:d84d:0:b0:314:2bfd:ddf3 with SMTP id
 a74-20020a0dd84d000000b003142bfdddf3mr8091696ywe.347.1655413929938; Thu, 16
 Jun 2022 14:12:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220608095623.22327-1-tmaimon77@gmail.com> <20220608095623.22327-6-tmaimon77@gmail.com>
 <CAK8P3a2CNxijmy0AO6NEfg=hxQZn5WxgQij4JgkTjDTfZZSScA@mail.gmail.com> <CAP6Zq1h+PzkD1vjx787F_tbk30rAZHEkZp9uNUOmrFSd4gLO=g@mail.gmail.com>
In-Reply-To: <CAP6Zq1h+PzkD1vjx787F_tbk30rAZHEkZp9uNUOmrFSd4gLO=g@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 16 Jun 2022 23:11:53 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1=n7QNaJRw6Wru13Lso6EApTqhsuGmgdkh2B3AdrE+_g@mail.gmail.com>
Message-ID: <CAK8P3a1=n7QNaJRw6Wru13Lso6EApTqhsuGmgdkh2B3AdrE+_g@mail.gmail.com>
Subject: Re: [PATCH v2 05/20] watchdog: npcm_wdt: Add NPCM845 watchdog support
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Avi Fishman <avifishman70@gmail.com>,
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
X-Provags-ID: V03:K1:NIjOik/WJEzdDxdYA1cJmP0wxFsRS3ajAia3aOO7OgSIB0ygYQ0
 EKA0iUea43JU5UwzuViKob61gfqb+ZTia2qBLKj4a3ceIIy7HlTb7mqd2NRJhpCLFCLrS8r
 QDnI0+MG9S3sSQWTx580s8yOg2E91P7IN1wfOorAoDa3b7MHA+QIu1yqLxCRoMNx3JXIs8S
 fB2CyQgYL+qqLVtvI3OeA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FRVmnoww0WI=:JvhulhdaAtfqBK+kp3KQQy
 ZGBzlxBcvBUMmthv716CpSZFRt6fpexpKRNe5t4CRIppnp601zerXls+ubvRUjOdrgeRS4+81
 rYYa8kTJqo4DQEQvHIbqy3S1gCUH2uLupswIOG5lSt8YYcdGuIgwBwvHtctRu/h5UaCy9txlG
 3h4An05j9vzHXBsRjDDnbeCG6zIr/W5FfJU7FgKe/OYPv+3+H5NKWmD8nW7zlWhlSOOiqTRBt
 E4yYAtgaFBh2bqbaKJfOy45x8TB6SHx5TyzyRFJYVtFoK2zN8AkS0kJA1Qbg07EwgVwI1pg5Q
 hd9LrlWPuIGEYJavC01DR5oRoG6pP4lnF0pwOiGfgJGK8LVkltWu7nXrmVJaAHhyC+D0ijaMY
 iiIT+O+VCmLYA7jqeVTuJcOFiWmJhChFf05j9tD4JISeQbdrjH3RYoi50uveWQvpwnZeTNE2y
 9hBc+2HO6MW0dd0Dz/wScZOo+SuDUSFZVG5o47zFwoDrxruQQ2Np8Tjjl+QasAE33wNXTIKOk
 Pn8ISlIam8q9pfmD/yAuTReV884uektVjgBKLuJfRiDaV6eAOyR4mDwjKtMgDQNpKPliNRo4U
 mUgPUzp+4Q3mDC5mtSN6WPrCu1eEZVpCWFDkxvi+AYjkZ5+fBhzSXRpuAJj9EMsYf62L7/d/c
 mmbNB1U/Ruo/nSQVuNmuw3Z8o34L/+9o15mg3gcYZHEyr8i/+wUorRcFRPfpNiFvx4wrtXwiX
 iPuJ5/JviM73u00WCTbOW0b+euu3VfTWCu/zQekEiQ+wMcslis9ofdO8kM7GaKz5RJpsQZszJ
 4vU+cvQehud+sMYA9IHJLkKuGmXJ/JWvAvDkbKaZdO6h+2AiX1TGkTXAP8olIUZ6acGDgoIwW
 wf3aWuSmAV03eWG8PHchQ1bf2nQbgl8tR6s/WGG61+iIKle4kKqLIHd5J5O23EL7aIrENRRiH
 waq7GV4w9bMRgSYxlteJU/ko25Tte7InBd/Pf4xYPqngL5zN+cnkb
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2022 at 11:06 PM Tomer Maimon <tmaimon77@gmail.com> wrote:
> On Wed, 8 Jun 2022 at 16:05, Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Wed, Jun 8, 2022 at 11:56 AM Tomer Maimon <tmaimon77@gmail.com> wrote:
> > >
> > > Add Nuvoton BMC NPCM845 watchdog support.
> > > The NPCM845 uses the same watchdog as the NPCM750.
> > >
> > > Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> >
> > This one should no longer be needed if the timers are compatible with the
> > old ones and correctly described in the DT.
> by timers do you mean clocks?

Sorry, I mis-copied my comment. I meant the watchdog being compatible
with the old
version.

        Arnd
