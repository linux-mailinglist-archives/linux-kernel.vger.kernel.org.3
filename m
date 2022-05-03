Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21C0B518917
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 17:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238995AbiECPz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 11:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232627AbiECPzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 11:55:24 -0400
Received: from mx-out1.startmail.com (mx-out1.startmail.com [145.131.90.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA4C431DF3;
        Tue,  3 May 2022 08:51:50 -0700 (PDT)
Date:   Tue, 3 May 2022 10:51:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=startmail.com;
        s=2020-07; t=1651593109;
        bh=56w8flPoDdgtjGA9GvUtnG3sqpiIHyKUNGbNmd5gImM=;
        h=Date:From:To:Subject:Message-ID:References:MIME-Version:
         Content-Type:Content-Disposition:In-Reply-To:From:Subject:To:Date:
         Sender:Content-Type:Content-Transfer-Encoding:Content-Disposition:
         Mime-Version:Reply-To:In-Reply-To:References:Message-Id:Autocrypt;
        b=FJ/tEpdv1e0AuZ2nIJUUELwcGzM69tunHMFCt/HJJxNPkq0+GLUD7oGrkdQv1N5aR
         ICOLWOni4cGw7aGWG2xZwEcDa7cjAlB9LLALDEAGMXaOUu/JkTRnU/F9QQTVa7bOd0
         G4FnPjmo1K+W+bvexKlIWTUOrwfBiDYoBl+3LJecTvSVxHtcWciit4OQG+CO4pl4xx
         MvyYEOSsDrphfcfamqZiiba2CXoCEn6/uwkqbgStr9bgyRavR0vs6Btag1xitnqWc+
         GxsXWRPYBMI+Sb4bPX8lbOl1oODzhC36nRyiGkllsZSZ9EIsbDG+BqjPpBJIg/at6N
         /lUwBdI9uSSMg==
From:   "Marty E. Plummer" <hanetzer@startmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     arnd@arndb.de, cai.huoqing@linux.dev, christian.koenig@amd.com,
        devicetree@vger.kernel.org, gengdongjiu@huawei.com,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux@armlinux.org.uk, michael@walle.cc, miquel.raynal@bootlin.com,
        mturquette@baylibre.com, novikov@ispras.ru, olof@lixom.net,
        p.yadav@ti.com, rdunlap@infradead.org, richard@nod.at,
        robh+dt@kernel.org, sboyd@kernel.org, soc@kernel.org,
        sumit.semwal@linaro.org, tudor.ambarus@microchip.com,
        vigneshr@ti.com, xuwei5@hisilicon.com
Subject: Re: [RFC v2 2/2] arm: hisi: enable Hi3521a soc
Message-ID: <20220503155141.ekbysx6fjom5el2h@proprietary-killer>
References: <20220501054440.2434247-1-hanetzer@startmail.com>
 <20220501173423.2473093-1-hanetzer@startmail.com>
 <20220501173423.2473093-3-hanetzer@startmail.com>
 <4cda3645-c4e8-1b3c-bd80-891afd56449a@linaro.org>
 <20220503134459.pplgvhcckja4ivcg@proprietary-killer>
 <75a48dfa-6fc9-aed9-b00e-d928bd9f33af@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75a48dfa-6fc9-aed9-b00e-d928bd9f33af@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 03, 2022 at 04:55:23PM +0200, Krzysztof Kozlowski wrote:
> On 03/05/2022 15:44, Marty E. Plummer wrote:
> > On Tue, May 03, 2022 at 01:47:01PM +0200, Krzysztof Kozlowski wrote:
> >> On 01/05/2022 19:34, Marty E. Plummer wrote:
> >>> Enable Hisilicon Hi3521A/Hi3520DCV300 SoC. This SoC series includes
> >>> hardware mutlimedia codec cores, commonly used in consumer cctv/dvr
> >>> security systems and ipcameras. The arm core is a Cortex A7.
> >>>
> >>> Add hi3521a.dtsi and hi3521a-rs-dm290e.dts for RaySharp CCTV systems,
> >>> marketed under the name Samsung SDR-B74301N.
> >>
> >> Thank you for your patch. There is something to discuss/improve.
> >>
> >>>
> >>> Signed-off-by: Marty E. Plummer <hanetzer@startmail.com>
> >>> ---
> >>>  arch/arm/boot/dts/Makefile              |   2 +
> >>>  arch/arm/boot/dts/hi3521a-rs-dm290e.dts | 134 ++++++++
> >>>  arch/arm/boot/dts/hi3521a.dtsi          | 423 ++++++++++++++++++++++++
> >>
> >> DTSes go to separate patches.
> > Do you mean dts and dtsi need to be separate patches?
> 
> I mean that any changes to "arch/arm/boot/dts/" have to be separate from
> other changes. These can be still one patch. See other examples on
> mailing lists.
> 
> >>
> >>>  arch/arm/mach-hisi/Kconfig              |   9 +
> >>>  4 files changed, 568 insertions(+)
> >>>  create mode 100644 arch/arm/boot/dts/hi3521a-rs-dm290e.dts
> >>>  create mode 100644 arch/arm/boot/dts/hi3521a.dtsi
> >>>
> >>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> >>> index 7c16f8a2b738..535cef3b14ab 100644
> >>> --- a/arch/arm/boot/dts/Makefile
> >>> +++ b/arch/arm/boot/dts/Makefile
> >>> @@ -242,6 +242,8 @@ dtb-$(CONFIG_ARCH_GEMINI) += \
> >>>  	gemini-ssi1328.dtb \
> >>>  	gemini-wbd111.dtb \
> >>>  	gemini-wbd222.dtb
> >>> +dtb-$(CONFIG_ARCH_HI3521A) += \
> >>> +	hi3521a-rs-dm290e.dtb
> >>>  dtb-$(CONFIG_ARCH_HI3xxx) += \
> >>>  	hi3620-hi4511.dtb
> >>>  dtb-$(CONFIG_ARCH_HIGHBANK) += \
> >>> diff --git a/arch/arm/boot/dts/hi3521a-rs-dm290e.dts b/arch/arm/boot/dts/hi3521a-rs-dm290e.dts
> >>> new file mode 100644
> >>> index 000000000000..b24fcf2ca85e
> >>> --- /dev/null
> >>> +++ b/arch/arm/boot/dts/hi3521a-rs-dm290e.dts
> >>> @@ -0,0 +1,134 @@
> >>> +// SPDX-License-Identifier: GPL-2.0-or-later
> >>> +/*
> >>> + * Copyright (C) 2017-2022 Marty Plummer <hanetzer@startmail.com>
> >>> + */
> >>> +
> >>> +#include "hi3521a.dtsi"
> >>> +
> >>> +/ {
> >>> +	model = "RaySharp RS-DM-290E DVR Board";
> >>> +	compatible = "raysharp,rs-dm-290e", "hisilicon,hi3521a";
> >>
> >> Please run checkpatch and fix the warnings.
> >>
> > sunova. I could have sworn I had my editor setup right for whitespace
> > and such.
> 
> It's not about whitespace but:
> 
ah. Well, I'm not certain what we'll even call the board in the end,
kind of a placeholder for now. What do you even name devices which are
generic consumer hardware that they never intended to be tinkered with
this way? the board is whiteboxed by several different vendors.
> WARNING: DT compatible string "raysharp,rs-dm-290e" appears
> un-documented -- check ./Documentation/devicetree/bindings/
> 
> 
> WARNING: DT compatible string vendor "raysharp" appears un-documented --
> check ./Documentation/devicetree/bindings/vendor-prefixes.yaml
> 
> 
> (...)
> 
> > Ah gotcha.
> >>> +	};
> >>> +
> >>> +	xtal24m: xtal24m {
> >>
> >> Generic node names, so one of: "clock-0" "clock-xtal24m"
> >>
> > Will do.
> >>> +		compatible = "fixed-clock";
> >>> +		#clock-cells = <0>;
> >>> +		clock-frequency = <24000000>;
> >>
> >> This does not look like property of the SoC, so should be defined by boards.
> >>
> > SoC requires a 24Mhz osc (and a 32khz one as well), so it'll always be
> > present regardless.
> 
> Sure, but DTS/DTSI describes hardware. If the clock is not in the SoC
> but on the board, it should be in the board DTSI. Many times such clocks
> are put partially in DTSI and only their specific parts - frequency - in
> the board DTS, to indicate that implementation is relevant to the board,
> not SoC.
> 
Ah ok, that makes sense I guess.
> >>> +	};
> >>> +
> >>> +	clk_3m: clk_3m {
> >>
> >> No underscores in node names, generic node name (see above).
> >>
> > early debugging clock, will be removed.
> >>> +		compatible = "fixed-clock";
> >>> +		#clock-cells = <0>;
> >>> +		clock-frequency = <3000000>;
> >>
> >> This does not look like property of the SoC, so should be defined by boards.
> 
> (...)
> 
> >>
> >>> +			status = "disabled";
> >>> +		};
> >>> +
> >>> +		dual_timer0: timer@12000000 {
> >>> +			compatible = "arm,sp804", "arm,primecell";
> >>> +			interrupts = <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
> >>> +				     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
> >>
> >> A bit weird interrupts... the same?
> >>
> > Yes, though I am aware that some sp804 timers do have a separate
> > interrupts per pair.
> 
> They have also separate interrupts, one combined interrupt or one sole
> interrupt. However what you described here is one interrupt line
> physically connected to two separate pins on the device yet still not
> being somehow shared (shared as "combined interrupt"). I don't think it
> is your case...
> 
Unsure. datasheet just says '33 | Timer0/Timer1'. I don't think these
timers are attached to pins, however.
> 
> 
> Best regards,
> Krzysztof
