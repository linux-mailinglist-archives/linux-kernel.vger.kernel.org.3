Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECEA64C2EEB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 16:05:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235788AbiBXPEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 10:04:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235128AbiBXPEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 10:04:45 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AAA01B718B;
        Thu, 24 Feb 2022 07:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1645715055; x=1677251055;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3X7MY7QMAfPwMnYY3v6PoXzfOyubJ8aa/cqA6j/5URs=;
  b=AZ7EVTglym31nBugi8Yjm9q6KqfDCIDUou5HwQFfgzfBN5nbC/cgSWnr
   HkgDzHOJBDOkFb5SHFDo7tt8SKZpKf/3RQxUlXuq2yBpKvFoxE4ATn+Rz
   yMaDuqQHhwTQrJ01J4NtCOn6djzeo7mt9yOCQmmY1/MTSx0dMu81T6oqw
   Sw+VQeluYDuqctAF21A2KfapHpOaPBc3a3aL2ImpVaIxbnB7Ty+MqCcKf
   hsk3p5r0a7cpWlfP0/5EdLwHYfuzsIwfX2U4TTrPVYUwhdFp1d1QuzpUP
   cqjKm15Lr5/XyKFKedtsNrKVh0hjYXmmQWpUGrNW7x18cL4LAU41hPJzT
   A==;
X-IronPort-AV: E=Sophos;i="5.90,134,1643698800"; 
   d="scan'208";a="163505030"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Feb 2022 08:04:14 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 24 Feb 2022 08:04:14 -0700
Received: from [10.12.73.51] (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Thu, 24 Feb 2022 08:04:12 -0700
Message-ID: <2fa34fae-7736-670a-1d31-7928fbcf95bd@microchip.com>
Date:   Thu, 24 Feb 2022 16:04:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] ARM: dts: at91: sama7g5: Add NAND support
Content-Language: en-US
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
CC:     <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        <robh+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220111130556.905978-1-tudor.ambarus@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20220111130556.905978-1-tudor.ambarus@microchip.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/01/2022 at 14:05, Tudor Ambarus wrote:
> Add NAND support. The sama7g5's SMC IP is the same as sama5d2's with
> a slightly change: it provides a synchronous clock output (SMC clock)
> that is dedicated to FPGA usage. Since this doesn't interfere with the SMC
> NAND configuration, thus code will not be added in the current nand driver
> to address the FPGA usage, use the sama5d2's compatible and choose not to
> introduce dedicated compatibles for sama7g5.
> Tested with Micron MT29F4G08ABAEAWP NAND flash.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

> ---
> The patch depends on the following patch:
> https://lore.kernel.org/linux-clk/20220111125310.902856-1-tudor.ambarus@microchip.com/T/#u

Patch seems taken, so I add this one to at91-dt branch for 5.18 merge 
window.

Best regards,
   Nicolas

> 
>   arch/arm/boot/dts/sama7g5.dtsi | 55 ++++++++++++++++++++++++++++++++++
>   1 file changed, 55 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sama7g5.dtsi b/arch/arm/boot/dts/sama7g5.dtsi
> index eddcfbf4d223..7972cb8c2562 100644
> --- a/arch/arm/boot/dts/sama7g5.dtsi
> +++ b/arch/arm/boot/dts/sama7g5.dtsi
> @@ -75,6 +75,45 @@ soc {
>   		#size-cells = <1>;
>   		ranges;
>   
> +		nfc_sram: sram@600000 {
> +			compatible = "mmio-sram";
> +			no-memory-wc;
> +			reg = <0x00600000 0x2400>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges = <0 0x00600000 0x2400>;
> +		};
> +
> +		nfc_io: nfc-io@10000000 {
> +			compatible = "atmel,sama5d3-nfc-io", "syscon";
> +			reg = <0x10000000 0x8000000>;
> +		};
> +
> +		ebi: ebi@40000000 {
> +			compatible = "atmel,sama5d3-ebi";
> +			#address-cells = <2>;
> +			#size-cells = <1>;
> +			atmel,smc = <&hsmc>;
> +			reg = <0x40000000 0x20000000>;
> +			ranges = <0x0 0x0 0x40000000 0x8000000
> +				  0x1 0x0 0x48000000 0x8000000
> +				  0x2 0x0 0x50000000 0x8000000
> +				  0x3 0x0 0x58000000 0x8000000>;
> +			clocks = <&pmc PMC_TYPE_CORE PMC_MCK1>;
> +			status = "disabled";
> +
> +			nand_controller: nand-controller {
> +				compatible = "atmel,sama5d3-nand-controller";
> +				atmel,nfc-sram = <&nfc_sram>;
> +				atmel,nfc-io = <&nfc_io>;
> +				ecc-engine = <&pmecc>;
> +				#address-cells = <2>;
> +				#size-cells = <1>;
> +				ranges;
> +				status = "disabled";
> +			};
> +		};
> +
>   		securam: securam@e0000000 {
>   			compatible = "microchip,sama7g5-securam", "atmel,sama5d2-securam", "mmio-sram";
>   			reg = <0xe0000000 0x4000>;
> @@ -181,6 +220,22 @@ tcb1: timer@e0800000 {
>   			clock-names = "t0_clk", "t1_clk", "t2_clk", "slow_clk";
>   		};
>   
> +		hsmc: hsmc@e0808000 {
> +			compatible = "atmel,sama5d2-smc", "syscon", "simple-mfd";
> +			reg = <0xe0808000 0x1000>;
> +			interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&pmc PMC_TYPE_PERIPHERAL 21>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +
> +			pmecc: ecc-engine@e0808070 {
> +				compatible = "atmel,sama5d2-pmecc";
> +				reg = <0xe0808070 0x490>,
> +				      <0xe0808500 0x200>;
> +			};
> +		};
> +
>   		qspi0: spi@e080c000 {
>   			compatible = "microchip,sama7g5-ospi";
>   			reg = <0xe080c000 0x400>, <0x20000000 0x10000000>;


-- 
Nicolas Ferre
