Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C489583957
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 09:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234039AbiG1HPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 03:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233501AbiG1HP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 03:15:28 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B8A59265
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 00:15:26 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id i205-20020a1c3bd6000000b003a2fa488efdso2048865wma.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 00:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=references:user-agent:from:to:subject:date:in-reply-to:message-id
         :mime-version;
        bh=AaIaSUDCvbW74aHuiO4CJrSTxDz4crTVOTtdXBqcE0U=;
        b=AWbcHHbX5voPsqXsYc0lPhQLZ7zq2Rbg+WDm4j47FHMHXMKBPLuAwqpaMLT4oN34qS
         R6hvle5W3TN4f3TJRhkhZx0QPFmqjX98W46tEqeGl2ss33pWsTUsz6ICWmUhi/rNGcp6
         3eQgOfcF15Ov6JaO/BaW85eAfyYfbTZQOU7lHqyUe9RumDh0CPDhSAXX5tspMaURVBIN
         hAIUu2L93pP5MlYjVltII27G+d2lmMvuyd0SOq/7MlSZeJoZH16sIqKEMA/AAaXCwDjZ
         ZO3DlrFDankTYdhuu2q7oCaJtjXdqKBN2swatEdyWuhc0kJ1eFLYTZlGg6qxjCqabDjz
         qUNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:subject:date
         :in-reply-to:message-id:mime-version;
        bh=AaIaSUDCvbW74aHuiO4CJrSTxDz4crTVOTtdXBqcE0U=;
        b=GQsYVXtWBXqr4lWS08/Fp9zg7uWfTWL7RMvXi0nGVNBFV0HBm4qQhVXZLVoLsuGjrY
         ghHwgjeEe79BH584H8Ge3phiSdy3OZivDLplUoUV7KP37QFDH4lbQ/QuLE8nlphewNhd
         CvsyqkEgHia8e4Xe2J/PAOf8bV4Mn6fzk9ECjUwyj8YJU5MelXPgbLdDZM/enTDGjCpN
         lnC960PKdHgexaKL2NPxOFDX+Ao4B9Vf6S32czJANkqUtcIJSYN7p+wmOkE/gzL/HSRg
         n3L2g49a6eb1A76KQq1FapnoN5eD9xbOe5Kk83dWaIJWJ0y2yNJBZvInkARbB9MeIF8f
         sgYw==
X-Gm-Message-State: AJIora9oYQVUyHFypZQeFlPG3/vTByu5WintXJAC+6qEST5l1O44bg7+
        ZFaDysAzC/f3ylyKI2Km6AQ+ig==
X-Google-Smtp-Source: AGRyM1uBQSHcp5qkcijv00Bu7Y7/z1KirWW8lPysYxj5MYnLBGbrvNTmEd6qDPwVfOty8mtSm4vSMw==
X-Received: by 2002:a05:600c:1289:b0:3a4:8401:5ced with SMTP id t9-20020a05600c128900b003a484015cedmr384142wmd.148.1658992524267;
        Thu, 28 Jul 2022 00:15:24 -0700 (PDT)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id n186-20020a1ca4c3000000b003a2d87aea57sm4519126wme.10.2022.07.28.00.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 00:15:23 -0700 (PDT)
References: <20220728054202.6981-1-yu.tu@amlogic.com>
User-agent: mu4e 1.8.6; emacs 27.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Yu Tu <yu.tu@amlogic.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH V2 0/3] Add S4 SoC clock controller driver
Date:   Thu, 28 Jul 2022 09:08:44 +0200
In-reply-to: <20220728054202.6981-1-yu.tu@amlogic.com>
Message-ID: <1j8rodhfn9.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu 28 Jul 2022 at 13:41, Yu Tu <yu.tu@amlogic.com> wrote:

> 1. Add clock controller driver for S4 SOC.
>
> Yu Tu (3):
>   dt-bindings: clk: meson: add S4 SoC clock controller bindings
>   arm64: dts: meson: add S4 Soc clock controller in DT
>   clk: meson: s4: add s4 SoC clock controller driver
>
> V1 -> V2: Change format as discussed in the email.
>
> Link:https://lore.kernel.org/linux-amlogic/20220708062757.3662-1-yu.tu@amlogic.com/
>
>  .../bindings/clock/amlogic,gxbb-clkc.txt      |    1 +
>  MAINTAINERS                                   |    1 +
>  arch/arm64/boot/dts/amlogic/meson-s4.dtsi     |   11 +
>  drivers/clk/meson/Kconfig                     |   15 +
>  drivers/clk/meson/Makefile                    |    1 +
>  drivers/clk/meson/s4.c                        | 4732 +++++++++++++++++
>  drivers/clk/meson/s4.h                        |  296 ++
>  include/dt-bindings/clock/s4-clkc.h           |  146 +
>  8 files changed, 5203 insertions(+)
>  create mode 100644 drivers/clk/meson/s4.c
>  create mode 100644 drivers/clk/meson/s4.h
>  create mode 100644 include/dt-bindings/clock/s4-clkc.h
>
>
> base-commit: b293bc9286ee21824e93f0fcfed3b78fdfee01e6

Please don't post until you have addressed *ALL* the comments from the
previous version.

At first glance, I can see that this is still a single driver for
what is obviously 2 controllers with 2 register spaces. Simple comments
like the "<< 2" in the register declaration have not been addressed either.

Seeing that, I have not reviewed this version further.
I won't until all the comments from v1 are either addressed or answered.

Regards
Jerome
