Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76F7D4EAF1C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 16:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237791AbiC2ORb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 10:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235027AbiC2OR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 10:17:28 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED31D1CC0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 07:15:45 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: detlev)
        with ESMTPSA id 991DA1F42771
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648563344;
        bh=5aRdTY9mn+6seuvtEvgDqM56RNvxAnbftkZBjriJEqI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F8mdCuycUxrdSjSd41Aze3+Lh/Jsq+jbbhbOrZo7Vbt/JYFgzzPnwgMJMzCOIp99+
         /4LprH1FxYLGp/mqD4QruTap56GEykEuALeR+yaBDXuW3ngSyx5k2ftyFLooScqs1I
         /l0uD87ybHTPcLkvqMVT0l+TcFx4GB9B05hAKgCogp0A9sKEKZXCqT6UFMTyRmfxJS
         fSGSJw2uxnxiBzikGksduEL7/RsUbpmpQNJguol66uKW9eyYDn9DGEL2Apb9kGLieO
         CIdXH3z4+KAfyEDExZZarQZhQCI8du+wqmzhpjMnNgfO3Zcxd13F6b6Wrz+QPms9Xs
         ZXm0ysHvmvZXA==
From:   Detlev Casanova <detlev.casanova@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org
Subject: Re: [RFC PATCH v2 0/3] ARM: dts: Support official Raspberry Pi 7inch touchscreen
Date:   Tue, 29 Mar 2022 10:15:40 -0400
Message-ID: <11947259.O9o76ZdvQC@falcon9>
In-Reply-To: <20220221140117.90284-1-detlev.casanova@collabora.com>
References: <20220221140117.90284-1-detlev.casanova@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, February 21, 2022 9:01:14 A.M. EDT Detlev Casanova wrote:
> Add a devicetree overlay to support the official Raspberry Pi 7inch
> touchscreen.
> 
> This also demuxes the i2c0 controller to support both pinctrls.
> 
> Changes in v2:
>  * The device tree in now an overlay
>  * The i2c demux patch is kept for now to have a working patch set. It has
>    not been merged yet in [1].
>  * The device tree overlay doesn't use fragments. It is working as is
>    but not enough literature was found to go one way or the other.
> 
> [1] https://www.spinics.net/lists/arm-kernel/msg944330.html
> 
> Detlev Casanova (3):
>   ARM: dts: bcm2*: Demux i2c0 with a pinctrl
>   of: Add support for -@ when compiling overlays
>   ARM: dto: Add bcm2711-rpi-7-inches-ts.dts overlay
> 
>  arch/arm/boot/dts/Makefile                    |   4 +
>  arch/arm/boot/dts/bcm2711-rpi-4-b.dts         |   1 +
>  arch/arm/boot/dts/bcm2711.dtsi                |   2 +-
>  arch/arm/boot/dts/bcm2835-rpi.dtsi            |   9 +-
>  .../boot/dts/bcm283x-rpi-i2c0mux_0_44.dtsi    |   4 +
>  arch/arm/boot/dts/bcm283x.dtsi                |  26 +++-
>  arch/arm/boot/dts/overlays/Makefile           |   3 +
>  .../dts/overlays/bcm2711-rpi-7-inches-ts.dts  | 125 ++++++++++++++++++
>  arch/arm64/boot/dts/broadcom/Makefile         |   4 +
>  .../arm64/boot/dts/broadcom/overlays/Makefile |   3 +
>  .../overlays/bcm2711-rpi-7-inches-ts.dts      |   2 +
>  drivers/of/Kconfig                            |   8 ++
>  scripts/Makefile.lib                          |   9 +-
>  13 files changed, 193 insertions(+), 7 deletions(-)
>  create mode 100644 arch/arm/boot/dts/bcm283x-rpi-i2c0mux_0_44.dtsi
>  create mode 100644 arch/arm/boot/dts/overlays/Makefile
>  create mode 100644 arch/arm/boot/dts/overlays/bcm2711-rpi-7-inches-ts.dts
>  create mode 100644 arch/arm64/boot/dts/broadcom/overlays/Makefile
>  create mode 100644
> arch/arm64/boot/dts/broadcom/overlays/bcm2711-rpi-7-inches-ts.dts

Hello,

Any comments on this ?

Regards,

Detlev.


