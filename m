Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF8C75A1293
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 15:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242113AbiHYNn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 09:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240724AbiHYNn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 09:43:26 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 979A2B5A7E
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 06:43:25 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id bj12so22593443ejb.13
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 06:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=QomYEQCF13pTiyVZD1MUQOKLylPL35fqoko3Mgfhgeo=;
        b=tdUD6ZFWr97P5SCROctrNkexFKVO2nqSFI6bd9T3B3IaredaPx5wkYjyOg6eOKxC0u
         1Tt75I/uywzBWnRbbm0Vm34Myie684KPwM/QyDuKbCrqRF65MFalujLXVMwQwvpSiezQ
         L8idOn6F4MyXuW/QcdLtLIN8bOnsFqRhmwA0ukwYzPyhMOcRYXcuZZoT3aeglEJ2R2Sj
         Z/qjSjkuIo6hJ1kp5Vh3QjOcADebDMPi0LBt97ht6AfyWmk65rVhCC8Z/H60YeWP0oku
         Nhg04sUG/F/sJH9F+75PV3IvjLxJxMcWS2GbRDIwMhwzBmjyqWJNKqd80KDNpZu9Aaqu
         ZgKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=QomYEQCF13pTiyVZD1MUQOKLylPL35fqoko3Mgfhgeo=;
        b=hc3LjtH7RbBl7fp6X33T3hYITBBrCeAnw6LTGvQ1MsQIGyq+oSbI/zkpQp+3dDZ4iK
         8y+VA5aowrSXX/oFqzJbcPQx87W358Q8/OjvDR8MlBoqoz/mQiflFoF/COJibcZbP23R
         ygwvqJOKzsSCmBHMsotkdY/zNQUvViee8zP9bUm/G2nn2CM7RExEyw71waeEriLypDwU
         y0HC3xVrkPN9mNdLMf0+OPSj1tqFFYsnAyc1vmuXYZjl5p3UEHIlyL3o84GI/i/dId/T
         NRU35PV4h3b8XW12o804kyR6LQyC6dl9Xnyp4ZNKRxJIkVmkmyr1A6KdBGiloQ8ySCdt
         fE8g==
X-Gm-Message-State: ACgBeo0SkVbeHokBRi+SiiZphcFNEO+nA5PEMQA78tvfiHiBypomakFB
        riL9JvSD1Gu71Ym8o7WphrF8GMc4Iw3h/M5oLMvSRQ==
X-Google-Smtp-Source: AA6agR7FNl3D7iHOIrzydCixyGnJ5x1DMItkJ1fpHsjG2Do4RJ4VIHz92OpD1jYYbQGa0/ELiyJwLGBl4ZqJJTubRF4=
X-Received: by 2002:a17:906:9b86:b0:73d:72cf:72af with SMTP id
 dd6-20020a1709069b8600b0073d72cf72afmr2626030ejc.440.1661435004205; Thu, 25
 Aug 2022 06:43:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220818145616.3156379-1-arnd@kernel.org> <20220818145616.3156379-5-arnd@kernel.org>
In-Reply-To: <20220818145616.3156379-5-arnd@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 25 Aug 2022 15:43:13 +0200
Message-ID: <CACRpkdbFkV1T+K9wKDyODkcwu=nhbV+4_JF=YTaA5ad_w4ggbw@mail.gmail.com>
Subject: Re: [PATCH 4/5] ARM: fix CPU_V6 dependencies
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 18, 2022 at 4:56 PM Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
>
> CONFIG_XIP_KERNEL must not be combined with CONFIG_SMP_ON_UP
> because the patching of read-only data does not work.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

The $SUBJECT of this patch is mildly confusing, as the affected
targets are maybe CPU_V6 but the change is related to XIP and
SMP_ON_UP.

Other than that it looks good.

Yours,
Linus Walleij
