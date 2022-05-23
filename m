Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8DB6530F05
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235096AbiEWLnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 07:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235074AbiEWLnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 07:43:35 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F31506DA;
        Mon, 23 May 2022 04:43:33 -0700 (PDT)
Received: from mail-ot1-f42.google.com ([209.85.210.42]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1M8yPu-1ny2QH3nh0-0066ng; Mon, 23 May 2022 13:43:32 +0200
Received: by mail-ot1-f42.google.com with SMTP id e11-20020a9d6e0b000000b0060afcbafa80so4418465otr.3;
        Mon, 23 May 2022 04:43:31 -0700 (PDT)
X-Gm-Message-State: AOAM530VEDwel10v6P42dzQ6EV0W/ImJ2lYBPfS2Ob6jT5cD6s9b3rRk
        rep+Z18t15/VrxXwa2LB9oh6NBm7p3HONc7O7mM=
X-Google-Smtp-Source: ABdhPJxpUCa94Kh6HQKuK56biKlb3vDJKuICvFZFBgpVEpCuri5EfGLbRA6cBhu22Na5oqGEdTcIEn9+H34udGZY6o0=
X-Received: by 2002:a25:75c5:0:b0:648:dccd:e1c with SMTP id
 q188-20020a2575c5000000b00648dccd0e1cmr21094709ybc.452.1653299785602; Mon, 23
 May 2022 02:56:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220522155046.260146-1-tmaimon77@gmail.com> <20220522155046.260146-5-tmaimon77@gmail.com>
In-Reply-To: <20220522155046.260146-5-tmaimon77@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 23 May 2022 11:56:09 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0Nh4m7O_WPe1DTWqwWU32C5khOPH0ir7r_=s106mLv5A@mail.gmail.com>
Message-ID: <CAK8P3a0Nh4m7O_WPe1DTWqwWU32C5khOPH0ir7r_=s106mLv5A@mail.gmail.com>
Subject: Re: [PATCH v1 04/19] tty: serial: 8250: Add NPCM845 UART support
To:     Tomer Maimon <tmaimon77@gmail.com>
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
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>,
        Jiri Slaby <jirislaby@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Vinod Koul <vkoul@kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        robert.hancock@calian.com,
        "nathan=20Neusch=C3=A4fer?=" <j.neuschaefer@gmx.net>,
        Lubomir Rintel <lkundrak@v3.sk>, SoC Team <soc@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:Eh/qW2KznBfSE/OEBWqMPrKe6wGQVBqS5SXsFUcXmZEqSSuDHwT
 72VMZAhZPMIqmh+H6lMwP5qwnaEjve33ZMwxkio1HwuhLe3vPgbpqAog7NGZVs3/TT2oIMr
 eLUmXk8B4w648y9F7Bu1gvCHI+0N3M/eyZ0k53KwRmUDovnzg2msAvsumZTmJi6s5Ya1U3b
 XfeBYBqjpRFHOFSgvC5YQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MX/kDM8qFJQ=:CvgCpZv4G2zKoUj2z9ehBD
 q317uwNL18N9Picka94IqPCTYd3CmtXvDVrZ9rwdHuwNOfOByunvQOyYEl5G8UQfzgImVWQBY
 D2Yk6dIUB06pWAOExUyI9NYclahQzC4GJDaRKjYHAZu+iYEzlL52xKUvBX6ZZGlmZHTPGN8YX
 Y/5RUBanuZtJvJ3iqaVWmUtMVIHC1WfhHtvERDNttfphhBU/c3itCrYebF2hY4d41zw4KBDkT
 VwFMXAaE1xna2GBc+ty/P+JeIl+zwKF3spkzznm8v3zF0gKEkK96NRflU70ymEbIXkMlosfa4
 /L7WeQkkTK3JvD6BDaeGnZMFBbTCwZHTtAefhAKghRvOBIPwyn+k5Xf+ohYGEMt6HOWRLJoLV
 sMYIWGyABqjBjoF2fu8Bhd4Z/GzoffvZlG5hEUyOiOaXt+LbNNxrFHXrn2ac34cWnfFoQKO7b
 G/j4oZ1S89kseAeIDBc3zq2pjCdnmeh2aT5VBDIO9EqV7QQNBsGLqHCq6Br+bSWTqOgNqFRiI
 GYuJRIitstsn3UA3Mg3fSmvVvA5S8zK34xsP4Ig9SNK1InEcSdsHPntJvV0R5CDVYUFHVzpLW
 5TL6tb0Qt79u4jxBCx/txPyQ4vCoPHVuj6/UyE13epLYHMwsTW/lbdmg6GxFOoVpPNtKTs2Dt
 rCVhULYuwi2udYEMOPaNzoEEUAAzZp2AgFWVYAXgWuddQ5uBtMvy3DbQEtX8YYqNOwskHC9Tu
 ZESP5no+BZ2x6s/vpQD5d2oZmYZ4wWiTMydWlWTqt8UDE1ugbhNkqcKztxF/zTHf/0BIFZrRp
 6kpLar02NBXVZfofCQH0YywcWqyCSP+dynb/W3vwBXGDi7cXGOCLkfF8ak/RImCcA+meyBaWP
 epvJo17x6SJ9CA+eTjtQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 22, 2022 at 5:50 PM Tomer Maimon <tmaimon77@gmail.com> wrote:
> +++ b/drivers/tty/serial/8250/8250_of.c
> @@ -333,6 +333,7 @@ static const struct of_device_id of_platform_serial_table[] = {
>         { .compatible = "ti,da830-uart", .data = (void *)PORT_DA830, },
>         { .compatible = "nuvoton,wpcm450-uart", .data = (void *)PORT_NPCM, },
>         { .compatible = "nuvoton,npcm750-uart", .data = (void *)PORT_NPCM, },
> +       { .compatible = "nuvoton,npcm845-uart", .data = (void *)PORT_NPCM, },
>         { /* end of list */ },

If these are compatible devices, it's usually easier to claim
compatibility with both the specific chip and the older model
as a fallback, to avoid driver changes. This seems to apply to
the timer and watchdog devices as well.

       Arnd
