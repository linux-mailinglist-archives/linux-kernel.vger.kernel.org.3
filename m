Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E74E530F7D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234256AbiEWKoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 06:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234236AbiEWKoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 06:44:39 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B64F21833;
        Mon, 23 May 2022 03:44:36 -0700 (PDT)
Received: from mail-yb1-f172.google.com ([209.85.219.172]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1M2gt5-1nrAXl1qU3-004EAy; Mon, 23 May 2022 12:44:34 +0200
Received: by mail-yb1-f172.google.com with SMTP id v71so24625779ybi.4;
        Mon, 23 May 2022 03:44:33 -0700 (PDT)
X-Gm-Message-State: AOAM530qeCxaHCmTmie4hv7Wx8oD2I4W6nmutjXgFkxho8NzdLnMdAjk
        LrMYbxgRZCF4bwL8p6q5muFE7gCnVGMfCCzTnEk=
X-Google-Smtp-Source: ABdhPJzbbTU7bxyEy+V6QZ7ro2Wti/wri258NXrp2iXt1Owp7jIbpPdzCSwsk8vjZl8l7XWvxC1S+1Cf8oUw+fAt8d0=
X-Received: by 2002:a81:6283:0:b0:2ff:2443:6f3c with SMTP id
 w125-20020a816283000000b002ff24436f3cmr22577090ywb.135.1653302662526; Mon, 23
 May 2022 03:44:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220522155046.260146-1-tmaimon77@gmail.com> <20220522155046.260146-13-tmaimon77@gmail.com>
In-Reply-To: <20220522155046.260146-13-tmaimon77@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 23 May 2022 12:44:06 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0PKvqpTjNeKUm6EnxpmJAtmk1jv+b4YXxr+fXFpsWXtw@mail.gmail.com>
Message-ID: <CAK8P3a0PKvqpTjNeKUm6EnxpmJAtmk1jv+b4YXxr+fXFpsWXtw@mail.gmail.com>
Subject: Re: [PATCH v1 12/19] reset: npcm: Add NPCM8XX support
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
X-Provags-ID: V03:K1:YHq8xzHHHcsfvYjSzSq+E07jIVbAebTZh9CDYUzTJWXfz/CNC4d
 DH5SoIfeUq+NJ0Nc8rFHY/R3FL/QCnVF1C9T2g2LIt3h7UY5J4dV1QADFb/h19lg4+G/mrl
 ru20c2th0IR3ckojIyJXvf17QEBdoGmeSS9umxMJsalQdaVTJpPNusRaXfENjA+29+RBrAc
 A/eMxpOhu6DPI5EC1lONg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9ufewbixEio=:gfWtISBLRbzNW+tb1mQRxi
 RgBwcoonfggCD2zBJNkDJPyPqTnWOkHKVP/axCZAgbnTPkLvZ/2mvREZwg3UdKBX3CO3ZIFjv
 E039TolbkZpDRUNirOjAR3lT3NgeBloRSOlGOeJTQex5EqZbuGiMXpMhh7Y31sqrw00Auu7e7
 K0PETQTHhahsABg3tFOBRB/9d8CzoVvuFqAPfkYwN9jRBuIIr8p7k3tQixc5ziYPHMRBMIvuN
 90QsmWW5DFdjia6cYUn/rCb1rs/7PVG1hATqVV9A1y/KdiaxhhVSiO+Jr1mKFqyUFKzDyjn40
 6QBiCUxQvH2dHfkSOsCIV7SLRaIVY0vr22sv7lnC098XcFCxnC60Pl3rfTOtu03rNvfkjIP0T
 oLqakUs5qn/l7Rv8iGrt7U1liwronrvxkXHblwfQNPgl/7Cf+jIEliL4gBgMiM3Bm6+5r/Hbn
 +32pQWFARuqBiGxY8LZWzp4yMgDb5iY+ddxFr5a2k8YExYeiVgJ5KayzwINNH3VmmAyxoehNT
 shUMVZvkIfQGj8Hf02i9sWWDbaLQGF1q0kot0TzSmG3evTjpCYli0ulX0zBKCi5V3irDgooQx
 EAuDqi9/nUNe9Zz7SBklDNs94WVt7kdJv342pJ6HRxaPeD8kDLin3FB5GDYns1SXrKgPOPBxQ
 YDi19RSwEEsgkEAHLWwo7GL8k3Cq4eubtEj077ejJTxESQq6S7nGyfgB55AEroKcrCxfTA7fX
 w5hu83J7EABn95Y6LqnHFxBT/l+dz3sUf97c3GtpMZ+LCZg9pSYoPGR9fKi8I2iLNQRxkYKbe
 fIsnfsHQSklCj7dKKTo9PAl9aRY8a4gLJwF5bTGDgCCxeTlOBG1Q4rtcCKIruMcVatbRkHoKG
 dYwJFGQOUpAs7KXJFSGt2jnw50VLGiVg5n5rRK6AM=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 22, 2022 at 5:50 PM Tomer Maimon <tmaimon77@gmail.com> wrote:

>  static const struct of_device_id npcm_rc_match[] = {
>         { .compatible = "nuvoton,npcm750-reset"},
> +       { .compatible = "nuvoton,npcm845-reset"},
>         { }
>  };
> +/*
> + *  The following procedure should be observed in USB PHY, USB device and
> + *  USB host initialization at BMC boot
> + */
> +static int npcm_usb_reset(struct platform_device *pdev, struct npcm_rc_data *rc)
> +{
> +       struct device_node *np = pdev->dev.of_node;
> +       struct device *dev = &pdev->dev;
> +
> +       rc->gcr_regmap = syscon_regmap_lookup_by_phandle(dev->of_node, "syscon");
> +       if (IS_ERR(rc->gcr_regmap)) {
> +               dev_err(&pdev->dev, "Failed to find gcr syscon");
> +               return PTR_ERR(rc->gcr_regmap);
> +       }
> +
> +       if (of_device_is_compatible(np, "nuvoton,npcm750-reset"))
> +               npcm_usb_reset_npcm7xx(rc);
> +       else if (of_device_is_compatible(np, "nuvoton,npcm845-reset"))
> +               npcm_usb_reset_npcm8xx(rc);
> +       else
> +               return -ENODEV;
>

In place of the string comparison in of_device_is_compatible(), maybe just use
the .data field of the of_device_id structure to point to the actual
reset function.

Alternatively, register two separate platform_driver instances here and
use separate probe functions that do the soc specific bits and call into
shared functions for the bits that are the same.

       Arnd
