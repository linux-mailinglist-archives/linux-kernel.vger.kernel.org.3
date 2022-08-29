Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18F1D5A462B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 11:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbiH2JeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 05:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbiH2Jd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 05:33:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6BC45C366
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 02:33:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4F46EB80E1A
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 09:33:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6C02C433D7
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 09:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661765631;
        bh=2Gh/KNyMZq1qOczR83Rxzp7vUQOYhFWD6C8J12u7ehQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WAtNVPQBtJ3rZyrQU+K8mKwtqMzEkWjsWwhnaORxXwlN5VdMFch4k6EBPl90+Xtb3
         nlIkTRoTFpsHDeMsr2Z778/XCLaswAJ58IjdhxjEFQi0Edb3fL8c0Inxzj8PrCNqWo
         AVZeDwigm9rKFQ5w+uAsVUEGoQbKpmq8yx7ohcDw83RNIsHAHpk9l4EyO3R29GfIgO
         Nb7fc7es04dYKWLXF1V95aq+DxICpmI14HvRKeMmv39c7DZl40aKoLCJVJQhuGIepj
         sq9vlFWMRg61tbYVFDTO/0S11lelYKXfmnanfufIZUwadLor/QEDFxJaLwO+X6OaMJ
         TDiIFxvK6QruA==
Received: by mail-ej1-f44.google.com with SMTP id bj12so14462182ejb.13
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 02:33:51 -0700 (PDT)
X-Gm-Message-State: ACgBeo3Fw3Ki+TtyvkHnATsT59arcmVd5ZbXh5o7OVDdnavrA1ew3Jnv
        8Bb6Q4TSe1KUqdOFITKHjbIf57ndKKHgqDsAznI=
X-Google-Smtp-Source: AA6agR4xCxsmtUziG/RWpfk1MQwOBPoKW8LI0isRo5zvbt8AVhbNCV5k3XGLjO6tEswAKL2xvjrJ8sJPcsJVjxy+4os=
X-Received: by 2002:a17:907:2d86:b0:741:8888:de8 with SMTP id
 gt6-20020a1709072d8600b0074188880de8mr3197524ejc.547.1661765630086; Mon, 29
 Aug 2022 02:33:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220818145616.3156379-1-arnd@kernel.org> <20220818145616.3156379-5-arnd@kernel.org>
 <CACRpkdbFkV1T+K9wKDyODkcwu=nhbV+4_JF=YTaA5ad_w4ggbw@mail.gmail.com>
In-Reply-To: <CACRpkdbFkV1T+K9wKDyODkcwu=nhbV+4_JF=YTaA5ad_w4ggbw@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 29 Aug 2022 11:33:34 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1PQjR2sv2rar6mFY9g4PkteAC+zgRUvnr04DETJX3K9w@mail.gmail.com>
Message-ID: <CAK8P3a1PQjR2sv2rar6mFY9g4PkteAC+zgRUvnr04DETJX3K9w@mail.gmail.com>
Subject: Re: [PATCH 4/5] ARM: fix CPU_V6 dependencies
To:     Linus Walleij <linus.walleij@linaro.org>
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
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 3:43 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Thu, Aug 18, 2022 at 4:56 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > CONFIG_XIP_KERNEL must not be combined with CONFIG_SMP_ON_UP
> > because the patching of read-only data does not work.
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> The $SUBJECT of this patch is mildly confusing, as the affected
> targets are maybe CPU_V6 but the change is related to XIP and
> SMP_ON_UP.
>
> Other than that it looks good.

The patch caused a regression, so I ended up completely replacing it,
new patch follows.

         Arnd
