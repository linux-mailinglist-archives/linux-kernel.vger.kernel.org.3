Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E24D558A5E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 22:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbiFWUvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 16:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbiFWUvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 16:51:43 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF394F9D0;
        Thu, 23 Jun 2022 13:51:42 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id i8-20020a17090aee8800b001ecc929d14dso4354160pjz.0;
        Thu, 23 Jun 2022 13:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DF2FXD71gqOjtQrBwDNRffReItmxuKK3gUoUPPQiRu8=;
        b=MLqV5p7IsGqf4Ko6unI+XADaUccyjVXRrH96dePvy+ZlepoxctSj7qO+ktAsHHr7Tb
         UNug+zVH4LApYBTo3l+FYSqxI1EL2n/Qhbjwr03piPAgRwE3siRwTncpTLd6gte7Psqk
         1jEXWP8yLiBmyO+PfYDUYevHrSLYfHeboN95Vqg7vfSDNeXbAgWqhOH4HwRnQr94TVxd
         YOa4HQHny4osLtN4Mjxc+Upn2WN0GngWi/dRjWZm18gREuJC9i+G/ts9zrs5kdxQCEDZ
         zzns1p/Ke/TIWr5zQDUn3AH7pEw8OdWQ6Nss2fTP1iJZ7ixRPP3gqt0fbYEQPTxkgeGr
         GHiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DF2FXD71gqOjtQrBwDNRffReItmxuKK3gUoUPPQiRu8=;
        b=ZwZNoaA7GYadnrp1k/O0C7Ehj0VZdeyM1nVrLceI0Sq5j743J4qnjDyTN8GDPNibl8
         ciwdew271WMK5Ti6juCctn13DhvLV7sPG9cbVTiigZi6L+H7n7wJGuBsD8JJIgRg+/sh
         U62Bi2dbrXBzKjKlSH/rqAYVG9b+e4oXwnBl7ilW1VyX8pT3JWusuhEaGXq/J9SX2gD8
         /p8YttAg73y3WHDwddkZWZkl3rPw38w3Atcx6rz/RoMN/9Fs9a7PzPacmBjIcZvebGr7
         70U3bTC7tVBapzgoxDa7wYLGIkP9VInKTqcC/si4cBZpL1eOfjbXp5wezwpH/LdZgDJR
         K6Bg==
X-Gm-Message-State: AJIora/mF2Os7/DSWbnh/J4cO6qElLkvV9DPMlv6cizTPxdS62Wfi85c
        lcBBDJUp+2SH0jNPBdevs+h3gVzscSQhyRq/cT4=
X-Google-Smtp-Source: AGRyM1umWrpYxCdsqahfZggxS4kZJfv4CL610/K1pDg8FvTpbU1OYrW3f+KJjo0bYpzbI39huYxJD7FTv3PKCxIYlH0=
X-Received: by 2002:a17:903:32cb:b0:16a:3f2e:ca70 with SMTP id
 i11-20020a17090332cb00b0016a3f2eca70mr13327719plr.153.1656017502408; Thu, 23
 Jun 2022 13:51:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220622062027.994614-1-peng.fan@oss.nxp.com> <20220622072435.GT1615@pengutronix.de>
 <CAGETcx9JpTbYtGFoKttWLeiBB73QzzBM1o-OL0o-XuFouLcEog@mail.gmail.com>
 <CAOMZO5DFX72xuxWwAPsuk4Q667Ap7Dk+pR89cWDQJkzT0D2osA@mail.gmail.com>
 <CAOMZO5Ccu_v_G9DEwrEfVHq83-hfrXCP_h20Rv0=oFTLux5AkQ@mail.gmail.com>
 <CAGETcx85z_hkhKFHUwnihqcD0UQG3xtSZjw=BZxqwQB0D1CMgw@mail.gmail.com>
 <CAOMZO5A6Zn=6tXU2VQ+-cj=50mpxCmoZ8c437=w1Spd34k7T6A@mail.gmail.com> <CAGETcx-_nwrzJzaY3yc80g4AfydV5J9-JYE5h1m+5TT05jyKOw@mail.gmail.com>
In-Reply-To: <CAGETcx-_nwrzJzaY3yc80g4AfydV5J9-JYE5h1m+5TT05jyKOw@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 23 Jun 2022 17:51:31 -0300
Message-ID: <CAOMZO5BvnBCza5HQVNUQqDBZR9WsXiK4RuVPh654GJGb2jw+1g@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8mp: drop dmas property for uart console
To:     Saravana Kannan <saravanak@google.com>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2022 at 3:58 PM Saravana Kannan <saravanak@google.com> wrote:

> Will do. I'm looking at the serial console code and I don't see a
> difference between earlycon= vs console= handling. And I know that
> earlycon= doesn't go through the driver core and isn't affected by any
> of this. If you have additional pointers on where console= is parsed,
> feel free to pass it on. I'll continue poking at this.

It seems to be parsed at uart_parse_earlycon() inside
drivers/tty/serial/serial_core.c.
