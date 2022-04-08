Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E14C54F992B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 17:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237556AbiDHPPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 11:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237473AbiDHPPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 11:15:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD7B1017D0;
        Fri,  8 Apr 2022 08:12:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0227061F40;
        Fri,  8 Apr 2022 15:12:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62316C385C1;
        Fri,  8 Apr 2022 15:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649430766;
        bh=Vb9ZJRhyCFckFYpPHjtuunbxhp174/M4q/M7Vp10tWU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sIa9ENYGM+gzmBtzAW5EYaDOBPLLH7d1PzrZ/x+d1jMG3IGmpvpVLkpFZ/Qd+Fk3U
         FWE3pLZbQRHkELHgKkULRcm8Euxxc9pmrhVr8zuajRltNwDPPoiUlKNFXkG/Eiw154
         87fsgvKu3euj2wO5+D47MGxZlJu1tvelBPzuymUr/uPdUe3d+M1/VAxEKeNKU6HDuc
         4Y5i0/AK788TPhSS9T4DE93YvygrKXQdOnbkWJdxgVL16olmzAFAhrew+Qi4zijJHN
         udXqltsx1fVIzsGoooDtImHWnXAZD+Cx923lCYY3zI7hCLykSpGo6GZbzKALmNZNFT
         blaa7DPl7g9kA==
Received: by mail-wr1-f42.google.com with SMTP id w21so13388295wra.2;
        Fri, 08 Apr 2022 08:12:46 -0700 (PDT)
X-Gm-Message-State: AOAM5303dlMDTzZI2RqBWBUYDzenAxVHVG04tEcQLQFTZBw3zYPKGvif
        1awom0xAYVM4vbwcVoXQaIHUZbPhWUqh5nnfxeI=
X-Google-Smtp-Source: ABdhPJyFw2dT2aWjYaAvHF77JNUxndIajbOPX4lldS3CPnCvoH9+Y+2vwBOU81XHAOhivBVHGIxOtJQ5LlXm43fQALY=
X-Received: by 2002:a05:6000:178c:b0:204:648:b4c4 with SMTP id
 e12-20020a056000178c00b002040648b4c4mr14707557wrg.219.1649430764377; Fri, 08
 Apr 2022 08:12:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220405091750.3076973-1-arnd@kernel.org> <CACRpkdbVHOyq_dt7dtr8htzQqJ0BbL2K4_p1HX97miJJ4qnUnQ@mail.gmail.com>
In-Reply-To: <CACRpkdbVHOyq_dt7dtr8htzQqJ0BbL2K4_p1HX97miJJ4qnUnQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Fri, 8 Apr 2022 17:12:28 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1UObWkbOZzN0BLSgjJXBj94Hw85dEoH_VNWGG=bDNjkQ@mail.gmail.com>
Message-ID: <CAK8P3a1UObWkbOZzN0BLSgjJXBj94Hw85dEoH_VNWGG=bDNjkQ@mail.gmail.com>
Subject: Re: [PATCH 00/12] ARM: ARMv5 multiplatform conversions
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Hubert Feurstein <hubert.feurstein@contec.at>,
        Lukasz Majewski <lukma@denx.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Simtec Linux Team <linux@simtec.co.uk>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Sudeep Holla <Sudeep.Holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES" 
        <linux-samsung-soc@vger.kernel.org>, patches@opensource.cirrus.com
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

On Thu, Apr 7, 2022 at 10:42 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Tue, Apr 5, 2022 at 11:18 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> These two:
>
> > Arnd Bergmann (12):
> >   ARM: rework endianess selection
> >   ARM: ixp4xx: enable multiplatform support
>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Tested-by: Linus Walleij <linus.walleij@linaro.org>
>
> I booted on the Gateway GW-2348 which has some ethernet,
> PCI and compact flash, LED and a button, so I could test a
> whole lot of stuff.

Perfect, thanks!

> However when switching over to multiplatform I needed to severely
> overhaul the ixp4xx_defconfig for it to bring the same drivers in as
> before, I will send my patch for that which I think need to go in in
> tandem with this rework for a smooth transition.

Ah right, I was planning to go through the patches again to make
sure I get them all. I did the change for some platforms but at least
missed this one. I folded in this change and will make sure I do the
same for the others as well:

--- a/arch/arm/configs/ixp4xx_defconfig
+++ b/arch/arm/configs/ixp4xx_defconfig
@@ -6,6 +6,7 @@ CONFIG_EXPERT=y
 CONFIG_MODULES=y
 CONFIG_MODVERSIONS=y
 # CONFIG_BLK_DEV_BSG is not set
+# CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_IXP4XX=y
 CONFIG_MACH_NSLU2=y
 CONFIG_MACH_AVILA=y
