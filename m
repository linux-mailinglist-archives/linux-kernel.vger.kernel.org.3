Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 752665588DA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 21:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbiFWT3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 15:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbiFWT3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 15:29:02 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9DB2DF1D
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 11:58:39 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-317a66d62dfso3464957b3.7
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 11:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FGzlsKlEfCGevmle/pHXLhVfx4U6rXBQGlZEgzoZTXI=;
        b=dvSmYPqhPiGxfI/5Zh18vm11MWcK7wOb8aYAdPwZxHqODG5Cuad8CaOEmv/Y2sa9p5
         VFVhZ3n04fnAE4EIBrxppU2JaQtCw+HwNGxNTftlpnSpGrlUtLsEAh3L0ohX07rtK8oT
         vpTgkigl4cA4ZXj7VK0JpmQlWypFDFhQ+PPfA1npnvuud8+/3Lrzirf0Ok6pZdv9uXCk
         VQcI1MF7PNbwpflSIIU5YLGwsfEJ+D0pBc2y9RzFdvO63vg93D63dsccsAeQnJ/ihgqY
         4KLTrkboG5Upk2hTkDe4NH4xsTpqB4jE9ojiP37WepP0vtdLf6M8E6YgpB9gFhYJ6DSW
         ukCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FGzlsKlEfCGevmle/pHXLhVfx4U6rXBQGlZEgzoZTXI=;
        b=oCB2gv4lz5pLYqul0uBF+vum3qPpFEWTtbllIJ6mbREGldrDl5cebQTDhEYt2uSfn+
         QcroYEA9veqYAq7y8kjJC5mRir8ek7M/QQDvUHhypKl/qe+fC4cc3UEcggmqVXYK1LQ9
         ilWN/jINC/2LNcuT22t5Er1RyoF+lsQzVB9VXBJ/hhO9aIf2Z645ep93Hp326akL0Rhl
         YjVsX1K5RzWopi/F9daZJXwx5KRkE48Ez7A7ToXuOqyJNnr+imccZgd42DzJEpvMI3AP
         cOtMIqYdKYKmCs7hMDJQtavux1Yfbu0a12pYfP126PxS2P943cf2IE0f2KbN8GhMjgyn
         jw7Q==
X-Gm-Message-State: AJIora/a5Br3aC38Ci/OFFhVY65bsBz1aFmrPblCIY7DOhnuu/bq59lJ
        l19ynqMsNvYy2V+lEBno6DwPT3Adudsf5KGRrgW4Tw==
X-Google-Smtp-Source: AGRyM1u/7wTdCyiFsm9BDRpZC1OybvAg1SKbmp+485CFKjjGjAnrIHBxFj8KE4k+UDRgnBvuLIE8imoEDuaOOm432SE=
X-Received: by 2002:a0d:dfd5:0:b0:317:f0d4:505b with SMTP id
 i204-20020a0ddfd5000000b00317f0d4505bmr11837779ywe.518.1656010718792; Thu, 23
 Jun 2022 11:58:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220622062027.994614-1-peng.fan@oss.nxp.com> <20220622072435.GT1615@pengutronix.de>
 <CAGETcx9JpTbYtGFoKttWLeiBB73QzzBM1o-OL0o-XuFouLcEog@mail.gmail.com>
 <CAOMZO5DFX72xuxWwAPsuk4Q667Ap7Dk+pR89cWDQJkzT0D2osA@mail.gmail.com>
 <CAOMZO5Ccu_v_G9DEwrEfVHq83-hfrXCP_h20Rv0=oFTLux5AkQ@mail.gmail.com>
 <CAGETcx85z_hkhKFHUwnihqcD0UQG3xtSZjw=BZxqwQB0D1CMgw@mail.gmail.com> <CAOMZO5A6Zn=6tXU2VQ+-cj=50mpxCmoZ8c437=w1Spd34k7T6A@mail.gmail.com>
In-Reply-To: <CAOMZO5A6Zn=6tXU2VQ+-cj=50mpxCmoZ8c437=w1Spd34k7T6A@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 23 Jun 2022 11:58:02 -0700
Message-ID: <CAGETcx-_nwrzJzaY3yc80g4AfydV5J9-JYE5h1m+5TT05jyKOw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8mp: drop dmas property for uart console
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>, hvilleneuve@dimonoff.com,
        Lucas Stach <l.stach@pengutronix.de>,
        abbaraju.manojsai@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>,
        Matteo Lisi <matteo.lisi@engicam.com>,
        Tim Harvey <tharvey@gateworks.com>,
        Teresa Remmet <t.remmet@phytec.de>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, t.remmet@phytec.deh,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2022 at 11:43 AM Fabio Estevam <festevam@gmail.com> wrote:
>
> On Thu, Jun 23, 2022 at 3:26 PM Saravana Kannan <saravanak@google.com> wrote:
>
> > I don't think it'll be hard to fix the console= case either. In the
> > case where you are not using stdout-path, how are you setting the
> > console? Just want to make sure I'm handling that case too.
>
> When stdout-path is not passed in DT, then the bootloader needs to pass
> console=ttymxc0,115200, for example.
>
> Please copy me in v3 if you send it.

Will do. I'm looking at the serial console code and I don't see a
difference between earlycon= vs console= handling. And I know that
earlycon= doesn't go through the driver core and isn't affected by any
of this. If you have additional pointers on where console= is parsed,
feel free to pass it on. I'll continue poking at this.

-Saravana
