Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF624595A4D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 13:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234432AbiHPLgV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 16 Aug 2022 07:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234345AbiHPLfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 07:35:54 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 881029E2C0;
        Tue, 16 Aug 2022 04:01:01 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C0A2E113E;
        Tue, 16 Aug 2022 04:01:01 -0700 (PDT)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2960F3F70D;
        Tue, 16 Aug 2022 04:00:59 -0700 (PDT)
Date:   Tue, 16 Aug 2022 12:00:50 +0100
From:   Andre Przywara <andre.przywara@arm.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-sunxi@lists.linux.dev,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org,
        Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH 06/12] riscv: dts: allwinner: Add the D1 SoC base
 devicetree
Message-ID: <20220816120050.07dc2416@donnerap.cambridge.arm.com>
In-Reply-To: <b5401052-e803-9788-64d6-82b2737533ce@linaro.org>
References: <20220815050815.22340-1-samuel@sholland.org>
        <5593349.DvuYhMxLoT@jernej-laptop>
        <3881930.ZaRXLXkqSa@diego>
        <2249129.ElGaqSPkdT@jernej-laptop>
        <b5401052-e803-9788-64d6-82b2737533ce@linaro.org>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Aug 2022 12:42:39 +0300
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

Hi,

> On 16/08/2022 12:25, Jernej Škrabec wrote:
> > Dne torek, 16. avgust 2022 ob 11:12:05 CEST je Heiko Stübner napisal(a):  
> >> Am Dienstag, 16. August 2022, 09:49:58 CEST schrieb Jernej Škrabec:  
> >>> Dne torek, 16. avgust 2022 ob 09:41:45 CEST je Krzysztof Kozlowski   
> > napisal(a):  
> >>>> On 15/08/2022 08:08, Samuel Holland wrote:  
> >>>>> +
> >>>>> +	de: display-engine {
> >>>>> +		compatible = "allwinner,sun20i-d1-display-engine";
> >>>>> +		allwinner,pipelines = <&mixer0>, <&mixer1>;
> >>>>> +		status = "disabled";
> >>>>> +	};
> >>>>> +
> >>>>> +	osc24M: osc24M-clk {  
> >>>>
> >>>> lowercase
> >>>>  
> >>>>> +		compatible = "fixed-clock";
> >>>>> +		clock-frequency = <24000000>;  
> >>>>
> >>>> This is a property of the board, not SoC.  
> >>>
> >>> SoC needs 24 MHz oscillator for correct operation, so each and every board
> >>> has it. Having it here simplifies board DT files.  
> >>
> >> I guess the oscillator is a separate component on each board, right?  
> > 
> > Correct.
> >   
> >> And DT obvious is meant to describe the hardware - independently from
> >> implementation-specific choices.  
> > 
> > There is no choice in this case. 24 MHz crystal has to be present.
> > 
> > FWIW, including crystal node in SoC specific DTSI is already common pattern in 
> > Allwinner ARM SoC DTSI files.
> >   
> >>
> >> Starting to discuss which exceptions to allow then might lead to even more
> >> exceptions.
> >>
> >> Also having to look for a board-component in the soc dtsi also is surprising
> >> if one gets to the party later on :-) .  
> > 
> > As I said, if one is accustomed to Allwinner ARM DT development, it would be 
> > more surprising to include 24 MHz crystal node in each and every board DT.  
> 
> It's same everywhere. Allwinner, Exynos, iMX, Qualcomm. Everywhere this
> is a part of the board, so even if oscillator frequency is fixed (as in
> 99% of cases although some SoCs I think might just allow to implement
> one of few), still this is a property of the board. Because:
> 1. DTSI describes the SoC part, not board.
> 2. So the DTS developer is a bit more conscious about his design.

1) is certainly true, but indeed most platforms put the base
crystal oscillator in the SoC .dtsi: I just sampled Rockchip (rk3399.dtsi,
rk356x.dtsi, rk3328.dtsi), Amlogic (meson-g12-common.dtsi), ActionSemi (s[79]00.dtsi),
Qualcomm (msm8916.dtsi, sm8450.dtsi, sc7180.dtsi), Freescale (imx8mm.dtsi,
imx8qxp.dtsi), Realtek (rtd129x.dtsi), Broadcom (bcm283x.dtsi), Mediatek
(mt8183.dtsi, mt8516.dtsi). The list probably goes on (I just stopped
here).

I think one reason might be that this is so central to the whole SoC
operation, that it's already referenced multiple times in the base .dtsi.
And having a yet unresolved reference in the .dtsi looks dodgy.

NVidia seems to omit a base oscillator (maybe it's implicit in their
binding design), Marvell doesn't use a fixed-clock (but still puts their
base clock in armada-37xx.dtsi).

Exynos and Renesas put a *stub* fixed-clock in the .dtsi, and set the
frequency in the board .dts files. Would this be a compromise?

Cheers,
Andre

> Keeping things in SoC DTSI just because it simplifies DTS is not correct
> IMHO. So again - like in several other cases - minimum the frequency is
> property of the board, not the SoC DTSI.
> 
> Everywhere. Allwinner is not special to receive exceptions.
> 
> Best regards,
> Krzysztof
> 

