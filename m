Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F331751925B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 01:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244276AbiECXlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 19:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234374AbiECXld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 19:41:33 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 789ED403FA;
        Tue,  3 May 2022 16:37:58 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nm25a-0004bi-Jq; Wed, 04 May 2022 01:37:54 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     krzk+dt@kernel.org, palmer@dabbelt.com, robh+dt@kernel.org,
        linux-riscv@lists.infradead.org
Cc:     conor.dooley@microchip.com, Cyril.Jean@microchip.com,
        daire.mcnamara@microchip.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, palmer@rivosinc.com, arnd@arndb.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Rob Herring <robh@kernel.org>,
        Conor Dooley <mail@conchuod.ie>
Subject: Re: [PATCH v3 2/8] riscv: dts: microchip: move sysctrlr out of soc bus
Date:   Wed, 04 May 2022 01:37:53 +0200
Message-ID: <3166309.aeNJFYEL58@phil>
In-Reply-To: <20220501192557.2631936-3-mail@conchuod.ie>
References: <20220501192557.2631936-1-mail@conchuod.ie> <20220501192557.2631936-3-mail@conchuod.ie>
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

Am Sonntag, 1. Mai 2022, 21:25:53 CEST schrieb Conor Dooley:
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

What function does the "soc-bus" have at all?
I.e. mailbox@37020000 also looks like a peripheral
of the chip but is outside it.

And I remember getting the suggestion to not use soc-"busses"
over in arm-land years ago [0].

[0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c3030d30d9c99c057b5ddfa289cffa637a2775f5

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




