Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC02452DD35
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 20:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242013AbiESSyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 14:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244346AbiESSyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 14:54:01 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E79B3465B
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 11:54:00 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d22so5541758plr.9
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 11:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cqXx+JOzkFXDkQqUC+tFOIFeOdrLRi5FsVZ7Q6tmusg=;
        b=KAueedpohy9ZiOcBymMzJEsFCiqcuYuuPjIX8XP7LbpXV2v67n3Jr3nZKvJB2E/kIL
         lg+zJ293d+WCNQvzx4uZJhzCn+5qWzB3138pkFQEueIaRqP7Suer+hZcBsAiB1hXKEmF
         109AEgiCJr1wKeIF43FSfR65AKDHN6yjqbWxE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cqXx+JOzkFXDkQqUC+tFOIFeOdrLRi5FsVZ7Q6tmusg=;
        b=kfUy4yX/6nqq74gt4mfl2mnyjPcAuD8xfbkyiz7JMD0aCOTVg34P5xaGboBh+EjReL
         FARMezFZ5PKP9IbdOKvgvHduZ2oeXemI5tCMARFHrLMwVwg26GoTV2hA7eTqDXmxJGcU
         YJyYL8os2xy3yXOXuxi6G5z4jyCDch3iDEa4a915YMvg+wQY+KyI64yGAz1fN8Obq2uF
         El96em8C64p4U5C6bwngkn5DnklwAIvNZIQqy3l0k0cV6TPeGEYUIVEsqFEtQRxTM4/2
         CYGVN2niOYs0jmBI8/aDzahs5BYBQfXUua7xLVOA6n9qKRNq4c4vQ+tbiJAnZe/+4I9Z
         hFOw==
X-Gm-Message-State: AOAM530Lm9rRTcuiN2SZtUpIY/tkWVKibuqGrFe92yAbA0jGcTZqXmFz
        067P+/u5OXF/+cHbKtUTaHTsyma0C3LWUZ1zYqq0AA==
X-Google-Smtp-Source: ABdhPJzi+RMNmnobsEMDELyM2l9/E1mnQZX5/Vb+7QiItPrOZ4eLgTdR5yT4+SAptOUz4GiCEPbBlLhNTH6u/2tbP6I=
X-Received: by 2002:a17:902:b90b:b0:15f:bd0:18b5 with SMTP id
 bf11-20020a170902b90b00b0015f0bd018b5mr6180510plb.97.1652986438537; Thu, 19
 May 2022 11:53:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220519185057.1657115-1-tommaso.merciai@amarulasolutions.com>
In-Reply-To: <20220519185057.1657115-1-tommaso.merciai@amarulasolutions.com>
From:   Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date:   Thu, 19 May 2022 20:53:46 +0200
Message-ID: <CAOf5uwnUPTc5zr8+QRwkr8L9104NY2LqX=oH0BOh6-fX_D=Eyg@mail.gmail.com>
Subject: Re: [PATCH v2] net: phy: DP83822: enable rgmii mode if phy_interface_is_rgmii
To:     Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
Cc:     alberto.bianchi@amarulasolutions.com,
        linux-amarula@amarulasolutions.com, linuxfancy@googlegroups.com,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tommaso

On Thu, May 19, 2022 at 8:50 PM Tommaso Merciai
<tommaso.merciai@amarulasolutions.com> wrote:
>
> RGMII mode can be enable from dp83822 straps, and also writing bit 9
> of register 0x17 - RMII and Status Register (RCSR).
> When phy_interface_is_rgmii rgmii mode must be enabled, same for
> contrary, this prevents malconfigurations of hw straps
>
> References:
>  - https://www.ti.com/lit/gpn/dp83822i p66
>
> Signed-off-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
> Co-developed-by: Michael Trimarchi <michael@amarulasolutions.com>
> Suggested-by: Alberto Bianchi <alberto.bianchi@amarulasolutions.com>
> Tested-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
> ---
> Changes since v1:
>  - Improve commit msg
>  - Add definition of bit 9 reg rcsr (rgmii mode en)
>  - Handle case: phy_interface_is_rgmii is false
>
>  drivers/net/phy/dp83822.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/net/phy/dp83822.c b/drivers/net/phy/dp83822.c
> index ce17b2af3218..7cb9d084707b 100644
> --- a/drivers/net/phy/dp83822.c
> +++ b/drivers/net/phy/dp83822.c
> @@ -94,6 +94,9 @@
>  #define DP83822_WOL_INDICATION_SEL BIT(8)
>  #define DP83822_WOL_CLR_INDICATION BIT(11)
>
> +/* RCSR bits */
> +#define DP83822_RGMII_MODE_EN  BIT(9)
> +
>  /* RSCR bits */
>  #define DP83822_RX_CLK_SHIFT   BIT(12)
>  #define DP83822_TX_CLK_SHIFT   BIT(11)

BIT(9) should go here

#define DP83822_RGMII_MODE_EN  BIT(9)
#define DP83822_RX_CLK_SHIFT   BIT(12)
#define DP83822_TX_CLK_SHIFT   BIT(11)

You duplicate the comments up.

> @@ -408,6 +411,12 @@ static int dp83822_config_init(struct phy_device *phydev)
>                         if (err)
>                                 return err;
>                 }
> +
> +               phy_set_bits_mmd(phydev, DP83822_DEVADDR,
> +                                       MII_DP83822_RCSR, DP83822_RGMII_MODE_EN);
> +       } else {
> +               phy_clear_bits_mmd(phydev, DP83822_DEVADDR,
> +                                       MII_DP83822_RCSR, DP83822_RGMII_MODE_EN);
>         }
>
>         if (dp83822->fx_enabled) {
> --
> 2.25.1
>

Michael

-- 
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
