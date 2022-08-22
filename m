Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 204EB59BDD5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 12:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233626AbiHVKuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 06:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233254AbiHVKuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 06:50:11 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EC7852F383;
        Mon, 22 Aug 2022 03:50:08 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9B0E111FB;
        Mon, 22 Aug 2022 03:50:11 -0700 (PDT)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9AC603F718;
        Mon, 22 Aug 2022 03:50:06 -0700 (PDT)
Date:   Mon, 22 Aug 2022 11:50:02 +0100
From:   Andre Przywara <andre.przywara@arm.com>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Conor.Dooley@microchip.com, wens@csie.org,
        jernej.skrabec@gmail.com, linux-sunxi@lists.linux.dev,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Icenowy Zheng <uwu@icenowy.me>
Subject: Re: [PATCH 06/12] riscv: dts: allwinner: Add the D1 SoC base
 devicetree
Message-ID: <20220822115002.74003b1c@donnerap.cambridge.arm.com>
In-Reply-To: <932aaefd-e2ca-ef26-bf30-e315fb271ec5@sholland.org>
References: <20220815050815.22340-1-samuel@sholland.org>
        <20220815050815.22340-7-samuel@sholland.org>
        <20220815141159.10edeba5@donnerap.cambridge.arm.com>
        <3cd9ed5b-8348-38ac-feb1-9a7da858cebc@microchip.com>
        <932aaefd-e2ca-ef26-bf30-e315fb271ec5@sholland.org>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Aug 2022 12:24:55 -0500
Samuel Holland <samuel@sholland.org> wrote:

Hi,

> On 8/15/22 12:01 PM, Conor.Dooley@microchip.com wrote:
> > On 15/08/2022 14:11, Andre Przywara wrote:  
> >> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> >>
> >> On Mon, 15 Aug 2022 00:08:09 -0500
> >> Samuel Holland <samuel@sholland.org> wrote:
> >>
> >> Hi,
> >>
> >> thanks for all the efforts in getting those SoC peripherals supported!
> >>  
> >>> D1 is a SoC containing a single-core T-HEAD Xuantie C906 CPU, as well as
> >>> one HiFi 4 DSP. The SoC is based on a design that additionally contained
> >>> a pair of Cortex A7's. For that reason, some peripherals are duplicated.  
> >>
> >> So because of this, the Allwinner R528 and T113 SoCs would share almost
> >> everything in this file. Would it be useful to already split this DT up?
> >> To have a base .dtsi, basically this file without /cpus and /soc/plic,
> >> then have a RISC-V specific file with just those, including the base?
> >> There is precedence for this across-arch(-directories) sharing with the
> >> Raspberry Pi and Allwinner H3/H5 SoCs.  
> > 
> > For those playing along at home, one example is the arm64 bananapi m2
> > dts which looks like:  
> >> /dts-v1/;
> >> #include "sun50i-h5.dtsi"
> >> #include "sun50i-h5-cpu-opp.dtsi"
> >> #include <arm/sunxi-bananapi-m2-plus-v1.2.dtsi>
> >>
> >> / {
> >> 	model = "Banana Pi BPI-M2-Plus v1.2 H5";
> >> 	compatible = "bananapi,bpi-m2-plus-v1.2", "allwinner,sun50i-h5";
> >> };  
> > 
> > I think this is a pretty good idea, and putting in the modularity up
> > front seems logical to me, so when the arm one does eventually get
> > added it can be done by only touching a single arch.  
> 
> This is not feasible, due to the different #interrupt-cells. See
> https://lore.kernel.org/linux-riscv/CAMuHMdXHSMcrVOH+vcrdRRF+i2TkMcFisGxHMBPUEa8nTMFpzw@mail.gmail.com/
> 
> Even if we share some file across architectures, you still have to update files
> in both places to get the interrupts properties correct.

There are interrupt-maps for that:
sun8i-r528.dtsi:
	soc {
		#interrupt-cells = <1>;
		interrupt-map = <0  18 &gic GIC_SPI  2 IRQ_TYPE_LEVEL_HIGH>,
				<0  19 &gic GIC_SPI  3 IRQ_TYPE_LEVEL_HIGH>,
				....

sun20i-d1.dtsi:
	soc {
		#interrupt-cells = <1>;
		interrupt-map = <0  18 &plic  18 IRQ_TYPE_LEVEL_HIGH>,
				<0  19 &plic  19 IRQ_TYPE_LEVEL_HIGH>,

then, in the shared .dtsi:
		uart0: serial@2500000 {
			compatible = "snps,dw-apb-uart";
			...
			interrupts = <18>;

This is completely untested, but I have all the files spelt out there, and
dtc seems happy for both architectures (outside of the kernel tree for now).

> I get the desire to deduplicate things, but we already deal with updating the
> same/similar nodes across several SoCs, so that is nothing new. I think it would
> be more confusing/complicated to have all of the interrupts properties
> overridden in a separate file.

So is this the only thing that prevents sharing? The above paragraph
sounds a bit you are not very fond of the idea to begin with?

Cheers,
Andre
