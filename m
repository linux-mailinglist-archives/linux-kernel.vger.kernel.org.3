Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23B6E5A7EFC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 15:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbiHaNgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 09:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbiHaNgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 09:36:19 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0253167CAB
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 06:35:15 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id r4so18405419edi.8
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 06:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=ILMmjKU6Icsi2CtEhA4aXyZVYS/WtQ7hgIQ3u2QLb+M=;
        b=KK7mmQc8i7qlU4Z6etcXWe2hZp4sScQNajKhHvm5shRsxcgYGTw7Bdb6jIPcnbTA3w
         qwQ7PNbjXLxpDC5NKnAsgncpOKtCPHVvUiCMIxlecOAQMz8zkYr3+ICA6kRljxEpecmo
         j/VAsiXyEBtexP5UaYXWQ6MYvbpBK2Iy96+m7fPsmGNv3kHmPYcuh7LUaNNabwJmNVq4
         EDjhZcqaGyA4O2u7TTfuaYLoTbpvmE4j89pjZggtIaM3ts44rTjmXcuf1kWIGmGhV6Di
         ZmEX9qxGlqzM7ZZecsXdY7Tc5HE56GHOhHbnAf39XACQ9p2PVFqXc+TgaXucQ/axc4Ky
         Kvzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=ILMmjKU6Icsi2CtEhA4aXyZVYS/WtQ7hgIQ3u2QLb+M=;
        b=0zEhVxkGYh8Yy/c7K0RI2RACmAtwMK6uOWbHW15yXR/ZAp81HslMz5+mcl7h+G88kV
         1LshhBD79NwwI0C7ADBo1uk5WiWhwynjeoTAAeJYn/ILsc9fqRk29xwxqQGsie+TmFnj
         Nu7MEYmjJI4Y/l1Ucycgksq+aBENi1lIgAQTJkLjuWi82mFtFHRfA4Ir7ToHBKcOatRE
         qCETsoxDdzDsCHOlZFcmrbL7T0MtDtefEqFA3Ce2yzXprQSZX19CQCelhTHx6JWdNTZh
         dIUq+G3dYCC8bcw2ge4J5I1c4e6vrICkP2axz5sYIGHbVDFCwAKDKSxbP5w7mutPV3lc
         cCmA==
X-Gm-Message-State: ACgBeo34tlJlIsSnX3rqL2csOlNUnA5cmuwajWbtevN2Mn2ZgICsU2E2
        s2ua3uHPeImwZJzIpjm3gNCMwqkomfLopSxNGHotvFCgCAE=
X-Google-Smtp-Source: AA6agR7Mt8+J+9C0t+E4H+SNLbKfvp6sQInXKIqgn+PeoTndSKIMBZutDhAtAgFa4DGD+hCYGDvQ2KjcehdXw9v0rCI=
X-Received: by 2002:a05:6402:641:b0:446:d:bd64 with SMTP id
 u1-20020a056402064100b00446000dbd64mr24694639edx.32.1661952913167; Wed, 31
 Aug 2022 06:35:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220818145616.3156379-1-arnd@kernel.org> <20220818145616.3156379-5-arnd@kernel.org>
 <CACRpkdbFkV1T+K9wKDyODkcwu=nhbV+4_JF=YTaA5ad_w4ggbw@mail.gmail.com>
 <CAK8P3a1PQjR2sv2rar6mFY9g4PkteAC+zgRUvnr04DETJX3K9w@mail.gmail.com> <63a630b7-9068-40f9-b7f7-d9a08f74ed13@www.fastmail.com>
In-Reply-To: <63a630b7-9068-40f9-b7f7-d9a08f74ed13@www.fastmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 31 Aug 2022 15:35:01 +0200
Message-ID: <CACRpkdZWhMX-16tn0sxY6TLDPeu0rJ2BRvqFunU3W_caJtTFHw@mail.gmail.com>
Subject: Re: [PATCH] ARM: fix XIP_KERNEL dependencies
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 9:21 AM Arnd Bergmann <arnd@arndb.de> wrote:

> CONFIG_XIP_KERNEL does not work with any option that involves patching
> the read-only kernel .text.
>
> Since at least CONFIG_SMP_ON_UP is required in certain configurations,
> flip the dependency to always allow the .text patching options but make
> XIP_KERNEL have the dependency instead.
>
> This is a prerequisite for allowing CONFIG_ARCH_MULTIPLATFORM to
> be disabled.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

OK this should work!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
