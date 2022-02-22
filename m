Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 908B54C0519
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 00:11:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235010AbiBVXLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 18:11:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbiBVXLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 18:11:44 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F4E8BF20;
        Tue, 22 Feb 2022 15:11:16 -0800 (PST)
Received: from [185.156.123.69] (helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nMeJN-0006se-UC; Wed, 23 Feb 2022 00:11:13 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Michael Riesch <michael.riesch@wolfvision.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Liang Chen <cl@rock-chips.com>, frank-w@public-files.de
Subject: Re: [PATCH 2/2] arm64: dts: rockchip: enable rk809 audio codec on the rk3568 evb1
Date:   Wed, 23 Feb 2022 00:11:12 +0100
Message-ID: <3287619.yDqD7nnjd0@phil>
In-Reply-To: <20220222175004.1308990-2-michael.riesch@wolfvision.net>
References: <20220222175004.1308990-1-michael.riesch@wolfvision.net> <20220222175004.1308990-2-michael.riesch@wolfvision.net>
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

Hi,

Am Dienstag, 22. Februar 2022, 18:50:04 CET schrieb Michael Riesch:
> Enable the Rockchip RK809 audio codec on the Rockchip RK3568
> EVB1. This requires the VCCIO_ACODEC voltage regulator to be set
> to always on.
> 
> Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>

[...]

> @@ -282,6 +301,7 @@ regulator-state-mem {
>  
>  			vccio_acodec: LDO_REG4 {
>  				regulator-name = "vccio_acodec";
> +				regulator-always-on;

As this seems to supply the codec (in the rk809?) shouldn't the
sound part model that relationship and handle regulators
instead of requiring an arbitary regulator to be always on?


Heiko

>  				regulator-min-microvolt = <3300000>;
>  				regulator-max-microvolt = <3300000>;
>  
> @@ -366,6 +386,10 @@ regulator-state-mem {
>  				};
>  			};
>  		};
> +
> +		codec {
> +			mic-in-differential;
> +		};
>  	};
>  };
>  
> @@ -386,6 +410,11 @@ touchscreen0: goodix@14 {
>  	};
>  };
>  
> +&i2s1_8ch {
> +	rockchip,trcm-sync-tx-only;
> +	status = "okay";
> +};
> +
>  &mdio0 {
>  	rgmii_phy0: ethernet-phy@0 {
>  		compatible = "ethernet-phy-ieee802.3-c22";
> 




