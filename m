Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 786EE5931EF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 17:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233056AbiHOPdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 11:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233041AbiHOPdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 11:33:15 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A91167D3;
        Mon, 15 Aug 2022 08:32:49 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1oNc53-0004Yz-7t; Mon, 15 Aug 2022 17:32:41 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev, Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH v3 1/4] regulator: dt-bindings: Add Allwinner D1 LDOs
Date:   Mon, 15 Aug 2022 17:32:40 +0200
Message-ID: <4371868.Wku2Vz74k6@diego>
In-Reply-To: <20220815043436.20170-2-samuel@sholland.org>
References: <20220815043436.20170-1-samuel@sholland.org> <20220815043436.20170-2-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 15. August 2022, 06:34:32 CEST schrieb Samuel Holland:
> The Allwinner D1 SoC contains two pairs of in-package LDOs. One pair is
> for general purpose use. LDOA generally powers the board's 1.8 V rail.
> LDOB generally powers the in-package DRAM, where applicable.
> 
> The other pair of LDOs powers the analog power domains inside the SoC,
> including the audio codec, thermal sensor, and ADCs. These LDOs require
> a 0.9 V bandgap voltage reference. The calibration value for the voltage
> reference is stored in an eFuse, accessed via an NVMEM cell.
> 
> Neither LDO control register is in its own MMIO range; instead, each
> regulator device relies on a regmap/syscon exported by its parent.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
> 
> Changes in v3:
>  - Add "reg" property to bindings
>  - Add "unevaluatedProperties: true" to regulator nodes
>  - Minor changes to regulator node name patterns
>  - Remove system-ldos example (now added in patch 3)
> 
> Changes in v2:
>  - Remove syscon property from bindings
>  - Update binding examples to fix warnings and provide context
> 
>  .../allwinner,sun20i-d1-analog-ldos.yaml      | 74 +++++++++++++++++++
>  .../allwinner,sun20i-d1-system-ldos.yaml      | 37 ++++++++++
>  2 files changed, 111 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/allwinner,sun20i-d1-analog-ldos.yaml
>  create mode 100644 Documentation/devicetree/bindings/regulator/allwinner,sun20i-d1-system-ldos.yaml
> 
> diff --git a/Documentation/devicetree/bindings/regulator/allwinner,sun20i-d1-analog-ldos.yaml b/Documentation/devicetree/bindings/regulator/allwinner,sun20i-d1-analog-ldos.yaml
> new file mode 100644
> index 000000000000..d6964b44ef21
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/allwinner,sun20i-d1-analog-ldos.yaml
> @@ -0,0 +1,74 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/regulator/allwinner,sun20i-d1-analog-ldos.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Allwinner D1 Analog LDOs
> +
> +description:
> +  Allwinner D1 contains a set of LDOs which are designed to supply analog power
> +  inside and outside the SoC. They are controlled by a register within the audio
> +  codec MMIO space, but which is not part of the audio codec clock/reset domain.
> +
> +maintainers:
> +  - Samuel Holland <samuel@sholland.org>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - allwinner,sun20i-d1-analog-ldos
> +
> +  reg:
> +    maxItems: 1
> +
> +  nvmem-cells:
> +    items:
> +      - description: NVMEM cell for the calibrated bandgap reference trim value
> +
> +  nvmem-cell-names:
> +    items:
> +      - const: bg_trim

aren't dashes "-" preferred over underscores "_" in
string names?

Maybe even make this "bandgap-trim" for a bit more
explanatory naming?


Heiko


