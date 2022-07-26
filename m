Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48E58580E18
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 09:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238376AbiGZHmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 03:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238444AbiGZHl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 03:41:59 -0400
Received: from polaris.svanheule.net (polaris.svanheule.net [84.16.241.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 974421F2FB
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 00:41:33 -0700 (PDT)
Received: from vanadium.ugent.be (vanadium.ugent.be [157.193.99.61])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id 6256A30119E;
        Tue, 26 Jul 2022 09:41:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1658821290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x6mhpRVjeY02y9PKjADFibHQ+QplFQdFMkH4yzixOv8=;
        b=svLpUGvmOVh7MtkHNWW2Yl0XLrnw1OfUWUmrCq8RRZ5L0BASxUo3AEjuchoc8o/84gbT8X
        NdtDB7cYaKrNpETyPE/RnAt7tp2j9akhjM5RzfaRWDzw1ammbvJS0Ag8fHp1d5fwPG2SsG
        fKdhvfkGsC3/morICGPIYkDzZs7+vtYNEuj3GAX8oYOqTbfhWFlDJErexm1apOe23XAbDG
        XwkqSyt9qStSEf6NDL0H5baQLV8MG+anH+P4K+OWQfYu/18h9h+Rjo9XeS4afFFPBi1AVk
        +xlh0TsN0tte8XYyO0c7uJPCDRLUHhd5SpTTpMPkQQEnQv4UigwaeMgL9zsbmw==
Message-ID: <d64b0d239972ed7b42a201d81ee1a7c4be96ece9.camel@svanheule.net>
Subject: Re: [PATCH v2] gpio: realtek-otto: switch to 32-bit I/O
From:   Sander Vanheule <sander@svanheule.net>
To:     linux-gpio@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        Birger Koblitz <mail@birger-koblitz.de>,
        Jan Hoffmann <jan@3e8.eu>, Paul Cercueil <paul@crapouillou.net>
Date:   Tue, 26 Jul 2022 09:41:28 +0200
In-Reply-To: <20220724113141.51646-1-sander@svanheule.net>
References: <20220724113141.51646-1-sander@svanheule.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 (3.44.3-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2022-07-24 at 13:31 +0200, Sander Vanheule wrote:
> By using 16-bit I/O on the GPIO peripheral, which is apparently not safe
> on MIPS, the IMR can end up containing garbage. This then results in
> interrupt triggers for lines that don't have an interrupt source
> associated. The irq_desc lookup fails, and the ISR will not be cleared,
> keeping the CPU busy until reboot, or until another IMR operation
> restores the correct value. This situation appears to happen very
> rarely, for < 0.5% of IMR writes.
>=20
> Instead of using 8-bit or 16-bit I/O operations on the 32-bit memory
> mapped peripheral registers, switch to using 32-bit I/O only, operating
> on the entire bank for all single bit line settings. For 2-bit line
> settings, with 16-bit port values, stick to manual (un)packing.
>=20
> This issue has been seen on RTL8382M (HPE 1920-16G), RTL8391M (Netgear
> GS728TP v2), and RTL8393M (D-Link DGS-1210-52 F3, Zyxel GS1900-48).
>=20
> Reported-by: Luiz Angelo Daros de Luca <luizluca@gmail.com> # DGS-1210-52
> Reported-by: Birger Koblitz <mail@birger-koblitz.de> # GS728TP
> Reported-by: Jan Hoffmann <jan@3e8.eu> # 1920-16G
> Cc: Paul Cercueil <paul@crapouillou.net>
> Signed-off-by: Sander Vanheule <sander@svanheule.net>
> ---

...

> @@ -307,16 +308,17 @@ static int realtek_gpio_irq_set_affinity(struct irq=
_data
> *data,
> =C2=A0static int realtek_gpio_irq_init(struct gpio_chip *gc)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct realtek_gpio_ctrl =
*ctrl =3D gpiochip_get_data(gc);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned int port;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u32 mask_all =3D GENMASK(gc->n=
gpio, 0);

This should be GENMASK(gc->ngpio - 1, 0).

I'll wait a bit more for other comments before sending a v3.

Best,
Sander

