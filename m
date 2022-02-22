Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9EF04C0468
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 23:13:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236017AbiBVWOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 17:14:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbiBVWOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 17:14:06 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB28C3303
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 14:13:40 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id j3-20020a9d7683000000b005aeed94f4e9so7258390otl.6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 14:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vA6jdhrt0X5IzFiRmRz30sCpDU0XpG4s8KI3tUMUnJU=;
        b=s9/S8l/ekkSc7aYsa1hv+0mOfM69bjvwKarNIOTjKrMlj/PTbV29mSEEcJIrnxOKAp
         WS8KVJOSY+v0I576R0yB7Hkl29e7E736IljU7HEUIbqu0MS595AksNseW1Dyv/xzHLvM
         owGbHsctUjewlSnx7c0cZYrFYFIzI3BguZw8erypsgjwvdzbNS2rPwHsha/RYspfJKc9
         5iDaeV7jdzpR24u347O9Qg7hytlSj30/b2kueAuGl+//ZZxqYbU8DOzq7ppkCv4W5jm8
         FrioZy2sIJzcNtCYEyIxWtmI2QSSdlqo2O6SCWI6y8P7Gdwt3MfxFpXFV6F5sgynLgoz
         xUsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vA6jdhrt0X5IzFiRmRz30sCpDU0XpG4s8KI3tUMUnJU=;
        b=aMn1OFe0lJxpB3k25R22VlLPmUUV5kDwMmeUvamY123atCcazupZezDwp1emdvnsJC
         /1ReypCYS/eXKwnu1T1QIvMwI7YHMrGHq8X60OED7tgNbpR3lWBAReUjRh4Q5oRwlDVc
         +E0Xu09TgasjDihpVnnSJJ8VkRtacUpF72w6jn5ycCwDyvigM4h/WjqyQMm1/4x6WSPE
         PXFnL960dsuOrd1dkIHgdgPgyuIq1WXdgkdMqi3llyQUikOiOX2GK1+4eRqyx/tOrvjD
         W6b6cc+Afd9qB73kK6EP7N+JwKbH83dbp9rSDUf9J+1JcbTm89TvX4ex8V9tnen/n2Rn
         TZtw==
X-Gm-Message-State: AOAM5306+QOvAFK14uBw3yYaP5zN/XTMrkxivb8Wfx2mrF+778bDW/nB
        Dl4QOgcLimvpCZHTOaI+Q0bM8Q==
X-Google-Smtp-Source: ABdhPJwo1jDiJk0G/kZFHuz7BVeOgw1uVfA8ZN23LdrEl4HjabtSCEXFmArIKbpm3EVQgnAD7vetQw==
X-Received: by 2002:a05:6830:1d5c:b0:5ad:132f:31ae with SMTP id p28-20020a0568301d5c00b005ad132f31aemr9019412oth.71.1645568020009;
        Tue, 22 Feb 2022 14:13:40 -0800 (PST)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id l38sm7974149otl.45.2022.02.22.14.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 14:13:39 -0800 (PST)
Date:   Tue, 22 Feb 2022 14:15:40 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Nishanth Menon <nm@ti.com>
Cc:     Rahul T R <r-ravikumar@ti.com>, catalin.marinas@arm.com,
        will@kernel.org, shawnguo@kernel.org, krzk@kernel.org,
        geert+renesas@glider.be, marcel.ziswiler@toradex.com,
        biju.das.jz@bp.renesas.com, vkoul@kernel.org,
        enric.balletbo@collabora.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, tomi.valkeinen@ideasonboard.com,
        laurent.pinchart@ideasonboard.com
Subject: Re: [PATCH] arm64: defconfig: Enable configs for DisplayPort on J721e
Message-ID: <YhVgjFWShgc8btJP@ripper>
References: <20220222180703.30401-1-r-ravikumar@ti.com>
 <20220222193930.sbc5xlsofhg3amgk@overrun>
 <YhVKSpMOKWzZy9a2@ripper>
 <20220222212642.vwtw7xiz7cck63ea@zombie>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222212642.vwtw7xiz7cck63ea@zombie>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 22 Feb 13:26 PST 2022, Nishanth Menon wrote:

> On 12:40-20220222, Bjorn Andersson wrote:
> > On Tue 22 Feb 11:39 PST 2022, Nishanth Menon wrote:
> > 
> > > On 23:37-20220222, Rahul T R wrote:
> > > > Enable DRM and PHY configs required for supporting
> > > > DisplayPort on J721e
> > > > 
> > > > Signed-off-by: Rahul T R <r-ravikumar@ti.com>
> > > > ---
> > > >  arch/arm64/configs/defconfig | 5 +++++
> > > >  1 file changed, 5 insertions(+)
> > > > 
> > > > diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> > > > index 9f23d7ec1232..b0cb894a392e 100644
> > > > --- a/arch/arm64/configs/defconfig
> > > > +++ b/arch/arm64/configs/defconfig
> > > > @@ -702,6 +702,9 @@ CONFIG_DRM_EXYNOS_DSI=y
> > > >  CONFIG_DRM_EXYNOS_HDMI=y
> > > >  CONFIG_DRM_EXYNOS_MIC=y
> > > >  CONFIG_DRM_ROCKCHIP=m
> > > > +CONFIG_DRM_TIDSS=m
> > > > +CONFIG_DRM_DISPLAY_CONNECTOR=m
> > > > +CONFIG_DRM_CDNS_MHDP8546=m
> > > 
> > > Please use savedefconfig to place the changes in the correct location
> > > 
> > 
> > Just to clarify the request, use "make savedefconfig" to generate a
> > defconfig, then based on that put _only_ the relevant changes in the
> > commit.
> 
> Yup, thanks for clarifying.
> > 
> > > Also indicate changes if any in vmlinux in commit message.
> > > 
> > 
> > Nishanth, what are you asking for here? Just a mentioning if this has
> > any impact to vmlinux (or is isolated to the modules selected), or are
> > you asking for anything specific?
> 
> In this case, just ensure to state that vmlinux size has'nt
> changed, in case where we see a =y, we should indicate via
> ./scripts/bloat-o-meter change that is introduced and if yes, we
> should explain why this is fundamental to system boot.
> 
> Why is this necessary? This is to prevent product specific
> configurations (such as early display banner, chime etc) from creeping
> and increasing vmlinux size which has an impact for all ARM SoCs.
> 

Sounds very reasonable, I'll make sure to ask for such motivations in
the defconfig changes that I pick up through the Qualcomm tree as well.

Regards,
Bjorn

> 
> [...]
> 
> -- 
> Regards,
> Nishanth Menon
> Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
