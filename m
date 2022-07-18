Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E285557801F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 12:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234415AbiGRKsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 06:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234346AbiGRKsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 06:48:33 -0400
X-Greylist: delayed 839 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 18 Jul 2022 03:48:25 PDT
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D854B1F626
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 03:48:24 -0700 (PDT)
Received: (Authenticated sender: gregory.clement@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 65BCC1BF212;
        Mon, 18 Jul 2022 10:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1658141303;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o/FH13uRGmS+AuVZhQjVBjqMHQ3DI/qobSCgCMenQ3Y=;
        b=gWfcqCwK1KnrECMlbY9vF1HqBA9gItNlBRjbxICKmMNc3qnbM0XPRSy9oLA6BEGSjMnOKj
        bB88xfRf6O50nH8Nwv8UmT3qfnQ0NBhUjlBpu70uuKEO6N0HSJTsoWscCWTzDGiBbTH3sY
        qfjKmoTT/AQ44w8aYC8OTJ/X4orL8njNbef22XCh7MhAOoXejxEqg6bvwnwZfhQz89sSJr
        4L86BYvlMAK6MfY5qnAcN3bs1X8yar3iHIFu6bsMbeutF5dQLkdy5Utn5GIbrEGsmk/09e
        uAudjVEFEZ+0IiabcAumlkxK5vkaQwSKaXHRgEalEUFQ9Rk/6AX0RoHBHYqzIA==
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Vadym Kochan <vadym.kochan@plvision.eu>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Vadym Kochan <vadym.kochan@plvision.eu>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Konstantin Porotchkin <kostap@marvell.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Robert Marko <robert.marko@sartura.hr>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Elad Nachman <enachman@marvell.com>
Subject: Re: [PATCH v10 0/3] arm64: mvebu: Support for Marvell 98DX2530 (and
 variants)
In-Reply-To: <20220705190934.6168-1-vadym.kochan@plvision.eu>
References: <20220705190934.6168-1-vadym.kochan@plvision.eu>
Date:   Mon, 18 Jul 2022 12:48:20 +0200
Message-ID: <87tu7er91n.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vadym Kochan <vadym.kochan@plvision.eu> writes:

> This series adds support for the Marvell 98DX2530 SoC which is the Control and
> Management CPU integrated into the AlleyCat5/AlleyCat5X series of Marvell
> switches.
>
> The CPU core is an ARM Cortex-A55 with neon, simd and crypto extensions.
>
> This is fairly similar to the Armada-3700 SoC so most of the required
> peripherals are already supported. This series adds a devicetree and pinctrl
> driver for the SoC and the RD-AC5X-32G16HVG6HLG reference board.
>
> The pinctrl changes from v4 have been picked up and are in linux-next so I
> haven't included them in this round. That leaves just the dts files and a minor
> Kconfig update for arm64.
>
> Changes:
>
> v10:
>       1) Use different cnm clock for AC5 and AC5X DTSIs
>
>       2) Rename device-tree yaml binding to match the $id
>
> v9 (proposed by Marvell):
>    It was discussed with Chris that Marvell will add some changes:
>       1) Rename "armada-" prefix in dts(i) file names to ac5, because
>          Armada has not much common with AC5 SoC.
>
>       2) Add clock fixes:
>          a) rename core_clock to cnm_clock
>
>          b) remove axi_clock
>
>          c) change cnm_clock to 325MHZ
>
>          d) use cnm_clock for the UART
>
> Chris Packham (3):
>   dt-bindings: marvell: Document the AC5/AC5X compatibles
>   arm64: dts: marvell: Add Armada 98DX2530 SoC and RD-AC5X board
>   arm64: marvell: enable the 98DX2530 pinctrl driver
>
>  .../bindings/arm/marvell/marvell,ac5.yaml     |  32 ++
>  arch/arm64/Kconfig.platforms                  |   2 +
>  arch/arm64/boot/dts/marvell/Makefile          |   1 +
>  arch/arm64/boot/dts/marvell/ac5-98dx25xx.dtsi | 291 ++++++++++++++++++
>  .../boot/dts/marvell/ac5-98dx35xx-rd.dts      | 101 ++++++
>  arch/arm64/boot/dts/marvell/ac5-98dx35xx.dtsi |  17 +
>  6 files changed, 444 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/marvell/marvell,ac5.yaml
>  create mode 100644 arch/arm64/boot/dts/marvell/ac5-98dx25xx.dtsi
>  create mode 100644 arch/arm64/boot/dts/marvell/ac5-98dx35xx-rd.dts
>  create mode 100644 arch/arm64/boot/dts/marvell/ac5-98dx35xx.dtsi
>


Series applied on mvebu/dt64

Thanks,

Gregory


> -- 
> 2.17.1
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
