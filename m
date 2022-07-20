Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB93A57B78C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 15:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233238AbiGTNbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 09:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232126AbiGTNbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 09:31:45 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D799E60C6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 06:31:43 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id a5so26119650wrx.12
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 06:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=jXWsCDJZbVRxP7xR4C+U6rZt5JnCuCWDrPBReQRj/tw=;
        b=fnqIuK/upZAzWSdv8c4Xn98IfAXMtNBC8vAlR5vrMj/2du3XqOPwte1qjMrWLuHE0i
         LIep0Sv1eq7e349LCymGOYm4TUYeyyoDRHZRsmdkOAZeb9iaBgagQLzmDiHToHZAfxRM
         ihx0hQHCepa1CFN2KrYqjfkjfgJACbdUXcIN+5R0y+Lj61RFQK78ZqtbhybUgIgpuG2J
         q+P6QZS4cDKhCHBcdADaCSc47eHksNAsFQlFoJw1+5UU4S7r0y39wr3Pb3wbazLMlntE
         5V5mPFz7By2zGpfa7PTaOGWO23THWYxm8j3qEuzs9U0r//i84t+1A7L6lM7C0McnNL2C
         BdCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=jXWsCDJZbVRxP7xR4C+U6rZt5JnCuCWDrPBReQRj/tw=;
        b=Fv8x8ECMHPlW1qP/B42rv7zf1l9jK1OFtSqWk0GrNxbOST84dKWDhCBSgWUXsuhBC5
         eDFMY/11UZKgX9GPsrHGKYBvMfc1Nmd/aW1zHEqzmOZrBnnsUw518B38J+ry6ffu4qJW
         cWI3SdCmgPWdcXUvFF7h/fepKtDLnHLNa+02UNdBLMI0BBmlyvT3rTaKaJrZ4mDHzh9u
         mLt74hiY+I8svfZWuJ6MREbun2zMOcLZjhX5pvu2hVycMa2Gnuxls63eOn4V30x5c+Cn
         R3zmoNHKM9rEQd6kDKMjIhzlovN9D5ucNzBi4Nttu6BMyWcOnAncI9EJ/S9Iut5cduzF
         g/vA==
X-Gm-Message-State: AJIora/A/DqXppStWzVfZb3y3eHQbu149BR5IETH7JRmMWjZk4GknBY3
        RDor3HJOv5GGBB5bAihfnm1goA==
X-Google-Smtp-Source: AGRyM1tyvKXKdPUtTzvOARCZKmziYzkJtcJwILxnHRLAiFVCrIOmOWmx0ChdTjh6M2BY6gcYj8q5AA==
X-Received: by 2002:a5d:4447:0:b0:21d:6b84:4678 with SMTP id x7-20020a5d4447000000b0021d6b844678mr28881929wrr.668.1658323902346;
        Wed, 20 Jul 2022 06:31:42 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id k20-20020a05600c1c9400b003a31fd05e0fsm9520548wms.2.2022.07.20.06.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 06:31:41 -0700 (PDT)
Date:   Wed, 20 Jul 2022 14:31:39 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Tinghan Shen <tinghan.shen@mediatek.com>
Cc:     Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        MandyJH Liu <mandyjh.liu@mediatek.com>, iommu@lists.linux.dev,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v3 06/21] dt-bindings: power: mediatek: Add bindings for
 MediaTek SCPSYS
Message-ID: <YtgDu70Lpl/uPOkf@google.com>
References: <20220720123023.13500-1-tinghan.shen@mediatek.com>
 <20220720123023.13500-7-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220720123023.13500-7-tinghan.shen@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jul 2022, Tinghan Shen wrote:

> The System Control Processor System (SCPSYS) has several power
> management related tasks in the system. Add the bindings for it.
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>

Why have you ignored my review comments from v2?

> ---
>  .../bindings/mfd/mediatek,mt8195-scpsys.yaml  | 68 +++++++++++++++++++
>  1 file changed, 68 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/mediatek,mt8195-scpsys.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/mediatek,mt8195-scpsys.yaml b/Documentation/devicetree/bindings/mfd/mediatek,mt8195-scpsys.yaml
> new file mode 100644
> index 000000000000..4117a6dbc19c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/mediatek,mt8195-scpsys.yaml
> @@ -0,0 +1,68 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/mediatek,mt8195-scpsys.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek System Control Processor System
> +
> +maintainers:
> +  - MandyJH Liu <mandyjh.liu@mediatek.com>
> +
> +description:
> +  MediaTek System Control Processor System (SCPSYS) has several
> +  power management tasks. The tasks include MTCMOS power
> +  domain control, thermal measurement, DVFS, etc.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - mediatek,mt8167-scpsys
> +          - mediatek,mt8173-scpsys
> +          - mediatek,mt8183-scpsys
> +          - mediatek,mt8192-scpsys
> +          - mediatek,mt8195-scpsys
> +      - const: syscon
> +      - const: simple-mfd
> +
> +  reg:
> +    maxItems: 1
> +
> +patternProperties:
> +  "^power-controller(@[0-9a-f]+)?$":
> +    $ref: /schemas/power/mediatek,power-controller.yaml#
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/mt8195-clk.h>
> +    #include <dt-bindings/power/mt8195-power.h>
> +
> +    syscon@10006000 {
> +        compatible = "mediatek,mt8195-scpsys", "syscon", "simple-mfd";
> +        reg = <0x10006000 0x100>;
> +
> +        spm: power-controller {
> +            compatible = "mediatek,mt8195-power-controller";
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +            #power-domain-cells = <1>;
> +
> +            /* sample of power domain nodes */
> +            power-domain@MT8195_POWER_DOMAIN_PCIE_PHY {
> +                    reg = <MT8195_POWER_DOMAIN_PCIE_PHY>;
> +                    #power-domain-cells = <0>;
> +            };
> +
> +            power-domain@MT8195_POWER_DOMAIN_SSUSB_PCIE_PHY {
> +                    reg = <MT8195_POWER_DOMAIN_SSUSB_PCIE_PHY>;
> +                    #power-domain-cells = <0>;
> +            };
> +        };
> +    };

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
