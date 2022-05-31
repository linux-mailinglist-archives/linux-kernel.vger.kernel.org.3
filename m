Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 794745393DD
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 17:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345616AbiEaPWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 11:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345139AbiEaPWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 11:22:50 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A411125290;
        Tue, 31 May 2022 08:22:49 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id h5so11084627wrb.0;
        Tue, 31 May 2022 08:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8dhNZzxcDqH8eUH1s8IHbudWKgs58nSE0muzeXBTjuY=;
        b=E1GQjuZW9sZHmfYcFMJ1aCOAduFcwcvyblhlBvq/cAFNzFuTn0SKU0mRpFpAYYq4M4
         RL7F92BzzyAnPM+7e4UY7ciMPz1wi0xQ5Niwo428c0HGjrqIg5PgayxupDIiTTJufuT/
         yavaeCJzEc7NIym5JQLqM5AFLnckZMuEBgZ4JW7vgmEHVAZ5m6gAwzKykayGuJYLM/tN
         s3qc8N1ZX3AwBYay53ph+wJtHECS7/3YjHhRx7xzCPST8JPg9AqSJIJql0Cw+8t2+9ec
         Qf3f4nFLfrNlYYK/JGoZXuS8zAk3wFPqBj5EaAB9zJWye79Ru3uliTiU49n2NCFr6Ybo
         rmxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8dhNZzxcDqH8eUH1s8IHbudWKgs58nSE0muzeXBTjuY=;
        b=wTiWbV1F7498L+WKmV4qWw4ziUMJVkuQFJdnS7d9WH8XdOsUKpEgtghE2H6Tle9eQR
         DQXR70QUvW5x1LJM/waBQ+2tZOeJBX2Tn3GEwjhUZf110Qo473JFzQdyO/0EgRS10EHM
         adIu4vH0h2zut5SjsPXj32SguZ/+/suCSK8kv+o9zMRyX2JzhSJAkHpRsT1SF/JY6OJY
         1MIHlxv6gsbEPKDwM8ZZ6gaVaI2PPNgA/ahH6RaJ83pi5RxN5l911vgsoYDRkVy5iSRd
         6S8gku/y0VgTJ0FG7eDW+ga5IP0s2z3Vig7wUfS8N8FrdBkBnsyy8h/9ekR1qSFP+Xwm
         KI4g==
X-Gm-Message-State: AOAM532EWbed7L1GkNBvq+F2G6eNptuXPFMuwrHmt8g66AHC2ixRKamO
        N0SwbctesSVYpbtcNxNd2rY=
X-Google-Smtp-Source: ABdhPJzxQR5NMIK+rbklutVxfOhZ8bGcR/zgUdGkNetM8QcimtFO8AwzM70tocDrq5+3XsEckuxvww==
X-Received: by 2002:a5d:54c3:0:b0:210:2a28:5666 with SMTP id x3-20020a5d54c3000000b002102a285666mr13156176wrv.345.1654010568205;
        Tue, 31 May 2022 08:22:48 -0700 (PDT)
Received: from kista.localnet (213-161-3-76.dynamic.telemach.net. [213.161.3.76])
        by smtp.gmail.com with ESMTPSA id f6-20020a05600c4e8600b0039466988f6csm3062560wmq.31.2022.05.31.08.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 08:22:47 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>
Cc:     Andre Przywara <andre.przywara@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 0/3] pinctrl: sunxi: Remove non-existent reset line references
Date:   Tue, 31 May 2022 17:22:46 +0200
Message-ID: <4400164.LvFx2qVVIh@kista>
In-Reply-To: <20220531053623.43851-1-samuel@sholland.org>
References: <20220531053623.43851-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne torek, 31. maj 2022 ob 07:36:20 CEST je Samuel Holland napisal(a):
> I assume these properties came from a lack of documentation, and the
> very reasonable assumption that where there's a clock gate bit in the
> CCU, there's a reset bit. But the pin controllers are special and don't
> have a module reset line. The only way to reset the pin controller is to
> reset the whole VDD_SYS power domain.
> 
> This series is preparation for converting the PRCM MFD and legacy clock
> drivers to a CCU clock/reset driver like all of the other Allwinner
> SoCs. I don't plan to add reset lines that don't actually exist to the
> new CCU driver. So we might as well get rid of the references now.
> Technically this breaks devicetree compatibility, since the old drivers
> expect the reset. But the CCU conversion will be a compatibility break
> anyway, so it's a bit of a moot point.

If I understand correclty, this would cause only DT forward compatibility 
issue, which happens now and then anyway. Kernel would still be compatible 
with older DTs, it would just ignore that reset, right?

Best regards,
Jernej

> 
> 
> Samuel Holland (3):
>   pinctrl: sunxi: Remove reset controller consumers
>   ARM: dts: sunxi: Drop resets from r_pio nodes
>   dt-bindings: pinctrl: sunxi: Disallow the resets property
> 
>  .../pinctrl/allwinner,sun4i-a10-pinctrl.yaml  |  3 ---
>  arch/arm/boot/dts/sun6i-a31.dtsi              |  1 -
>  arch/arm/boot/dts/sun8i-a23-a33.dtsi          |  1 -
>  arch/arm/boot/dts/sun9i-a80.dtsi              |  1 -
>  drivers/pinctrl/sunxi/Kconfig                 |  3 ---
>  drivers/pinctrl/sunxi/pinctrl-sun50i-a64-r.c  |  1 -
>  drivers/pinctrl/sunxi/pinctrl-sun50i-h6-r.c   |  1 -
>  drivers/pinctrl/sunxi/pinctrl-sun50i-h616-r.c |  1 -
>  drivers/pinctrl/sunxi/pinctrl-sun6i-a31-r.c   | 22 +---------------
>  drivers/pinctrl/sunxi/pinctrl-sun8i-a23-r.c   | 25 +------------------
>  drivers/pinctrl/sunxi/pinctrl-sun8i-a83t-r.c  |  1 -
>  drivers/pinctrl/sunxi/pinctrl-sun9i-a80-r.c   |  1 -
>  12 files changed, 2 insertions(+), 59 deletions(-)
> 
> -- 
> 2.35.1
> 
> 


