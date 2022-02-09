Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A05494AF224
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 13:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233699AbiBIMwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 07:52:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbiBIMwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 07:52:49 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920D5C0613CA;
        Wed,  9 Feb 2022 04:52:51 -0800 (PST)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nHmSj-0001ci-RZ; Wed, 09 Feb 2022 13:52:45 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        krzysztof.kozlowski@canonical.com, robh+dt@kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: Re: [PATCH] dt-bindings: crypto: convert rockchip-crypto to yaml
Date:   Wed, 09 Feb 2022 13:52:45 +0100
Message-ID: <2571349.qrhAyUUNuM@diego>
In-Reply-To: <20220209124725.2080986-1-clabbe@baylibre.com>
References: <20220209124725.2080986-1-clabbe@baylibre.com>
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

Am Mittwoch, 9. Februar 2022, 13:47:25 CET schrieb Corentin Labbe:
> Convert rockchip-crypto to yaml.
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  .../bindings/crypto/rockchip-crypto.txt       | 28 --------
>  .../bindings/crypto/rockchip-crypto.yaml      | 64 +++++++++++++++++++
>  2 files changed, 64 insertions(+), 28 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/crypto/rockchip-crypto.txt
>  create mode 100644 Documentation/devicetree/bindings/crypto/rockchip-crypto.yaml
> 
> diff --git a/Documentation/devicetree/bindings/crypto/rockchip-crypto.txt b/Documentation/devicetree/bindings/crypto/rockchip-crypto.txt
> deleted file mode 100644
> index 5e2ba385b8c9..000000000000
> --- a/Documentation/devicetree/bindings/crypto/rockchip-crypto.txt
> +++ /dev/null
> @@ -1,28 +0,0 @@
> -Rockchip Electronics And Security Accelerator
> -
> -Required properties:
> -- compatible: Should be "rockchip,rk3288-crypto"
> -- reg: Base physical address of the engine and length of memory mapped
> -       region
> -- interrupts: Interrupt number
> -- clocks: Reference to the clocks about crypto
> -- clock-names: "aclk" used to clock data
> -	       "hclk" used to clock data
> -	       "sclk" used to clock crypto accelerator
> -	       "apb_pclk" used to clock dma
> -- resets: Must contain an entry for each entry in reset-names.
> -	  See ../reset/reset.txt for details.
> -- reset-names: Must include the name "crypto-rst".
> -
> -Examples:
> -
> -	crypto: cypto-controller@ff8a0000 {
> -		compatible = "rockchip,rk3288-crypto";
> -		reg = <0xff8a0000 0x4000>;
> -		interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
> -		clocks = <&cru ACLK_CRYPTO>, <&cru HCLK_CRYPTO>,
> -			 <&cru SCLK_CRYPTO>, <&cru ACLK_DMAC1>;
> -		clock-names = "aclk", "hclk", "sclk", "apb_pclk";
> -		resets = <&cru SRST_CRYPTO>;
> -		reset-names = "crypto-rst";
> -	};
> diff --git a/Documentation/devicetree/bindings/crypto/rockchip-crypto.yaml b/Documentation/devicetree/bindings/crypto/rockchip-crypto.yaml
> new file mode 100644
> index 000000000000..392d89055398
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/crypto/rockchip-crypto.yaml
> @@ -0,0 +1,64 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/crypto/rockchip-crypto.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Rockchip Electronics And Security Accelerator
> +
> +maintainers:
> +  - Heiko Stuebner <heiko@sntech.de>
> +
> +properties:
> +  compatible:
> +    const: rockchip,rk3288-crypto
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: clock data
> +      - description: clock data
> +      - description: clock crypto accelerator
> +      - description: clock dma
> +
> +  clock-names:
> +    items:
> +      - const: aclk
> +      - const: hclk
> +      - const: sclk
> +      - const: apb_pclk
> +
> +  resets:
> +    minItems: 1
> +
> +  reset-names:
> +    const: crypto-rst
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - resets
> +  - reset-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |

Binding itself looks good.

But the constants below will probably trigger a compiler-error and
therefore Rob's bot.

You will need something like 

    #include <dt-bindings/clock/rk3399-cru.h>
    #include <dt-bindings/interrupt-controller/arm-gic.h>

here.

A "make ..... dt_binding_check" should show the issue and also
it going away with the right includes ;-)

Heiko


> +    crypto: crypto@ff8a0000 {
> +      compatible = "rockchip,rk3288-crypto";
> +      reg = <0xff8a0000 0x4000>;
> +      interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
> +      clocks = <&cru ACLK_CRYPTO>, <&cru HCLK_CRYPTO>,
> +               <&cru SCLK_CRYPTO>, <&cru ACLK_DMAC1>;
> +      clock-names = "aclk", "hclk", "sclk", "apb_pclk";
> +      resets = <&cru SRST_CRYPTO>;
> +      reset-names = "crypto-rst";
> +    };
> 




