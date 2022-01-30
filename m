Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ACCA4A32E0
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 01:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353595AbiA3Abo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 19:31:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353588AbiA3Abl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 19:31:41 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C8DC061741
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 16:31:41 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id i62so29519971ybg.5
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 16:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pme32IFXRNHgrXZ/dj8GMepH+ska0RwjBdlk1fihJ0A=;
        b=IltbbM1EQZqZOXk2OvOAxzFGYEGyIcXl0ze+Gd6uqe80Yl441IZCeUTU/rBTVpvJCF
         KIXazu/IDMXkGcjo+FKTks/BRGXeuUCz+25eZD77PYKVmNBrXCcKb0UzTzGfGIS5/KsK
         GJkAMdZSlu0tseCMyhAia/aB9i9WbvlP6lz9vmkAXtTeiWyunPOWGvGmz7UdePwIeZ/M
         j4FN8lMJFu3P7EO8CWdKag9uzRC/ATVhyyZH3h479vSUSTqoYAGTiuh9r0CQJOHD10sh
         Gh79f795EdnRlH6dlo4y4XRQkyUhWw8rJGLgOmWVdJRpEeoczaVsi0x2jBDHXgveJpES
         viCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pme32IFXRNHgrXZ/dj8GMepH+ska0RwjBdlk1fihJ0A=;
        b=nOdafTLN3tG3Kw52WUhkf7ofzHSSFUG5gnkoTLzMv9ifrfrCd8/F9RG4wf7M/48YiG
         KFuH2p9VNonDvNVsL6j9LWH/3QqKoSUBIlxdmf0cg0iwK7OplJwW48r6tHtTzour5aEc
         LcyNdbt0WzweRfv8WaUb+sG0aoEpQ51urlftbXgS5rmTobP+W70nNI6+wDhb7jWMyjzC
         s/+3Go1CB8NKuyK6Vc0QMctanW2QnYourGDVhFWZ1rlW2phZCky2RKCaOnmedH1xRUu9
         a1Yum6CNrHDM1LOjBkyrVdB0RQtXW5pnM33CaxYjmMMTBwvVrfWa0bP2yfGSP+J4/alm
         KXpQ==
X-Gm-Message-State: AOAM530QjwA9YdUXTuRu+qaJkHDFcRPtucd5GXaGTg7LHvMOMpQMiqkV
        qy4/pAaOu0eSLas9WXQBsEdgjB9MC/wt6wZNYRpN8w==
X-Google-Smtp-Source: ABdhPJzxAbrXaVgDQ08MBW1JI8bn63pnojvyZBxce+CBlsONQJOt0o6ierYk3+5NsIeuVr0qUpocfIe0c5ve35EnJKw=
X-Received: by 2002:a25:cfc6:: with SMTP id f189mr21205071ybg.322.1643502700641;
 Sat, 29 Jan 2022 16:31:40 -0800 (PST)
MIME-Version: 1.0
References: <20220129220221.2823127-1-colin.foster@in-advantage.com> <20220129220221.2823127-3-colin.foster@in-advantage.com>
In-Reply-To: <20220129220221.2823127-3-colin.foster@in-advantage.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 30 Jan 2022 01:31:29 +0100
Message-ID: <CACRpkdbXD0cA07zPQtVH1_hdc-aLq5ktm1DpUW=dB-i+B5dacw@mail.gmail.com>
Subject: Re: [RFC v6 net-next 2/9] pinctrl: microchip-sgpio: allow sgpio
 driver to be used as a module
To:     Colin Foster <colin.foster@in-advantage.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Russell King <linux@armlinux.org.uk>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>, UNGLinuxDriver@microchip.com,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Lee Jones <lee.jones@linaro.org>, katie.morris@in-advantage.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 29, 2022 at 11:02 PM Colin Foster
<colin.foster@in-advantage.com> wrote:

> As the commit message suggests, this simply adds the ability to select
> SGPIO pinctrl as a module. This becomes more practical when the SGPIO
> hardware exists on an external chip, controlled indirectly by I2C or SPI.
> This commit enables that level of control.
>
> Signed-off-by: Colin Foster <colin.foster@in-advantage.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
