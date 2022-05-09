Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF38751FAD2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 13:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231853AbiEILI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 07:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231977AbiEILIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 07:08:31 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39EA23E2B2;
        Mon,  9 May 2022 04:04:24 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1no1Bc-0005dn-5v; Mon, 09 May 2022 13:04:20 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     krzk+dt@kernel.org, palmer@dabbelt.com, robh+dt@kernel.org,
        Conor Dooley <mail@conchuod.ie>
Cc:     conor.dooley@microchip.com, Cyril.Jean@microchip.com,
        daire.mcnamara@microchip.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, palmer@rivosinc.com, arnd@arndb.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 2/8] riscv: dts: microchip: move sysctrlr out of soc bus
Date:   Mon, 09 May 2022 13:04:19 +0200
Message-ID: <2826000.e9J7NaK4W3@diego>
In-Reply-To: <20220504203051.1210355-3-mail@conchuod.ie>
References: <20220504203051.1210355-1-mail@conchuod.ie> <20220504203051.1210355-3-mail@conchuod.ie>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 4. Mai 2022, 22:30:46 CEST schrieb Conor Dooley:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> The MPFS system controller has no registers of its own, so move it out
> of the soc node to avoid dtbs_check warnings:
> arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dtb: soc: syscontroller: {'compatible': ['microchip,mpfs-sys-controller'], 'mboxes': [[15, 0]], 'status': ['okay']} should not be valid under {'type': 'object'}
> 
> Reported-by: Palmer Dabbelt <palmer@rivosinc.com>
> Suggested-by: Rob Herring <robh@kernel.org>
> Fixes: 528a5b1f2556 ("riscv: dts: microchip: add new peripherals to icicle kit device tree")
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

> ---
>  arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi b/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
> index 746c4d4e7686..bf21a2edd180 100644
> --- a/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
> +++ b/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
> @@ -146,6 +146,11 @@ refclk: mssrefclk {
>  		#clock-cells = <0>;
>  	};
>  
> +	syscontroller: syscontroller {
> +		compatible = "microchip,mpfs-sys-controller";
> +		mboxes = <&mbox 0>;
> +	};
> +
>  	soc {
>  		#address-cells = <2>;
>  		#size-cells = <2>;
> @@ -446,10 +451,5 @@ mbox: mailbox@37020000 {
>  			#mbox-cells = <1>;
>  			status = "disabled";
>  		};
> -
> -		syscontroller: syscontroller {
> -			compatible = "microchip,mpfs-sys-controller";
> -			mboxes = <&mbox 0>;
> -		};
>  	};
>  };
> 




