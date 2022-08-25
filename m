Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C45D5A19E4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 21:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242269AbiHYT7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 15:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233657AbiHYT7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 15:59:39 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26CE82981B;
        Thu, 25 Aug 2022 12:59:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 5F413CE29AA;
        Thu, 25 Aug 2022 19:59:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2609C433C1;
        Thu, 25 Aug 2022 19:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661457574;
        bh=MxUP2JHg8QwMYl+xwMnMOML01dgAM84sIH3ZqdpLtV4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=p7Vbh6xeDJd3jcip6S0cWeGwM/c8kv/xToP/nuFffRC7Fv3s2y2xWNBhu8Z117l3V
         f1pRSyc5nNzDBx+7FmP4lU06B8hFZ/mU3IDR6M1+mWEZWjAqfs7eIzUQI9Mnniu+i+
         /hrE6UMyikcYMNSnY48UtnTBF2kLPbC92q/VHTyf+9hyTuRH+O62P+lOY57xvJOgln
         TPndr7a0M7mR4vmnGJ7te6VDOFtV+SeBieIbUaaaU70Yb7sR0lHg/jXq+i9wrk6/E0
         N2LVJFDFJh1jIg2zYF3k35hh9mtw4xEYhaWnS60QLVV2m1wkHii2RI8aSieqDQ0LIy
         7uDHKIVppCCig==
Received: by mail-ua1-f54.google.com with SMTP id d14so32779ual.9;
        Thu, 25 Aug 2022 12:59:34 -0700 (PDT)
X-Gm-Message-State: ACgBeo1/exjemPhlDazlenj9ALXIoeaFPJeiNRuljxIktwj1PVonWLcJ
        2un/Ed6xXo958nSyvLWqIZp6+5qraA7oGJRB5g==
X-Google-Smtp-Source: AA6agR7LaEu19VG0BnXmAdnMXB3Ngs2NMPE+dUCbgUSp0a1yNey5mW4XZWSmeU0hwjn7oHXypwGk/L9W7lhkniojaJY=
X-Received: by 2002:ab0:4565:0:b0:395:b672:508 with SMTP id
 r92-20020ab04565000000b00395b6720508mr2155494uar.63.1661457573681; Thu, 25
 Aug 2022 12:59:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220825170327.674446-1-ardb@kernel.org>
In-Reply-To: <20220825170327.674446-1-ardb@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 25 Aug 2022 14:59:22 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKnmK+FGRCMz=LOCieHwC7xg9dqZVRd=i1chE=9UUuEsA@mail.gmail.com>
Message-ID: <CAL_JsqKnmK+FGRCMz=LOCieHwC7xg9dqZVRd=i1chE=9UUuEsA@mail.gmail.com>
Subject: Re: [RFC PATCH] usb: reduce kernel log spam on driver registration
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        linux-omap <linux-omap@vger.kernel.org>,
        Avi Fishman <avifishman70@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        Nancy Yuen <yuenn@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Patrick Venture <venture@google.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Benjamin Fair <benjaminfair@google.com>
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

On Thu, Aug 25, 2022 at 12:04 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> Drivers are typically supposed to be quiet unless they are actually
> probed, but for some reason, USB host controllers seem to be exempt from
> this rule, and happily broadcast their existence into the kernel log at
> boot even if the hardware in question is nowhere to be found.
>
> Let's fix that, and remove these pr_info() calls.
>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: Claudiu Beznea <claudiu.beznea@microchip.com>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Cc: Alim Akhtar <alim.akhtar@samsung.com>
> Cc: Avi Fishman <avifishman70@gmail.com>
> Cc: Tomer Maimon <tmaimon77@gmail.com>
> Cc: Tali Perry <tali.perry1@gmail.com>
> Cc: Patrick Venture <venture@google.com>
> Cc: Nancy Yuen <yuenn@google.com>
> Cc: Benjamin Fair <benjaminfair@google.com>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Vladimir Zapolskiy <vz@mleia.com>
> Cc: linux-usb@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-samsung-soc@vger.kernel.org
> Cc: linux-omap@vger.kernel.org
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  drivers/usb/host/ehci-atmel.c    | 1 -
>  drivers/usb/host/ehci-exynos.c   | 1 -
>  drivers/usb/host/ehci-fsl.c      | 2 --
>  drivers/usb/host/ehci-hcd.c      | 1 -
>  drivers/usb/host/ehci-npcm7xx.c  | 2 --
>  drivers/usb/host/ehci-omap.c     | 2 --
>  drivers/usb/host/ehci-orion.c    | 2 --
>  drivers/usb/host/ehci-pci.c      | 2 --
>  drivers/usb/host/ehci-platform.c | 2 --
>  drivers/usb/host/ehci-spear.c    | 2 --
>  drivers/usb/host/ehci-st.c       | 2 --
>  drivers/usb/host/fotg210-hcd.c   | 1 -
>  drivers/usb/host/ohci-at91.c     | 1 -
>  drivers/usb/host/ohci-da8xx.c    | 1 -
>  drivers/usb/host/ohci-exynos.c   | 1 -
>  drivers/usb/host/ohci-hcd.c      | 1 -
>  drivers/usb/host/ohci-nxp.c      | 2 --
>  drivers/usb/host/ohci-omap.c     | 2 --
>  drivers/usb/host/ohci-pci.c      | 2 --
>  drivers/usb/host/ohci-platform.c | 2 --
>  drivers/usb/host/ohci-pxa27x.c   | 2 --
>  drivers/usb/host/ohci-s3c2410.c  | 1 -
>  drivers/usb/host/ohci-spear.c    | 2 --
>  drivers/usb/host/ohci-st.c       | 2 --
>  24 files changed, 39 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>

I've had the same patch sitting around since 3.15...

Rob
