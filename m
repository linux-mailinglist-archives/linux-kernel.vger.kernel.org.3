Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20D8D56D7B6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 10:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbiGKIT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 04:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiGKITz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 04:19:55 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA6B61BE99
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 01:19:54 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-31c8bb90d09so41218797b3.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 01:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pxy7liPnZ5m4wecdCola/+mPesrxMbGV+yBwzRe+HQw=;
        b=uF5JUwKif/ljECrYLC3GwBF7Oz/kZICVgsfdbXAGYczA5QZPZsUmF6t85Y3yr3w2eP
         kmBYNtlCCTD/Shd6WZ9IABaGOKTpDQ07bF285AH4nTLvHCHTAM+4Zd3btDhpfQ+8bnmH
         yaXYdTkYQ6Ps1TtSfNlwq8sPbALaaTFYDpBbPcrD4FhPneEI8fx3dt+DFCy6gByCuy6Z
         JU/n0j8qxdqbn4LSPdmxeEi6dTV75Y+WYBdB46a4BKVRtxP2qe1IiwbBrvLfitoV4cMe
         LcVVFXo2+2YnOrIXzPMZWGOXO0oTuxVhYiz190QurgVAFF8Y4M8DNXrV8NYOuhe49Jxc
         kF7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pxy7liPnZ5m4wecdCola/+mPesrxMbGV+yBwzRe+HQw=;
        b=qjJCKcwoU5tA3idVVV2Y86nIPRRpixj84KVRrBnqMjOm8P53nBjZK2hb3jknVCSfC0
         Pvf1q4RPuuKaa74Y6o8ccPK8tb68JZket3c5JzqERUTx0556opWlucz3eIrYI9k54zwS
         bQb9QTLfaKs+TL70gkHvMLJL3MCdBi5BAPX1qVjcwVPySwQMOxQ5RZxeT3TLCjd72V1Y
         xAIjDTOcEAafcO6EWNRst+JnsLfvRtngYOsvUtmmlGt/aREM8ljGreugiD1TcUvFEQ+D
         WdQZVW5JvnXBmPL0pFyNxjcR9ud0w0OQtT3SjzK/Rj38bGIvwivmE4tvLaEo/ZOd5JsA
         +nQw==
X-Gm-Message-State: AJIora8V/6bMwm3HskJMxZDb8VerrkM/FDLXtf0zloPA515lHNGlOeh1
        b9l7fRFsSOMPEVaK5Gqr51yOuAyYaOA5NBKg06H1TA==
X-Google-Smtp-Source: AGRyM1tI00BbLOX63G0ktj/7+ZI6YpR2enqSMl+gHB0/BK49V1YovcTBoeqLMk82lqIKrnTIkD6E4KH7y6aBdso1Eks=
X-Received: by 2002:a81:cc4:0:b0:31c:839c:7e27 with SMTP id
 187-20020a810cc4000000b0031c839c7e27mr18532160ywm.151.1657527593991; Mon, 11
 Jul 2022 01:19:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220705204743.3224692-1-colin.foster@in-advantage.com> <20220705204743.3224692-7-colin.foster@in-advantage.com>
In-Reply-To: <20220705204743.3224692-7-colin.foster@in-advantage.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 11 Jul 2022 10:19:42 +0200
Message-ID: <CACRpkda=5TUfbHyLOsKEF0xXzc3__qCRKzM6tz3+5WCUJERXaQ@mail.gmail.com>
Subject: Re: [PATCH v13 net-next 6/9] pinctrl: microchip-sgpio: add ability to
 be used in a non-mmio configuration
To:     Colin Foster <colin.foster@in-advantage.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        UNGLinuxDriver@microchip.com, Wolfram Sang <wsa@kernel.org>,
        Terry Bowman <terry.bowman@amd.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        katie.morris@in-advantage.com
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

On Tue, Jul 5, 2022 at 10:48 PM Colin Foster
<colin.foster@in-advantage.com> wrote:

> There are a few Ocelot chips that can contain SGPIO logic, but can be
> controlled externally. Specifically the VSC7511, 7512, 7513, and 7514. In
> the externally controlled configurations these registers are not
> memory-mapped.
>
> Add support for these non-memory-mapped configurations.
>
> Signed-off-by: Colin Foster <colin.foster@in-advantage.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
